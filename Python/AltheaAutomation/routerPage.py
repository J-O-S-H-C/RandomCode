from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains
from Page_Objects.altheaPage import altheaPage

UNIQUE_VALUE = "sHsR08dn7b" #Used as a reference for bandwidth checking
class routerPage(altheaPage):
    """ Page Object for Router-Settings 
    
    ...

    Methods
    -------
    getSSID (self, freq)
        Gets the current SSID of specified frequency number. 
    getKey (self, freq)
        Gets the current Password/Key of specified frequency number. 
    getChannel(self, freq)
        Gets the current Channel of specified frequency number. 
    getAllChannels(self, freq)
        Gets the current array list of Channels for specified frequency number. 
    setSSID(self, freq, newID, new5ID=UNIQUE_VALUE)
        Changes the SSID to passed value for a specified frequency or both.  
    setKey(self, freq, newPass, new5Pass=UNIQUE_VALUE)
        Changes the Password/Key to passed value for a specified frequency or both. 
    setChannel(self, freq, newChannel)
        Changes the Wifi Channel to passed value for a specified frequency. 
    """

    def __init__(self, driver):
        """ Initializes the page 
        
        Defines all constants associated with Router Settings page. Validates that proper page is loaded by the web driver.

        Parameters
        ---------- 
        driver : driver
            The browser web driver
        """
        altheaPage.__init__(self, driver)
        self.TITLE = "Althea Router Dashboard"
        self.MAIN_HEADER = "Wi-Fi and Ports"
        self.MAIN_HEADER_ID = "router-settings-title"
        self.LINK_ID = "router-settings"
        self.GHZ_2_ID = "ssid_2ghz"
        self.GHZ_5_ID = "ssid_5ghz"
        self.KEY_2_ID = "key_2ghz"
        self.KEY_5_ID = "key_5ghz"
        self.CHANNEL_2_ID = "channel_2ghz"
        self.CHANNEL_5_ID = "channel_5ghz"
        self.WAIT_TIME = 120

        self.is_correct_page(self.LINK_ID)

    def setSSID(self, newID, new5ID=UNIQUE_VALUE, freq="25"):
        """ Changes the SSID to passed value for a specified frequency or both.

        If a frequency of 2 or 5 is passed the SSID for that specific 
        bandwidth will be changed. If no frequency is specified each SSID
        passed will be changed. If no frequency and only one SSID string
        is passed a 2 or 5 will be concatenated to the end of the SSID
        before both are changed.

        Parameters
        ----------
        freq : int, optional
            2 or 5 to represent Wifi bands.
        newID : str
            SSID required for changes. Used for both bands if only
            parameter passed.
        new5ID : str, optional
            SSID required for changes to 5Ghz band.
        """
        inputs = self.driver.find_elements_by_name('ssid')
        if freq == 2:
            inputs[0].clear()
            inputs[0].send_keys(newID)
            inputs[0].submit()
        elif freq == 5:
            inputs[1].clear()
            inputs[1].send_keys(newID)
            inputs[1].submit()
        else:
            inputs[0].clear()
            inputs[1].clear()
            if new5ID != UNIQUE_VALUE:
                inputs[0].send_keys(newID)
                inputs[1].send_keys(new5ID)
            else:
                inputs[0].send_keys(newID+"2")
                inputs[1].send_keys(newID+"5")
                print("SSID Changed to 2Ghz: " + newID+"2" + "and 5Ghz: " + newID+"5")
            inputs[1].submit()
            inputs[0].submit()

    def getSSID (self, freq="25"):
        """ Gets the current SSID of specified frequency number. 
        
        If the frequency isn't passed it returns an array of both SSIDs.

        Parameters
        ----------
        freq : int, optional
            2 or 5 to represent Wifi bands.
         """
        if freq == 2:
            return self.driver.find_elements_by_name('ssid')[0].get_attribute("value")
        elif freq == 5:
            return self.driver.find_elements_by_name('ssid')[1].get_attribute("value")
        else: #both default
            all_frequencies = self.driver.find_elements_by_name('ssid')
            ssid_list =[]
            for frequency in all_frequencies:
                ssid_list.append(frequency.get_attribute("value"))
            return ssid_list
    
    def setKey(self, newPass, new5Pass=UNIQUE_VALUE, freq="25"):
        """ Changes the Password/Key to passed value for a specified frequency or both.

        If a frequency of 2 or 5 is passed the passphrase for that specific 
        bandwidth will be changed. If no frequency is specified each passphrase
        passed will be changed. If no frequency and only one passphrase string
        is passed a 2 or 5 will be concatenated to the end of the passphrase
        before both are changed.

        Parameters
        ----------
        freq : int, optional
            2 or 5 to represent Wifi bands.
        newPass : str
            Passphrase required for changes. Used for both bands if only
            parameter passed.
        new5Pass : str, optional
            Passphrase required for changes to 5Ghz band.
        """
        inputs = self.driver.find_elements_by_name('key')
        if freq == 2:
            inputs[0].clear()
            inputs[0].send_keys(newPass)
            inputs[0].submit()
        elif freq == 5:
            inputs[2].clear()
            inputs[2].send_keys(newPass)
            inputs[2].submit()
        else:
            inputs[0].clear()
            inputs[2].clear()
            if new5Pass != UNIQUE_VALUE:
                inputs[0].send_keys(newPass)
                inputs[2].send_keys(new5Pass)
            else:
                inputs[0].send_keys(newPass+"2")
                inputs[2].send_keys(newPass+"5")
                print("Passphrases Changed to 2Ghz: " + newPass+"2" + "and 5Ghz: " + newPass+"5")
            inputs[2].submit()
            inputs[0].submit()

    def getKey (self, freq="25"):
        """ Gets the current Passphrase of specified frequency number.
        
        If the frequency isn't passed it returns an array of both passphrases.

        Parameters
        ----------
        freq : int, optional
            2 or 5 to represent Wifi bands.
        """
        if freq == 2:
            return self.driver.find_elements_by_name('key')[0].get_attribute("value")
        elif freq == 5:
            return self.driver.find_elements_by_name('key')[1].get_attribute("value")
        else: #both default
            all_frequencies = self.driver.find_elements_by_name('key')
            key_list =[]
            for frequency in all_frequencies:
                key_list.append(frequency.get_attribute("value"))
            return key_list

    def setChannel(self, freq, newChannel):
        """Changes the Wifi Channel to passed value for a specified frequency. 
        
        Parameters
        ----------
        freq : int
            2 or 5 to represent Wifi bands.
        newChannel : int
            One of the available bandwidth channels.

        Raises
        ------
        NotImplementedError
            If no frequency is not passed in as a parameter. 
        """
        if freq == 2:
            all_channels = self.driver.find_elements_by_name('channel')[0].find_elements_by_tag_name('option')
        elif freq == 5:
            all_channels = self.driver.find_elements_by_name('channel')[1].find_elements_by_tag_name('option')
        else:
            raise NotImplementedError("A frequency of 2 or 5 is required.")
        for channel in all_channels:
            if int(channel.get_attribute("value")) == int(newChannel):
                channel.click()
        channel.submit()

    def getChannel(self, freq):
        """ Gets the current Channel of specified frequency number.  
        
        Parameters
        ----------
        freq : int
            2 or 5 to represent Wifi bands.
        
        Raises
        ------
        NotImplementedError
            If no frequency is not passed in as a parameter.      
        """
        if freq == 2:
            return self.driver.find_elements_by_name('channel')[0].get_attribute("value")
        elif freq == 5:
            return self.driver.find_elements_by_name('channel')[1].get_attribute("value")
        else:
            raise NotImplementedError("A frequency of 2 or 5 is required.")
    
    def getAllChannels(self, freq):
        """Returns array of all available channels. 

        Parameters
        ----------
        freq : int
            2 or 5 to represent Wifi bands.
        
        Raises
        ------
        NotImplementedError
            If no frequency is not passed in as a parameter
        """
        channel_list = []
        if freq == 2:
            all_channels = self.driver.find_elements_by_name('channel')[0].find_elements_by_tag_name('option')
        elif freq == 5:
            all_channels = self.driver.find_elements_by_name('channel')[1].find_elements_by_tag_name('option')
        else:
            raise NotImplementedError("A frequency of 2 or 5 is required.")
        for channel in all_channels:
            channel_list.append(channel.get_attribute("value"))
        return channel_list

    def setPort(self, portNum, protocol):
        protoNum = protocol + "_" + str(portNum)
        button = WebDriverWait(self.driver, self.WAIT_TIME).until(
            EC.element_to_be_clickable((By.ID, protoNum))
        )
        button.click()
        confirm = WebDriverWait(self.driver, self.WAIT_TIME).until(
            EC.element_to_be_clickable((By.ID , "confirm")))
        if confirm.text != "Yes":
            print("wrong button")
            self.driver.quit()
        confirm.click()
        delay = WebDriverWait(self.driver, self.WAIT_TIME).until(
            EC.text_to_be_present_in_element((By.XPATH, "//div[@role='alert']"), "You can now safely unplug and re-plug your cables into the ports you wish to use."))