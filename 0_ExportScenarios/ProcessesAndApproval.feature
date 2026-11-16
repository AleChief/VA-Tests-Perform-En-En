#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the 'Process and Approval' subsystem

Scenario: I create contact persons role 'TheRole'

	* Opening list form
		And In the command interface I select "Consolidation under IFRS" "Contact person roles"

	* Deleting an element
		And I search element '[TheRole]' "Exact match" by field "Description" in list "Contact person roles"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheRole] (Contact person roles)" clearing
	
	* Creating an element
		When "Contact person roles" window is opened
		And I click the button named 'FormCreate'
		Then "Contact person roles (create)" window is opened
		And I input '[TheRole]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Contact person roles (create) *" window closing in 20 seconds
		And I close "Contact person roles" window

Scenario: I create extended addressing element 'TheExtendedAddressing' role 'TheRole'

	* Opening list form
		And In the command interface I select "Processes and approval" "Extended approval addressing"

	* Deleting an element
		And I search element '[TheExtendedAddressing]' "Exact match" by field "Description" in list "Extended approval addressing"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheExtendedAddressing] (Extended approval addressing)" clearing

	* Creating an element
		And I click the button named 'FormCreate'
		Then "Extended approval addressing (create)" window is opened
		And I input '[TheExtendedAddressing]' text in the field named 'Description'
		And I click Choice button of the field named 'Owner'
		Then "Select data type" window is opened
		And I go to line in "" table:
			| ''            |
			| "Infobase document" |
		And I select current line in "" table
		And I search and select element "Report instance" "Anywhere in the line" by field "Document" in list "Infobase documents"
		Then "Extended approval addressing (create) *" window is opened
		And I select "Role by fixed object" exact value from the drop-down list named 'ExtendedAddressingNegotiationType'
		And I move to the tab named 'GroupPageRoleByFixedObject'
		And I click Choice button of the field named 'AddressingRole1'
		And I search and select element '[TheRole]' "Exact match" by field "Description" in list "Contact person roles"
		Then "Extended approval addressing (create) *" window is opened
		And I click Choice button of the field named 'FixedAddressingObjects'
		Then "Select data type" window is opened
		If '$$IsERPCPM$$' Then
			And I go to line in "" table:
				| ''            |
				| "Company" |
		Else
			And I go to line in "" table:
				| ''                        |
				| "Business unit" |
		And I select current line in "" table
		Then "Business units" window is opened
		And I close "Business units" window
		Then "Extended approval addressing (create) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "[TheExtendedAddressing] (Extended approval addressing)" window closing in 20 seconds
		And I close "Extended approval addressing" window

Scenario: I add row to addressing matrix role 'TheRole' user 'TheUser'

	And In the command interface I select "Processes and approval" "Addressing matrix"
	
	* Deleting an element
		Then "Addressing matrix" window is opened
		And in the table 'TableOfResponsiblePersons' I click the button named 'TableOfResponsiblePersonsFind'
		Then "Find" window is opened
		And I select "Role" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input '[TheRole]' text in the field named 'Pattern'
		And I click the button named 'Find'
		
		Then "Addressing matrix" window is opened
		And in the table 'TableOfResponsiblePersons' I click the button named 'TableOfResponsiblePersonsFind'
		Then "Find" window is opened
		And I select "User" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input '[TheUser]' text in the field named 'Pattern'
		And I click the button named 'Find'
		
		And While the number of 'TableOfResponsiblePersons' table lines 'more' 0 Then
			And I select current line in 'TableOfResponsiblePersons' table
			And I delete current element in window "Responsible persons by objects*" clearing

	If number of 'TableOfResponsiblePersons' table lines is "=" 0 Then
		And in the table 'TableOfResponsiblePersons' I click the button named 'TableOfResponsiblePersonsCreate'
		Then "Responsible persons by objects" window is opened
		And I click Choice button of the field named 'Role'
		And I search and select element '[TheRole]' "Exact match" by field "Description" in list "Contact person roles"
		Then "Responsible persons by objects *" window is opened
		And I click Choice button of the field named 'User'
		And I search element '[TheUser]' "Exact match" by field "Full name" in list "Select user"
		And I select current line in 'UsersList' table
		Then "Responsible persons by objects *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Responsible persons by objects *" window closing in 20 seconds
		
	And in the table 'TableOfResponsiblePersons' I click the button named 'TableOfResponsiblePersonsCancelSearch'
	And I close "Addressing matrix" window

Scenario: I add approval step with name 'TheStepName' addressing method 'TheAddressingMethod' user 'TheUser' role 'TheRole' extended addressing 'TheExtendedAddressing'

	And in 'PossibleStepsTableBox' spreadsheet document I move to 'ApprovalStep' cell
	And I click the button named 'AddSelectedStep'
	Then "Approval step (Universal process step)" window is opened
	And I input '[TheStepName]' text in the field named 'Description'
	And I activate field named 'ApproversAddressingMethod' in 'Approvers' table
	And I select current line in 'Approvers' table

	If '"[TheAddressingMethod]" = "User"' Then
		And I select "User" exact value from the drop-down list named 'ApproversAddressingMethod' in 'Approvers' table
		And I finish line editing in 'Approvers' table
		And I activate field named 'ApproversUser' in 'Approvers' table
		And I select current line in 'Approvers' table
		And I search and select element '[TheUser]' "Exact match" by field "Full name" in list "Users"
	
	If '"[TheAddressingMethod]" = "Role"' Then
		And I select "Role" exact value from the drop-down list named 'ApproversAddressingMethod' in 'Approvers' table
		And I finish line editing in 'Approvers' table
		And I activate field named 'ApproversUser' in 'Approvers' table
		And I select current line in 'Approvers' table
		And I search and select element '[TheRole]' "Exact match" by field "Description" in list "Contact person roles"
	
	If '"[TheAddressingMethod]" = "Extended addressing" OR "[TheAddressingMethod]" = "Extended addressing"' Then
		And I select "Extended addressing" exact value from the drop-down list named 'ApproversAddressingMethod' in 'Approvers' table
		And I finish line editing in 'Approvers' table
		And I activate field named 'ApproversUser' in 'Approvers' table
		And I select current line in 'Approvers' table
		And I search and select element '[TheExtendedAddressing]' "Exact match" by field "Description" in list "Extended approval addressing"
		
	And I click the button named 'FormWriteAndClose'
	And I wait "Approval step (Universal process step) *" window closing in 20 seconds

Scenario: I add link from step 'TheStepOne' to step 'TheStepTwo'

	When "Editing process stages: *" window is opened
	And I click the button named 'AddLink'
	And I search and select element '[TheStepOne]' "Exact match" by field "Description" in list "Select initial link step"
	And I search and select element '[TheStepTwo]' "Exact match" by field "Description" in list "Select end link step"

Scenario: I add deputy 'TheDeputy' for user 'TheUser'
		
	Try
		When in opened panel I select "Home page"
	Except
		And I close all client application windows
	
	Then "Home page" window is opened
	And I click the button named 'AssignSubstitute'
		
	And I search element '[TheDeputy]' "Anywhere in the line" by field "Substitute" in list "Substitutes for user: [TheUser]"

	If number of 'List' table lines is "=" 0 Then
		And in the table "List" I click the button named 'AddSubstitute'
			
		And I search element '[TheDeputy]' "Exact match" by field "Full name" in list "Select user"
		And the number of 'UsersList' table lines is 'equal' 1
		And I select current line in 'UsersList' table

		Then "User substitute: [TheUser] *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "User substitute: [TheUser] *" window closing in 20 seconds
	Then "Substitutes for user: [TheUser]" window is opened
	And I close "Substitutes for user: [TheUser]" window
