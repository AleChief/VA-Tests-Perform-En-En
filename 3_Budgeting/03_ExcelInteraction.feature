#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 03. Exporting templates and importing report instances from Excel

	As Administrator I want to
	Checking that export and import from Excel work
	To import report instances from files

Background:

	And I close all client application windows

Scenario: 03.00 Determining the application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 03.01 Creating a report with groups and 6 dimensions

	And I create report type with name "VA - ImportExcel" and parent "VA - Report group"

	* Creating report rows
		And I open report wizard with name "VA - ImportExcel"
		And I add rows in report wizard
			| 'Description'              |
			| "Line_Synthetic_1"        |
			| "Group_Synthetic"          |
			| "Line_Synthetic_2"        |
			| "Group_Dimensions_0"        |
			| "Group_Dimensions_1_2"      |
			| "Line_Dimensions_1"        |
			| "Line_Dimensions_2"        |
			| "Group_Dimensions_6"        |
			| "Line_Dimensions_6"        |
			| "Group_Currency"             |
			| "Line_Dimensions_6_Currency" |

	* Setting the row hierarchy
		And I change row parent to "Group_Dimensions_0" in cell 'R6C1' in report wizard
		And I change row parent to "Group_Dimensions_0" in cell 'R9C1' in report wizard
		And I change row parent to "Group_Currency" in cell 'R12C1' in report wizard
		And I change row parent to "Group_Dimensions_6" in cell 'R11C1' in report wizard
		And I change row parent to "Group_Dimensions_6" in cell 'R12C1' in report wizard
		And I change row parent to "Group_Dimensions_1_2" in cell 'R12C1' in report wizard
		And I change row parent to "Group_Dimensions_1_2" in cell 'R12C1' in report wizard
		And I change row parent to "Group_Synthetic" in cell 'R4C1' in report wizard
	
	* Creating report columns
		And I add columns in report wizard
			| 'Description' |
			| "Date"         |
			| "Boolean"       |
			| "Line"         |
			| "Count"      |
			| "Amount"        |

	* Configuring indicator types
		And I change indicator properties 'ValueType' to "Date" in cell 'R2C2:R12C2' in report wizard
		And I change indicator properties 'ValueType' to "Boolean" in cell 'R2C3:R12C3' in report wizard
		And I change indicator properties 'ValueType' to "Line" in cell 'R2C4:R12C4' in report wizard

	* Entering dimensions
		* Dimension "Counterparties"
			And I add dimension with code "VA0Counter" in cell 'R7C2' in report wizard
			Then "Report wizard" window is opened
			And I click the button named 'CopyDimension'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R8C2' cell
			And I click the button named 'InsertDimension'
			And I click the button named 'CopyDimension'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C2' cell
			And I click the button named 'InsertDimension'
			And I click the button named 'CopyDimension'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C2' cell
			And I click the button named 'InsertDimension'
		* Dimension "Counterparty contracts"
			And I add dimension with code "VA0Contrac" in cell 'R8C3' in report wizard
			Then "Report wizard" window is opened
			And I click the button named 'CopyDimension'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C3' cell
			And I click the button named 'InsertDimension'
			And I click the button named 'CopyDimension'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C3' cell
			And I click the button named 'InsertDimension'
		* Dimension "Product categories"
			And I add dimension with code "VA0ProCate" in cell 'R10C4' in report wizard
			And I click the button named 'CopyDimension'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C4' cell
			And I click the button named 'InsertDimension'
		* Dimension "Product range"
			And I add dimension with code "VA0Product" in cell 'R10C5' in report wizard
			And I click the button named 'CopyDimension'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C5' cell
			And I click the button named 'InsertDimension'
		* Dimension "Cash flow items"
			And I add dimension with code "VA0CFItems" in cell 'R10C6' in report wizard
			And I click the button named 'CopyDimension'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C6' cell
			And I click the button named 'InsertDimension'
		* Dimension "Income and expense items"
			And I add dimension with code "VA0IEItems" in cell 'R10C7' in report wizard
			And I click the button named 'CopyDimension'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C7' cell
			And I click the button named 'InsertDimension'
		* Dimension Currency
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C8' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	* Comparing the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| 'String'                    | "Dimension 1" | "Dimension 2"           | "Dimension 3"        | "Dimension 4"  | "Dimension 5" | "Dimension 6"               | "Drilldown by currencies" | "Settings" |
			| "Line_Synthetic_1"        | ''            | ''                      | ''                   | ''             | ''            | ''                          | ''                     | ''          |
			| "Group_Synthetic"          | ''            | ''                      | ''                   | ''             | ''            | ''                          | ''                     | ''          |
			| "Line_Synthetic_2"        | ''            | ''                      | ''                   | ''             | ''            | ''                          | ''                     | ''          |
			| "Group_Dimensions_0"        | ''            | ''                      | ''                   | ''             | ''            | ''                          | ''                     | ''          |
			| "Group_Dimensions_1_2"      | ''            | ''                      | ''                   | ''             | ''            | ''                          | ''                     | ''          |
			| "Line_Dimensions_1"        | "Counterparties" | ''                      | ''                   | ''             | ''            | ''                          | ''                     | ''          |
			| "Line_Dimensions_2"        | "Counterparties" | "Counterparty contracts" | ''                   | ''             | ''            | ''                          | ''                     | ''          |
			| "Group_Dimensions_6"        | ''            | ''                      | ''                   | ''             | ''            | ''                          | ''                     | ''          |
			| "Line_Dimensions_6"        | "Counterparties" | "Counterparty contracts" | "Product categories" | "Product range" | "Cash flow items"  | "Income and expense items" | ''                     | ''          |
			| "Group_Currency"             | ''            | ''                      | ''                   | ''             | ''            | ''                          | ''                     | ''          |
			| "Line_Dimensions_6_Currency" | "Counterparties" | "Counterparty contracts" | "Product categories" | "Product range" | "Cash flow items"  | "Income and expense items" | '■'                    | ''          |

	* Configuring calculation formulas
		* Group_Synthetic
			And I set cell copy formula 'R4C2' for cell 'R3C2' in report wizard
			And I set cell copy formula 'R4C3' for cell 'R3C3' in report wizard
			And I set cell copy formula 'R4C4' for cell 'R3C4' in report wizard
			And I set cell copy formula 'R4C5' for cell 'R3C5' in report wizard
			And I set cell sum formula 'R4C6' for cell 'R3C6' in report wizard
		* Group_Dimensions_0
			And I set formula 'MAX({VAImportExcel.GroupDimensions12_Date},{VAImportExcel.GroupDimensions6_Date})' for cell 'R5C2' in report wizard
			And I set formula 'MAX({VAImportExcel.GroupDimensions12_Boolean}, {VAImportExcel.GroupDimensions6_Boolean})' for cell 'R5C3' in report wizard
			And I set sum formula for cell 'R6C5' of cells 'R9C5' 'R5C5' in report wizard
			And I set sum formula for cell 'R6C6' of cells 'R9C6' 'R5C6' in report wizard
		* Group_Dimensions_1_2
			And I set formula 'MAX({VAImportExcel.LineDimensions1_Date}, {VAImportExcel.LineDimensions2_Date})' for cell 'R6C2' in report wizard
			And I set formula 'MAX({VAImportExcel.LineDimensions1_Boolean}, {VAImportExcel.LineDimensions2_Boolean})' for cell 'R6C3' in report wizard
			And I set sum formula for cell 'R7C5' of cells 'R8C5' 'R6C5' in report wizard
			And I set cell sum formula 'R7C6:R8C6' for cell 'R6C6' in report wizard
		* Group_Dimensions_6
			And I set formula 'MAX({VAImportExcel.LineDimensions6_Date}, {VAImportExcel.GroupCurrency_Date})' for cell 'R9C2' in report wizard
			And I set formula 'MAX({VAImportExcel.LineDimensions6_Boolean}, {VAImportExcel.GroupCurrency_Boolean})' for cell 'R9C3' in report wizard
			And I set cell sum formula 'R10C5:R11C5' for cell 'R9C5' in report wizard
			And I set sum formula for cell 'R10C6' of cells 'R11C6' 'R9C6' in report wizard
		* Group_Currency
			And I set cell copy formula 'R12C2' for cell 'R11C2' in report wizard
			And I set cell copy formula 'R12C3' for cell 'R11C3' in report wizard
			And I set cell copy formula 'R12C5' for cell 'R11C5' in report wizard
			And I set cell copy formula 'R12C6' for cell 'R11C6' in report wizard

	* Configuring the information base type
		When "Report wizard" window is opened
		And I click Open button of the field named 'ProcessingRule'
		Then "VA - ImportExcel (Calculation rules)" window is opened
		And I click Choice button of the field named 'DBType'
		And I search and select element "Microsoft Excel files" "At beginning of line" by field "Description" in list "Infobase types"
		And I click the button named 'FormWriteAndClose'
		And I wait "VA - ImportExcel (Calculation rules) *" window closing in 20 seconds

Scenario: 03.02 Creating an external information base "VA - Import from Excel"

	And I create external information base "VA - Import from Excel" type "Microsoft Excel files" catalog "$ProjectPath$\3_Budgeting\Layouts\03" storage type ''

	* Testing the name mask mechanism
		Then the form attribute named 'FullNameMask' became equal to "$ProjectPath$\3_Budgeting\Layouts\03\*.xls?"
		When '$WindowTitle$' window is opened
		And I click the button named 'NameStructureFill'
		Then 'NameStructure' table became equal
			| "Separator"  | "Key attribute" |
			| '\\'           | "Scenario period"   |
			| '\\'           | "Scenario"          |
			| '\\'           | "Company"       |
			| '\\'           | "Project"            |
			| '\\'           | "Report type"        |
		Then the form attribute named 'FullNameMask' became equal to "$ProjectPath$\3_Budgeting\Layouts\03\<Scenario period>\<Scenario>\<Company>\<Project>\<Report type>.xls?"
		When '$WindowTitle$' window is opened
		And I go to line in 'NameStructure' table:
			| "Separator" | "Key attribute" |
			| '\\'          | "Scenario period"   |
		And I click the button named 'NameStructureDelete'
		And I click the button named 'NameStructureDelete'
		And I click the button named 'NameStructureDelete'
		And I click the button named 'NameStructureDelete'
		And I click the button named 'NameStructureAdd'
		And I select "+" exact value from the drop-down list named 'NameStructureStartElement' in 'NameStructure' table
		And I select "Company" exact value from the drop-down list named 'NameStructureItem' in 'NameStructure' table
		And I cancel line editing in 'NameStructure' table
		Then the form attribute named 'FullNameMask' became equal to "$ProjectPath$\3_Budgeting\Layouts\03\<Report type>+<Company>.xls?"

	* Configuring path elements
		Then '$WindowTitle$' window is opened
		And I click the button named 'OpenCompaniesFilesExchangeSettings'
		And I add company files path element for type 'Organization' object "Mercury LLC" value "Mercury"
		And I add company files path element for type 'ReportKind' object "VA - ImportExcel" value "VA_ImportExcel"
		Then "Company file path items: List form" window is opened
		And I click the button named 'FormClose'

	* Saving and closing the element
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 03.03 Creating a multi-period report template and export to Excel

	And I create default import template for report type "VA - ImportExcel"

	* Filling the sheet name
		Then '$WindowTitle$' window is opened
		And I input 'TDSheet' text in the field named 'SheetName'
		And I click the button named 'RecordButtonForm'

	* Saving the template
		Then '$WindowTitle$' window is opened
		And I click the button named 'ExportTemplate'
		Then "Save report template" window is opened
		And I select from the drop-down list named 'ExternalIB'  by "VA - Import from Excel" string
		And I input "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Template.xlsx" text in the field named 'UploadFileName'
		And I select "Month" exact value from the drop-down list named 'Periodicity'
		And I input '3' text in the field named 'NumberOfPeriods'
		And I click the button named 'FormExport'
		Then '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window

	* Comparing the file
		And In the command interface I select "Budgeting, reporting, and analysis" "Compare spreadsheet documents"
		Then "Compare spreadsheet documents" window is opened
		And I input "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Template.xlsx" text in the field named 'DocumentPath1'
		And I input "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Template.mxl" text in the field named 'DocumentPath2'
		And I set checkbox named 'AreOnlyValuesCompared'
		And I set checkbox named 'ShouldCompareByTemplate'
		And I click the button named 'FormCompareDocuments'
		Then "Documents are identical: Compare spreadsheet documents" window is opened
		And I close "Documents are identical: Compare spreadsheet documents" window

	* Configuring sorting
		And I change sorting "Product range" "Description" to sorting "Product range" "Product ID" in template for expansion group with address 'R18C1' for report type "VA - ImportExcel"
		And I change sorting "Product range" "Description" to sorting "Product range" "Product ID" in template for expansion group with address 'R21C1' for report type "VA - ImportExcel"

Scenario: 03.04 Creating a pivot table template

	And I for report type "VA - ImportExcel" create default pivot table template with filters

	And I open default pivot table template for report type "VA - ImportExcel"

	* Configuring the dimension order
		When '$WindowTitle$' window is opened
		And I click the button named 'ShowTableSettingsByAxes'
		And I move dimension with name "Additional currencies" up in pivot table
		And I move dimension with name "Income and expense items" up in pivot table
		And I move dimension with name "Cash flow items" up in pivot table
		And I move dimension with name "Product range" up in pivot table
		And I move dimension with name "Product categories" up in pivot table
		And I move dimension with name "Counterparty contracts" up in pivot table
		And I move dimension with name "Counterparties" up in pivot table

	* Configuring sorting for the Nomenclature dimension
		When "Set up field location" window is opened
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Product range"               |
		And I select current line in 'TableRows1' table
		Then "Dimension display parameters (Product range)" window is opened
		And I click Choice button of the field named 'DCSettingsOrderSettings'
		Then "Edit order" window is opened
		And I select current line in 'Data' table
		And I select "Product range.Product ID" exact value from the drop-down list named 'DataField' in 'Data' table
		And I finish line editing in 'Data' table
		And I click the button named 'OK'
		When "Dimension display parameters (Product range)" window is opened
		And the form attribute named 'DCSettingsOrderSettings' became equal to "Product range.Product ID"
		And the form attribute named 'ShouldSupportHierarchy1' became equal to 'No'
		And I click the button named 'FormApply'

	* Configuring dimension output
		When "Set up field location" window is opened
		And I click the button named 'DimensionsLayoutOption'
		And on the form menu I select "Adjacent dimensions"
		And I change checkbox named 'TotalByColumns'
		And I click the button named 'ButtonApply'
	
	* Saving a template
		When '$WindowTitle$' window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 03.05 Configuring the report filling method

	And I create report instance for report type "VA - ImportExcel" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''
	
	Then '$WindowTitle$' window is opened
	And I click the button named 'FormOpenSettings'
	Then "Document settings" window is opened
	When "Document settings" window is opened
	And I move to the tab named 'GroupPageReportSettings'
	And I select "Import" exact value from the drop-down list named 'ReportGenerationMethod'
	And I select from the drop-down list named 'ExternalInfobase'  by "VA - Import from Excel" string
	Then the form attribute named 'TemplateForImport' became equal to "VA - ImportExcel"
	And I click the button named 'FormApplyAndClose'

Scenario: 03.06 Configuring rights for the user "Budgeting1"

	And I add right "Read, write" for report type "VA - ImportExcel" user "Budgeting1" for all companies
	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 03.07 Creating a report instance - "VA - ImportExcel" and loading from a file

	And I create report instance for report type "VA - ImportExcel" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''
		
	* The document should be empty
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\03\VA_ImportExcel_Empty.mxl"

	* Checking settings
		When '$WindowTitle$' window is opened
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I move to the tab named 'GroupPageReportSettings'
		And the form attribute named 'ReportGenerationMethod' became equal to "Import"
		And the form attribute named 'ProcessingRule' became equal to "VA - ImportExcel"
		And the form attribute named 'ExternalInfobase' became equal to "VA - Import from Excel"
		And the form attribute named 'CheckRule' became equal to "VA - ImportExcel"
		And the form attribute named 'TemplateForImport' became equal to "VA - ImportExcel"
		And I select "By processing rule" exact value from the drop-down list named 'ReportGenerationMethod'
		And I close "Document settings *" window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

	* Loading without a file
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillInUsingAnotherApproach'
		When "Select method to calculate indicators" window is opened
		And the form attribute named 'ReportGenerationMethod' became equal to "Import"
		And the form attribute named 'ProcessingRule' became equal to "VA - ImportExcel"
		And the form attribute named 'ExternalInfobase' became equal to "VA - Import from Excel"
		And the form attribute named 'CheckRule' became equal to "VA - ImportExcel"
		And the form attribute named 'TemplateForImport' became equal to "VA - ImportExcel"
		And the form attribute named 'ImportApproach' became equal to "0"
		And I change the radio button named 'ImportApproach' value to "File on hard drive"
		And I click the button named 'FormSelect'
		When '$WindowTitle$' window is opened
		Затем я жду, что в сообщениях пользователю будет подстрока "Imported file path not specified. Operation canceled." в течение 30 секунд
		And I clear user message window
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\03\VA_ImportExcel_Empty.mxl"

	* Loading an incorrect file
		And I click the button named 'FormFillInUsingAnotherApproach'
		When "Select method to calculate indicators" window is opened
		Then the editing text of form attribute named 'ReportGenerationMethod' became equal to "Import"
		Then the editing text of form attribute named 'TemplateForImport' became equal to "VA - ImportExcel"
		And the form attribute named 'ImportApproach' became equal to "2"
		And I input "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Error.xlsx" text in the field named 'PathToFile'
		And I click the button named 'FormSelect'
		When "Protocol" window is opened
		Then 'SpreadsheetDocumentField' spreadsheet document is equal by template
			| "Errors"                                            |
			| "In file * no line * was found. Import was aborted." |
		And I close "Protocol" window
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Empty.mxl"

	* Loading with a file
		And I click the button named 'FormFillInUsingAnotherApproach'
		When "Select method to calculate indicators" window is opened
		Then the editing text of form attribute named 'ReportGenerationMethod' became equal to "Import"
		Then the editing text of form attribute named 'TemplateForImport' became equal to "VA - ImportExcel"
		Then the form attribute named 'ImportApproach' became equal to "1"
		Then the editing text of form attribute named 'ImportFile3' became equal to "VA_ImportExcel_Error.xlsx"
		And I change the radio button named 'ImportApproach' value to "File on hard drive"
		Then the editing text of form attribute named 'PathToFile' became equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Error.xlsx"
		And I input "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury.xlsx" text in the field named 'PathToFile'
		And I click the button named 'FormSelect'
		When "Spreadsheet document import parameters" window is opened
		And 'SheetsList' table became equal
			| "Sheet name" | "Password protected" |
			| 'TDSheet'   | "No"             |
			| '2Sheet'    | "No"             |
		And I go to line in 'SheetsList' table:
			| "Sheet name" | "Password protected" |
			| 'TDSheet'   | "No"             |
		And I click the button named 'OkCommand'
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury.mxl"

	* Checking the action history
		Then '$WindowTitle$' window is opened
		And I click the button named 'CancelApplyDetailed'
		Then "Action history" window is opened
		Then 'Transactions_' table became equal
			| "Transaction presentation" |
			| "Import from MS Excel"     |
		And I click the button named 'FormCancel'

	* Saving a document
		Then '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 30 seconds

Scenario: 03.08 Re-loading data from a file

	And I open first report instance for report type "VA - ImportExcel"
	Then I open report instance for report type "VA - ImportExcel" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
	
	* Clearing indicators
		Then '$WindowTitle$' window is opened
		And I click the button named 'Edit'
		And I click the button named 'Clear'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Empty.mxl"
		Then '$WindowTitle$' window is opened
		And I click the button named 'Write'

	* Loading the same file again
		And I click the button named 'FormFillInUsingAnotherApproach'
		When "Select method to calculate indicators" window is opened
		And I select "Import" exact value from the drop-down list named 'ReportGenerationMethod'
		Then the form attribute named 'ImportApproach' became equal to "1"
		And I change the radio button named 'ImportApproach' value to "File on hard drive"
		Then the editing text of form attribute named 'PathToFile' became equal to ""
		And I input "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury.xlsx" text in the field named 'PathToFile'
		And I click the button named 'FormSelect'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Empty.mxl"

	* Loading the file again
		And I click the button named 'FormFillInUsingAnotherApproach'
		When "Select method to calculate indicators" window is opened
		And I select "Import" exact value from the drop-down list named 'ReportGenerationMethod'
		And the form attribute named 'ImportApproach' became equal to "1"
		And the form attribute named 'ImportFile3' became equal to "VA_ImportExcel_Mercury.xlsx"
		And the form attribute named 'TemplateForImport' became equal to "VA - ImportExcel"
		And I click the button named 'FormSelect'
		When "Select file version" window is opened
		And 'SheetsList' table became equal
			| "Document sheet" | "Password protected" |
			| 'TDSheet'        | "No"             |
			| '2Sheet'         | "No"             |
		And I go to line in 'SheetsList' table:
			| "Document sheet" | "Password protected" |
			| 'TDSheet'        | "No"             |
		And I click the button named 'FormOK'
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury.mxl"

	* Canceling the load
		Then '$WindowTitle$' window is opened
		And I click the button named 'CancelAction'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Empty.mxl"

	* Calculating by regulation
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormFillByDefault'
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury.mxl"
		And I click the button named 'Write'

	* Selecting the second file
		And I click the button named 'FormFillInUsingAnotherApproach'
		When "Select method to calculate indicators" window is opened
		And I change the radio button named 'ImportApproach' value to "File on hard drive"
		And I input "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_2.xlsm" text in the field named 'PathToFile'
		And I click the button named 'FormSelect'
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_2.mxl"
	
	* Filling from an external base
		And I click the button named 'FormFillInUsingAnotherApproach'
		When "Select method to calculate indicators" window is opened
		And I change the radio button named 'ImportApproach' value to "External infobase"
		And I select from the drop-down list named 'ExternalInfobase'  by "VA - Import from Excel" string
		And I click the button named 'FormSelect'
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury.mxl"

	* Rolling back calculation
		Then '$WindowTitle$' window is opened
		And I click the button named 'CancelAction'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_2.mxl"

	* Closing the document
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 03.09 Creating a pivot table

	* Opening a pivot table
		And I open report pivot table with name "VA - ImportExcel"
		And I set pivot table filters: start date '1/1/2024', end date '3/31/2024', currency 'RUB', scenario "VA - Main scenario", company "Mercury LLC"

	* Verifying the table
		When '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_2_PivotTable.mxl"

	* Loading without a file
		When '$WindowTitle$' window is opened
		And I click the button named 'RecalculateOther'
		Then "Select method to calculate indicators" window is opened
		And the form attribute named 'ReportGenerationMethod' became equal to "Import"
		And the form attribute named 'ProcessingRule' became equal to "VA - ImportExcel"
		And the form attribute named 'ExternalInfobase' became equal to "VA - Import from Excel"
		And the form attribute named 'CheckRule' became equal to "VA - ImportExcel"
		And the form attribute named 'TemplateForImport' became equal to "VA - ImportExcel"
		Then the form attribute named 'ImportApproach' became equal to "0"
		And I change the radio button named 'ImportApproach' value to "File on hard drive"
		And I click the button named 'FormSelect'
		When '$WindowTitle$' window is opened
		Затем я жду, что в сообщениях пользователю будет подстрока "Imported file path not specified. Operation canceled." в течение 30 секунд
		And I clear user message window

	* Loading an incorrect file
		When '$WindowTitle$' window is opened
		And I click the button named 'RecalculateOther'
		When "Select method to calculate indicators" window is opened
		Then the editing text of form attribute named 'ReportGenerationMethod' became equal to "Import"
		Then the editing text of form attribute named 'TemplateForImport' became equal to "VA - ImportExcel"
		Then the form attribute named 'ImportApproach' became equal to "2"
		And I input "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Error.xlsx" text in the field named 'PathToFile'
		And I click the button named 'FormSelect'
		And I wait "Protocol" window opening in 20 seconds
		Then 'SpreadsheetDocumentField' spreadsheet document is equal by template
			| "Errors"                                            |
			| "In file * no line * was found. Import was aborted." |
		And I close "Protocol" window
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_2_PivotTable.mxl"

	* Loading by regulation
		Then '$WindowTitle$' window is opened
		And I click the button named 'RecalculateAccordingToRegulations'
		And I wait for '$WindowTitle$' form opening for 30 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_PivotTable.mxl"

	* Rolling back changes
		Then '$WindowTitle$' window is opened
		And I click the button named 'CancelAction'
		And I wait for '$WindowTitle$' form opening for 30 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_2_PivotTable.mxl"

	* Loading by external information base
		And I click the button named 'RecalculateOther'
		When "Select method to calculate indicators" window is opened
		And I change the radio button named 'ImportApproach' value to "External infobase"
		And I select from the drop-down list named 'ExternalInfobase'  by "VA - Import from Excel" string
		And I click the button named 'FormSelect'
		And I wait for '$WindowTitle$' form opening for 30 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_PivotTable.mxl"

	* Clearing part of the indicators
		Then '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R10C9:R28C9" cell
		And I click the button named 'ClearRange'
	
	* Loading with a file
		And I click the button named 'RecalculateOther'
		When "Select method to calculate indicators" window is opened
		And I change the radio button named 'ImportApproach' value to "File on hard drive"
		And I input "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_2.xlsm" text in the field named 'PathToFile'
		And I click the button named 'FormSelect'

	* Verifying the result
		And I wait for '$WindowTitle$' form opening for 30 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_2_PivotTable.mxl"

	* Checking the action history
		Then '$WindowTitle$' window is opened
		And I click the button named 'CancelApplyDetailed'
		Then "Action history" window is opened
		Then 'Transactions_' table became equal
			| "Transaction presentation" |
			| "Import from MS Excel"     |
			| "Clear cell range"  |
			| "Import from MS Excel"     |
		And I click the button named 'FormCancel'

	* Saving
		Then '$WindowTitle$' window is opened
		And I click the button named 'Apply'
		And I click the button named 'UpdateTabData'
				
	* Verifying the result
		And I wait for '$WindowTitle$' form opening for 20 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "$ProjectPath$\3_Budgeting\Layouts\03\VA_ImportExcel_Mercury_2_PivotTable.mxl"
