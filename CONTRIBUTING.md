# Running MegaLinter

1. Install Latest stable/long term service Node Version Manager aka $ nvm
    a. Installation instructions: <https://github.com/nvm-sh/nvm#installing-and-updating>
2. Use NVM to install the latest long term service (LTS) version of node and node package manager (npm)
    a. `nvm install --lts`
3. Install Mega-Linter using the provided package.json file
    a. `npm install package.json`
4. Run Mega-Linter in the root of the project.  The Node package executor $ npx is an included utility with  npm
    a. `npx mega-linter-runner`
    b. Note: Do not provide the runner with a directory path or it may not activate all linters (e.g. `npx mega-linter-runner .`) (possible bug in upstream)

Expected Results:  Mega-Linter should run and report any issues it finds in the project.


+----SUMMARY------+--------------------------+---------------+-------+-------+--------+--------------+

| Descriptor      | Linter                   | Mode          | Files | Fixed | Errors | Elapsed time |

+-----------------+--------------------------+---------------+-------+-------+--------+--------------+

| ✅ ACTION       | actionlint               | list_of_files |     1 |       |      0 |        0.17s |

| ❌ ARM          | arm-ttk                  | file          |     3 |       |      3 |        24.3s |

| ✅ BICEP        | bicep_linter             | file          |     3 |       |      0 |       22.08s |

| ❌ COPYPASTE    | jscpd                    | project       |   n/a |       |      7 |        5.66s |

| ✅ CSHARP       | dotnet-format            | file          |    22 |     8 |      0 |      122.93s |

| ✅ DOCKERFILE   | hadolint                 | list_of_files |     1 |       |      0 |        0.23s |

| ❌ EDITORCONFIG | editorconfig-checker     | list_of_files |    67 |       |      1 |         0.6s |

| ✅ JSON         | eslint-plugin-jsonc      | list_of_files |     9 |     1 |      0 |        7.12s |

| ✅ JSON         | jsonlint                 | list_of_files |     9 |       |      0 |        0.48s |

| ✅ JSON         | prettier                 | list_of_files |     9 |     1 |      0 |         5.2s |

| ✅ JSON         | v8r                      | list_of_files |     9 |       |      0 |       14.13s |

| ◬ MARKDOWN      | markdownlint             | list_of_files |     5 |     5 |      2 |        1.98s |

| ❌ MARKDOWN     | markdown-link-check      | list_of_files |     5 |       |      2 |       32.89s |

| ✅ MARKDOWN     | markdown-table-formatter | list_of_files |     5 |     5 |      0 |        1.39s |

| ❌ POWERSHELL   | powershell               | file          |    11 |       |      9 |        25.6s |

| ✅ PYTHON       | bandit                   | list_of_files |     1 |       |      0 |        1.63s |

| ✅ PYTHON       | black                    | list_of_files |     1 |     0 |      0 |        1.44s |

| ✅ PYTHON       | flake8                   | list_of_files |     1 |       |      0 |        0.92s |

| ✅ PYTHON       | isort                    | list_of_files |     1 |     0 |      0 |         0.7s |

| ✅ PYTHON       | mypy                     | list_of_files |     1 |       |      0 |        8.56s |

| ✅ PYTHON       | pylint                   | list_of_files |     1 |       |      0 |        2.34s |

| ✅ PYTHON       | pyright                  | list_of_files |     1 |       |      0 |       21.49s |

| ❌ REPOSITORY   | checkov                  | project       |   n/a |       |      7 |        54.1s |

| ◬ REPOSITORY    | devskim                  | project       |   n/a |       |      1 |         1.5s |

| ✅ REPOSITORY   | dustilock                | project       |   n/a |       |      0 |        0.45s |

| ✅ REPOSITORY   | gitleaks                 | project       |   n/a |       |      0 |        1.44s |

| ❌ REPOSITORY   | git_diff                 | project       |   n/a |       |      1 |        0.21s |

| ✅ REPOSITORY   | secretlint               | project       |   n/a |       |      0 |        2.94s |

| ✅ REPOSITORY   | syft                     | project       |   n/a |       |      0 |        2.34s |

| ❌ REPOSITORY   | trivy                    | project       |   n/a |       |      1 |         7.0s |

| ❌ SPELL        | cspell                   | list_of_files |    67 |       |    281 |        6.59s |

| ✅ SPELL        | misspell                 | list_of_files |    67 |    15 |      0 |         1.8s |

| ✅ YAML         | prettier                 | list_of_files |     2 |     1 |      0 |        3.02s |

| ✅ YAML         | v8r                      | list_of_files |     2 |       |      0 |        9.04s |

| ✅ YAML         | yamllint                 | list_of_files |     2 |       |      0 |        0.47s |

+-----------------+--------------------------+---------------+-------+-------+--------+--------------+
