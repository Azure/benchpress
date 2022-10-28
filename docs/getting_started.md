# Getting started
This guide walks you through the process of starting development on *Benchpress*.

## Setting up the development environment

If you’re using [Visual Studio Code](https://code.visualstudio.com/) as your IDE of choice, then this project contains all of the necessary configurations to bootstrap your development environment. See the section on [Development environment setup within VS Code
](#development-environment-setup-within-vs-code)

### Development environment setup within VS Code
Visual Studio Code supports compilation and development on a container known as [Dev Containers](https://code.visualstudio.com/docs/remote/containers).

If you’re using VS Code, please install see the installation guide to install Docker and VS Code extension: https://code.visualstudio.com/docs/remote/containers#_installation

Then launch the environment by opening the command pallete <kbd>Shift</kbd>+<kbd>Command</kbd>+<kbd>P</kbd> (Mac) / <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> (Windows/Linux) and running `Dev Containers: Open Folder in Container`

The Dev Container configuration also contains VS Code extensions for linting/formatting/testing/compilation.

### Development dependencies
Depending on the feature/language you are working on, you may need to download and install language-specific packages, e.g., Python 3.

List of requirements on development machine:

- Azure CLI
- DotNet Core (version 6.0)
- Node (>= version 14)
- PowerShell 8
- Python 3

#### Python setup
From the root directory, execute to install benchpress as a module that can be referenced:

> pip install --editable ./framework/python/


