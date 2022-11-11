# Github Actions Lint Workflow

Current repo has three linting workflows in the `.github/workflows` directory. Each workflow uses specific Megalinter flavor to lint specific folders when new code gets pushed. All configuration files are located under `config/megalinter` directory

- pr_dotnet - uses `oxsecurity/megalinter/flavors/dotnet@v6.12.0` to lint dotnet code in the `framework/` and `samples/` directories
- pr_python - uses `oxsecurity/megalinter/flavors/python@v6.12.0` to lint python code in the `framework/` and `samples/` directories
- pr_docs - uses `oxsecurity/megalinter/flavors/documentation@v6.12.0` to lint md file in the `docs/` and `root` directories

See for more details [Megalinter flavors](#additional-useful-links)

## Run Github Action Workflow Locally

Rather than having to commit/push every time you want to test out the changes you are making to your `.github/workflows/` files, you can test it locally using `act` to run the actions locally.

### Prerequisites

- Docker see [Install Docker](https://docs.docker.com/get-docker/)
- `act` to run Github Actions [Install Act](https://github.com/nektos/act)

### Additional useful links

- Understanding GitHub Actions [GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions)
- Github Actions Workflow Syntax [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- Full list of [Megalinter flavors](https://oxsecurity.github.io/megalinter/latest/flavors/)
- Megalinter Configuration Variables [Configuration Variables](https://github.com/marketplace/actions/megalinter#common-variables)
- Useful `act` CLI commands [act CLI commands](https://github.com/nektos/act#example-commands)

### Example

This is an example of running `.github/workflows/pr_dotnet.yml` file to lint dotnet specific folders locally using `act` command

Run the workflow locally using `act` command

```sh
act pull_request --workflows .\.github\workflows\pr_docs.yaml
```

```yaml
name: pr_dotnet

on:
  pull_request:
    paths:
      - "framework/dotnet/**"
      - "samples/dotnet/**"
      - "engine/**"
      - "protos/**"
      - ".github/workflows/pr_dotnet.yaml"
    branches:
      - main

env:
  DOTNET_VERSION: '6.0.x'

jobs:
  lint:
    name: lint-${{matrix.os}}
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ ubuntu-latest ]

    steps:
      - name: Checkout repository and submodules
        uses: actions/checkout@v3
        with:
          token: ${{ secrets.PAT || secrets.GITHUB_TOKEN }}
          fetch-depth: 0
          submodules: recursive

      - name: MegaLinter dotnet flavor
        uses: oxsecurity/megalinter/flavors/dotnet@v6.12.0
        env:
          IGNORE_GITIGNORED_FILES: true
          VALIDATE_ALL_CODEBASE: true
          PRINT_ALL_FILES: true
          DISABLE: SPELL,COPYPASTE,YAML
          DISABLE_LINTERS: REPOSITORY_CHECKOV,REPOSITORY_TRIVY
          FILTER_REGEX_INCLUDE: '(framework/dotnet|samples/dotnet|engine/)'
          FILTER_REGEX_EXCLUDE: '(examples/|/docs|\.devcontainer|\.editorconfig|\.gitmodules|\.sln|\.md|LICENSE|/framework/python|samples/python)'
          REPORT_OUTPUT_FOLDER: ${GITHUB_WORKSPACE}/megalinter-reports

      - name: Setup dotnet
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: ${{ env.DOTNET_VERSION }}

      - name: Install dependencies
        run: dotnet restore

      - name: Build
        run: dotnet build --configuration Release --no-restore
```
