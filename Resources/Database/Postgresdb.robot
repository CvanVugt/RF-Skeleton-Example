*** Settings ***
Library     Collections
Library     DatabaseLibrary
Library     BuiltIn
Library     OperatingSystem

*** Variables ***
#database connection variables
${DB_Server}        postgresql-10
${DB_User_Name}     username
${DB_Password}      password
${DB_Name}          casemanagement
${DB_Host}          name.something.eu-west-1.rds.amazonaws.com
${DB_Port}          5432

&{CASETITLE}    Scenario1=AutomatedTest_Sc_1     Scenario2=AutomatedTest_Sc_2       ScenarioA=AutomatedTest_Sc_A
&{CASEDELETION}     Scenario1=AutomatedTest_Sc_1      Scenario2=AutomatedTest_Sc_2

*** Keywords ***
A connection is established with the case management database
    Connect To Database   psycopg2   ${DB_Name}  ${DB_User_Name}  ${DB_Password}  ${DB_Host}  ${DB_Port}

Case is deleted in the database with a SQL query ${CASEDELETION}
    A connection is established with the case management database
    Run Keyword And Ignore Error      Row Count Is Equal To X     SELECT * FROM public."case" where title = '${CASEDELETION}';     1
    Run Keyword And Ignore Error      Execute SQL String     delete from public."case" where title = '${CASEDELETION}';

Case should be visible in the database ${CASETITLE}
    A connection is established with the case management database
    Row Count Is Equal To X     SELECT * FROM public."case" where title = '${CASETITLE}';     1

A case is CREATED in the database, uuid: aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa
    A connection is established with the case management database
    Execute SQL String      INSERT INTO public."case"(uuid, asset_health, asset_id, created_at, description, installation, installation_name, occurred_at, sensor_tags, status, title, nickname) VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 0, '300208128', '2999-01-01 07:47:44', 'This is an automated test. Or not, who knows.', '100038006', 'ALLURE OF THE SEAS', '2999-01-01 09:15:00', 'TE403PV', 2, 'Automated Test', 'Bob');

A case is DELETED in the database, uuid: aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa
    A connection is established with the case management database
    Run Keyword And Ignore Error  Row Count Is Equal To X     SELECT * FROM public."case" where uuid = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';     1
    Run Keyword And Ignore Error  Execute SQL String      delete from public."case" where uuid = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';