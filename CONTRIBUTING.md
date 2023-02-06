# Contributing to BenchPress

Thank you for your interest in the BenchPress open-source project for testing Infrastructure as Code in Azure.

There are several ways to contribute to BenchPress including:
identifying and reporting issues,
contributing to the code and documentation.

Please review the [Code of Conduct](#code-of-conduct) and the [Contributor License Agreement](#contributor-license-agreement).

## Code of Conduct

Please review and adhere to the tenents of the [Code of Conduct](CODE_OF_CONDUCT.md) before contributing.

## Contributor License Agreement

To speed up the acceptance of any contribution to the BenchPress repository,
you should sign the Microsoft [Contributor License Agreement (CLA)](https://cla.microsoft.com/) ahead of time.
If you've already contributed to BenchPress or Microsoft repositories in the past, congratulations!
You've already completed this step.
This a one-time requirement for the BenchPress project.
Signing the CLA process is simple and can be done in less than a minute.
You don't have to do this up-front.
You can simply clone, fork, and submit your pull request as usual.
When your pull request is created, it is checked by the CLA bot.
If you have signed the CLA, the status check will be set to `passing`.  Otherwise, it will stay at `pending`.
Once you sign a CLA, all your existing and future pull requests will have the status check automatically set at `passing`.

## Local Environment Setup

There are two methods to getting a development environment up and running: local setup and using a dev container.

### Local Setup

Using a local setup either VS Code or Visual Studio can be used to develop code for the BenchPress project. VS Code is
the recommended IDE, but Visual Studio will work as well. For this guide we will cover VS Code prerequisites:

1. Install PowerShell Modules:
    - Azure PowerShell Module: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser &&`
      `Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force`
    - Pester: `Install-Module -Name Pester -Force -SkipPublisherCheck`.
1. Install [Visual Studio Code](https://code.visualstudio.com/Download).
1. Install [node.js](https://nodejs.org/en/download/) (required for running megalinter).
1. Install VS Code Extensions:
    - Azure CLI Tools
    - Bicep
    - C#
    - Docker
    - PowerShell
    - Prettier (used for local linting)

### Dev Container

The BenchPress repository contains a definition for a dev container. In order to use the dev container:

1. Install VS Code Extensions:
    - Dev Container
    - WSL
1. Ensure that Docker Desktop or other container hosting engine is installed and running.
1. Open the BenchPress repository folder.
1. From the command window (Ctrl + Shift + P) choose "Reopen in Container".

The BenchPress dev container is configured to provide the developer with all of the tools necessary to write and test
code for BenchPress.

#### Using WSL2 with a Dev Container

If your Docker Desktop or other container host is using WSL2, then there might be severe lag when using VSCode with
a dev container when the code is hosted on the Windows subsystem. In order to remediate this it is recommended to use
the WSL2 subsystem with the dev container.

1. Install the **Remote Development Extension Pack** Extension in VSCode.
1. If WSL2 is not installed, install WSL2. From a Windows Terminal execute `wsl --install` and then open a WSL terminal.
1. From a terminal in WSL2:
    1. Install the .NET SDK: `sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0`
    1. Install .NET Core: `sudo apt-get update && sudo apt-get install -y dotnet-runtime-7.0`
    1. Restart the WSL terminal.
    1. Create a directory for source code and `cd` into it.
    1. Clone or fork the repo as described below in
       [Contributing to Code and Documentation](#contributing-to-code-and-documentation)
    1. `cd` into the repo's directory
    1. Open VSCode from the command line with: `code .`
    1. From the command window (Ctrl + Shift + P) choose `Reopen in Container`

#### Running Megalinter in a Dev Container

Because megalinter executes in a container within the dev container the mapped paths are mapped to the container path,
but executed against the host path. This requires that the docker command that would normally be executed with
`mega-linter-runner` be adjusted for the host path:

- Specific folder (recursively):
  `docker run -v /var/run/docker.sock:/var/run/docker.sock:rw -v <host path to folder>:/tmp/lint:rw`
  `oxsecurity/megalinter-dotnet:v6`
- Specific file (or comma separated files):
  `docker run -v /var/run/docker.sock:/var/run/docker.sock:rw -v <host path to folder>:/tmp/lint:rw`
  `-e SKIP_CLI_LINT_MODES=project -e MEGALINTER_FILES_TO_LINT=<relative path to file(s) from folder>`
  `oxsecurity/megalinter-dotnet:v6`

## Reporting Issues

1. Check the [Issue Tracker](https://github.com/Azure/benchpress/issues) to determine whether the issue that you're
   going to file already exists.
    1. If your issue exists (all inputs and relevant information is identical to an existing issue):
       1. Make relevant comments to add context that helps broaden understanding or helps identify the root concern.
       1. Add a [reaction](https://github.com/blog/2119-add-reactions-to-pull-requests-issues-and-comments) to upvote
          (:+1:) or downvote (:-1:) an issue.
    1. If the issue does not exist create a new issue with the following guidelines:
       - Do not submit multiple problems or features in a single submitted issue.
       - Provide as much information as possible. The more information provided, the more likely that someone will
         be successful in reproducing the issue and identifying the cause. Provide as much of the following
         information as possible (not an exhaustive list):
           - Version of PowerShell being used.
           - The operating system and version being used.
           - Any container information, if used.
           - An ordered list of reproducible steps that cause the issue to manifest.
           - Expecations versus reality. What was expected to happen versus what actually happened.
           - Any images, gifs, animations, links, videos, etc. that demonstrate the issue.
           - A code snippet or link to a repository that contains code that reproduces the issue.

## Contributing to Code and Documentation

In order to setup a local environment to contribute to BenchPress review the
[Local Environment Setup](#local-environment-setup).

Once an issue has been created or identified to contribute to, the following steps can be followed to contribute to the
BenchPress code and documentation:

1. Clone or fork the repository. Clone if you have permissions, fork if you do not.
1. Ensure the latest code is available locally by executing `git fetch all`.
1. Create and checkout a feature branch using the number of the issue in a `feature\<issue #>` branch. For example:
   `git checkout -b feature\123`.
1. Make the changes necessary to address the issue.
1. Commit the final changes to the feature branch using `git commit`
1. Push change to the fork or clone.
1. Create a [Pull Request](https://github.com/Azure/benchpress/pulls) from the pushed branch if the repository was
   cloned or from the fork/branch if the repository was forked.
1. If necessary address any automated Pull Request checks by making fixes on the local feature branch and pushing the
   fixes when completed. Repeat this process until all PR checks have been resolved.

## Thank You

Thank you for your interest and contribution to the BenchPress open-source project.
