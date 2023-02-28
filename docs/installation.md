# Installing BenchPress

There are two general ways to install BenchPress:

- Install from the PowerShell Gallery
- Import from a local copy of the BenchPress GitHub repository

## Install From the PowerShell Gallery

In order to install from the PowerShell Gallery follow these steps from a PowerShell terminal:

1. Ensure that the latest version of
[PowerShellGet](https://learn.microsoft.com/en-us/powershell/scripting/gallery/installing-psget?view=powershell-7.3)
is installed.
1. Execute `Install-Module -Name Az.InfrastructureTest`
1. To make the module available to the current session execute `Import-Module -Name Az.InfrastructureTest`

## Install From a Local Copy of the Repository

### Copy the Repo to the Local File System

A local copy of the git repository must be present by either cloning from the source GitHub repository or forking the
source GitHub repository and cloning that repository locally.

To fork the repository you must have a GitHub account and follow these steps:

1. Navigate to the [BenchPress](https://github.com/Azure/benchpress) GitHub page.
1. Click the `Fork` button in the top right hand corner of the page.
1. Follow the instructions to fork the BenchPress repository into your own GitHub account.

To clone the repository:

1. From a terminal window navigate to the directory that the cloned repository will be cloned.
1. If cloning from the source repository execute: `git clone https://github.com/Azure/benchpress.git`. This will
   automatically create the `benchpress` folder and copy all files to the local file system.
1. If cloning from a forked repository:
    1. Navigate to the forked repository's `Code` page in GitHub.
    1. Click the `Code` button drop down and under the `HTTPS` tab copy the URL.
    1. In the terminal window execute `git clone <copied path>`. As above, this will copy all files to the local file
       system.

### Install the BenchPress Module from the Local File System

Once a local copy of the BenchPress repository exists, to install the BenchPress Module, from the project root path
execute `./build.ps1 -Import`. This will create a `.psm1` file in the `bin` directory that will dot source all cmdlets
in the `Public` and `Private` folders, `Export-ModuleMember` for all `Public` cmdlets, and sets the proper `using`
statements to import classes.

To clean the `bin` folder before outputting the artifacts from `build.ps1` the `-Clean` flag can be passed.

To test the load time the `-Load` flag can be passed.

To test the build as an inline `.psm1` file pass the `-InLine` flag. This will consolidate all files in the `Classes`
, `Public`, and `Private` folders into a single file instead of dot sourcing the files.
