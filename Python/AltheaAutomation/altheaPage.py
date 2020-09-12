from selenium.webdriver.common.action_chains import ActionChains

class altheaPage():
    """ Page Object for Router-Settings 
    
    ...

    Methods
    -------
    is_correct_page (self, page)
        Compares the H1 tag on the page to the phrase passed 
    changePage (self, page)
        Clicks the link with the phrased passed 
    """

    def __init__(self, driver):
        self.driver = driver
        self.linkID = "althea-home"

    def is_correct_page(self, page):
        """ Compares the H1 tag on the page to the phrase passed. 

        Parameters
        ----------
        page : str
            The phrase used within the first H1 tag on the page. This should be the title of the page.
         """
        h1 = self.driver.find_element_by_tag_name("h1")
        if (h1.text != page):
            self.changePage(page)

    def changePage(self, page):
        """ Clicks the link with the phrased passed 

        Parameters
        ----------
        page : str
            The phrase used within the link on the page.
         """
        navLink = self.driver.find_element_by_id(page)
        self.driver.execute_script("arguments[0].click();", navLink)