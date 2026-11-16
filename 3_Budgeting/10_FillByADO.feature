#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 10. Calculation of indicators with ADO filling

	As Administrator I want to
	Check that ADO data is loaded into report instances

Background:

	And I close all client application windows

Scenario: 10.00 Determining the application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 10.01 Creating information bases

	And I create information base type with name "VA - ADO Import (Excel)" version "Connect via ADO"

	And I create external information base "VA - ADO Import (Excel)" type "VA - ADO Import (Excel)" catalog "$ProjectPath$\3_Budgeting\Layouts\10\ADO_En" storage type 'Excel'

Scenario: 10.02 Configuring information bases

	* Enabling reference data management
		And In the command interface I select "General catalogs and settings" "General settings"
		Then "General settings*" window is opened
		And I set checkbox named 'UseMasterDataManagement'
		And I click the button named 'FormWriteAndClose'
		And I wait "General settings*" window closing in 20 seconds

	And In the command interface I select "Integration and master data management" "Infobase types"
	And I search and select element "VA - ADO Import (Excel)" "At the beginning of the line" by field "Description" in list "Infobase types"
	Then "VA - ADO Import (Excel) (Infobase type)" window is opened
	And I select from the drop-down list named 'DefaultEIB'  by "VA - ADO Import (Excel)" string
	And I click the button named 'FormWrite'
	Then "VA - ADO Import (Excel) (Infobase type)" window is opened
	And In this window I click command interface button "ADO tables"
	And in the table 'List' I click the button named 'UpdateListOfTables'
	When "VA - ADO Import (Excel) (Infobase type)" window is opened
	And In this window I click command interface button "Correspondence with external infobases"
	
	* Nomenclature
		And I click the button named 'FormCreate'
		Then "Correspondence with external infobases (create)" window is opened
		And I click Choice button of the field named 'ObjectDetailsEIB'
		Then "ADO tables" window is opened
		And I select current line in 'List' table
		Then "Correspondence with external infobases (create) *" window is opened
		And I select "Catalog" exact value from the drop-down list named 'ConsolidationObjectType'
		And I click Choice button of the field named 'CrntObjectDetails'
		Then "Infobase catalogs" window is opened
		And I go to line in 'List' table:
			| "Not in the configuration" | "Under approval" | "Catalog"   |
			| "No"                        | "No"         | "Product range" |
		And I select current line in 'List' table
		* Name
			Then "Correspondence with external infobases (create) *" window is opened
			And I go to line in 'ComplianceTable' table:
				| "Field"         |
				| "Description" |
			And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I go to line in 'DBDimensionsTableBox' table:
				| "Used in mapping" | "Field"         |
				| "No"                          | "Product range" |
			And I select context menu item named 'ComplianceTableContextMenuCommandBarMapsButtonMapDimensions' of the form attribute named 'ComplianceTable'
		* Article number
			And I go to line in 'ComplianceTable' table:
				| "Field"    |
				| "Product ID" |
			And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I go to line in 'DBDimensionsTableBox' table:
				| "Used in mapping" | "Field"    |
				| "No"                          | "Product ID" |
			And I select context menu item named 'ComplianceTableContextMenuCommandBarMapsButtonMapDimensions' of the form attribute named 'ComplianceTable'
			And I go to line in 'ComplianceTable' table:
				| "Source" | "Key" | "Field"    | "Filling method" |
				| "Product ID"  | "No"      | "Product ID" | "Source field"    |
			And I activate field named 'MapTableOfKeyOne' in 'ComplianceTable' table
			And I change checkbox named 'MapTableOfKeyOne' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
		* Nomenclature type
			If 'NOT $$IsPerform$$' Then
				When "Correspondence with external infobases (create) *" window is opened
				And I go to line in 'ComplianceTable' table:
					| "Field"             |
					| "Nomenclature type" |
				And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I finish line editing in 'ComplianceTable' table
				And I activate field named 'MappingTableEIBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				And I search and select element "VA - Products" "At the beginning of the line" by field "Description" in list "Enter a value"
		* Nomenclature group
			If 'NOT $$IsERPCPM$$' Then
				When "Correspondence with external infobases (create) *" window is opened
				And I go to line in 'ComplianceTable' table:
					| "Field"                  |
					| "Product range group" |
				And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I finish line editing in 'ComplianceTable' table
				And I activate field named 'MappingTableEIBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				And I search and select element "VA - Product range group" "At the beginning of the line" by field "Description" in list "Enter a value"
		* Unit of measure
			When "Correspondence with external infobases (create) *" window is opened
			If '$$IsERPCPM$$' Then
				And I go to line in 'ComplianceTable' table:
					| "Field"             |
					| "Storage unit" |
			Else
				And I go to line in 'ComplianceTable' table:
					| "Field"    |
					| "Unit" |
			And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I select current line in 'ComplianceTable' table
			And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I activate field named 'MappingTableEIBAlias' in 'ComplianceTable' table
			And I select current line in 'ComplianceTable' table
			If '$$IsERPCPM$$' Then
				And I search and select element "PCs" "At the beginning of the line" by field "Description" in list "Enter a value"
			Else
				And I search and select element "Piece" "At the beginning of the line" by field "Description" in list "Enter a value"
		* Root directory
			If '$$IsCPM$$' Then
				And I click Choice button of the field named 'RootDirectory1'
				And I search element "VA - Products" "At the beginning of the line" by field "Reference" in list 'Catalog.Products'
				And in the table 'List' I click the button named 'ListChoose'
				Then the form attribute named 'RootDirectory1' became equal to "VA - Products"
		And I click the button named 'FormWriteAndClose'
		And I wait "Correspondence with external infobases (create) *" window closing in 20 seconds

	When "VA - ADO Import (Excel) (Infobase type)" window is opened
	And I click the button named 'FormCreate'
	Then "Correspondence with external infobases (create)" window is opened
	And I select "Sheet1$" exact value from the drop-down list named 'ObjectDetailsEIB'
	And I select "Catalog" exact value from the drop-down list named 'ConsolidationObjectType'
	And I click Choice button of the field named 'CrntObjectDetails'
	Then "Infobase catalogs" window is opened
	And I go to line in 'List' table:
		| "Not in the configuration" | "Under approval" | "Catalog"                |
		| "No"                        | "Yes"          | "Income and expense items" |
	And I select current line in 'List' table
	Then "Correspondence with external infobases (create) *" window is opened
	And I go to line in 'DBDimensionsTableBox' table:
		| "Used in mapping" | "Field"         |
		| "No"                          | "Activity" |
	And I go to line in 'ComplianceTable' table:
		| "Field"         |
		| "Description" |
	And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
	And I select context menu item named 'ComplianceTableContextMenuCommandBarMapsButtonMapDimensions' of the form attribute named 'ComplianceTable'
	And I go to line in 'ComplianceTable' table:
		| "Field" |
		| "Code"  |
	And I go to line in 'ComplianceTable' table:
		| "Source"     | "Key" | "Field"         | "Filling method" |
		| "Activity" | "No"      | "Description" | "Source field"    |
	And I activate field named 'MapTableOfKeyOne' in 'ComplianceTable' table
	And I change checkbox named 'MapTableOfKeyOne' in 'ComplianceTable' table
	And I finish line editing in 'ComplianceTable' table
	* Root directory
		And I click Choice button of the field named 'RootDirectory1'
		And I search element "VA - Income and expense items" "At the beginning of the line" by field "Reference" in list 'Catalog.IncomeAndExpenseItems'
		And in the table 'List' I click the button named 'ListChoose'
		Then the form attribute named 'RootDirectory1' became equal to "VA - Income and expense items"
	And I click the button named 'FormWriteAndClose'
	And I wait "Correspondence with external infobases (create) *" window closing in 20 seconds
	
	Then "VA - ADO Import (Excel) (Infobase type)" window is opened
	And In this window I click command interface button "Main"
	And In this window I click command interface button "ADO tables"
	And in the table 'List' I click the button named 'ListDataView'
	Then "ADO table view form" window is opened
	And I close "ADO table view form" window
	Then "VA - ADO Import (Excel) (Infobase type)" window is opened
	And I close "VA - ADO Import (Excel) (Infobase type)" window
	Then "Infobase types" window is opened
	And I close "Infobase types" window
			
Scenario: 10.03 Creating a report type

	And I create report type with name "VA - ADO Import (Excel)" and parent "VA - Report group"

	* Configuring the report structure
		And I open report wizard with name "VA - ADO Import (Excel)"
		And I add row with name "Sales" in report wizard
		And I add column with name "Price" in report wizard
		And I add column with name "Count" in report wizard
		And I add column with name "Product ID" in report wizard
		And I change indicator property 'ValueType' to "Line" in cell 'R2C4' in report wizard
		And I add dimension with code "VA0Product" in cell 'R2C2' in report wizard
		And I add dimension with code "VA0IEItems" in cell 'R2C3' in report wizard

	* File exchange settings
		Then "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And I click Open button of the field named 'ProcessingRule'
		Then "VA - ADO Import (Excel) (Calculation rules)" window is opened
		And I select from the drop-down list named 'DBType'  by "VA - ADO Import (Excel)" string
		And I click Open button of the field named 'DBType'
		Then "VA - ADO Import (Excel) (Infobase type)" window is opened
		And I click Open button of the field named 'DefaultEIB'
		Then "VA - ADO Import (Excel) (External infobases)" window is opened
		And I click the button named 'OpenCompaniesFilesExchangeSettings'
		And I add company files path element for type 'ReportKind' object "VA - ADO Import (Excel)" value "VA_LoadingADO"
		Then "Company file path items: List form" window is opened
		And I close "Company file path items: List form" window
		Then "VA - ADO Import (Excel) (External infobases)" window is opened
		And I close "VA - ADO Import (Excel) (External infobases)" window
		Then "VA - ADO Import (Excel) (Infobase type)" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "VA - ADO Import (Excel) (Infobase type)" window closing in 20 seconds
		Then "VA - ADO Import (Excel) (Calculation rules) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "VA - ADO Import (Excel) (Calculation rules) *" window closing in 20 seconds

	* Configuring formulas
		* Price
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select "Tables from ADO connection" exact value from the drop-down list named 'MethodOfObtaining'
			And I click Choice button of the field named 'ADOTable'
			Then "ADO tables" window is opened
			And I select current line in 'List' table
			Then "Data source (create) *" window is opened
			And I expand current line in 'FieldsTreeDB' table
			And I go to line in 'FieldsTreeDB' table:
				| "Field" |
				| "Price" |
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension" | "Column name"  | "Filling method" |
				| "Value"            | "[Count]" | "Source field"    |
			And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
			And I select context menu item named 'ButtonMapDimensions' of the form attribute named 'ComplianceTable'
			And I move to the tab named 'FiltersPage'
			And I go to line in 'FieldsTreeDB' table:
				| "Field"   |
				| "Period" |
			And I click the button named 'AddConditionItem'
			And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I select current line in 'TreeOfFilterParametersDB' table
			And I select "In interval" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			Then "Specify interval limit calculation methods" window is opened
			And I click the button named 'FormWrite'
			Then "Data source (create) *" window is opened
			And I finish line editing in 'TreeOfFilterParametersDB' table
			And I click the button named 'FormWriteAndClose'
			And I wait "Data source (create) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'
		* Quantities
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select "Tables from ADO connection" exact value from the drop-down list named 'MethodOfObtaining'
			And I select "Sheet1$" exact value from the drop-down list named 'ADOTable'
			And I move to the tab named 'FiltersPage'
			And I expand current line in 'FieldsTreeDB' table
			And I go to line in 'FieldsTreeDB' table:
				| "Field"   |
				| "Period" |
			And I click the button named 'AddConditionItem'
			And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I select current line in 'TreeOfFilterParametersDB' table
			And I select "In interval" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			Then "Specify interval limit calculation methods" window is opened
			And I click the button named 'FormWrite'
			Then "Data source (create) *" window is opened
			And I finish line editing in 'TreeOfFilterParametersDB' table
			And I click the button named 'FormWriteAndClose'
			And I wait "Data source (create) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'
		* Article number
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C4' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select "Tables from ADO connection" exact value from the drop-down list named 'MethodOfObtaining'
			And I select "Sheet1$" exact value from the drop-down list named 'ADOTable'
			And I expand current line in 'FieldsTreeDB' table
			And I go to line in 'FieldsTreeDB' table:
				| "Field"    |
				| "Product ID" |
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension" | "Filling method" |
				| "Value"            | "Source field"    |
			And I select context menu item named 'ButtonMapDimensions' of the form attribute named 'ComplianceTable'
			And I move to the tab named 'FiltersPage'
			And I expand current line in 'FieldsTreeDB' table
			And I go to line in 'FieldsTreeDB' table:
				| "Field"   |
				| "Period" |
			And I click the button named 'AddConditionItem'
			And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I select current line in 'TreeOfFilterParametersDB' table
			And I select "In interval" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			Then "Specify interval limit calculation methods" window is opened
			And I click the button named 'FormWrite'
			Then "Data source (create) *" window is opened
			And I finish line editing in 'TreeOfFilterParametersDB' table
			And I click the button named 'FormWriteAndClose'
			And I wait "Data source (create) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'
			Then "Report wizard" window is opened
			And I close "Report wizard" window

	* Creating a template
		And I create default template for report type "VA - ADO Import (Excel)"

Scenario: 10.04 Configuring information base directories

	And In the command interface I select "General catalogs and settings" "Catalogs"
	Then "Current infobase catalogs" window is opened
	And I go to line in 'List' table:
		| "Catalog"   |
		| "Product range" |
	And I select current line in 'List' table
	Then "Product range (Infobase catalogs)" window is opened
	And for each line of 'Attributes' table I do
		And I activate field named 'AttributesIsRequired' in 'Attributes' table
		And I remove checkbox named 'AttributesIsRequired' in 'Attributes' table
	And I click the button named 'FormWriteAndClose'
	And I wait "Product range (Infobase catalogs) *" window closing in 20 seconds
	Then "Current infobase catalogs" window is opened
	And I go to line in 'List' table:
		| "Catalog"     |
		| "Income and expense items" |
	And I select current line in 'List' table
	Then "Income and expense items (Infobase catalogs)" window is opened
	And for each line of 'Attributes' table I do
		And I activate field named 'AttributesIsRequired' in 'Attributes' table
		And I remove checkbox named 'AttributesIsRequired' in 'Attributes' table
	And I click the button named 'FormWriteAndClose'
	And I close "Current infobase catalogs" window

Scenario: 10.05 Creating a report instance

	And I create report instance for report type "VA - ADO Import (Excel)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''
	
	* Installing the information base
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I move to the tab named 'GroupPageReportSettings'
		And I select "VA - ADO Import (Excel)" exact value from the drop-down list named 'ExternalInfobase'
		And I click the button named 'FormApplyAndClose'
	
	* Performing calculation
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormFillByDefault'
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\10\VA_ImportADO.mxl"
		And I click the button named 'Write'
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormOpenDocumentRegisterRecordsFlatTab'
		Then "Flat table of indicator values" window is opened
		And I wait for filling of 'R2C1' cell in 'ReportSpreadsheetDocument' spreadsheet document for 60 seconds
		Given 'ReportSpreadsheetDocument' spreadsheet document is equal to "3_Budgeting\Layouts\10\VA_ImportADO_Movements.mxl" by template
		And I close "Flat table of indicator values" window
		Then '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window

Scenario: 10.06 Loading the second file

	* Opening the document
		And I open first report instance for report type "VA - ADO Import (Excel)"
		And I open report instance for report type "VA - ADO Import (Excel)" currency "RUB" company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
	
	* Checking the indicator calculation method form
		And I click the button named 'FormFillInUsingAnotherApproach'
		Then "Select method to calculate indicators" window is opened
		Then the form attribute named 'TemplateForImport' became equal to "VA - ADO Import (Excel)"
		And the form attribute named 'ExternalInfobase' became equal to "VA - ADO Import (Excel)"
		And the form attribute named 'ProcessingRule' became equal to "VA - ADO Import (Excel)"
		And the form attribute named 'CheckRule' became equal to "VA - ADO Import (Excel)"
		And the form attribute named 'ImportApproach' became equal to "0"
		And the form attribute named 'ReportGenerationMethod' became equal to "By processing rule"
	
	* Selecting a file
		And I change the radio button named 'ImportApproach' value to "File on hard drive"
		And I input "$ProjectPath$\3_Budgeting\Layouts\10\ADO_En2\VA_LoadADO2.xls" text in the field named 'PathToFile'
		And I click the button named 'FormSelect'

	* Verifying the result
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\10\VA_ImportADO2.mxl"

	* Filling by default
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormFillByDefault'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\10\VA_ImportADO.mxl"

	* Reloading the file
		And I click the button named 'FormFillInUsingAnotherApproach'
		Then "Select method to calculate indicators" window is opened
		And the form attribute named 'ImportApproach' became equal to "1"
		Then the form attribute named 'ImportFile3' became equal to "VA_LoadADO2.xls"
		And I change the radio button named 'ImportApproach' value to "File on hard drive"
		And I click the button named 'FormSelect'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

	* Reloading the file
		And I click the button named 'FormFillInUsingAnotherApproach'
		Then "Select method to calculate indicators" window is opened
		And I click the button named 'FormSelect'

	* Checking the file version selection form
		And I wait "Select file version" window opening in 20 seconds
		And the form attribute named 'StoredFile' became equal to "VA_LoadADO2.xls"
		And the form attribute named 'Password' became equal to ""
		And 'SheetsList' table became equal
			| "Document sheet" | "Password protected" |
			| "Sheet1"          | "No"             |
		And I click the button named 'FormOK'

	* Verifying the result
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\10\VA_ImportADO2.mxl"
	
	* Closing the document without saving
		Then '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 10.07 Changing the nomenclature type

	If '$$IsPerform$$' Then
		And I select value '' in group '' for attribute 'Product_Category' for nomenclature with name "2C:KP GU PROF for 12 months"
		And I select value '' in group '' for attribute 'Product_Category' for nomenclature with name "2C:KP GU PROF for 6 months"

	ElseIf '$$IsCPM$$' Then
		And In the command interface I select "Catalogs" "Product range"
		Then "Product range" window is opened
		And I go to line in 'List' table:
			| "Description"      |
			| "VA - Products" |
		And I move one level down in 'List' table

		* 1C:KP GU PROF for 12 months
			If 'List' table contains line Then
				| "Product ID"  | 'Unit' | "Description"                |
				| "30000012" | 'PCs'      | "2C:KP GU PROF for 12 months" |
				And I go to line in 'List' table:
					| "Product ID"  | 'Unit' | "Description"                |
					| "30000012" | 'PCs'      | "2C:KP GU PROF for 12 months" |
				And I select current line in 'List' table
				Then "2C:KP GU PROF for 12 months (Product range)" window is opened
				And I select from the drop-down list named 'ProductKind'  by 'DimenKind - Other' string
				And I click the button named 'FormWriteAndClose'
				And I wait "2C:KP GU PROF for 12 months (Product range) *" window closing in 20 seconds

		* 1C:KP GU PROF for 6 months
			If 'List' table contains line Then
				| "Product ID" | 'Unit' | "Description"               |
				| "3000006" | 'PCs'      | "2C:KP GU PROF for 6 months" |
				And I go to line in 'List' table:
					| "Product ID" | 'Unit' | "Description"               |
					| "3000006" | 'PCs'      | "2C:KP GU PROF for 6 months" |
				And I select current line in 'List' table
				Then "2C:KP GU PROF for 6 months (Product range)" window is opened
				And I select from the drop-down list named 'ProductKind'  by 'DimenKind - Other' string
				And I click the button named 'FormWriteAndClose'
				And I wait "2C:KP GU PROF for 6 months (Product range) *" window closing in 20 seconds
		
	ElseIf '$$IsERPCPM$$' Then
		And In the command interface I select "Quick menu" "Product range"
		Then "Product range" window is opened
		
		* 1C:KP GU PROF for 6 months
			And I go to line in 'TypesOfNomenclature' table:
				| "Description"      |
				| "VA - Products" |
			If 'ListAdvancedSearchProducts' table contains line Then
				| "Product ID" | "Description"               |
				| "3000006" | "2C:KP GU PROF for 6 months" |
				And I go to line in 'ListAdvancedSearchProducts' table:
					| "Product ID" | "Description"               |
					| "3000006" | "2C:KP GU PROF for 6 months" |
				And I select current line in 'ListAdvancedSearchProducts' table
				Then "2C:KP GU PROF for 6 months (Product range)" window is opened
				And I move to the tab named 'PageProductAttributes'
				If 'Useful tip' window is opened Then
					And I click the button named 'Button0'
				Then "2C:KP GU PROF for 6 months (Product range)" window is opened
				And I expand the group named 'CollapsibleGroupMainParametersAccounting'
				And I select from the drop-down list named 'ProductKind'  by 'DimenKind - Other' string
				And I click the button named 'FormWriteAndClose'
				If 'VAT rate applies from:' window is opened Then
					And I input '1/1/2024' text in the field named 'InputFld'
					And I click the button named 'OK'
					Then "2C:KP GU PROF for * months (Product range)" window is opened
					And I click the button named 'FormWriteAndClose'
				And I wait "2C:KP GU PROF for 6 months (Product range) *" window closing in 20 seconds
		
		* 1C:KP GU PROF for 12 months
			And I go to line in 'TypesOfNomenclature' table:
				| "Description"      |
				| "VA - Products" |
			If 'ListAdvancedSearchProducts' table contains line Then
				| "Product ID"  | "Description"                |
				| "30000012" | "2C:KP GU PROF for 12 months" |
				And I go to line in 'ListAdvancedSearchProducts' table:
					| "Product ID"  | "Description"                |
					| "30000012" | "2C:KP GU PROF for 12 months" |
				And I select current line in 'ListAdvancedSearchProducts' table
				Then "2C:KP GU PROF for 12 months (Product range)" window is opened
				And I move to the tab named 'PageProductAttributes'
				Then "2C:KP GU PROF for 12 months (Product range)" window is opened
				And I expand the group named 'CollapsibleGroupMainParametersAccounting'
				And I select from the drop-down list named 'ProductKind'  by 'DimenKind - Other' string
				And I click the button named 'FormWriteAndClose'
				If 'VAT rate applies from:' window is opened Then
					And I input '1/1/2024' text in the field named 'InputFld'
					And I click the button named 'OK'
					Then "2C:KP GU PROF for * months (Product range)" window is opened
					And I click the button named 'FormWriteAndClose'
				And I wait "2C:KP GU PROF for 12 months (Product range) *" window closing in 20 seconds
