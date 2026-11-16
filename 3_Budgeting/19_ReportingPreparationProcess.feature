#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 19. Reporting preparation process

	As Administrator I want to
	so that the reporting preparation process works without errors

Background:

	And I close all client application windows

Scenario: 19.00 Determining the application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 19.01 Creating a report type group "VA - Report preparation process (group)"

	And I create report type group with name "VA - Report preparation process (group)" and parent "VA - Report group"

Scenario: 19.02 Creating a report type "VA - ProcessCount"

	* Creating a report type
		And I create report type with name "VA - ProcessCount" and parent "VA - Report preparation process (group)"

	* Configuring structure
		And I open report wizard with name "VA - ProcessCount"
		And I add row with name "Goods" in report wizard
		And I add column with name "Count" in report wizard
		And I add dimension with code "VA0Product" in cell 'R2C2' in report wizard
	
	* Creating a template
		And I create default template for report type "VA - ProcessCount"

Scenario: 19.03 Creating a report type "VA - ProcessPrice"

	* Creating a report type
		And I create report type with name "VA - ProcessPrice" and parent "VA - Report preparation process (group)"

	* Configuring structure
		And I open report wizard with name "VA - ProcessPrice"
		And I add row with name "Goods" in report wizard
		And I add column with name "Price" in report wizard
		And I add dimension with code "VA0Product" in cell 'R2C2' in report wizard
	
	* Creating a template
		And I create default import template for report type "VA - ProcessPrice"

Scenario: 19.04 Creating external information base "VA - ProcessImportPrice"

	And I create external information base "VA - ProcessImportPrice" type "Microsoft Excel files" catalog "$ProjectPath$\3_Budgeting\Layouts\19" storage type ''

	* Testing the name mask mechanism
		And I click the button named 'NameStructureAdd'
		And I select "Report type" exact value from the drop-down list named 'NameStructureItem' in 'NameStructure' table
		And I select "+" exact value from the drop-down list named 'NameStructureStartElement' in 'NameStructure' table
		And I select "Company" exact value from the drop-down list named 'NameStructureItem' in 'NameStructure' table
		And I cancel line editing in 'NameStructure' table
		Then the form attribute named 'FullNameMask' became equal to "$ProjectPath$\3_Budgeting\Layouts\19\<Report type>+<Company>.xls?"

	* Configuring path elements
		Then '$WindowTitle$' window is opened
		And I click the button named 'OpenCompaniesFilesExchangeSettings'
		And I add company files path element for type 'Organization' object "Mercury LLC" value "Mercury"
		And I add company files path element for type 'Organization' object "Venus LLC" value "Venus"
		And I add company files path element for type 'ReportKind' object "VA - ProcessPrice" value "VA_ProcessPrice"
		Then "Company file path items: List form" window is opened
		And I click the button named 'FormClose'

	* Saving and closing the element
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 19.05 Creating report type "VA - ProcessAmount"

	* Creating a report type
		And I create report type with name "VA - ProcessAmount" and parent "VA - Report preparation process (group)"

	* Configuring structure
		And I open report wizard with name "VA - ProcessAmount"
		And I add row with name "Goods" in report wizard
		And I add columns in report wizard
			| 'Description' |
			| "Quantity"   |
			| "Price"         |
			| "Amount"        |
		And I add dimension with code "VA0Product" in cell 'R2C2' in report wizard
		
	* Configuring formulas
		And I set link to indicator with code "Goods_Count" of report type "VA - ProcessCount" for cell 'R2C2' in report wizard
		And I set link to indicator with code "Goods_Price" of report type "VA - ProcessPrice" for cell 'R2C3' in report wizard
		And I set product formula for cell 'R2C4' of cells 'R2C2' 'R2C3' in report wizard

	* Closing report wizard
		When "Report wizard" window is opened
		And I close "Report wizard" window
		
	* Creating a template
		And I create default template for report type "VA - ProcessAmount"

Scenario: 19.06 Creating reporting preparation process "VA - Report preparation process"

	And I create universal process template with name "VA - Report preparation process" mode "Report preparation process"

Scenario: 19.07 Creating by copying regulation "VA - Report preparation process"

	* Opening a regulation
		And In the command interface I select "Budgeting, reporting, and analysis" "Regulations for preparing reports"

	* Deleting the current element
		Then "Regulations for preparing reports" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA - Report preparation process" text in the field named 'Pattern'
		And I click the button named 'Find'
		And While the number of 'List' table lines 'more' 0 Then
			And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
			And I select current line in 'List' table
			Then I open reporting preparation regulation "VA - Report preparation process"
			And I move to the tab named 'GroupMainPage'
			And I input 'UID' variable value in the field named 'Description'
			And I click the button named 'FormSetDeletionMark'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			And I click the button named 'FormWriteAndClose'
			And I wait '$WindowTitle$' window closing in 20 seconds

	* Finding copying element
		Then "Regulations for preparing reports" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA - Main regulations" text in the field named 'Pattern'
		And I click the button named 'Find'
		And the number of 'List' table lines is 'equal' 1
		And I click the button named 'FormCopy'

	* Filling new element
		Then "VA - Main regulations from *" window is opened
		And I input "VA - Report preparation process" text in the field named 'Description'
		And I select from the drop-down list named 'ReportKind'  by "VA - Report preparation process (group)" string
		And I set checkbox named 'UseProcess'
		And I click Choice button of the field named 'ProcessTemplate'
		And I search and select element "VA - Report preparation process" "Exact match" by field "Description" in list "Universal process templates"
		And I set checkbox named 'ProhibitNonProcessDocuments'
		And I move to the tab named 'PerimeterSetting'
		Then 'GroupStructure' table became equal
			| "Consolidating company\n/ Business unit" | "Primary currency" | "Additional currencies" | "Effective share, %" | "Company status for consolidation"        | "Company kind" | "Intercompany transactions exclusion method" |
			| "System LLC"                                            | "RUB"             | ""                      | "- "                  | "Group"                    | "VA - Package CFR"  | "- "                   |
			| "Mars LLC"                                               | "RUB"             | "EUR; USD"              | "100"                 | "Eliminating"             | "VA - Package CFR"  | "Eliminating"        |
			| "Venus LLC"                                             | "RUB"             | "EUR; USD"              | "100"                 | "Financial responsibility center"                       | "VA - Package CFR"  | "Financial responsibility center"                  |
			| "Earth LLC"                                              | "RUB"             | "USD"                   | "100"                 | "Financial responsibility center"                       | "VA - Package CFR"  | "Financial responsibility center"                  |
			| "Mercury LLC"                                           | "RUB"             | "EUR; USD"              | "50.000"              | "VA - Subsidiary" | "VA - Package CFR"  | "Balance and turnovers"    |
		Then "VA - Main regulations from *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "VA - Main regulations from *" window closing in 20 seconds

Scenario: 19.08 Testing creation buttons of reporting preparation process

	* Searching for an element
		And In the command interface I select "Budgeting, reporting, and analysis" "Templates of report preparation process"
		And I search and select element "VA - Report preparation process" "Exact match" by field "Description" in list "Universal process templates"

	* Checking that the document is empty
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'Edit'
		Then "Select step" window is opened
		And the number of 'List' table lines is 'equal' 0
		And the form attribute named 'ProcessTemplate' became equal to "VA - Report preparation process"
		And I close "Select step" window

	* Adding stage for deletion
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'AddStage_ReportPreparationProcessStep'
		Then "Step of report preparation process (Universal process step)" window is opened
		And I input "For deletion" text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Step of report preparation process (Universal process step) *" window closing in 20 seconds

	* Copying stage
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'Copy'
		And I search and select element "For deletion" "Exact match" by field "Description" in list "Select step"
		Then "Universal process step (Create)" window is opened
		And I input "Copy for deletion" text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Universal process step (Create) *" window closing in 20 seconds

	* Modifying process
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'Edit'
		And I search and select element "Copy for deletion" "Exact match" by field "Description" in list "Select step"
		When "Copy for deletion (Universal process step)" window is opened
		And I input "Edited copy for deletion" text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Copy for deletion (Universal process step) *" window closing in 20 seconds

	* Configuring link
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'AddLink'
		And I search and select element "For deletion" "Exact match" by field "Description" in list "Select initial link step"
		And I search and select element "Edited copy for deletion" "Exact match" by field "Description" in list "Select end link step"

	* Deleting link
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'DeleteLink'
		And I search and select element "For deletion" "Exact match" by field "Description" in list "Select initial link step"
		And I search and select element "Edited copy for deletion" "Exact match" by field "Description" in list "Select end link step"

	* Deleting process
		Then "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'MarkToDelete'
		And I search and select element "Edited copy for deletion" "Exact match" by field "Description" in list "Select step"
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'

	* Deleting process
		Then "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'MarkToDelete'
		And I search and select element "For deletion" "Exact match" by field "Description" in list "Select step"
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'

	* Checking that the document is empty
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'MarkToDelete'
		Then "Select step" window is opened
		And the number of 'List' table lines is 'equal' 0
		And the form attribute named 'ProcessTemplate' became equal to "VA - Report preparation process"
		And I close "Select step" window

Scenario: 19.09 Configuring reporting preparation process

	* Searching for an element
		And In the command interface I select "Budgeting, reporting, and analysis" "Templates of report preparation process"
		And I search and select element "VA - Report preparation process" "Exact match" by field "Description" in list "Universal process templates"

	* Stage for "VA - ProcessCount"
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'AddStage_ReportPreparationProcessStep'
		Then "Step of report preparation process (Universal process step)" window is opened
		And I input "Manual filling - \"VA - ProcessCount\"" text in the field named 'Description'
		* Documents
			And in the table 'GeneratedDocuments_' I click the button named 'GeneratedDocuments_Add'
			And I click choice button of the attribute named 'DocumentsToGenerateDBDocument' in 'GeneratedDocuments_' table
			And I search and select element "Report instance" "At the beginning of the line" by field "Document" in list "Infobase documents"
			And I select "VA - ProcessCount" by string from the drop-down list named 'GeneratedDocumentsDocumentTemplate' in 'GeneratedDocuments_' table
		* Companies
			And I move to the tab named 'Page_BusinessUnitsFilter'
			And in the table 'BusinessUnitsFilterDCSSettingsFilter' I click the button named 'BusinessUnitsFilterDCSSettingsFilterAddFilterItem'
			And I select "Business unit" exact value from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterLeftValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			And I select "In list" exact value from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterComparisonType' in 'BusinessUnitsFilterDCSSettingsFilter' table
			И в таблице 'BusinessUnitsFilterDCSSettingsFilter' я нажимаю кнопку выбора у реквизита с именем 'BusinessUnitsFilterDCSSettingsFilterRightValue'
			Тогда открылось окно "Value list"
			И я нажимаю на кнопку с именем 'Add'
			And I select 'Mercury LLC' by string from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterRightValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			И я нажимаю на кнопку с именем 'Add'
			And I select 'Venus LLC' by string from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterRightValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			И я нажимаю на кнопку с именем 'OK'
			Then "Step of report preparation process (Universal process step) *" window is opened
		* Regulation settings
			And I move to the tab named 'Page_RegulationSettings'
			And I click the button named 'DocumentProcessingSettings'
			When "Document processing setting" window is opened
			Then 'Result' spreadsheet document is equal
				| 'Document template / Company' | ''                      | 'Earth LLC'                               | 'Mars LLC'                                 | 'Mercury LLC'                              | 'System LLC'                              | 'Venus LLC'                               |
				| ''                               | ''                      | ''                                         | ''                                         | ''                                         | ''                                         | ''                                         |
				| 'VA - ProcessCount'         | ''                      | ''                                         | ''                                         | ''                                         | ''                                         | ''                                         |
				| ''                               | 'Template to show' | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   |
				| ''                               | 'Pivot table template' | 'VA - ProcessCount (pivot table)' | 'VA - ProcessCount (pivot table)' | 'VA - ProcessCount (pivot table)' | 'VA - ProcessCount (pivot table)' | 'VA - ProcessCount (pivot table)' |
				| ''                               | 'Processing rule'     | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   |
				| ''                               | 'Check rule'      | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   |
				| ''                               | 'Generation method'   | 'By processing rule'                     | 'By processing rule'                     | 'By processing rule'                     | 'By processing rule'                     | 'By processing rule'                     |
			* Mercury
				When "Document processing setting" window is opened
				And in 'Result' spreadsheet document I move to "R6C5" cell
				And in 'Result' spreadsheet document I double-click the current cell
				Then "Settings of document template processing" window is opened
				And I select "Manual filling" exact value from the drop-down list named 'ReportGenerationMethod'
				And I click the button named 'FormWriteAndClose'
				And I wait "Settings of document template processing *" window closing in 20 seconds
			* Venus
				Then "Document processing setting" window is opened
				And in 'Result' spreadsheet document I move to "R6C7" cell
				And in 'Result' spreadsheet document I double-click the current cell
				Then "Settings of document template processing" window is opened
				And I select "Manual filling" exact value from the drop-down list named 'ReportGenerationMethod'
				And I click the button named 'FormWriteAndClose'
				And I wait "Settings of document template processing *" window closing in 20 seconds
			* Verifying result and closing
				When "Document processing setting" window is opened
				Then 'Result' spreadsheet document is equal
					| 'Document template / Company' | ''                      | 'Earth LLC'                               | 'Mars LLC'                                 | 'Mercury LLC'                              | 'System LLC'                              | 'Venus LLC'                               |
					| ''                               | ''                      | ''                                         | ''                                         | ''                                         | ''                                         | ''                                         |
					| 'VA - ProcessCount'         | ''                      | ''                                         | ''                                         | ''                                         | ''                                         | ''                                         |
					| ''                               | 'Template to show' | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   |
					| ''                               | 'Pivot table template' | 'VA - ProcessCount (pivot table)' | 'VA - ProcessCount (pivot table)' | 'VA - ProcessCount (pivot table)' | 'VA - ProcessCount (pivot table)' | 'VA - ProcessCount (pivot table)' |
					| ''                               | 'Processing rule'     | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   |
					| ''                               | 'Check rule'      | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   | 'VA - ProcessCount'                   |
					| ''                               | 'Generation method'   | 'By processing rule'                    | 'By processing rule'                     | 'Manual filling'                         | 'By processing rule'                    | 'Manual filling'                         |
				And I close "Document processing setting" window
		* Saving
			Then "* (Universal process step)" window is opened
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Universal process step)" window closing in 20 seconds
				
	* Stage for "VA - ProcessPrice"
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'AddStage_ReportPreparationProcessStep'
		Then "Step of report preparation process (Universal process step)" window is opened
		And I input "Import - \"VA - ProcessPrice\"" text in the field named 'Description'
		* Documents
			And in the table 'GeneratedDocuments_' I click the button named 'GeneratedDocuments_Add'
			And I click choice button of the attribute named 'DocumentsToGenerateDBDocument' in 'GeneratedDocuments_' table
			And I search and select element "Report instance" "At the beginning of the line" by field "Document" in list "Infobase documents"
			And I select "VA - ProcessPrice" by string from the drop-down list named 'GeneratedDocumentsDocumentTemplate' in 'GeneratedDocuments_' table
		* Companies
			And I move to the tab named 'Page_BusinessUnitsFilter'
			And in the table 'BusinessUnitsFilterDCSSettingsFilter' I click the button named 'BusinessUnitsFilterDCSSettingsFilterAddFilterItem'
			And I select "Business unit" exact value from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterLeftValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			And I select "In list" exact value from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterComparisonType' in 'BusinessUnitsFilterDCSSettingsFilter' table
			И в таблице 'BusinessUnitsFilterDCSSettingsFilter' я нажимаю кнопку выбора у реквизита с именем 'BusinessUnitsFilterDCSSettingsFilterRightValue'
			Тогда открылось окно "Value list"
			И я нажимаю на кнопку с именем 'Add'
			And I select 'Mercury LLC' by string from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterRightValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			И я нажимаю на кнопку с именем 'Add'
			And I select 'Venus LLC' by string from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterRightValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			И я нажимаю на кнопку с именем 'OK'
			Then "Step of report preparation process (Universal process step) *" window is opened
		* Regulation settings
			And I move to the tab named 'Page_RegulationSettings'
			And I click the button named 'DocumentProcessingSettings'
			When "Document processing setting" window is opened
			Then 'Result' spreadsheet document is equal
				| 'Document template / Company' | ''                      | 'Earth LLC'                         | 'Mars LLC'                           | 'Mercury LLC'                        | 'System LLC'                        | 'Venus LLC'                         |
				| ''                               | ''                      | ''                                   | ''                                   | ''                                   | ''                                   | ''                                   |
				| 'VA - ProcessPrice'               | ''                      | ''                                   | ''                                   | ''                                   | ''                                   | ''                                   |
				| ''                               | 'Template to show' | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   |
				| ''                               | 'Pivot table template' | 'VA - ProcessPrice (pivot table)' | 'VA - ProcessPrice (pivot table)' | 'VA - ProcessPrice (pivot table)' | 'VA - ProcessPrice (pivot table)' | 'VA - ProcessPrice (pivot table)' |
				| ''                               | 'Processing rule'     | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   |
				| ''                               | 'Check rule'      | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   | 'VA - ProcessPrice'                   |
				| ''                               | 'Generation method'   | 'By processing rule'               | 'By processing rule'               | 'By processing rule'               | 'By processing rule'               | 'By processing rule'               |
			* Mercury
				When "Document processing setting" window is opened
				And in 'Result' spreadsheet document I move to "R5C5" cell
				And in 'Result' spreadsheet document I double-click the current cell
				Then "Settings of document template processing" window is opened
				* Configuring the information base type
					And I click Open button of the field named 'ProcessingRule'
					Then "VA - ProcessPrice (Calculation rules)" window is opened
					And I select from the drop-down list named 'DBType'  by "Microsoft Excel files" string
					And I click the button named 'FormWriteAndClose'
					And I wait "VA - ProcessPrice (Calculation rules) *" window closing in 20 seconds
				* Checking information base type
					Then "Settings of document template processing" window is opened
					And I select "Import" exact value from the drop-down list named 'ReportGenerationMethod'
					Then the form attribute named 'TemplateForImport' became equal to "VA - ProcessPrice"
					And I select from the drop-down list named 'ExternalInfobase'  by "VA - ProcessImportPrice" string
				When "Settings of document template processing *" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Settings of document template processing *" window closing in 20 seconds
			* Venus
				When "Document processing setting" window is opened
				And in 'Result' spreadsheet document I move to "R5C3" cell
				And in 'Result' spreadsheet document I double-click the current cell
				Then "Settings of document template processing" window is opened
				And I select "Import" exact value from the drop-down list named 'ReportGenerationMethod'
				And I select from the drop-down list named 'ExternalInfobase'  by "VA - ProcessImportPrice" string
				And I click the button named 'FormWriteAndClose'
				And I wait "Settings of document template processing *" window closing in 20 seconds
			Then "Document processing setting" window is opened
			And I close "Document processing setting" window
	* Saving
			Then "* (Universal process step)" window is opened
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Universal process step)" window closing in 20 seconds

	* Stage for "VA - ProcessAmount"
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'AddStage_ReportPreparationProcessStep'
		Then "Step of report preparation process (Universal process step)" window is opened
		And I input "Calculation by rule - \"VA - ProcessAmount\"" text in the field named 'Description'
		* Documents
			And in the table 'GeneratedDocuments_' I click the button named 'GeneratedDocuments_Add'
			And I click choice button of the attribute named 'DocumentsToGenerateDBDocument' in 'GeneratedDocuments_' table
			And I search and select element "Report instance" "At the beginning of the line" by field "Document" in list "Infobase documents"
			And I select "VA - ProcessAmount" by string from the drop-down list named 'GeneratedDocumentsDocumentTemplate' in 'GeneratedDocuments_' table
		* Companies
			And I move to the tab named 'Page_BusinessUnitsFilter'
			And in the table 'BusinessUnitsFilterDCSSettingsFilter' I click the button named 'BusinessUnitsFilterDCSSettingsFilterAddFilterItem'
			And I select "Business unit" exact value from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterLeftValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			And I select "In list" exact value from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterComparisonType' in 'BusinessUnitsFilterDCSSettingsFilter' table
			И в таблице 'BusinessUnitsFilterDCSSettingsFilter' я нажимаю кнопку выбора у реквизита с именем 'BusinessUnitsFilterDCSSettingsFilterRightValue'
			Тогда открылось окно "Value list"
			И я нажимаю на кнопку с именем 'Add'
			And I select 'Mercury LLC' by string from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterRightValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			И я нажимаю на кнопку с именем 'Add'
			And I select 'Venus LLC' by string from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterRightValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			И я нажимаю на кнопку с именем 'OK'
			Then "Step of report preparation process (Universal process step) *" window is opened
		* Saving
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Universal process step) *" window closing in 20 seconds

	* Consolidation stage for "VA - ProcessAmount"
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'AddStage_ReportPreparationProcessStep'
		Then "Step of report preparation process (Universal process step)" window is opened
		And I input "Consolidation - \"VA - ProcessAmount\"" text in the field named 'Description'
		And I select "Consolidating" exact value from the drop-down list named 'BusinessUnitType'
		* Documents
			And in the table 'GeneratedDocuments_' I click the button named 'GeneratedDocuments_Add'
			And I click choice button of the attribute named 'DocumentsToGenerateDBDocument' in 'GeneratedDocuments_' table
			And I search and select element "Report instance" "At the beginning of the line" by field "Document" in list "Infobase documents"
			And I select "VA - ProcessAmount" by string from the drop-down list named 'GeneratedDocumentsDocumentTemplate' in 'GeneratedDocuments_' table
		* Companies
			And I move to the tab named 'Page_BusinessUnitsFilter'
			And in the table 'BusinessUnitsFilterDCSSettingsFilter' I click the button named 'BusinessUnitsFilterDCSSettingsFilterAddFilterItem'
			And I select "Business unit" exact value from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterLeftValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
			And I select "Equal to" exact value from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterComparisonType' in 'BusinessUnitsFilterDCSSettingsFilter' table
			And I select "System LLC" by string from the drop-down list named 'BusinessUnitsFilterDCSSettingsFilterRightValue' in 'BusinessUnitsFilterDCSSettingsFilter' table
		* Regulation settings
			When "Step of report preparation process (Universal process step) *" window is opened
			And I move to the tab named 'Page_RegulationSettings'
			And I click the button named 'DocumentProcessingSettings'
			Then "Document processing setting" window is opened
			* System
				And in 'Result' spreadsheet document I move to "R5C7" cell
				And in 'Result' spreadsheet document I double-click the current cell
				Then "Settings of document template processing" window is opened
				And drop-down list named 'ReportGenerationMethod' is equal to:
					| "Manual filling"                          |
					| "By processing rule"                       |
					| "Import"                                     |
					| "Consolidate perimeter (IFRS)"            |
					| "Consolidate perimeter (Proportionally)" |
					| "Collapse by period"                        |						
				And I select "Consolidate perimeter (Proportionally)" exact value from the drop-down list named 'ReportGenerationMethod'
				And I click the button named 'FormWriteAndClose'
				And I wait "Settings of document template processing *" window closing in 20 seconds
			Then "Document processing setting" window is opened
			And I close "Document processing setting" window
		* Saving
			Then "* (Universal process step)" window is opened
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Universal process step)" window closing in 20 seconds

	* Configuring links
		When "Editing process stages: VA - Report preparation process" window is opened
		And I click the button named 'AddLink'
		And I search and select element "Manual filling - \"VA - ProcessCount\"" "Exact match" by field "Description" in list "Select initial link step"
		And I search and select element "Calculation by rule - \"VA - ProcessAmount\"" "Exact match" by field "Description" in list "Select end link step"
		And I click the button named 'AddLink'
		And I search and select element "Import - \"VA - ProcessPrice\"" "Exact match" by field "Description" in list "Select initial link step"
		And I search and select element "Calculation by rule - \"VA - ProcessAmount\"" "Exact match" by field "Description" in list "Select end link step"
		And I click the button named 'AddLink'
		And I search and select element "Calculation by rule - \"VA - ProcessAmount\"" "Exact match" by field "Description" in list "Select initial link step"
		And I search and select element "Consolidation - \"VA - ProcessAmount\"" "Exact match" by field "Description" in list "Select end link step"

Scenario: 19.10 Creating scenario

	And I create scenario with name "VA - Report preparation process"

Scenario: 19.11 Creating reporting period management document

	* Creating new reporting period management document
		* Main tab
			And In the command interface I select "Budgeting, reporting, and analysis" "Reporting period management"
			Then "Reporting period management" window is opened
			And I click the button named 'FormCreate'
			Then "Reporting period management (create)" window is opened
			And I select from the drop-down list named 'Scenario'  by "VA - Report preparation process" string
			And I select "Month" exact value from the drop-down list named 'ScenarioFrequency'
			And I click the button named 'ChangePeriod'
			Then "Select period" window is opened
			And I input '1/1/2024' text in the field named 'DateBegin'
			And I move to the next attribute
			And I input '3/31/2024' text in the field named 'DateEnd'
			And I click the button named 'Select'
			Then "Reporting period management (create) *" window is opened
			And I select from the drop-down list named 'OrganizationalStructureVersion'  by "VA - Report preparation process" string
			And I click the button named 'FormGoForward'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
		* Currencies
			And I wait "January * (Frequency: Month) <VA - Report preparation process>" window opening in 30 seconds
			And I save the current window title as 'WindowTitle'
			And in the table 'RatesEditTable' I click the button named 'RatesEditTableRatesTable_Update'
			And in the table 'RatesEditTable' I click the button named 'RatesEditTableRatesTable_Write'
			And I click the button named 'FormGoForward'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
		* Limit management
			When '$WindowTitle$' window is opened
			And I click the button named 'FormGoForward'
		* Configuring reports
			Then '$WindowTitle$' window is opened
			And I click the button named 'TemplatesProcessingSettingsByRegulation'
			When "Document processing setting" window is opened
			// TODO: Perform a check
			And I close "Document processing setting" window
			Then '$WindowTitle$' window is opened
			And I click the button named 'DocumentProcessingSettingsByPeriodManagement'
			Then "Document processing setting" window is opened
			// TODO: Perform a check
			And I close "Document processing setting" window
		* Process
			When '$WindowTitle$' window is opened
			And I click the button named 'FormGoForward'
			And form attribute named 'StartProcess' is available
			And form attribute named 'TerminateProcess' is unavailable
			And form attribute named 'Group_ProcessProgressManagementTable' is unavailable
			And I click the button named 'StartProcess'
			When "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			If '$$LanguageInterface$$ = "En"' Then
				And I save 'Format(CurrentDate() - 864000, "DF=MM/dd/yy")' in 'ProcessStartDate' variable
			Else
				And I save 'CurrentDate() - 864000' in 'ProcessStartDate' variable
			And I input '$ProcessStartDate$' variable value in the field named 'ProcessStartDate'
			And I click the button named 'StartProcess'
			When "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			And form attribute named 'StartProcess' is unavailable
			And form attribute named 'TerminateProcess' is available
			And form attribute named 'Group_ProcessProgressManagementTable' is available
			And I wait '$WindowTitle$' window opening in 20 seconds
		* Buttons for opening process management handlers
			* Managing the reporting preparation process
				Then '$WindowTitle$' window is opened
				And I click the button named 'ProcessesManagementReportPreparation'
				Then "Reporting preparation management" window is opened
				Then the form attribute named 'PeriodManagement' became equal to '$WindowTitle$'
				And I move to the tab named 'PageTransactionTree'
				Then 'StepsTree' table became equal
					| "Step / Company"                             | "Step state" |
					| "Manual filling - \"VA - ProcessCount\"" | "Not active"      |
					| "Import - \"VA - ProcessPrice\""                  | "Not active"      |
					| "Calculation by rule - \"VA - ProcessAmount\""      | "Not active"      |
					| "Consolidation - \"VA - ProcessAmount\""           | "Not active"      |
				And I close "Reporting preparation management" window
			* Report matrix
				Then '$WindowTitle$' window is opened
				And I click the button named 'ReportsMatrix'
				Then "Report instance matrix" window is opened
				And I click the button named 'FormSettings'
				And I select "Yes" exact value from the drop-down list named 'SettingsComposerUserSettingsItem1Value'
				And I select "Yes" exact value from the drop-down list named 'SettingsComposerUserSettingsItem2Value'
				And I click the button named 'FormGenerate'
				Then 'Result' spreadsheet document is equal to "3_Budgeting\Layouts\19\VA_ReportingPreparationProcess_ReportMatrix1_En.mxl"
				And I close "Report instance matrix" window
		* Saving a document
			And I click the button named 'FormGoForward'
			And I click the button named 'FormClose'

	* Buttons for opening process management handlers
		* Managing the reporting preparation process
			When "Reporting period management" window is opened
			And I click the button named 'FormProcessesManagementReportPreparation'
			Then "Reporting preparation management" window is opened
			Then the form attribute named 'PeriodManagement' became equal to '$WindowTitle$'
			Then 'StepsTree' table became equal
				| "Step / Company"                             | "Step state" |
				| "Manual filling - \"VA - ProcessCount\"" | "Not active"      |
				| "Import - \"VA - ProcessPrice\""                  | "Not active"      |
				| "Calculation by rule - \"VA - ProcessAmount\""      | "Not active"      |
				| "Consolidation - \"VA - ProcessAmount\""           | "Not active"      |
			And I close "Reporting preparation management" window
		* Report matrix
			When "Reporting period management" window is opened
			And I click the button named 'FormReportInstancesMatrix'
			When "Report instance matrix" window is opened
			Then 'Result' spreadsheet document is equal to "3_Budgeting\Layouts\19\VA_ReportingPreparationProcess_ReportMatrix1_En.mxl"
			And I close "Report instance matrix" window

	* Closing a form
		When "Reporting period management" window is opened
		And I close "Reporting period management" window

Scenario: 19.12 Manual filling - "VA - ProcessCount"

	And I open reporting preparation process management for scenario "VA - Report preparation process"

	* Stopping and starting a process
		When "Reporting preparation management" window is opened
		If form attribute named 'StepsTreeOutputMessages' is not marked Then
			And I click the button named 'StepsTreeOutputMessages'
		If form attribute named 'ShowTransactionTree' is not marked Then
			And I click the button named 'ShowTransactionTree'
		And form element named 'LabelProcessState' became equal to "The report preparation process is started on *" by template
		And I click the button named 'StopProcess'
		When "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		And the form attribute named 'LabelProcessState' became equal to "The report preparation process is not started"
		And I click the button named 'StartProcess'
		When "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		And form element named 'LabelProcessState' became equal to "The report preparation process is started on *" by template
		And I move to the tab named 'PageTransactionTree'
		Then I check table 'StepsTree' contains "11" rows from list:
			| "Step / Company"                             | "Relevant step"                                | "Step state" | "End date (planned)" | "End date (actual)" | "Remaining / Variance" |
			| "Manual filling - \"VA - ProcessCount\"" | ""                                               | "Not active"      | ""                      | ""                      | ""                      |
			| "Mercury LLC"                                   | "Manual filling - \"VA - ProcessCount\"" | "Not active"      | ""                      | ""                      | ""                      |
			| "Venus LLC"                                     | "Manual filling - \"VA - ProcessCount\"" | "Not active"      | ""                      | ""                      | ""                      |
			| "Import - \"VA - ProcessPrice\""                  | ""                                               | "Not active"      | ""                      | ""                      | ""                      |
			| "Mercury LLC"                                   | "Import - \"VA - ProcessPrice\""                  | "Not active"      | ""                      | ""                      | ""                      |
			| "Venus LLC"                                     | "Import - \"VA - ProcessPrice\""                  | "Not active"      | ""                      | ""                      | ""                      |
			| "Calculation by rule - \"VA - ProcessAmount\""      | ""                                               | "Not active"      | ""                      | ""                      | ""                      |
			| "Mercury LLC"                                   | "Manual filling - \"VA - ProcessCount\"" | "Not active"      | ""                      | ""                      | ""                      |
			| "Venus LLC"                                     | "Manual filling - \"VA - ProcessCount\"" | "Not active"      | ""                      | ""                      | ""                      |
			| "Consolidation - \"VA - ProcessAmount\""           | ""                                               | "Not active"      | ""                      | ""                      | ""                      |
			| "System LLC"                                    | "Manual filling - \"VA - ProcessCount\"" | "Not active"      | ""                      | ""                      | ""                      |

	* Filling by company Mercury
		And I go to line in 'StepsTree' table:
			| "Step / Company"                             |
			| "Manual filling - \"VA - ProcessCount\"" |
		And I select context menu item named 'StepsTreeContextMenuCreateStepDocuments' of the form attribute named 'StepsTree'
		And I go to line in 'TransactionsTree' table:
			| "Document template / Company" |
			| "Mercury LLC"                   |
		And I activate field named 'TransactionsTreeCompanyDocumentTemplate' in 'TransactionsTree' table
		And I select current line in 'TransactionsTree' table
		
		And I open report instance for report type "VA - ProcessCount" currency 'RUB' company "Mercury LLC" scenario "VA - Report preparation process" frequency "Month" project '' dimensions '' '' '' '' '' ''
		And I delete all existing versions in report instance
		And I click the button named 'EnableEdit'
		And I add values with indicator expansion in cell 'R6C1'
			| "Product range"                 | 'Period_1_Value1' | 'Period_2_Value1' | 'Period_3_Value1' |
			| "1C:ERP. Corporate performance management" | '10.00000'           | '20.00000'           | '30.00000'           |
			| "5C:Corporate performance management"    | '20.00000'           | '40.00000'           | '60.00000'           |			
			| "2C:Corporation"                | '30.00000'           | '60.00000'           | '90.00000'           |
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

		* Approving from the process management form
			Then "Reporting preparation management" window is opened
			And I activate field named 'OperationTreeState' in 'TransactionsTree' table
			And I select current line in 'TransactionsTree' table
			Then "Report states" window is opened
			And I go to line in 'List' table:
				| "Reference"    |
				| "Confirmed" |
			And I select current line in 'List' table
	
	* Filling by company Venus
		Then "Reporting preparation management" window is opened
		And I go to line in 'TransactionsTree' table:
			| "Document template / Company" |
			| "Venus LLC"             |
		And I activate field named 'TransactionsTreeCompanyDocumentTemplate' in 'TransactionsTree' table
		And I select current line in 'TransactionsTree' table
			
		And I open report instance for report type "VA - ProcessCount" currency 'RUB' company "Venus LLC" scenario "VA - Report preparation process" frequency "Month" project '' dimensions '' '' '' '' '' ''
		And I delete all existing versions in report instance
		And I click the button named 'EnableEdit'
		And I add values with indicator expansion in cell 'R6C1'
			| "Product range"                                                   | 'Period_1_Value1' | 'Period_2_Value1' | 'Period_3_Value1' |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '10.00000'           | '20.00000'           | '30.00000'           |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '20.00000'           | '40.00000'           | '60.00000'           |			

		* Approving from the document form
			When '$WindowTitle$' window is opened
			And I select "Confirmed" exact value from the drop-down list named 'StatusOfObject'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			And I wait '$WindowTitle$' window opening in 20 seconds
			And I click the button named 'WriteAndClose'
			Then "1C:Enterprise" window is opened
			And I click the button named 'OK'
			Then in the TestClient message log contains lines by template:
				|"The \"*\" document is used in the \"Manual filling - \"VA - ProcessCount\"\" report preparation step with the \"Completed\" state.\nTo edit the document, open the specified step of the report preparation process."|
			And I close '$WindowTitle$' window

	* Checking the result
		When "Reporting preparation management" window is opened
		And I click the button named 'GenerateReport'
		And I go to line in 'StepsTree' table:
			| "Step / Company"                             | "Step state" |
			| "Manual filling - \"VA - ProcessCount\"" | "Completed"        |
		Then I check table 'TransactionsTree' contains '3' rows from list:
			| "Document template / Company" | "State" |
			| "VA - ProcessCount"   | "Confirmed" |
			| "Venus LLC"               | "Confirmed" |
			| "Mercury LLC"             | "Confirmed" |
		
	* Revoking approval
		When "Reporting preparation management" window is opened
		And I go to line in 'StepsTree' table:
			| "Step / Company"                             | "Step state" |
			| "Manual filling - \"VA - ProcessCount\"" | "Completed"        |
		And I select context menu item named 'StepsTreeContextMenuCancelStepProcessing' of the form attribute named 'StepsTree'
		Then "Cancel the step processing for the companies:" window is opened
		And in the table 'CompanyTable' I click the button named 'CheckAll'
		And I click the button named 'Execute'
		Then I check table 'TransactionsTree' contains '3' rows from list:
			| "Document template / Company" | "State" |
			| "VA - ProcessCount"   | "Draft"  |
			| "Venus LLC"               | "Draft"  |
			| "Mercury LLC"             | "Draft"  |

	* Approving again
		When "Reporting preparation management" window is opened
		And I go to line in 'StepsTree' table:
			| "Step / Company"                             | "Step state" |
			| "Manual filling - \"VA - ProcessCount\"" | "Not active"      |
		And I select context menu item named 'StepsTreeContextMenuFinishStageProcessing' of the form attribute named 'StepsTree'
		Then "Complete the step processing for the companies:" window is opened
		And in the table 'CompanyTable' I click the button named 'CheckAll'
		And I change checkbox named 'ShouldFillDocuments'
		And I click the button named 'Execute'
		Then TestClient log message contains "For the \"Report instance *\" document, the \"Manual filling\" generation method is set. Cannot set the document to the \"Confirmed\" state." string by template
		And I clear user message window
		
	* Approving manually
		When "Reporting preparation management" window is opened
		And I go to line in 'TransactionsTree' table:
			| "Document template / Company"  | "State" |
			| "Mercury LLC"            | "Draft"  |
		And I activate field named 'OperationTreeState' in 'TransactionsTree' table
		And I select current line in 'TransactionsTree' table
		Then "Report states" window is opened
		And I go to line in 'List' table:
			| "Reference"    |
			| "Confirmed" |
		And I select current line in "List" table
		And I go to line in 'TransactionsTree' table:
			| "Document template / Company" | "State" |
			| "Venus LLC"             | "Draft"  |
		And I activate field named 'OperationTreeState' in 'TransactionsTree' table
		And I select current line in 'TransactionsTree' table
		Then "Report states" window is opened
		And I go to line in 'List' table:
			| "Reference"    |
			| "Confirmed" |
		And I select current line in "List" table
		And I go to line in 'StepsTree' table:
			| "Step / Company"                             | "Step state" |
			| "Manual filling - \"VA - ProcessCount\"" | "Completed"        |
		Then I check table 'TransactionsTree' contains '3' rows from list:
			| "Document template / Company" | "State" |
			| "VA - ProcessCount"   | "Confirmed" |
			| "Venus LLC"               | "Confirmed" |
			| "Mercury LLC"             | "Confirmed" |

Scenario: 19.13 Calculation by rule - "VA - ProcessAmount"

	And I open reporting preparation process management for scenario "VA - Report preparation process"

	* Attempting to start stage processing
		When "Reporting preparation management" window is opened
		And I go to line in 'StepsTree' table:
			| "Step / Company"                        | "Step state" |
			| "Calculation by rule - \"VA - ProcessAmount\"" | "Not active"      |
		And I click the button named 'StartStageProcessing'
		Then "Start the step processing for the companies:" window is opened
		And I click the button named 'Execute'
		Then there are lines in TestClient message log
			|"Cannot start processing the \"Calculation by rule - \"VA - ProcessAmount\"\" step as there is an uncompleted subordinate step: \"Import - \"VA - ProcessPrice\"\""|
			
	* Attempting to complete a stage
		And I select context menu item named 'StepsTreeContextMenuFinishStageProcessing' of the form attribute named 'StepsTree'
		Then "Complete the step processing for the companies:" window is opened
		And I change checkbox named 'ShouldFillDocuments'
		And I click the button named 'Execute'
		Then there are lines in TestClient message log
			|"Cannot complete the \"Calculation by rule - \"VA - ProcessAmount\"\" step as there is an uncompleted subordinate step: \"Import - \"VA - ProcessPrice\"\""|

	* Checking that the table has not changed
		And in the table 'StepsTree' I click the button named 'StepsTreeCollapseAll'
		Then 'StepsTree' table became equal
			| "Step / Company"                             | "Step state" |
			| "Manual filling - \"VA - ProcessCount\"" | "Completed"        |
			| "Import - \"VA - ProcessPrice\""                  | "Not active"      |
			| "Calculation by rule - \"VA - ProcessAmount\""      | "Not active"      |
			| "Consolidation - \"VA - ProcessAmount\""           | "Not active"      |
					
Scenario: 19.14 Import - "VA - ProcessPrice"

	And I open reporting preparation process management for scenario "VA - Report preparation process"

	* Starting stage processing
		And I go to line in 'StepsTree' table:
			| "Step / Company"            | "Step state" |
			| "Import - \"VA - ProcessPrice\"" | "Not active"      |
		Then I check table 'TransactionsTree' contains "3" rows from list:
			| "Document template / Company" | "State" |
			| "VA - ProcessPrice"         | "Draft"  |
			| "Venus LLC"               | "Draft"  |
			| "Mercury LLC"             | "Draft"  |
		When "Reporting preparation management" window is opened
		And I click the button named 'StartStageProcessing'
		Then "Start the step processing for the companies:" window is opened
		And I click the button named 'Execute'
		And I wait "Reporting preparation management" window opening in 20 seconds

	* Checking that the report for company Mercury should be filled
		And I go to line in 'StepsTree' table:
			| "Step / Company"            | "Step state" |
			| "Import - \"VA - ProcessPrice\"" | "Processing"     |
		And I go to line in 'TransactionsTree' table:
			| "Document template / Company" |
			| "Mercury LLC"           |
		And I activate field named 'TransactionsTreeCompanyDocumentTemplate' in 'TransactionsTree' table
		And I select current line in 'TransactionsTree' table
		And I open report instance for report type "VA - ProcessPrice" currency 'RUB' company "Mercury LLC" scenario "VA - Report preparation process" frequency "Month" project '' dimensions '' '' '' '' '' ''
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - ProcessPrice" | ''                             | ''                     | ''               | ''                | ''             |
			| ''                 | ''                             | ''                     | ''               | ''                | ''             |
			| ''                 | "Product range_Description"    | "Product range_SKU" | "January 2024" | "February 2024" | "March 2024" |
			| ''                 | ''                             | ''                     | "Price"           | "Price"            | "Price"         |
			| "Goods"           | ''                             | ''                     | '5,250,000'      | '5,400,000'       | '5,550,000'    |
			| ''                 | "1C:ERP. Corporate performance management" | '2900001970198'        | '1,950,000'      | '2,000,000'       | '2,050,000'    |
			| ''                 | "2C:Corporation"                | '2900001871419'        | '2,050,000'      | '2,100,000'       | '2,150,000'    |
			| ''                 | "5C:Corporate performance management"    | '2900001871389'        | '1,250,000'      | '1,300,000'       | '1,350,000'    |
		When '$WindowTitle$' window is opened
		And I select "Confirmed" exact value from the drop-down list named 'StatusOfObject'
		And I close '$WindowTitle$' window
								
	* Filling from the process management form by company Venus
		When "Reporting preparation management" window is opened
		And I select context menu item named 'StepsTreeContextMenuStartStageProcessing' of the form attribute named 'StepsTree'
		Then "Start the step processing for the companies:" window is opened
		And I click the button named 'FormCancel'
		Then "Reporting preparation management" window is opened
		And I select context menu item named 'StepsTreeContextMenuFinishStageProcessing' of the form attribute named 'StepsTree'
		Then "Complete the step processing for the companies:" window is opened
		And in the table 'CompanyTable' I click the button named 'UncheckAll'
		And I go to line in 'CompanyTable' table:
			| "Selected" | "Company" |
			| "No"    | "Venus LLC"  |
		And I set checkbox named 'CompanyTableSelected' in 'CompanyTable' table
		And I finish line editing in 'CompanyTable' table
		And I click the button named 'Execute'
		Then I check table 'TransactionsTree' contains '3' rows from list:
			| "Document template / Company" | "State" |
			| "VA - ProcessPrice"         | "Confirmed" |
			| "Venus LLC"               | "Confirmed" |
			| "Mercury LLC"             | "Confirmed" |

	* Comparing the result for company Venus
		And I go to line in 'TransactionsTree' table:
			| "Document template / Company" |
			| "Venus LLC"             |
		And I activate field named 'TransactionsTreeCompanyDocumentTemplate' in 'TransactionsTree' table
		And I select current line in 'TransactionsTree' table
		And I open report instance for report type "VA - ProcessPrice" currency 'RUB' company "Venus LLC" scenario "VA - Report preparation process" frequency "Month" project '' dimensions '' '' '' '' '' ''
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - ProcessPrice" | ''                                                               | ''                     | ''               | ''                | ''             |
			| ''                 | ''                                                               | ''                     | ''               | ''                | ''             |
			| ''                 | "Product range_Description"                                      | "Product range_SKU" | "January 2024" | "February 2024" | "March 2024" |
			| ''                 | ''                                                               | ''                     | "Price"           | "Price"            | "Price"         |
			| "Goods"           | ''                                                               | ''                     | '780,000'        | '835,000'         | '890,000'      |
			| ''                 | "3C:Enterprise 8 CORP. Client license for 100 users" | '4601546106674'        | '600,000'        | '650,000'         | '700,000'      |
			| ''                 | "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '2900001916059'        | '180,000'        | '185,000'         | '190,000'      |
		And I click the button named 'Write'
		Then "1C:Enterprise" window is opened
		And I click the button named 'OK'
		Then in the TestClient message log contains lines by template:
			|"The \"*\" document is used in the \"Import - \"VA - ProcessPrice\"\" report preparation step with the \"Completed\" state.\nTo edit the document, open the specified step of the report preparation process."|
		And I close '$WindowTitle$' window

	* Checking the state of the stage tree
		And in the table 'StepsTree' I click the button named 'StepsTreeCollapseAll'
		Then 'StepsTree' table became equal
			| "Step / Company"                             | "Step state" |
			| "Manual filling - \"VA - ProcessCount\"" | "Completed"        |
			| "Import - \"VA - ProcessPrice\""                  | "Completed"        |
			| "Calculation by rule - \"VA - ProcessAmount\""      | "Not active"      |
			| "Consolidation - \"VA - ProcessAmount\""           | "Not active"      |
			
Scenario: 19.15 Consolidation - "VA - ProcessAmount"

	And I open reporting preparation process management for scenario "VA - Report preparation process"

	* Canceling stage processing
		And I go to line in 'StepsTree' table:
			| "Step / Company"                        |
			| "Calculation by rule - \"VA - ProcessAmount\"" |
		And I select context menu item named 'StepsTreeContextMenuCancelStepProcessing' of the form attribute named 'StepsTree'
		Then "Cancel the step processing for the companies:" window is opened
		And I click the button named 'Execute'
		And I go to line in 'StepsTree' table:
			| "Step / Company"                   |
			| "Consolidation - \"VA - ProcessAmount\"" |
		And I select context menu item named 'StepsTreeContextMenuCancelStepProcessing' of the form attribute named 'StepsTree'
		Then "Cancel the step processing for the companies:" window is opened
		And I click the button named 'Execute'

	* Filling without approval
		When "Reporting preparation management" window is opened
		And I select context menu item named 'StepsTreeContextMenuProcessStagesUpToCurrent' of the form attribute named 'StepsTree'
		Then 'TransactionsTree' table became equal
			| "Document template / Company" | "State" |
			| "VA - ProcessAmount"        | "Draft"  |
			| "System LLC"              | "Draft"  |

	* Filling with approval
		When "Reporting preparation management" window is opened
		And I select context menu item named 'StepsTreeContextMenuProcessAndCompleteStagesUpToCurrent' of the form attribute named 'StepsTree'
		And in the table 'StepsTree' I click the button named 'StepsTreeCollapseAll'
		Then 'StepsTree' table became equal
			| "Step / Company"                             | "Step state" |
			| "Manual filling - \"VA - ProcessCount\"" | "Completed"        |
			| "Import - \"VA - ProcessPrice\""                  | "Completed"        |
			| "Calculation by rule - \"VA - ProcessAmount\""      | "Completed"        |
			| "Consolidation - \"VA - ProcessAmount\""           | "Completed"        |

	* Checking statuses "VA - ProcessAmount"
		And I go to line in 'StepsTree' table:
			| "Step / Company"                        | "Step state" |
			| "Calculation by rule - \"VA - ProcessAmount\"" | "Completed"        |
		Then I check table 'TransactionsTree' contains '3' rows from list:
			| "Document template / Company" | "State" |
			| "VA - ProcessAmount"        | "Confirmed" |
			| "Venus LLC"               | "Confirmed" |
			| "Mercury LLC"             | "Confirmed" |

	* Checking statuses "VA - ProcessAmount"
		And I go to line in 'StepsTree' table:
			| "Step / Company"                   | "Step state" |
			| "Consolidation - \"VA - ProcessAmount\"" | "Completed"        |
		Then 'TransactionsTree' table became equal
			| "Document template / Company" | "State" |
			| "VA - ProcessAmount"        | "Confirmed" |
			| "System LLC"              | "Confirmed" |
		And I go to line in 'TransactionsTree' table:
			| "Document template / Company" | "State" |
			| "System LLC"              | "Confirmed" |
		And I activate field named 'TransactionsTreeCompanyDocumentTemplate' in 'TransactionsTree' table
		And I select current line in 'TransactionsTree' table
		
	* Verifying the final report
		And I open report instance for report type "VA - ProcessAmount" currency 'RUB' company "System LLC" scenario "VA - Report preparation process" frequency "Month" project '' dimensions '' '' '' '' '' ''
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - ProcessAmount"                                               | ''               | ''          | ''           | ''                | ''          | ''           | ''             | ''          | ''            | ''           | ''           | ''            |
			| ''                                                                | ''               | ''          | ''           | ''                | ''          | ''           | ''             | ''          | ''            | ''           | ''           | ''            |
			| ''                                                                | "January 2024" | ''          | ''           | "February 2024" | ''          | ''           | "March 2024" | ''          | ''            | "TOTAL"      | ''           | ''            |
			| ''                                                                | "Quantity"     | "Price"      | "Amount"      | "Quantity"      | "Price"      | "Amount"      | "Quantity"   | "Price"      | "Amount"       | "Quantity" | "Price"       | "Amount"       |
			| "Goods"                                                          | '60'             | '3,405,000' | '36,100,000' | '120'             | '3,535,000' | '74,900,000' | '180'          | '3,665,000' | '116,400,000' | '360'        | '10,605,000' | '227,400,000' |
			| "1C:ERP. Corporate performance management "                                   | '5'              | '975,000'   | '4,875,000'  | '10'              | '1,000,000' | '10,000,000' | '15'           | '1,025,000' | '15,375,000'  | '30'         | '3,000,000'  | '30,250,000'  |
			| "2C:Corporation "                                                  | '15'             | '1,025,000' | '15,375,000' | '30'              | '1,050,000' | '31,500,000' | '45'           | '1,075,000' | '48,375,000'  | '90'         | '3,150,000'  | '95,250,000'  |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '10'             | '600,000'   | '6,000,000'  | '20'              | '650,000'   | '13,000,000' | '30'           | '700,000'   | '21,000,000'  | '60'         | '1,950,000'  | '40,000,000'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '20'             | '180,000'   | '3,600,000'  | '40'              | '185,000'   | '7,400,000'  | '60'           | '190,000'   | '11,400,000'  | '120'        | '555,000'    | '22,400,000'  |
			| "5C:Corporate performance management "                                      | '10'             | '625,000'   | '6,250,000'  | '20'              | '650,000'   | '13,000,000' | '30'           | '675,000'   | '20,250,000'  | '60'         | '1,950,000'  | '39,500,000'  |
		
Scenario: 19.16 Checking that the process is completed

	* Searching for the required document
		And In the command interface I select "Budgeting, reporting, and analysis" "Reporting period management"
		Then "Reporting period management" window is opened
		And I search element "VA - Report preparation process" "Exact match" by field "Scenario" in list "Reporting period management"

	* Opening process management from the list
		Then "Reporting period management" window is opened
		And I click the button named 'FormProcessesManagementReportPreparation'
		Then "Reporting preparation management" window is opened
		And 'StepsTree' table became equal
			| "Step / Company"                             | "Step state" |
			| "Manual filling - \"VA - ProcessCount\"" | "Completed"        |
			| "Import - \"VA - ProcessPrice\""                  | "Completed"        |
			| "Calculation by rule - \"VA - ProcessAmount\""      | "Completed"        |
			| "Consolidation - \"VA - ProcessAmount\""           | "Completed"        |
		Then 'TransactionsTree' table became equal
			| "Document template / Company" | "State" |
			| "VA - ProcessCount"   | "Confirmed" |
			| "Mercury LLC"             | "Confirmed" |
			| "Venus LLC"               | "Confirmed" |
		And form element named 'LabelProcessState' became equal to "The report preparation process is completed on *" by template
		And I close "Reporting preparation management" window

	* Opening the document
		Then "Reporting period management" window is opened
		And I select current line in 'List' table
		Then I open period management document for scenario "VA - Report preparation process" frequency "Month"
		
	* Checking the process state
		And I go to line in 'Contents' table:
			| 'Description'                  |
			| "Report preparation process" |
		And I move to the tab named 'ProcessSetup'
		And form attribute named 'StartProcess' is available
		And form attribute named 'TerminateProcess' is unavailable
		And form attribute named 'Group_ProcessProgressManagementTable' is unavailable

	* Starting and stopping the process
		And I click the button named 'StartProcess'
		And I click the button named 'TerminateProcess'
