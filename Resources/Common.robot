*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
Begin Web Test
    Set Selenium Timeout  30 seconds
#    Open Browser  ${URL.${ENVIRONMENT}}  ${BROWSER}  remote_url=http://selenium-hub:4444/wd/hub
    Open Browser  ${URL.${ENVIRONMENT}}  ${BROWSER}
#    remote_url=http://localhost:4444/wd/hub  <--- not usable for newer versions of Robot. Will keep it here for older versions.
    Set Window Size     1920    1080

End Web Test
    Close Browser
