#language: en

@tree
@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for managing reference data - Income and expense items

As a Tester I want
to have export scenarios for cash flow statement items
to make it easier to write and maintain tests

Background:
	   And I launch TestClient opening script or connect the existing one
	   And I close all client application windows

Scenario: I create income statement item group with name 'TheName'

	* Opening list form
		If '$$IsPerform$$' Then
			And I open 'IncomeAndExpenseItems' catalog default form
		Else
			And In the command interface I select "Planning and control" "Income and expense items"
	
	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Income and expense items"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (Income and expense items)" clearing

	* Creating an element
		Then "Income and expense items" window is opened
		And I click the button named 'FormCreateFolder'
		Then "Income and expense items (create group)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Income and expense items (create group) *" window closing in 20 seconds

	* Closing a list form
		When "Income and expense items" window is opened
		And I close "Income and expense items" window

Scenario: I create income statement item with name 'TheName' parent 'TheParent'

	* Opening list form
		If '$$IsPerform$$' Then
			And I open 'IncomeAndExpenseItems' catalog default form
		Else
			And In the command interface I select "Planning and control" "Income and expense items"
	
	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Income and expense items"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (Income and expense item)" clearing

	* Creating an element
		Then "Income and expense items" window is opened
		And I click the button named 'FormCreate'
		Then "Income and expense item (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I select from the drop-down list named 'Parent'  by '[TheParent]' string
		And I click the button named 'FormWriteAndClose'
		And I wait "Income and expense item (create) *" window closing in 20 seconds

	* Closing a list form
		When "Income and expense items" window is opened
		And I close "Income and expense items" window


Scenario: I define expansion group 'TheAnalyticsGroup' for income statement item with name 'TheName'
	
	* Opening list form
		If '$$IsPerform$$' Then
			And I open 'IncomeAndExpenseItems' catalog default form
		Else
			And In the command interface I select "Planning and control" "Income and expense items"

	* Finding and filling an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Income and expense items"
		And I select current line in "List" table
		Then '[TheName] (Income and expense item)' window is opened
		If the form attribute named "DrillDownGroup" became equal to '[TheAnalyticsGroup]' Then
			And I wait '[TheName] (Income and expense item) *' window closing in 20 seconds
		Else
			And I change the radio button named 'DrillDownGroupRadioButton' value to '1'
			And I select from the drop-down list named "DrillDownGroup"  by '[TheAnalyticsGroup]' string
			
	* Closing an element form
		And I click the button named 'FormWriteAndClose'
		And I wait '[TheName] (Income and expense item) *' window closing in 20 seconds
		And I close "Income and expense items" window

Scenario: I define dimension types 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6' for income statement item with name 'TheName'
	
	* Opening list form
		If '$$IsPerform$$' Then
			And I open 'IncomeAndExpenseItems' catalog default form
		Else
			And In the command interface I select "Planning and control" "Income and expense items"

	* Finding and filling an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Income and expense items"
		And I select current line in "List" table
		Then '[TheName] (Income and expense item)' window is opened

		If the form attribute named "DrillDownGroup" became equal to '' Then
			And I fill dimension types 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'
			And I click the button named 'FormWrite'
		Else
			And I wait '[TheName] (Income and expense item) *' window closing in 20 seconds

	* Closing an element form
		And I click the button named 'FormWriteAndClose'
		And I wait '[TheName] (Income and expense item) *' window closing in 20 seconds
		And I close "Income and expense items" window

Scenario: I define item movement type 'TheTypeDirection' for income statement item with name 'TheName'

	* Opening list form
		If '$$IsPerform$$' Then
			And I open 'IncomeAndExpenseItems' catalog default form
		Else
			And In the command interface I select "Planning and control" "Income and expense items"

	* Finding and filling an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Income and expense items"
		And I select current line in "List" table
		And I change the radio button named 'ArrivalExpense' value to '[TheTypeDirection]'
		And I click the button named 'FormWrite'
	
	* Closing an element form
		And I click the button named 'FormWriteAndClose'
		And I wait '[TheName] (Income and expense item) *' window closing in 20 seconds
		And I close "Income and expense items" window
