# Generator

The Generator project can take a `.bicep` file and scaffold example Pester tests that use the BenchPress PowerShell
module. These generated tests are not meant to work out of the box and are just a starting point for your
infrastructure tests.The Generator project is still in the early stages of development, so expect many ongoing changes.

## Running Locally

If you are interested in contributing to or consuming the Generator project at this time, the following these steps
will help you get started:

### Prerequisites

- [.NET 7](https://dotnet.microsoft.com/en-us/download) installed

### Steps

1. Clone the repository.
1. Open your command prompt and initialize the `bicep` submodule:

   ```bash
    git submodule update --init --recursive
   ```

1. Navigate to the BenchPress solution:

   ```bash
    cd BenchPress
   ```

1. Build the solution:

   ```bash
    dotnet build
   ```

1. Run the Generator project using a `.bicep` file

   ```bash
   cd Generators
   dotnet run --provider powershell --import ../../examples.StreamAnalytics/streamAnalytics.bicep --output ./output/
   ```

   - The `provider` option specifies the language test file to generate. Currently, only PowerShell is supported.
   - The `import` option specifies the `.bicep` file to generate tests for. Feel free to use your own. This document
     uses an existing `.bicep` file that is located under the `examples` directory.
   - The `output` option specifies where to write the generated test files. Feel free to use a different path.

1. Success! The generated PowerShell test files will be located in the directory specified by the `output` option. Open
   these test files and look over the contents to see the tests that have been generated. You will notice that you will
   still need to edit some of the file contents (i.e. changing resource names) to make these tests work. Happy testing!
