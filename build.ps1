#! /usr/bin/pwsh

[CmdletBinding()]
param (
  [switch] $Load,
  [switch] $Clean,
  [switch] $Inline,
  [switch] $Import
)
function Copy-Content ($Content) {
  foreach ($c in $content) {
    $source, $destination = $c

    $null = New-Item -Force $destination -ItemType Directory

    Get-ChildItem $source -File | Copy-Item -Destination $destination
  }
}

$ErrorActionPreference = 'Stop'

if (-not $PSBoundParameters.ContainsKey("Inline")) {
  # Force inlining by env variable, build.ps1 is used in multiple places and passing the $inline everywhere is
  # difficult.
  # Only read this option here. Don't write it.
  $Inline = $env:BENCPRESS_BUILD_INLINE -eq "1"
} else {
  # We provided Inline explicitly, write the option. This assumes that you don't use -Inline:$false in any of the
  # test scripts, otherwise the test script would reset the option incorrectly.
  $env:BENCHPRESS_BUILD_INLINE = [string][int][bool] $Inline
}

Get-Module BenchPress | Remove-Module

if ($Clean -and (Test-Path "$PSScriptRoot/bin")) {
  Remove-Item "$PSScriptRoot/bin" -Recurse -Force
}

$null = New-Item "$PSScriptRoot/bin" -ItemType Directory -Force

$content = @(
  , ("$PSScriptRoot/Modules/BenchPress.Azure/BenchPress.Azure.psd1", "$PSScriptRoot/bin/")
)

Copy-Content -Content $content

$publicClasses = @(Get-ChildItem -Path $PSScriptRoot/Modules/BenchPress.Azure/Classes -Recurse -Filter "*.psm1")
$publicFunctions = @(Get-ChildItem -Path $PSScriptRoot/Modules/BenchPress.Azure/Public -Recurse -Filter "*.ps1")
$privateFunctions = @(Get-ChildItem -Path $PSScriptRoot/Modules/BenchPress.Azure/Private -Recurse -Filter "*.ps1")

$sb = [System.Text.StringBuilder]""

if ($Inline) {
  $allFiles = $publicClasses + $publicFunctions + $privateFunctions

  foreach ($file in $allFiles) {
    $lines = Get-Content $file
    $relativePath = ($file.FullName -replace ([regex]::Escape($PSScriptRoot))).TrimStart('\').TrimStart('/')

    $null = $sb.AppendLine("# file $($relativePath)")

    $skipLine = $false

    foreach ($line in $lines) {
      # when inlining the code skip everything wrapped in # INLINE_SKIP, # end INLINE_SKIP
      if ($line -match '^.*#\s*INLINE_SKIP') {
        $skipLine = $true
      }

      if (-not $skipLine) {
        $null = $sb.AppendLine($line)
      }

      if ($line -match '^.*#\s*end\s*INLINE_SKIP') {
        $skipLine = $false
      }
    }
  }
} else {
  # "using" for class files must be the first line in the module script
  foreach ($class in $publicClasses) {
    $null = $sb.AppendLine("using module $($class.FullName)")
  }

  # Define this at the top of the module, after the using statements, to skip the code that is wrapped in this if in
  # different source files.
  $null = $sb.AppendLine('$BENCHPRESS_BUILD=1')

  $functionFiles = $publicFunctions + $privateFunctions

  foreach ($file in $functionFiles) {
    $null = $sb.AppendLine(". '$($file.FullName)'")
  }
}

$null = $sb.AppendLine("Export-ModuleMember $($publicFunctions.BaseName -join ',')")

$sb.ToString() | Set-Content "$PSScriptRoot/bin/BenchPress.Azure.psm1" -Encoding UTF8

$powershell = Get-Process -Id $PID | Select-Object -ExpandProperty Path

if ($Load) {
    & $powershell -c "'Load: ' + (Measure-Command { Import-Module '$PSScriptRoot/bin/BenchPress.Azure.psd1' -ErrorAction Stop}).TotalMilliseconds + 'ms'"
    if (0 -ne $LASTEXITCODE) {
        throw "load failed!"
    }
}

if ($Import) {
  Import-Module "$PSScriptRoot/bin/BenchPress.Azure.psd1" -Force
}
