*** Settings ***
Library     Collections
Library		RequestsLibrary
Library     BuiltIn
Library     OperatingSystem
Library     json
Library     string

*** Keywords ***

*** Variables ***
#api variables
${API}=  https://case-management-tst.am.wartsila.com/api
${ALIAS}=  localhost

#json content
${json_string}      {"caseId":"1338","title":"AutomatedTest_Sc_A","installation":"100038006","asset":300208129,"priority":0,"assetHealth":0,"description":"","createdAt":null,"occurredAt":null,"endedAt":null,"editedAt":null,"editedBy":null,"reporter":0,"safetySeverity":0,"financialSeverity":0,"environmentalSeverity":0,"anomalyCategory":null,"detectedBy":null,"sensorTags":null,"followUpAction":null,"truePositive":false}

*** Keywords ***
#PUT = The PUT method completely replaces whatever currently exists at the target URL with something else.
#POST = The HTTP POST method is used to send user-generated data to the web server.

Get cases Requests 4C API
	${data}=	Create Session 	${ALIAS} 	${API}
	${resp}= 	Get Request 	${ALIAS} 	/cases
	Should Be Equal As Strings 	${resp.status_code} 	200     json=${data}
	${jsondata}=  to json  ${resp.content}

Post data test 4C API
    Create Session  ${ALIAS}     ${API}
    ${headers}=    Create Dictionary   Content-Type=application/json
    ${json}=    evaluate    json.loads('''${json_string}''')    json
    ${resp}=     Post Request  ${ALIAS}  /case    data=${json}     headers=${headers}
    Should Be Equal As Strings  ${resp.status_code}  200

#DOESNT WORK YET FOR THIS API
#Delete Requests with Json Data
#    Create Session  ${ALIAS}     ${API}
#    ${headers}=    Create Dictionary   Content-Type=application/json
#    ${json}=    evaluate    json.loads('''${json_string}''')    json
#    ${resp}=     Delete Request  ${ALIAS}  /cases    data=${json}     headers=${headers}
#    Should Be Equal As Strings  ${resp.status_code}  200