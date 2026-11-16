#language: en
@tree
@IgnoreOnCIMainBuild

Feature: 17. Testing Analytical reports and panels

	As Administrator I want to
	Test analytical reports and analytical panels
	To eliminate errors during development

Background:
	
	And I close all client application windows

Scenario: 17.00 Determining application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 17.01 Creating report type

	* Creating a report type
		And I create report type with name "VA - Analytical reports" and parent "VA - Report group"

	* Configuring structure
		And I open report wizard with name "VA - Analytical reports"
		And I add rows in report wizard
			| 'Description' |
			| "Line 1"     |
			| "Line 2"     |
			| "Line 3"     |
		And I add columns in report wizard
			| 'Description' |
			| "Quantity"   |
			| "Price"         |
			| "Amount"        |

	* Configuring formulas
		And I set product formula for cell 'R2C4' of cells 'R2C2' 'R2C3' in report wizard
		And I set product formula for cell 'R3C4' of cells 'R3C2' 'R3C3' in report wizard
		And I set product formula for cell 'R4C4' of cells 'R4C2' 'R4C3' in report wizard

	* Closing report wizard
		When "Report wizard" window is opened
		And I close "Report wizard" window
		
	* Creating a template
		And I create default template for report type "VA - Analytical reports"

Scenario: 17.02 Creating analytical reports

	And I create analytical report group with code '100000000000' name "VA - Analytical reports" parent ''

	And I create analytical report with code '100000000001' report type "VA - Analytical reports" period "January 2024" company "Mercury LLC" parent "VA - Analytical reports"
	And I create analytical report with code '100000000002' report type "VA - Analytical reports" period "January 2024" company "System LLC" parent "VA - Analytical reports"

Scenario: 17.03 Creating analytical panel

	* Opening form
		And In the command interface I select "Budgeting, reporting, and analysis" "Analytical dashboards"

	* Deleting an element
		And I search element "VA - Analytical reports" "At the beginning of the line" by field "Analytical dashboard" in list "Analytical dashboards"
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "* (Analytical dashboard)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Analytical dashboard) *" window closing in 20 seconds
		And I select context menu item named 'ListContextMenuCancelSearch' of the form attribute named "List"

	* Creating element
 		Then "Analytical dashboards" window is opened
 		And I click the button named 'FormCreate'
 		Then "Analytical dashboard (create)" window is opened
 		And I input "VA - Analytical reports" text in the field named 'Description'
 		And I click the button named 'FormWrite'
 	
	 * Configuring panel
		Then "VA - Analytical reports (Analytical dashboard)" window is opened
		And in the table 'PanelContent' I click the button named 'PanelContentCreatePage'
		And I activate field named 'PanelContentArea' in 'PanelContent' table
		And I select current line in 'PanelContent' table
		And I input 'Page 1' text in the field named 'PanelContentArea' of 'PanelContent' table
		And I finish line editing in 'PanelContent' table
		And I select context menu item named 'PanelContentContextMenuCreateFolder' of the form attribute named 'PanelContent'
		And I expand current line in 'PanelContent' table
		And I go to line in 'PanelContent' table:
			| "Use" | "Set up report" | "Area"        | "Display description" |
			| "Yes"            | "(Default)"   | "(New group)" | "Yes"                      |
		And I select current line in 'PanelContent' table
		And I input "Group 1" text in the field named 'PanelContentArea' of 'PanelContent' table
		And I finish line editing in 'PanelContent' table
		And I click the button named 'FormWrite'

		When "VA - Analytical reports (Analytical dashboard)" window is opened
		And in the table 'PanelContent' I click the button named 'PanelContentAdd'
		And on the form menu I select "Standard area"
		And I search and select element "VA - Analytical reports (Mercury LLC)" "Exact match" by field "Description" in list "Analytical reports"

	 	Then 'VA - Analytical reports (Analytical dashboard)' window is opened
 		And in the table "PanelContent" I click the button named 'PanelContentAdd'
 		And on the form menu I select 'Standard area'
		And I search and select element "VA - Analytical reports (System LLC)" "Exact match" by field "Description" in list "Analytical reports"
 		
 	Then "VA - Analytical reports (Analytical dashboard)" window is opened
 	And I click the button named 'FormWriteAndClose'

Scenario: 17.04 Configuring rights for user "Budgeting1"

	And I add right "Read, write" for report type "VA - Analytical reports" user "Budgeting1" for all companies
	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 17.05 Creating report instances

	And I create report instance for report type "VA - Analytical reports" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	And I enter value '3.00000' in cell 'R6C2'
	And I enter value '4.00000' in cell 'R7C2'
	And I enter value '5.00000' in cell 'R8C2'
	And I enter value '100.00000' in cell 'R6C3'
	And I enter value '200.00000' in cell 'R7C3'
	And I enter value '300.00000' in cell 'R8C3'

	When '$WindowTitle$' window is opened
	And I click the button named 'WriteAndClose'
	And I wait '$WindowTitle$' window closing in 20 seconds

	And I create report instance for report type "VA - Analytical reports" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "System LLC" project '' dimensions '' '' '' '' '' ''
	And I click the button named 'FormFillInUsingAnotherApproach'
	Then "Select method to calculate indicators" window is opened
	And I select "Consolidate perimeter (IFRS)" exact value from the drop-down list named 'ReportGenerationMethod'
	And I click the button named 'FormSelect'

	When '$WindowTitle$' window is opened
	And I click the button named 'WriteAndClose'
	And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 17.06 Viewing analytical reports

	And In the command interface I select "Budgeting, reporting, and analysis" "Analytical reports"
	And I search element "VA - Analytical reports (Mercury LLC)" "Exact match" by field "Description" in list "Analytical reports"
	And I click the button named 'FormOpenReport'
	And 'Result' spreadsheet document is equal to "3_Budgeting\Layouts\18\VA_AnalyticalReport.mxl" by template
	And I close "VA - Analytical reports (Mercury LLC) (Analytical report)" window
	
	And I search element "VA - Analytical reports (System LLC)" "Exact match" by field "Description" in list "Analytical reports"
	And I click the button named 'FormOpenReport'
	And 'Result' spreadsheet document is equal to "3_Budgeting\Layouts\18\VA_AnalyticalReport.mxl" by template
	And I close "VA - Analytical reports (System LLC) (Analytical report)" window

	Then "Analytical reports" window is opened
	And I close "Analytical reports" window
		
Scenario: 17.07 Viewing analytical panels

	And In the command interface I select "Budgeting, reporting, and analysis" "Analytical dashboards"
	And I search element "VA - Analytical reports" "At the beginning of the line" by field "Analytical dashboard" in list "Analytical dashboards"
	And I click the button named 'FormShowPanel'

	And 'Code_100000000001_1_Window' spreadsheet document is equal to "3_Budgeting\Layouts\18\VA_AnalyticalReport.mxl" by template
	And 'Code_100000000002_2_Window' spreadsheet document is equal to "3_Budgeting\Layouts\18\VA_AnalyticalReport.mxl" by template
	
 	Then "VA - Analytical reports (Analytical dashboard)" window is opened
 	And I close "VA - Analytical reports (Analytical dashboard)" window
 	Then "Analytical dashboards" window is opened
 	And I close "Analytical dashboards" window
	