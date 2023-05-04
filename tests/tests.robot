*** Settings ***
Library                       QForce
Library                       QWeb
Suite Setup                   OpenBrowser                 about:blank            chrome

*** Variables ***
${SERVER}                     https://sanae3.my.salesforce.com/
${USERNAME}                   oliver.vamos-lxxk@force.com
${home_url}                   ${SERVER}/lightning/page/home

*** Keywords ***    
Open Browser and Login
    [Documentation]           Login to Salesforce
    Open Browser              ${SERVER}                   ${BROWSER}
    TypeText                  Username                    ${USERNAME}
    TypeText                  Password                    ${PASSWORD}
    ClickText                 Log In
    VerifyText                See the Top Essentials Features
    SetConfig                 DefaultTimeout              10s                    # Salesforce is slow
End Suite  
    [Documentation]           Log out and Close Browser
    ClickText                 View profile
    ClickText                 Log Out
    Close All Browsers



*** Test Cases ***
Create Lead
    [Documentation]           Creating and deleting Lead
    Open Browser and Login
    ClickText                 Leads
    ClickText                 New
    UseModal                  On
    PickList                  *Lead Status                Working
    PickList                  Salutation                  Dr.
    TypeText                  First Name                  Matus
    TypeText                  Last Name                   TEST2
    TypeText                  *Company                    Sanae
    TypeText                  Street                      Dunajská
    TypeText                  City                        Bratislava
    TypeText                  State/Province              Stare mesto
    TypeText                  Zip/Postal Code             85544
    TypeText                  Country                     Slovakia
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    VerifyText                Matus TEST2      partial_match=True
    ClickText                 Home
    ClickText                 Leads
    UseTable                  Item Number
    UseTable                  Item Number
    ClickCell                 r1c10
    ClickText                 Delete
    UseModal                  On
    ClickText                 Delete
    VerifyText                Lead "Matus TEST2" was deleted     partial_match=True
    End Suite

Create Account
    [Documentation]           Creating and deleting Account
    Open Browser and Login
    ClickText                 Accounts List
    ClickText                 New Account
    UseModal                  On
    TypeText                  *Account Name               Matus Test
    TypeText                  Phone                       +4219001789456
    PickList                  Type                        Analyst
    PickList                  Industry                    Banking
    ComboBox                  Search Address              Dúbravská cesta
    ClickText                 Save                        partial_match=False
    VerifyText                Account "Matus Test" was created.
    UseModal                  Off
    ClickText                 Accounts
    UseTable                  Item Number
    VerifyTable               r1c4                        MLajd
    ClickCell                 r1c5
    ClickText                 Delete
    UseModal                  On
    ClickText                 Delete
    VerifyText                Account "Matus Test" was deleted.
    VerifyNoText              +4219001789456
    End Suite

Create Contact
    ClickText                 Contacts
    ClickText                 New
    UseModal                  On
    ComboBox                  Search Accounts...          Matus
    PickList                  Salutation                  Dr.
    TypeText                  First Name                  Matus
    TypeText                  Last Name                   Tester
    TypeText                  Email                       matus@test.sk
    ClickText                 Undo Email
    TypeText                  Phone                       +4219077888999
    ComboBox                  Search Address              Dúbravská cesta
    TypeText                  Mailing Street              Dúbravská cesta 14
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    VerifyText                Dr. Matus Tester