#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 09. Currency indicators

	As Administrator I want to
	Check that report types with currency indicators are calculated and saved

Background:
	
	And I close all client application windows

Scenario: 09.00 Determining the application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 09.01 Creating a report group "VA - Currency indicators (group)"

	And I create report type group with name "VA - Currency indicators (group)" and parent "VA - Report group"

Scenario: 09.02 Creating a report type "VA - Currency indicators (source)"

	And I create report type with name "VA - Currency indicators (source)" and parent "VA - Currency indicators (group)"
	
	And I open report type with name "VA - Currency indicators (source)"
	And I set checkbox named 'ProjectSeparation'
	And I click the button named 'RecordButtonForm'

	And I click the button named 'EditTree'
	When "Report wizard" window is opened

	And I add rows in report wizard
		| 'Description'      |
		| "Revenue"           |
		| "Revenue in currency"  |
		| "Revenue by currency" |
		| "Effective on"        |
		| "Rate [EUR]"        |
		| "Rate [USD]"        |
		
	And I add column with name "Value" in report wizard

	And I change indicator property 'ValueType' to "Date" in cell 'R5C2' in report wizard
	And I change indicator property 'NonFinancial' to "True" in cell 'R6C2' in report wizard
	And I change indicator property 'NonFinancial' to "True" in cell 'R7C2' in report wizard
	
	And I add dimension with code "VA0Counter" in cell 'R2C2' in report wizard
	When "Report wizard" window is opened
	And I click the button named 'CopyDimension'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
	And I click the button named 'InsertDimension'

	And I change dimension currency in cell 'R2C8' in report wizard
	And I change dimension currency in cell 'R3C8' in report wizard
	And I change dimension currency in cell 'R4C8' in report wizard

	And I check indicator property 'ShouldRecalculateForeignCurrencyAmount' is "False" in cell 'R2C2' in report wizard
	And I change indicator properties 'ShouldRecalculateForeignCurrencyAmount' to "True" in cell 'R2C2:R4C2' in report wizard
	And I check indicator property 'ShouldRecalculateForeignCurrencyAmount' is "True" in cell 'R2C2' in report wizard

	And I change dimension currency in cell 'R2C8' in report wizard
	And I check indicator property 'ShouldRecalculateForeignCurrencyAmount' is "False" in cell 'R2C2' in report wizard

Scenario: 09.03 Creating a multi-period template for the report type "VA - Currency indicators (source)"

	And I create default template for report type "VA - Currency indicators (source)"

	* Opening a template
		And I find report type with name "VA - Currency indicators (source)" in list
		Then "Report types and templates" window is opened
		And I go to line in 'List' table:
			| "Description"                        |
			| "VA - Currency indicators (source)" |
		And I select current line in 'List' table
		And I save form header as 'WindowTitle' variable
	
	* Adding a column with the currency value
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'C4' cell
		And I click the button named 'AddAreaToColumnInGroupingRight'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C4:R16C4' cell
		And I click the button named 'CopyToClipboard'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C5:R16C5' cell
		And I click the button named 'PasteFromClipboard'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C4:R5C5' cell
		And I click the button named 'Union'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C5' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text 'Amount (currency)'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C5:R10C5' cell
		And I click the button named 'ClearUpContent'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C5' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Indicator value filter settings" window is opened
		And I change checkbox named 'AmountInAddlCurrency'
		And I click the button named 'FormApply'
		Then '$WindowTitle$ *' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C5' cell
		And I click the button named 'ClearUpContent'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R13C5' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Indicator value filter settings" window is opened
		And I change checkbox named 'AmountInAddlCurrency'
		And I click the button named 'FormApply'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R14C5:R16C5' cell
		And I click the button named 'ClearUpContent'
	
	* Adding a column with the currency value for the total
		When '$WindowTitle$ *' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'C6' cell
		And I click the button named 'AddAreaToColumnInGroupingRight'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C6:R16C6' cell
		And I click the button named 'CopyToClipboard'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C7:R16C7' cell
		And I click the button named 'PasteFromClipboard'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C7:R10C7' cell
		And I click the button named 'ClearUpContent'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C7' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Indicator value filter settings" window is opened
		And I change checkbox named 'AmountInAddlCurrency'
		And I click the button named 'FormApply'
		Then '$WindowTitle$ *' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C7' cell
		And I click the button named 'ClearUpContent'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R13C7' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Indicator value filter settings" window is opened
		And I change checkbox named 'AmountInAddlCurrency'
		And I click the button named 'FormApply'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R14C7:R16C7' cell
		And I click the button named 'ClearUpContent'
	
	* Saving the layout
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'FormButtonWriteAndClose'

Scenario: 09.04 Creating a report type "VA - Currency indicators (recipient)"

	And I create report type with name "VA - Currency indicators (recipient)" and parent 'VA - Currency indicators (group)'

	And I open report type with name "VA - Currency indicators (recipient)"
	And I set checkbox named 'ProjectSeparation'
	And I click the button named 'RecordButtonForm'

	And I click the button named 'EditTree'
	When "Report wizard" window is opened

	* Adding rows
		And I add rows in report wizard
			| 'Description'                                                           |
			| "Revenue by currency"                                                      |
			| "Revenue by currency [Average rate for period]"                             |
			| "Revenue by currency [Average rate for IFRS period]"                        |
			| "Revenue by currency [Average rate for period CB]"                          |
			| "Revenue by currency [Exchange rate at the beginning of the period]"                             |
			| "Revenue by currency [Exchange rate at the end of the period]"                              |
			| "Revenue by currency [Average rate for the previous period]"                  |
			| "Revenue by currency [Exchange rate at the end of the previous period]"                  |
			| "Revenue by currency [Average rate for the previous period CB]"               |
			| "Effective on"                                                             |
			| "Revenue by currency [Exchange rate as of the date specified in the indicator]"                |
			| "Revenue by currency [Exchange rate as of the date specified in the indicator another report]" |
			| "Rate [EUR]"                                                             |
			| "Rate [USD]"                                                             |
			| "Revenue by currency [Rate specified in the indicator]"                        |
			| "Revenue by currency [Rate specified in the indicator another report]"         |
		
	* Adding columns
		And I add column with name "Value" in report wizard

	* Configuring indicators
		* Revenue by currency [Average rate for period]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			Then the form attribute named 'CurrExchangeType' became equal to "Average rate for period"
			And I click Clear button of the field named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			Тогда в логе сообщений TestClient есть строки:
				|"\"Exchange rate kind\" is a required field."|
			And I select "Average rate for period" exact value from the drop-down list named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Average rate for period]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Average rate for period" exact value from the drop-down list named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Average rate for IFRS period]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Average rate for IFRS period" exact value from the drop-down list named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Average rate for period CB]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Average rate for period CB" exact value from the drop-down list named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Exchange rate at the beginning of the period]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Exchange rate at the beginning of the period" exact value from the drop-down list named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Exchange rate at the end of the period]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Exchange rate at the end of the period" exact value from the drop-down list named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Average rate for the previous period]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R8C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Average rate for the previous period" exact value from the drop-down list named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Exchange rate at the end of the previous period]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Exchange rate at the end of the previous period" exact value from the drop-down list named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Average rate for the previous period CB]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Average rate for the previous period CB" exact value from the drop-down list named 'CurrExchangeType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Rate date
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I select "Date" exact value from the drop-down list named 'ValueType'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Rate as of the date specified in the indicator]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Exchange rate as of the date specified in the indicator" exact value from the drop-down list named 'CurrExchangeType'
			And I click Choice button of the field named 'LinkedIndicator'
			And I select indicator with code "EffectiveOn_Value"
			Then "* (Report indicators) *" window is opened
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Rate as of the date specified in the indicator of another report]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R13C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Exchange rate as of the date specified in the indicator" exact value from the drop-down list named 'CurrExchangeType'
			And I click Choice button of the field named 'LinkedIndicator'
			And I select indicator with code "EffectiveOn_Value" of report type "VA - Currency indicators (source)"
			Then "* (Report indicators) *" window is opened
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Rate (EUR)
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R14C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I select "Total by dimensions is not calculated" exact value from the drop-down list named 'TotalKind'
			And I change checkbox named 'NonFinancial'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Rate (USD)
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R15C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I select "Total by dimensions is not calculated" exact value from the drop-down list named 'TotalKind'
			And I change checkbox named 'NonFinancial'
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Rate specified in the indicator]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R16C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Rate specified in the indicator" exact value from the drop-down list named 'CurrExchangeType'
			* EUR
				And in the table 'IndicatorsForExchangeRates' I click the button named 'IndicatorsForExchangeRatesAdd'
				And I select "EUR" exact value from the drop-down list named 'IndicatorsForExchangeRatesCurrency' in 'IndicatorsForExchangeRates' table
				And I move to the next attribute
				And I click choice button of the attribute named 'IndicatorsForExchangeRatesRateIndicator' in 'IndicatorsForExchangeRates' table
				And I select indicator with code "RateEUR_Value" of report type "VA - Currency indicators (recipient)"
				Then "* (Report indicators) *" window is opened
				And I input '1' text in the field named 'IndicatorsForExchangeRatesRepetition' of 'IndicatorsForExchangeRates' table
				And I finish line editing in 'IndicatorsForExchangeRates' table
			* USD
				And in the table 'IndicatorsForExchangeRates' I click the button named 'IndicatorsForExchangeRatesAdd'
				And I select "USD" exact value from the drop-down list named 'IndicatorsForExchangeRatesCurrency' in 'IndicatorsForExchangeRates' table
				And I move to the next attribute
				And I click choice button of the attribute named 'IndicatorsForExchangeRatesRateIndicator' in 'IndicatorsForExchangeRates' table
				And I select indicator with code "RateUSD_Value" of report type "VA - Currency indicators (recipient)"
				Then "* (Report indicators) *" window is opened
				And I input '1' text in the field named 'IndicatorsForExchangeRatesRepetition' of 'IndicatorsForExchangeRates' table
				And I finish line editing in 'IndicatorsForExchangeRates' table
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds
		* Revenue by currency [Rate specified in the indicator of another report]
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R17C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "* (Report indicators)" window is opened
			And I move to the tab named 'CurrenciesConversion'
			And I select "Rate specified in the indicator" exact value from the drop-down list named 'CurrExchangeType'
			* EUR
				And in the table 'IndicatorsForExchangeRates' I click the button named 'IndicatorsForExchangeRatesAdd'
				And I select "EUR" exact value from the drop-down list named 'IndicatorsForExchangeRatesCurrency' in 'IndicatorsForExchangeRates' table
				And I move to the next attribute
				And I click choice button of the attribute named 'IndicatorsForExchangeRatesRateIndicator' in 'IndicatorsForExchangeRates' table
				And I select indicator with code "RateEUR_Value" of report type "VA - Currency indicators (source)"
				Then "* (Report indicators) *" window is opened
				And I input '1' text in the field named 'IndicatorsForExchangeRatesRepetition' of 'IndicatorsForExchangeRates' table
				And I finish line editing in 'IndicatorsForExchangeRates' table
			* USD
				And in the table 'IndicatorsForExchangeRates' I click the button named 'IndicatorsForExchangeRatesAdd'
				And I select "USD" exact value from the drop-down list named 'IndicatorsForExchangeRatesCurrency' in 'IndicatorsForExchangeRates' table
				And I move to the next attribute
				And I click choice button of the attribute named 'IndicatorsForExchangeRatesRateIndicator' in 'IndicatorsForExchangeRates' table
				And I select indicator with code "RateUSD_Value" of report type "VA - Currency indicators (source)"
				Then "* (Report indicators) *" window is opened
				And I input '1' text in the field named 'IndicatorsForExchangeRatesRepetition' of 'IndicatorsForExchangeRates' table
				And I finish line editing in 'IndicatorsForExchangeRates' table
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Report indicators) *" window closing in 20 seconds

	* Setting report dimensions
		And I add dimension with code "VA0Counter" in cell 'R2C2' in report wizard
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R8C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R13C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R16C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R17C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I change indicator properties 'ShouldRecalculateForeignCurrencyAmount' to 'True' in cell 'R2C2:R17C2' in report wizard

	* Entering data sources
		* Revenue by currency
			And I set link to indicator with code "RevenueInCurrency_Value" of report type "VA - Currency indicators (source)" for cell 'R2C2' in report wizard
		* Revenue by currency [Average rate for period]
			And I set link to indicator with code "RevenueByCurrency_Value" of report type "VA - Currency indicators (source)" for cell 'R3C2' in report wizard
		* Revenue by currency [Average rate for IFRS period]
			Then "Report wizard" window is opened
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Average rate for period CB]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Exchange rate at the beginning of the period]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Exchange rate at the end of the period]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Average rate for the previous period]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R8C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Exchange rate at the end of the previous period]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Average rate for the previous period CB]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Rate as of the date specified in the indicator]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Rate as of the date specified in the indicator of another report]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R13C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Rate specified in the indicator]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R16C2' cell
			And I click the button named 'InsertFormula'
		* Revenue by currency [Rate specified in the indicator of another report]
			And I click the button named 'CopyFormula'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R17C2' cell
			And I click the button named 'InsertFormula'
		* Rate date
			And I set link to indicator with code "EffectiveOn_Value" of report type "VA - Currency indicators (source)" for cell 'R11C2' in report wizard
		* Rate (EUR)
			And I set link to indicator with code "RateEUR_Value" of report type "VA - Currency indicators (source)" for cell 'R14C2' in report wizard
		* Rate (USD)
			And I set link to indicator with code "RateUSD_Value" of report type "VA - Currency indicators (source)" for cell 'R15C2' in report wizard

	* Enabling indicator editing
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R3C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R4C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R5C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R6C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R7C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R8C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R9C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R10C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R11C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R12C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R13C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R14C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R15C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R16C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R17C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I set checkbox named 'FormulaEditorEditingImpossible'
		And I click the button named 'WriteAndCollapse'

Scenario: 09.05 Creating a multi-period template for report type "VA - Currency indicators (recipient)"

	And I create default template for report type "VA - Currency indicators (recipient)"

	* Opening a template
		And I find report type with name "VA - Currency indicators (recipient)" in list
		Then "Report types and templates" window is opened
		And I go to line in 'List' table:
			| "Description"                        |
			| "VA - Currency indicators (recipient)" |
		And I select current line in 'List' table
		And I save form header as 'WindowTitle' variable

	* Adding a column with the currency value
		* Report period
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R1C4' cell
			And I click the button named 'AddAreaToColumnInGroupingRight'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C4:R36C4' cell
			And I click the button named 'CopyToClipboard'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C5:R36C5' cell
			And I click the button named 'PasteFromClipboard'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C4:R5C5' cell
			And I click the button named 'Union'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C5:R8C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R13C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R14C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R15C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R16C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R17C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R18C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R19C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R20C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R21C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R22C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R23C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R24C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R25C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R26C5:R27C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R28C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R29C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R30C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R31C5:R33C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R34C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R35C5' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R36C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
		* Total
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R1C6' cell
			And I click the button named 'AddAreaToColumnInGroupingRight'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C6:R36C6' cell
			And I click the button named 'CopyToClipboard'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C7:R36C7' cell
			And I click the button named 'PasteFromClipboard'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C6:R5C7' cell
			And I click the button named 'Union'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C7:R8C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R13C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R14C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R15C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R16C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R17C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R18C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R19C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R20C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R21C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R22C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R23C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R24C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R25C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R26C7:R27C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R28C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R29C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R30C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R31C7:R33C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R34C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
			Then '$WindowTitle$ *' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R35C7' cell
			And I click the button named 'ClearUpContent'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R36C7' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Indicator value filter settings" window is opened
			And I change checkbox named 'AmountInAddlCurrency'
			And I click the button named 'FormApply'
				
	* Saving a template
		When '$WindowTitle$ *' window is opened
		And I click the button named 'FormButtonWriteAndClose'

Scenario: 09.06 Configuring rights for user "Budgeting1"

	And I add right "Read, write" for report type "VA - Currency indicators (source)" user "Budgeting1" for all companies
	And I add right "Read, write" for report type "VA - Currency indicators (recipient)" user "Budgeting1" for all companies
	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 09.07 Creating a report instance - "VA - Currency indicators (source)"

	And I create report instance for report type "VA - Currency indicators (source)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Filling values for non-currency indicators
		When '$WindowTitle$' window is opened
		And I add values with indicator expansion in cell 'R6C2'
				| "VA0Counter"      | 'Value1'     |
				| "LLC \"Ganymede\"" | '100,000.00000' |
				| "LLC \"Io\""      | '200,000.00000' |

	* Filling values with dimensions, checking conversion to currency
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C1' cell
		And I click the button named 'DisplayADrilldown'
		Then "Drill down indicators: *" window is opened
		And I fill 'IndicatorsDrilldown' table with data
			| "Counterparties"     | "Currencies" | 'Period_1_Value1' | 'Period_1_ValueCurrency1' |
			| "LLC \"Ganymede\"" | 'RUB'    | ''                   | '100,000.00000'            |
			| "LLC \"Ganymede\"" | 'USD'    | '90,000.00000'       | ''                         |
			| "LLC \"Ganymede\"" | 'EUR'    | '110,000.00000'      | ''                         |
			| "LLC \"Io\""      | 'RUB'    | ''                   | '200,000.00000'            |
			| "LLC \"Io\""      | 'USD'    | '180,000.00000'      |                            |
			| "LLC \"Io\""      | 'EUR'    | '220,000.00000'      |                            |
		Then 'IndicatorsDrilldown' table became equal
			| "Counterparties"     | "Currencies" | 'Period_1_Value1' | 'Period_1_ValueCurrency1' | 'Period_2_Value1' | 'Period_2_ValueCurrency1' | 'Period_3_Value1' | 'Period_3_ValueCurrency1' |
			| "LLC \"Ganymede\"" | 'RUB'    | '100,000.00000'      | '100,000.00000'            | ''                   | ''                         | ''                   | ''                         |
			| "LLC \"Ganymede\"" | 'USD'    | '90,000.00000'       | '1,212.60462'              | ''                   | ''                         | ''                   | ''                         |
			| "LLC \"Ganymede\"" | 'EUR'    | '110,000.00000'      | '1,215.50856'              | ''                   | ''                         | ''                   | ''                         |
			| "LLC \"Io\""      | 'RUB'    | '200,000.00000'      | '200,000.00000'            | ''                   | ''                         | ''                   | ''                         |
			| "LLC \"Io\""      | 'USD'    | '180,000.00000'      | '2,425.20924'              | ''                   | ''                         | ''                   | ''                         |
			| "LLC \"Io\""      | 'EUR'    | '220,000.00000'      | '2,431.01713'              | ''                   | ''                         | ''                   | ''                         |
		And I click the button named 'FormOKButton'
		And I wait "Drill down indicators: *" window closing in 20 seconds

	* Filling values, checking conversion to currency
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R18C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Drill down indicators: *" window is opened
		And I fill 'IndicatorsDrilldown' table with data
			| 'DimensionCurrency' | 'Value1' | 'ValueCurrency1' |
			| 'RUB'             | ''          | '300,000.00000'   |
			| 'USD'             | ''          | '3500'            |
			| 'EUR'             | ''          | '3600'            |
		And I input '4' text in the field named 'Accuracy'
		And I select "thousands" exact value from the drop-down list named 'Divisor'
		Then 'IndicatorsDrilldown' table became equal
			| "Currencies" | 'Value1' | 'ValueCurrency1' |
			| 'RUB'    | '300.0000'  | '300.0000'        |
			| 'USD'    | '259.7714'  | '3.5000'          |
			| 'EUR'    | '325.7896'  | '3.6000'          |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I fill 'IndicatorsDrilldown' table with data
			| 'DimensionCurrency' | 'Value1'     |
			| 'RUB'             | '300,000.00000' |
			| 'USD'             | '270,000.00000' |
			| 'EUR'             | '330,000.00000' |
		Then 'IndicatorsDrilldown' table became equal
			| "Currencies" | 'Value1' | 'ValueCurrency1' |
			| 'RUB'    | '300.0000'  | '300.0000'        |
			| 'USD'    | '270.0000'  | '3.6378'          |
			| 'EUR'    | '330.0000'  | '3.6465'          |
		And I click the button named 'FormOKButton'
		And I wait "Drill down indicators: *" window closing in 20 seconds

	* Copying indicator values
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2:R21C2' cell
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'

	* Filling values for rate calculation
		When '$WindowTitle$' window is opened
		And I enter value '3/1/2024' in cell 'R22C2'
		And I enter value '2/1/2024' in cell 'R22C4'
		And I enter value '1/1/2024' in cell 'R22C6'
		And I enter value '90.00000' in cell 'R23C2'
		And I enter value '91.00000' in cell 'R23C4'
		And I enter value '92.00000' in cell 'R23C6'
		And I enter value '73.00000' in cell 'R24C2'
		And I enter value '74.00000' in cell 'R24C4'
		And I enter value '75.00000' in cell 'R24C6'

	* Comparing the final document
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Currency indicators (source)" | ''               | ''            | ''                | ''            | ''             | ''            | ''          | ''         |
			| ''                                    | ''               | ''            | ''                | ''            | ''             | ''            | ''          | ''         |
			| ''                                    | "January 2024" | ''            | "February 2024" | ''            | "March 2024" | ''            | "TOTAL"     | "TOTAL"    |
			| ''                                    | "Value"       | 'Amount (currency)' | "Value"        | 'Amount (currency)' | "Value"     | 'Amount (currency)' | "Value"  | "Value" |
			| "Revenue"                             | '300,000'        | ''            | '300,000'         | ''            | '300,000'      | ''            | '900,000'   | ''         |
			| "LLC \"Ganymede\" "                    | '100,000'        | ''            | '100,000'         | ''            | '100,000'      | ''            | '300,000'   | ''         |
			| "LLC \"Io\" "                         | '200,000'        | ''            | '200,000'         | ''            | '200,000'      | ''            | '600,000'   | ''         |
			| "Revenue in currency"                    | '900,000'        | ''            | '900,000'         | ''            | '900,000'      | ''            | '2,700,000' | ''         |
			| "LLC \"Ganymede\" "                    | '300,000'        | ''            | '300,000'         | ''            | '300,000'      | ''            | '900,000'   | ''         |
			| 'EUR '                                | '110,000'        | '1,216'       | '110,000'         | '1,223'       | '110,000'      | '1,240'       | '330,000'   | '3,679'    |
			| 'RUB '                                | '100,000'        | '100,000'     | '100,000'         | '100,000'     | '100,000'      | '100,000'     | '300,000'   | '300,000'  |
			| 'USD '                                | '90,000'         | '1,213'       | '90,000'          | '1,210'       | '90,000'       | '1,210'       | '270,000'   | '3,632'    |
			| "LLC \"Io\" "                         | '600,000'        | ''            | '600,000'         | ''            | '600,000'      | ''            | '1,800,000' | ''         |
			| 'EUR '                                | '220,000'        | '2,431'       | '220,000'         | '2,446'       | '220,000'      | '2,481'       | '660,000'   | '7,358'    |
			| 'RUB '                                | '200,000'        | '200,000'     | '200,000'         | '200,000'     | '200,000'      | '200,000'     | '600,000'   | '600,000'  |
			| 'USD '                                | '180,000'        | '2,425'       | '180,000'         | '2,420'       | '180,000'      | '2,419'       | '540,000'   | '7,265'    |
			| "Revenue by currency"                   | '900,000'        | ''            | '900,000'         | ''            | '900,000'      | ''            | '2,700,000' | ''         |
			| 'EUR '                                | '330,000'        | '3,647'       | '330,000'         | '3,669'       | '330,000'      | '3,721'       | '990,000'   | '11,037'   |
			| 'RUB '                                | '300,000'        | '300,000'     | '300,000'         | '300,000'     | '300,000'      | '300,000'     | '900,000'   | '900,000'  |
			| 'USD '                                | '270,000'        | '3,638'       | '270,000'         | '3,630'       | '270,000'      | '3,629'       | '810,000'   | '10,897'   |
			| "Effective on"                          | '3/1/2024'     | ''            | '2/1/2024'      | ''            | '1/1/2024'   | ''            | ''          | ''         |
			| "Rate [EUR]"                          | '90'             | ''            | '91'              | ''            | '92'           | ''            | '273'       | ''         |
			| "Rate [USD]"                          | '73'             | ''            | '74'              | ''            | '75'           | ''            | '222'       | ''         |

	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'

	* Comparing movements
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormOpenDocumentRegisterRecordsFlatTab'
		Then "Flat table of indicator values" window is opened
		And I wait for filling of 'R2C1' cell in 'ReportSpreadsheetDocument' spreadsheet document for 30 seconds
		Given 'ReportSpreadsheetDocument' spreadsheet document is equal to "3_Budgeting\Layouts\09\VA_CurrencyIndicators_Source_Movements.mxl" by template

Scenario: 09.08 Manual filling of report instance - "VA - Currency indicators (recipient)"

	And I create report instance for report type "VA - Currency indicators (recipient)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Checking values in the indicator editing form
		* Revenue by currency [Average rate for period]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,638'           |
				| 'EUR'    | '330,000'   | '3,647'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Revenue by currency [Average rate for IFRS period]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,597'           |
				| 'EUR'    | '330,000'   | '3,605'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Revenue by currency [Average rate for period CB]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R15C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,641'           |
				| 'EUR'    | '330,000'   | '3,648'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Revenue by currency [Exchange rate at the beginning of the period]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R19C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,655'           |
				| 'EUR'    | '330,000'   | '3,635'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Revenue by currency [Exchange rate at the end of the period]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R23C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,541'           |
				| 'EUR'    | '330,000'   | '3,575'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Revenue by currency [Average rate for the previous period]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R27C4' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,638'           |
				| 'EUR'    | '330,000'   | '3,647'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Revenue by currency [Exchange rate at the end of the previous period]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R31C4' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,541'           |
				| 'EUR'    | '330,000'   | '3,575'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Revenue by currency [Average rate for the previous period CB]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R35C4' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,641'           |
				| 'EUR'    | '330,000'   | '3,648'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Rate date
			And I enter value '3/1/2024' in cell 'R39C2'
		* Revenue by currency [Rate as of the date specified in the indicator]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R40C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,627'           |
				| 'EUR'    | '330,000'   | '3,651'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Revenue by currency [Rate as of the date specified in the indicator of another report]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R44C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,627'           |
				| 'EUR'    | '330,000'   | '3,651'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Rate date
			And I enter value '90' in cell 'R48C2'
		* Rate date
			And I enter value '73' in cell 'R49C2'
		* Revenue by currency [Rate specified in the indicator]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R50C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                 |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,699'           |
				| 'EUR'    | '330,000'   | '3,667'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds
		* Revenue by currency [Rate specified in the indicator of another report]
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R54C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators: *" window is opened
			And I fill 'IndicatorsDrilldown' table with data
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | ''                |
				| 'USD'    | '270,000'   | ''                |
				| 'EUR'    | '330,000'   | ''                |
			Then 'IndicatorsDrilldown' table became equal
				| "Currencies" | 'Value1' | 'ValueCurrency1' |
				| 'RUB'    | '300,000'   | '300,000'         |
				| 'USD'    | '270,000'   | '3,699'           |
				| 'EUR'    | '330,000'   | '3,667'           |
			And I click the button named 'FormOKButton'
			And I wait "Drill down indicators: *" window closing in 20 seconds

	* Checking the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Currency indicators (recipient)"                                    | ''               | ''         | ''                | ''         | ''             | ''         | ''         | ''         |
			| ''                                                                       | ''               | ''         | ''                | ''         | ''             | ''         | ''         | ''         |
			| ''                                                                       | "January 2024" | ''         | "February 2024" | ''         | "March 2024" | ''         | "TOTAL"    | ''         |
			| ''                                                                       | "Value"       | "Value" | "Value"        | "Value" | "Value"     | "Value" | "Value" | "Value" |
			| "Revenue by currency"                                                      | '0'              | ''         | '0'               | ''         | '0'            | ''         | '0'        | ''         |
			| "Revenue by currency [Average rate for period]"                             | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,647'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,647'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,638'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,638'    |
			| "Revenue by currency [Average rate for IFRS period]"                        | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,605'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,605'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,597'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,597'    |
			| "Revenue by currency [Average rate for period CB]"                          | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,648'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,648'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,641'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,641'    |
			| "Revenue by currency [Exchange rate at the beginning of the period]"                             | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,635'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,635'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,655'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,655'    |
			| "Revenue by currency [Exchange rate at the end of the period]"                              | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,575'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,575'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,541'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,541'    |
			| "Revenue by currency [Average rate for the previous period]"                  | '0'              | ''         | '900,000'         | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '0'              | '0'        | '330,000'         | '3,647'    | '0'            | '0'        | '330,000'  | '3,647'    |
			| 'RUB '                                                                   | '0'              | '0'        | '300,000'         | '300,000'  | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '0'              | '0'        | '270,000'         | '3,638'    | '0'            | '0'        | '270,000'  | '3,638'    |
			| "Revenue by currency [Exchange rate at the end of the previous period]"                  | '0'              | ''         | '900,000'         | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '0'              | '0'        | '330,000'         | '3,575'    | '0'            | '0'        | '330,000'  | '3,575'    |
			| 'RUB '                                                                   | '0'              | '0'        | '300,000'         | '300,000'  | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '0'              | '0'        | '270,000'         | '3,541'    | '0'            | '0'        | '270,000'  | '3,541'    |
			| "Revenue by currency [Average rate for the previous period CB]"               | '0'              | ''         | '900,000'         | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '0'              | '0'        | '330,000'         | '3,648'    | '0'            | '0'        | '330,000'  | '3,648'    |
			| 'RUB '                                                                   | '0'              | '0'        | '300,000'         | '300,000'  | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '0'              | '0'        | '270,000'         | '3,641'    | '0'            | '0'        | '270,000'  | '3,641'    |
			| "Effective on"                                                             | '3/1/2024'     | ''         | ''                | ''         | ''             | ''         | ''         | ''         |
			| "Revenue by currency [Exchange rate as of the date specified in the indicator]"                | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,651'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,651'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,627'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,627'    |
			| "Revenue by currency [Exchange rate as of the date specified in the indicator another report]" | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,651'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,651'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,627'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,627'    |
			| "Rate [EUR]"                                                             | '90'             | ''         | '0'               | ''         | '0'            | ''         | '0'        | ''         |
			| "Rate [USD]"                                                             | '73'             | ''         | '0'               | ''         | '0'            | ''         | '0'        | ''         |
			| "Revenue by currency [Rate specified in the indicator]"                        | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,667'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,667'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,699'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,699'    |
			| "Revenue by currency [Rate specified in the indicator another report]"         | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,667'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,667'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,699'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,699'    |

	* Saving and closing the document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 09.09 Calculation by report instance rule - "VA - Currency indicators (recipient)"

	And I open first report instance for report type "VA - Currency indicators (recipient)"
	Then I open report instance for report type "VA - Currency indicators (recipient)" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Checking the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Currency indicators (recipient)"                                    | ''               | ''         | ''                | ''         | ''             | ''         | ''         | ''         |
			| ''                                                                       | ''               | ''         | ''                | ''         | ''             | ''         | ''         | ''         |
			| ''                                                                       | "January 2024" | ''         | "February 2024" | ''         | "March 2024" | ''         | "TOTAL"    | ''         |
			| ''                                                                       | "Value"       | "Value" | "Value"        | "Value" | "Value"     | "Value" | "Value" | "Value" |
			| "Revenue by currency"                                                      | '0'              | ''         | '0'               | ''         | '0'            | ''         | '0'        | ''         |
			| "Revenue by currency [Average rate for period]"                             | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,647'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,647'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,638'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,638'    |
			| "Revenue by currency [Average rate for IFRS period]"                        | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,605'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,605'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,597'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,597'    |
			| "Revenue by currency [Average rate for period CB]"                          | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,648'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,648'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,641'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,641'    |
			| "Revenue by currency [Exchange rate at the beginning of the period]"                             | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,635'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,635'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,655'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,655'    |
			| "Revenue by currency [Exchange rate at the end of the period]"                              | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,575'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,575'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,541'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,541'    |
			| "Revenue by currency [Average rate for the previous period]"                  | '0'              | ''         | '900,000'         | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '0'              | '0'        | '330,000'         | '3,647'    | '0'            | '0'        | '330,000'  | '3,647'    |
			| 'RUB '                                                                   | '0'              | '0'        | '300,000'         | '300,000'  | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '0'              | '0'        | '270,000'         | '3,638'    | '0'            | '0'        | '270,000'  | '3,638'    |
			| "Revenue by currency [Exchange rate at the end of the previous period]"                  | '0'              | ''         | '900,000'         | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '0'              | '0'        | '330,000'         | '3,575'    | '0'            | '0'        | '330,000'  | '3,575'    |
			| 'RUB '                                                                   | '0'              | '0'        | '300,000'         | '300,000'  | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '0'              | '0'        | '270,000'         | '3,541'    | '0'            | '0'        | '270,000'  | '3,541'    |
			| "Revenue by currency [Average rate for the previous period CB]"               | '0'              | ''         | '900,000'         | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '0'              | '0'        | '330,000'         | '3,648'    | '0'            | '0'        | '330,000'  | '3,648'    |
			| 'RUB '                                                                   | '0'              | '0'        | '300,000'         | '300,000'  | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '0'              | '0'        | '270,000'         | '3,641'    | '0'            | '0'        | '270,000'  | '3,641'    |
			| "Effective on"                                                             | '3/1/2024'     | ''         | ''                | ''         | ''             | ''         | ''         | ''         |
			| "Revenue by currency [Exchange rate as of the date specified in the indicator]"                | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,651'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,651'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,627'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,627'    |
			| "Revenue by currency [Exchange rate as of the date specified in the indicator another report]" | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,651'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,651'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,627'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,627'    |
			| "Rate [EUR]"                                                             | '90'             | ''         | '0'               | ''         | '0'            | ''         | '0'        | ''         |
			| "Rate [USD]"                                                             | '73'             | ''         | '0'               | ''         | '0'            | ''         | '0'        | ''         |
			| "Revenue by currency [Rate specified in the indicator]"                        | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,667'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,667'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,699'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,699'    |
			| "Revenue by currency [Rate specified in the indicator another report]"         | '900,000'        | ''         | '0'               | ''         | '0'            | ''         | '900,000'  | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,667'    | '0'               | '0'        | '0'            | '0'        | '330,000'  | '3,667'    |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '0'               | '0'        | '0'            | '0'        | '300,000'  | '300,000'  |
			| 'USD '                                                                   | '270,000'        | '3,699'    | '0'               | '0'        | '0'            | '0'        | '270,000'  | '3,699'    |

	* Calculating the document by rule and verifying the result
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Currency indicators (recipient)"                                    | ''               | ''         | ''                | ''         | ''             | ''         | ''          | ''         |
			| ''                                                                       | ''               | ''         | ''                | ''         | ''             | ''         | ''          | ''         |
			| ''                                                                       | "January 2024" | ''         | "February 2024" | ''         | "March 2024" | ''         | "TOTAL"     | ''         |
			| ''                                                                       | "Value"       | "Value" | "Value"        | "Value" | "Value"     | "Value" | "Value"  | "Value" |
			| "Revenue by currency"                                                      | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| "LLC \"Ganymede\" "                                                       | '300,000'        | ''         | '300,000'         | ''         | '300,000'      | ''         | '900,000'   | ''         |
			| 'EUR '                                                                   | '110,000'        | '1,216'    | '110,000'         | '1,223'    | '110,000'      | '1,240'    | '330,000'   | '3,679'    |
			| 'RUB '                                                                   | '100,000'        | '100,000'  | '100,000'         | '100,000'  | '100,000'      | '100,000'  | '300,000'   | '300,000'  |
			| 'USD '                                                                   | '90,000'         | '1,213'    | '90,000'          | '1,210'    | '90,000'       | '1,210'    | '270,000'   | '3,632'    |
			| "LLC \"Io\" "                                                            | '600,000'        | ''         | '600,000'         | ''         | '600,000'      | ''         | '1,800,000' | ''         |
			| 'EUR '                                                                   | '220,000'        | '2,431'    | '220,000'         | '2,446'    | '220,000'      | '2,481'    | '660,000'   | '7,358'    |
			| 'RUB '                                                                   | '200,000'        | '200,000'  | '200,000'         | '200,000'  | '200,000'      | '200,000'  | '600,000'   | '600,000'  |
			| 'USD '                                                                   | '180,000'        | '2,425'    | '180,000'         | '2,420'    | '180,000'      | '2,419'    | '540,000'   | '7,265'    |
			| "Revenue by currency [Average rate for period]"                             | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,647'    | '330,000'         | '3,669'    | '330,000'      | '3,721'    | '990,000'   | '11,037'   |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '900,000'   | '900,000'  |
			| 'USD '                                                                   | '270,000'        | '3,638'    | '270,000'         | '3,630'    | '270,000'      | '3,629'    | '810,000'   | '10,897'   |
			| "Revenue by currency [Average rate for IFRS period]"                        | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,605'    | '330,000'         | '3,613'    | '330,000'      | '3,682'    | '990,000'   | '10,900'   |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '900,000'   | '900,000'  |
			| 'USD '                                                                   | '270,000'        | '3,597'    | '270,000'         | '3,584'    | '270,000'      | '3,597'    | '810,000'   | '10,777'   |
			| "Revenue by currency [Average rate for period CB]"                          | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,648'    | '330,000'         | '3,667'    | '330,000'      | '3,719'    | '990,000'   | '11,034'   |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '900,000'   | '900,000'  |
			| 'USD '                                                                   | '270,000'        | '3,641'    | '270,000'         | '3,627'    | '270,000'      | '3,631'    | '810,000'   | '10,899'   |
			| "Revenue by currency [Exchange rate at the beginning of the period]"                             | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,635'    | '330,000'         | '3,575'    | '330,000'      | '3,651'    | '990,000'   | '10,862'   |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '900,000'   | '900,000'  |
			| 'USD '                                                                   | '270,000'        | '3,655'    | '270,000'         | '3,541'    | '270,000'      | '3,627'    | '810,000'   | '10,823'   |
			| "Revenue by currency [Exchange rate at the end of the period]"                              | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,575'    | '330,000'         | '3,651'    | '330,000'      | '3,713'    | '990,000'   | '10,940'   |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '900,000'   | '900,000'  |
			| 'USD '                                                                   | '270,000'        | '3,541'    | '270,000'         | '3,627'    | '270,000'      | '3,567'    | '810,000'   | '10,735'   |
			| "Revenue by currency [Average rate for the previous period]"                  | '0'              | ''         | '900,000'         | ''         | '900,000'      | ''         | '1,800,000' | ''         |
			| 'EUR '                                                                   | '0'              | '0'        | '330,000'         | '3,647'    | '330,000'      | '3,669'    | '660,000'   | '7,316'    |
			| 'RUB '                                                                   | '0'              | '0'        | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '600,000'   | '600,000'  |
			| 'USD '                                                                   | '0'              | '0'        | '270,000'         | '3,638'    | '270,000'      | '3,630'    | '540,000'   | '7,268'    |
			| "Revenue by currency [Exchange rate at the end of the previous period]"                  | '0'              | ''         | '900,000'         | ''         | '900,000'      | ''         | '1,800,000' | ''         |
			| 'EUR '                                                                   | '0'              | '0'        | '330,000'         | '3,575'    | '330,000'      | '3,651'    | '660,000'   | '7,227'    |
			| 'RUB '                                                                   | '0'              | '0'        | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '600,000'   | '600,000'  |
			| 'USD '                                                                   | '0'              | '0'        | '270,000'         | '3,541'    | '270,000'      | '3,627'    | '540,000'   | '7,168'    |
			| "Revenue by currency [Average rate for the previous period CB]"               | '0'              | ''         | '900,000'         | ''         | '900,000'      | ''         | '1,800,000' | ''         |
			| 'EUR '                                                                   | '0'              | '0'        | '330,000'         | '3,648'    | '330,000'      | '3,667'    | '660,000'   | '7,315'    |
			| 'RUB '                                                                   | '0'              | '0'        | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '600,000'   | '600,000'  |
			| 'USD '                                                                   | '0'              | '0'        | '270,000'         | '3,641'    | '270,000'      | '3,627'    | '540,000'   | '7,268'    |
			| "Effective on"                                                             | '3/1/2024'     | ''         | '2/1/2024'      | ''         | '1/1/2024'   | ''         | ''          | ''         |
			| "Revenue by currency [Exchange rate as of the date specified in the indicator]"                | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,651'    | '330,000'         | '3,575'    | '330,000'      | '3,635'    | '990,000'   | '10,862'   |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '900,000'   | '900,000'  |
			| 'USD '                                                                   | '270,000'        | '3,627'    | '270,000'         | '3,541'    | '270,000'      | '3,655'    | '810,000'   | '10,823'   |
			| "Revenue by currency [Exchange rate as of the date specified in the indicator another report]" | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,651'    | '330,000'         | '3,575'    | '330,000'      | '3,635'    | '990,000'   | '10,862'   |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '900,000'   | '900,000'  |
			| 'USD '                                                                   | '270,000'        | '3,627'    | '270,000'         | '3,541'    | '270,000'      | '3,655'    | '810,000'   | '10,823'   |
			| "Rate [EUR]"                                                             | '90'             | ''         | '91'              | ''         | '92'           | ''         | '0'         | ''         |
			| "Rate [USD]"                                                             | '73'             | ''         | '74'              | ''         | '75'           | ''         | '0'         | ''         |
			| "Revenue by currency [Rate specified in the indicator]"                        | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,667'    | '330,000'         | '3,626'    | '330,000'      | '3,587'    | '990,000'   | '10,880'   |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '900,000'   | '900,000'  |
			| 'USD '                                                                   | '270,000'        | '3,699'    | '270,000'         | '3,649'    | '270,000'      | '3,600'    | '810,000'   | '10,947'   |
			| "Revenue by currency [Rate specified in the indicator another report]"         | '900,000'        | ''         | '900,000'         | ''         | '900,000'      | ''         | '2,700,000' | ''         |
			| 'EUR '                                                                   | '330,000'        | '3,667'    | '330,000'         | '3,626'    | '330,000'      | '3,587'    | '990,000'   | '10,880'   |
			| 'RUB '                                                                   | '300,000'        | '300,000'  | '300,000'         | '300,000'  | '300,000'      | '300,000'  | '900,000'   | '900,000'  |
			| 'USD '                                                                   | '270,000'        | '3,699'    | '270,000'         | '3,649'    | '270,000'      | '3,600'    | '810,000'   | '10,947'   |
	
	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'

	* Comparing movements
		When '$WindowTitle$' window is opened
		And I click the button named 'FormOpenDocumentRegisterRecordsFlatTab'
		Then "Flat table of indicator values" window is opened
		And I wait for filling of 'R2C1' cell in 'ReportSpreadsheetDocument' spreadsheet document for 30 seconds
		Given 'ReportSpreadsheetDocument' spreadsheet document is equal to "3_Budgeting\Layouts\09\VA_CurrencyIndicators_Receiver_Movements.mxl" by template
		And I close "Flat table of indicator values" window

Scenario: 09.10 Changing the rate via Periodic currency rates

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password

	* Opening the processing
		And In the command interface I select "Budgeting, reporting, and analysis" "Periodic exchange rates"
		Then "Periodic exchange rates" window is opened
		And I select from the drop-down list named 'Scenario'  by "VA - Main scenario" string
		And I select "Month" exact value from the drop-down list named 'Periodicity'
		And I click the button named 'ChangePeriod'
		Then "Select period" window is opened
		And I input "1/1/2024" text in the field named 'DateBegin'
		And I move to the next attribute
		And I input "3/31/2024" text in the field named 'DateEnd'
		And I click the button named 'Select'
		Then "Periodic exchange rates" window is opened
		And I select "EUR" exact value from the drop-down list named 'Currency'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "Currency"          | "Exchange rate at the beginning of the period" | "Exchange rate at the end of the period" | "Average rate" | "Average rate IFRS" | "Average rate (CB)" | "Multiplier" |
			| "EUR"             | ''                       | ''                      | ''             | ''                  | ''                  | ''          |
			| "January 2024"  | '90.7932'                | '92.2963'               | '90.4971'      | '91.5448'           | '90.4537'           | '1.0000'    |
			| "February 2024" | '92.2963'                | '90.3743'               | '89.9321'      | '91.3353'           | '90.0038'           | '1.0000'    |
			| "March 2024"    | '90.3743'                | '88.8821'               | '88.6820'      | '89.6282'           | '88.7338'           | '1.0000'    |
	
	* Editing the rate
		// TO BE COMPLETED
				
Scenario: 09.11 Changing the rate in the Scenario period management document

	* Finding and opening the required document
		And In the command interface I select "Budgeting, reporting, and analysis" "Reporting period management"

		And I search element "VA - Main scenario" "Exact match" by field "Scenario" in list "Reporting period management"
		And I search element "Month" "Exact match" by field "Frequency" in list "Reporting period management"
		And I search element "January 2024" "At the beginning of the line" by field "Start period" in list "Reporting period management"

		Then the number of 'List' table lines is "equal" 1
		And I select current line in 'List' table

		Then I open period management document for scenario "VA - Main scenario" frequency "Month"

	* Editing the rate
	// TO BE COMPLETED
//		And I press the button named 'FormGoForward'
//		And in the table 'RatesViewTable' I press the button named 'RatesTable_ChangeModeWithoutSave'
//		When the window '$WindowTitle$' opened
//		And in the table 'RatesEditTable' I go to the row:
//			| "Currency" | "Current value" | "Multiplier" | "Rate period"   |
//			| 'EUR'    | '90.7932'          | '1.0000'    | "January 2024" |
//		And in the table 'RatesEditTable' I select the current row
//		And in the table 'RatesEditTable' in the field named 'RatesEditTableRateAtPeriodStart_CurrentValue' I enter the text '90.7932'
//		And in the table 'RatesEditTable' in the field named 'RatesEditTableRateAtPeriodEnd_CurrentValue' I enter the text '92.2963'
//		And in the table 'RatesEditTable' in the field named 'RatesEditTableAverageRateForPeriod_CurrentValue' I enter the text '90.4971'
//		And in the table 'RatesEditTable' in the field named 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' I enter the text '90.4537'
//		And in the table 'RatesEditTable' in the field named 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' I enter the text '91.5448'
//		And in the table 'RatesEditTable' in the field named 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' I enter the text '0'
//		And in the table 'RatesEditTable' in the field named 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' I enter the text '0'
//		And in the table 'RatesEditTable' in the field named 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' I enter the text '0'
//		And in the table 'RatesEditTable' I finish editing the row
//		And in the table 'RatesEditTable' I press the button named 'RatesEditTableRatesTable_Write'
		

