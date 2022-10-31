# [Choice] .NET version: 6.0, 5.0, 3.1, 6.0-bullseye, 5.0-bullseye, 3.1-bullseye, 6.0-focal, 5.0-focal, 3.1-focal
ARG VARIANT="6.0"
FROM mcr.microsoft.com/vscode/devcontainers/dotnet:${VARIANT}
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Install-Module -Name Pester -Force -SkipPublisherCheck
RUN Install-Module -Name Az -Force -SkipPublisherCheck
