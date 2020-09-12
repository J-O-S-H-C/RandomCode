# Althea Router Firmware
Althea.net is a software for decentralized ISPs. The following documents are a small amount of code that went into testing the router's firmware UI. The toolkit uses Selenium Webdriver in Python to interact with the browser. The whole toolkit is structured in a Page Object Model with the following structure:

    +-- tests.py: Lists the test sets for QA sessions
    +-- Page_Objects/
        +-- AdvancedPage.py
        +-- AltheaPage.py
        +-- NetworkPage.py
        +-- RouterPage.py

This is only an example of the overall toolkit as the majority of the code is proprietary to LunarHubLLC.

# AltheaPage.py
The default load page for the firmware with minimal fields. The primary purpose of this object model is to verify location of the current test's UI location.
# RouterPage.py
The Router page of the firmware was the primary location to change standard router information like SSID, Passwords, Channels, etc. Several input fields existed on this page that needed to be tested. The parameter choices also allowed for testing user input validation.