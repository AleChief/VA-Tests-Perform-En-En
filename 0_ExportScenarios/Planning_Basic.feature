#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for the Planning and control block

Scenario: I set control dimensions by dimension type 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6' for budget item with name 'TheName'
	* In the Limit management workstation, open item settings
		And I move to the tab named "SettingsLimitingBudgetItems"

	* Find the Limit management workstation item
		And I search and select element '[TheName]' "Exact match" by field "Budget item" in items table "ListItems"

		If 'NOT IsBlankString("[TheAnalytics1]")' Then
			If "ItemsList" table is equal to the passed table Then
				| 'Budget item' | '1'   |
				| '[TheName]'      | 'No' |
				And I activate field named "ListItemsControlDimension1" in "ListItems" table
				And I select current line in "ListItems" table
		If 'NOT IsBlankString("[TheAnalytics2]")' Then
			If "ItemsList" table is equal to the passed table Then
				| 'Budget item' | '2'   |
				| '[TheName]'      | 'No' |
				And I activate field named "ListItemsControlDimension2" in "ListItems" table
				And I select current line in "ListItems" table
		If 'NOT IsBlankString("[TheAnalytics3]")' Then
			If "ItemsList" table is equal to the passed table Then
				| 'Budget item' | '3'   |
				| '[TheName]'      | 'No' |
				And I activate field named "ListItemsControlDimension3" in "ListItems" table
				And I select current line in "ListItems" table
		If 'NOT IsBlankString("[TheAnalytics4]")' Then
			If "ItemsList" table is equal to the passed table Then
				| 'Budget item' | '4'   |
				| '[TheName]'      | 'No' |
				And I activate field named "ListItemsControlDimension4" in "ListItems" table
				And I select current line in "ListItems" table
		If 'NOT IsBlankString("[TheAnalytics5]")' Then
			If "ItemsList" table is equal to the passed table Then
				| 'Budget item' | '5'   |
				| '[TheName]'      | 'No' |
				And I activate field named "ListItemsControlDimension5" in "ListItems" table
				And I select current line in "ListItems" table
		If 'NOT IsBlankString("[TheAnalytics6]")' Then
			If "ItemsList" table is equal to the passed table Then
				| 'Budget item' | '6'   |
				| '[TheName]'      | 'No' |
				And I activate field named "ListItemsControlDimension6" in "ListItems" table
				And I select current line in "ListItems" table

Scenario: I create operational plan settings variant 'ThePlanOption' with duration 'N'
	* Creating an element
		And I click the button named 'FormCreate'
		And I input '[ThePlanOption]' text in the field named 'Description'
		And I input '[N]' text in the field named 'NumberOfPeriods'
		And I click the button named 'FormWrite'

Scenario: I select fixed horizon 'TheFixHorizon' with duration 'N' starting from period 'TheFirstPeriodOfFixedHorizon'
		And I select from the drop-down list named "KindOfHorizon"  by 'Fixed' string
		And I input '[N]' text in the field named 'NumberOfPeriods'
		And I select from the drop-down list named "FirstPeriod"  by '[TheFirstPeriodOfFixedHorizon]' string
		And I click the button named 'FormWrite'

Scenario: I search value 'ThePattern' by field 'TheAnalytics' in table 'TheTable'
		And I go to line in '[TheTable]' table:
			| '[TheAnalytics]'   |
			| '[ThePattern]'     |

Scenario: I search and select element "ThePattern" "TheCompareType" by field "TheField" in items table "TheListName"
		If a button named 'FormFind' exists Then
			And I click the button named 'FormFind'
		Else
			And I select context menu item named 'ListItemsContextMenuFind' of the form attribute named '[TheListName]'
		Then "Find" window is opened
		And I select from the drop-down list named 'FieldSelector'  by '[TheField]' string
		And I change the radio button named 'CompareType' value to '[TheCompareType]'
		And I wait "Find" window opening in 10 seconds
		And I input '[ThePattern]' text in the field named 'Pattern'
		And I click the button named 'Find'

Scenario: I select plan variant 'ThePlanOption'
		And I click Choice button of the field named "VariantSetting"
		And I go to line in "List" table:
			| 'Description'    |
			| '[ThePlanOption]' |
		And I click the button named 'FormSelect'

Scenario: I create operational plan document by budget type 'TheBudget'
		And in the table "List" I click the button named 'Create'
		Then 'Operational plan (creating)' window is opened
		And I change 'Budget profile' radio button value to '[TheBudget]'


Scenario: I set filter in operational plan list form 'TheField' 'TheComparisonType' 'TheValue'
		And in the table "List" I click the button named 'ListListSettings'
		Then 'List settings' window is opened
		And I activate 'Filter. Items' field
		And I delete all lines of "SettingsComposerUserSettingsItem3Filter" table
		And I delete all lines of 'SettingsComposerUserSettingsItem3Filter' table
		And in the table 'SettingsComposerUserSettingsItem3Filter' I click the button named 'SettingsComposerUserSettingsItem3FilterAddFilterItem'
	//	And in the table 'SettingsComposerUserSettingsItem3Filter' I go to the last row
		If 'StrFind("[TheField]", ".") > 0' Then
			And I input '[TheField]' text in the field named 'SettingsComposerUserSettingsItem3FilterLeftValue' of 'SettingsComposerUserSettingsItem3Filter' table
		And I select '[TheField]' by string from the drop-down list named 'SettingsComposerUserSettingsItem3FilterLeftValue' in 'SettingsComposerUserSettingsItem3Filter' table
		And I activate field named 'SettingsComposerUserSettingsItem3FilterComparisonType' in 'SettingsComposerUserSettingsItem3Filter' table
		And I select '[TheComparisonType]' by string from the drop-down list named 'SettingsComposerUserSettingsItem3FilterComparisonType' in 'SettingsComposerUserSettingsItem3Filter' table
		And I activate field named 'SettingsComposerUserSettingsItem3FilterRightValue' in 'SettingsComposerUserSettingsItem3Filter' table
		If 'StrFind(Lower("[TheComparisonType]"),"contains")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0 OR StrFind(Lower("[TheComparisonType]"),"contain")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0' Then
			And I input '[TheValue]' text in the field named 'SettingsComposerUserSettingsItem3FilterRightValue' of 'SettingsComposerUserSettingsItem3Filter' table
		Else
			And I select '[TheValue]' by string from the drop-down list named 'SettingsComposerUserSettingsItem3FilterRightValue' in 'SettingsComposerUserSettingsItem3Filter' table
		And I finish line editing in 'SettingsComposerUserSettingsItem3Filter' table
		And I click the button named 'FormEndEdit'

Scenario: I add filter in operational plan list form 'TheField' 'TheComparisonType' 'TheValue'
		And in the table "List" I click the button named 'ListListSettings'
		Then "List settings" window is opened
		And in the table 'SettingsComposerUserSettingsItem3Filter' I click the button named 'SettingsComposerUserSettingsItem3FilterAddFilterItem'
		If 'StrFind("[TheField]", ".") > 0' Then
			And I input '[TheField]' text in the field named 'SettingsComposerUserSettingsItem3FilterLeftValue' of 'SettingsComposerUserSettingsItem3Filter' table
		And I select '[TheField]' by string from the drop-down list named 'SettingsComposerUserSettingsItem3FilterLeftValue' in 'SettingsComposerUserSettingsItem3Filter' table
		And I activate field named 'SettingsComposerUserSettingsItem3FilterComparisonType' in 'SettingsComposerUserSettingsItem3Filter' table
		And I select '[TheComparisonType]' by string from the drop-down list named 'SettingsComposerUserSettingsItem3FilterComparisonType' in 'SettingsComposerUserSettingsItem3Filter' table
		And I activate field named 'SettingsComposerUserSettingsItem3FilterRightValue' in 'SettingsComposerUserSettingsItem3Filter' table
		If 'StrFind(Lower("[TheComparisonType]"),"contains")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0 OR StrFind(Lower("[TheComparisonType]"),"contain")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0' Then
			And I input '[TheValue]' text in the field named 'SettingsComposerUserSettingsItem3FilterRightValue' of 'SettingsComposerUserSettingsItem3Filter' table
		Else
			And I select '[TheValue]' by string from the drop-down list named 'SettingsComposerUserSettingsItem3FilterRightValue' in 'SettingsComposerUserSettingsItem3Filter' table
		And I finish line editing in 'SettingsComposerUserSettingsItem3Filter' table
		And I click the button named 'FormEndEdit'

Scenario: I remove all filters in operational plan list form
		And in the table "List" I click the button named 'ListListSettings'
		Then "List settings" window is opened
		And I move to the tab named 'SettingsComposerUserSettingsItem3'
		And I delete all lines of 'SettingsComposerUserSettingsItem3Filter' table
		And I click the button named 'FormEndEdit'

Scenario: I form limits report by budget type 'TheBudget' for period from "PeriodValue1" to "PeriodValue2" in currency 'TheCurrency'
		And In the command interface I select 'Planning and control' 'Limit report'
		And I click the button named 'AllSettings'
		Then 'Report settings "Report on limits (period in rows)"' window is opened
		Если представление элемента с именем 'ExtendedMode' стало равно 'Downtime' тогда
			And I change the radio button named 'ExtendedMode' value to 'Advanced'
		And in the table "Filters" I click the button named 'Filters_ClearCheckBoxes'
		And I close 'Report settings "Limits report (period in rows)"' window
		Then '1C:Enterprise' window is opened
		And I click 'Yes' button
		And I select from the drop-down list named "SettingsComposerUserSettingsItem1Value"  by '[TheBudget]' string
		And I select from the drop-down list named "SettingsComposerUserSettingsItem2Value"  by '[TheCurrency]' string
		And I click the button named 'SelectPeriod1'
		And I input '[PeriodValue1]' text in the field named 'DateBegin'
		And I input '[PeriodValue2]' text in the field named 'DateEnd'
		And I click the button named 'Select'
		And I click the button named 'GenerateReport'

Scenario: I add filter in limits report 'TheField' 'TheComparisonType' 'TheValue'
		And I click the button named 'AllSettings'
		And in the table "Filters" I click the button named 'Filters_Add'
		And I go to line in "AvailableFields" table:
			| 'Title'  |
			| '[TheField]' |
		And I select current line in "AvailableFields" table
		And I go to line in "Filters" table:
			| 'Use' | 'Field'       |
			| 'Yes'            | '[TheField]' |
		And I activate field named 'FiltersComparisonType' in 'Filters' table
		And I select '[TheComparisonType]' by string from the drop-down list named 'FiltersComparisonType' in 'Filters' table
		And I activate field named 'FiltersRightValue' in 'Filters' table
		If 'StrFind(Lower("[TheComparisonType]"),"contains")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0 OR StrFind(Lower("[TheComparisonType]"),"contain")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0' Then
			And I input '[TheValue]' text in the field named 'FiltersRightValue' of 'Filters' table
		Else
			And I select '[TheValue]' by string from the drop-down list named 'FiltersRightValue' in 'Filters' table
		And I finish line editing in "Filters" table
		And I click the button named 'GenerateAndClose'

	



//		Given I set the table of rows "Filters"
//			| 'Use' | 'Field'       | 'Condition'             |
//			| 'Yes'            | '[TheField]' | '[TheComparisonType]' |
//	
//		And in the table "Filters" I activate the field named "FiltersRightValue"
//		And in the table "Filters" I select the current row
//		And in the table "Filters" from the drop-down list named "FiltersRightValue" I select by row '[TheValue]'

Scenario: I set filter in reserve list form 'TheField' 'TheComparisonType' 'TheValue'
		And in the table "List" I click the button named 'ListListSettings'
		Then 'List settings' window is opened
		And I activate 'Filter. Items' field
		And I delete all lines of "SettingsComposerUserSettingsItem4Filter" table
		And I delete all lines of 'SettingsComposerUserSettingsItem4Filter' table
		And in the table 'SettingsComposerUserSettingsItem4Filter' I click the button named 'SettingsComposerUserSettingsItem4FilterAddFilterItem'
		If 'StrFind("[TheField]", ".") > 0' Then
			And I input '[TheField]' text in the field named 'SettingsComposerUserSettingsItem4FilterLeftValue' of 'SettingsComposerUserSettingsItem4Filter' table
		And I select '[TheField]' by string from the drop-down list named 'SettingsComposerUserSettingsItem4FilterLeftValue' in 'SettingsComposerUserSettingsItem4Filter' table
		And I activate field named 'SettingsComposerUserSettingsItem4FilterComparisonType' in 'SettingsComposerUserSettingsItem4Filter' table
		And I select '[TheComparisonType]' by string from the drop-down list named 'SettingsComposerUserSettingsItem4FilterComparisonType' in 'SettingsComposerUserSettingsItem4Filter' table
		And I activate field named 'SettingsComposerUserSettingsItem4FilterRightValue' in 'SettingsComposerUserSettingsItem4Filter' table
		If 'StrFind(Lower("[TheComparisonType]"),"contains")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0 OR StrFind(Lower("[TheComparisonType]"),"contain")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0' Then
			And I input '[TheValue]' text in the field named 'SettingsComposerUserSettingsItem4FilterRightValue' of 'SettingsComposerUserSettingsItem4Filter' table
		Else
			And I select '[TheValue]' by string from the drop-down list named 'SettingsComposerUserSettingsItem4FilterRightValue' in 'SettingsComposerUserSettingsItem4Filter' table
		And I finish line editing in 'SettingsComposerUserSettingsItem4Filter' table
		And I click the button named 'FormEndEdit'

Scenario: I add filter in reserve list form 'TheField' 'TheComparisonType' 'TheValue'
		And in the table "List" I click the button named 'ListListSettings'
		Then "List settings" window is opened
		And in the table 'SettingsComposerUserSettingsItem4Filter' I click the button named 'SettingsComposerUserSettingsItem4FilterAddFilterItem'
		If 'StrFind("[TheField]", ".") > 0' Then
			And I input '[TheField]' text in the field named 'SettingsComposerUserSettingsItem4FilterLeftValue' of 'SettingsComposerUserSettingsItem4Filter' table
		And I select '[TheField]' by string from the drop-down list named 'SettingsComposerUserSettingsItem4FilterLeftValue' in 'SettingsComposerUserSettingsItem4Filter' table
		And I activate field named 'SettingsComposerUserSettingsItem4FilterComparisonType' in 'SettingsComposerUserSettingsItem4Filter' table
		And I select '[TheComparisonType]' by string from the drop-down list named 'SettingsComposerUserSettingsItem4FilterComparisonType' in 'SettingsComposerUserSettingsItem4Filter' table
		And I activate field named 'SettingsComposerUserSettingsItem4FilterRightValue' in 'SettingsComposerUserSettingsItem4Filter' table
		If 'StrFind(Lower("[TheComparisonType]"),"contains")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0 OR StrFind(Lower("[TheComparisonType]"),"contain")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0' Then
			And I input '[TheValue]' text in the field named 'SettingsComposerUserSettingsItem4FilterRightValue' of 'SettingsComposerUserSettingsItem4Filter' table
		Else
			And I select '[TheValue]' by string from the drop-down list named 'SettingsComposerUserSettingsItem4FilterRightValue' in 'SettingsComposerUserSettingsItem4Filter' table
		And I finish line editing in 'SettingsComposerUserSettingsItem4Filter' table
		And I click the button named 'FormEndEdit'

Scenario: I remove all filters in reserve list form
		Then "List settings" window is opened
		And I move to the tab named 'SettingsComposerUserSettingsItem4'
		And I delete all lines of 'SettingsComposerUserSettingsItem4Filter' table
		And I click the button named 'FormEndEdit'

Scenario: I create reservation document by budget type 'TheBudget'
		And in the table "List" I click the button named 'Create'
		Then 'Reservation of plans and limits (creating)' window is opened
		And I change 'Budget profile' radio button value to '[TheBudget]'

Scenario: I open limits management workstation by budget type 'TheBudget'
		And In the command interface I select 'Planning and control' 'Plan and limit management'
		And I click '[TheBudget]' button

Scenario: I create supplier invoice 'TheContractor' for company 'TheBusinessUnitName'
	
		And In the command interface I select 'Purchases' 'Supplier invoices'
		And I remove checkbox named 'SettingsComposerUserSettingsItem1Use'
		And I click the button named 'FormCreate'
		Then 'Supplier invoice (creating)' window is opened
		And I select from the drop-down list named "Counterparty"  by '[TheContractor]' string
		And I select from the drop-down list named "Organization"  by '[TheBusinessUnitName]' string
		And I click the button named 'FormWrite'

Scenario: I add nomenclature 'TheProductName' in quantity 'N' at price 'X' at rate 'TheVATrate' to supplier invoice
		And I add a line in "Goods" table
		And I click choice button of the attribute named "GoodsProductRange" in "Goods" table
		And I search and select element '[TheProductName]' "Exact match" by field "Description" in list "List"
		And I activate field named "GoodsCount" in "Goods" table
		And I input '[N]' text in the field named 'GoodsCount' of "Goods" table
		And I input '[X]' text in the field named 'GoodsPrice' of "Goods" table
		And I activate field named "GoodsVATRate" in "Goods" table
		And I select '[TheVATrate]' by string from the drop-down list named "GoodsVATRate" in "Goods" table
		And I finish line editing in "Goods" table
//		And in the table "Goods" I cancel row editing
				
Scenario: I check limit control is violated
		And I move to the tab named "PageDocumentControl"
		And I click the button named 'ExecuteCheckDocument'
		Then "TableControlDocument" table became equal
			| 'Type of control'                | 'Result' | 'Additional information' |
			| 'Budget limit control'  | 'Violated'   | 'Details'                 |
			| 'Budget reserve control' | '*'         | '*'                         |

Scenario: I check reserve control is violated
		And I move to the tab named "PageDocumentControl"
		And I click the button named 'ExecuteCheckDocument'
		Then "TableControlDocument" table became equal
			| 'Type of control'                | 'Result' | 'Additional information' |
			| 'Budget limit control'  | '*'         | '*'                         |
			| 'Budget reserve control' | 'Violated'   | 'Details'                 |
		
Scenario: I check limit and reserve control passed successfully
		And I move to the tab named "PageDocumentControl"
		And I click the button named 'ExecuteCheckDocument'
		Then "TableControlDocument" table became equal
			| 'Type of control'                | 'Result' | 'Additional information' |
			| 'Budget limit control'  | 'OK'        | 'Details'                 |
			| 'Budget reserve control' | 'OK'        | 'Details'                 |

Scenario: I create payment register for company 'TheBusinessUnitName'
		And In the command interface I select 'Treasury' 'Payment registers'

	* Cancel document posting
		And I select from the drop-down list named "SettingsComposerUserSettingsItem0Value"  by '[TheBusinessUnitName]' string
		And for each line of 'List' table I do
			And I delete current row in list 'List'

	* Create a new document
		And I click the button named 'FormCreate'
		Then 'Payment register (creating)' window is opened
//		And I press the selection button for the field named "Organization"
//		And I in the table 'List' by the field 'Name in the application' I search for the value '[TheBusinessUnitName]'
//		And in the table "List" I select the current row
		And I click the button named 'FormWrite'

Scenario: I create plan and limits adjustment request based on
		And I click 'Request for correction of plans and limits' button
		Then 'Application for correction of plans and limits (creation) *' window is opened
		And I click the button named 'FormPost'
		And I delete '$$ReferenceValue$$' variable
		And I save current window navigation link to "$$ReferenceKnowledgeKey$$" variable
		And I click the button named 'FormShowInListRequestForPlansAdjustment'
		And I save the value of the field named 'DocumentAmount' of 'List' table as 'ToGuarantee'

Scenario: I check the creation of OFD 1 "DocumentIB"
    * Opening the OFD list
        And In the command interface I select 'Treasury' 'Actual data reflections'
        Then 'Recording of actual data' window is opened
    
	* Searching for a document type
        And I click the button named 'FormFind'
        Then 'Find' window is opened
        And I select 'Infobase document' exact value from the drop-down list named "FieldSelector"
        And I click Choice button of the field named "Pattern"
        Then 'Infobase documents' window is opened
        And I go to line in "List" table:
            | 'Document'                 |
            | '[DocumentIB]' |
        And I select current line in "List" table
        Then 'Find' window is opened
        And I click the button named 'Find'
   	
	* Filter the document list by date
		And I activate field named "Date" in "List" table
		And in the table "List" I click the button named 'ListContextMenuSetDateInterval'
		Then 'Select period' window is opened
		And I input '$DateDoc$' variable value in the field named 'DateBegin'
		And I move to the next attribute
		And I click the button named 'Select'

	* Positioning on the source document for automatic determination of the document type in the search window
        And I activate field named "SourceDocument_" in "List" table
    
	* Search by source document number
        And I click the button named 'FormFind'
        Then 'Find' window is opened
        And I select 'Original document' exact value from the drop-down list named "FieldSelector"
       And I input '$NumberDoc$' text in the field named 'Pattern'
        And I click the button named 'Find'
 
	* Checking the result (there should be one row)
        Then "List" table became equal
            | 'Infobase document'                           |
            | '[DocumentIB]' |

   //* Closing the OFD list (the list with the found document should remain open)
 	//	And I close the window 'Actual data reflections'

Scenario: I check dimension filling by budget type 'TheBudget' in OFD
	
		And I save '[TheBudget]' line to the variable "Budget"
		When 'Actual data recordings' window is opened
		And I select current line in "List" table
		If "Budget" variable is equal to 'Budget of Cash Flows' Then
			And I move to the tab named "GroupCFB"
			Then "TabBudgetMovementMonetaryFunds" table became equal by template
				| 'Cash flow item' | 'Dimension1'        | 'Dimension2'        | 'Dimension3'        | 'Dimension4'        | 'Dimension5'        | 'Dimension6'        | 'Financial responsibility center'     | 'Project'     | 'Amount in document currency' | 'Document plan' |
				| '$VAItem$' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '$VACFD$' | '$VAProject$' | '$Amount$'                  | '$PlanningDocument$'     |
						
		If "Budget" variable is equal to 'БДР' Then
			And I move to the tab named "GroupIEBudget"
			Then "TabBudgetIncomeAndExpense" table became equal
				| 'IEB item' | 'Dimension1'        | 'Dimension2'        | 'Dimension3'        | 'Dimension4'        | 'Dimension5'        | 'Dimension6'        | 'Financial responsibility center'     | 'Project'     | 'Amount in document currency' | 'Document plan' |
				| '$VAItem$' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '$VACFD$' | '$VAProject$' | '$Amount$'                  | '$PlanningDocument$'     |
			
Scenario: I check movements by budget type 'TheBudget' in OFD
		
		And I save '[TheBudget]' line to the variable "Budget"
		And I save the value of the field named 'ArrivalExpense' as 'ArrivalExpense'
		And I click the button named 'FormProcessingDocumentRegisterRecordsDocumentRegisterRecordsReport'
		When 'Document register records: Recording actual data *' window is opened
		And I move to the tab named "GroupBudgetsOperations"
		If "Budget" variable is equal to 'Budget of Cash Flows' Then
			If "ArrivalExpense" variable is equal to 'Income' Then
				Then "BudgetsOperations" table became equal
					| 'N' | 'Budget profile'                      | 'Planning object' | 'Amount' | 'Executed amount' | 'Structure dimension'                  | 'Executed limit' | 'Limit' | 'Currency' | 'Executed quantity' | 'Limiting currency' | 'Budget items dimension' |
					| '1' | 'Cash flow budget' | '$PlanningDoc$'   | ''      | '$Amount$'         | '$VABudgetCode$; $VAProject$; $VAOrganization$' | '$Amount$'         | ''      | 'RUB'    | ''                     | 'RUB'                  | '$VAItem$ Income'         |

		If "Budget" variable is equal to 'Budget of Cash Flows' Then
			If "ArrivalExpense" variable is equal to 'Expense' Then
				Then "BudgetsOperations" table became equal
					| 'N' | 'Budget profile'                      | 'Planning object' | 'Amount' | 'Executed amount' | 'Structure dimension'                  | 'Executed limit' | 'Limit' | 'Currency' | 'Executed quantity' | 'Limiting currency' | 'Budget items dimension' |
					| '1' | 'Cash flow budget' | '$PlanningDoc$'   | ''      | '$Amount$'         | '$VABudgetCode$; $VAProject$; $VAOrganization$' | '$Amount$'         | ''      | 'RUB'    | ''                     | 'RUB'                  | '$VAItem$ Expense'         |


		If "Budget" variable is equal to 'БДР' Then
			If "ArrivalExpense" variable is equal to 'Income' Then
				Then "BudgetsOperations" table became equal by template
					| 'N' | 'Budget profile'               | 'Planning object' | 'Amount'    | 'Executed amount' | 'Structure dimension'                  | 'Executed limit' | 'Limit'    | 'Currency' | 'Executed quantity' | 'Limiting currency' | 'Budget items dimension' |
					| '1' | 'P&amp;L budget' | '$PlanningDoc$'   | '-$Amount$' | '$Amount$'         | '$VABudgetCode$; $VAProject$; $VAOrganization$' | '$Amount$'         | '-$Amount$' | 'RUB'    | ''                     | 'RUB'                  | '$VAItem$ Income'         |

		If "Budget" variable is equal to 'БДР' Then
			If "ArrivalExpense" variable is equal to 'Expense' Then
				Then "BudgetsOperations" table became equal by template
					| 'N' | 'Budget profile'               | 'Planning object' | 'Amount'    | 'Executed amount' | 'Structure dimension'                  | 'Executed limit' | 'Limit'    | 'Currency' | 'Executed quantity' | 'Limiting currency' | 'Budget items dimension' |
					| '1' | 'P&amp;L budget' | '$DocumentPlan$'   | '-$Amount$' | '$Amount$'         | '$VAFinancialResponsibilityCenter$; $VAProject$; $VAOrganization$' | '$Amount$'         | '-$Amount$' | 'RUB'    | ''                     | 'RUB'                  | '$VAItem$ Expense'         |

Scenario: I open and check customer payment schedule

		And I click the button named 'OpenScheduleCalculations'
		Then 'Payment schedule with buyer or supplier *' window is opened
		And I save the value of the field named 'ObjectCalculations' as 'PlanningDocument'

	* Checking the dimensions of the chart
		And I move to the tab named "GroupSchedule"
		If number of 'ScheduleCalculations' table lines is "equal" 0 Then
			And I input 'CurrentDate()' expression value in the field named 'DateFirstOperation'
			And in the table "ScheduleCalculations" I click the button named 'ScheduleCalculateFromDateFirstPayment'
		And I go to the first line in 'ScheduleOfCalculations' table
		Then "ScheduleCalculationsLinear" table became equal by template
			| 'Schedule transaction' | 'Budget profile'               | 'Debt structure item' | 'Direction of movement' | 'Budget item' | 'Dimension 1'       | 'Dimension 2'       | 'Dimension 3'       | 'Dimension 4'       | 'Dimension 5'       | 'Dimension 6'       | 'Financial responsibility center'   | 'Project'   | 'Company account' | 'Counterparty account' | 'Currency' | 'Amount'   |
			| 'Accrual'       | 'P&amp;L budget' | 'Principal debt'                   | 'Income'               | 'VAItem'       | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | 'VAFinancialResponsibilityCenter' | 'VAProject' | ''                 | ''                 | 'RUB'    | '$Amount$' |
		
		And I go to the last line in 'ScheduleOfCalculations' table
		Then "ScheduleCalculationsLinear" table became equal by template
			| 'Schedule transaction' | 'Budget profile'                      | 'Debt structure item' | 'Direction of movement' | 'Budget item' | 'Dimension 1'       | 'Dimension 2'       | 'Dimension 3'       | 'Dimension 4'       | 'Dimension 5'       | 'Dimension 6'       | 'Financial responsibility center'   | 'Project'   | 'Company account' | 'Counterparty account' | 'Currency' | 'Amount'   |
			| 'Payment'           | 'Cash flow budget' | 'Principal debt'                   | 'Income'               | 'VAItem'       | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | 'VAFRC' | 'VAProject' | ''                 | ''                 | 'RUB'    | '$Amount$' |

	* Checking the movements
		And I move to the tab named "MainGroup3"
		If form element named "ObjectCalculations" became equal to 'Customer order *' by template Then
			And I click the button named 'FormProcessingDocumentRegisterRecordsDocumentRegisterRecordsReport'
		Else
			And I click the button named 'FormPost'
			And I click the button named 'FormProcessingDocumentRegisterRecordsDocumentRegisterRecordsReport'
		
		Then 'Document register records: Payment schedule with buyer or supplier * from *' window is opened
		Then "BudgetsOperations" table became equal by template
			| 'N' | 'Budget profile'                      | 'Income expense' | 'Limiting multiplier' | 'Planning object' | 'Amount'   | 'Partners dimension'                                           | 'Version source' | 'State' | 'Planning rate' | 'Needs dimension' | 'Executed amount' | 'Structure dimension'                  | 'Executed limit' | 'Supply dimension' | 'Количество' | 'Limit'   | 'Currency' | 'Executed quantity' | 'Nomenclature dimension' | 'Limiting currency' | 'Planning multiplier' | 'Rate specified in operation' | 'Limiting rate' | 'Budget items dimension' | 'Document adjusting' |
			| '1' | 'P&amp;L budget'        | 'Income'        | '1'                       | '$PlanningDoc$'   | '$Amount$' | '$VAOrganization$; $VACustomer$; $Contract$; $PlanningDoc$' | ''                | ''          | '1.0000'            | ''                       | ''                | '$VABudgetCode$; $VAProject$; $VAOrganization$' | ''                | ''                   | ''           | '$Amount$' | 'RUB'    | ''                     | ''                       | 'RUB'                  | '1'                      | 'No'                   | '1.0000'             | '$VAItem$ Income'         | ''                        |
			| '2' | 'Cash flow budget' | 'Income'        | '1'                       | '$DocumentPlan$'   | '$Amount$' | '$VAOrganization$; $VACustomer$; $Contract$; $DocumentPlan$' | ''                | ''          | '1.0000'            | ''                       | ''                | '$VAFinancialResponsibilityCenter$; $VAProject$; $VAOrganization$' | ''                | ''                   | ''           | '$Amount$' | 'RUB'    | ''                     | ''                       | 'RUB'                  | '1'                      | 'No'                   | '1.0000'             | '$VAItem$ Income'         | ''                        |

		And I close 'Document register records: Payment schedule with buyer or supplier * from *' window
		Then 'Payment schedule with buyer or supplier * from *' window is opened
		And I close 'Payment schedule with buyer or supplier * from *' window

Scenario: I open and check supplier payment schedule

		And I click the button named 'OpenScheduleCalculations'
		Then 'Payment schedule with buyer or supplier *' window is opened
		And I save the value of the field named 'ObjectCalculations' as 'PlanningDocument'

	* Checking the dimensions of the chart
		And I move to the tab named "GroupSchedule"
		And I go to the first line in 'ScheduleOfCalculations' table
		Then "ScheduleCalculationsLinear" table became equal by template
			| 'Schedule transaction' | 'Budget profile'               | 'Debt structure item' | 'Direction of movement' | 'Budget item' | 'Dimension 1'       | 'Dimension 2'       | 'Dimension 3'       | 'Dimension 4'       | 'Dimension 5'       | 'Dimension 6'       | 'Financial responsibility center'   | 'Project'   | 'Company account' | 'Counterparty account' | 'Currency' | 'Amount'   |
			| 'Accrual'       | 'P&amp;L budget' | 'Principal debt'                   | 'Expense'               | 'VAItem'       | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | 'VAFinancialResponsibilityCenter' | 'VAProject' | ''                 | ''                 | 'RUB'    | '$Amount$' |
		
		And I go to the last line in 'ScheduleOfCalculations' table
		Then "ScheduleCalculationsLinear" table became equal by template
			| 'Schedule transaction' | 'Budget profile'                      | 'Debt structure item' | 'Direction of movement' | 'Budget item' | 'Dimension 1'       | 'Dimension 2'       | 'Dimension 3'       | 'Dimension 4'       | 'Dimension 5'       | 'Dimension 6'       | 'Financial responsibility center'   | 'Project'   | 'Company account' | 'Counterparty account' | 'Currency' | 'Amount'   |
			| 'Payment'           | 'Cash flow budget' | 'Principal debt'                   | 'Expense'               | 'VAItem'       | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | '<Not used>' | 'VAFRC' | 'VAProject' | ''                 | ''                 | 'RUB'    | '$Amount$' |

	* Checking the movements
		And I move to the tab named "MainGroup3"
		If form element named "ObjectCalculations" became equal to 'Supplier order *' by template Then
			And I click the button named 'FormProcessingDocumentRegisterRecordsDocumentRegisterRecordsReport'
		Else
			And I click the button named 'FormPost'
			And I click the button named 'FormProcessingDocumentRegisterRecordsDocumentRegisterRecordsReport'
		Then 'Document register records: Payment schedule with buyer or supplier * from *' window is opened
		Then "BudgetsOperations" table became equal by template
			| 'N' | 'Budget profile'                      | 'Income expense' | 'Limiting multiplier' | 'Planning object' | 'Amount'   | 'Partners dimension'                                           | 'Version source' | 'State' | 'Planning rate' | 'Needs dimension' | 'Executed amount' | 'Structure dimension'                  | 'Executed limit' | 'Supply dimension' | 'Количество' | 'Limit'   | 'Currency' | 'Executed quantity' | 'Nomenclature dimension' | 'Limiting currency' | 'Planning multiplier' | 'Rate specified in operation' | 'Limiting rate' | 'Budget items dimension' | 'Document adjusting' |
			| '1' | 'P&amp;L budget'        | 'Expense'        | '1'                       | '$PlanningDoc$'   | '$Amount$' | '$VAOrganization$; $VACustomer$; $Contract$; $PlanningDoc$' | ''                | ''          | '1.0000'            | ''                       | ''                | '$VABudgetCode$; $VAProject$; $VAOrganization$' | ''                | ''                   | ''           | '$Amount$' | 'RUB'    | ''                     | ''                       | 'RUB'                  | '1'                      | 'No'                   | '1.0000'             | '$VAItem$ Expense'         | ''                        |
			| '2' | 'Cash flow budget' | 'Expense'        | '1'                       | '$DocumentPlan$'   | '$Amount$' | '$VAOrganization$; $VACustomer$; $Contract$; $DocumentPlan$' | ''                | ''          | '1.0000'            | ''                       | ''                | '$VAFinancialResponsibilityCenter$; $VAProject$; $VAOrganization$' | ''                | ''                   | ''           | '$Amount$' | 'RUB'    | ''                     | ''                       | 'RUB'                  | '1'                      | 'No'                   | '1.0000'             | '$VAItem$ Expense'         | ''                        |

		And I close 'Document register records: Payment schedule with buyer or supplier * from *' window
		Then 'Payment schedule with buyer or supplier * from *' window is opened
		And I close 'Payment schedule with buyer or supplier * from *' window

Scenario: I open the document movements with a filter by movement type 'MovementType' in ERP_UH

		And I click 'Document register records' button
		Then 'Document register records (Horizontal)' window is opened
		And I activate 'Display only' field
		And I click Select button of "Display only" field
		Then 'Display only' window is opened
		And I click the button named 'ListClearCheckBoxes'
		And I go to line in "List" table:
			| 'Value'      | 'Mark' |
			| '[MovementType]' | 'No'     |
		And I change checkbox named 'ListCheckBox' in "List" table
		And I finish line editing in "List" table
		And I click the button named 'OkCommand'
		Then 'Document register records (Horizontal)' window is opened
		And I click the button named 'GenerateReport'


