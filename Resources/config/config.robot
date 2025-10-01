*** Variables ***
# Browser Configuration
${BROWSER}              chrome
${CHROME_OPTIONS}       options=add_argument("--start-maximized");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-gpu");add_argument("--disable-extensions");add_argument("--disable-notifications")

# Environment URLs
${BASE_URL}            https://duckduckgo.com
${API_URL}             https://api.duckduckgo.com    # For future API testing

# Directory Structure
${OUTPUT_DIR}          ${CURDIR}/../../
${SCREENSHOTS_DIR}     ${OUTPUT_DIR}/Screenshots
${RESULTS_DIR}         ${OUTPUT_DIR}/Results
${LOGS_DIR}           ${OUTPUT_DIR}/Logs

# Timeouts and Retry Settings
${TIMEOUT}            10s    # Default timeout for element operations
${RETRY_TIMEOUT}      1s     # Time between retries
${MAX_RETRIES}        3      # Maximum number of retry attempts

# Test Data
${DEFAULT_BROWSER}    chrome
${DEFAULT_LANGUAGE}   en-US
${DEFAULT_VIEWPORT}   1920x1080

# Logging Levels
${LOG_LEVEL}         INFO    # Default logging level
${SCREENSHOT_LEVEL}  WARN    # Level at which to take screenshots