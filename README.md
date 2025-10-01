# Robot Framework Test Automation Project

A clean, maintainable test automation framework that's easy to understand and extend.

## Project Structure

```
robot_framework/
├── Tests/               # Your test files
│   └── example_test.robot
├── Resources/           # Shared test resources
│   ├── common.robot     # Common keywords
│   ├── variables.robot  # Shared variables
│   └── screenshot_library.robot
├── Screenshots/         # Test failure screenshots
├── Results/            # Test reports and logs
├── run_tests.sh        # Test runner script
└── requirements.txt    # Python dependencies
```

## Quick Start

1. Install Python dependencies:
```bash
pip install -r requirements.txt
```

2. Run the tests:
```bash
./run_tests.sh
```

## Writing Tests

### Basic Test Structure
Here's a simple test case example:

```robotframework
*** Settings ***
Documentation     Example test suite
Resource          ../Resources/common.robot
Resource          ../Resources/variables.robot

*** Test Cases ***
Search For Something
    [Documentation]    Performs a search and verifies results
    [Tags]    smoke    search
    Open Browser To Search
    Search For    Robot Framework
    Page Should Contain    Robot Framework
    [Teardown]    Close Browser
```

### Using Variables
Define your variables in `variables.robot`:

```robotframework
*** Variables ***
${BROWSER}         chrome
${SEARCH_URL}      https://duckduckgo.com
${SEARCH_INPUT}    id=searchbox_input
```

Use them in your tests:
```robotframework
Open Browser    ${SEARCH_URL}    ${BROWSER}
Input Text      ${SEARCH_INPUT}    search term
```

### Creating Keywords
Add reusable keywords in `common.robot`:

```robotframework
*** Keywords ***
Search For
    [Arguments]    ${search_term}
    Wait Until Element Is Visible    ${SEARCH_INPUT}
    Input Text    ${SEARCH_INPUT}    ${search_term}
    Press Keys    ${SEARCH_INPUT}    RETURN
```

### Handling Screenshots
Screenshots are automatically taken when tests fail. They are:
- Saved in the `Screenshots/` directory
- Named after the failing test
- Only captured on failure

Example screenshot name:
```
Search_For_Something_FAILED.png
```

## Running Tests

### Basic Run
```bash
./run_tests.sh
```

### Run Specific Tests
```bash
# Run tests with specific tag
robot -i smoke Tests/

# Run single test file
robot Tests/example_test.robot

# Run with custom browser
robot -v BROWSER:firefox Tests/
```

### Test Results
After running tests, you'll find:
- `log.html` - Detailed test execution log
- `report.html` - Test result summary
- `output.xml` - Raw test data
- Screenshots of any failures in `Screenshots/`

## Common Patterns

### Waiting for Elements
Always use explicit waits:
```robotframework
# Good - Explicit wait
Wait Until Element Is Visible    ${SEARCH_INPUT}
Input Text    ${SEARCH_INPUT}    search term

# Bad - No wait
Input Text    ${SEARCH_INPUT}    search term
```

### Error Handling
Use try-catch pattern:
```robotframework
*** Keywords ***
Handle Cookie Consent
    ${status}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${COOKIE_BANNER}
    Run Keyword If    ${status}    Click Element    ${COOKIE_BANNER}
```

### Test Setup/Teardown
Always clean up after tests:
```robotframework
*** Settings ***
Test Setup       Open Test Browser
Test Teardown    Close All Browsers

*** Keywords ***
Open Test Browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
```

## Best Practices

### 1. Test Organization
✅ DO:
```robotframework
*** Test Cases ***
User Can Login
    [Documentation]    Verifies user login works
    [Tags]    smoke    login
    Enter Login Details    ${USERNAME}    ${PASSWORD}
    Submit Login Form
    Verify Login Success
```

❌ DON'T:
```robotframework
*** Test Cases ***
Test 1
    [Documentation]    Tests stuff
    Do Many Things
    Check Many Things
```

### 2. Variable Naming
✅ DO:
```robotframework
${LOGIN_BUTTON}      id=loginBtn
${ERROR_MESSAGE}     css=.error-text
```

❌ DON'T:
```robotframework
${btn}              id=loginBtn
${error_msg}        css=.error-text
```

### 3. Keyword Organization
✅ DO:
```robotframework
*** Keywords ***
Enter Login Details
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}
```

❌ DON'T:
```robotframework
*** Keywords ***
Do Login Stuff
    [Arguments]    ${u}    ${p}
    Input Text    id=user    ${u}
    Input Text    id=pass    ${p}
```

## Troubleshooting

### Common Issues

1. **Element Not Found**
```robotframework
# Solution: Add explicit wait
Wait Until Element Is Visible    ${ELEMENT}    timeout=10s
Click Element    ${ELEMENT}
```

2. **Test Timing Out**
```robotframework
# Solution: Adjust timeout in wait commands
Wait Until Page Contains    ${TEXT}    timeout=20s
```

3. **Screenshot Issues**
Check:
- Screenshots directory exists
- Test has proper [Teardown]
- Permissions are correct

## Configuration

### Browser Options
In `variables.robot`:
```robotframework
*** Variables ***
${CHROME_OPTIONS}    options=add_argument("--start-maximized");add_argument("--disable-notifications")
```

### Test Timeouts
In your test file:
```robotframework
*** Settings ***
Test Timeout    2 minutes

*** Test Cases ***
Long Running Test
    [Timeout]    5 minutes
    Run Long Process
```

## Maintenance

### Adding New Tests
1. Create new .robot file in Tests/
2. Follow existing test structure
3. Use shared resources
4. Add appropriate documentation

### Updating Keywords
1. Check existing usage
2. Update documentation
3. Update any dependent tests
4. Run full test suite

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
2. Add clear documentation
3. Include example usage
4. Test thoroughly

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