*** Settings ***
Library  SeleniumLibrary
#Library  RobotEyes  test
Resource  ../Resources/POM/ExamplePage.robot
Resource  ../Resources/API/api.robot
Resource  ../Resources/Database/Postgresdb.robot
Resource  ../Resources/Common.robot

Test Setup  Begin Web Test
Test Teardown  End Web Test

#docker-compose -f docker-compose.ui-testing.yaml up
#pybot -d results tests/wartsila_demo.robot

*** Variables ***
#Firefox= Headless Firefox      Chrome= Headless Chrome
${BROWSER} =  Chrome
${ENVIRONMENT} =  tst
&{URL}  acc=www.google.nl  tst=https://expert-insight-test.apim.wartsila.com/login

*** Tasks ***
#Examples yo
Check elements on a page with the use of a for loop ...
    @{ITEMS} =  Create List  xpath=/html/body/div/div/div/div/div/form/input[1]  xpath=/html/body/div/div/div/div/div/form/input[2]

    FOR  ${MyItem}  IN  @{ITEMS}
       ${RESULT}    Run Keyword And Return Status    Wait until page contains element  ${MyItem}
       Should Be True   "${RESULT}" == "True"
       Run Keyword If   "${MyItem}" == "xpath=/html/body/div/div/div/div/div/form/input[2]" and "${RESULT}" == "True"    Click Element   xpath=/html/body/div/div/div/div/div/form/input[3]
       log     ${MyItem}
    END
    Sleep  5s

Check elements on a page with the use of a for loop ... 2
    FOR  ${MyItem}  IN  @{ITEMS}
       Wait until page contains element  ${MyItem}
       Run Keyword If  "${MyItem}" == "xpath=/html/body/div/div/div/div/div/form/input[2]"   Click Element   xpath=/html/body/div/div/div/div/div/form/input[3]
       log     ${MyItem}
    END
