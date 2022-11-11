# Getting started
This guide walks you through the process of starting development on *Benchpress*.

## Development environment setup within VS Code
If you’re using [Visual Studio Code](https://code.visualstudio.com/) as your IDE of choice, then this project contains all of the necessary configurations to bootstrap your development environment using a container known as a [Dev Container](https://code.visualstudio.com/docs/remote/containers).

To use the Dev Container, please follow the installation guide to install Docker and the VS Code extension: https://code.visualstudio.com/docs/remote/containers#_installation

Then launch the environment by opening the command palette <kbd>Shift</kbd>+<kbd>Command</kbd>+<kbd>P</kbd> (Mac) / <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> (Windows/Linux) and running `Dev Containers: Open Folder in Container`

The Dev Container configuration also contains VS Code extensions for linting, formatting, testing, and compilation.

### Authenticating git within the dev container
For MacOs, make sure your ssh key is properly added to your key-chain

1. Call `ssh-add -l` in your **host** terminal. If your key is not in your key-chain, it will say `The agent has no identities` or the identities listed will not include the key you use to authenticate with git.
2. To add your key to the key-chain, call `shh-add <the path to your private key>` (most likely, `ssh-add ~/.ssh/id_rsa`).
3. Call `ssh-add -l` on your **host** terminal again to verify the identity has been added.
4. Call `ssh-add -l` in your **dev container** terminal to verify that it is accessible in the container. Now you should be able to authenticate with git from within the dev container.

For Windows, try following [this stack overflow post](https://stackoverflow.com/questions/56490194/vs-code-bitbucket-ssh-permission-denied-publickey/72029153#72029153)

## Development dependencies if not using VS Code
Depending on the feature/language you are working on, you may need to download and install language-specific packages, e.g., Python 3.

List of requirements on development machine:

- Azure CLI
- DotNet Core (version 6.0)
- Node (>= version 14)
- PowerShell 8
- Python 3.5
- pip 9.0.1

### Python setup
Install the gRPC Tools:

```bash
python -m pip install grpcio-tools
```

From the root directory, execute to install benchpress as a module that can be referenced:

```bash
pip install --editable ./framework/python/
```

