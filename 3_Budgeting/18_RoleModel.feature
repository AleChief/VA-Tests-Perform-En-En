#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 18. Checking role model in Budgeting

	As Administrator I want to
	Check that the role model in Budgeting
	works correctly

Background:
	
	And I close all client application windows

Scenario: 18.00 Determining application type

	And I close "CPM - Budget" TestClient
	Try
		And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

	And I enable performance mode of restrictions at record level
	
Scenario: 18.01 Creating report type group "VA - Checking access settings (group)"

	And I create report type group with name "VA - Checking access settings (group)" and parent "VA - Report group"

Scenario: 18.02 Creating report type "VA - Checking access settings (no)"

	* Creating a report type
		And I create report type with name "VA - Checking access settings (no)" and parent "VA - Checking access settings (group)"

	* Configuring report type
		And I open report type with name "VA - Checking access settings (no)"
		And I set checkbox named 'ProjectSeparation'
		And I move to the tab named 'DimensionsOfReport'
		And I select from the drop-down list named 'DimensionKind1'  by "Company business units" string
		And I click the button named 'RecordButtonForm'
		Then "Data restructuring" window is opened
		And I click the button named 'FormOK'
		And I click the button named 'EditTree'

	* Editing the report structure
		And I add row with name "ReportRow" in report wizard
		And I add row with name "ReportRowX2" in report wizard
		And I add column with name "Amount" in report wizard
		And I add dimension with code "VA0IEItems" in cell 'R3C3' in report wizard

	* Configuring formulas
		When "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R3C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Report wizard" window is opened
		And I click the button named 'TotalByAccount1'
		Then "Data source (create)" window is opened
		And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Checking access settings (no)" string
		And I click Choice button of the field named 'IndicatorFilter'
		Then "Report indicators" window is opened
		And I change the radio button named 'IndicatorChoiceMode' value to "Indicator list"
		When "Report indicators" window is opened
		And I go to line in 'List' table by template:
			| "Code"               | "Description"       |
			| "ReportRow_Amount*" | "ReportRow amount" |
		And I select current line in 'List' table
		Then "Data source (create) *" window is opened
		And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
		And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
		And I finish line editing in 'ComplianceTable' table
		And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
		And I select current line in 'ComplianceTable' table
		And I search and select element "2Software implementation" "Exact match" by field "Description" in list "Income and expense items"
		When "Data source (create) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Data source (create) *" window closing in 20 seconds
		Then "Report wizard *" window is opened
		And I input "[VACheckingAccessSettingsNo_ReportRow_Amount] * 2" text in the field named 'TextDocumentFieldProcedure'
		And I click the button named 'WriteAndCollapse'
		When "Report wizard" window is opened
		And I close "Report wizard" window

	And I create default template for report type "VA - Checking access settings (no)"
	And I for report type "VA - Checking access settings (no)" create default pivot table template with filters "Company business units" "Project"

Scenario Outline: 18.03 Copying report type "VA - Checking access settings (no)"

	* Opening a list
		And In the command interface I select "Budgeting, reporting, and analysis" "Report types and templates"

	* Deleting the current element
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input <TextReportKind> text in the field named 'Pattern'
		And I click the button named 'Find'
		And While the number of 'ReportKindList' table lines 'more' 0 Then
			* Marking for deletion
					And I delete current row in list 'ReportKindList'
						And I select context menu item named 'ReportKindListContextMenuSetDeletionMark' of the form attribute named 'ReportKindList'
						Then "1C:Enterprise" window is opened
						If form element named 'Message' became equal to "Mark * for deletion?" by template Then
								And I click the button named 'Button0'
						Else
								And I click the button named 'Button1'
						And I wait the attribute named 'ReportKindList' availability in 20 seconds
			* Renaming
				And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'ReportKindList' table
				Then "* (Report types)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I input 'UID' variable value in the field named 'FullDescr'
				And I input 'UID' variable value in the field named 'Code'
				And I input '' text in the field named 'Parent'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Report types)" window closing in 20 seconds

	* Searching for report to copy
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input "VA - Checking access settings (no)" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then the number of 'ReportKindList' table lines is "equal" 1
		When "Report types and templates" window is opened
		And I select context menu item named 'ReportKindListContextMenuCopy' of the form attribute named 'ReportKindList'
		Then "Copy report type" window is opened
		And I click the button named 'FormOK'
		When "Report types (create)" window is opened
		And I input <TextReportKind> text in the field named 'Description'
		And I input <TextReportKind> text in the field named 'FullDescr'
		And I click the button named 'FormWriteAndClose'
		And I wait "Report types (create) *" window closing in 20 seconds

	* Creating pivot table template
		// TO DO: Templates should be correctly copied along with the report type
		When "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input <TextReportKind> text in the field named 'Pattern'
		And I click the button named 'Find'
		When "Report types and templates" window is opened
		Then the number of 'ReportKindList' table lines is "equal" 1
		And I go to line in 'List' table:
			| "Description"                                           |
			| "VA - Checking access settings (no) (pivot table)" |
		And I select current line in 'List' table
		When "Pivot table template: *" window is opened
		And I click the button named 'ShowListOfRows'
		Then "Set up line list" window is opened
		And I go to line in 'TreeOfSelectedLines' table by template:
			| "Code"         | "Report line" |
			| "ReportRow*" | "ReportRow"  |
		And I click the button named 'Delete'
		And I click the button named 'Delete'
		And I click the button named 'MoveLeftAll'
		And I click the button named 'ApplyTheChanges'
		Then "Pivot table template: *" window is opened
		And I click the button named 'ShowListOfColumns'
		Then "Set up column list" window is opened
		And in the table 'PivotTableColumnsListSettings' I click the button named 'PivotTableColumnsListSettingsDelete'
		And in the table 'PivotTableColumnsListSettings' I click the button named 'PivotTableColumnsListSettingsPopulateColumns'
		And I click the button named 'FormApply'
		Then "Pivot table template: *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Pivot table template: *" window closing in 20 seconds

Examples:
	| TextReportKind                              |
	| "VA - Checking access settings (record)" |
	| "VA - Checking access settings (read)" |

Scenario Outline: 18.04 Creating indicator value adjustment templates

	And I create indicator values adjustment template with name <TextReportKind> and report types
		| "Report type"   |
		| <TextReportKind> |

	And I fill adjustment table with values for indicator values adjustment template with name <TextReportKind>
		| "Report type"   | "Indicator"           |
		| <TextReportKind> | "ReportRow amount"   |
		| <TextReportKind> | "ReportRowX2 amount" |

Examples:
	| TextReportKind                              |
	| "VA - Checking access settings (no)"    |
	| "VA - Checking access settings (record)" |
	| "VA - Checking access settings (read)" |

Scenario Outline: 18.05 Creating indicator value adjustments

	And I create indicator values adjustment scenario "VA - Main scenario" period "January 2024" frequency "Month" company <TextOrganization> values
		| "Report type"   | "Indicator"         | "Company"    | "Report period"  | "Dimension 1"   | "Project"               | "Adjustment" |
		| <TextReportKind> | "ReportRow amount" | <TextOrganization> | "January 2024" | "Administration" | "VA - Main project" | "20.00000"      |

Examples:
	| TextReportKind                              | TextOrganization |
	| "VA - Checking access settings (no)"    | "Mercury LLC" |
	| "VA - Checking access settings (record)" | "Mercury LLC" |
	| "VA - Checking access settings (read)" | "Venus LLC"   |
	| "VA - Checking access settings (read)" | "System LLC"  |

Scenario: 18.06 Creating double indicator value adjustment template

	And I create indicator values adjustment template with name "VA - Checking access settings (some)" and report types
		| "Report type"                              |
		| "VA - Checking access settings (no)"    |
		| "VA - Checking access settings (record)" |

	And I fill adjustment table with values for indicator values adjustment template with name "VA - Checking access settings (some)"
		| "Report type"                              | "Indicator"         |
		| "VA - Checking access settings (no)"    | "ReportRow amount" |
		| "VA - Checking access settings (record)" | "ReportRow amount" |

Scenario: 18.07 Creating double indicator value adjustment

	And I open new indicator values adjustment scenario "VA - Main scenario" period "January 2024" frequency "Month" company "Mercury LLC"

	When "Indicator value adjustment (create) *" window is opened
	And I select from the drop-down list named 'TemplateOfAdjustment'  by "VA - Checking access settings (some)" string
	And in the table 'KeyAttributes' I click the button named 'KeyAttributesPopulateKeyAttributes'
	Then "Attribute population form" window is opened
	And I select "Mercury LLC" exact value from the drop-down list named 'Organization'
	And I select from the drop-down list named 'ReportPeriod'  by "January 2024" string
	And I click the button named 'FormOK'
	Then "Indicator value adjustment (create) *" window is opened
	And in the table 'TableOfAdjustments' I click the button named 'FillFromTemplate'
	// TO DO: When filling by template, there is no way to specify the report type dimension and project
	And I click the button named 'FormPostAndClose'
	And I wait "Indicator value adjustment (create) *" window closing in 20 seconds

Scenario Outline: 18.08 Creating report instances

	And I create report instance for report type <TextReportKind> scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company <TextOrganization> project "VA - Main project" dimensions "Administration" '' '' '' '' ''
	Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_20.mxl'
	And I enter value '100' in cell 'R6C2'
	Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_100.mxl'
	And I click the button named 'WriteAndClose'
	And I wait '$WindowTitle$' window closing in 20 seconds

Examples:
	| TextReportKind                              | TextOrganization |
	| "VA - Checking access settings (no)"    | "Mercury LLC" |
	| "VA - Checking access settings (record)" | "Mercury LLC" |
	| "VA - Checking access settings (read)" | "Venus LLC"   |
	| "VA - Checking access settings (read)" | "System LLC"  |

Scenario: 18.09 Configuring rights for users

	// Access group "VA - Budgeting (Editing)", companies - all
	And I add right "Read, write" for report type "VA - Checking access settings (record)" user "Budgeting1" for all companies
	And I add right "Read" for report type "VA - Checking access settings (read)" user "Budgeting1" for all companies

	// Access group "VA - Budgeting (Editing)", companies - all
	And I add right "Read, write" for report type "VA - Checking access settings (record)" user "Budgeting2" company "Mercury LLC"
	And I add right "Read" for report type "VA - Checking access settings (read)" user "Budgeting2" company "Venus LLC"

	// Access group "VA - Budgeting (View)", companies - "Mercury LLC" and "Venus LLC"
	And I add right "Read, write" for report type "VA - Checking access settings (record)" user "Budgeting3" company "Mercury LLC"

	And I close current test client session

Scenario: 18.10 Checking report types for "Budgeting1"
	
	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Report "VA - Checking access settings (no)" should not be in the list
		And In the command interface I select "Budgeting, reporting, and analysis" "Report types and templates"
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input "VA - Checking access settings (no)" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then the number of 'ReportKindList' table lines is "equal" 0
				
	* Searching for report "VA - Checking access settings (record)"
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input "VA - Checking access settings (record)" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then the number of 'ReportKindList' table lines is "equal" 1
		And I close "Report types and templates" window

Scenario: 18.11 Checking indicator value adjustments for "Budgeting1"

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Opening list with filters
		And In the command interface I select "Budgeting, reporting, and analysis" "Indicator value adjustment"
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I set filter in list form "Synthetic adjustment.Report type.Description" "Contains" "VA - Checking access settings"
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I add filter in list form "Deletion mark" "Equal to" "No"

	* Checking list composition
		Then I check table 'List' contains '4' rows from list:
			| "Company"  | "Scenario"               | "Adjustment template"                       | "Adjustment input method" |
			| "Mercury LLC" | "VA - Main scenario" | ""                                           | "Manual entry"                  |
			| "Venus LLC"   | "VA - Main scenario" | ""                                           | "Manual entry"                  |
			| "System LLC"  | "VA - Main scenario" | ""                                           | "Manual entry"                  |
			| "Mercury LLC" | "VA - Main scenario" | "VA - Checking access settings (some)" | "Manual entry"                  |

	* Opening document without access
		And I go to line in 'List' table:
			| "Company"  | "Scenario"               | "Adjustment template"                       | "Adjustment input method" |
			| "Mercury LLC" | "VA - Main scenario" | "VA - Checking access settings (some)" | "Manual entry"                  |
		And I select current line in 'List' table
		Then "Indicator value adjustment" window is opened
		Then there are lines in TestClient message log
			|"Insufficient access rights to view the document.\nCheck settings in Report type access matrix."|
		And I clear user message window
		
	* Cancelling posting of document without access
		And I select context menu item named 'ListContextMenuUndoPosting' of the form attribute named 'List'
		Then "1C:Enterprise" window is opened
		And I click the button named 'OK'
		Then there are lines in TestClient message log
			|"Insufficient access rights to save the document.\nCheck settings in Report type access matrix."|
		And I clear user message window

	* Opening document with access
		When "Indicator value adjustment" window is opened
		And I go to line in 'List' table:
			| "Company"  | "Scenario"               | "Adjustment template" | "Adjustment input method" |
			| "Mercury LLC" | "VA - Main scenario" | ""                     | "Manual entry"                  |
		And I select current line in 'List' table
		Then "Indicator value adjustment *" window is opened
		And I click the button named 'FormPostAndClose'
		And I wait "Indicator value adjustment *" window closing in 20 seconds
		And TestClient log message does not contain "*" string

	* Opening document with read access
		When "Indicator value adjustment" window is opened
		And I go to line in 'List' table:
			| "Company" | "Scenario"               | "Adjustment template" | "Adjustment input method" |
			| "Venus LLC"  | "VA - Main scenario" | ""                     | "Manual entry"                  |
		And I select current line in 'List' table
		Then "Indicator value adjustment *" window is opened
		And I click the button named 'FormPostAndClose'
		Then "1C:Enterprise" window is opened
		And I click the button named 'OK'
		Then there are lines in TestClient message log
			|"Insufficient access rights to save the document.\nCheck settings in Report type access matrix."|
		And I close "Indicator value adjustment *" window
		
	* Removing filters
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I remove all filters in list form

Scenario: 18.12 Checking report instances for "Budgeting1"

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Searching for report instances
		And In the command interface I select "Budgeting, reporting, and analysis" "Report instances"
		And I search element "VA - Checking access settings" "At the beginning of the line" by field "Report type" in list "Report instances"
		And I click Clear button of the field named 'SavedSetting'
		Then I check table 'List' contains "3" rows from list:
			| "Report type"                              | "Company"  | "Report period"  | "End period" | "Scenario"               | "State" | "Project"               | "Dimension 1"   | "Dimension 2" | "Dimension 3" | "Dimension 4" | "Dimension 5" | "Dimension 6" | "Primary currency" | "External infobase" |
			| "VA - Checking access settings (read)" | "System LLC"  | "January 2024" | "March 2024"     | "VA - Main scenario" | "Draft"  | "VA - Main project" | "Administration" | ''            | ''            | ''            | ''            | ''            | "RUB"             | ''           |
			| "VA - Checking access settings (read)" | "Venus LLC"   | "January 2024" | "March 2024"     | "VA - Main scenario" | "Draft"  | "VA - Main project" | "Administration" | ''            | ''            | ''            | ''            | ''            | "RUB"             | ''           |
			| "VA - Checking access settings (record)" | "Mercury LLC" | "January 2024" | "March 2024"     | "VA - Main scenario" | "Draft"  | "VA - Main project" | "Administration" | ''            | ''            | ''            | ''            | ''            | "RUB"             | ''           |

	* Opening document with write access
		And I go to line in 'List' table:
			| "Report type"                              | "Company"  | "Report period"  | "End period" | "Scenario"               | "State" | "Project"               | "Dimension 1"   | "Primary currency" |
			| "VA - Checking access settings (record)" | "Mercury LLC" | "January 2024" | "March 2024"     | "VA - Main scenario" | "Draft"  | "VA - Main project" | "Administration" | "RUB"             |
		And I select current line in 'List' table
		And I open report instance for report type "VA - Checking access settings (record)" currency "RUB" company "Mercury LLC" scenario "VA - Main scenario" frequency 'Month' project "VA - Main project" dimensions "Administration" '' '' '' '' ''
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_100.mxl'
		And I click the button named 'FormVersionsManagement'
		Then "Indicator version management" window is opened
		And I click the button named 'ListDeleteVersions'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Indicator version management *" window is opened
		And I close "Indicator version management *" window
		And '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_20.mxl'
		And I click the button named 'EnableEdit'
		And I enter value '100' in cell 'R6C2'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_100.mxl'
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds
		When "Report instances" window is opened
		And I select current line in 'List' table
		And '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_100.mxl'
		And I close '$WindowTitle$' window
				
	* Opening document with read access
		When "Report instances" window is opened
		And I go to line in 'List' table:
			| "Report type"                              | "Company" | "Report period"  | "End period" | "Scenario"               | "State" | "Project"               | "Dimension 1"   | "Primary currency" |
			| "VA - Checking access settings (read)" | "Venus LLC"  | "January 2024" | "March 2024"     | "VA - Main scenario" | "Draft"  | "VA - Main project" | "Administration" | "RUB"             |
		And I select current line in 'List' table
		And I open report instance for report type "VA - Checking access settings (read)" currency "RUB" company "Venus LLC" scenario "VA - Main scenario" frequency 'Month' project "VA - Main project" dimensions "Administration" '' '' '' '' ''
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_100.mxl'
		And form attribute named 'EnableEdit' is unavailable
		And I close '$WindowTitle$' window

	* Marking document for deletion
		When "Report instances" window is opened
		And I select context menu item named 'ListContextMenuSetDeletionMark' of the form attribute named 'List'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		When "1C:Enterprise" window is opened
		And I click the button named 'OK'
		Then there are lines in TestClient message log
			|"Insufficient access rights to save the document.\nCheck settings in Report type access matrix."|

Scenario: 18.13 Checking report instances settings form for "Budgeting1"

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And I open first report instance for report type "VA - Checking access settings (record)"
	Then I open report instance for report type "VA - Checking access settings (record)" currency "RUB" company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions "Administration" '' '' '' '' ''

	* Checking settings form
		And I click the button named 'FormOpenSettings'
		When "Document settings" window is opened
		And I click Open button of the field named 'ReportKind'
		Then "VA - Checking access settings (record) (Report types)" window is opened
		And I close "VA - Checking access settings (record) (Report types)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'TemplateForReport'
		Then "Template VA - Checking access settings (no) report type: VA - Checking access settings (record)" window is opened
		And I close "Template VA - Checking access settings (no) report type: VA - Checking access settings (record)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'Project'
		Then "VA - Main project (Projects and phases)" window is opened
		And I close "VA - Main project (Projects and phases)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'Dimension1'
		When "Administration (Department)" window is opened
		And I close "Administration (Department)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'Scenario'
		Then "Scenarios: VA - Main scenario (Scenarios)" window is opened
		And I close "Scenarios: VA - Main scenario (Scenarios)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'PeriodManagement'
		Then "January 2024 - March 2024 (Frequency: Month) <VA - Main scenario>" window is opened
		And I close "January 2024 - March 2024 (Frequency: Month) <VA - Main scenario>" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'Organization'
		Then "Mercury LLC (Business unit*)" window is opened
		And I close "Mercury LLC (Business unit*)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'RegulationVersion'
		Then "VA - Main regulations from * (Regulation for preparing reports)" window is opened
		And I close "VA - Main regulations from * (Regulation for preparing reports)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'MainCurrency'
		Then "RUB (Currency)" window is opened
		And I close "RUB (Currency)" window
		Then "Document settings" window is opened
		And I move to the tab named 'GroupPageReportSettings'
		And I click Open button of the field named 'ProcessingRule'
		Then "VA - Checking access settings (no) (Calculation rules)" window is opened
		And I close "VA - Checking access settings (no) (Calculation rules)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'ExternalInfobase'
		Then "Current infobase (External infobases)" window is opened
		And I close "Current infobase (External infobases)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'CheckRule'
		Then "VA - Checking access settings (no) (Check rules)" window is opened
		And I close "VA - Checking access settings (no) (Check rules)" window

	* Changing period
		Then "Document settings" window is opened
		And I click the button named 'ChangePeriod'
		Then "Select period" window is opened
		And I input '1/1/2023' text in the field named 'DateBegin'
		And I input '3/31/2023' text in the field named 'DateEnd'
		And I click the button named 'Select'
		And "Document settings *" window is opened
		Then there are lines in TestClient message log
			|"Cannot identify a reporting period management document by the parameters:\n	Scenario: VA - Main scenario,\n	Period: January 2023"|
		And I clear user message window
		Then the form attribute named 'PeriodManagement' became equal to ""
		Then the form attribute named 'Organization' became equal to ""
		Then the form attribute named 'ReportFrequency' became equal to "Month"
		Then the form attribute named 'ReportPeriod' became equal to ""
		Then the form attribute named 'EndingPeriod' became equal to ""
		Then the form attribute named 'RegulationVersion' became equal to ""
		Then the form attribute named 'MainCurrency' became equal to ""

	* Selecting period management document
		Then "Document settings *" window is opened
		And I click Choice button of the field named 'PeriodManagement'
		And I find and select reporting period management document by scenario "VA - Main scenario" and start period "January 2024"
		Then "Document settings *" window is opened
		And the form attribute named 'AdditionalCurrencies' became equal to "USD; EUR"
		And the form attribute named 'Organization' became equal to ""
		And the form attribute named 'MainCurrency' became equal to "RUB"
		And the form attribute named 'ReportFrequency' became equal to "Month"
		And the form attribute named 'EndingPeriod' became equal to "March 2024"
		And the form attribute named 'ReportPeriod' became equal to "January 2024"
		And the form attribute named 'RegulationVersion' became equal to "VA - Main regulations"
		And the form attribute named 'Scenario' became equal to "VA - Main scenario"
		And the form attribute named 'PeriodManagement' became equal to "January 2024 - March 2024 (Frequency: Month) <VA - Main scenario>"

	* Clearing scenario
		When "Document settings *" window is opened
		And I click Clear button of the field named 'Scenario'
		Then the form attribute named 'PeriodManagement' became equal to ""
		Then the form attribute named 'ReportFrequency' became equal to "Month"
		Then the form attribute named 'ReportPeriod' became equal to ""
		Then the form attribute named 'EndingPeriod' became equal to ""
		Then the form attribute named 'RegulationVersion' became equal to ""
		Then the form attribute named 'MainCurrency' became equal to ""

	* Selecting scenario
		When "Document settings *" window is opened
		And I select from the drop-down list named 'Scenario'  by "VA - Main scenario" string
		Then the form attribute named 'Dimension1' became equal to "Administration"
		And the form attribute named 'AdditionalCurrencies' became equal to "USD; EUR"
		And the form attribute named 'MainCurrency' became equal to "RUB"
		And the form attribute named 'ReportFrequency' became equal to "Month"
		And the form attribute named 'EndingPeriod' became equal to "March 2024"
		And the form attribute named 'ReportPeriod' became equal to "January 2024"
		And the form attribute named 'RegulationVersion' became equal to "VA - Main regulations"
		And the form attribute named 'Scenario' became equal to "VA - Main scenario"
		And the form attribute named 'PeriodManagement' became equal to "January 2024 - March 2024 (Frequency: Month) <VA - Main scenario>"

	* Closing forms
		When "Document settings *" window is opened
		And I close "Document settings *" window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'
		Then '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		
	And I close current test client session

Scenario: 18.14 Checking indicator value adjustments for "Budgeting2"

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting2" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting2" login and '' password

	* Opening list with filters
		And In the command interface I select "Budgeting, reporting, and analysis" "Indicator value adjustment"
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I set filter in list form "Synthetic adjustment.Report type.Description" "Contains" "VA - Checking access settings"
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I add filter in list form "Deletion mark" "Equal to" "No"

	* Checking list composition
		Then I check table 'List' contains '3' rows from list:
			| "Company"  | "Scenario"               | "Adjustment template"                       | "Adjustment input method" |
			| "Mercury LLC" | "VA - Main scenario" | ""                                           | "Manual entry"                  |
			| "Venus LLC"   | "VA - Main scenario" | ""                                           | "Manual entry"                  |
			| "Mercury LLC" | "VA - Main scenario" | "VA - Checking access settings (some)" | "Manual entry"                  |
		
	* Removing filters
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I remove all filters in list form

Scenario: 18.15 Checking report instances for "Budgeting2"

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting2" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting2" login and '' password

	* Searching for report instances
		And In the command interface I select "Budgeting, reporting, and analysis" "Report instances"
		And I search element "VA - Checking access settings" "At the beginning of the line" by field "Report type" in list "Report instances"
		And I click Clear button of the field named 'SavedSetting'
		Then I check table 'List' contains "2" rows from list:
			| "Report type"                              | "Company"  | "Report period"  | "End period" | "Scenario"               | "State" | "Project"               | "Dimension 1"   | "Dimension 2" | "Dimension 3" | "Dimension 4" | "Dimension 5" | "Dimension 6" | "Primary currency" | "External infobase" |
			| "VA - Checking access settings (read)" | "Venus LLC"   | "January 2024" | "March 2024"     | "VA - Main scenario" | "Draft"  | "VA - Main project" | "Administration" | ''            | ''            | ''            | ''            | ''            | "RUB"             | ''           |
			| "VA - Checking access settings (record)" | "Mercury LLC" | "January 2024" | "March 2024"     | "VA - Main scenario" | "Draft"  | "VA - Main project" | "Administration" | ''            | ''            | ''            | ''            | ''            | "RUB"             | ''           |
	
	* Creating report for a company without access
		And I go to line in 'List' table:
			| "Report type"                              | "Company"  | "Report period"  | "End period" | "Scenario"               | "Project"               | "Dimension 1"   |
			| "VA - Checking access settings (record)" | "Mercury LLC" | "January 2024" | "March 2024"     | "VA - Main scenario" | "VA - Main project" | "Administration" |
		And I select context menu item named 'ListContextMenuCopy' of the form attribute named 'List'
		Then "Specify key document attributes" window is opened
		And I click Choice button of the field named 'Organization'
		And I select company "System LLC"
		And I click the button named 'FormApplyAndClose'
		Then "Specify key document attributes *" window is opened
		Then there are lines in TestClient message log
			|"The Budgeting2 user\nhas insufficient rights to view the VA - Checking access settings (no) template by the System LLC company.\nSelect another template."|
		When "Specify key document attributes *" window is opened
		And I close "Specify key document attributes *" window
		Then "Report instances" window is opened

Scenario: 18.16 Checking pivot table for user "Budgeting2"

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting2" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting2" login and '' password

	* Checking pivot table with write rights
		And In the command interface I select "Budgeting, reporting, and analysis" "Pivot table"
		Then "Pivot table: *" window is opened
		And I click the hyperlink named 'FilterHeading'
		And I input "" text in the field named 'Form'
		And I click Choice button of the field named 'Form'
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListRefresh'
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then "Find" window is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "At the beginning of the line"
		And I input "VA - Checking access settings (record)" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Report types and templates" window is opened
		And I go to line in 'List' table:
			| "Description"                                           |
			| "VA - Checking access settings (no) (pivot table)" |
		And I click the button named 'ListChoose'
		Then "Pivot table: *" window is opened
		And I click Choice button of the field named 'PivotTableVariant'
		Then "Pivol table options" window is opened
		And I select current line in 'List' table
		And I select "Main" exact value from the drop-down list named 'WorkMode'
		And I click the button named 'ChangePeriod'
		Then "Select period" window is opened
		And I input '1/1/2024' text in the field named 'DateBegin'
		And I move to the next attribute
		And I input '3/31/2024' text in the field named 'DateEnd'
		And I click the button named 'Select'
		Then I open pivot table for report type "VA - Checking access settings (no)"
		Then '$WindowTitle$' window is opened
		And I select 'RUB' exact value from the drop-down list named 'DisplayCurrency'
		And I select from the drop-down list named 'Item_Scenario'  by "VA - Main scenario" string
		And I select from the drop-down list named 'Item_Organization'  by "Mercury LLC" string
		And I select from the drop-down list named 'Item_Project'  by "VA - Main project" string
		And I select from "Company business units" drop-down list by "Administration" string
		And I click the button named 'UpdateTabData1'
		And I wait for '$WindowTitle$' form opening for 20 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_PivotTable_100.mxl'
		And I click the button named 'VersionsManagement'
		Then "Indicator version management" window is opened
		And I click the button named 'ListDeleteVersions'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Indicator version management *" window is opened
		And I close "Indicator version management *" window
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_PivotTable_20.mxl'
		And I enter value '100' in cell 'R4C2'
		And I click the button named 'Apply'
		Then '$WindowTitle$' window is opened
		And I click the button named 'UpdateTabData'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_PivotTable_100.mxl'

	* Checking pivot table without rights
		And I set pivot table filter 'Item_Organization' with value "Venus LLC"
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		And In the command interface I select "Budgeting, reporting, and analysis" "Pivot table"
		When '$WindowTitle$' window is opened
		And I wait the attribute named 'SpreadsheetFieldTemlate' unavailability in 20 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_NoAccess.mxl'

	* Checking pivot table with read rights
		When "Pivot table: *" window is opened
		And I click the hyperlink named 'FilterHeading'
		And I click Choice button of the field named 'Form'
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then "Find" window is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "At the beginning of the line"
		And I input "VA - Checking access settings (read)" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Report types and templates" window is opened
		And I go to line in 'List' table:
			| "Description"                                           |
			| "VA - Checking access settings (no) (pivot table)" |
		And I click the button named 'ListChoose'
		Then I open pivot table for report type "VA - Checking access settings (no)"
		And I click Choice button of the field named 'PivotTableVariant'
		Then "Pivol table options" window is opened
		And I select current line in 'List' table
		And I click the button named 'UpdateTabData1'
		And I wait for '$WindowTitle$' form opening for 20 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_PivotTable_100.mxl'
		And I enter value '200' in cell 'R4C3'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_PivotTable_100.mxl'

	And I close current test client session
								
Scenario: 18.17 Checking indicator value adjustments for "Budgeting3"

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password

	* Opening list with filters
		And In the command interface I select "Budgeting, reporting, and analysis" "Indicator value adjustment"
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I set filter in list form "Synthetic adjustment.Report type.Description" "Contains" "VA - Checking access settings"
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I add filter in list form "Deletion mark" "Equal to" "No"

	* Checking list composition
		Then I check table 'List' contains '2' rows from list:
			| "Company"  | "Scenario"               | "Adjustment template"                       | "Adjustment input method" |
			| "Mercury LLC" | "VA - Main scenario" | ""                                           | "Manual entry"                  |
			| "Mercury LLC" | "VA - Main scenario" | "VA - Checking access settings (some)" | "Manual entry"                  |

	* Opening document without access
		And I go to line in 'List' table:
			| "Company"  | "Scenario"               | "Adjustment template"                       | "Adjustment input method" |
			| "Mercury LLC" | "VA - Main scenario" | "VA - Checking access settings (some)" | "Manual entry"                  |
		And I select current line in 'List' table
		Then "Indicator value adjustment" window is opened
		Then there are lines in TestClient message log
			|"Insufficient access rights to view the document.\nCheck settings in Report type access matrix."|
		And I clear user message window
		And the field named 'ListContextMenuCancelPosting' does not exist on the form

	* Opening document with read access
		When "Indicator value adjustment" window is opened
		And I go to line in 'List' table:
			| "Company"  | "Scenario"               | "Adjustment template" | "Adjustment input method" |
			| "Mercury LLC" | "VA - Main scenario" | ""                     | "Manual entry"                  |
		And I select current line in 'List' table
		Then "Indicator value adjustment *" window is opened
		And the field named 'FormPostAndClose' does not exist on the form
		And I close "Indicator value adjustment *" window
		
	* Removing filters
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I remove all filters in list form

Scenario: 18.18 Checking report instances and settings form for "Budgeting3"
	
	Try
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password

	* Searching for report instances
		And In the command interface I select "Budgeting, reporting, and analysis" "Report instances"
		And I search element "VA - Checking access settings" "At the beginning of the line" by field "Report type" in list "Report instances"
		And I click Clear button of the field named 'SavedSetting'
		If '$$IsERPCPM$$' Then
			And I save "Administration" value to 'NameDepartment' variable
		Else
			And I save "<Object not found> (*)" value to 'NameDepartment' variable
		Then 'List' table became equal by template
			| "Report type"                              | "Company"  | "Report period"  | "End period" | "Scenario"               | "State" | "Project"               | "Dimension 1"        | "Dimension 2" | "Dimension 3" | "Dimension 4" | "Dimension 5" | "Dimension 6" | "Primary currency" | "External infobase" |
			| "VA - Checking access settings (record)" | "Mercury LLC" | "January 2024" | "March 2024"     | "VA - Main scenario" | "Draft"  | "VA - Main project" | '$NameDepartment$' | ''            | ''            | ''            | ''            | ''            | "RUB"             | ''           |
	
	* Opening document with read rights
		When "Report instances" window is opened
		And I select current line in 'List' table
		And I open report instance for report type "VA - Checking access settings (record)" currency "RUB" company "Mercury LLC" scenario "VA - Main scenario" frequency 'Month' project "VA - Main project" dimensions '$NameDepartment$' '' '' '' '' ''
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_100.mxl'
		And the field named 'EnableEdit' does not exist on the form
		When '$WindowTitle$' window is opened
		Try
			And I select "USD" exact value from the drop-down list named 'DisplayCurrency'
			And I click the button named 'WriteAndClose'
		Except
			And I click the button named 'FormOpenSettings'
	
	* Checking settings form
		When "Document settings" window is opened
		And I click Open button of the field named 'ReportKind'
		Then "VA - Checking access settings (record) (Report types)" window is opened
		And I close "VA - Checking access settings (record) (Report types)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'TemplateForReport'
		Then "Template VA - Checking access settings (no) report type: VA - Checking access settings (record)" window is opened
		And I close "Template VA - Checking access settings (no) report type: VA - Checking access settings (record)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'Project'
		Then "VA - Main project (Projects and phases)" window is opened
		And I close "VA - Main project (Projects and phases)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'Dimension1'
		If '$$IsERPCPM$$' Then
			When "Administration (Department)" window is opened
			And I close "Administration (Department)" window
		Else
			Then "1C:Enterprise" window is opened
			And I click the button named 'OK'
		Then "Document settings" window is opened
		And I click Open button of the field named 'Scenario'
		Then "Scenarios: VA - Main scenario (Scenarios)" window is opened
		And I close "Scenarios: VA - Main scenario (Scenarios)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'PeriodManagement'
		Then "January 2024 - March 2024 (Frequency: Month) <VA - Main scenario>" window is opened
		And I close "January 2024 - March 2024 (Frequency: Month) <VA - Main scenario>" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'Organization'
		Then "Mercury LLC (Business unit*)" window is opened
		And I close "Mercury LLC (Business unit*)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'RegulationVersion'
		Then "VA - Main regulations from * (Regulation for preparing reports)" window is opened
		And I close "VA - Main regulations from * (Regulation for preparing reports)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'MainCurrency'
		Then "RUB (Currency)" window is opened
		And I close "RUB (Currency)" window
		Then "Document settings" window is opened
		And I move to the tab named 'GroupPageReportSettings'
		And I click Open button of the field named 'ProcessingRule'
		Then "VA - Checking access settings (no) (Calculation rules)" window is opened
		And I close "VA - Checking access settings (no) (Calculation rules)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'ExternalInfobase'
		Then "Current infobase (External infobases)" window is opened
		And I close "Current infobase (External infobases)" window
		Then "Document settings" window is opened
		And I click Open button of the field named 'CheckRule'
		Then "VA - Checking access settings (no) (Check rules)" window is opened
		And I close "VA - Checking access settings (no) (Check rules)" window

	* Changing period
		Then "Document settings" window is opened
		Try
			And I click the button named 'ChangePeriod'
		Except
			And I close "Document settings" form

	When '$WindowTitle$' window is opened
	And I close '$WindowTitle$' window
		
Scenario: 18.19 Checking pivot table for user "Budgeting3"

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password

	* Checking pivot table with read rights
		And In the command interface I select "Budgeting, reporting, and analysis" "Pivot table"
		Then "Pivot table: *" window is opened
		And I click the hyperlink named 'FilterHeading'
		And I input "" text in the field named 'Form'
		And I click Choice button of the field named 'Form'
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListRefresh'
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then "Find" window is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "At the beginning of the line"
		And I input "VA - Checking access settings (record)" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Report types and templates" window is opened
		And I go to line in 'List' table:
			| "Description"                                           |
			| "VA - Checking access settings (no) (pivot table)" |
		And I click the button named 'ListChoose'
		Then "Pivot table: *" window is opened
		And I click Choice button of the field named 'PivotTableVariant'
		Then "Pivol table options" window is opened
		And I select current line in 'List' table
		And I select "Main" exact value from the drop-down list named 'WorkMode'
		And I click the button named 'ChangePeriod'
		Then "Select period" window is opened
		And I input '1/1/2024' text in the field named 'DateBegin'
		And I move to the next attribute
		And I input '3/31/2024' text in the field named 'DateEnd'
		And I click the button named 'Select'
		Then I open pivot table for report type "VA - Checking access settings (no)"
		Then '$WindowTitle$' window is opened
		And I select 'RUB' exact value from the drop-down list named 'DisplayCurrency'
		And I select from the drop-down list named 'Item_Scenario'  by "VA - Main scenario" string
		And I select from the drop-down list named 'Item_Organization'  by "Mercury LLC" string
		And I select from the drop-down list named 'Item_Project'  by "VA - Main project" string
		And I click the button named 'UpdateTabData1'
		And I wait for '$WindowTitle$' form opening for 20 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_PivotTable_Empty.mxl'
		And I enter value '100' in cell 'R4C2'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_PivotTable_Empty.mxl'

	* Checking pivot table without rights
		And I set pivot table filter 'Item_Organization' with value "Venus LLC"
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		And In the command interface I select "Budgeting, reporting, and analysis" "Pivot table"
		When '$WindowTitle$' window is opened
		And I wait the attribute named 'SpreadsheetFieldTemlate' unavailability in 20 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\18\VA_AccessSettingsCheck_NoAccess.mxl'

Scenario: 18.20 Interface test for user "Budgeting3" - Sections and functions panel

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password

	* Sections panel
		And section panel is equal to
			| "Quick menu" |
			| "Budgeting, reporting, and analysis" |

	* Functions panel
		If '$$IsERPCPM$$' Then
			And I save "Companies" value to 'NameCompany' variable
		Else
			And I save "Business units" value to 'NameCompany' variable
			
		When in sections panel I select "Budgeting, reporting, and analysis"
		And functions panel is equal to
			| "Report types and templates" | // Important
			| "Report instances" |
			| "Pivot table" |
			| "Reporting period management" | // Main
			| "Indicator version management" |
			| "Periodic exchange rates" |
			| "Indicator value adjustment" |
			| "Indicator value adjustments templates" |
			| "Budgeting classifiers" | // Subsystems
			| "Investment projects" |
			| "Reports" |
			| "Tools" |
			| "Regulations for preparing reports" | // Budgeting classifiers
			| "Scenarios" |
			| '$NameCompany$' |
			| "Periods" |
			| "Dimension types (corporate)" |
			| "Arbitrary classifier" |
			| "Projects and phases" | // Investment projects
			| "Organizational regulation structures" | // Reports
			| "Report on report indicator links" |
			| "Graphic report link report" |
			| "Network diagram of project group" |
			| "Copy report indicator values" | // Service
			| "Compare spreadsheet documents" |

	And I close current test client session

Scenario: 18.21 Interface test for user "Budgeting1" - Sections and functions panel

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Sections panel
		And section panel is equal to
			| "Quick menu" |
			| "Budgeting, reporting, and analysis" |

	* Functions panel
		If '$$IsERPCPM$$' Then
			And I save "Companies" value to 'NameCompany' variable
		Else
			And I save "Business units" value to 'NameCompany' variable

		When in sections panel I select "Budgeting, reporting, and analysis"
		And functions panel is equal to
			| "Report types and templates" | // Important
			| "Report instances" |
			| "Pivot table" |
			| "Reporting period management" | // Main
			| "Indicator version management" |
			| "Periodic exchange rates" |
			| "Indicator value adjustment" |
			| "Indicator value adjustments templates" |
			| "Budgeting classifiers" | // Subsystems
			| "Investment projects" |
			| "Reports" |
			| "Tools" |
			| "Regulations for preparing reports" | // Budgeting classifiers
			| "Scenarios" |
			| '$NameCompany$' |
			| "Periods" |
			| "Dimension types (corporate)" |
			| "Arbitrary classifier" |
			| "Projects and phases" | // Investment projects
			| "Document processing setting" | // Reports
			| "Organizational regulation structures" |
			| "Report instance matrix" | 		
			| "Report on report indicator links" |
			| "Graphic report link report" |
			| "Network diagram of project group" |
			| "Copy report indicator values" | // Service
			| "Compare spreadsheet documents" |	

Scenario: 18.22 Interface test for user "Budgeting1" - Personal settings

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	If '$$IsERPCPM$$' Then

		* User
			And In the command interface I select "Quick menu" "Personal settings"
			Then "My settings" window is opened
			And I click the button named 'UserInfo'
			Then "Budgeting1 (User)" window is opened
			And In this window I click command interface button "Setup options"
			And In this window I click command interface button "Access rights"
			And In this window I click command interface button "Settings"
			And I close "Budgeting1 (User)" window

		* My settings
			When "My settings" window is opened
			And I remove checkbox named 'AskConfirmationOnExit'
			And I close "My settings" window

		* My settings again
			And In the command interface I select "Quick menu" "Personal settings"
			Then the form attribute named 'AskConfirmationOnExit' became equal to "No"

		* Closing the form
			And I close "My settings" window

	Else

		* Personal settings
			And In the command interface I select "Quick menu" "Personal settings"
			When "Personal settings" window is opened

			And I select from the drop-down list named 'MainProjectCPM'  by "VA - Main project" string
			And I select from the drop-down list named 'MainCFRCPM'  by "Mercury LLC" string
			If 'NOT $$IsPerform$$' Then
				And I select from the drop-down list named 'MainCompany'  by "Mercury LLC" string
				And I select "20%" exact value from the drop-down list named 'MainVATRate'
				And I set checkbox named 'ShowGLAccountsInDocuments'
			And I remove checkbox named 'AskConfirmationOnExit'
			When "Personal settings *" window is opened
			And I click the button named 'FormWriteAndClose'
			And In the command interface I select "Quick menu" "Personal settings"
			Then the form attribute named 'AuthorizedUser' became equal to "Budgeting1"
			And the editing text of form attribute named 'CPMMainLanguage' became equal to "Main language"
			And the form attribute named 'MainProjectCPM' became equal to "VA - Main project"
			And the form attribute named 'MainCFRCPM' became equal to "Mercury LLC"
			If 'NOT $$IsPerform$$' Then
				And the form attribute named 'MainCompany' became equal to "Mercury LLC"
				// TODO: BP error
				//And the form element named 'MainVATRate' became equal to "20%"
				And the form attribute named 'ShowGLAccountsInDocuments' became equal to "Yes"
			Then the form attribute named 'AskConfirmationOnExit' became equal to "No"
			
		* User
			When "Personal settings" window is opened
			And I click the hyperlink named 'AuthorizedUser'
			Then "Budgeting1 (User)" window is opened
			And In this window I click command interface button "Setup options"
			If 'NOT $$IsPerform$$' Then
				And In this window I click command interface button "Contact persons"
			And In this window I click command interface button "Access rights"
			And In this window I click command interface button "Settings"
			And I close "Budgeting1 (User)" window

		* Proxy server
			Then "Personal settings" window is opened
			And I click the button named 'ProxyServerParameters'
			Then "Proxy server parameters" window is opened
			And I change the radio button named 'ProxyServerUseCases' value to "Do not use proxy server"
			And I click the button named 'OK'

		* Scanning settings
			Then "Personal settings" window is opened
			And I click the button named 'ScanningSettings'
			Then "Install add-in" window is opened
			And I click the button named 'Close'
		
		Then "Personal settings" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Personal settings" window closing in 20 seconds

Scenario: 18.23 Interface test for user "Budgeting1" - Report types, report instances, pivot table

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And In the command interface I select "Budgeting, reporting, and analysis" "Report types and templates"
	Then "Report types and templates" window is opened

	* Searching for report "VA - Checking access settings (record)"
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input "VA - Checking access settings (record)" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then the number of 'ReportKindList' table lines is "equal" 1
		
	* Unavailability of elements without rights
		When "Report types and templates" window is opened
		And the field named 'DoOpenDesigner' does not exist on the form
		And the field named 'CreateReportInstanceTemplate' does not exist on the form
		And the field named 'ListCreatePivotTabTemplate' does not exist on the form
		And the field named 'ListInstallMainTemplateOfReport' does not exist on the form
		
	* Template list
		And I go to line in 'List' table:
			| "Description"                         |
			| "VA - Checking access settings (no)" |
		And I click the button named 'MagazineForm'
		Then "Report instances" window is opened
		And I close "Report instances" window
		Then "Report types and templates" window is opened
		And I click the button named 'SwitchToDataDisplayMode'
		Then "VA - Checking access settings (no) (View mode)" window is opened
		And I close "VA - Checking access settings (no) (View mode)" window
		Then "Report types and templates" window is opened

	* Report instances list
		And in the table 'ReportKindList' I click the button named 'ReportKindListOpenInstancesList'
		Then "Report instances" window is opened
		And I set checkbox named 'UseScenario'
		And I click Choice button of the field named 'FilteringByScenario'
		Then "Value list" window is opened
		And I select "VA - Main scenario" by string from the drop-down list named 'Value' in 'ValueList' table
		And I click the button named 'OK'
		Then "Report instances" window is opened
		And I go to line in 'Companies' table:
			| "Value"    | "Use" |
			| "System LLC" | "No"          |
		And I expand current line in 'Companies' table
		And I go to line in 'Companies' table:
			| "Value"     | "Use" |
			| "Mercury LLC" | "No"          |
		And I set checkbox named 'CompaniesUse' in 'Companies' table
		Then 'List' table became equal
			| "Report type"                              | "Company"  | "Report period"  | "End period" | "Scenario"               | "State" | "Project"               | "Assignee" | "Approval" | "Dimension 1"   | "Dimension 2" | "Dimension 3" | "Dimension 4" | "Dimension 5" | "Dimension 6" | "Primary currency" | "External infobase" |
			| "VA - Checking access settings (record)" | "Mercury LLC" | "January 2024" | "March 2024"     | "VA - Main scenario" | "Draft"  | "VA - Main project" | ""            | ""             | "Administration" | ""            | ""            | ""            | ""            | ""            | "RUB"             | ""           |
	
	* Creating and copying
		And I click the button named 'FormCreate'
		Then "Specify key document attributes" window is opened
		And I close "Specify key document attributes" window
		And I click the button named 'FormCopy'
		Then "Specify key document attributes" window is opened
		And I close "Specify key document attributes" window
		Then "Report instances" window is opened
		
	* Approval
		Then "Report instances" window is opened
		And I click the button named 'FormCommonCommandUniversalApproval_ApprovalHistory'
		Then "Approval history" window is opened
		And I close "Approval history" window
		Then "Report instances" window is opened
		And I click the button named 'FormCommonCommandUniversalApproval_ApproveDocument'
		And I click the button named 'FormCommonCommandUniversalApproval_UndoApproval'
		And I click the button named 'FormCommonCommandUniversalApproval_AcceptForApproval'
		And I click the button named 'BatchEditAttributes'
		Then in the TestClient message log contains lines by template:
			|"Person responsible for approval of the * object is not specified in the responsibility assignment matrix. The Status field is available for editing. Set the required approval status manually"|
			|"Approval has not been initiated for object *."|
			|"No person responsible for approval is specified in the responsibility assignment matrix for *. Enter proper approval status manually."|
			|"Current user does not have the \"Superuser\" role for company \"Mercury LLC\""|
		And I click the button named 'FormCommonCommandUniversalApproval_ApprovalRoute'
		Then "Process management console" window is opened
		And I close "Process management console" window

	* Filling
		Then "Report instances" window is opened
		And I click the button named 'ImportOfData'
		And the field named 'FormProcessingProtocol' does not exist on the form
		Then "Report instances" window is opened
		And I select current line in 'List' table
		And I open report instance for report type "VA - Checking access settings (record)" currency "RUB" company "Mercury LLC" scenario "VA - Main scenario" frequency 'Month' project "VA - Main project" dimensions "Administration" '' '' '' '' ''
		And I close '$WindowTitle$' window

	* Report instances
		Then "Report instances" window is opened
		And I close "Report instances" window
		And In the command interface I select "Budgeting, reporting, and analysis" "Report instances"
		Then "Report instances" window is opened
		And I close "Report instances" window

	* Pivot table
		When in sections panel I select "Budgeting, reporting, and analysis"
		And In the command interface I select "Budgeting, reporting, and analysis" "Pivot table"
		Then "Pivot table: *" window is opened
		And I close "Pivot table: *" window
			
Scenario: 18.24 Interface test for user "Budgeting1" - Reporting period management

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And In the command interface I select "Budgeting, reporting, and analysis" "Reporting period management"

	* Checking list form
		Then "Reporting period management" window is opened
		And the field named 'PeriodsManagementForm' does not exist on the form
		And the field named 'FormOpenNextPeriod' does not exist on the form
		And the field named 'ProcessesManagementReportPreparation' does not exist on the form
		And the field named 'ReportingPreparationProcessChart' does not exist on the form
		
		And I find and select reporting period management document by scenario "VA - Main scenario" and start period "January 2024"
	
	* Checking element form
		Then I open period management document for scenario "VA - Main scenario" frequency "Month"
		And the field named 'Label_MainPage' exists on the form
		And 'Contents' table became equal
			| "Description"            |
			| "Main period data" |
			| "Setting"               |
			| "Exchange rates"             |
		And the field named 'ChangePeriod' does not exist on the form
		And I click the button named 'ReportOrganizationStructure'
		Then "Organizational structure briefly" window is opened
		And I close "Organizational structure briefly" window
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormGoForward'
		And the field named 'Label_ExchangeRates' exists on the form
		And the field named 'RatesTable_ChangeModeWithoutSave' does not exist on the form
		And form attribute named 'FormGoForward' is unavailable
		And I click the button named 'FormClose'
		Then "Reporting period management" window is opened
		And I close "Reporting period management" window
				
Scenario: 18.25 Interface test for user "Budgeting1" - Indicator value adjustment

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Opening list with filters
		And In the command interface I select "Budgeting, reporting, and analysis" "Indicator value adjustment"
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I set filter in list form "Synthetic adjustment.Report type.Description" "Contains" "VA - Checking access settings"
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I add filter in list form "Deletion mark" "Equal to" "No"

	* Opening the document
		When "Indicator value adjustment" window is opened
		And I go to line in 'List' table:
			| "Company"  | "Adjustment input method" | "Scenario"               | "Adjustment template" |
			| "Mercury LLC" | "Manual entry"                  | "VA - Main scenario" | ""                     |
		And I select current line in 'List' table
		Then "Indicator value adjustment *" window is opened
		And I close "Indicator value adjustment *" window

	* Checking approval buttons
		Then "Indicator value adjustment" window is opened
		And I click the button named 'FormCommonCommandUniversalApproval_ApprovalHistory'
		Then "Approval history" window is opened
		And I close "Approval history" window
		Then "Indicator value adjustment" window is opened
		And I click the button named 'FormCommonCommandUniversalApproval_ApproveDocument'
		And I click the button named 'FormCommonCommandUniversalApproval_UndoApproval'
		And I click the button named 'FormCommonCommandUniversalApproval_AcceptForApproval'
		Then in the TestClient message log contains lines by template:
			|"Person responsible for approval of the Indicator value adjustment * object is not specified in the responsibility assignment matrix. The Status field is available for editing. Set the required approval status manually"|
			|"Approval has not been initiated for object Indicator value adjustment *."|
			|"No person responsible for approval is specified in the responsibility assignment matrix for Indicator value adjustment *. Enter proper approval status manually."|
		And I click the button named 'FormCommonCommandUniversalApproval_ApprovalRoute'
		Then "Process management console" window is opened
		And I close "Process management console" window

	* Removing filters
		When "Indicator value adjustment" window is opened
		And I click the button named 'FormListSettings'
		And I remove all filters in list form

Scenario: 18.26 Interface test for user "Budgeting1" - Template for adjusting indicator values
	
	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And In the command interface I select "Budgeting, reporting, and analysis" "Indicator value adjustments templates"
	And I search element "VA - Checking access settings" "At the beginning of the line" by field "Description" in list "Indicator value adjustments templates"

	Then I check table 'List' contains '3' rows from list:
		| "Description"                               | "Comment" | "Balanced" | "Adjustment input method" | "Filter companies" |
		| "VA - Checking access settings (record)"    | ""            | "No"              | "Manual entry"                  | ""                  |
		| "VA - Checking access settings (some)" | ""            | "No"              | "Manual entry"                  | ""                  |
		| "VA - Checking access settings (read)"    | ""            | "No"              | "Manual entry"                  | ""                  |

	And I go to line in 'List' table:
		| "Description"                               | "Balanced" | "Adjustment input method" |
		| "VA - Checking access settings (some)" | "No"              | "Manual entry"                  |
	And I select current line in 'List' table

	Then "VA - Checking access settings (some) (Indicator value adjustments templates)" window is opened
	Then 'UsedReportTypes' table became equal by template
		| "Report type"                              |
		| "<Object not found> (*)"                  |
		| "VA - Checking access settings (record)" |
	
	And I click the button named 'FormDocumentIndicatorsValuesAdjustmentCreateBasedOn'
	Then "Indicator value adjustment (create)" window is opened
	Then the form attribute named 'TemplateOfAdjustment' became equal to "VA - Checking access settings (some)"
	And I close "Indicator value adjustment (create)" window

	Then "VA - Checking access settings (some) (Indicator value adjustments templates)" window is opened
	And I close "VA - Checking access settings (some) (Indicator value adjustments templates)" window
	
	Then "Indicator value adjustments templates" window is opened
	And I go to line in 'List' table:
		| "Description"                            | "Balanced" | "Adjustment input method" |
		| "VA - Checking access settings (read)" | "No"              | "Manual entry"                  |
	And I select current line in 'List' table

	Then "VA - Checking access settings (read) (Indicator value adjustments templates)" window is opened
	Then 'UsedReportTypes' table became equal
		| "Report type"                              |
		| "VA - Checking access settings (read)" |
	And 'TableOfAdjustments' table became equal
		| "Report type"                              | "Indicator"           |
		| "VA - Checking access settings (read)" | "ReportRow amount"   |
		| "VA - Checking access settings (read)" | "ReportRowX2 amount" |
	And I close "VA - Checking access settings (read) (Indicator value adjustments templates)" window
	
	Then "Indicator value adjustments templates" window is opened
	And I close "Indicator value adjustments templates" window
		
Scenario: 18.27 Interface test for user "Budgeting1" - Reporting preparation regulation
	
	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And In the command interface I select "Budgeting, reporting, and analysis" "Regulations for preparing reports"
	And I search element "VA - Main regulations" "At the beginning of the line" by field "Description" in list "Regulations for preparing reports"

	Then the number of 'List' table lines is "equal" 1

	When "Regulations for preparing reports" window is opened
	And I click the button named 'FormReportOrganizationalRegulationStructuresBusinessUnitChart'
	Then "Organizational structure briefly" window is opened
	Then 'ReportSpreadsheetDocument' spreadsheet document is equal
		| "System LLC (No, VA - Package CFR, RUB)" | '' | ''                                        |
		| ''                                       | '' | ''                                        |
		| ''                                       | '' | ''                                        |
		| ''                                       | '' | "Mars LLC (Yes, VA - Package CFR, RUB)"      |
		| ''                                       | '' | ''                                        |
		| ''                                       | '' | ''                                        |
		| ''                                       | '' | "Venus LLC (No, VA - Package CFR, RUB)"   |
		| ''                                       | '' | ''                                        |
		| ''                                       | '' | ''                                        |
		| ''                                       | '' | "Earth LLC (No, VA - Package CFR, RUB)"    |
		| ''                                       | '' | ''                                        |
		| ''                                       | '' | ''                                        |
		| ''                                       | '' | "Mercury LLC (No, VA - Package CFR, RUB)" |
	And I close "Organizational structure briefly" window

	Then "Regulations for preparing reports" window is opened
	And I click the button named 'FormReportOrganizationalRegulationStructuresBusinessUnitTable'
	When "Organizational structure briefly" window is opened
	Then 'ReportSpreadsheetDocument' spreadsheet document is equal
		| "Data parameters:"         | "Regulation version: VA - Main regulations" | ''                            | ''                                |
		| ''                        | "Display chart: No"                       | ''                            | ''                                |
		| ''                        | ''                                           | ''                            | ''                                |
		| "Business unit" | "Eliminating company"                  | "Business unit kind" | "Presentation currency" |
		| "System LLC"             | "No"                                        | "VA - Package CFR"              | "RUB"                             |
		| "Mars LLC"                | "Yes"                                         | "VA - Package CFR"              | "RUB"                             |
		| "Venus LLC"              | "No"                                        | "VA - Package CFR"              | "RUB"                             |
		| "Earth LLC"               | "No"                                        | "VA - Package CFR"              | "RUB"                             |
		| "Mercury LLC"            | "No"                                        | "VA - Package CFR"              | "RUB"                             |
	And I close "Organizational structure briefly" window
		
	And I select current line in 'List' table
	Then "VA - Main regulations from * (Regulation for preparing reports)" window is opened
	And I move to the tab named 'GroupMainPage'
	And I click the button named 'FormConfirmedReports'
	Then "Report instances" window is opened
	And I close "Report instances" window
	Then "VA - Main regulations from * (Regulation for preparing reports)" window is opened
	And I move to the tab named 'PerimeterSetting'
	Try
		And I click the button named 'FormWrite'
	Except
		And I close "VA - Main regulations from * (Regulation for preparing reports)" window
	
	When "Regulations for preparing reports" window is opened
	And I close "Regulations for preparing reports" window
			
Scenario: 18.28 Interface test for user "Budgeting1" - Scenarios

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And In the command interface I select "Budgeting, reporting, and analysis" "Scenarios"
	And I search element "VA - Main scenario" "At the beginning of the line" by field "Description" in list "Scenarios"

	Then the number of 'List' table lines is "equal" 1
	And I select current line in 'List' table

	Then "Scenarios: VA - Main scenario (Scenarios)" window is opened
	And I move to the tab named 'Budgeting'
	And I move to the tab named 'MainProperties'
	Try
		And I click the button named 'FormWrite'
	Except
		And I close "Scenarios: VA - Main scenario (Scenarios)" window

	When "Scenarios" window is opened
	And I close "Scenarios" window

Scenario: 18.29 Interface test for user "Budgeting1" - Companies

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	If '$$IsPerform$$' Then

		And In the command interface I select "Budgeting, reporting, and analysis" "Business units"
		Then "Business units" window is opened
	
		And I go to line in 'List' table:
			| "Description" | "Company type"    |
			| "System LLC"  | "Tax resident" |
		And I move one level down in 'List' table
		
		Then I check table 'List' contains '5' rows from list:
			| "Description" | "Company type"    |
			| "System LLC"  | "Tax resident" |
			| "Mars LLC"     | "Elimination"         |
			| "Earth LLC"    | "Financial responsibility center"                |
			| "Venus LLC"   | "Financial responsibility center"                |
			| "Mercury LLC" | "Tax resident" |

		And I go to line in 'List' table:
			| "Description" | "Company type"    |
			| "Mercury LLC" | "Tax resident" |

		And I select current line in 'List' table
		Then "Mercury LLC (Business unit)" window is opened
		And In this window I click command interface button "Bank accounts"
		And In this window I click command interface button "Departments"
		// TO DO: Currently not working
		//And In the current window I press the command interface button "Attachments"
		//And In the current window I press the command interface button "Accounting policy settings"
		And In this window I click command interface button "Stored files of business units"
		And I close "Mercury LLC (Business unit)" window

	ElseIf '$$IsERPCPM$$' Then

		And In the command interface I select "Budgeting, reporting, and analysis" "Companies"
		Then "Companies" window is opened

		Then I check table 'List' contains '5' rows from list:
			| "Description" | "Company type"       |
			| "Venus LLC"   | "Financial responsibility center"                   |
			| "Earth LLC"    | "Financial responsibility center"                   |
			| "Mars LLC"     | "Elimination"            |
			| "Mercury LLC" | "Russian tax resident" |
			| "System LLC"  | "Tax resident of the Russian Federation" |
		
		When "Companies" window is opened
		And I click the button named 'FormCommonCommandAdditionalInfoCommandBar'
		Then "Additional information records" window is opened
		And I close "Additional information records" window

		When "Companies" window is opened
		And I go to line in 'List' table:
			| "Description" | "Company type"       |
			| "Mercury LLC" | "Russian tax resident" |
		And I select current line in 'List' table

		Then "Mercury LLC (Business unit)" window is opened
		And In this window I click command interface button "Authorized signatories"
		And In this window I click command interface button "Bank accounts"
		And In this window I click command interface button "Company cash registers"
		And In this window I click command interface button "Tax authorities for profit tax by regions"
		// TO DO: Currently not working
		//And In the current window I press the command interface button "Accounting policy settings"
		And In this window I click command interface button "Stored files of business units"
		And I close "Mercury LLC (Business unit)" window

	ElseIf '$$IsCPM$$' Then

		And In the command interface I select "Budgeting, reporting, and analysis" "Business units"
		Then "Business units" window is opened

		Then I check table 'List' contains '5' rows from list:
			| "Name in the application" | "Company type"       |
			| "System LLC"              | "Russian tax resident" |
			| "Venus LLC"               | "Financial responsibility center"                   |
			| "Earth LLC"                | "Financial responsibility center"                   |
			| "Mars LLC"                 | "Elimination"            |
			| "Mercury LLC"             | "Russian tax resident" |

		And I go to line in 'List' table:
			| "Name in the application" | "Company type"       |
			| "Mercury LLC"             | "Russian tax resident" |
	
		And I click the button named 'FormUseAsMain'
		And I click the button named 'FormUseAsMain'
	
		And I click the button named 'PrintSubmenuRegular__Attributes'
		Then "Print details of Mercury LLC" window is opened
		And I close "Print details Mercury LLC" window

		Then "Business units" window is opened
		And I click the button named 'CommonCommandAttachedFiles'
		Then "Attachments: Mercury LLC" window is opened
		And I close "Attachments: Mercury LLC" window

		Then "Business units" window is opened
		When "Business units" window is opened
		And I click the button named 'CommonCommandAdditionalInfoCommandBar'
		Then "Additional information records" window is opened
		And I close "Additional information records" window

		Then "Business units" window is opened
		And I click the button named 'FormRegulatedManagementAccounting'
		Then I check table 'List' contains '2' rows from list:
			| "Name in the application" | "TIN" | "KPP" | "Company type"       |
			| "Mercury LLC"             | ""    | ""    | "Russian tax resident" |
			| "System LLC"              | ""    | ""    | "Russian tax resident" |
		And I click the button named 'FormRegulatedManagementAccounting'

		And I select current line in 'List' table
		Then "Mercury LLC (Business unit)" window is opened
		// TO DO: Currently not working
		//And In the current window I press the command interface button "Accounting policy settings"
		And In this window I click command interface button "Stored files of business units"
		And I close "Mercury LLC (Business unit)" window

Scenario: 18.30 Interface test for user "Budgeting1" - Periods

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And In the command interface I select "Budgeting, reporting, and analysis" "Periods"
	Then "Periods" window is opened
	
	And I go to line in 'List' table:
		| "Start date" | "End date" | "Description" | "Frequency" | "Arbitrary" |
		| "1/1/2024"  | "12/31/2024"     | "2024 year"    | "Year"           | "No"          |
	And I select current line in 'List' table
	Then "2024 year (Periods)" window is opened
	And I close "2024 year (Periods)" window

Scenario: 18.31 Interface test for user "Budgeting1" - Dimension types (corporate)

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And In the command interface I select "Budgeting, reporting, and analysis" "Dimension types (corporate)"
	And I search element "VA0" "At the beginning of the line" by field "Code" in list "Dimension types (corporate)"
	If '$$IsPerform$$' Then
		Then I check table 'List' contains '6' rows from list:
			| "Code"        | "Description"              | "Value type"                 | "Create if search failed during import" | "Update attributes during import" | "Divide by companies" |
			| "VA0Contrac" | "Counterparty contracts"     | "Contract"                      | "No"                                        | "No"                             | "No"                       |
			| "VA0Counter" | "Counterparties"               | "Counterparty"                   | "No"                                        | "No"                             | "No"                       |
			| "VA0Product" | "Product range"              | "Product range"                 | "No"                                        | "No"                             | "No"                       |
			| "VA0CFItems" | "Cash flow items"                | "Cash flow item" | "No"                                        | "No"                             | "No"                       |
			| "VA0IEItems" | "Income and expense items" | "Income and expense item"    | "No"                                        | "No"                             | "No"                       |
			| "VA0ProCate" | "Product categories"        | "Arbitrary classifier"   | "No"                                        | "No"                             | "No"                       |
	ElseIf '$$IsERPCPM$$' Then
		Then I check table 'List' contains '6' rows from list:
			| "Code"        | "Description"              | "Value type"                     | "Create if search failed during import" | "Update attributes during import" | "Divide by companies" |
			| "VA0Contrac" | "Counterparty contracts"     | "Contract with counterparty"           | "No"                                        | "No"                             | "No"                       |
			| "VA0Counter" | "Counterparties"               | "Counterparty"                       | "No"                                        | "No"                             | "No"                       |
			| "VA0Product" | "Product range"              | "Product range"                     | "No"                                        | "No"                             | "No"                       |
			| "VA0CFItems" | "Cash flow items"                | "Cash flow item" | "No"                                        | "No"                             | "No"                       |
			| "VA0IEItems" | "Income and expense items" | "Income and expense item"        | "No"                                        | "No"                             | "No"                       |
			| "VA0ProCate" | "Product categories"        | "Product categories"               | "No"                                        | "No"                             | "No"                       |
	ElseIf '$$IsCPM$$' Then
		Then I check table 'List' contains '6' rows from list:
			| "Code"        | "Description"              | "Value type"                 | "Create if search failed during import" | "Update attributes during import" | "Divide by companies" |
			| "VA0Contrac" | "Counterparty contracts"     | "Contract"                      | "No"                                        | "No"                             | "No"                       |
			| "VA0Counter" | "Counterparties"               | "Counterparty"                   | "No"                                        | "No"                             | "No"                       |
			| "VA0Product" | "Product range"              | "Product range"                 | "No"                                        | "No"                             | "No"                       |
			| "VA0CFItems" | "Cash flow items"                | "Cash flow item" | "No"                                        | "No"                             | "No"                       |
			| "VA0IEItems" | "Income and expense items" | "Income and expense item"    | "No"                                        | "No"                             | "No"                       |
			| "VA0ProCate" | "Product categories"        | "Product categories"           | "No"                                        | "No"                             | "No"                       |
	
	When "Dimension types (corporate)" window is opened
	And I go to line in 'List' table:
		| "Code"        | "Description" | "Update attributes during import" | "Divide by companies" | "Create if search failed during import" | "Value type" |
		| "VA0Product" | "Product range" | "No"                             | "No"                       | "No"                                        | "Product range" |
	And I select current line in 'List' table
	Then "Product range (Dimension types (corporate))" window is opened
	And In this window I click command interface button "Default dimension values"
	And In this window I click command interface button "Arbitrary classifier"
	And I close "Product range (Dimension types (corporate))" window
	Then "Dimension types (corporate)" window is opened
	And I close "Dimension types (corporate)" window

Scenario: 18.32 Interface test for user "Budgeting1" - Custom classifier

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And In the command interface I select "Budgeting, reporting, and analysis" "Arbitrary classifier"
	Then "Arbitrary classifier" window is opened

	If '$$IsERPCPM$$' Then
		And I select from the drop-down list named 'Owner'  by "Units of measure" string
	Else
		And I select from the drop-down list named 'Owner'  by "Staff kinds" string
	And I click Clear button of the field named 'Owner'

	If number of 'List' table lines is "more" 0 Then
		And I select current line in 'List' table
		Then "* (Arbitrary classifier)" window is opened
		And I close "* (Arbitrary classifier)" window

	Then "Arbitrary classifier" window is opened
	And I close "Arbitrary classifier" window

Scenario: 18.33 Interface test for user "Budgeting1" - Projects and stages

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	And In the command interface I select "Budgeting, reporting, and analysis" "Projects and phases"
	And I search element "VA - Main project" "Exact match" by field "Description" in list "Projects and phases"
	Then the number of 'List' table lines is "equal" 1
	
	And I click the button named 'ButtonIncExpBudget'
	Then "Pivot table: No options selected" window is opened
	And I close "Pivot table: No options selected" window

	Then "Projects and phases" window is opened
	And I click the button named 'ButtonCFBudget'
	Then "Pivot table: No options selected" window is opened
	And I close "Pivot table: No options selected" window

	Then "Projects and phases" window is opened
	And I click the button named 'ButtonIEBudget'
	Then "Pivot table: No options selected" window is opened
	And I close "Pivot table: No options selected" window

	Then "Projects and phases" window is opened
	And I select current line in 'List' table
	When "VA - Main project (Projects and phases)" window is opened
	And I close "VA - Main project (Projects and phases)" window

	When "Projects and phases" window is opened
	And I close "Projects and phases" window
			
Scenario: 18.34 Interface test for user "Budgeting1" - Report instances matrix

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Opening a report
		And In the command interface I select "Budgeting, reporting, and analysis" "Report instance matrix"
		Then "Report instance matrix" window is opened
		And I click the button named 'FormSettings'
		And I click Choice button of the field named 'PeriodManagement'
		And I find and select reporting period management document by scenario "VA - Main scenario" and start period "January 2024"
		
		Then "Report instance matrix" window is opened
		And I go to line in 'SettingsComposerSettingsFilter' table:
			| "Left value"  | "Application" | "Display mode" |
			| "Report type" | "No hierarchy" | "Quick access"    |
		And I set checkbox named 'SettingsComposerSettingsFilterUse' in 'SettingsComposerSettingsFilter' table
		And I activate field named 'SettingsComposerSettingsFilterComparisonType' in 'SettingsComposerSettingsFilter' table
		And I select "In group" exact value from the drop-down list named 'SettingsComposerSettingsFilterComparisonType' in 'SettingsComposerSettingsFilter' table
		And I activate field named 'SettingsComposerSettingsFilterRightValue' in 'SettingsComposerSettingsFilter' table
		And I select "VA - Checking access settings (group)" by string from the drop-down list named 'SettingsComposerSettingsFilterRightValue' in 'SettingsComposerSettingsFilter' table
		And I finish line editing in 'SettingsComposerSettingsFilter' table
		
		And I click the button named 'FormGenerate'

	* Verifying the result
		Then 'Result' spreadsheet document is equal
			| "Scenario: VA - Main scenario\nPeriod: January 2024 - March 2024\nFrequency: Month" | "Project"               | "Dimension1"                                                   | "Earth LLC" | "Mars LLC" | "Mercury LLC" | "System LLC" | "Venus LLC" |
			| ''                                                                                              | ''                     | ''                                                             | ''           | ''          | ''         | ''             | ''            |
			| "VA - Report group"                                                                           | ''                     | ''                                                             | ''           | ''          | ''         | ''             | ''            |
			| "VA - Checking access settings (group)"                                                       | ''                     | ''                                                             | ''           | ''          | ''         | ''             | ''            |
			| "VA - Checking access settings (read)"                                                         | ''                     | ''                                                             | ''           | ''          | ''         | ''             | ''            |
			| "VA - Checking access settings (read)"                                                         | ''                     | ''                                                             | ''           | ''          | ''         | ''             | ''            |
			| "VA - Checking access settings (read)"                                                         | "VA - Main project" | "Administration"                                                | ''           | ''          | ''         | ''             | ''            |
			| "VA - Checking access settings (record)"                                                     | ''                     | ''                                                             | ''           | ''          | ''         | ''             | ''            |
			| "VA - Checking access settings (record)"                                                     | ''                     | ''                                                             | ''           | ''          | ''         | ''             | ''            |
			| "VA - Checking access settings (record)"                                                     | "VA - Main project" | "Administration"                                                | ''           | ''          | ''         | ''             | ''            |
			| ''                                                                                              | ''                     | ''                                                             | ''           | ''          | ''         | ''             | ''            |
			| ''                                                                                              | ''                     | ''                                                             | ''           | ''          | ''         | ''             | ''            |
			| ''                                                                                              | ''                     | " - Report instance in the \"Not filled in\" state"              | ''           | ''          | ''         | ''             | ''            |
			| ''                                                                                              | ''                     | " - Report instance in the \"Draft\" state"                 | ''           | ''          | ''         | ''             | ''            |
			| ''                                                                                              | ''                     | " - Report instance in the \"Checked, pending approval\" state" | ''           | ''          | ''         | ''             | ''            |
			| ''                                                                                              | ''                     | " - Report instance in the \"Sent for revision\" state"   | ''           | ''          | ''         | ''             | ''            |
			| ''                                                                                              | ''                     | " - Report instance in the \"Confirmed\" state"                | ''           | ''          | ''         | ''             | ''            |
			| ''                                                                                              | ''                     | " - Report instance in the \"Filled in with errors\" state"      | ''           | ''          | ''         | ''             | ''            |
			| ''                                                                                              | "X"                    | " - This dimension is not used for the report type"          | ''           | ''          | ''         | ''             | ''            |

	* Closing a report WITHOUT saving the variant
		Then "Report instance matrix" window is opened
		And I close "Report instance matrix" window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 18.35 Interface test for user "Budgeting1" - Document processing configuration

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Opening a report
		And In the command interface I select "Budgeting, reporting, and analysis" "Document processing setting"
		Then "Document processing setting" window is opened
		And I click the button named 'FormSettings'
		And I select from the drop-down list named 'RegulationVersion'  by "VA - Main regulations" string
		When "Document processing setting" window is opened
		And I click Choice button of the field named 'PeriodManagement'
		And I find and select reporting period management document by scenario "VA - Main scenario" and start period "January 2024"

		When "Document processing setting" window is opened
		And I go to line in 'SettingsComposerSettingsFilter' table:
			| "Left value"  | "Application" | "Display mode" |
			| "Report type" | "No hierarchy" | "Quick access"    |
		And I set checkbox named 'SettingsComposerSettingsFilterUse' in 'SettingsComposerSettingsFilter' table
		And I activate field named 'SettingsComposerSettingsFilterComparisonType' in 'SettingsComposerSettingsFilter' table
		And I select "In group" exact value from the drop-down list named 'SettingsComposerSettingsFilterComparisonType' in 'SettingsComposerSettingsFilter' table
		And I activate field named 'SettingsComposerSettingsFilterRightValue' in 'SettingsComposerSettingsFilter' table
		And I select "VA - Checking access settings (group)" by string from the drop-down list named 'SettingsComposerSettingsFilterRightValue' in 'SettingsComposerSettingsFilter' table
		And I finish line editing in 'SettingsComposerSettingsFilter' table

		And I go to line in 'SettingsComposerSettingsFilter' table:
			| "Left value"                                 | "Application" | "Display mode" |
			| "Indicator value adjustment template" | "No hierarchy" | "Quick access"    |
		And I set checkbox named 'SettingsComposerSettingsFilterUse' in 'SettingsComposerSettingsFilter' table
		And I finish line editing in 'SettingsComposerSettingsFilter' table

		And I go to line in 'SettingsComposerSettingsFilter' table:
			| "Left value"         | "Application" | "Display mode" |
			| "Translation template" | "No hierarchy" | "Quick access"    |
		And I set checkbox named 'SettingsComposerSettingsFilterUse' in 'SettingsComposerSettingsFilter' table
		And I finish line editing in 'SettingsComposerSettingsFilter' table

		And I go to line in 'SettingsComposerSettingsFilter' table:
			| "Left value"                              | "Application" | "Display mode" |
			| "Transformational adjustment template" | "No hierarchy" | "Quick access"    |
		And I set checkbox named 'SettingsComposerSettingsFilterUse' in 'SettingsComposerSettingsFilter' table
		And I finish line editing in 'SettingsComposerSettingsFilter' table
		
		And I click the button named 'FormGenerate'

	* Verifying the result
		Then 'Result' spreadsheet document is equal
			| "Document template / Company"          | ''            | ''            | ''                      | "Earth LLC"                                              | "Mars LLC"                                               | "Mercury LLC"                                           | "System LLC"                                            | "Venus LLC"                                             |
			| ''                                        | "Project"      | "Dimension1"  | ''                      | ''                                                       | ''                                                       | ''                                                       | ''                                                       | ''                                                       |
			| "VA - Checking access settings (read)"   | ''            | ''            | ''                      | ''                                                       | ''                                                       | ''                                                       | ''                                                       | ''                                                       |
			| ''                                        | "< By all >" | "< By all >" | "Template to show" | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   |
			| ''                                        | ''            | ''            | "Pivot table template" | "VA - Checking access settings (no) (pivot table)" | "VA - Checking access settings (no) (pivot table)" | "VA - Checking access settings (no) (pivot table)" | "VA - Checking access settings (no) (pivot table)" | "VA - Checking access settings (no) (pivot table)" |
			| ''                                        | ''            | ''            | "Processing rule"     | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   |
			| ''                                        | ''            | ''            | "Check rule"      | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   |
			| ''                                        | ''            | ''            | "Generation method"   | 'By processing rule'                                   | 'By processing rule'                                   | 'By processing rule'                                   | 'By processing rule'                                   | 'By processing rule'                                   |
			| "VA - Checking access settings (record)" | ''            | ''            | ''                      | ''                                                       | ''                                                       | ''                                                       | ''                                                       | ''                                                       |
			| ''                                        | "< By all >" | "< By all >" | "Template to show" | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   |
			| ''                                        | ''            | ''            | "Pivot table template" | "VA - Checking access settings (no) (pivot table)" | "VA - Checking access settings (no) (pivot table)" | "VA - Checking access settings (no) (pivot table)" | "VA - Checking access settings (no) (pivot table)" | "VA - Checking access settings (no) (pivot table)" |
			| ''                                        | ''            | ''            | "Processing rule"     | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   |
			| ''                                        | ''            | ''            | "Check rule"      | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   | "VA - Checking access settings (no)"                   |
			| ''                                        | ''            | ''            | "Generation method"   | 'By processing rule'                                   | 'By processing rule'                                   | 'By processing rule'                                   | 'By processing rule'                                   | 'By processing rule'                                   |
		
	* Closing a report WITHOUT saving the variant
		When "Document processing setting" window is opened
		And I close "Document processing setting" window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 18.36 Interface test for user "Budgeting1" - Organizational structures of the regulation

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Opening a report
		And In the command interface I select "Budgeting, reporting, and analysis" "Organizational regulation structures"
		Then "Organizational structure briefly" window is opened
		And I select from the drop-down list named 'SettingsComposerUserSettingsItem0Value'  by "VA - Main regulations" string
		And I click the button named 'GenerateReport'

	* Verifying the result
		Then 'ReportSpreadsheetDocument' spreadsheet document is equal
			| "Data parameters:"              | "Regulation version: VA - Main regulations" | ''                            | ''                                |
			| ''                        | "Display chart: No"                       | ''                            | ''                                |
			| ''                        | ''                                           | ''                            | ''                                |
			| "Business unit" | "Eliminating company"                  | "Business unit kind" | "Presentation currency" |
			| "System LLC"             | "No"                                        | "VA - Package CFR"              | "RUB"                             |
			| "Mars LLC"                | "Yes"                                         | "VA - Package CFR"              | "RUB"                             |
			| "Venus LLC"              | "No"                                        | "VA - Package CFR"              | "RUB"                             |
			| "Earth LLC"               | "No"                                        | "VA - Package CFR"              | "RUB"                             |
			| "Mercury LLC"            | "No"                                        | "VA - Package CFR"              | "RUB"                             |
		
	And I close "Organizational structure briefly" window

Scenario: 18.37 Interface test for user "Budgeting1" - Report on report indicator links

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Opening a report
		And In the command interface I select "Budgeting, reporting, and analysis" "Report on report indicator links"
		Then "Report on report indicator links" window is opened
		And in the table 'MainReports' I click the button named 'MainReportsAdd'
		And I click choice button of the attribute named 'MainReportsReportKind' in 'MainReports' table
		And I search and select element "VA - Checking access settings (record)" "Exact match" by field "Description" in list "Report types"
		And in the table 'MainReports' I click the button named 'FormGenerate'
		
	And I close "Report on report indicator links" window

Scenario: 18.38 Interface test for user "Budgeting1" - Report on links between reports

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Opening a report
		And In the command interface I select "Budgeting, reporting, and analysis" "Graphic report link report"
		Then "Report links report" window is opened
		And in the table 'ReportsTableBox' I click the button named 'ReportsTableBoxAdd'
		And I click choice button of the attribute named 'ReportsTableBoxReport' in 'ReportsTableBox' table
		And I search and select element "VA - Checking access settings (record)" "Exact match" by field "Description" in list "Report types"
		And I finish line editing in 'ReportsTableBox' table
		And in the table 'ReportsTableBox' I click the button named 'Generate'
		
	And I close "Report links report" window

Scenario: 18.39 Interface test for user "Budgeting1" - Network diagram of a project group

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Opening a report
		And In the command interface I select "Budgeting, reporting, and analysis" "Network diagram of project group"
		Then "Network diagram of project group" window is opened
		And in 'SpreadsheetDocumentField' spreadsheet document I move to "R1C1" cell
		And I click the button named 'FormGenerate'
		
	And I close "Network diagram of project group" window
			
Scenario: 18.40 Interface test for user "Budgeting1" - Copying report indicator values
		
	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Copying report indicator data
		And In the command interface I select "Budgeting, reporting, and analysis" "Copy report indicator values"
		Then "Copy report indicator values" window is opened
	
	And I close "Copy report indicator values" window

Scenario: 18.41 Interface test for user "Budgeting1" - Comparison of tabular documents

	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Comparison of tabular documents
		And In the command interface I select "Budgeting, reporting, and analysis" "Compare spreadsheet documents"
		Then "Compare spreadsheet documents" window is opened
	
	And I close "Compare spreadsheet documents" window
				