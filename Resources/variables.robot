*** Variables ***
${BROWSER}               chrome
${DELAY}                0
${SEARCH_URL}           https://duckduckgo.com
${SEARCH_INPUT}         id=searchbox_input
${SEARCH_BUTTON}        xpath=//button[@type='submit']
${COOKIE_BANNER}        xpath=//*[contains(@id, 'consent') or contains(@class, 'consent') or contains(@title, 'consent')]//button[last()]
${CHROME_OPTIONS}       options=add_argument("--start-maximized"); add_argument("--disable-notifications"); add_argument("--no-sandbox"); add_argument("--disable-blink-features=AutomationControlled"); add_experimental_option("excludeSwitches", ["enable-automation"]); add_experimental_option("prefs", {"profile.default_content_setting_values.cookies": 1, "profile.block_third_party_cookies": false})
