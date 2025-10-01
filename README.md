# robot_framework

A starter project for Robot Framework test automation.

## Overview

This repository provides a basic template for getting started with Robot Framework, a generic test automation framework for acceptance testing and acceptance test-driven development (ATDD).

## Project Structure

```
robot_framework/
├── tests/                    # Test suite files
│   ├── example_tests.robot  # Basic example tests
│   └── web_example.robot    # Web automation example
├── resources/                # Reusable resources
│   └── common_keywords.robot # Custom keywords and variables
├── requirements.txt          # Python dependencies
└── README.md                # This file
```

## Prerequisites

- Python 3.7 or higher
- pip (Python package installer)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/tinowski/robot_framework.git
   cd robot_framework
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Running Tests

### Run all tests:
```bash
robot tests/
```

### Run a specific test suite:
```bash
robot tests/example_tests.robot
```

### Run tests with specific tags:
```bash
robot --include basic tests/
robot --include example tests/
```

### Generate detailed reports:
```bash
robot --outputdir results tests/
```

## Test Reports

After running tests, Robot Framework generates three files:
- **output.xml** - Detailed test execution data in XML format
- **log.html** - Detailed execution log with test details
- **report.html** - High-level test execution summary

Open the HTML files in your browser to view the results.

## Creating New Tests

1. Create a new `.robot` file in the `tests/` directory
2. Add your test cases following the Robot Framework syntax:

```robot
*** Settings ***
Documentation     Your test suite description
Resource          ../resources/common_keywords.robot

*** Test Cases ***
Your Test Case Name
    [Documentation]    Test case description
    [Tags]    your-tag
    # Your test steps here
    Log    Hello, World!
```

## Adding Custom Keywords

Add reusable keywords to `resources/common_keywords.robot`:

```robot
*** Keywords ***
Your Custom Keyword
    [Documentation]    Keyword description
    [Arguments]    ${arg1}    ${arg2}
    # Your keyword implementation
    Log    ${arg1} and ${arg2}
```

## Web Testing

The project includes SeleniumLibrary for web automation. To use it:

1. Install a browser driver (ChromeDriver, GeckoDriver, etc.)
2. Add it to your system PATH
3. Create test cases using SeleniumLibrary keywords

See `tests/web_example.robot` for a basic example.

## Resources

- [Robot Framework Official Documentation](https://robotframework.org/)
- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [SeleniumLibrary Documentation](https://robotframework.org/SeleniumLibrary/)
- [Built-in Library Keywords](https://robotframework.org/robotframework/latest/libraries/BuiltIn.html)

## License

This project is open source and available under the MIT License.