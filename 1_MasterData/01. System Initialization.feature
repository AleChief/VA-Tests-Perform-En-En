#language: en
@tree

@UH32_NSI

Feature: 01. System initialization

	As an Analyst I want to
	fill the reference data database
	to use it in scenario tests

Scenario: 01.01 Creating a system user [Administrator]

	And I connect "Main client" test client from test client table
	
	* Creating an individual
		And I open "Persons" catalog default form
		Then 'Individuals' window is opened
		And I click the button named 'FormFind'
		Then "Find" window is opened
		And I input "Stark Bran" text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		If number of 'List' table lines is "equal" 0 Then
			And I click the button named 'FormCreate'
			Then 'Individual (create)' window is opened
			And I input 'Stark Bran' text in the field named 'Description'
			And I move to the next attribute
			And I click the button named 'FormWrite'
			And I click the button named 'FormWriteAndClose'
			And I wait 'Individual (create) *' window closing in 20 seconds
		Then 'Individuals' window is opened
		And I close "Individuals" window
	
	* Searching for user Administrator
		And In the command interface I select 'Administration' 'Users and rights settings'
		Then 'Users and rights settings' window is opened
		And I click 'Users' button
		When "Users" window is opened
		And I click the button named 'FormFind'
		Then "Find" window is opened
		And I input "Administrator" text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		If number of 'UsersList' table lines is "equal" 0 Then
			And I click the button named 'CreateUser'
			Then 'User (create)' window is opened
			And I input 'Administrator' text in 'Full name' field
		Else
			And I select current line in 'UsersList' table
			Then 'Administrator (User)' window is opened

	* Filling the user
		And I click the button named 'FormWrite'
		If 'Save infobase user' window is opened Then
			And I click 'Yes' button
		If 'Conversations (interaction system)' window is opened Then
			And I change checkbox 'Do not ask again'
			And I click 'No' button
		Then 'Administrator (User)' window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait 'Administrator (User)' window closing in 20 seconds

		And I execute 1C:Enterprise script at server no context
			| 'SetPrivilegedMode(True);' |
			| 'Common.CommonSettingsStorageSave("UserCommonSettings", "AskConfirmationOnExit", False, , "Administrator");' |

	And I close "Main client" TestClient

Scenario: 01.02 Allowing opening of external data processors

	Try
		And I connect "CPM - NSI" TestClient using "Administrator" login and "" password
	Except
		And Delay 30
		And I connect "CPM - NSI" TestClient using "Administrator" login and "" password

	If 'Security warning' window is opened Then
		And I click the button named 'Allow'
		When '1C:Enterprise' window is opened
		And I click the button named 'Button1'

	And I close "CPM - NSI" TestClient

Scenario: 01.03 Enabling subsystems

	Try
		And I connect "CPM - NSI" TestClient using "Administrator" login and "" password
	Except
		And Delay 30
		And I connect "CPM - NSI" TestClient using "Administrator" login and "" password

	* Enabling the "Master data management" subsystem
		And I set 'False' value to the constant 'UseMasterDataManagement'

	And I close "CPM - NSI" TestClient