# Robot Framework Test Automation Project

A clean, maintainable test automation framework with reusable components and smart screenshot handling.

## Project Structure

```
robot_framework/
├── Tests/               # Test suites
│   └── example_test.robot
├── Resources/           # Shared resources
│   ├── common.robot     # Common keywords and setup/teardown
│   ├── variables.robot  # Shared variables
│   └── screenshot_library.robot
├── Screenshots/         # Failure screenshots
├── Results/            # Test reports and logs
├── run_tests.sh        # Test execution script
└── requirements.txt    # Dependencies
```

## Quick Start

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Run tests:
```bash
./run_tests.sh
```

## Key Features

### 1. Reusable Setup and Teardown

Suite level setup/teardown:
```robotframework
*** Settings ***
Suite Setup      Suite Setup
Suite Teardown   Suite Teardown
```

Test level setup/teardown with configurable parameters:
```robotframework
*** Settings ***
Test Setup       Test Setup    browser=chrome    url=https://example.com
Test Teardown    Test Teardown    screenshot_name=${TEST NAME}
```

Available Setup Functions:
```robotframework
# Suite Level
Suite Setup
    - Creates Screenshots directory
    - Sets screenshot location

Suite Teardown
    - Closes all browsers
    - Cleans up resources

# Test Level
Test Setup
    [Arguments]    ${browser}=${BROWSER}    ${url}=${SEARCH_URL}    ${options}=${CHROME_OPTIONS}
    - Sets Selenium speed
    - Creates Screenshots directory
    - Opens browser with options
    - Handles cookie consent

Test Teardown
    [Arguments]    ${screenshot_name}=${TEST NAME}
    - Takes screenshot on failure
    - Closes all browsers
```

### 2. Smart Screenshot Handling

Automatic screenshot capture for failures:
```robotframework
*** Test Cases ***
Example Test
    [Documentation]    Screenshots automatically captured on failure
    [Tags]    example
    Run Keyword And Expect Error    *    Should Be True    False
```

Screenshot Features:
- Only captures on test failure
- Meaningful names with timestamp
- Stored in dedicated Screenshots directory
- Automatic cleanup of selenium screenshots
- Custom screenshot library for reliability

### 3. Cookie Consent Handling

Robust cookie handling with multiple strategies:
```robotframework
Handle Cookie Consent
    # Tries multiple approaches:
    - iframe detection and handling
    - Multiple button patterns
    - JavaScript fallback
    - Error recovery
```

### 4. Test Organization

Example test structure:
```robotframework
*** Settings ***
Documentation     Test suite description
Resource          ../Resources/common.robot
Resource          ../Resources/variables.robot

Suite Setup      Suite Setup
Suite Teardown   Suite Teardown
Test Setup       Test Setup
Test Teardown    Test Teardown

*** Test Cases ***
Example Test Case
    [Documentation]    Test case description
    [Tags]    category    type
    Search For    Robot Framework
    Page Should Contain    Expected Result
```

## Running Tests

### Basic Run
```bash
./run_tests.sh
```

### Run Specific Tests
```bash
# Run by tag
robot --include smoke Tests/

# Run single test file
robot Tests/example_test.robot

# Run with custom browser
robot -v BROWSER:firefox Tests/
```

## Test Results

After test execution:
- Test reports in Results/
- Failure screenshots in Screenshots/
- Screenshot naming: `Test_Name_Timestamp_FAILED.png`

## Best Practices

### 1. Test Structure
```robotframework
*** Test Cases ***
Test Name
    [Documentation]    Clear description
    [Tags]    category    type
    [Setup]    Test Setup    url=https://example.com
    Test Steps
    Verification Steps
```

### 2. Error Handling
```robotframework
Run Keyword And Ignore Error    Handle Cookie Consent
Run Keyword If Test Failed    Take Screenshot    ${TEST NAME}
```

### 3. Resource Organization
- Common keywords in common.robot
- Variables in variables.robot
- Screenshot handling in screenshot_library.robot

### 4. Screenshot Management
- Automatic cleanup of selenium screenshots
- Meaningful screenshot names
- Organized in Screenshots directory
- Only captured for failures

## Configuration

### Browser Options
```robotframework
${CHROME_OPTIONS}    options=add_argument("--start-maximized"); add_argument("--disable-notifications")
```

### Test Timeouts
```robotframework
*** Settings ***
Test Timeout    1 minute
```

### Screenshot Directory
```robotframework
${SCREENSHOTS_DIR}    ${CURDIR}/../Screenshots
```

## Troubleshooting

### Common Issues

1. **Screenshot Not Captured**
   - Check Screenshots directory permissions
   - Verify browser is still open
   - Check error messages in log

2. **Cookie Consent Issues**
   - Multiple retry strategies implemented
   - Check for iframe presence
   - JavaScript fallback available

3. **Browser Issues**
   - Chrome options configurable
   - Automatic cleanup on failure
   - Error recovery in place

## Dependencies

Current versions:
```
robotframework>=6.1.1
robotframework-seleniumlibrary>=6.1.3
robotframework-requests>=0.9.5
selenium>=4.15.2
webdriver-manager>=4.0.1
```

## Contributing

1. Follow existing patterns
2. Use reusable setup/teardown
3. Implement proper error handling
4. Add appropriate documentation
5. Test thoroughly

## Version Control

The following are ignored in git:
```gitignore
# Test outputs
Results/
Screenshots/
*.html
*.xml
*.png
```