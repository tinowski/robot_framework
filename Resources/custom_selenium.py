from SeleniumLibrary import SeleniumLibrary
from robot.libraries.BuiltIn import BuiltIn

class CustomSeleniumLibrary(SeleniumLibrary):
    def __init__(self):
        super().__init__()
        self.screenshot_directory = None
        
    def capture_page_screenshot(self, filename=None):
        if BuiltIn().get_variable_value("${TEST_STATUS}") == "FAIL":
            return super().capture_page_screenshot(filename)
        return None
