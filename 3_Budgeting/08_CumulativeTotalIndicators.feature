#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 08. Calculation of indicators as cumulative total

	As Administrator I want to
	Check various ways of calculating indicators as cumulative total

Background:

	And I close all client application windows

Scenario: 08.00 Determining the application type
	
	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 08.01 Creating report group "VA - Cumulative total (group)"

	And I create report type group with name "VA - Cumulative total (group)" and parent "VA - Report group"

Scenario: 08.02 Creating report type "VA - Cumulative total (source)"

	And I create report type with name "VA - Cumulative total (source)" and parent "VA - Cumulative total (group)"

	And I open report type with name "VA - Cumulative total (source)"
	And I set checkbox named 'ProjectSeparation'
	And I move to the tab named 'DimensionsOfReport'
	And I select from the drop-down list named 'DimensionKind1'  by "VA0CFItems" string
	And I click the button named 'RecordButtonForm'
	When "Data restructuring" window is opened
	And I click the button named 'FormOK'

	And I click the button named 'EditTree'
	When "Report wizard" window is opened
	And I add row with name "Goods" in report wizard
	And I add column with name "Count" in report wizard
	And I add dimension with code "VA0Product" in cell 'R2C3' in report wizard
		
	And I create default template for report type "VA - Cumulative total (source)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Cumulative total (source)"

Scenario: 08.03 Creating report instance - "VA - Cumulative total (source)"

	And I create report instance for report type "VA - Cumulative total (source)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions "3Software sale" '' '' '' '' ''

	* The document should be empty
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Cumulative total (source)" | ''               | ''                | ''             | ''           |
			| ''                                 | ''               | ''                | ''             | ''           |
			| ''                                 | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
			| ''                                 | "Count"     | "Count"      | "Count"   | "Count" |
			| "Goods"                           | '0'              | '0'               | '0'            | '0'          |

	* Filling indicator values
		When '$WindowTitle$' window is opened
		And I add values with indicator expansion in cell 'R6C2'
				| "VA0Product"                                                     | 'Value1' |
				| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '10.00000'  |
				| "3C:Enterprise 8 CORP. Client license for 100 users" | '10.00000'  |
				| "5C:Corporate performance management"                                      | '10.00000'  |
				| "2C:Corporation"                                                  | '10.00000'  |
				| "1C:ERP. Corporate performance management"                                   | '10.00000'  |

	* Copying indicator values
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2:R11C2' cell
		And I click the button named 'CopyToClipboard'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C3:R11C3' cell
		And I paste from clipboard in the layout
		And I change value to '100.00000' percent in cell 'R6C3:R11C3'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C3:R11C3' cell
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'
		And I change value to '10.00000' in cell 'R7C4:R11C4'

	* Comparing the final document
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Cumulative total (source)"                                | ''               | ''                | ''             | ''           |
			| ''                                                                | ''               | ''                | ''             | ''           |
			| ''                                                                | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
			| ''                                                                | "Count"     | "Count"      | "Count"   | "Count" |
			| "Goods"                                                          | '50'             | '100'             | '150'          | '300'        |
			| "5C:Corporate performance management "                                      | '10'             | '20'              | '30'           | '60'         |
			| "2C:Corporation "                                                  | '10'             | '20'              | '30'           | '60'         |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '10'             | '20'              | '30'           | '60'         |
			| "1C:ERP. Corporate performance management "                                   | '10'             | '20'              | '30'           | '60'         |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '10'             | '20'              | '30'           | '60'         |

	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 08.04 Creating report type "VA - Cumulative total (recipient)"

	And I create report type with name "VA - Cumulative total (recipient)" and parent "VA - Cumulative total (group)"

	And I open report type with name "VA - Cumulative total (recipient)"
	And I set checkbox named 'ProjectSeparation'
	And I move to the tab named 'DimensionsOfReport'
	And I select from the drop-down list named 'DimensionKind1'  by "VA0CFItems" string
	And I click the button named 'RecordButtonForm'
	When "Data restructuring" window is opened
	And I click the button named 'FormOK'

	And I click the button named 'EditTree'
	When "Report wizard" window is opened
	
	And I add row with name "SourceData" in report wizard
	And I add row with name "FromSourceBeforeCalculation" in report wizard
	And I add row with name "FromSourceBeforeCalculationX2" in report wizard
	And I add row with name "FromSourceAfterCalculation" in report wizard
	And I add row with name "FromSourceSelectionByPeriod" in report wizard
	And I add row with name "FromReceiverSelectionByPeriod" in report wizard
	And I add row with name "FromReceiverShiftPeriod" in report wizard
	And I add row with name "FromSourceArbitraryCode" in report wizard
		
	And I add column with name "Count" in report wizard
	
	And I add dimension with code "VA0Product" in cell 'R2C3' in report wizard
	When "Report wizard" window is opened
	And I click the button named 'CopyAndShiftDown1'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
	And I click the button named 'DeleteDimension'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C3' cell
	And I click the button named 'DeleteDimension'

	* Adding calculation formulas
		* DataSource
			When "Report wizard" window is opened
			And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'RefToIndicator1'
			And I select indicator with code "Goods_Count" of report type "VA - Cumulative total (source)"
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'
		* FromSourceBeforeCalculationX2
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'WriteFormula'
			Then "Report wizard" window is opened
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
			And I remove checkbox named 'UseMultiperiodContext'
			And I input 'SELECT 2 AS Value' text in the field named 'QueryTextForm'
			And I click the button named 'EditQueryText'
			And I move to the tab named 'ComplianceAnalyst'
			And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I select current line in 'ComplianceTable' table
			And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
			And I select current line in 'ComplianceTable' table
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Data source (create) *" window is opened
			And I click the button named 'FormWriteAndClose'
			And I wait "Data source (create) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'ButtonMultiply'
			And I click the button named 'WriteAndCollapse'
		* FromSourceFilterByPeriod
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select "Current infobase report item indicator" exact value from the drop-down list named 'MethodOfObtaining'
			And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Cumulative total (source)" string
			And I click Choice button of the field named 'IndicatorFilter'
			And I select indicator with code "Goods_Count"
			Then "Data source (create) *" window is opened
			And I move to the tab named 'FiltersPage'
			And I go to line in 'TreeOfFilterParametersDB' table:
				| "Filter"         | "Field"            |
				| "Report period" | "[Report period]" |
			And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I select current line in 'TreeOfFilterParametersDB' table
			And I select "List of values (function in 1C:Enterprise script)" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			When "VA - Cumulative total (recipient): Calculate a parameter value" window is opened
			And I input text in the field named 'TextDocumentFieldProcedure'
				|'// Getting all periods up to the current one'|
				|'Result = New ValueList;'|
				|'For Cnt = 0 To ObjectOfARAP.ArrayOfPeriods.Find(ObjectOfARAP.ReportPeriod) Do'|
				|' Result.Add(ObjectOfARAP.ArrayOfPeriods.Get(Cnt));'|
				|'EndDo;'|
			And I click the button named 'FormWriteAndClose'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			And I activate "Data source (create) *" window
			Then "Data source (create) *" window is opened
			And I finish line editing in 'TreeOfFilterParametersDB' table
			And I click the button named 'FormWriteAndClose'
			And I wait "Data source (create) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'
		* FromDestinationFilterByPeriod
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select "Current infobase report item indicator" exact value from the drop-down list named 'MethodOfObtaining'
			And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Cumulative total (recipient)" string
			And I click Choice button of the field named 'IndicatorFilter'
			And I select indicator with code "SourceData_Count"
			Then "Data source (create) *" window is opened
			And I move to the tab named 'FiltersPage'
			And I go to line in 'TreeOfFilterParametersDB' table:
				| "Filter"         | "Field"            |
				| "Report period" | "[Report period]" |
			And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I select current line in 'TreeOfFilterParametersDB' table
			And I select "List of values (function in 1C:Enterprise script)" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			Then "VA - Cumulative total (recipient): Calculate a parameter value" window is opened
			And I input text in the field named 'TextDocumentFieldProcedure'
				|'// Getting all periods up to the current one'|
				|'Result = New ValueList;'|
				|'For Cnt = 0 To ObjectOfARAP.ArrayOfPeriods.Find(ObjectOfARAP.ReportPeriod) Do'|
				|' Result.Add(ObjectOfARAP.ArrayOfPeriods.Get(Cnt));'|
				|'EndDo;'|
			And I click the button named 'FormWriteAndClose'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			And I activate "Data source (create) *" window
			Then "Data source (create) *" window is opened
			And I finish line editing in 'TreeOfFilterParametersDB' table
			And I click the button named 'FormWriteAndClose'
			And I wait "Data source (create) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'
		* FromDestinationMovePeriod
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R8C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Cumulative total (recipient)" string
			And I click Choice button of the field named 'IndicatorFilter'
			And I select indicator with code "FromReceiverSelectio_Count"
			Then "Data source (create) *" window is opened
			And I move to the tab named 'FiltersPage'
			And I go to line in 'TreeOfFilterParametersDB' table:
				| "Filter"         | "Field"            |
				| "Report period" | "[Report period]" |
			And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I select current line in 'TreeOfFilterParametersDB' table
			And I select "Report period with a shift" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			And I input '-1' text in the field named 'DefiningMethodClarification' of 'TreeOfFilterParametersDB' table
			And I finish line editing in 'TreeOfFilterParametersDB' table
			And I click the button named 'FormWriteAndClose'
			And I wait "Data source (create) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'ButtonPlus'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'WriteAndCollapse'
		* FromSourceArbitraryCode
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'ArbitraryCode'
			And I click the button named 'EditProcedure'
			Then "VA - Cumulative total (recipient): Calculation formula" window is opened
			And I save "VACumulativeTotalSource" value to 'ReportCode' variable
			And I save "Goods_Count" value to 'CodeOfIndicator1' variable
			And I input text in the field named 'TextDocumentFieldProcedure'
				|'// Getting references to the needed indicators'|
				|'IndicatorSource = Catalogs.ReportsIndicators.FindByCode("$CodeIndicator1$",,,Catalogs.ReportsKinds.FindByCode("$CodeReport$"));'|
				|''|
				|'// Getting the array of periods'|
				|'tReportPeriods = New Array;'|
				|'For Cnt = 0 To ObjectOfARAP.ArrayOfPeriods.Find(ObjectOfARAP.ReportPeriod) Do'|
				|' tReportPeriods.Add(ObjectOfARAP.ArrayOfPeriods.Get(Cnt));'|
				|'EndDo;'|
				|''|
				|'FilterParameterStructure = New Structure("ReportIndicator,Currency,ReportPeriod,Scenario,Organization", IndicatorSource,ObjectOfARAP.MainCurrency,tReportPeriods,ObjectOfARAP.Scenario,ObjectOfARAP.Organization);'|
				|'AdditionalParameters = New Structure("Overall",Enums.IndicatorTotalsTypes.Sum);'|
				|'tIndicatorsValues = GetIndicatorsValue(FilterParameterStructure,,AdditionalParameters);'|
				|''|
				|' // Getting sum of factor values'|
				|' If tIndicatorsValues.Count() Then'|
				|'  Result = tIndicatorsValues.Get(0).Value;'|
				|' Else'|
				|'  Result = 0; '|
				|' EndIf; '|
			And I click the button named 'FormWriteAndClose'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			Then "Report wizard" window is opened
			And I click the button named 'WriteAndCollapse'

	* Adding procedures to the processing rule
		* Before calculation procedure
			When "Report wizard" window is opened
			And I click Open button of the field named 'ProcessingRule'
			When I open calculation rule for report type "VA - Cumulative total (recipient)"
			And I click the button named 'FormProcedureOfCalculation'
			When "VA - Cumulative total (recipient), VA - Cumulative total (recipient): Procedure before calculation" window is opened
			And I save "FromSourceBeforeCalc_Count" value to 'CodeOfIndicator2' variable
			And I input text in the field named 'TextDocumentFieldProcedure'
				|'// Getting references to the needed indicators'|
				|'IndicatorSource = Catalogs.ReportsIndicators.FindByCode("$CodeIndicator1$",,,Catalogs.ReportsKinds.FindByCode("$CodeReport$"));'|
				|'IndicatorDestination = Catalogs.ReportsIndicators.FindByCode("$CodeIndicator2$",,,ObjectOfARAP.ReportKind);'|
				|''|
				|'// Do for report periods'|
				|'For CntShared = 0 To ObjectOfARAP.ArrayOfPeriods.Count()-1 Do'|
				|''|
				|' // Getting value of factors of all previous and current periods'|
				|' tReportPeriods = New Array;'|
				|' For CntTimeIntervals = 0 To CntShared Do'|
				|'  tReportPeriods.Add(ObjectOfARAP.ArrayOfPeriods.Get(CntTimeIntervals));'|
				|' EndDo;'|
				|' '|
				|' DimensionsToDrillDown = New Structure("Dimension2");'|
				|''|
				|' FilterParameterStructure = New Structure("ReportIndicator,Currency,ReportPeriod,Scenario,Organization",'|
				|'  IndicatorSource,ObjectOfARAP.MainCurrency,tReportPeriods,ObjectOfARAP.Scenario,ObjectOfARAP.Organization);'|
				|''|
				|' tIndicatorsValues = GetIndicatorsValue(FilterParameterStructure,DimensionsToDrillDown);'|
				|' tIndicatorsValues.GroupBy("Dimension2","Value");'|
				|' '|
				|' For Each RowIndicatorValues In tIndicatorsValues Do'|
				|'  SetIndicatorValue('|
				|'   IndicatorDestination,  '|
				|'   RowIndicatorValues.Value,   '|
				|'   ObjectOfARAP.ArrayOfPeriods.Get(CntShared),,'|
				|'   RowIndicatorValues.Dimension2);'|
				|' EndDo;'|
				|'  '|
				|'EndDo;'|
			And I click the button named 'FormWriteAndClose'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
		* After calculation procedure
			When I open calculation rule for report type "VA - Cumulative total (recipient)"
			And I click the button named 'FormProcedureAfterCalculation'
			When "VA - Cumulative total (recipient), VA - Cumulative total (recipient): Procedure after calculation" window is opened
			And I save "FromSourceAfterCalcu_Count" value to 'CodeOfIndicator2' variable
			And I input text in the field named 'TextDocumentFieldProcedure'
				|'// Getting references to the needed indicators'|
				|'IndicatorSource = Catalogs.ReportsIndicators.FindByCode("$CodeIndicator1$",,,Catalogs.ReportsKinds.FindByCode("$CodeReport$"));'|
				|'IndicatorDestination = Catalogs.ReportsIndicators.FindByCode("$CodeIndicator2$",,,ObjectOfARAP.ReportKind);'|
				|''|
				|'// Do for report periods'|
				|'For CntShared = 0 To ObjectOfARAP.ArrayOfPeriods.Count()-1 Do'|
				|''|
				|' // Getting value of factors of all previous and current periods'|
				|' tReportPeriods = New Array;'|
				|' For CntTimeIntervals = 0 To CntShared Do'|
				|'  tReportPeriods.Add(ObjectOfARAP.ArrayOfPeriods.Get(CntTimeIntervals));'|
				|' EndDo;'|
				|''|
				|' FilterParameterStructure = New Structure("ReportIndicator,Currency,ReportPeriod,Scenario,Organization",'|
				|'  IndicatorSource,ObjectOfARAP.MainCurrency,tReportPeriods,ObjectOfARAP.Scenario,ObjectOfARAP.Organization);'|
				|'  '|
				|' AdditionalParameters = New Structure("Overall",Enums.IndicatorTotalsTypes.Sum); '|
				|''|
				|' tIndicatorsValues = GetIndicatorsValue(FilterParameterStructure,,AdditionalParameters);'|
				|' '|
				|' // Getting sum of factor values'|
				|' If tIndicatorsValues.Count() Then'|
				|'  Value = tIndicatorsValues.Get(0).Value;'|
				|' Else'|
				|'  Value = 0; '|
				|' EndIf;'|
				|''|
				|' // Setting factor value'|
				|' SetIndicatorValue('|
				|'  IndicatorDestination,  '|
				|'  Value,   '|
				|'  ObjectOfARAP.ArrayOfPeriods.Get(CntShared));'|
				|'  '|
				|'EndDo;'|
			And I click the button named 'FormWriteAndClose'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			Then I open calculation rule for report type "VA - Cumulative total (recipient)"
			And I save form header as "WindowTitle" variable
			And I click the button named 'FormWriteAndClose'
			And I wait '$WindowTitle$' window closing in 20 seconds
			When "Report wizard" window is opened
			And I close "Report wizard" window
	
	And I create default template for report type "VA - Cumulative total (recipient)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Cumulative total (recipient)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R10C1' for report type "VA - Cumulative total (recipient)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R12C1' for report type "VA - Cumulative total (recipient)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R15C1' for report type "VA - Cumulative total (recipient)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R17C1' for report type "VA - Cumulative total (recipient)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R19C1' for report type "VA - Cumulative total (recipient)"

Scenario: 08.05 Creating a report instance - "VA - Cumulative total (recipient)"

	And I create report instance for report type "VA - Cumulative total (recipient)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions "3Software sale" '' '' '' '' ''

	* Calculating and verifying the document
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\08\VA_CumulativeTotal.mxl"

	* Calculate the document again, make sure nothing has changed
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'
		Then I open report instance for report type "VA - Cumulative total (recipient)" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions "3Software sale" '' '' '' '' ''
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\08\VA_CumulativeTotal.mxl"

	* Viewing movements
		When '$WindowTitle$ *' window is opened
		And I click the button named 'FormOpenDocumentRegisterRecordsFlatTab'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Flat table of indicator values" window is opened
		And I wait for filling of 'R2C1' cell in 'ReportSpreadsheetDocument' spreadsheet document for 30 seconds
		When I set 'R1C1:R452C20' template area reading parameters
		Given 'ReportSpreadsheetDocument' spreadsheet document is equal to "3_Budgeting\Layouts\08\VA_CumulativeTotal_Movements.mxl" by template

	* Closing the report and the document
		When "Flat table of indicator values" window is opened
		And I close "Flat table of indicator values" window
		Then '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds
