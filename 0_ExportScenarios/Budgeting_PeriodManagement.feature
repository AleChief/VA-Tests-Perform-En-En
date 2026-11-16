#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the "Budgeting" subsystem - "Reporting period management"

Scenario: I create period management document with scenario 'TheScenario' regulation 'TheRegulation' frequency 'TheFrequency' start date 'TheDateBegin' end date 'TheDateEnd'

	And In the command interface I select "Budgeting, reporting, and analysis" "Reporting period management"
	Then "Reporting period management" window is opened
	And I click the button named 'FormCreate'
	Then "Reporting period management (create)" window is opened
	And I select from the drop-down list named 'Scenario'  by '[TheScenario]' string
	And I select '[TheFrequency]' exact value from the drop-down list named 'ScenarioFrequency'
	And I click the button named 'ChangePeriod'
	Then "Select period" window is opened
	And I input '[TheDateBegin]' text in the field named 'DateBegin'
	And I move to the next attribute
	And I input '[TheDateEnd]' text in the field named 'DateEnd'
	And I click the button named 'Select'
	Then "Reporting period management (create) *" window is opened
	And I select from the drop-down list named 'OrganizationalStructureVersion'  by '[TheRegulation]' string
	And I click the button named 'FormGoForward'
	Then "1C:Enterprise" window is opened
	And I click the button named 'Button0'
	And I save form header as 'FormCaption' variable
	Then '$FormCaption$' window is opened
	And in the table 'RatesEditTable' I click the button named 'RatesEditTableRatesTable_Update'
	And I click the button named 'FormGoForward'
	Then "1C:Enterprise" window is opened
	And I click the button named 'Button0'
	When '$FormCaption$' window is opened
	And I click the button named 'FormGoForward'
	Then '$FormCaption$' window is opened
	And I click the button named 'FormClose'

Scenario: I fill exchange rates table in scenario period management

	And I move to the tab named 'ExchangeRates'
	And in the table 'RatesEditTable' I click the button named 'RatesEditTableRatesTable_Update'
	And in the table 'RatesEditTable' I click the button named 'RatesEditTableRatesTable_Write'
	And in the table 'RatesViewTable' I click the button named 'RatesTable_ChangeModeWithoutSave'
	* EUR
		And I go to line in 'RatesEditTable' table:
			| "Currency" | "Multiplier" | "Rate period"   |
			| 'EUR'    | '1.0000'    | "January 2024" |
		And I select current line in 'RatesEditTable' table
		And I input '90.7932' text in the field named 'RatesEditTableRateAtPeriodStart_CurrentValue' of 'RatesEditTable' table
		And I input '92.2963' text in the field named 'RatesEditTableRateAtPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '90.4971' text in the field named 'RatesEditTableAverageRateForPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '90.4537' text in the field named 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I input '91.5448' text in the field named 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' of 'RatesEditTable' table
		And I input '0' text in the field named 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '0' text in the field named 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '0' text in the field named 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I go to line in 'RatesEditTable' table:
			| "Currency" | "Multiplier" | "Rate period"    |
			| 'EUR'    | '1.0000'    | "February 2024" |
		And I select current line in 'RatesEditTable' table
		And I input '92.2963' text in the field named 'RatesEditTableRateAtPeriodStart_CurrentValue' of 'RatesEditTable' table
		And I input '90.3743' text in the field named 'RatesEditTableRateAtPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '89.9321' text in the field named 'RatesEditTableAverageRateForPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '90.0038' text in the field named 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I input '91.3353' text in the field named 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' of 'RatesEditTable' table
		And I input '92.2963' text in the field named 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '90.4971' text in the field named 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '90.4537' text in the field named 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I go to line in 'RatesEditTable' table:
			| "Currency" | "Multiplier" | "Rate period" |
			| 'EUR'    | '1.0000'    | "March 2024" |
		And I select current line in 'RatesEditTable' table
		And I input '90.3743' text in the field named 'RatesEditTableRateAtPeriodStart_CurrentValue' of 'RatesEditTable' table
		And I input '88.8821' text in the field named 'RatesEditTableRateAtPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '88.6820' text in the field named 'RatesEditTableAverageRateForPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '88.7338' text in the field named 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I input '89.6282' text in the field named 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' of 'RatesEditTable' table
		And I input '90.3743' text in the field named 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '89.9321' text in the field named 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '90.0038' text in the field named 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
	* USD
		And I go to line in 'RatesEditTable' table:
			| "Currency" | "Multiplier" | "Rate period"   |
			| 'USD'    | '1.0000'    | "January 2024" |
		And I select current line in 'RatesEditTable' table
		And I input '73.8757' text in the field named 'RatesEditTableRateAtPeriodStart_CurrentValue' of 'RatesEditTable' table
		And I input '76.2527' text in the field named 'RatesEditTableRateAtPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '74.2204' text in the field named 'RatesEditTableAverageRateForPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '74.1489' text in the field named 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I input '75.0642' text in the field named 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' of 'RatesEditTable' table
		And I input '0' text in the field named 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '0' text in the field named 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '0' text in the field named 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I go to line in 'RatesEditTable' table:
			| "Currency" | "Multiplier" | "Rate period"    |
			| 'USD'    | '1.0000'    | "February 2024" |
		And I select current line in 'RatesEditTable' table
		And I input '76.2527' text in the field named 'RatesEditTableRateAtPeriodStart_CurrentValue' of 'RatesEditTable' table
		And I input '74.4373' text in the field named 'RatesEditTableRateAtPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '74.3747' text in the field named 'RatesEditTableAverageRateForPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '74.4435' text in the field named 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I input '75.3450' text in the field named 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' of 'RatesEditTable' table
		And I input '76.2527' text in the field named 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '74.2204' text in the field named 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '74.1489' text in the field named 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I go to line in 'RatesEditTable' table:
			| "Currency" | "Multiplier" | "Rate period" |
			| 'USD'    | '1.0000'    | "March 2024" |
		And I select current line in 'RatesEditTable' table
		And I input '74.4373' text in the field named 'RatesEditTableRateAtPeriodStart_CurrentValue' of 'RatesEditTable' table
		And I input '75.7023' text in the field named 'RatesEditTableRateAtPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '74.4035' text in the field named 'RatesEditTableAverageRateForPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '74.3689' text in the field named 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
		And I input '75.0698' text in the field named 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' of 'RatesEditTable' table
		And I input '74.4373' text in the field named 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' of 'RatesEditTable' table
		And I input '74.3747' text in the field named 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' of 'RatesEditTable' table
		And I input '74.4435' text in the field named 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' of 'RatesEditTable' table
	And I finish line editing in 'RatesEditTable' table
	And in the table 'RatesEditTable' I click the button named 'RatesEditTableRatesTable_Write'

Scenario: I find and select reporting period management document by scenario "TheScenario" and start period "ThePeriod"

	Then "Reporting period management" window is opened
	And I search element "[TheScenario]" "Exact match" by field "Scenario" in list "Reporting period management"
	And I search element "[ThePeriod]" "At the beginning of the line" by field "Start period" in list "Reporting period management"
	Then the number of 'List' table lines is "equal" 1
	And I select current line in 'List' table
