*** Settings ***
Library           AppiumLibrary
Suite Setup       Open Application    appium_config.json
Suite Teardown    Close Application

*** Variables ***
${CALCULATOR_PACKAGE}     com.google.android.calculator
${CALCULATOR_ACTIVITY}    com.android.calculator2.Calculator

*** Test Cases ***
Addition
    [Documentation]    Testa a soma de dois números
    Open Calculator
    Press Key    2
    Press Key    add
    Press Key    3
    Press Key    equal
    Verify Result    5

Subtraction
    [Documentation]    Testa a subtração de dois números
    Open Calculator
    Press Key    5
    Press Key    subtract
    Press Key    2
    Press Key    equal
    Verify Result    3

Multiplication
    [Documentation]    Testa a multiplicação de dois números
    Open Calculator
    Press Key    3
    Press Key    multiply
    Press Key    4
    Press Key    equal
    Verify Result    12

Division
    [Documentation]    Testa a divisão de dois números
    Open Calculator
    Press Key    8
    Press Key    divide
    Press Key    2
    Press Key    equal
    Verify Result    4

*** Keywords ***
Open Calculator
    Launch App    ${CALCULATOR_PACKAGE}/${CALCULATOR_ACTIVITY}
    Wait Until Element Is Visible    id=com.google.android.calculator:id/digit_0

Press Key
    [Arguments]    ${key}
    ${key_id}=    Run Keyword And Return    Get Key Id    ${key}
    Click Element    ${key_id}

Get Key Id
    [Arguments]    ${key}
    ${key_ids}=    Create Dictionary
    ...    0=resource-id=com.google.android.calculator:id/digit_0
    ...    1=resource-id=com.google.android.calculator:id/digit_1
    ...    2=resource-id=com.google.android.calculator:id/digit_2
    ...    3=resource-id=com.google.android.calculator:id/digit_3
    ...    4=resource-id=com.google.android.calculator:id/digit_4
    ...    5=resource-id=com.google.android.calculator:id/digit_5
    ...    6=resource-id=com.google.android.calculator:id/digit_6
    ...    7=resource-id=com.google.android.calculator:id/digit_7
    ...    8=resource-id=com.google.android.calculator:id/digit_8
    ...    9=resource-id=com.google.android.calculator:id/digit_9
    ...    add=resource-id=com.google.android.calculator:id/op_add
    ...    subtract=resource-id=com.google.android.calculator:id/op_sub
    ...    multiply=resource-id=com.google.android.calculator:id/op_mul
    ...    divide=resource-id=com.google.android.calculator:id/op_div
    ...    equal=resource-id=com.google.android.calculator:id/eq
    [Return]    ${key_ids[${key}]}

Verify Result
    [Arguments]    ${expected}
    ${result}=    Get Text    id=com.google.android.calculator:id/result_final
    Should Be Equal As Numbers    ${result}    ${expected}