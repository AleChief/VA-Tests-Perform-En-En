#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 02. Checking pivot table operation

	As Administrator I want to
	Check creation and operation of pivot tables

Background:

	And I close all client application windows

Scenario: 02.00 Determining application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 02.01 Creating a report type

	* Creating a report type
		And I create report type with name "VA - Recalculation in context" and parent "VA - Report group"
		And I open report type with name "VA - Recalculation in context"

	* Refining a report type
		And I change checkbox named 'IsChangeTrackingEnabled'
		And I move to the tab named 'DimensionsOfReport'
		And I select from the drop-down list named 'DimensionKind1'  by "VA0CFItems" string
		And I move to the tab named 'Main'
		And I click the button named 'RecordButtonForm'
		Then "Data restructuring" window is opened
		And I click the button named 'FormOK'
	
	* Configuring report type structure
		And I click the button named 'EditTree'
		And I add row with name "Total" in report wizard
		And I add row with name "Goods" in report wizard
		And I add column with name "Count" in report wizard
		And I add column with name "ZoomRatio" in report wizard
		And I add column with name "Total" in report wizard
		And I add column with name "Date" in report wizard
		And I add column with name "String" in report wizard

	* Changing indicator types
		And I change indicator property 'NonFinancial' to "False" in cell 'R2C3' in report wizard
		And I change indicator property 'ValueType' to "Date" in cell 'R2C5' in report wizard
		And I change indicator property 'TotalKind' to "Maximum" in cell 'R2C5' in report wizard
		And I change indicator property 'ValueType' to "Date" in cell 'R3C5' in report wizard
		And I change indicator property 'TotalKind' to "Minimum" in cell 'R3C5' in report wizard
		And I change indicator property 'NonFinancial' to "True" in cell 'R3C3' in report wizard
		And I change indicator properties 'ValueType' to "Line" in cell 'R2C6:R3C6' in report wizard

	* Setting dimensions
		And I add dimension with code "VA0Product" in cell 'R3C3' in report wizard

	* Entering calculation formulas
		When "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C4' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'ButtonMultiply'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C4' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'ButtonMultiply'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C5' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C5' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'
		And I close "Report wizard" window

Scenario: 02.02 Creating templates for a report type

	And I create default template for report type "VA - Recalculation in context"
	
	And I for report type "VA - Recalculation in context" create default pivot table template with filters "Cash flow items"

	And I open default pivot table template for report type "VA - Recalculation in context"
	And I click the button named 'ShowTableSettingsByAxes'
	Then "Set up field location" window is opened
	And I go to line in 'TableRows1' table:
		| "Horizontally (in rows)" |
		| "Product range"               |
	And I select current line in 'TableRows1' table
	Then "Dimension display parameters (Product range)" window is opened
	And I click Choice button of the field named 'DCSettingsOrderSettings'
	Then "Edit order" window is opened
	And I go to line in 'Data' table:
		| "Use" | "Field"                      |
		| "Yes"            | "Product range.Description" |
	And I select "Product range.Product ID" exact value from the drop-down list named 'DataField' in 'Data' table
	And I finish line editing in 'Data' table
	And I click the button named 'OK'
	Then "Dimension display parameters (Product range)" window is opened
	And I click the button named 'FormApply'
	Then "Set up field location" window is opened
	And I click the button named 'ButtonApply'
	When '$WindowTitle$' window is opened
	And I click the button named 'FormWriteAndClose'
	And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 02.03 Creating a new scenario for indexing

	And I create scenario with name "VA - Script for indexing"
	And I set value "True" for attribute 'AllocationScenario' on tab 'Budgeting' for scenario "VA - Script for indexing"

	* Period management document
		And In the command interface I select "Budgeting, reporting, and analysis" "Reporting period management"
		Then "Reporting period management" window is opened
		And I click the button named 'FormCreate'
		Then "Reporting period management (create)" window is opened
		And I select from the drop-down list named 'Scenario'  by "VA - Script for indexing" string
		And I select "Month" exact value from the drop-down list named 'ScenarioFrequency'
		And I click the button named 'ChangePeriod'
		Then "Select period" window is opened
		And I input '1/1/2024' text in the field named 'DateBegin'
		And I move to the next attribute
		And I input '3/31/2024' text in the field named 'DateEnd'
		And I click the button named 'Select'
		Then "Reporting period management (create) *" window is opened
		And I select from the drop-down list named 'OrganizationalStructureVersion'  by "VA - Main regulations" string
		And I click the button named 'FormGoForward'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		And I save form header as 'FormCaption' variable
		Then '$FormCaption$' window is opened
		And I fill exchange rates table in scenario period management
		And I click the button named 'FormGoForward'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		When '$FormCaption$' window is opened
		And I click the button named 'FormGoForward'
		* Closing a period
			And I click the button named 'PeriodsManagement1'
			Then "Manage period lock duration and indicator updates" window is opened
			And in 'SpreadsheetFieldPeriodsManagement' spreadsheet document I move to 'R6C2' cell
			And I click the button named 'ClosePeriod'
			And I close "Manage period lock duration and indicator updates" window
		Then '$FormCaption$' window is opened
		And I click the button named 'FormClose'

Scenario: 02.04 Configuring rights for user "Budgeting1"

	And I add right "Read, write" for report type "VA - Recalculation in context" user "Budgeting1" for all companies
	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 02.05 Entering data into a pivot table

	* Opening a pivot table
		And I open report pivot table with name "VA - Recalculation in context"
		And I set pivot table filters: start date '1/1/2024', end date '3/31/2024', currency 'RUB', scenario "VA - Main scenario", company "Mercury LLC"
		And I set pivot table filter "VA0CFItems" with value "3Software sale"
		
	* Entering values manually
		And I add values with indicator expansion in cell 'R5C2'
			| "VA0Product"                                                     | 'Value1' |
			| "1C:ERP. Corporate performance management"                                   | '10.00000'  |
			| "2C:Corporation"                                                  | '20.00000'  |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '30.00000'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '40.00000'  |
			| "5C:Corporate performance management"                                      | '50.00000'  |		
		
		And I enter value '2.00000' in cell 'R6C3'
		And I enter value '1/1/2024' in cell 'R6C5'
		And I enter value "Line1" in cell 'R6C6'
	
	* Copying values by column
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C3' cell
		And I click the button named 'CopyDataByColumn'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C5' cell
		And I click the button named 'CopyDataByColumn'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C6' cell
		And I click the button named 'CopyDataByColumn'
	
	* Copying and pasting values
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2:R10C6' cell
		And I click the button named 'CopyIntoClipboard'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C7:R10C11' cell
		And I click the button named 'PasteFromClipboard1'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''     | ''     | ''       | "TOTAL"      | ''            | ''      | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total" | "Date" | "String" | "Count" | "ZoomRatio" | "Total"  | "Date"       | "String" |
			| "Total"                                                           | '150'            | '10'          | '1,500' | '1/1/2024' | ''        | '150'             | '10'          | '1,500' | '1/1/2024' | ''        | '0'            | '0'           | '0'    | ''     | ''       | '300'        | '20'          | '3,000' | '1/1/2024' | ''       |
			| "Goods"                                                         | '150'            | '10'          | '300'   | '1/1/2024' | ''        | '150'             | '10'          | '300'   | '1/1/2024' | ''        | '0'            | '0'           | '0'    | ''     | ''       | '300'        | '20'          | '600'   | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '50'             | '2'           | '100'   | '1/1/2024' | "Line1" | '50'              | '2'           | '100'   | '1/1/2024' | "Line1" | '0'            | '0'           | '0'    | ''     | ''       | '100'        | '4'           | '200'   | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '20'             | '2'           | '40'    | '1/1/2024' | "Line1" | '20'              | '2'           | '40'    | '1/1/2024' | "Line1" | '0'            | '0'           | '0'    | ''     | ''       | '40'         | '4'           | '80'    | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '40'             | '2'           | '80'    | '1/1/2024' | "Line1" | '40'              | '2'           | '80'    | '1/1/2024' | "Line1" | '0'            | '0'           | '0'    | ''     | ''       | '80'         | '4'           | '160'   | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '10'             | '2'           | '20'    | '1/1/2024' | "Line1" | '10'              | '2'           | '20'    | '1/1/2024' | "Line1" | '0'            | '0'           | '0'    | ''     | ''       | '20'         | '4'           | '40'    | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '30'             | '2'           | '60'    | '1/1/2024' | "Line1" | '30'              | '2'           | '60'    | '1/1/2024' | "Line1" | '0'            | '0'           | '0'    | ''     | ''       | '60'         | '4'           | '120'   | '1/1/2024' | ''       |

	* Entering values again
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C10' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '1/1/2024'
		When '$WindowTitle$' window is opened
		And I click the button named 'CopyDataByColumn'
		When '$WindowTitle$' window is opened
		And I click the button named 'CopyDataByColumn'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C11' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text "Line1"
		When '$WindowTitle$' window is opened
		And I click the button named 'CopyDataByColumn'
	
	* Copying values by row
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C7:R10C7' cell
		And I click the button named 'CopyDataByRow'
		When '$WindowTitle$' window is opened
		And I click the button named 'CopyDataByRow'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C8:R10C8' cell
		And I click the button named 'CopyDataByRow'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C10:R10C10' cell
		And I click the button named 'CopyDataByRow'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C11:R10C11' cell
		And I click the button named 'CopyDataByRow'

	* Changing indicators
		* To percentage
			When '$WindowTitle$' window is opened
			And I change value to '100.00000' percent in cell 'R6C7:R10C8'
			Then '$WindowTitle$' window is opened
			And I change value to '200.00000' percent in cell 'R6C12:R10C12'
			* Non-numeric
				Then '$WindowTitle$' window is opened
				And I change value to '100.00000' percent in cell 'R6C6:R10C6'
		* To value
			Then '$WindowTitle$' window is opened
			And I change value to '4.00000' in cell 'R6C13:R10C13'
			* Non-numeric
				When '$WindowTitle$' window is opened
				And I change value to '200.00000' in cell 'R6C5:R10C5'

	* Clearing indicators
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2:R10C16' cell
		And I click the button named 'ClearRange'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)" | "January 2024" | ''            | ''     | ''     | ''       | "February 2024" | ''            | ''     | ''     | ''       | "March 2024" | ''            | ''     | ''     | ''       | "TOTAL"      | ''            | ''     | ''     | ''       |
			| "VA - Recalculation in context (pivot table)" | "Count"     | "ZoomRatio" | "Total" | "Date" | "String" | "Count"      | "ZoomRatio" | "Total" | "Date" | "String" | "Count"   | "ZoomRatio" | "Total" | "Date" | "String" | "Count" | "ZoomRatio" | "Total" | "Date" | "String" |
			| "Total"                                        | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |
			| "Goods"                                      | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |

	* Cancel button
		When '$WindowTitle$' window is opened
		And I repeat 24 times
			And I click the button named 'CancelAction'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)" | "January 2024" | ''            | ''     | ''     | ''       | "February 2024" | ''            | ''     | ''     | ''       | "March 2024" | ''            | ''     | ''     | ''       | "TOTAL"      | ''            | ''     | ''     | ''       |
			| "VA - Recalculation in context (pivot table)" | "Count"     | "ZoomRatio" | "Total" | "Date" | "String" | "Count"      | "ZoomRatio" | "Total" | "Date" | "String" | "Count"   | "ZoomRatio" | "Total" | "Date" | "String" | "Count" | "ZoomRatio" | "Total" | "Date" | "String" |
			| "Total"                                        | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |
			| "Goods"                                      | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |

	* Repeat action button
		And I repeat 23 times
			And I click the button named 'RetryAction'

	* Undo from list
		When '$WindowTitle$' window is opened
		And I click the button named 'CancelApplyDetailed'
		Then "Action history" window is opened
		And I select all lines of 'Transactions_' table
		And I click the button named 'FormApply'
		And I wait for '$WindowTitle$' form opening for 20 seconds
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)" | "January 2024" | ''            | ''     | ''     | ''       | "February 2024" | ''            | ''     | ''     | ''       | "March 2024" | ''            | ''     | ''     | ''       | "TOTAL"      | ''            | ''     | ''     | ''       |
			| "VA - Recalculation in context (pivot table)" | "Count"     | "ZoomRatio" | "Total" | "Date" | "String" | "Count"      | "ZoomRatio" | "Total" | "Date" | "String" | "Count"   | "ZoomRatio" | "Total" | "Date" | "String" | "Count" | "ZoomRatio" | "Total" | "Date" | "String" |
			| "Total"                                        | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |
			| "Goods"                                      | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |

	* Repeat action
		When '$WindowTitle$' window is opened
		And I click the button named 'RetryAction'

	* Complex sequence of undo / repeat action
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
		When '$WindowTitle$' window is opened
		And I click the button named 'CancelAction'
		And I click the button named 'RetryAction'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C5' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '2/2/2024'
		When '$WindowTitle$' window is opened
		And I click the button named 'CancelAction'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Drill down indicators: *" window is opened
		Then I check table 'IndicatorsDrilldown' contains '5' rows from list:
			| "Product range"                                                   | 'Value1' |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '40'        |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '30'        |
			| "5C:Corporate performance management"                                      | '100'       |
			| "2C:Corporation"                                                  | '20'        |
			| "1C:ERP. Corporate performance management"                                   | '10'        |
					
		And I click the button named 'FormCancel'
		Then '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Drill down indicators: *" window is opened
		And I go to line in 'IndicatorsDrilldown' table:
			| "Product range"              | 'Value1' |
			| "5C:Corporate performance management" | '100'       |
		And I input '10.00000' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		And I finish line editing in 'IndicatorsDrilldown' table
		And I click the button named 'FormOKButton'

	* Setting comments
		When '$WindowTitle$' window is opened
		And I enter comment "First cell" in cell 'R6C2'
		Then '$WindowTitle$' window is opened
		And I enter comment "Last cell" in cell 'R10C5'
		Then '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
		And I select context menu item named 'SpreadsheetFieldTemlateContextMenuInsertNote' of the form attribute named 'SpreadsheetFieldTemlate'
		Then "Comments" window is opened
		And I input "First cell 2" text in the field named 'NewComment'
		And I click the button named 'WriteComment'
		Then '$WindowTitle$' window is opened
		And I click the button named 'LeaveCommentToIndicator'
		Then form element named "CommentsHistory" became equal to by template
			|'* (*): '      |
			|"First cell"|
			|'* (*): '        |
			|"First cell 2"|
		And the form attribute named 'NewComment' became equal to ''
		When "Comments" window is opened
		And I close "Comments" window

	* Undo / repeat action buttons with comments
		Then '$WindowTitle$' window is opened
		And I click the button named 'CancelAction'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
		And I click the button named 'LeaveCommentToIndicator'
		Then "Comments" window is opened
		Then form element named "CommentsHistory" became equal to by template
			|'* (*): '|
			|"First cell"|				
		And I close "Comments" window
		And I click the button named 'CancelAction'
		And I click the button named 'CancelAction'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
		And I click the button named 'LeaveCommentToIndicator'
		Then "Comments" window is opened
		Then the form attribute named 'CommentsHistory' became equal to ''
		And I close "Comments" window
		When '$WindowTitle$' window is opened
		And I click the button named 'RetryAction'
		And I click the button named 'RetryAction'
		And I click the button named 'RetryAction'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
		And I select context menu item named 'SpreadsheetFieldTemlateContextMenuInsertNote' of the form attribute named 'SpreadsheetFieldTemlate'
		Then form element named "CommentsHistory" became equal to by template
			|'* (*): '      |
			|"First cell"|
			|'* (*): '        |
			|"First cell 2"|		
		When "Comments" window is opened
		And I input "First cell 3" text in the field named 'NewComment'
		And I click the button named 'WriteComment'

	* Saving indicator values
		When '$WindowTitle$' window is opened
		And I click the button named 'Apply'
		And I wait for "Pivot table: *" form opening for 20 seconds

	* Comparing the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''       | ''           | ''        | "TOTAL"      | ''            | ''       | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"   | "Date"       | "String" |
			| "Total"                                                           | '110'            | '10'          | '1,100' | '1/1/2024' | ''        | '300'             | '20'          | '6,000' | '1/1/2024' | ''        | '450'          | '30'          | '13,500' | '1/1/2024' | ''        | '860'        | '60'          | '20,600' | '1/1/2024' | ''       |
			| "Goods"                                                         | '110'            | '10'          | '220'   | '1/1/2024' | ''        | '300'             | '20'          | '1,200' | '1/1/2024' | ''        | '450'          | '30'          | '2,700'  | '1/1/2024' | ''        | '860'        | '60'          | '4,120'  | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '10'             | '2'           | '20'    | '1/1/2024' | "Line1" | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'    | '1/1/2024' | "Line1" | '260'        | '12'          | '1,320'  | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '20'             | '2'           | '40'    | '1/1/2024' | "Line1" | '40'              | '4'           | '160'   | '1/1/2024' | "Line1" | '60'           | '6'           | '360'    | '1/1/2024' | "Line1" | '120'        | '12'          | '560'    | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '40'             | '2'           | '80'    | '1/1/2024' | "Line1" | '80'              | '4'           | '320'   | '1/1/2024' | "Line1" | '120'          | '6'           | '720'    | '1/1/2024' | "Line1" | '240'        | '12'          | '1,120'  | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '10'             | '2'           | '20'    | '1/1/2024' | "Line1" | '20'              | '4'           | '80'    | '1/1/2024' | "Line1" | '30'           | '6'           | '180'    | '1/1/2024' | "Line1" | '60'         | '12'          | '280'    | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '30'             | '2'           | '60'    | '1/1/2024' | "Line1" | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'    | '1/1/2024' | "Line1" | '180'        | '12'          | '840'    | '1/1/2024' | ''       |

Scenario: 02.06 Export and import from Excel

	* Opening a pivot table
		And I open report pivot table with name "VA - Recalculation in context"
		
	* Loading reference file
		When '$WindowTitle$' window is opened
		And I click the button named 'ImportFromMSExcel'
		Then "Import from Excel" window is opened
		And I input "$ProjectPath$\3_Budgeting\Layouts\02\VA_ContextBasedRecalculationReference_En.xlsx" text in the field named 'ExistingFile'
		And I wait the field named 'SheetName' will be filled in 30 seconds
		Then the form attribute named 'SheetName' became equal to 'TDSheet'
		And I click the button named 'Load'
		And I wait for '$WindowTitle$' form opening for 30 seconds
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''       | ''           | ''        | "TOTAL"      | ''            | ''       | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"   | "Date"       | "String" |
			| "Total"                                                           | '150'            | '10'          | '1,500' | '1/1/2024' | ''        | '300'             | '20'          | '6,000' | '1/1/2024' | ''        | '450'          | '30'          | '13,500' | '1/1/2024' | ''        | '900'        | '60'          | '21,000' | '1/1/2024' | ''       |
			| "Goods"                                                         | '150'            | '10'          | '300'   | '1/1/2024' | ''        | '300'             | '20'          | '1,200' | '1/1/2024' | ''        | '450'          | '30'          | '2,700'  | '1/1/2024' | ''        | '900'        | '60'          | '4,200'  | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '10'             | '2'           | '20'    | '1/1/2024' | "Line1" | '20'              | '4'           | '80'    | '1/1/2024' | "Line1" | '30'           | '6'           | '180'    | '1/1/2024' | "Line1" | '60'         | '12'          | '280'    | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '20'             | '2'           | '40'    | '1/1/2024' | "Line1" | '40'              | '4'           | '160'   | '1/1/2024' | "Line1" | '60'           | '6'           | '360'    | '1/1/2024' | "Line1" | '120'        | '12'          | '560'    | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | "Line1" | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'    | '1/1/2024' | "Line1" | '180'        | '12'          | '840'    | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '40'             | '2'           | '80'    | '1/1/2024' | "Line1" | '80'              | '4'           | '320'   | '1/1/2024' | "Line1" | '120'          | '6'           | '720'    | '1/1/2024' | "Line1" | '240'        | '12'          | '1,120'  | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'   | '1/1/2024' | "Line1" | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'    | '1/1/2024' | "Line1" | '300'        | '12'          | '1,400'  | '1/1/2024' | ''       |
 		And I click the button named 'Apply'

	* Exporting values to file
		When '$WindowTitle$' window is opened
		And I click the button named 'SaveAsExcel'
		Then "Save in Excel" window is opened
		And I change the radio button named 'SavingOption' value to "Create new file"
		And I input "$ProjectPath$\3_Budgeting\Layouts\02" text in the field named 'Directory'
		And I input "VA_ContextRecalculateInitial" text in the field named 'ExistingFile'
		And I input "Sheet_123" text in the field named 'SheetName'
		And I click the button named 'Save'
		Затем я жду, что в сообщениях пользователю будет подстрока "saved successfully" в течение 60 секунд		
		And I clear user message window

	* Loading prepared file
		When '$WindowTitle$' window is opened
		And I click the button named 'ImportFromMSExcel'
		Then "Import from Excel" window is opened
		And I input "$ProjectPath$\3_Budgeting\Layouts\02\VA_ContextBasedRecalculationPrepared_En.xlsx" text in the field named 'ExistingFile'
		And I wait the field named 'SheetName' will be filled in 30 seconds
		Then the form attribute named 'SheetName' became equal to 'TDSheet'
		And I click the button named 'Load'
		And I wait for '$WindowTitle$' form opening for 30 seconds
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''       | ''           | ''         | "February 2024" | ''            | ''       | ''           | ''         | "March 2024" | ''            | ''     | ''     | ''       | "TOTAL"      | ''            | ''       | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"   | "Date"       | "String"   | "Count"      | "ZoomRatio" | "Total"   | "Date"       | "String"   | "Count"   | "ZoomRatio" | "Total" | "Date" | "String" | "Count" | "ZoomRatio" | "Total"   | "Date"       | "String" |
			| "Total"                                                           | '800'            | '60'          | '48,000' | '1/3/2024' | ''         | '600'             | '80'          | '48,000' | '2/2/2024' | ''         | '0'            | '0'           | '0'    | ''     | ''       | '1,400'      | '140'         | '96,000' | '2/2/2024' | ''       |
			| "Goods"                                                         | '800'            | '60'          | '16,000' | ''           | ''         | '600'             | '80'          | '16,000' | ''           | ''         | '0'            | '0'           | '0'    | ''     | ''       | '1,400'      | '140'         | '32,000' | ''           | ''       |
			| "5C:Corporate performance management"                                      | '100'            | '20'          | '2,000'  | '1/1/2024' | "Line11" | '200'             | '0'           | '0'      | ''           | ''         | '0'            | '0'           | '0'    | ''     | ''       | '300'        | '20'          | '2,000'  | ''           | ''       |
			| "2C:Corporation"                                                  | '200'            | '20'          | '4,000'  | '1/2/2024' | "Line12" | '400'             | '40'          | '16,000' | '2/2/2024' | "Line22" | '0'            | '0'           | '0'    | ''     | ''       | '600'        | '60'          | '20,000' | ''           | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '500'            | '20'          | '10,000' | '1/3/2024' | "Line13" | '0'               | '40'          | '0'      | ''           | "Line23" | '0'            | '0'           | '0'    | ''     | ''       | '500'        | '60'          | '10,000' | ''           | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0'              | '0'           | '0'      | ''           | ''         | '0'               | '0'           | '0'      | ''           | ''         | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'      | ''           | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '0'              | '0'           | '0'      | ''           | ''         | '0'               | '0'           | '0'      | ''           | ''         | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'      | ''           | ''       |

	* Loading source file
		When '$WindowTitle$' window is opened
		And I click the button named 'ImportFromMSExcel'
		Then "Import from Excel" window is opened
		And I input "$ProjectPath$\3_Budgeting\Layouts\02\VA_ContextRecalculateInitial.xlsx" text in the field named 'ExistingFile'
		And I wait the field named 'SheetName' will be filled in 30 seconds
		Then the form attribute named 'SheetName' became equal to "Sheet_123"
		And I click the button named 'Load'
		And I wait for '$WindowTitle$' form opening for 30 seconds
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''       | ''           | ''        | "TOTAL"      | ''            | ''       | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"   | "Date"       | "String" |
			| "Total"                                                           | '150'            | '10'          | '1,500' | '1/1/2024' | ''        | '300'             | '20'          | '6,000' | '1/1/2024' | ''        | '450'          | '30'          | '13,500' | '1/1/2024' | ''        | '900'        | '60'          | '21,000' | '1/1/2024' | ''       |
			| "Goods"                                                         | '150'            | '10'          | '300'   | '1/1/2024' | ''        | '300'             | '20'          | '1,200' | '1/1/2024' | ''        | '450'          | '30'          | '2,700'  | '1/1/2024' | ''        | '900'        | '60'          | '4,200'  | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '10'             | '2'           | '20'    | '1/1/2024' | "Line1" | '20'              | '4'           | '80'    | '1/1/2024' | "Line1" | '30'           | '6'           | '180'    | '1/1/2024' | "Line1" | '60'         | '12'          | '280'    | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '20'             | '2'           | '40'    | '1/1/2024' | "Line1" | '40'              | '4'           | '160'   | '1/1/2024' | "Line1" | '60'           | '6'           | '360'    | '1/1/2024' | "Line1" | '120'        | '12'          | '560'    | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | "Line1" | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'    | '1/1/2024' | "Line1" | '180'        | '12'          | '840'    | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '40'             | '2'           | '80'    | '1/1/2024' | "Line1" | '80'              | '4'           | '320'   | '1/1/2024' | "Line1" | '120'          | '6'           | '720'    | '1/1/2024' | "Line1" | '240'        | '12'          | '1,120'  | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'   | '1/1/2024' | "Line1" | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'    | '1/1/2024' | "Line1" | '300'        | '12'          | '1,400'  | '1/1/2024' | ''       |

Scenario: 02.07 Testing indicator input form

	And I open report pivot table with name "VA - Recalculation in context"

	* Opening edit form, display settings
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C1' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Drill down indicators: *" window is opened
		And I check table 'IndicatorsDrilldown' contains '5' rows from list:
			| "Product range"                                                   | 'Period_1_Value1' | 'Period_1_Value2' | 'Period_1_Value3' | 'Period_1_Value4' | 'Period_1_Value5' | 'Period_2_Value1' | 'Period_2_Value2' | 'Period_2_Value3' | 'Period_2_Value4' | 'Period_2_Value5' | 'Period_3_Value3' | 'Period_3_Value1' | 'Period_3_Value2' | 'Period_3_Value4' | 'Period_3_Value5' |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30.00000'           | '2.00000'            | '60.00000'           | '1/1/2024'         | "Line1"            | '60.00000'           | '4.00000'            | '240.00000'          | '1/1/2024'         | "Line1"            | '540.00000'          | '90.00000'           | '6.00000'            | '1/1/2024'         | "Line1"            |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50.00000'           | '2.00000'            | '100.00000'          | '1/1/2024'         | "Line1"            | '100.00000'          | '4.00000'            | '400.00000'          | '1/1/2024'         | "Line1"            | '900.00000'          | '150.00000'          | '6.00000'            | '1/1/2024'         | "Line1"            |
			| "5C:Corporate performance management"                                      | '10.00000'           | '2.00000'            | '20.00000'           | '1/1/2024'         | "Line1"            | '20.00000'           | '4.00000'            | '80.00000'           | '1/1/2024'         | "Line1"            | '180.00000'          | '30.00000'           | '6.00000'            | '1/1/2024'         | "Line1"            |
			| "2C:Corporation"                                                  | '20.00000'           | '2.00000'            | '40.00000'           | '1/1/2024'         | "Line1"            | '40.00000'           | '4.00000'            | '160.00000'          | '1/1/2024'         | "Line1"            | '360.00000'          | '60.00000'           | '6.00000'            | '1/1/2024'         | "Line1"            |
			| "1C:ERP. Corporate performance management"                                   | '40.00000'           | '2.00000'            | '80.00000'           | '1/1/2024'         | "Line1"            | '80.00000'           | '4.00000'            | '320.00000'          | '1/1/2024'         | "Line1"            | '720.00000'          | '120.00000'          | '6.00000'            | '1/1/2024'         | "Line1"            |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownPeriodsInColumns'
		And I check table 'IndicatorsDrilldown' contains '15' rows from list:
			| "Report period"   | "Product range"                                                   | 'Value1' | 'Value3' | 'Value2' | 'Value4'  | 'Value5' |
			| "January 2024"  | "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30.00000'  | '60.00000'  | '2.00000'   | '1/1/2024' | "Line1"   |
			| "January 2024"  | "3C:Enterprise 8 CORP. Client license for 100 users" | '50.00000'  | '100.00000' | '2.00000'   | '1/1/2024' | "Line1"   |
			| "January 2024"  | "5C:Corporate performance management"                                      | '10.00000'  | '20.00000'  | '2.00000'   | '1/1/2024' | "Line1"   |
			| "January 2024"  | "2C:Corporation"                                                  | '20.00000'  | '40.00000'  | '2.00000'   | '1/1/2024' | "Line1"   |
			| "January 2024"  | "1C:ERP. Corporate performance management"                                   | '40.00000'  | '80.00000'  | '2.00000'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '60.00000'  | '240.00000' | '4.00000'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "3C:Enterprise 8 CORP. Client license for 100 users" | '100.00000' | '400.00000' | '4.00000'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "5C:Corporate performance management"                                      | '20.00000'  | '80.00000'  | '4.00000'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "2C:Corporation"                                                  | '40.00000'  | '160.00000' | '4.00000'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "1C:ERP. Corporate performance management"                                   | '80.00000'  | '320.00000' | '4.00000'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '90.00000'  | '540.00000' | '6.00000'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "3C:Enterprise 8 CORP. Client license for 100 users" | '150.00000' | '900.00000' | '6.00000'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "5C:Corporate performance management"                                      | '30.00000'  | '180.00000' | '6.00000'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "2C:Corporation"                                                  | '60.00000'  | '360.00000' | '6.00000'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "1C:ERP. Corporate performance management"                                   | '120.00000' | '720.00000' | '6.00000'   | '1/1/2024' | "Line1"   |
		And the form attribute named 'Accuracy' became equal to '0'
		And the editing text of form attribute named 'Divisor' became equal to "units"
		And I input '5' text in the field named 'Accuracy'
		And I select "thousands" exact value from the drop-down list named 'Divisor'
		And I check table 'IndicatorsDrilldown' contains '15' rows from list:
			| "Report period"   | "Product range"                                                   | 'Value1' | 'Value3' | 'Value2' | 'Value4'  | 'Value5' |
			| "January 2024"  | "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '0.03000'   | '0.06000'   | '0.00200'   | '1/1/2024' | "Line1"   |
			| "January 2024"  | "3C:Enterprise 8 CORP. Client license for 100 users" | '0.05000'   | '0.10000'   | '0.00200'   | '1/1/2024' | "Line1"   |
			| "January 2024"  | "5C:Corporate performance management"                                      | '0.01000'   | '0.02000'   | '0.00200'   | '1/1/2024' | "Line1"   |
			| "January 2024"  | "2C:Corporation"                                                  | '0.02000'   | '0.04000'   | '0.00200'   | '1/1/2024' | "Line1"   |
			| "January 2024"  | "1C:ERP. Corporate performance management"                                   | '0.04000'   | '0.08000'   | '0.00200'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '0.06000'   | '0.24000'   | '0.00400'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "3C:Enterprise 8 CORP. Client license for 100 users" | '0.10000'   | '0.40000'   | '0.00400'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "5C:Corporate performance management"                                      | '0.02000'   | '0.08000'   | '0.00400'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "2C:Corporation"                                                  | '0.04000'   | '0.16000'   | '0.00400'   | '1/1/2024' | "Line1"   |
			| "February 2024" | "1C:ERP. Corporate performance management"                                   | '0.08000'   | '0.32000'   | '0.00400'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '0.09000'   | '0.54000'   | '0.00600'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "3C:Enterprise 8 CORP. Client license for 100 users" | '0.15000'   | '0.90000'   | '0.00600'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "5C:Corporate performance management"                                      | '0.03000'   | '0.18000'   | '0.00600'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "2C:Corporation"                                                  | '0.06000'   | '0.36000'   | '0.00600'   | '1/1/2024' | "Line1"   |
			| "March 2024"    | "1C:ERP. Corporate performance management"                                   | '0.12000'   | '0.72000'   | '0.00600'   | '1/1/2024' | "Line1"   |
		And the form attribute named 'Accuracy' became equal to '5'
		And the editing text of form attribute named 'Divisor' became equal to "thousands"
		And I click the button named 'FormOKButton'
				
	* Table mode by periods
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C1' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Drill down indicators: *" window is opened
		And I check table 'IndicatorsDrilldown' contains '5' rows from list:
			| "Product range"                                                   | 'Period_1_Value1' | 'Period_1_Value2' | 'Period_1_Value3' | 'Period_1_Value4' | 'Period_1_Value5' | 'Period_2_Value1' | 'Period_2_Value2' | 'Period_2_Value3' | 'Period_2_Value4' | 'Period_2_Value5' | 'Period_3_Value1' | 'Period_3_Value2' | 'Period_3_Value3' | 'Period_3_Value4' | 'Period_3_Value5' |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30.00000'           | '2.00000'            | '60.00000'           | '1/1/2024'         | "Line1"            | '60.00000'           | '4.00000'            | '240.00000'          | '1/1/2024'         | "Line1"            | '90.00000'           | '6.00000'            | '540.00000'          | '1/1/2024'         | "Line1"            |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50.00000'           | '2.00000'            | '100.00000'          | '1/1/2024'         | "Line1"            | '100.00000'          | '4.00000'            | '400.00000'          | '1/1/2024'         | "Line1"            | '150.00000'          | '6.00000'            | '900.00000'          | '1/1/2024'         | "Line1"            |
			| "5C:Corporate performance management"                                      | '10.00000'           | '2.00000'            | '20.00000'           | '1/1/2024'         | "Line1"            | '20.00000'           | '4.00000'            | '80.00000'           | '1/1/2024'         | "Line1"            | '30.00000'           | '6.00000'            | '180.00000'          | '1/1/2024'         | "Line1"            |
			| "2C:Corporation"                                                  | '20.00000'           | '2.00000'            | '40.00000'           | '1/1/2024'         | "Line1"            | '40.00000'           | '4.00000'            | '160.00000'          | '1/1/2024'         | "Line1"            | '60.00000'           | '6.00000'            | '360.00000'          | '1/1/2024'         | "Line1"            |
			| "1C:ERP. Corporate performance management"                                   | '40.00000'           | '2.00000'            | '80.00000'           | '1/1/2024'         | "Line1"            | '80.00000'           | '4.00000'            | '320.00000'          | '1/1/2024'         | "Line1"            | '120.00000'          | '6.00000'            | '720.00000'          | '1/1/2024'         | "Line1"            |

	* Deleting dimension
		And I go to line in 'IndicatorsDrilldown' table:
			| "Product range"  |
			| "2C:Corporation" |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I go to line in 'IndicatorsDrilldown' table:
			| "Product range"                 |
			| "1C:ERP. Corporate performance management" |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I click the button named 'FormOKButton'
		When '$WindowTitle$' window is opened
		And I click the button named 'FormRowsWithValues'
		And I click the button named 'FormColumnsWithValues'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''     | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''      | ''           | ''        | "TOTAL"      | ''            | ''      | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total" | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"  | "Date"       | "String" |
			| "Total"                                                           | '90'             | '6'           | '540'  | '1/1/2024' | ''        | '180'             | '12'          | '2,160' | '1/1/2024' | ''        | '270'          | '18'          | '4,860' | '1/1/2024' | ''        | '540'        | '36'          | '7,560' | '1/1/2024' | ''       |
			| "Goods"                                                         | '90'             | '6'           | '180'  | '1/1/2024' | ''        | '180'             | '12'          | '720'   | '1/1/2024' | ''        | '270'          | '18'          | '1,620' | '1/1/2024' | ''        | '540'        | '36'          | '2,520' | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '10'             | '2'           | '20'   | '1/1/2024' | "Line1" | '20'              | '4'           | '80'    | '1/1/2024' | "Line1" | '30'           | '6'           | '180'   | '1/1/2024' | "Line1" | '60'         | '12'          | '280'   | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'   | '1/1/2024' | "Line1" | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'   | '1/1/2024' | "Line1" | '180'        | '12'          | '840'   | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'  | '1/1/2024' | "Line1" | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'   | '1/1/2024' | "Line1" | '300'        | '12'          | '1,400' | '1/1/2024' | ''       |

	* Adding dimensions
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C1' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Drill down indicators: *" window is opened
		* Clearing the "String" field
			And I go to line in 'IndicatorsDrilldown' table:
				| "Product range"                                         |
				| "4C:Enterprise 8.3 CORP. Server License (x86-64)" |
			And I input '' text in the field named 'Period_1_Value5' of 'IndicatorsDrilldown' table
			And I go to line in 'IndicatorsDrilldown' table:
				| "Product range"                                                   |
				| "3C:Enterprise 8 CORP. Client license for 100 users" |
			And I input '' text in the field named 'Period_1_Value5' of 'IndicatorsDrilldown' table
			And I go to line in 'IndicatorsDrilldown' table:
				| "Product range"              |
				| "5C:Corporate performance management" |
			And I input '' text in the field named 'Period_1_Value5' of 'IndicatorsDrilldown' table
		* Adding rows
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
			And I select "2C:Corporation" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
			And I input '50.00000' text in the field named 'Period_1_Value1' of 'IndicatorsDrilldown' table
			And I input '2.00000' text in the field named 'Period_1_Value2' of 'IndicatorsDrilldown' table
			And I input '1/1/2024' text in the field named 'Period_1_Value4' of 'IndicatorsDrilldown' table
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
			And I select "5C:Corporate performance management" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
			And I select "5C:Corporate performance management" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
			And I input '20.00000' text in the field named 'Period_1_Value1' of 'IndicatorsDrilldown' table
			And I input '1/31/2024' text in the field named 'Period_1_Value4' of 'IndicatorsDrilldown' table
		* Verifying the result
			And I click the button named 'FormOKButton'
			When '$WindowTitle$' window is opened
			Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''       | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''      | ''           | ''        | "TOTAL"      | ''            | ''      | ''           | ''       |
				| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String" | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"  | "Date"       | "String" |
				| "Total"                                                           | '160'            | '8'           | '1,280' | '1/31/2024' | ''       | '180'             | '12'          | '2,160' | '1/1/2024' | ''        | '270'          | '18'          | '4,860' | '1/1/2024' | ''        | '610'        | '38'          | '8,300' | '1/31/2024' | ''       |
				| "Goods"                                                         | '160'            | '8'           | '320'   | '1/1/2024' | ''       | '180'             | '12'          | '720'   | ''           | ''        | '270'          | '18'          | '1,620' | ''           | ''        | '610'        | '38'          | '2,660' | ''           | ''       |
				| "5C:Corporate performance management"                                      | '30'             | '2'           | '60'    | '1/31/2024' | ''       | '20'              | '4'           | '80'    | ''           | ''        | '30'           | '6'           | '180'   | ''           | ''        | '80'         | '12'          | '320'   | ''           | ''       |
				| "2C:Corporation"                                                  | '50'             | '2'           | '100'   | '1/1/2024' | ''       | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '50'         | '2'           | '100'   | ''           | ''       |
				| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | ''       | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'   | '1/1/2024' | "Line1" | '180'        | '12'          | '840'   | '1/1/2024' | ''       |
				| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'   | '1/1/2024' | ''       | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'   | '1/1/2024' | "Line1" | '300'        | '12'          | '1,400' | '1/1/2024' | ''       |

	* Opening form for a single period (Quantity)
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Drill down indicators: *" window is opened
		Then I check table 'IndicatorsDrilldown' contains '4' rows from list:
			| "Product range"                                                   | 'Value1' |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'        |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'        |
			| "5C:Corporate performance management"                                      | '30'        |
			| "2C:Corporation"                                                  | '50'        |
		And I go to line in 'IndicatorsDrilldown' table:
			| "Product range"  |
			| "2C:Corporation" |
		And I input '70.00000' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
		And I select "5C:Corporate performance management" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
		And I input '20.00000' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		And I click the button named 'FormButtonApply'
		And I click the button named 'FormCancel'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''       | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''      | ''           | ''        | "TOTAL"      | ''            | ''      | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String" | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"  | "Date"       | "String" |
			| "Total"                                                           | '200'            | '8'           | '1,600' | '1/31/2024' | ''       | '180'             | '12'          | '2,160' | '1/1/2024' | ''        | '270'          | '18'          | '4,860' | '1/1/2024' | ''        | '650'        | '38'          | '8,620' | '1/31/2024' | ''       |
			| "Goods"                                                         | '200'            | '8'           | '400'   | '1/1/2024' | ''       | '180'             | '12'          | '720'   | ''           | ''        | '270'          | '18'          | '1,620' | ''           | ''        | '650'        | '38'          | '2,740' | ''           | ''       |
			| "5C:Corporate performance management"                                      | '50'             | '2'           | '100'   | '1/31/2024' | ''       | '20'              | '4'           | '80'    | ''           | ''        | '30'           | '6'           | '180'   | ''           | ''        | '100'        | '12'          | '360'   | ''           | ''       |
			| "2C:Corporation"                                                  | '70'             | '2'           | '140'   | '1/1/2024' | ''       | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '70'         | '2'           | '140'   | ''           | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | ''       | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'   | '1/1/2024' | "Line1" | '180'        | '12'          | '840'   | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'   | '1/1/2024' | ''       | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'   | '1/1/2024' | "Line1" | '300'        | '12'          | '1,400' | '1/1/2024' | ''       |

	* Opening form for a single period (Date)
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R5C5" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Drill down indicators: *" window is opened
		Then I check table 'IndicatorsDrilldown' contains '4' rows from list:
			| "Product range"                                                   | 'Value1'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '1/1/2024' |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '1/1/2024' |
			| "5C:Corporate performance management"                                      | '1/31/2024' |
			| "2C:Corporation"                                                  | '1/1/2024' |
		* Changing empty value
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
			And I select "1C:ERP. Corporate performance management" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
			And I input '2/5/2024' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		* Changing existing value
			And I go to line in 'IndicatorsDrilldown' table:
				| "Product range"  |
				| "2C:Corporation" |
			And I input '2/5/2024' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		* Adding new value
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
			And I select "5C:Corporate performance management" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
			And I input '2/5/2024' text in the field named 'Value1' of 'IndicatorsDrilldown' table
			And I finish line editing in 'IndicatorsDrilldown' table
		And I click the button named 'FormOKButton'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''       | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''      | ''           | ''        | "TOTAL"      | ''            | ''      | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String" | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"  | "Date"       | "String" |
			| "Total"                                                           | '200'            | '8'           | '1,600' | '2/5/2024' | ''       | '180'             | '12'          | '2,160' | '1/1/2024' | ''        | '270'          | '18'          | '4,860' | '1/1/2024' | ''        | '650'        | '38'          | '8,620' | '2/5/2024' | ''       |
			| "Goods"                                                         | '200'            | '8'           | '400'   | '1/1/2024' | ''       | '180'             | '12'          | '720'   | ''           | ''        | '270'          | '18'          | '1,620' | ''           | ''        | '650'        | '38'          | '2,740' | ''           | ''       |
			| "5C:Corporate performance management"                                      | '50'             | '2'           | '100'   | '2/5/2024' | ''       | '20'              | '4'           | '80'    | ''           | ''        | '30'           | '6'           | '180'   | ''           | ''        | '100'        | '12'          | '360'   | ''           | ''       |
			| "2C:Corporation"                                                  | '70'             | '2'           | '140'   | '2/5/2024' | ''       | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '70'         | '2'           | '140'   | ''           | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | ''       | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'   | '1/1/2024' | "Line1" | '180'        | '12'          | '840'   | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0'              | '0'           | '0'     | '2/5/2024' | ''       | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '0'          | '0'           | '0'     | '2/5/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'   | '1/1/2024' | ''       | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'   | '1/1/2024' | "Line1" | '300'        | '12'          | '1,400' | '1/1/2024' | ''       |

	* Opening form for a single period (String)
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R5C6" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Drill down indicators: *" window is opened
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
		And I select "5C:Corporate performance management" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
		And I input 'String2' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
		And I select "5C:Corporate performance management" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
		And I input 'String3' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		And I click the button named 'FormOKButton'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''      | ''           | ''        | "TOTAL"      | ''            | ''      | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"  | "Date"       | "String" |
			| "Total"                                                           | '200'            | '8'           | '1,600' | '2/5/2024' | ''        | '180'             | '12'          | '2,160' | '1/1/2024' | ''        | '270'          | '18'          | '4,860' | '1/1/2024' | ''        | '650'        | '38'          | '8,620' | '2/5/2024' | ''       |
			| "Goods"                                                         | '200'            | '8'           | '400'   | '1/1/2024' | ''        | '180'             | '12'          | '720'   | ''           | ''        | '270'          | '18'          | '1,620' | ''           | ''        | '650'        | '38'          | '2,740' | ''           | ''       |
			| "5C:Corporate performance management"                                      | '50'             | '2'           | '100'   | '2/5/2024' | 'String3' | '20'              | '4'           | '80'    | ''           | ''        | '30'           | '6'           | '180'   | ''           | ''        | '100'        | '12'          | '360'   | ''           | ''       |
			| "2C:Corporation"                                                  | '70'             | '2'           | '140'   | '2/5/2024' | ''        | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '70'         | '2'           | '140'   | ''           | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | ''        | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'   | '1/1/2024' | "Line1" | '180'        | '12'          | '840'   | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0'              | '0'           | '0'     | '2/5/2024' | ''        | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '0'          | '0'           | '0'     | '2/5/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'   | '1/1/2024' | ''        | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'   | '1/1/2024' | "Line1" | '300'        | '12'          | '1,400' | '1/1/2024' | ''       |
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R5C6" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Drill down indicators: *" window is opened
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
		And I select "1C:ERP. Corporate performance management" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
		And I input 'String4' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		And I go to line in 'IndicatorsDrilldown' table:
			| "Product range"              | 'Value1' |
			| "5C:Corporate performance management" | 'String3'   |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I click the button named 'FormOKButton'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''      | ''           | ''        | "TOTAL"      | ''            | ''      | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"  | "Date"       | "String" |
			| "Total"                                                           | '200'            | '8'           | '1,600' | '2/5/2024' | ''        | '180'             | '12'          | '2,160' | '1/1/2024' | ''        | '270'          | '18'          | '4,860' | '1/1/2024' | ''        | '650'        | '38'          | '8,620' | '2/5/2024' | ''       |
			| "Goods"                                                         | '200'            | '8'           | '400'   | '1/1/2024' | ''        | '180'             | '12'          | '720'   | ''           | ''        | '270'          | '18'          | '1,620' | ''           | ''        | '650'        | '38'          | '2,740' | ''           | ''       |
			| "5C:Corporate performance management"                                      | '50'             | '2'           | '100'   | '2/5/2024' | ''        | '20'              | '4'           | '80'    | ''           | ''        | '30'           | '6'           | '180'   | ''           | ''        | '100'        | '12'          | '360'   | ''           | ''       |
			| "2C:Corporation"                                                  | '70'             | '2'           | '140'   | '2/5/2024' | ''        | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '70'         | '2'           | '140'   | ''           | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | ''        | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'   | '1/1/2024' | "Line1" | '180'        | '12'          | '840'   | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0'              | '0'           | '0'     | '2/5/2024' | 'String4' | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '0'          | '0'           | '0'     | '2/5/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'   | '1/1/2024' | ''        | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'   | '1/1/2024' | "Line1" | '300'        | '12'          | '1,400' | '1/1/2024' | ''       |

	* Opening form for period totals
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R4C17" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Drill down indicators (read-only): *" window is opened
		Then I check table 'IndicatorsDrilldown' contains '3' rows from list:
			| "Report period"   | 'Value1' |
			| "February 2024" | '180'       |
			| "March 2024"    | '270'       |
			| "January 2024"  | '200'       |
		And I click the button named 'FormCancel'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R5C17" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Drill down indicators: *" window is opened
		* Deleting row
			And I go to line in 'IndicatorsDrilldown' table:
				| "Report period"  | "Product range"                                                   | 'Value1' |
				| "January 2024" | "3C:Enterprise 8 CORP. Client license for 100 users" | '50'        |
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		* Changing value
			And I go to line in 'IndicatorsDrilldown' table:
				| "Report period"  | "Product range"              | 'Value1' |
				| "January 2024" | "5C:Corporate performance management" | '50'        |
			And I input '100' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		* Adding value
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
			And I select "January 2024" by string from the drop-down list named 'ReportPeriod' in 'IndicatorsDrilldown' table
			And I activate field named "VA0Product" in 'IndicatorsDrilldown' table
			And I select "2C:Corporation" by string from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
			And I input '30' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		And I click the button named 'FormOKButton'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''      | ''           | ''        | "TOTAL"      | ''            | ''      | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"  | "Date"       | "String" |
			| "Total"                                                           | '230'            | '8'           | '1,840' | '2/5/2024' | ''        | '180'             | '12'          | '2,160' | '1/1/2024' | ''        | '270'          | '18'          | '4,860' | '1/1/2024' | ''        | '680'        | '38'          | '8,860' | '2/5/2024' | ''       |
			| "Goods"                                                         | '230'            | '8'           | '460'   | '1/1/2024' | ''        | '180'             | '12'          | '720'   | ''           | ''        | '270'          | '18'          | '1,620' | ''           | ''        | '680'        | '38'          | '2,800' | ''           | ''       |
			| "5C:Corporate performance management"                                      | '100'            | '2'           | '200'   | '2/5/2024' | ''        | '20'              | '4'           | '80'    | ''           | ''        | '30'           | '6'           | '180'   | ''           | ''        | '150'        | '12'          | '460'   | ''           | ''       |
			| "2C:Corporation"                                                  | '100'            | '2'           | '200'   | '2/5/2024' | ''        | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '100'        | '2'           | '200'   | ''           | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | ''        | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'   | '1/1/2024' | "Line1" | '180'        | '12'          | '840'   | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0'              | '0'           | '0'     | '2/5/2024' | 'String4' | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '0'          | '0'           | '0'     | '2/5/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '0'              | '2'           | '0'     | '1/1/2024' | ''        | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'   | '1/1/2024' | "Line1" | '250'        | '12'          | '1,300' | '1/1/2024' | ''       |

	* Opening form for period totals (Date)
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R5C20" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "Drill down indicators: *" window is opened
		* Deleting row
			And I go to line in 'IndicatorsDrilldown' table:
				| "Report period"  | "Product range"                                                   | 'Value1'  |
				| "January 2024" | "3C:Enterprise 8 CORP. Client license for 100 users" | '1/1/2024' |
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		* Changing value
			And I go to line in 'IndicatorsDrilldown' table:
				| "Report period"  | "Product range"              | 'Value1'  |
				| "January 2024" | "5C:Corporate performance management" | '2/5/2024' |
			And I input '3/10/2024' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		* Adding value
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
			And I select "January 2024" exact value from the drop-down list named 'ReportPeriod' in 'IndicatorsDrilldown' table
			And I select "2C:Corporation" exact value from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
			And I input '3/10/2024' text in the field named 'Value1' of 'IndicatorsDrilldown' table
		And I click the button named 'FormOKButton'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''      | ''           | ''        | "TOTAL"      | ''            | ''      | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"  | "Date"       | "String" |
			| "Total"                                                           | '230'            | '8'           | '1,840' | '3/10/2024' | ''        | '180'             | '12'          | '2,160' | '1/1/2024' | ''        | '270'          | '18'          | '4,860' | '1/1/2024' | ''        | '680'        | '38'          | '8,860' | '3/10/2024' | ''       |
			| "Goods"                                                         | '230'            | '8'           | '460'   | '1/1/2024' | ''        | '180'             | '12'          | '720'   | ''           | ''        | '270'          | '18'          | '1,620' | ''           | ''        | '680'        | '38'          | '2,800' | ''           | ''       |
			| "5C:Corporate performance management"                                      | '100'            | '2'           | '200'   | '3/10/2024' | ''        | '20'              | '4'           | '80'    | ''           | ''        | '30'           | '6'           | '180'   | ''           | ''        | '150'        | '12'          | '460'   | ''           | ''       |
			| "2C:Corporation"                                                  | '100'            | '2'           | '200'   | '3/10/2024' | ''        | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '100'        | '2'           | '200'   | ''           | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | ''        | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'   | '1/1/2024' | "Line1" | '180'        | '12'          | '840'   | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0'              | '0'           | '0'     | '2/5/2024' | 'String4' | '0'               | '0'           | '0'     | ''           | ''        | '0'            | '0'           | '0'     | ''           | ''        | '0'          | '0'           | '0'     | '2/5/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '0'              | '2'           | '0'     | ''           | ''        | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'   | '1/1/2024' | "Line1" | '250'        | '12'          | '1,300' | '1/1/2024' | ''       |

	* Closing pivot table without saving
		Then '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 02.08 Factor analysis

	And I open report pivot table with name "VA - Recalculation in context"

	// TO DO: Does not work if there are dimensions of the report type

Scenario: 02.09 Copying all data of the reporting period

	And I open report pivot table with name "VA - Recalculation in context"

	* Copying data
		And I click the button named 'DataCopying'
		Then "Copy report indicator values" window is opened
		And I select "All data for reporting period" exact value from the drop-down list named 'DataProcessorRunMode'
		And I click Choice button of the field named 'MDESource'
		And I find and select reporting period management document by scenario "VA - Main scenario" and start period "January 2024"
		Then "Copy report indicator values" window is opened
		And I change checkbox named 'AdvancedSettingFilterIsBeingEdited' in 'AdvancedSettingFilter' table
		And I finish line editing in 'AdvancedSettingFilter' table
		And I activate field named 'FilterSource' in 'AdvancedSettingFilter' table
		And I select current line in 'AdvancedSettingFilter' table
		Then "Dimension content filter" window is opened
		And I go to line in 'SKDSelection' table:
			| "Comparison type" | "Use" | "Left value"        | "Display mode" |
			| "Equal to"         | "Yes"            | "Companies" | "Quick access"    |
		And I activate field named 'SKDSelectionRightValue' in 'SKDSelection' table
		And I select current line in 'SKDSelection' table
		And I select "Mercury LLC" by string from the drop-down list named 'SKDSelectionRightValue' in 'SKDSelection' table
		And I finish line editing in 'SKDSelection' table
		And I click the button named 'Apply'
		Then "Copy report indicator values" window is opened
		And I click Choice button of the field named 'MDEDestination'
		And I find and select reporting period management document by scenario "VA - Script for indexing" and start period "January 2024"
		Then "Copy report indicator values" window is opened
		And I select current line in 'AdvancedSettingFilterDestination' table
		And on the form menu I select "Fixed value"
		And I select company "Venus LLC"
		And I set checkbox named 'TransferReportsInstances'
		And I click the button named 'Execute'
		Затем я жду, что в сообщениях пользователю будет подстрока "Copy successful" в течение 60 секунд
		And I clear user message window
		And I click the button named 'Execute'
		Затем я жду, что в сообщениях пользователю будет подстрока "Copy successful" в течение 60 секунд		
		And I close "Copy report indicator values" window

	And I set pivot table filter 'Item_Scenario' with value "VA - Script for indexing"
	And I set pivot table filter 'Organization' with value "Venus LLC"

	* Verifying the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''       | ''           | ''        | "TOTAL"      | ''            | ''       | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"   | "Date"       | "String" |
			| "Total"                                                           | '150'            | '10'          | '1,500' | '1/1/2024' | ''        | '300'             | '20'          | '6,000' | '1/1/2024' | ''        | '450'          | '30'          | '13,500' | '1/1/2024' | ''        | '900'        | '60'          | '21,000' | '1/1/2024' | ''       |
			| "Goods"                                                         | '150'            | '10'          | '300'   | '1/1/2024' | ''        | '300'             | '20'          | '1,200' | '1/1/2024' | ''        | '450'          | '30'          | '2,700'  | '1/1/2024' | ''        | '900'        | '60'          | '4,200'  | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '10'             | '2'           | '20'    | '1/1/2024' | "Line1" | '20'              | '4'           | '80'    | '1/1/2024' | "Line1" | '30'           | '6'           | '180'    | '1/1/2024' | "Line1" | '60'         | '12'          | '280'    | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '20'             | '2'           | '40'    | '1/1/2024' | "Line1" | '40'              | '4'           | '160'   | '1/1/2024' | "Line1" | '60'           | '6'           | '360'    | '1/1/2024' | "Line1" | '120'        | '12'          | '560'    | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | "Line1" | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'    | '1/1/2024' | "Line1" | '180'        | '12'          | '840'    | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '40'             | '2'           | '80'    | '1/1/2024' | "Line1" | '80'              | '4'           | '320'   | '1/1/2024' | "Line1" | '120'          | '6'           | '720'    | '1/1/2024' | "Line1" | '240'        | '12'          | '1,120'  | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'   | '1/1/2024' | "Line1" | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'    | '1/1/2024' | "Line1" | '300'        | '12'          | '1,400'  | '1/1/2024' | ''       |
									
Scenario: 02.10 Copying data by indicators

	And I open report pivot table with name "VA - Recalculation in context"

	* Copying data
		And I click the button named 'DataCopying'

		Then "Copy report indicator values" window is opened
		And I select from the drop-down list named 'ScenarioDestination'  by "VA - Script for indexing" string
		And I go to line in 'AdvancedSettingFilter' table:
			| "Dimension"   | "Filter value" | "Being edited" |
			| "Companies" | "<Without filter>"    | "No"           |
		And I change checkbox named 'AdvancedSettingFilterIsBeingEdited' in 'AdvancedSettingFilter' table
		And I finish line editing in 'AdvancedSettingFilter' table
		And I activate field named 'FilterSource' in 'AdvancedSettingFilter' table
		And I select current line in 'AdvancedSettingFilter' table
		Then "Dimension content filter" window is opened
		And I go to line in 'SKDSelection' table:
			| "Comparison type" | "Use" | "Left value"        | "Display mode" |
			| "Equal to"         | "Yes"            | "Companies" | "Quick access"    |
		And I activate field named 'SKDSelectionRightValue' in 'SKDSelection' table
		And I select current line in 'SKDSelection' table
		And I select "Venus LLC" by string from the drop-down list named 'SKDSelectionRightValue' in 'SKDSelection' table
		And I finish line editing in 'SKDSelection' table
		And I click the button named 'Apply'
		
		Then "Copy report indicator values" window is opened
		And I select current line in 'AdvancedSettingFilterDestination' table
		And on the form menu I select "Fixed value"
		And I select company "Mercury LLC"
		Then "Copy report indicator values" window is opened

		And I go to line in 'AdvancedSettingFilter' table:
			| "Dimension"  | "Filter value" | "Being edited" |
			| "Cash flow items" | "<Without filter>"    | "No"           |
		And I activate field named 'AdvancedSettingFilterIsBeingEdited' in 'AdvancedSettingFilter' table
		And I change checkbox named 'AdvancedSettingFilterIsBeingEdited' in 'AdvancedSettingFilter' table
		And I finish line editing in 'AdvancedSettingFilter' table
		And I activate field named 'FilterSource' in 'AdvancedSettingFilter' table
		And I select current line in 'AdvancedSettingFilter' table
		Then "Dimension content filter" window is opened
		And I go to line in 'SKDSelection' table:
			| "Comparison type" | "Use" | "Left value"       | "Display mode" |
			| "Equal to"         | "Yes"            | "Cash flow items" | "Quick access"    |
		And I activate field named 'SKDSelectionRightValue' in 'SKDSelection' table
		And I select current line in 'SKDSelection' table
		And I select "3Software sale" by string from the drop-down list named 'SKDSelectionRightValue' in 'SKDSelection' table
		And I finish line editing in 'SKDSelection' table
		And I click the button named 'Apply'
		
		Then "Copy report indicator values" window is opened
		And I select current line in 'AdvancedSettingFilterDestination' table
		And on the form menu I select "By source values"

		Then "Copy report indicator values" window is opened
		And I go to line in 'AdvancedSettingFilter' table:
			| "Dimension"    | "Filter value" | "Being edited" |
			| "Product range" | "<Without filter>"    | "No"           |
		And I activate field named 'AdvancedSettingFilterIsBeingEdited' in 'AdvancedSettingFilter' table
		And I change checkbox named 'AdvancedSettingFilterIsBeingEdited' in 'AdvancedSettingFilter' table
		And I finish line editing in 'AdvancedSettingFilter' table
		And I activate field named 'FilterSource' in 'AdvancedSettingFilter' table
		And I select current line in 'AdvancedSettingFilter' table
		Then "Dimension content filter" window is opened
		And I go to line in 'SKDSelection' table:
			| "Comparison type" | "Use" | "Left value"         | "Display mode" |
			| "Equal to"         | "Yes"            | "Product range" | "Quick access"    |
		And I activate field named 'SKDSelectionComparisonType' in 'SKDSelection' table
		And I select current line in 'SKDSelection' table
		And I select "Not equal" exact value from the drop-down list named 'SKDSelectionComparisonType' in 'SKDSelection' table
		And I activate field named 'SKDSelectionRightValue' in 'SKDSelection' table
		And I select "5C:Corporate performance management" by string from the drop-down list named 'SKDSelectionRightValue' in 'SKDSelection' table
		And I finish line editing in 'SKDSelection' table
		And I click the button named 'Apply'
		
		Then "Copy report indicator values" window is opened
		And I click the button named 'Execute'

	* An error log should appear
		And I wait "Protocol" window opening in 60 seconds
		Then 'SpreadsheetDocumentField' spreadsheet document is equal
			| "Errors"                                                                                                                                                                                              |
			| "Cannot save indicator values. Block to change by parameters is set:\n	Scenario: \"VA - Script for indexing\",\n	Company: \"Mercury LLC\",\n	Period: \"January 2024\"" |
		And I close "Protocol" window

	* Copying with period shift
		When "Copy report indicator values" window is opened
		And I click the button named 'ButtonChangePeriodSource'
		Then "Select period" window is opened
		And I input '1/1/2024' text in the field named 'DateBegin'
		And I move to the next attribute
		And I input '1/31/2024' text in the field named 'DateEnd'
		And I click the button named 'Select'
		Then "Copy report indicator values" window is opened
		And I click the button named 'ButtonChangePeriodDestination'
		Then "Select period" window is opened
		And I input '2/1/2024' text in the field named 'DateBegin'
		And I move to the next attribute
		And I input '2/28/2024' text in the field named 'DateEnd'
		And I click the button named 'Select'
		Then "Copy report indicator values" window is opened
		And I click the button named 'Execute'
		Затем я жду, что в сообщениях пользователю будет подстрока "Copy successful" в течение 60 секунд
		And I clear user message window
		And I click the button named 'Execute'
		Затем я жду, что в сообщениях пользователю будет подстрока "Copy successful" в течение 60 секунд		
		And I close "Copy report indicator values" window

	* Checking the result
		And I set pivot table filter 'Item_Organization' with value "Mercury LLC"
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''     | ''     | ''       | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''       | ''           | ''        | "TOTAL"      | ''            | ''       | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total" | "Date" | "String" | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"   | "Date"       | "String" |
			| "Total"                                                           | '0'              | '0'           | '0'    | ''     | ''       | '150'             | '10'          | '1,500' | '1/1/2024' | ''        | '450'          | '30'          | '13,500' | '1/1/2024' | ''        | '600'        | '40'          | '15,000' | '1/1/2024' | ''       |
			| "Goods"                                                         | '0'              | '0'           | '0'    | ''     | ''       | '140'             | '8'           | '280'   | '1/1/2024' | ''        | '420'          | '24'          | '2,520'  | '1/1/2024' | ''        | '560'        | '32'          | '2,800'  | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '0'              | '0'           | '0'    | ''     | ''       | '20'              | '2'           | '40'    | '1/1/2024' | "Line1" | '60'           | '6'           | '360'    | '1/1/2024' | "Line1" | '80'         | '8'           | '400'    | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '0'              | '0'           | '0'    | ''     | ''       | '30'              | '2'           | '60'    | '1/1/2024' | "Line1" | '90'           | '6'           | '540'    | '1/1/2024' | "Line1" | '120'        | '8'           | '600'    | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0'              | '0'           | '0'    | ''     | ''       | '40'              | '2'           | '80'    | '1/1/2024' | "Line1" | '120'          | '6'           | '720'    | '1/1/2024' | "Line1" | '160'        | '8'           | '800'    | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '0'              | '0'           | '0'    | ''     | ''       | '50'              | '2'           | '100'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'    | '1/1/2024' | "Line1" | '200'        | '8'           | '1,000'  | '1/1/2024' | ''       |
				
Scenario: 02.11 Checking pivot table

	And I open report pivot table with name "VA - Recalculation in context"

	* Changing table view
		When '$WindowTitle$' window is opened
		And I click the hyperlink named 'FilterHeading'
		And I select "USD" exact value from the drop-down list named 'DisplayCurrency'
		And I select "thousands" exact value from the drop-down list named 'Divisor'
		And I move to the next attribute
		And I input '5' text in the field named 'Accuracy'
		And I move to the next attribute
		And I click the button named 'ShowPeriodsSettings'
		And I change checkbox named 'ShouldShowTotalQuarter'
		And I click the button named 'FormApply'
		Then '$WindowTitle$' window is opened
		And I click the button named 'ShowTableSettingsByAxes'
		Then "Set up field location" window is opened
		And I click the button named 'DimensionsLayoutOption'
		And on the form menu I select "Adjacent dimensions"
		And I click the button named 'ButtonApply'
		Then '$WindowTitle$' window is opened
		And I click the button named 'ShowAdditionalFilters'
		And I go to line in 'FiltersSettings' table:
			| "Comparison type" | "Use" | "Field"         |
			| "Equal to"         | "No"          | "Product range" |
		And I set checkbox named 'FiltersSettingsUse' in 'FiltersSettings' table
		And I activate field named 'FiltersSettingsComparisonType' in 'FiltersSettings' table
		And I select current line in 'FiltersSettings' table
		And I select "In list" exact value from the drop-down list named 'FiltersSettingsComparisonType' in 'FiltersSettings' table
		And I activate field named 'FiltersSettingsFilterValue' in 'FiltersSettings' table
		And I click choice button of the attribute named 'FiltersSettingsFilterValue' in 'FiltersSettings' table
		Then "Value list" window is opened
		And I click the button named 'Add'
		And I select "1C:ERP. Corporate performance management" exact value from the drop-down list named 'value' in 'ValueList' table
		And I click the button named 'Add'
		And I select "5C:Corporate performance management" exact value from the drop-down list named 'value' in 'ValueList' table
		And I click the button named 'OK'
		Then '$WindowTitle$' window is opened
		And I finish line editing in 'FiltersSettings' table
		And I click the button named 'UpdateTabData'
		And I wait for "Pivot table: *" form opening for 20 seconds
		
	* Comparing the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal by template
			| "VA - Recalculation in context (pivot table)" | "Product range"                 | "January 2024" | ''            | ''     | ''     | ''       | "February 2024" | ''            | ''        | ''           | ''        | "March 2024" | ''            | ''        | ''           | ''        | "1 quarter of 2024" | ''            | ''        | ''           | ''        | "TOTAL"      | ''            | ''        | ''           | ''       |
			| "VA - Recalculation in context (pivot table)" | ''                             | "Count"     | "ZoomRatio" | "Total" | "Date" | "String" | "Count"      | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count"        | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"    | "Date"       | "String" |
			| "Total"                                        | ''                             | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'       | ''           | ''        | '0'            | '0'           | '0'       | ''           | ''        | '0'                 | '0'           | '0'       | ''           | ''        | '0'          | '0'           | '0'       | ''           | ''       |
			| "Goods"                                      | ''                             | '0'              | '0'           | '0'    | ''     | ''       | '0.0005*'         | '0.00200'     | '0.0010*' | '1/1/2024' | ''        | '0.0016*'      | '0.00600'     | '0.0096*' | '1/1/2024' | ''        | '0.0021*'           | '0.00800'     | '0.0107*' | '1/1/2024' | ''        | '0.0021*'    | '0.00800'     | '0.0107*' | '1/1/2024' | ''       |
			| ''                                            | "1C:ERP. Corporate performance management" | '0'              | '0'           | '0'    | ''     | ''       | '0.0005*'         | '0.00200'     | '0.0010*' | '1/1/2024' | "Line1" | '0.0016*'      | '0.00600'     | '0.0096*' | '1/1/2024' | "Line1" | '0.0021*'           | '0.00800'     | '0.0107*' | '1/1/2024' | "Line1" | '0.0021*'    | '0.00800'     | '0.0107*' | '1/1/2024' | ''       |

Scenario: 02.12 Indexing by scenario

	* Opening a pivot table
		And I open report pivot table with name "VA - Recalculation in context"
		And I set pivot table filter 'DisplayCurrency' with value 'RUB'
		And I set pivot table filter 'Item_Scenario' with value "VA - Main scenario"

	* Indexing
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2:R10C11' cell
		And I click the button named 'ChangeIndicatorsIndexing'
		Then "Change values" window is opened
		And I select from the drop-down list named 'Deflator'  by "VA - Script for indexing" string
		And I click the button named 'Apply'
	* Cancelling the action
		Then '$WindowTitle$' window is opened
		And I click the button named 'CancelAction'
	* Indexing
		And I click the button named 'ChangeIndicatorsIndexing'
		Then "Change values" window is opened
		And I select from the drop-down list named 'Deflator'  by "VA - Script for indexing" string
		And I click the button named 'Apply'

	* Indexing non-numeric values
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C10:R9C11' cell
		And I click the button named 'ChangeIndicatorsIndexing'
		Then "Change values" window is opened
		And I select from the drop-down list named 'Deflator'  by "VA - Script for indexing" string
		And I click the button named 'Apply'

	* Checking the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''      | ''           | ''        | "February 2024" | ''            | ''        | ''           | ''        | "March 2024" | ''            | ''       | ''           | ''        | "TOTAL"      | ''            | ''        | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"    | "Date"       | "String" |
			| "Total"                                                           | '150'            | '10'          | '1,500' | '1/1/2024' | ''        | '10,820'          | '36'          | '389,520' | '1/1/2024' | ''        | '450'          | '30'          | '13,500' | '1/1/2024' | ''        | '11,420'     | '76'          | '404,520' | '1/1/2024' | ''       |
			| "Goods"                                                         | '150'            | '10'          | '300'   | '1/1/2024' | ''        | '10,820'          | '36'          | '86,480'  | '1/1/2024' | ''        | '450'          | '30'          | '2,700'  | '1/1/2024' | ''        | '11,420'     | '76'          | '89,480'  | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '10'             | '2'           | '20'    | '1/1/2024' | "Line1" | '20'              | '4'           | '80'      | '1/1/2024' | "Line1" | '30'           | '6'           | '180'    | '1/1/2024' | "Line1" | '60'         | '12'          | '280'     | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '20'             | '2'           | '40'    | '1/1/2024' | "Line1" | '800'             | '8'           | '6,400'   | '1/1/2024' | "Line1" | '60'           | '6'           | '360'    | '1/1/2024' | "Line1" | '880'        | '16'          | '6,800'   | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30'             | '2'           | '60'    | '1/1/2024' | "Line1" | '1,800'           | '8'           | '14,400'  | '1/1/2024' | "Line1" | '90'           | '6'           | '540'    | '1/1/2024' | "Line1" | '1,920'      | '16'          | '15,000'  | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '40'             | '2'           | '80'    | '1/1/2024' | "Line1" | '3,200'           | '8'           | '25,600'  | '1/1/2024' | "Line1" | '120'          | '6'           | '720'    | '1/1/2024' | "Line1" | '3,360'      | '16'          | '26,400'  | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '2'           | '100'   | '1/1/2024' | "Line1" | '5,000'           | '8'           | '40,000'  | '1/1/2024' | "Line1" | '150'          | '6'           | '900'    | '1/1/2024' | "Line1" | '5,200'      | '16'          | '41,000'  | '1/1/2024' | ''       |
		
	* Closing without saving
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 02.13 Reverse allocation (uniform)
	
	* Opening a pivot table
		And I open report pivot table with name "VA - Recalculation in context"

	* Switching to reverse allocation mode
		When '$WindowTitle$' window is opened
		And I click the hyperlink named 'FilterHeading'
		And I select "Reverse allocation (equally)" exact value from the drop-down list named 'WorkMode'
		Then the form attribute named 'WorkMode' became equal to "Reverse allocation (equally)"
		And I click the button named 'UpdateTabData1'
		And I wait for "Pivot table: *" form opening for 30 seconds

	* Allocating indicators by a single period
		* Quantity
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C2' cell
			And I select context menu item named 'SpreadsheetFieldTemlateContextMenuLockCellForDistribution' of the form attribute named 'SpreadsheetFieldTemlate'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '1,000.00000'
		* Coefficient
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C3:R10C3' cell
			And I select context menu item named 'SpreadsheetFieldTemlateContextMenuLockCellForDistribution' of the form attribute named 'SpreadsheetFieldTemlate'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C3' cell
			And I select context menu item named 'SpreadsheetFieldTemlateContextMenuUnlockCellForDistribution' of the form attribute named 'SpreadsheetFieldTemlate'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
		* Total
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C4' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
		* Date
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'

	* Comparing the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''        | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''       | ''           | ''        | "TOTAL"      | ''            | ''        | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"    | "Date"       | "String" |
			| "Total"                                                           | '1,000'          | '100'         | '100,000' | '1/1/2024' | ''        | '300'             | '20'          | '6,000' | '1/1/2024' | ''        | '450'          | '30'          | '13,500' | '1/1/2024' | ''        | '1,750'      | '150'         | '119,500' | '1/1/2024' | ''       |
			| "Goods"                                                         | '1,000'          | '100'         | '3,800'   | '1/1/2024' | ''        | '300'             | '20'          | '1,200' | '1/1/2024' | ''        | '450'          | '30'          | '2,700'  | '1/1/2024' | ''        | '1,750'      | '150'         | '7,700'   | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '245'            | '2'           | '490'     | '1/1/2024' | "Line1" | '20'              | '4'           | '80'    | '1/1/2024' | "Line1" | '30'           | '6'           | '180'    | '1/1/2024' | "Line1" | '295'        | '12'          | '750'     | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '20'             | '92'          | '1,840'   | '1/1/2024' | "Line1" | '40'              | '4'           | '160'   | '1/1/2024' | "Line1" | '60'           | '6'           | '360'    | '1/1/2024' | "Line1" | '120'        | '102'         | '2,360'   | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '245'            | '2'           | '490'     | '1/1/2024' | "Line1" | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'    | '1/1/2024' | "Line1" | '395'        | '12'          | '1,270'   | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '245'            | '2'           | '490'     | '1/1/2024' | "Line1" | '80'              | '4'           | '320'   | '1/1/2024' | "Line1" | '120'          | '6'           | '720'    | '1/1/2024' | "Line1" | '445'        | '12'          | '1,530'   | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '245'            | '2'           | '490'     | '1/1/2024' | "Line1" | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'    | '1/1/2024' | "Line1" | '495'        | '12'          | '1,790'   | '1/1/2024' | ''       |
							
	* Allocation by periods
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C2' cell
		And I select context menu item named 'SpreadsheetFieldTemlateContextMenuUnlockCellForDistribution' of the form attribute named 'SpreadsheetFieldTemlate'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C3' cell
		And I select context menu item named 'SpreadsheetFieldTemlateContextMenuLockCellForDistribution' of the form attribute named 'SpreadsheetFieldTemlate'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C17' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '15,000.00000'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C18' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '42.00000'

	* Comparing the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''        | ''           | ''        | "February 2024" | ''            | ''        | ''           | ''        | "March 2024" | ''            | ''        | ''           | ''        | "TOTAL"      | ''            | ''        | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"    | "Date"       | "String" |
			| "Total"                                                           | '5,000'          | '100'         | '500,000' | '1/1/2024' | ''        | '5,000'           | '36'          | '180,000' | '1/1/2024' | ''        | '5,000'        | '44'          | '220,000' | '1/1/2024' | ''        | '15,000'     | '180'         | '900,000' | '1/1/2024' | ''       |
			| "Goods"                                                         | '5,000'          | '100'         | '100,000' | '1/1/2024' | ''        | '5,000'           | '36'          | '36,000'  | '1/1/2024' | ''        | '5,000'        | '44'          | '44,000'  | '1/1/2024' | ''        | '15,000'     | '180'         | '180,000' | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '1,000'          | '2'           | '2,000'   | '1/1/2024' | "Line1" | '1,000'           | '20'          | '20,000'  | '1/1/2024' | "Line1" | '1,000'        | '20'          | '20,000'  | '1/1/2024' | "Line1" | '3,000'      | '42'          | '42,000'  | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '1,000'          | '92'          | '92,000'  | '1/1/2024' | "Line1" | '1,000'           | '4'           | '4,000'   | '1/1/2024' | "Line1" | '1,000'        | '6'           | '6,000'   | '1/1/2024' | "Line1" | '3,000'      | '102'         | '102,000' | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '1,000'          | '2'           | '2,000'   | '1/1/2024' | "Line1" | '1,000'           | '4'           | '4,000'   | '1/1/2024' | "Line1" | '1,000'        | '6'           | '6,000'   | '1/1/2024' | "Line1" | '3,000'      | '12'          | '12,000'  | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '1,000'          | '2'           | '2,000'   | '1/1/2024' | "Line1" | '1,000'           | '4'           | '4,000'   | '1/1/2024' | "Line1" | '1,000'        | '6'           | '6,000'   | '1/1/2024' | "Line1" | '3,000'      | '12'          | '12,000'  | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '1,000'          | '2'           | '2,000'   | '1/1/2024' | "Line1" | '1,000'           | '4'           | '4,000'   | '1/1/2024' | "Line1" | '1,000'        | '6'           | '6,000'   | '1/1/2024' | "Line1" | '3,000'      | '12'          | '12,000'  | '1/1/2024' | ''       |
				
	* Allocating by periods again
		* Coefficient
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C18' cell
			And I select context menu item named 'SpreadsheetFieldTemlateContextMenuLockCellForDistribution' of the form attribute named 'SpreadsheetFieldTemlate'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C18' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '2,100.00000'
		* Total
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C19' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
		* Date
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C20' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
		* Row
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'C17' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
		* Column
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'

	* Comparing the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''        | ''           | ''        | "February 2024" | ''            | ''          | ''           | ''        | "March 2024" | ''            | ''          | ''           | ''        | "TOTAL"      | ''            | ''           | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"      | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"      | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"       | "Date"       | "String" |
			| "Total"                                                           | '5,000'          | '100'         | '500,000' | '1/1/2024' | ''        | '5,000'           | '1,000'       | '5,000,000' | '1/1/2024' | ''        | '5,000'        | '1,000'       | '5,000,000' | '1/1/2024' | ''        | '15,000'     | '2,100'       | '10,500,000' | '1/1/2024' | ''       |
			| "Goods"                                                         | '5,000'          | '100'         | '100,000' | '1/1/2024' | ''        | '5,000'           | '1,000'       | '1,000,000' | '1/1/2024' | ''        | '5,000'        | '1,000'       | '1,000,000' | '1/1/2024' | ''        | '15,000'     | '2,100'       | '2,100,000'  | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '1,000'          | '2'           | '2,000'   | '1/1/2024' | "Line1" | '1,000'           | '200'         | '200,000'   | '1/1/2024' | "Line1" | '1,000'        | '200'         | '200,000'   | '1/1/2024' | "Line1" | '3,000'      | '402'         | '402,000'    | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '1,000'          | '92'          | '92,000'  | '1/1/2024' | "Line1" | '1,000'           | '200'         | '200,000'   | '1/1/2024' | "Line1" | '1,000'        | '200'         | '200,000'   | '1/1/2024' | "Line1" | '3,000'      | '492'         | '492,000'    | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '1,000'          | '2'           | '2,000'   | '1/1/2024' | "Line1" | '1,000'           | '200'         | '200,000'   | '1/1/2024' | "Line1" | '1,000'        | '200'         | '200,000'   | '1/1/2024' | "Line1" | '3,000'      | '402'         | '402,000'    | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '1,000'          | '2'           | '2,000'   | '1/1/2024' | "Line1" | '1,000'           | '200'         | '200,000'   | '1/1/2024' | "Line1" | '1,000'        | '200'         | '200,000'   | '1/1/2024' | "Line1" | '3,000'      | '402'         | '402,000'    | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '1,000'          | '2'           | '2,000'   | '1/1/2024' | "Line1" | '1,000'           | '200'         | '200,000'   | '1/1/2024' | "Line1" | '1,000'        | '200'         | '200,000'   | '1/1/2024' | "Line1" | '3,000'      | '402'         | '402,000'    | '1/1/2024' | ''       |
	
Scenario: 02.14 Reverse allocation (proportional)

	* Opening a pivot table
		And I open report pivot table with name "VA - Recalculation in context"

	* Switching to reverse allocation mode
		And I click the hyperlink named 'FilterHeading'
		And I select "Reverse allocation (proportionally)" exact value from the drop-down list named 'WorkMode'
		And I click the button named 'UpdateTabData1'
		And I wait for "Pivot table: *" form opening for 30 seconds

	* Allocating indicators by a single period
		* Quantity
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C2' cell
			And I select context menu item named 'SpreadsheetFieldTemlateContextMenuLockCellForDistribution' of the form attribute named 'SpreadsheetFieldTemlate'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '1,050.00000'
		* Blocking a group of cells
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C3:R10C6' cell
			And I select context menu item named 'SpreadsheetFieldTemlateContextMenuLockCellForDistribution' of the form attribute named 'SpreadsheetFieldTemlate'
		* Coefficient
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '200.00000'
			When '$WindowTitle$' window is opened
			Then 'R4C2:R10C6' area of 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| '1,050'          | '10'          | '10,500' | '1/1/2024' | ''        |
				| '1,050'          | '10'          | '2,100'  | '1/1/2024' | ''        |
				| '100'            | '2'           | '200'    | '1/1/2024' | "Line1" |
				| '200'            | '2'           | '400'    | '1/1/2024' | "Line1" |
				| '300'            | '2'           | '600'    | '1/1/2024' | "Line1" |
				| '400'            | '2'           | '800'    | '1/1/2024' | "Line1" |
				| '50'             | '2'           | '100'    | '1/1/2024' | "Line1" |
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C3:R10C3' cell
			And I select context menu item named 'SpreadsheetFieldTemlateContextMenuUnlockCellForDistribution' of the form attribute named 'SpreadsheetFieldTemlate'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '200.00000'
		* Total
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C4' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
		* Row
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C6' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
						
		* Comparing the result
			When '$WindowTitle$' window is opened
			Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''        | ''           | ''        | "February 2024" | ''            | ''      | ''           | ''        | "March 2024" | ''            | ''       | ''           | ''        | "TOTAL"      | ''            | ''        | ''           | ''       |
				| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"  | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"    | "Date"       | "String" |
				| "Total"                                                           | '1,050'          | '200'         | '210,000' | '1/1/2024' | ''        | '300'             | '20'          | '6,000' | '1/1/2024' | ''        | '450'          | '30'          | '13,500' | '1/1/2024' | ''        | '1,800'      | '250'         | '229,500' | '1/1/2024' | ''       |
				| "Goods"                                                         | '1,050'          | '200'         | '42,000'  | '1/1/2024' | ''        | '300'             | '20'          | '1,200' | '1/1/2024' | ''        | '450'          | '30'          | '2,700'  | '1/1/2024' | ''        | '1,800'      | '250'         | '45,900'  | '1/1/2024' | ''       |
				| "5C:Corporate performance management"                                      | '100'            | '40'          | '4,000'   | '1/1/2024' | "Line1" | '20'              | '4'           | '80'    | '1/1/2024' | "Line1" | '30'           | '6'           | '180'    | '1/1/2024' | "Line1" | '150'        | '50'          | '4,260'   | '1/1/2024' | ''       |
				| "2C:Corporation"                                                  | '200'            | '40'          | '8,000'   | '1/1/2024' | "Line1" | '40'              | '4'           | '160'   | '1/1/2024' | "Line1" | '60'           | '6'           | '360'    | '1/1/2024' | "Line1" | '300'        | '50'          | '8,520'   | '1/1/2024' | ''       |
				| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '300'            | '40'          | '12,000'  | '1/1/2024' | "Line1" | '60'              | '4'           | '240'   | '1/1/2024' | "Line1" | '90'           | '6'           | '540'    | '1/1/2024' | "Line1" | '450'        | '50'          | '12,780'  | '1/1/2024' | ''       |
				| "1C:ERP. Corporate performance management"                                   | '400'            | '40'          | '16,000'  | '1/1/2024' | "Line1" | '80'              | '4'           | '320'   | '1/1/2024' | "Line1" | '120'          | '6'           | '720'    | '1/1/2024' | "Line1" | '600'        | '50'          | '17,040'  | '1/1/2024' | ''       |
				| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '40'          | '2,000'   | '1/1/2024' | "Line1" | '100'             | '4'           | '400'   | '1/1/2024' | "Line1" | '150'          | '6'           | '900'    | '1/1/2024' | "Line1" | '300'        | '50'          | '3,300'   | '1/1/2024' | ''       |
		
		* Allocation by periods
			* Quantity
				When '$WindowTitle$' window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C17' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '3,550.00000'
			* Coefficient
				When '$WindowTitle$' window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C18' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '500.00000'
			* Total
				When '$WindowTitle$' window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C19' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
			* Date
				When '$WindowTitle$' window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C20' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
			* Row
				When '$WindowTitle$' window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'C17' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
			* Column
				When '$WindowTitle$' window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
																
		* Comparing the result
			When '$WindowTitle$' window is opened
			Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''        | ''           | ''        | "February 2024" | ''            | ''       | ''           | ''        | "March 2024" | ''            | ''       | ''           | ''        | "TOTAL"      | ''            | ''        | ''           | ''       |
				| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"    | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"   | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"    | "Date"       | "String" |
				| "Total"                                                           | '2,050'          | '400'         | '820,000' | '1/1/2024' | ''        | '600'             | '40'          | '24,000' | '1/1/2024' | ''        | '900'          | '60'          | '54,000' | '1/1/2024' | ''        | '3,550'      | '500'         | '898,000' | '1/1/2024' | ''       |
				| "Goods"                                                         | '2,050'          | '400'         | '164,000' | '1/1/2024' | ''        | '600'             | '40'          | '4,800'  | '1/1/2024' | ''        | '900'          | '60'          | '10,800' | '1/1/2024' | ''        | '3,550'      | '500'         | '179,600' | '1/1/2024' | ''       |
				| "5C:Corporate performance management"                                      | '200'            | '80'          | '16,000'  | '1/1/2024' | "Line1" | '40'              | '8'           | '320'    | '1/1/2024' | "Line1" | '60'           | '12'          | '720'    | '1/1/2024' | "Line1" | '300'        | '100'         | '17,040'  | '1/1/2024' | ''       |
				| "2C:Corporation"                                                  | '400'            | '80'          | '32,000'  | '1/1/2024' | "Line1" | '80'              | '8'           | '640'    | '1/1/2024' | "Line1" | '120'          | '12'          | '1,440'  | '1/1/2024' | "Line1" | '600'        | '100'         | '34,080'  | '1/1/2024' | ''       |
				| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '600'            | '80'          | '48,000'  | '1/1/2024' | "Line1" | '120'             | '8'           | '960'    | '1/1/2024' | "Line1" | '180'          | '12'          | '2,160'  | '1/1/2024' | "Line1" | '900'        | '100'         | '51,120'  | '1/1/2024' | ''       |
				| "1C:ERP. Corporate performance management"                                   | '800'            | '80'          | '64,000'  | '1/1/2024' | "Line1" | '160'             | '8'           | '1,280'  | '1/1/2024' | "Line1" | '240'          | '12'          | '2,880'  | '1/1/2024' | "Line1" | '1,200'      | '100'         | '68,160'  | '1/1/2024' | ''       |
				| "3C:Enterprise 8 CORP. Client license for 100 users" | '50'             | '80'          | '4,000'   | '1/1/2024' | "Line1" | '200'             | '8'           | '1,600'  | '1/1/2024' | "Line1" | '300'          | '12'          | '3,600'  | '1/1/2024' | "Line1" | '550'        | '100'         | '9,200'   | '1/1/2024' | ''       |
							
Scenario: 02.15 Changing indicators in an additional currency

	* Opening a pivot table
		And I open report pivot table with name "VA - Recalculation in context"
		And I set pivot table filter 'DisplayCurrency' with value 'USD'

	* Changing display precision
		When '$WindowTitle$' window is opened
		And I input '5' text in the field named 'Accuracy'
		And I click the button named 'UpdateTabData'
		And I wait for "Pivot table: *" form opening for 20 seconds

	* Checking the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''         | ''           | ''        | "February 2024" | ''            | ''         | ''           | ''        | "March 2024" | ''            | ''          | ''           | ''        | "TOTAL"      | ''            | ''          | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"     | "Date"       | "String"  | "Count"      | "ZoomRatio" | "Total"     | "Date"       | "String"  | "Count"   | "ZoomRatio" | "Total"      | "Date"       | "String"  | "Count" | "ZoomRatio" | "Total"      | "Date"       | "String" |
			| "Total"                                                           | '2.02102'        | '0.13474'     | '20.21007' | '1/1/2024' | ''        | '4.03362'         | '0.26890'     | '80.67260' | '1/1/2024' | ''        | '6.04810'      | '0.40320'     | '181.44307' | '1/1/2024' | ''        | '12.10274'   | '0.80684'     | '282.32574' | '1/1/2024' | ''       |
			| "Goods"                                                         | '2.02102'        | '10.00000'    | '4.04202'  | '1/1/2024' | ''        | '4.03363'         | '20.00000'    | '16.13452' | '1/1/2024' | ''        | '6.04808'      | '30.00000'    | '36.28862'  | '1/1/2024' | ''        | '12.10273'   | '60.00000'    | '56.46516'  | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '0.13474'        | '2.00000'     | '0.26947'  | '1/1/2024' | "Line1" | '0.26891'         | '4.00000'     | '1.07563'  | '1/1/2024' | "Line1" | '0.40320'      | '6.00000'     | '2.41925'   | '1/1/2024' | "Line1" | '0.80685'    | '12.00000'    | '3.76435'   | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '0.26947'        | '2.00000'     | '0.53894'  | '1/1/2024' | "Line1" | '0.53782'         | '4.00000'     | '2.15127'  | '1/1/2024' | "Line1" | '0.80641'      | '6.00000'     | '4.83848'   | '1/1/2024' | "Line1" | '1.61370'    | '12.00000'    | '7.52869'   | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '0.40421'        | '2.00000'     | '0.80840'  | '1/1/2024' | "Line1" | '0.80673'         | '4.00000'     | '3.22690'  | '1/1/2024' | "Line1" | '1.20962'      | '6.00000'     | '7.25773'   | '1/1/2024' | "Line1" | '2.42056'    | '12.00000'    | '11.29303'  | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0.53893'        | '2.00000'     | '1.07787'  | '1/1/2024' | "Line1" | '1.07563'         | '4.00000'     | '4.30254'  | '1/1/2024' | "Line1" | '1.61282'      | '6.00000'     | '9.67696'   | '1/1/2024' | "Line1" | '3.22738'    | '12.00000'    | '15.05737'  | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '0.67367'        | '2.00000'     | '1.34734'  | '1/1/2024' | "Line1" | '1.34454'         | '4.00000'     | '5.37818'  | '1/1/2024' | "Line1" | '2.01603'      | '6.00000'     | '12.09620'  | '1/1/2024' | "Line1" | '4.03424'    | '12.00000'    | '18.82172'  | '1/1/2024' | ''       |
							
	* Changing indicators
		* Quantity
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '1,000.00000'
			When '$WindowTitle$' window is opened
			And I click the button named 'CopyDataByRow'
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C4' cell
			And I click the button named 'CopyDataByRow'
		* Quantity (zeroing)
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '0.00000'
		* Date
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '1/31/2024'
		* Row
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C6' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text "LineUSD"
			When '$WindowTitle$' window is opened
			And I click the button named 'CopyDataByRow'
		* Coefficient
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R8C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '1.00000'
			When '$WindowTitle$' window is opened
			And I click the button named 'CopyDataByColumn'
		* Quantity (cancellation / return)
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '1.00000'
			When '$WindowTitle$' window is opened
			And I click the button named 'CancelAction'
			When '$WindowTitle$' window is opened
			And I click the button named 'RetryAction'

	* Verifying the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''            | ''           | ''          | "February 2024" | ''            | ''            | ''           | ''          | "March 2024" | ''            | ''            | ''           | ''          | "TOTAL"       | ''            | ''             | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"        | "Date"       | "String"    | "Count"      | "ZoomRatio" | "Total"        | "Date"       | "String"    | "Count"   | "ZoomRatio" | "Total"        | "Date"       | "String"    | "Count"  | "ZoomRatio" | "Total"         | "Date"       | "String" |
			| "Total"                                                           | '1,001.94314'    | '7.00000'     | '7,013.60198' | '1/31/2024' | ''          | '1,003.76472'     | '0.26890'     | '269.91233'   | '1/1/2024' | ''          | '1,005.64488'  | '0.40320'     | '405.47602'   | '1/1/2024' | ''          | '3,011.35274' | '7.67210'     | '7,688.99033'  | '1/31/2024' | ''       |
			| "Goods"                                                         | '1,001.94314'    | '7.00000'     | '2,001.94314' | '1/1/2024' | ''          | '1,003.76472'     | '20.00000'    | '4,015.05888' | '1/1/2024' | ''          | '1,005.64488'  | '30.00000'    | '6,033.86928' | '1/1/2024' | ''          | '3,011.35274' | '57.00000'    | '12,050.87130' | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '1,000.00000'    | '2.00000'     | '2,000.00000' | '1/1/2024' | "Line1"   | '1,000.00000'     | '4.00000'     | '4,000.00000' | '1/1/2024' | "Line1"   | '1,000.00000'  | '6.00000'     | '6,000.00000' | '1/1/2024' | "Line1"   | '3,000.00000' | '12.00000'    | '12,000.00000' | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '0'              | '2.00000'     | '0'           | '1/31/2024' | "LineUSD" | '0.53782'         | '4.00000'     | '2.15128'     | '1/1/2024' | "LineUSD" | '0.80641'      | '6.00000'     | '4.83846'     | '1/1/2024' | "LineUSD" | '1.34423'     | '12.00000'    | '6.98974'      | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '0.40421'        | '1.00000'     | '0.40421'     | '1/1/2024' | "Line1"   | '0.80673'         | '4.00000'     | '3.22692'     | '1/1/2024' | "Line1"   | '1.20962'      | '6.00000'     | '7.25772'     | '1/1/2024' | "Line1"   | '2.42056'     | '11.00000'    | '10.88885'     | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0.53893'        | '1.00000'     | '0.53893'     | '1/1/2024' | "Line1"   | '1.07563'         | '4.00000'     | '4.30252'     | '1/1/2024' | "Line1"   | '1.61282'      | '6.00000'     | '9.67692'     | '1/1/2024' | "Line1"   | '3.22738'     | '11.00000'    | '14.51837'     | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '1.00000'        | '1.00000'     | '1.00000'     | '1/1/2024' | "Line1"   | '1.34454'         | '4.00000'     | '5.37816'     | '1/1/2024' | "Line1"   | '2.01603'      | '6.00000'     | '12.09618'    | '1/1/2024' | "Line1"   | '4.36057'     | '11.00000'    | '18.47434'     | '1/1/2024' | ''       |
					
	* Changing currency to Euro
		And I set pivot table filter 'DisplayCurrency' with value 'EUR'
						
	* Verifying the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''            | ''           | ''          | "February 2024" | ''            | ''            | ''           | ''          | "March 2024" | ''            | ''            | ''           | ''          | "TOTAL"       | ''            | ''             | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"        | "Date"       | "String"    | "Count"      | "ZoomRatio" | "Total"        | "Date"       | "String"    | "Count"   | "ZoomRatio" | "Total"        | "Date"       | "String"    | "Count"  | "ZoomRatio" | "Total"         | "Date"       | "String" |
			| "Total"                                                           | '821.73483'      | '5.74098'     | '5,752.14393' | '1/31/2024' | ''          | '830.12297'       | '0.22240'     | '223.22005'   | '1/1/2024' | ''          | '843.72814'    | '0.33828'     | '340.19120'   | '1/1/2024' | ''          | '2,495.58594' | '6.30166'     | '6,315.55518'  | '1/31/2024' | ''       |
			| "Goods"                                                         | '821.73482'      | '7.00000'     | '1,641.87604' | '1/1/2024' | ''          | '830.12298'       | '20.00000'    | '3,320.49179' | '1/1/2024' | ''          | '843.72813'    | '30.00000'    | '5,062.36882' | '1/1/2024' | ''          | '2,495.58593' | '57.00000'    | '10,024.73665' | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '820.14118'      | '2.00000'     | '1,640.28240' | '1/1/2024' | "Line1"   | '827.00950'       | '4.00000'     | '3,308.03796' | '1/1/2024' | "Line1"   | '838.99213'    | '6.00000'     | '5,033.95276' | '1/1/2024' | "Line1"   | '2,486.14281' | '12.00000'    | '9,982.27312'  | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '0'              | '2.00000'     | '-0.00001'    | '1/31/2024' | "LineUSD" | '0.44478'         | '4.00000'     | '1.77913'     | '1/1/2024' | "LineUSD" | '0.67657'      | '6.00000'     | '4.05943'     | '1/1/2024' | "LineUSD" | '1.12135'     | '12.00000'    | '5.83855'      | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '0.33150'        | '1.00000'     | '0.33152'     | '1/1/2024' | "Line1"   | '0.66717'         | '4.00000'     | '2.66870'     | '1/1/2024' | "Line1"   | '1.01486'      | '6.00000'     | '6.08917'     | '1/1/2024' | "Line1"   | '2.01353'     | '11.00000'    | '9.08939'      | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '0.44200'        | '1.00000'     | '0.44199'     | '1/1/2024' | "Line1"   | '0.88957'         | '4.00000'     | '3.55822'     | '1/1/2024' | "Line1"   | '1.35314'      | '6.00000'     | '8.11886'     | '1/1/2024' | "Line1"   | '2.68471'     | '11.00000'    | '12.11907'     | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '0.82014'        | '1.00000'     | '0.82014'     | '1/1/2024' | "Line1"   | '1.11196'         | '4.00000'     | '4.44778'     | '1/1/2024' | "Line1"   | '1.69143'      | '6.00000'     | '10.14860'    | '1/1/2024' | "Line1"   | '3.62353'     | '11.00000'    | '15.41652'     | '1/1/2024' | ''       |
	
	* Saving
		When '$WindowTitle$' window is opened
		And I click the button named 'Apply'

	* Changing currency to Rubles
		And I set pivot table filter 'DisplayCurrency' with value 'RUB'
				
	* Verifying the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)"                    | "January 2024" | ''            | ''              | ''           | ''          | "February 2024" | ''            | ''              | ''           | ''          | "March 2024" | ''            | ''              | ''           | ''          | "TOTAL"         | ''            | ''              | ''           | ''       |
			| "VA - Recalculation in context (pivot table)"                    | "Count"     | "ZoomRatio" | "Total"          | "Date"       | "String"    | "Count"      | "ZoomRatio" | "Total"          | "Date"       | "String"    | "Count"   | "ZoomRatio" | "Total"          | "Date"       | "String"    | "Count"    | "ZoomRatio" | "Total"          | "Date"       | "String" |
			| "Total"                                                           | '74,364.61971'   | '519.54234'   | '520,552.34491' | '1/31/2024' | ''          | '74,654.70064'    | '20.00000'    | '20,074.64815'  | '1/1/2024' | ''          | '74,823.49902' | '30.00000'    | '30,168.83560'  | '1/1/2024' | ''          | '223,842.81937' | '569.54234'   | '570,795.82866' | '1/31/2024' | ''       |
			| "Goods"                                                         | '74,364.61971'   | '7.00000'     | '148,585.02028' | '1/1/2024' | ''          | '74,654.69990'    | '20.00000'    | '298,618.79959' | '1/1/2024' | ''          | '74,823.50051' | '30.00000'    | '448,940.99263' | '1/1/2024' | ''          | '223,842.82012' | '57.00000'    | '896,144.81250' | '1/1/2024' | ''       |
			| "5C:Corporate performance management"                                      | '74,220.39954'   | '2.00000'     | '148,440.79983' | '1/1/2024' | "Line1"   | '74,374.69990'    | '4.00000'     | '297,498.80034' | '1/1/2024' | "Line1"   | '74,403.50051' | '6.00000'     | '446,420.99933' | '1/1/2024' | "Line1"   | '222,998.59995' | '12.00000'    | '892,360.59950' | '1/1/2024' | ''       |
			| "2C:Corporation"                                                  | '-0.00017'       | '2.00000'     | '-0.00034'      | '1/31/2024' | "LineUSD" | '40.00000'        | '4.00000'     | '160.00074'     | '1/1/2024' | "LineUSD" | '60.00000'     | '6.00000'     | '359.99851'     | '1/1/2024' | "LineUSD" | '99.99983'      | '12.00000'    | '519.99891'     | '1/1/2024' | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '30.00000'       | '1.00000'     | '30.00085'      | '1/1/2024' | "Line1"   | '60.00000'        | '4.00000'     | '240.00149'     | '1/1/2024' | "Line1"   | '90.00000'     | '6.00000'     | '539.99926'     | '1/1/2024' | "Line1"   | '180.00000'     | '11.00000'    | '810.00160'     | '1/1/2024' | ''       |
			| "1C:ERP. Corporate performance management"                                   | '40.00000'       | '1.00000'     | '39.99966'      | '1/1/2024' | "Line1"   | '80.00000'        | '4.00000'     | '319.99851'     | '1/1/2024' | "Line1"   | '120.00000'    | '6.00000'     | '719.99702'     | '1/1/2024' | "Line1"   | '240.00000'     | '11.00000'    | '1,079.99519'   | '1/1/2024' | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '74.22034'       | '1.00000'     | '74.22028'      | '1/1/2024' | "Line1"   | '100.00000'       | '4.00000'     | '399.99851'     | '1/1/2024' | "Line1"   | '150.00000'    | '6.00000'     | '899.99851'     | '1/1/2024' | "Line1"   | '324.22034'     | '11.00000'    | '1,374.21730'   | '1/1/2024' | ''       |
									
Scenario: 02.16 Changing indicators in a currency not from the regulation

	* Opening a pivot table
		And I open report pivot table with name "VA - Recalculation in context"
		And I set pivot table filter 'DisplayCurrency' with value 'KZT'

	* Checking the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)" | "January 2024" | ''            | ''     | ''     | ''       | "February 2024" | ''            | ''     | ''     | ''       | "March 2024" | ''            | ''     | ''     | ''       | "TOTAL"      | ''            | ''     | ''     | ''       |
			| "VA - Recalculation in context (pivot table)" | "Count"     | "ZoomRatio" | "Total" | "Date" | "String" | "Count"      | "ZoomRatio" | "Total" | "Date" | "String" | "Count"   | "ZoomRatio" | "Total" | "Date" | "String" | "Count" | "ZoomRatio" | "Total" | "Date" | "String" |
			| "Total"                                        | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |
			| "Goods"                                      | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |
		
	* Adding values
		When '$WindowTitle$' window is opened
		And I add values with indicator expansion in cell 'R5C2'
			| "VA0Product"                | 'Value1' |
			| "5C:Corporate performance management" | '100.00000' |

	* A protocol should appear
		Then "Protocol" window is opened
		Then 'SpreadsheetDocumentField' spreadsheet document is equal
			| "Errors"                                                                                                                                                                                  |
			| "The selected currency KZT does not correspond to the currencies set in parameter regulation:\n	Scenario: \"VA - Main scenario\",\n	Company: \"Mercury LLC\",\n	Period: \"January 2024\"" |
		When "Protocol" window is opened
		And I close "Protocol" window

	* Checking the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Recalculation in context (pivot table)" | "January 2024" | ''            | ''     | ''     | ''       | "February 2024" | ''            | ''     | ''     | ''       | "March 2024" | ''            | ''     | ''     | ''       | "TOTAL"      | ''            | ''     | ''     | ''       |
			| "VA - Recalculation in context (pivot table)" | "Count"     | "ZoomRatio" | "Total" | "Date" | "String" | "Count"      | "ZoomRatio" | "Total" | "Date" | "String" | "Count"   | "ZoomRatio" | "Total" | "Date" | "String" | "Count" | "ZoomRatio" | "Total" | "Date" | "String" |
			| "Total"                                        | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |
			| "Goods"                                      | '0'              | '0'           | '0'    | ''     | ''       | '0'               | '0'           | '0'    | ''     | ''       | '0'            | '0'           | '0'    | ''     | ''       | '0'          | '0'           | '0'    | ''     | ''       |
