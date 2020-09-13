. .\getFirmware.ps1
. .\installFirmware.ps1
. .\connectWifi.ps1
. .\findNetProfile.ps1

$DEFAULT_URL = "https://github.com/althea-net/althea-firmware/releases/download/"   #Github repo archived firmware
$DEFAULT_DIR = "C:\Users\*********\Documents\Althea\Firmware\"                      #Where the firmware gets organized locally
$DEVICE_IP = "192.168.10.1"                                                         #Fresh firmware install IP
$DEVICE_DEFAULT_SSID = "AltheaHome-5"                                               #Wifi SSID for fresh firmware install
$DEFAULT_MODEL = "all"                                                              #n600 n750 glb1300 wrt3200acm edge x86 all
$INSTALL_TYPE = "sysupgrade.bin"                                                    #factory.bin
$TEST_PHASE = "Beta"                                                                #Current repo phase. ie: Alpha or Beta
$TEST_PHASE_NUM = "10"                                                              #Current phase number
$TEST_RELEASE_NUM = "6"                                                             #Release Candidate number
$MODEL_URLS = @{                                                                    #All the models currently in test github locations
    n600 = '/openwrt-ar71xx-generic-mynet-n600-squashfs-sysupgrade.bin';
    n750 = '/openwrt-ar71xx-generic-mynet-n750-squashfs-sysupgrade.bin';
    glb1300 = '/openwrt-ipq40xx-glinet_gl-b1300-squashfs-sysupgrade.bin';
    edge = '/openwrt-ramips-mt7621-ubnt-erx-squashfs-sysupgrade.tar';
    x86 = "/openwrt-x86-64-combined-squashfs.img.gz";
    wrt3200acm = '/openwrt-mvebu-cortexa9-linksys-wrt3200acm-squashfs-sysupgrade.bin'
}
$DEVICE_NUM = "32"                                                                  #Device number for testing multiple devices of the same hardware.
$INTERNET_IP = "8.8.8.8"                                                            #Google DNS server for testing if proper internet access exists.
$INTERNET_SSID = "Argonath"                                                         #Fall back connection for downloading. Required to have proper internet access.