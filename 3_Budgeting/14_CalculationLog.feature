#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 14. Checking display of protocol

	As Administrator I want to
	Check that calculation protocol is displayed
	so that the user can see the calculation protocol

Background:

	And I close all client application windows

Scenario: 14.00 Determining application type

	And I close "CPM - Budget" TestClient
	Try
		And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 14.01 Creating report type "VA - Calculation protocol"

	And I create report type with name "VA - Calculation protocol" and parent "VA - Report group"

	* Editing the report structure
		And I open report wizard with name "VA - Calculation protocol"
		And I add row with name "ReportRow" in report wizard
		And I add column with name "Sum" in report wizard
	
	* Entering calculation formulas
		Then "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'ArbitraryCode'
		And I input text in the field named 'TextDocumentFieldProcedure'
			|'Result = 123;'|
		And I click the button named 'WriteAndCollapse'
		And I close "Report wizard" window

	And I create default template for report type "VA - Calculation protocol"
	And I for report type "VA - Calculation protocol" create default pivot table template with filters ''

Scenario: 14.02 Configuring rights for user "Budgeting1"

	And I add right "Read, write" for report type "VA - Calculation protocol" user "Budgeting1" for all companies
	And I close "CPM - Budget" TestClient
	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 14.03 Creating report instance "VA - Calculation protocol" for company "Mercury LLC"

	And I create report instance for report type "VA - Calculation protocol" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	* Saving document
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'

	* Calculating the document
		And I click the button named 'FormFillByDefault'

	* Verifying the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Calculation protocol" | ''               | ''                | ''             | ''      |
			| ''                      | ''               | ''                | ''             | ''      |
			| ''                      | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
			| ''                      | "Sum"          | "Sum"           | "Sum"        | "Sum" |
			| "ReportRow"          | '123'            | '123'             | '123'          | '369'   |
		
	* Closing without saving
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 14.04 Creating report instance "VA - Calculation protocol" for company "Earth LLC"

	And I create report instance for report type "VA - Calculation protocol" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Earth LLC" project '' dimensions '' '' '' '' '' ''

	* Saving document
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'

	* Calculating the document
		And I click the button named 'FormFillByDefault'
		When "Protocol" window is opened
		Then 'SpreadsheetDocumentField' spreadsheet document is equal
			| "Additional information"                                                                                                                                                                                    | ''           |
			| "Locked period is excluded from calculation by the following parameters:\n	Period: \"January 2024\"\n	Regulation: \"VA - Main regulations\",\n	Scenario: \"VA - Main scenario\",\n	Company: \"Earth LLC\""  | "Information" |
			| "Locked period is excluded from calculation by the following parameters:\n	Period: \"February 2024\"\n	Regulation: \"VA - Main regulations\",\n	Scenario: \"VA - Main scenario\",\n	Company: \"Earth LLC\""  | "Information" |
		And I click the button named 'FormTechnicalInformation'
		And I close "Protocol" window

	* Verifying the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Calculation protocol" | ''               | ''                | ''             | ''      |
			| ''                      | ''               | ''                | ''             | ''      |
			| ''                      | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
			| ''                      | "Sum"          | "Sum"           | "Sum"        | "Sum" |
			| "ReportRow"          | '0'              | '0'               | '123'          | '123'   |
		
	* Closing without saving
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'
				
Scenario: 14.05 Running calculation of report instances from list

	And I find report type with name "VA - Calculation protocol" in list
	And in the table 'ReportKindList' I click the button named 'ReportKindListOpenInstancesList'
	
	* Running calculation
		Then "Report instances" window is opened
		And I select all lines of 'List' table
		And I click the button named 'ImportOfData'
		
	* Checking protocol
		Then "Protocol" window is opened
		Then 'SpreadsheetDocumentField' spreadsheet document is equal
			| "Additional information"                                                                                                                                                                                    | ''           |
			| "Locked period is excluded from calculation by the following parameters:\n	Period: \"January 2024\"\n	Regulation: \"VA - Main regulations\",\n	Scenario: \"VA - Main scenario\",\n	Company: \"Earth LLC\""  | "Information" |
			| "Locked period is excluded from calculation by the following parameters:\n	Period: \"February 2024\"\n	Regulation: \"VA - Main regulations\",\n	Scenario: \"VA - Main scenario\",\n	Company: \"Earth LLC\""  | "Information" |
		And I click the button named 'FormTechnicalInformation'
		And I close "Protocol" window

	* Checking calculation for "Mercury LLC"
		Then "Report instances" window is opened
		And I go to line in 'List' table:
			| "Primary currency" | "Report type"            | "Company"  | "Report period"  | "End period" | "Scenario"               |
			| 'RUB'             | "VA - Calculation protocol" | "Mercury LLC" | "January 2024" | "March 2024"     | "VA - Main scenario" |
		And I select current line in 'List' table
		Then I open report instance for report type "VA - Calculation protocol" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Calculation protocol" | ''               | ''                | ''             | ''      |
			| ''                      | ''               | ''                | ''             | ''      |
			| ''                      | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
			| ''                      | "Sum"          | "Sum"           | "Sum"        | "Sum" |
			| "ReportRow"          | '123'            | '123'             | '123'          | '369'   |
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		
	* Checking calculation for "Mercury LLC"
		Then "Report instances" window is opened
		And I go to line in 'List' table:
			| "Primary currency" | "Report type"            | "Company" | "Report period"  | "End period" | "Scenario"               |
			| 'RUB'             | "VA - Calculation protocol" | "Earth LLC"   | "January 2024" | "March 2024"     | "VA - Main scenario" |
		And I select current line in 'List' table
		Then I open report instance for report type "VA - Calculation protocol" currency 'RUB' company "Earth LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Calculation protocol" | ''               | ''                | ''             | ''      |
			| ''                      | ''               | ''                | ''             | ''      |
			| ''                      | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
			| ''                      | "Sum"          | "Sum"           | "Sum"        | "Sum" |
			| "ReportRow"          | '0'              | '0'               | '123'          | '123'   |
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window

Scenario: 14.06 Running calculation of report instances from list

	* Opening a pivot table
		And I open report pivot table with name "VA - Calculation protocol"
		And I set pivot table filters: start date '1/1/2024', end date '3/31/2024', currency 'RUB', scenario "VA - Main scenario", company "Earth LLC"

	* Running calculation
		When '$WindowTitle$' window is opened
		And I click the button named 'RecalculateAccordingToRegulations'

	* Checking protocol
		Then "Protocol" window is opened
		Then 'SpreadsheetDocumentField' spreadsheet document is equal
			| "Additional information"                                                                                                                                                                                    | ''           |
			| "Locked period is excluded from calculation by the following parameters:\n	Period: \"January 2024\"\n	Regulation: \"VA - Main regulations\",\n	Scenario: \"VA - Main scenario\",\n	Company: \"Earth LLC\""  | "Information" |
			| "Locked period is excluded from calculation by the following parameters:\n	Period: \"February 2024\"\n	Regulation: \"VA - Main regulations\",\n	Scenario: \"VA - Main scenario\",\n	Company: \"Earth LLC\""  | "Information" |
		And I click the button named 'FormTechnicalInformation'
		And I close "Protocol" window

	* Verifying the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Calculation protocol (pivot table)" | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
			| "VA - Calculation protocol (pivot table)" | "Sum"          | "Sum"           | "Sum"        | "Sum" |
			| "ReportRow"                            | '0'              | '0'               | '123'          | '123'   |
					