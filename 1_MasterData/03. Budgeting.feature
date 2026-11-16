#language: en
@tree

@UH32_NSI
@ERPUH32_NSI
@Perform_Budget

Feature: 03. Initial configuration and reference data entry - "Budgeting"

	As Administrator I want to
	Enter all reference data
	to verify reference data entry and start testing other functionality

Background:

	And I connect "CPM - NSI" TestClient using "Administrator" login and "" password
	And I close all client application windows

Scenario: 00.01 Launching the required test client

	And I initialize variables

Scenario: 00.02 Configuring the information base

	* Configuring access rights
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Users and rights settings"
			Then "Users and rights settings" window is opened
		Else
			And In the command interface I select "Administration" "Users and rights settings"
			Then "Users and rights settings" window is opened
			If 'NOT $$IsPerform$$' Then
				And I set checkbox named 'UseMultipleResponsiblePersons'
		And I set checkbox named 'UseUserGroups'
		And I set checkbox named 'LimitAccessAtRecordLevel'
		If "1C:Enterprise" window is opened Then
			And I click the button named 'Button0'
		Then "Users and rights settings" window is opened
		If '$$IsPerform$$' Then
			* Enabling performance mode
				And I enable performance mode of restrictions at record level
		Else
			* Enabling standard mode
				And I select "Standard" exact value from the drop-down list named 'LimitAccessAtRecordLevelUniversally'
				If "1C:Enterprise" window is opened Then
					And I click the button named 'Button0'

	* Configuring the edit lock date
		Then "Users and rights settings" window is opened
		And I expand the group named 'UsersPersonalSettingsGroup'
		And I expand the group named 'PeriodClosingDatesGroup'
		And I set checkbox named 'UsePeriodClosingDates'
		And I click the button named 'ConfigurePeriodClosingDates'
		Then "Period-end closing dates" window is opened
		And I input '12/31/2000' text in the field named 'PeriodEndClosingDateSimpleMode'
		And I move to the tab named 'AdvancedOptionsGroup'
		And I select "Single date for all sections and objects" exact value from the drop-down list named 'PeriodEndClosingDateSettingMethod'
		And I close "Period-end closing dates" window
		And I close "Users and rights settings" window

	* Configuring the program
		If '$$IsERPCPM$$' Then
			* Enterprise
				And In the command interface I select "Reference data and administration" "Company"
				Then "Company" window is opened
				And I set checkbox named 'UseMultipleOrganizations'
				And I expand the group named 'GroupSettingsCurrencies'
				And I set checkbox named 'UseMultipleCurrencies'
				Then "Company" window is opened
				And I close "Enterprise" window
			* CRM and Marketing
				And In the command interface I select "Reference data and administration" "CRM and marketing"
				Then "CRM and marketing" window is opened
				And I expand the group named "GroupSettingsCRM"
				And I set checkbox named 'UsePartnersAndCounterparties'
				And I expand the group named 'GroupMarketing'
				And I set checkbox named 'UseMultiplePriceTypes'
				Then "CRM and marketing" window is opened
				And I close "CRM and marketing" window
			* Warehouse and Delivery
				And In the command interface I select "Reference data and administration" "Warehouse and delivery"
				Then "Warehouse and delivery" window is opened
				And I set checkbox named 'UseMultipleWarehouses'
				Then "Warehouse and delivery" window is opened
				And I close "Warehouse and delivery" window

	And I create unit of measure with code '796' if it does not exist, name "PCs", full name "Piece"

	* Setting constants and FO
		And I set 'True' value to the constant 'UseIndicatorRecalculationTraceMode'
		If '$$IsERPCPM$$' Then
			And I set 'True' value to the constant 'UseCommodityCategories'

	* Adding currencies if they don't exist
		* RUB
			And I create currency with digital code '643' symbol code 'RUB' and name "Russian ruble" if it does not exist
		* EUR
			And I create currency with digital code '978' symbol code 'EUR' and name "Euro" if it does not exist
			And I set currency rate 'EUR' on date '1/1/2024' to value '90.7932' repetition '1' base currency 'RUB'
			And I set currency rate 'EUR' on date '2/1/2024' to value '92.2963' repetition '1' base currency 'RUB'
			And I set currency rate 'EUR' on date '3/1/2024' to value '90.3743' repetition '1' base currency 'RUB'
		* USD
			And I create currency with digital code '840' symbol code 'USD' and name "US dollar" if it does not exist
			And I set currency rate 'USD' on date '1/1/2024' to value '73.8757' repetition '1' base currency 'RUB'
			And I set currency rate 'USD' on date '2/1/2024' to value '76.2527' repetition '1' base currency 'RUB'
			And I set currency rate 'USD' on date '3/1/2024' to value '74.4373' repetition '1' base currency 'RUB'
		* KZT
			And I create currency with digital code '398' symbol code 'KZT' and name "Tenge" if it does not exist

	* Setting the regulated accounting currency for ERPKH
		If '$$IsCPM$$' Then
			If '$$IsPerform$$' Then
				And In the command interface I select "IFRS accounting" "IFRS settings"
				Then "IFRS settings" window is opened
				And I expand the group named 'GroupDefaultValues'
				And I select 'RUB' exact value from the drop-down list named 'ManagementAccountingCurrency'
				And I click the button named 'FormWriteAndClose'
				And I wait "IFRS settings *" window closing in 20 seconds
			Else
				And I execute 1C:Enterprise script at server no context
				"""bsl
					Константы.ВалютаУправленческогоУчета.Установить(Справочники.Валюты.НайтиПоКоду("643"));
				"""	
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Company"
			Then "Company" window is opened
			And I expand the group named 'GroupSettingsCurrencies'
			And I select 'RUB' exact value from the drop-down list named 'ManagementAccountingCurrency'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			Then "Company" window is opened
			And I close "Enterprise" window

	If '$$IsPerform$$' Then
		И Я создаю страну с кодом1 '643' кодом2 'RU' кодом3 'RUS' именем1 "РОССИЯ" именем2 "Российская Федерация" именем3 "The Russian Federation" если ее нет в 1C:CPMWE

	* Disabling news functionality
		If '$$IsERPCPM$$' Then
			And I set 'False' value to the constant 'WorkWithNewsAllowed'
			And I set 'False' value to the constant 'WorkWithNewsThroughInternetAllowed'

Scenario: 00.03 Creating profiles and access groups

	And I create access group with name "Open external reports and data processors" by profile "Open external reports and data processors"

	And I create profile with name "VA - Budgeting (Edit)" based on profile "Operations with customizable reporting (report instances, adjustments, and pivot table)"
	And I create access group with name "VA - Budgeting (Edit)" by profile "VA - Budgeting (Edit)"

	And I create profile with name "VA - Budgeting (View)" based on profile "View customizable reporting (report instances, adjustments, and pivot table)"
	And I create access group with name "VA - Budgeting (View)" by profile "VA - Budgeting (View)"

Scenario: 00.04 Creating users

	And I find or create user "Administrator" access group "Administrators" group ""

	And I find or create user group with name "VA - Budgeting"

	And I find or create user "Budgeting1" access group "VA - Budgeting (Edit)" group "VA - Budgeting"
	And I find or create user "Budgeting2" access group "VA - Budgeting (Edit)" group "VA - Budgeting"
	And I find or create user "Budgeting3" access group "VA - Budgeting (View)" group "VA - Budgeting"
	And I find or create user "Budgeting4" access group "VA - Budgeting (View)" group "VA - Budgeting"

Scenario: 00.05 Creating Report Types group

	And I create report type group with name "VA - Report group" and parent ''

Scenario: 00.06 Creating organizational unit type

	And I create organizational unit type with name "VA - Package CFR"

Scenario: 00.07 Creating relationship to group

	And I create relation to group with name "VA - Subsidiary" and kind "Subsidiary"

Scenario: 00.08 Creating companies and cost centers
	
	* Creating company System
		And I create company with name "System LLC" type 'SelectRF' kind 'SelectLE' taxation 'TaxationSystemGeneralLE'
		If '$$IsCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType' for company "System LLC"
			And I create subdivision with name "Administration" for company "System LLC"
			And I create subdivision with name "Accounting" for company "System LLC"
		If '$$IsERPCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType1' for company "System LLC"
			And I for company "System LLC" create a department with name "Administration" in ERP_UH
			And I for company "System LLC" create a department with name "Accounting" in ERP_UH

		If '$$IsPerform$$' Then
			And I select value "VA - Subsidiary" for attribute 'GroupCounterparty' for company "System LLC"
		Else
			And I select value "VA - Subsidiary" for attribute 'CounterpartyGroups' for company "System LLC"

	* Creating company Mercury
		And I create company with name "Mercury LLC" type 'SelectRF' kind 'SelectLE' taxation 'TaxationSystemGeneralLE'
		And I select value "System LLC" for attribute 'Parent' for company "Mercury LLC"
		
		If '$$IsCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType' for company "Mercury LLC"
		ElseIf '$$IsERPCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType1' for company "Mercury LLC"
		
		If '$$IsPerform$$' Then
			And I select value "VA - Subsidiary" for attribute 'GroupCounterparty' for company "Mercury LLC"
		Else
			And I select value "VA - Subsidiary" for attribute 'CounterpartyGroups' for company "Mercury LLC"

	* Creating company Venus
		And I create company with name "Venus LLC" type 'SelectCFO' kind '' taxation ''
		And I select value "System LLC" for attribute 'Parent' for company "Venus LLC"
		
		If '$$IsCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType' for company "Venus LLC"
		ElseIf '$$IsERPCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType1' for company "Venus LLC"

	* Creating company Earth
		And I create company with name "Earth LLC" type 'SelectCFO' kind '' taxation ''
		And I select value "System LLC" for attribute 'Parent' for company "Earth LLC"
		
		If '$$IsCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType' for company "Earth LLC"
		ElseIf '$$IsERPCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType1' for company "Earth LLC"
		
	* Creating company Mars
		And I create company with name "Mars LLC" type 'SelectCFO' kind 'SelectEl' taxation ''
		And I select value "System LLC" for attribute 'Parent' for company "Mars LLC"
		
		If '$$IsCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType' for company "Mars LLC"
		ElseIf '$$IsERPCPM$$' Then
			And I select value "VA - Package CFR" for attribute 'CompanyType1' for company "Mars LLC"

Scenario: 00.09 Configuring access restrictions by companies

	And I add access restriction with kind "Companies" value "All denied, configure exceptions in access groups" to profile "VA - Budgeting (Edit)"
	And I add access values with kind "Companies" from table to access group "VA - Budgeting (Edit)"
		| "Access Value" | "Include subordinate items" |
		| "System LLC"      | "Yes"                  |

	And I add access restriction with kind "Companies" value "All denied, configure exceptions in access groups" to profile "VA - Budgeting (View)"
	And I add access values with kind "Companies" from table to access group "VA - Budgeting (View)"
		| "Access Value" | "Include subordinate items" |
		| "Mercury LLC"     | "No"                 |
		| "Venus LLC"       | "No"                 |

Scenario: 00.10 Creating Scenario

	And I create scenario with name "VA - Main scenario"

Scenario: 00.11 Creating Project

	And I create project with name "VA - Main project"
				
Scenario: 00.12 Creating reporting preparation regulation

	And I create regulation group with name "VA - Group regulations"

	* Deleting the current element
		And I search element "VA - Main regulations" "Exact match" by field "Description" in list "Regulations for preparing reports"
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then I open reporting preparation regulation "VA - Main regulations"
				And I move to the tab named 'GroupMainPage'
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait '$WindowTitle$' window closing in 20 seconds

	* Creating an element
		Then "Regulations for preparing reports" window is opened
		And I click the button named 'FormCreate'
		Then I open reporting preparation regulation ''
		And I input "VA - Main regulations" text in the field named 'Description'
		And I input "VA - Group regulations" text in the field named 'Parent'
	
	* Selecting report types group
		Then '$WindowTitle$' window is opened
		And I click Choice button of the field named 'ReportKind'
		Then "Report types" window is opened
		And I select context menu item named 'ListContextMenuFind' of the form attribute named 'List'
		Then the form named 'UniversalListFindExtForm' is opened
		And I input "VA - Report group" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Report types" window is opened
		And I activate field named 'Description' in 'List' table
		And I select current line in 'List' table
	
	* Hiding companies, enabling perimeters
		Then '$WindowTitle$' window is opened
		And I move to the tab named 'PerimeterSetting'
		And in the table 'GroupStructure' I click the button named 'GroupStructureClearBusinessUnits'
		And I change checkbox named 'UsePerimeters'
		When '$WindowTitle$' window is opened
		And in the table 'GroupStructure' I click the button named 'GroupStructurePickOfCompaines'
		And I click the button named 'OrganizationalUnitsFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select from the drop-down list named 'Pattern'  by "System LLC" string
		And I click the button named 'Find'
		Then '$WindowTitle$' window is opened
		And I click the button named 'BusinessUnitsCopyWithHierarchy'

	* Expanding groups
		When '$WindowTitle$' window is opened
		And I go to line in 'GroupStructure' table:
			| "Consolidating company\n/ Business unit" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
			| "System LLC"                                            | '- '                   | "Group"             | '- '                  |
		And I expand current line in 'GroupStructure' table

	* Setting currency, if necessary
		If 'GroupStructure' table contains line Then
			| "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Основная валюта" | "Company status for consolidation" | "Effective share, %" |
			| "System LLC"                                            | '- '                   | ''                | "Group"             | '- '                  |
			And I go to line in 'GroupStructure' table:
				| "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Основная валюта" | "Company status for consolidation" | "Effective share, %" |
				| "System LLC"                                            | '- '                   | ''                | "Group"             | '- '                  |
			And I activate field named 'GroupStructureCurrency' in 'GroupStructure' table
			And I select current line in 'GroupStructure' table
			And I select 'RUB' exact value from the drop-down list named 'GroupStructureCurrency' in 'GroupStructure' table
		If 'GroupStructure' table contains line Then
			| "Consolidating company\n/ Business unit" | "Intercompany transactions exclusion method" | "Основная валюта" | "Effective share, %" |
			| "Venus LLC"                                             | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			And I go to line in 'GroupStructure' table:
				| "Consolidating company\n/ Business unit" | "Intercompany transactions exclusion method" | "Основная валюта" | "Effective share, %" |
				| "Venus LLC"                                             | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			And I activate field named 'GroupStructureCurrency' in 'GroupStructure' table
			And I select current line in 'GroupStructure' table
			And I select 'RUB' exact value from the drop-down list named 'GroupStructureCurrency' in 'GroupStructure' table
		If 'GroupStructure' table contains line Then
			| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
			| "Венера ООО"                                             | ''                | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			And I go to line in 'GroupStructure' table:
				| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
				| "Венера ООО"                                             | ''                | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			And I activate field named 'GroupStructureCurrency' in 'GroupStructure' table
			And I select current line in 'GroupStructure' table
			And I select 'RUB' exact value from the drop-down list named 'GroupStructureCurrency' in 'GroupStructure' table
		If 'GroupStructure' table contains line Then
			| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
			| "Земля ООО"                                              | ''                | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			And I go to line in 'GroupStructure' table:
				| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
				| "Земля ООО"                                              | ''                | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			And I activate field named 'GroupStructureCurrency' in 'GroupStructure' table
			And I select current line in 'GroupStructure' table
			And I select 'RUB' exact value from the drop-down list named 'GroupStructureCurrency' in 'GroupStructure' table
		If 'GroupStructure' table contains line Then
			| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Метод исключения ВГО" | "Отношение к Группе" | "Эффективная доля, %" |
			| "Mars LLC"                                               | ''                | "ЦФО"                  | "ЦФО"                | '100'                 |
			And I go to line in 'GroupStructure' table:
				| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Метод исключения ВГО" | "Отношение к Группе" | "Эффективная доля, %" |
				| "Mars LLC"                                               | ''                | "ЦФО"                  | "ЦФО"                | '100'                 |
			And I activate field named 'GroupStructureCurrency' in 'GroupStructure' table
			And I select current line in 'GroupStructure' table
			And I select 'RUB' exact value from the drop-down list named 'GroupStructureCurrency' in 'GroupStructure' table

	* Configuring relationship to group and ownership share
		When '$WindowTitle$' window is opened
		And I go to line in 'GroupStructure' table:
			| "Company kind" | "Consolidating company\n/ Business unit" | "Primary currency" | "Effective share, %" |
			| "VA - Package CFR"  | "Mercury LLC"                                           | 'RUB'             | '100.000'             |
		And I activate field named 'GroupStructureEffectiveShare' in 'GroupStructure' table
		And I select current line in 'GroupStructure' table
		And I input '50.000' text in the field named 'GroupStructureEffectiveShare' of 'GroupStructure' table
		And I finish line editing in 'GroupStructure' table
		And I activate field named 'GroupStructureCounterpartyGroup' in 'GroupStructure' table
		And I select current line in 'GroupStructure' table
		And I select "VA - Subsidiary" exact value from the drop-down list named 'GroupStructureCounterpartyGroup' in 'GroupStructure' table
		And I finish line editing in 'GroupStructure' table
		And I activate field named 'GroupStructureIntercompanyTransactionsExclusionMethod' in 'GroupStructure' table
		And I select current line in 'GroupStructure' table
		And I select "Balance and turnovers" exact value from the drop-down list named 'GroupStructureIntercompanyTransactionsExclusionMethod' in 'GroupStructure' table
		And I finish line editing in 'GroupStructure' table
				
	* Testing buttons 'Up' and 'Down'
		And I go to line in 'GroupStructure' table:
			| "Consolidating company\n/ Business unit" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation" | "Effective share, %" |
			| "Mars LLC"                                               | "Eliminating"        | 'RUB'             | "Eliminating"      | '100'                 |
		And in the table 'GroupStructure' I click the button named 'GroupStructureCommandBarMoveUp'
		And in the table 'GroupStructure' I click the button named 'GroupStructureCommandBarMoveUp'
		And in the table 'GroupStructure' I click the button named 'GroupStructureCommandBarMoveUp'
		And I go to line in 'GroupStructure' table:
			| "Company kind" | "Consolidating company\n/ Business unit" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation"        | "Effective share, %" |
			| "VA - Package CFR"  | "Mercury LLC"                                           | "Balance and turnovers"    | 'RUB'             | "VA - Subsidiary" | '50.000'              |
		And in the table 'GroupStructure' I click the button named 'GroupStructureCommandBarMoveDown'
		And in the table 'GroupStructure' I click the button named 'GroupStructureCommandBarMoveDown'
	
	* Saving element
		When '$WindowTitle$' window is opened
		And I click the button named 'FormWrite'

	* Setting additional currencies
		Then I open reporting preparation regulation "VA - Main regulations"
		And I move to the tab named 'PerimeterSetting'
		And I move to the tab named 'GroupMainPage'
		* Mars
			Then '$WindowTitle$' window is opened
			And I go to line in 'GroupStructure' table:
				| "Consolidating company\n/ Business unit" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation" | "Effective share, %" |
				| "Mars LLC"                                               | "Eliminating"        | 'RUB'             | "Eliminating"      | '100'                 |
			And I activate field named 'GroupStructureAdditionalCurrencies' in 'GroupStructure' table
			And I select current line in 'GroupStructure' table
			And I click choice button of the attribute named 'GroupStructureAdditionalCurrencies' in 'GroupStructure' table
			Then "Currency list" window is opened
			And I click the button named 'AdditionalCurrenciesAdd'
			And I select "EUR" exact value from the drop-down list named 'AdditionalCurrenciesCurrency' in 'AdditionalCurrencies' table
			And I finish line editing in 'AdditionalCurrencies' table
			And I click the button named 'AdditionalCurrenciesAdd'
			And I select "USD" exact value from the drop-down list named 'AdditionalCurrenciesCurrency' in 'AdditionalCurrencies' table
			And I finish line editing in 'AdditionalCurrencies' table
			And I click the button named 'FormOkCommand'
		* Mercury
			Then '$WindowTitle$' window is opened
			And I finish line editing in 'GroupStructure' table
			And I go to line in 'GroupStructure' table:
				| "Company kind" | "Consolidating company\n/ Business unit" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation"        | "Effective share, %" |
				| "VA - Package CFR"  | "Mercury LLC"                                           | "Balance and turnovers"    | 'RUB'             | "VA - Subsidiary" | '50.000'              |
			And I select current line in 'GroupStructure' table
			And I click choice button of the attribute named 'GroupStructureAdditionalCurrencies' in 'GroupStructure' table
			Then "Currency list" window is opened
			And I click the button named 'AdditionalCurrenciesAdd'
			And I select "EUR" exact value from the drop-down list named 'AdditionalCurrenciesCurrency' in 'AdditionalCurrencies' table
			And I finish line editing in 'AdditionalCurrencies' table
			And I click the button named 'AdditionalCurrenciesAdd'
			And I select "USD" exact value from the drop-down list named 'AdditionalCurrenciesCurrency' in 'AdditionalCurrencies' table
			And I finish line editing in 'AdditionalCurrencies' table
			And I click the button named 'FormOkCommand'
		* Venus
			Then '$WindowTitle$' window is opened
			And I finish line editing in 'GroupStructure' table
			And I go to line in 'GroupStructure' table:
				| "Consolidating company\n/ Business unit" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation" | "Effective share, %" |
				| "Venus LLC"                                             | "Financial responsibility center"                  | 'RUB'             | "Financial responsibility center"                | '100'                 |
			And I select current line in 'GroupStructure' table
			And I click choice button of the attribute named 'GroupStructureAdditionalCurrencies' in 'GroupStructure' table
			Then "Currency list" window is opened
			And I click the button named 'AdditionalCurrenciesAdd'
			And I select "EUR" exact value from the drop-down list named 'AdditionalCurrenciesCurrency' in 'AdditionalCurrencies' table
			And I finish line editing in 'AdditionalCurrencies' table
			And I click the button named 'AdditionalCurrenciesAdd'
			And I select "USD" exact value from the drop-down list named 'AdditionalCurrenciesCurrency' in 'AdditionalCurrencies' table
			And I finish line editing in 'AdditionalCurrencies' table
			And I click the button named 'FormOkCommand'
		* Earth
			Then '$WindowTitle$' window is opened
			And I finish line editing in 'GroupStructure' table
			And I go to line in 'GroupStructure' table:
				| "Consolidating company\n/ Business unit" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation" | "Effective share, %" |
				| "Earth LLC"                                              | "Financial responsibility center"                  | 'RUB'             | "Financial responsibility center"                | '100'                 |
			And I select current line in 'GroupStructure' table
			And I click choice button of the attribute named 'GroupStructureAdditionalCurrencies' in 'GroupStructure' table
			Then "Currency list" window is opened
			And I click the button named 'AdditionalCurrenciesAdd'
			And I select "USD" exact value from the drop-down list named 'AdditionalCurrenciesCurrency' in 'AdditionalCurrencies' table
			And I finish line editing in 'AdditionalCurrencies' table
			And I click the button named 'FormOkCommand'

	* Testing reports and related links
		Then I open reporting preparation regulation "VA - Main regulations"
		And in the table 'GroupStructure' I click the button named 'FormInvestorsComposition'
		Then "Ownership structure" window is opened
		And I close "Ownership structure" window
		Then '$WindowTitle$' window is opened
		And in the table 'GroupStructure' I click the button named 'GroupStructureReportRegulationOrganizationalStructuresOrganizationalStructureChart'
		Then "Organizational structure briefly" window is opened
		And I close "Organizational structure briefly" window
		Then '$WindowTitle$' window is opened
		And in the table 'GroupStructure' I click the button named 'GroupStructureReportRegulationOrganizationalStructuresOrganizationalStructureTable'
		Then "Organizational structure briefly" window is opened
		And I close "Organizational structure briefly" window
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormDocumentScenarioPeriodManagementAccountingPeriodManagementDocuments'
		Then "Reporting period management" window is opened
		And I close "Reporting period management" window
		Then '$WindowTitle$' window is opened
		And I move to the tab named 'GroupMainPage'
	
	* Saving and closing the element
		And I click the button named 'FormWriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds
		Then "Regulations for preparing reports" window is opened
		And I select current line in 'List' table
	
Scenario: 00.13 Creating a document Reporting period management

	* Opening the form of a new document
		And In the command interface I select "Budgeting, reporting, and analysis" "Reporting period management"
		Then "Reporting period management" window is opened
		And I click the button named 'FormCreate'
		Then "Reporting period management (create)" window is opened
	
	* Filling fields on the first tab
		And I select from the drop-down list named 'Scenario'  by "VA - Main scenario" string
		And I select "Month" exact value from the drop-down list named 'ScenarioFrequency'
		And I click the button named 'ChangePeriod'
		Then "Select period" window is opened
		And I input '1/1/2024' text in the field named 'DateBegin'
		And I input '3/31/2024' text in the field named 'DateEnd'
		And I click the button named 'Select'
		Then "Reporting period management (create) *" window is opened
		And I select from the drop-down list named 'OrganizationalStructureVersion'  by "VA - Main regulations" string
//		And I set the flag named 'LimitsSet'
//		And I click the button named 'OpenReportTypesToSetLimits'
//		Then the window "Types of reports for limit setting" opened
//		And I close the window "Types of reports for limit setting"
//		Then the window "Reporting period management (create) *" opened
//		And I uncheck the flag named 'LimitsSet'
		And I click the button named 'FormGoForward'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'

	* Filling exchange rates
		Then I open period management document for scenario "VA - Main scenario" frequency "Month"
		And I fill exchange rates table in scenario period management
		And I click the button named 'FormGoForward'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'

	* Testing buttons
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormGoForward'
		* Blocking the period
			And I click the button named 'PeriodsManagement1'
			When "Manage period lock duration and indicator updates" window is opened
			And in 'SpreadsheetFieldPeriodsManagement' spreadsheet document I move to "R5C2:R5C4" cell
			And I click the button named 'ClosePeriod'
			And I click the button named 'OpenPeriod'
			And in 'SpreadsheetFieldPeriodsManagement' spreadsheet document I move to "R5C2:R5C3" cell
			And I click the button named 'ClosePeriod'
			And I close "Manage period lock duration and indicator updates" window
		Then '$WindowTitle$' window is opened
		And I click the button named 'ButtonDeleteVersions'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormClose'

	* Opening an already saved form
		When "Reporting period management" window is opened
		And I select current line in 'List' table
		Then '$WindowTitle$' window is opened
		And I click the button named 'ReportOrganizationStructure'
		Then "Organizational structure briefly" window is opened
		And I close "Organizational structure briefly" window
		Then '$WindowTitle$' window is opened
		And I click the button named 'FormGoForward'
		And I click the button named 'FormGoForward'
		And I click the button named 'FormGoForward'
		And I click the button named 'FormBack'
		And I click the button named 'FormBack'
		And I click the button named 'FormBack'
		And I click the button named 'FormClose'

Scenario: 00.14 Creating dimension types (corporate)
	
	* Configuring the dimension 'Currency'
		And In the command interface I select "Budgeting, reporting, and analysis" "Dimension types (corporate)"
		And I search and select element 'Currencies' "Exact match" by field "Description" in list "Dimension types (corporate)"
		When '* (Dimension types (corporate))' window is opened
		And I input "Currencies" text in the field named 'Description'
		And I save the value of the field named 'Code' as 'CodeCurrency'
		And I click the button named 'FormWriteAndClose'
		And I wait "* (Dimension types (corporate)) *" window closing in 20 seconds
		And I set attribute "Alphabetic code" as key for dimension type with code "$CodeCurrency$"

	If '$$IsPerform$$' Then
		And I create dimension type with code "VA0ProCate" name "Product categories" type 'CatalogRef.ArbitraryClassifierCPM'
	Else
		And I create dimension type with code "VA0ProCate" name "Product categories" type 'CatalogRef.ProductCategories'
	And I set attribute "Description" as key for dimension type with code "VA0ProCate"

	And I create dimension type with code "VA0Product" name "Product range" type 'CatalogRef.Products'
	And I set attribute "Description" as key for dimension type with code "VA0Product"
	And I set attribute "Product ID" as key for dimension type with code "VA0Product"

	And I create dimension type with code "VA0Counter" name "Counterparties" type 'CatalogRef.Counterparties'
	If '$$IsERPCPM$$' Then
		And I set attribute "Working name" as key for dimension type with code "VA0Counter"
	Else
		And I set attribute "Name in the application" as key for dimension type with code "VA0Counter"

	And I create dimension type with code "VA0Contrac" name "Counterparty contracts" type 'CatalogRef.CounterpartyContracts'
	If '$$IsERPCPM$$' Then
		And I set attribute "Working name" as key for dimension type with code "VA0Contrac"
	Else
		And I set attribute "Description" as key for dimension type with code "VA0Contrac"

	And I create dimension type with code "VA0CFItems" name "Cash flow items" type 'CatalogRef.CashFlowReportItems'
	And I set attribute "Description" as key for dimension type with code "VA0CFItems"

	And I create dimension type with code "VA0IEItems" name "Income and expense items" type 'CatalogRef.IncomeAndExpenseItems'
	And I set attribute "Description" as key for dimension type with code "VA0IEItems"

Scenario: 00.15 Creating a nomenclature type

	If '$$IsCPM$$' Then
		And I create nomenclature folder with name "VA - Products"
		If 'NOT $$IsPerform$$' Then
			And I create nomenclature kind with name "VA - Products"
			And I create nomenclature kind with name "DimenKind - Other"

	If '$$IsERPCPM$$' Then
		And I create a nomenclature type with name "VA - Products" type 'Goods' in 1C:ERP_UH
		And I create a nomenclature type with name "DimenKind - Other" type 'Goods' in 1C:ERP_UH

Scenario: 00.16 Creating a product category

	If '$$IsPerform$$' Then
		And I create CPM subaccount with name "Software products" and dimension type with code "VA0ProCate"
	Else
		And I create product category with name "Software products" nomenclature kind "VA - Products"

Scenario: 00.17 Creating a nomenclature group

	If 'NOT $$IsERPCPM$$' Then
		And I create nomenclature group with name "VA - Product range group"

Scenario: 00.18 Creating nomenclature

	And I create nomenclature with name "4C:Enterprise 8.3 CORP. Server License (x86-64)" parent "VA - Products" nomenclature kind "VA - Products" article '2900001916059'
	And I create nomenclature with name "3C:Enterprise 8 CORP. Client license for 100 users" parent "VA - Products" nomenclature kind "VA - Products" article '4601546106674'
	And I create nomenclature with name "5C:Corporate performance management" parent "VA - Products" nomenclature kind "VA - Products" article '2900001871389'
	And I create nomenclature with name "2C:Corporation" parent "VA - Products" nomenclature kind "VA - Products" article '2900001871419'
	And I create nomenclature with name "1C:ERP. Corporate performance management" parent "VA - Products" nomenclature kind "VA - Products" article '2900001970198'

	If '$$IsCPM$$' Then
		And I select value "VA - Product range group" in group '' for attribute 'Product_Category' for nomenclature with name "4C:Enterprise 8.3 CORP. Server License (x86-64)"
		And I select value "VA - Product range group" in group '' for attribute 'Product_Category' for nomenclature with name "3C:Enterprise 8 CORP. Client license for 100 users"
		And I select value "VA - Product range group" in group '' for attribute 'Product_Category' for nomenclature with name "5C:Corporate performance management"
		And I select value "VA - Product range group" in group '' for attribute 'Product_Category' for nomenclature with name "2C:Corporation"
		And I select value "VA - Product range group" in group '' for attribute 'Product_Category' for nomenclature with name "1C:ERP. Corporate performance management"
		
		If 'NOT $$IsPerform$$' Then
			And I select value "Software products" in group 'GroupPurchasesUH' for attribute 'CommodityCategory' for nomenclature with name "4C:Enterprise 8.3 CORP. Server License (x86-64)"
			And I select value "Software products" in group 'GroupPurchasesUH' for attribute 'CommodityCategory' for nomenclature with name "3C:Enterprise 8 CORP. Client license for 100 users"
			And I select value "Software products" in group 'GroupPurchasesUH' for attribute 'CommodityCategory' for nomenclature with name "5C:Corporate performance management"
			And I select value "Software products" in group 'GroupPurchasesUH' for attribute 'CommodityCategory' for nomenclature with name "2C:Corporation"
			And I select value "Software products" in group 'GroupPurchasesUH' for attribute 'ProductCategory' for nomenclature with name "1C:ERP. Corporate performance management"

	ElseIf '$$IsERPCPM$$' Then
		And I select value "Software products" in group 'CollapsibleGroupPlanningAndMarketing' for attribute 'CommodityCategory' for nomenclature with name "4C:Enterprise 8.3 CORP. Server License (x86-64)"
		And I select value "Software products" in group 'CollapsibleGroupPlanningAndMarketing' for attribute 'CommodityCategory' for nomenclature with name "3C:Enterprise 8 CORP. Client license for 100 users"
		And I select value "Software products" in group 'CollapsibleGroupPlanningAndMarketing' for attribute 'CommodityCategory' for nomenclature with name "5C:Corporate performance management"
		And I select value "Software products" in group 'CollapsibleGroupPlanningAndMarketing' for attribute 'CommodityCategory' for nomenclature with name "2C:Corporation"
		And I select value "Software products" in group 'CollapsibleGroupPlanningAndMarketing' for attribute 'CommodityCategory' for nomenclature with name "1C:ERP. Corporate performance management"

Scenario: 00.19 Setting nomenclature prices

	If '$$IsCPM$$' Then
		And I create price type with name "VA - Products" currency 'RUB'
		If '$$IsPerform$$' Then
			And I set a price with type "VA - Products" for nomenclature "4C:Enterprise 8.3 CORP. Server License (x86-64)" on date '1/1/2024' to value '180000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "3C:Enterprise 8 CORP. Client license for 100 users" on date '1/1/2024' to value '600000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "5C:Corporate performance management" on date '1/1/2024' to value '1250000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "2C:Corporation" on date '1/1/2024' to value '2050000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "1C:ERP. Corporate performance management" on date '1/1/2024' to value '1950000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "4C:Enterprise 8.3 CORP. Server License (x86-64)" on date '2/1/2024' to value '198000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "3C:Enterprise 8 CORP. Client license for 100 users" on date '2/1/2024' to value '660000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "5C:Corporate performance management" on date '2/1/2024' to value '1375000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "2C:Corporation" on date '2/1/2024' to value '2255000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "1C:ERP. Corporate performance management" on date '2/1/2024' to value '2145000.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "4C:Enterprise 8.3 CORP. Server License (x86-64)" on date '3/1/2024' to value '223700.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "3C:Enterprise 8 CORP. Client license for 100 users" on date '3/1/2024' to value '745800.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "5C:Corporate performance management" on date '3/1/2024' to value '1553800.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "2C:Corporation" on date '3/1/2024' to value '2548200.00' 'RUB' in 1C:CPMWE
			And I set a price with type "VA - Products" for nomenclature "1C:ERP. Corporate performance management" on date '3/1/2024' to value '2423900.00' 'RUB' in 1C:CPMWE
		Else
			* 1C:ERP

				// 1C:ERP - Opening document list
				And In the command interface I select "Warehouse" "Setting nomenclature prices"
				Then "Setting nomenclature prices" window is opened
				
				// Creating a new document
				And I click the button named 'FormCreate'
				Then "Setting nomenclature prices (creation)" window is opened
				And I input '01.01.2024  0:00:00' text in the field named 'Date'
				And I select from the drop-down list named 'PriceType_'  by "VA - Products" string

				// Goods
				When "Setting nomenclature prices (creation) *" window is opened
				And in the table 'Goods' I click the button named 'GoodsAdd'
				And I select "4C:Enterprise 8.3 CORP. Server License (x86-64)" by string from the drop-down list named 'GoodsProductRange' in 'Goods' table
				And I input '180,000.00' text in the field named 'GoodsPrice' of 'Goods' table
				And in the table 'Goods' I click the button named 'GoodsAdd'
				And I select "3C:Enterprise 8 CORP. Client license for 100 users" by string from the drop-down list named 'GoodsProductRange' in 'Goods' table
				And I input '600,000.00' text in the field named 'GoodsPrice' of 'Goods' table
				And in the table 'Goods' I click the button named 'GoodsAdd'
				And I select "5C:Corporate performance management" by string from the drop-down list named 'GoodsProductRange' in 'Goods' table
				And I input '1,250,000.00' text in the field named 'GoodsPrice' of 'Goods' table
				And in the table 'Goods' I click the button named 'GoodsAdd'
				And I select "2C:Corporation" by string from the drop-down list named 'GoodsProductRange' in 'Goods' table
				And I input '2,050,000.00' text in the field named 'GoodsPrice' of 'Goods' table
				And in the table 'Goods' I click the button named 'GoodsAdd'
				And I select "1C:ERP. Corporate performance management" by string from the drop-down list named 'GoodsProductRange' in 'Goods' table
				And I input '1,950,000.00' text in the field named 'GoodsPrice' of 'Goods' table
			
				// Saving the document
				And I click the button named 'FormPostAndClose'
				And I wait "Setting product range prices (creation) *" window closing in 30 seconds
						
				// Creating another document
				When "Setting nomenclature prices" window is opened
				And I click the button named 'FormCreate'
				Then "Setting nomenclature prices (creation)" window is opened
				And I input '01.02.2024  0:00:00' text in the field named 'Date'
				And I select from the drop-down list named 'PriceType_'  by "VA - Products" string
				And in the table 'Goods' I click the button named 'FillByNomenclatureGroup'
				Then "Product range" window is opened
				And I select context menu item named 'ListContextMenuFind' of the form attribute named 'List'
				Then the form named 'UniversalListFindExtForm' is opened
				And I input "VA - Products" text in the field named 'Pattern'
				And I click the button named 'Find'
				Then "Product range" window is opened
				And I select current line in 'List' table
				Then "Setting nomenclature prices (creation) *" window is opened
				And in the table 'Goods' I click the button named 'GoodsChangeGoods'
				Then "Update of goods table" window is opened
				And I select "Change prices by percentage" exact value from the drop-down list named 'CurrentAction'
				And I input '10.00' text in the field named 'VariantValuesNumberPercent'
				And I click the button named 'Execute'
				And I click the button named 'FormMoveToDocument'
				Then "Setting nomenclature prices (creation) *" window is opened
				And I click the button named 'FormPostAndClose'
				And I wait "Setting product range prices (creation) *" window closing in 20 seconds
			
				// Creating a document by copying
				When "Setting nomenclature prices" window is opened
				And I select context menu item named 'ListContextMenuCopy' of the form attribute named 'List'
				Then "Setting nomenclature prices (creation)" window is opened
				And I input '01.03.2024  0:00:00' text in the field named 'Date'
				And in the table 'Goods' I click the button named 'GoodsChangeGoods'
				Then "Update of goods table" window is opened
				And I input '13.00' text in the field named 'VariantValuesNumberPercent'
				And I click the button named 'Execute'
				And I select "Round prices to" exact value from the drop-down list named 'CurrentAction'
				And I select "100" exact value from the drop-down list named 'VariantValuesOrderRounding'
				And I click the button named 'Execute'
				And I click the button named 'FormMoveToDocument'
				Then "Setting nomenclature prices (creation) *" window is opened
				And I click the button named 'FormPostAndClose'
				And I wait "Setting product range prices (creation) *" window closing in 20 seconds

				// Checking the result
				When "Setting nomenclature prices" window is opened
				And I select current line in 'List' table
				Then "Setting nomenclature prices * from *" window is opened
				Then 'Goods' table became equal
				| 'N' | "Product range"                                                   | "Price"         | "Currency" | "Indent" |
				| '1' | "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '223,700.00'   | 'RUB'    | ''       |
				| '2' | "3C:Enterprise 8 CORP. Client license for 100 users" | '745,800.00'   | 'RUB'    | ''       |
				| '3' | "5C:Corporate performance management"                                      | '1,553,800.00' | 'RUB'    | ''       |
				| '4' | "2C:Corporation"                                                  | '2,548,200.00' | 'RUB'    | ''       |
				| '5' | "1C:ERP. Corporate performance management"                                   | '2,423,900.00' | 'RUB'    | ''       |
				And I close "Setting nomenclature prices * from *" window

	If '$$IsERPCPM$$' Then

		* Creating a new price type
			And In the command interface I select "CRM and marketing" "Settings and directories"
			Then "Settings and directories for CRM and marketing" window is opened
			And I click the button named 'OpenPriceTypes'
			Then "Price types " window is opened
			And I change the radio button named 'GroupWarehousesViewOptionTypesOfPrices' value to 'All'
			And I wait for "Price types " form opening for 10 seconds
			If number of 'List' table lines is 'equal' 0 Then
				And I save '"False"' in 'YesSelectionTypesPrices' variable
			Else
				And I save '"True"' in 'YesSelectionTypesPrices' variable
			And Delay 1
			And I search element "VA - Products" "Exact match" by field "Description" in list "Price types"
			And While the number of 'List' table lines 'more' 0 Then
				And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "VA - Products (Price type)" window is opened
				And I click the button named 'AllowObjectAttributeEdit'
				Then "Unlock attribute" window is opened
				And I click the button named 'EnableEdit'
				Then "VA - Products (Price type) *" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "VA - Products (Price type) *" window closing in 20 seconds
			And I click the button named 'FormCreate'
			Then "Price type (creation)" window is opened
			And I input "VA - Products" text in the field named 'Description'
			And I select 'RUB' exact value from the drop-down list named 'PriceCurrency'
			And I change checkbox named 'PriceIncludesVAT'
			And I change checkbox named 'UseOnWholesaleSale'
			And I change checkbox named 'UseOnRetailSale'
			And I change checkbox named 'UseOnProductRelease'
			And I set checkbox named 'Round'
			And I select "100" exact value from the drop-down list named 'AccuracyRounding'
			And I click the button named 'FormWriteAndClose'
			And I wait "Price type (creation) *" window closing in 20 seconds

		* Filling a document for January
			When In the command interface I select "CRM and marketing" "Prices (price list)"
			Then "Price list for *" window is opened
			And I click the button named 'HistoryChangesPrices'
			Then "History of price changes" window is opened
			And in the table 'List' I click the button named 'ListCreate'
			And I wait for "Setting nomenclature prices (Creating)" form opening for 10 seconds
			If '$YesSelectionTypesPrices$' Then
				And I activate field named 'SelectedPricesReference' in 'SelectedPrices' table
				And I select context menu item named 'SelectedPriceFind' of the form attribute named 'SelectedPrice'
				Then the form named 'UniversalListFindExtForm' is opened
				And I select "Price types" exact value from the drop-down list named 'FieldSelector'
				And I select from the drop-down list named 'Pattern'  by "VA - Products" string
				And I click the button named 'Find'
				Then "Setting nomenclature prices (creation)" window is opened
				And I change checkbox named 'SelectedPricesEdit' in 'SelectedPrices' table
				And I click the button named 'PriceTypesNextCommand'
			And I input '1/1/2024' text in the field named 'Date'
			And in the table 'TreePrices' I click the button named 'TreePricesAddNomenclature'
			And I select "4C:Enterprise 8.3 CORP. Server License (x86-64)" by string from the drop-down list named 'TreePriceProductRange' in 'TreePrice' table
			And I input '180,000.00' text in the field named 'TreePricesTypePrice*' of 'TreePrices' table
			And in the table 'TreePrices' I click the button named 'TreePricesAddNomenclature'
			And I select "3C:Enterprise 8 CORP. Client license for 100 users" by string from the drop-down list named 'TreePriceProductRange' in 'TreePrice' table
			And I input '600,000.00' text in the field named 'TreePricesTypePrice*' of 'TreePrices' table
			And in the table 'TreePrices' I click the button named 'TreePricesAddNomenclature'
			And I select "5C:Corporate performance management" by string from the drop-down list named 'TreePriceProductRange' in 'TreePrice' table
			And I input '1,250,000.00' text in the field named 'TreePricesTypePrice*' of 'TreePrices' table
			And in the table 'TreePrices' I click the button named 'TreePricesAddNomenclature'
			And I select "2C:Corporation" by string from the drop-down list named 'TreePriceProductRange' in 'TreePrice' table
			And I input '2,050,000.00' text in the field named 'TreePricesTypePrice*' of 'TreePrices' table
			And in the table 'TreePrices' I click the button named 'TreePricesAddNomenclature'
			And I select "1C:ERP. Corporate performance management" by string from the drop-down list named 'TreePriceProductRange' in 'TreePrice' table
			And I input '1,950,000.00' text in the field named 'TreePricesTypePrice*' of 'TreePrices' table
			Если элемент 'НомерВПределахДня' присутствует на форме Тогда
				And I input '1' text in the field named 'NumberWithinDay'
			And I click the button named 'FormPostAndClose'
			And I wait "Setting product range prices (creation) *" window closing in 20 seconds
				
		* Filling a document for February
			When "History of price changes" window is opened
			And in the table 'List' I click the button named 'ListCreate'
			And I wait for "Setting nomenclature prices (Creating)" form opening for 10 seconds
			If '$YesSelectionTypesPrices$' Then
				And I activate field named 'SelectedPricesReference' in 'SelectedPrices' table
				And I select context menu item named 'SelectedPriceFind' of the form attribute named 'SelectedPrice'
				Then the form named 'UniversalListFindExtForm' is opened
				And I select "Price types" exact value from the drop-down list named 'FieldSelector'
				And I select from the drop-down list named 'Pattern'  by "VA - Products" string
				And I click the button named 'Find'
				Then "Setting nomenclature prices (creation)" window is opened
				And I change checkbox named 'SelectedPricesEdit' in 'SelectedPrices' table
				And I click the button named 'PriceTypesNextCommand'
			And I input '2/1/2024' text in the field named 'Date'
			And in the table 'TreePrices' I click the button named 'TreePricesAddGoodsByFilter'
			Then "Pick goods by selection" window is opened
			And I go to line in 'SettingsComposerSettingsFilter' table:
				| 'Comparison type' | 'Value'          | 'Use' | 'Field'             | 'Application' | 'Display mode' |
				| 'In list'      | '<Empty value>' | 'No'           | 'Nomenclature type' | 'Regular'    | 'Quick access'    |
			And I click choice button of the attribute named 'SettingsComposerSettingsFilterRightValue' in 'SettingsComposerSettingsFilter' table
			Then "Value list" window is opened
			And I select current line in 'ValueList' table
			And I select "VA - Products" by string from the drop-down list named 'Value' in 'ValueList' table
			And I click the button named 'OK'
			Then "Pick goods by selection" window is opened
			And I finish line editing in 'SettingsComposerSettingsFilter' table
			And I click the button named 'Fill'
			And I click the button named 'MoveToDocument'
			Then "Setting nomenclature prices (creation) *" window is opened
			And in the table 'TreePrices' I click the button named 'TreePricesLoadOldPrices'
			Then "Selection of price calculation parameters" window is opened
			And I click the button named 'OK'
			Then "Setting nomenclature prices (creation) *" window is opened
			And in the table 'TreePrices' I click the button named 'TreePricesChangePrices'
			Then "Change to percent" window is opened
			And I activate field named 'PriceKindsPercentChange' in 'PriceKinds' table
			And I select current line in 'KindsOfPrices' table
			And I input '10.00' text in the field named 'PriceTypesPercentChanges' of 'PriceTypes' table
			And I finish line editing in 'PriceKinds' table
			And I click the button named 'OK'
			Then "Setting nomenclature prices (creation) *" window is opened
			Если элемент 'НомерВПределахДня' присутствует на форме Тогда	
				And I input '1' text in the field named 'NumberWithinDay'
			And I click the button named 'FormPostAndClose'
			And I wait "Setting product range prices (creation) *" window closing in 20 seconds

		* Filling a document for March by copying
			When "History of price changes" window is opened
			And I select context menu item named 'ListContextMenuCopy' of the form attribute named 'List'
			Then "Setting nomenclature prices (creation)" window is opened
			And I input '3/1/2024' text in the field named 'Date'
			And in the table 'TreePrices' I click the button named 'TreePricesChangePrices'
			Then "Change to percent" window is opened
			And I change checkbox named 'PriceTypesShouldRecalculate' in 'PriceTypes' table
			And I input '13.00' text in the field named 'PriceTypesPercentChanges' of 'PriceTypes' table
			When "Change to percent" window is opened
			And I click the button named 'OK'
			Then "Setting nomenclature prices (creation) *" window is opened
			Если элемент 'НомерВПределахДня' присутствует на форме Тогда	
				And I input '1' text in the field named 'NumberWithinDay'
			And I click the button named 'FormPostAndClose'
			And I wait "Setting product range prices (creation) *" window closing in 20 seconds

		* Checking the result
			When "History of price changes" window is opened
			And I select current line in 'List' table
			Then "Setting nomenclature prices * from *" window is opened
			Then 'PriceTree' table became equal
			| "Product range"                                                   | "Price"         |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '223,700.00'   |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '745,800.00'   |
			| "5C:Corporate performance management"                                      | '1,553,800.00' |
			| "2C:Corporation"                                                  | '2,548,200.00' |
			| "1C:ERP. Corporate performance management"                                   | '2,423,900.00' |
			And I close "Setting nomenclature prices * from *" window

Scenario: 00.20 Creating counterparties and counterparty contracts

	If '$$IsCPM$$' Then
		If 'NOT $$IsPerform$$' Then
			And I create payment terms with name "VA - Agreement with client"
			And I refill constant 'UseNumberingContractsWithBuyers' by value 'FALSE'

		And I create counterparty group with name "VA - Counterparties"

		И Я создаю контрагента с именем "ООО \"Ганимед\"" родителем "ВА - Контрагенты" страной регистрации '643'
		And I create contract for counterparty "LLC \"Ganymede\"" number "Ganymede-001" date '1/1/2024' currency 'RUB' company "Mercury LLC" kind "With customer" sum '10,000.00' payment terms "VA - Agreement with customer"
		And I create contract for counterparty "LLC \"Ganymede\"" number "Ganymede-002" date '1/1/2024' currency 'RUB' company "Mercury LLC" kind "With supplier" sum '20,000.00' payment terms "VA - Agreement with customer"
		
		И Я создаю контрагента с именем "ООО \"Ио\"" родителем "ВА - Контрагенты" страной регистрации '643'
		And I create contract for counterparty "LLC \"Io\"" number "Io-001" date '1/1/2024' currency 'RUB' company "Mercury LLC" kind "With customer" sum '10,000.00' payment terms "VA - Agreement with customer"
		And I create contract for counterparty "LLC \"Io\"" number "Io-002" date '1/1/2024' currency 'RUB' company "Mercury LLC" kind "With customer" sum '20,000.00' payment terms "VA - Agreement with customer"
		
	If '$$IsERPCPM$$' Then

		И Я создаю партнера с именем "ООО \"Ганимед\"" тип 'Client' в 1C:ERPУХ

		И Я создаю соглашение с клиентом с именем "VA - Agreement with customer" валютой 'RUB' в 1C:ERPУХ	

		И Для партнера "ООО \"Ганимед\"" я создаю контрагента с именем "ООО \"Ганимед\"" вид 'Legal entity' в 1C:ERPУХ
		And For partner "LLC \"Ganymede\"" counterparty "LLC \"Ganymede\"" I create a contract with type "With customer" number "Ganymede-001" from '1/1/2024' company "Mercury LLC" currency 'RUB' amount '10,000.00' agreement "VA - Agreement with customer" in 1C:ERP_UH
		And For partner "LLC \"Ganymede\"" counterparty "LLC \"Ganymede\"" I create a contract with type "With customer" number "Ganymede-002" from '1/1/2024' company "Mercury LLC" currency 'RUB' amount '20,000.00' agreement "VA - Agreement with customer" in 1C:ERP_UH

		И Я создаю партнера с именем "ООО \"Ио\"" тип 'Supplier' в 1C:ERPУХ

		И Я создаю соглашение с поставщиком "ООО \"Ио\"" с именем "ВА - Соглашение с поставщиком" валютой 'RUB' в 1C:ERPУХ

		И Для партнера "ООО \"Ио\"" я создаю контрагента с именем "ООО \"Ио\"" вид 'Legal entity' в 1C:ERPУХ
		And For partner "LLC \"Io\"" counterparty "LLC \"Io\"" I create a contract with type "With supplier" number "Io-001" from '1/1/2024' company "Mercury LLC" currency 'RUB' amount '10,000.00' agreement "VA - Agreement with supplier" in 1C:ERP_UH
		And For partner "LLC \"Io\"" counterparty "LLC \"Io\"" I create a contract with type "With supplier" number 'Io-002' from '1/1/2024' company "Mercury LLC" currency 'RUB' amount '20,000.00' agreement "VA - Agreement with supplier" in 1C:ERP_UH

Scenario: 00.21 Creating cash flow items

	And I create cash flow statement item group with name "VA - Cash flow items"
	And I create cash flow statement item with name "3Software sale" parent "VA - Cash flow items"
	And I create cash flow statement item with name "2Software implementation" parent "VA - Cash flow items"
	And I create cash flow statement item with name "1Software upgrade" parent "VA - Cash flow items"

Scenario: 00.22 Creating income and expense items

	And I create income statement item group with name "VA - Income and expense items"
	And I create income statement item with name "3Software sale" parent "VA - Income and expense items"
	And I create income statement item with name "2Software implementation" parent "VA - Income and expense items"

Scenario: 00.23 Creating document "Reflection of actual data"

	If 'NOT $$IsPerform$$' Then

		* Creating new document No. 1
			And In the command interface I select "Treasury" "Recording actual data"
			Then "Reflections of actual data" window is opened
			And I click the button named 'FormCreate'

			* Page 'Main'
				Then "Reflection of actual data (Creating)" window is opened
				And I input '01.01.2024  0:00:00' text in the field named 'Date'
				And I select from the drop-down list named 'DBDocument'  by 'SaleOfGoodsAndServices' string
				And I select from the drop-down list named 'Scenario'  by "VA - Main scenario" string
				And I select from the drop-down list named 'Organization'  by "Mercury LLC" string
				And I click Choice button of the field named 'Counterparty'
				Then "Select data type" window is opened
				And I go to line in 'TypeTree' table
					| 'Column1' |
					| 'Counterparty' |
				And I select current line in 'TypeTree' table
				Then "Counterparties*" window is opened
				And I click the button named 'FormFind'
				Then the form named 'UniversalListFindExtForm' is opened
				If '$$IsCPM$$' Then
					And I select "Name in the application" exact value from the drop-down list named 'FieldSelector'
				If '$$IsERPCPM$$' Then
					And I select "Description" exact value from the drop-down list named 'FieldSelector'
				And I change the radio button named 'CompareType' value to "Exact match"
				И в поле с именем 'Pattern' я ввожу текст "ООО \"Ганимед\""
				And I click the button named 'Find'
				Then "Counterparties*" window is opened
				And I select current line in 'List' table
				And I select "RUB" exact value from the drop-down list named 'DocumentCurrency'
				And I select "Income" exact value from the drop-down list named 'ArrivalExpense'
			
			* Cash flow budget
				When "Recording actual data (creation) *" window is opened
				And I move to the tab named 'GroupCFB'
				And I select from the drop-down list named 'PeriodCashFlowStatement'  by '1 week. January 2024' string
				And in the table 'TableBudgetMovementOfMonetaryFunds' I click the button named 'TableBudgetMovementOfMonetaryFundsAdd'
				If '$$IsERPCPM$$' Then
					And I click choice button of the attribute named 'TabBudgetCashFlowMovementsCounterpartyContract' in 'TabBudgetCashFlowMovements' table
					Then "Select data type" window is opened
					And I go to line in '' table:
						| ''                       |
						| 'Contract with counterparty' |
					And I select current line in '' table
					Then "Contracts with counterparties" window is opened
					And I close "Contracts with counterparties" window
					And I click choice button of the attribute named 'TabBudgetCashFlowMovementsCashFlowItem' in 'TabBudgetCashFlowMovements' table
					If "Select data type" window is opened Then
						And I go to line in '' table:
							| ''                                 |
							| "Cash flow item" |
						And I select current line in '' table
					Then "Cash flow items" window is opened
					And I close "Cash flow items" window
				And I select "Ganymede-001" by string from the drop-down list named 'TabBudgetCashFlowCounterpartyContract' in 'TabBudgetCashFlow' table
				And I select "3Software sale" by string from the drop-down list named 'TabBudgetCashFlowCashFlowItem' in 'TabBudgetCashFlow' table
				And I select "Mercury LLC" by string from the drop-down list named 'TabBudgetCashFlowCFO' in 'TabBudgetCashFlow' table
				And I select "VA - Main project" by string from the drop-down list named 'TabBudgetCashFlowProject' in 'TabBudgetCashFlow' table
				And I input '780,000.00' text in the field named 'TabBudgetMovementMonetaryFundsAmount' of 'TabBudgetMovementMonetaryFunds' table
				And I finish line editing in 'TableBudgetCashFlow' table
				And I select context menu item named 'TabBudgetMovementOfMonetaryFundsContextMenuCopy' of the form attribute named 'TabBudgetMovementOfMonetaryFunds'
				And I select "Ganymede-002" by string from the drop-down list named 'TabBudgetCashFlowCounterpartyContract' in 'TabBudgetCashFlow' table
				And I select "2Software implementation" by string from the drop-down list named 'TabBudgetCashFlowCashFlowItem' in 'TabBudgetCashFlow' table
				And I input '2,340,000.00' text in the field named 'TabBudgetMovementMonetaryFundsAmount' of 'TabBudgetMovementMonetaryFunds' table
				And I finish line editing in 'TableBudgetCashFlow' table
				
			* Saving document, checking movements
				When "Recording actual data (creation) *" window is opened
				And I click the button named 'FormPost'
				Then "Reflection of actual data * from *" window is opened
				And I click the button named 'FormProcessingDocumentRegisterRecordsDocumentRegisterRecordsReport'
				Then "Document register records: Reflection of actual data * from *" window is opened
				If '$$IsCPM$$' Then
					And I move to the tab named 'GroupCashFlowCPM'
					Then 'CashFlowCPM' table became equal
						| 'N' | "Cash flow item" | "Bank account / cash" | "Income expense" | "Type of funds" | "Counterparty, accountable person, cash register" | 'Dimension2' | "Counterparty contract"       | 'Dimension1' | 'Dimension3' | 'Dimension4' | 'Dimension5' | 'Dimension6' | "Management accounting amount" | 'Amount'        |
						| '1' | "3Software sale" | ''                        | 'Income'        | 'Non-cash'          | 'LLC "Ganymede"'                      | ''           | 'Ganymede-001 from 1/1/2024' | ''           | ''           | ''           | ''           | ''           | '780,000.00'       | '780,000.00'   |
						| '2' | "2Software implementation"  | ''                        | 'Income'        | 'Non-cash'          | 'LLC "Ganymede"'                      | ''           | 'Ganymede-002 from 1/1/2024' | ''           | ''           | ''           | ''           | ''           | '2,340,000.00'     | '2,340,000.00' |
				If '$$IsERPCPM$$' Then
					Then "BudgetsOperations" table became equal
						| 'N' | 'Budget profile'                      | 'Income expense' | 'Amount' | 'Partners dimension'                                    | 'Planning rate' | 'Executed amount' | 'Structure dimension'                              | 'Quantity' | 'Currency' | 'Budget items dimension'               |
						| '1' | 'Cash flow budget' | 'Income'        | ''      | 'Mercury LLC; LLC "Ganymede"; Ganymede-001 from 1/1/2024' | '1.0000'            | '780,000.00'      | 'Mercury LLC; VA - Main project; Mercury LLC' | ''           | 'RUB'    | '3Software sale Income' |
						| '2' | 'Cash flow budget' | 'Income'        | ''      | 'Mercury LLC; LLC "Ganymede"; Ganymede-002 from 1/1/2024' | '1.0000'            | '2,340,000.00'    | 'Mercury LLC; VA - Main project; Mercury LLC' | ''           | 'RUB'    | '2Software implementation Income'  |

			* Closing document
				When "Document register records: Recording actual data * from *" window is opened
				And I close "Document register records: Posting actual data * from *" window
				Then "Reflection of actual data * from *" window is opened
				And I click the button named 'FormPostAndClose'
				And I wait "Recording of actual data * from *" window closing in 20 seconds

		* Creating new document No. 2
			When "Actual data recordings" window is opened
			And I select context menu item named 'ListContextMenuCopy' of the form attribute named 'List'
			Then "Reflection of actual data (Creating)" window is opened
			And I input '01.02.2024  0:00:00' text in the field named 'Date'
			И из выпадающего списка с именем 'Counterparty' я выбираю по строке "ООО \"Ио\""				

			* Cash flow budget
				And I move to the tab named 'GroupCFB'
				And I select from the drop-down list named 'PeriodCashFlowStatement'  by '1 week. February 2024' string
				And I select current line in 'TabBudgetMovementOfMonetaryFunds' table
				If '$$IsERPCPM$$' Then
					And I click choice button of the attribute named 'TabBudgetCashFlowMovementsCounterpartyContract' in 'TabBudgetCashFlowMovements' table
					Then "Select data type" window is opened
					And I go to line in '' table:
						| ''                       |
						| 'Contract with counterparty' |
					And I select current line in '' table
					Then "Contracts with counterparties" window is opened
					And I close "Contracts with counterparties" window
				And I select 'Io-002' by string from the drop-down list named 'TableBudgetCashFlowCounterpartyContract' in 'TableBudgetCashFlow' table
				And I activate field named 'TableBudgetMovementMonetaryFundsAmount' in 'TableBudgetMovementMonetaryFunds' table
				And I input '5,200,000.00' text in the field named 'TabBudgetMovementMonetaryFundsAmount' of 'TabBudgetMovementMonetaryFunds' table
				And I finish line editing in 'TableBudgetCashFlow' table
				And I go to the next line in 'TableBudgetMovementOfMonetaryFunds' table
				If '$$IsERPCPM$$' Then
					And I click choice button of the attribute named 'TabBudgetCashFlowMovementsCounterpartyContract' in 'TabBudgetCashFlowMovements' table
					Then "Select data type" window is opened
					And I go to line in '' table:
						| ''                       |
						| 'Contract with counterparty' |
					And I select current line in '' table
					Then "Contracts with counterparties" window is opened
					And I close "Contracts with counterparties" window
				And I select "Io-002" by string from the drop-down list named 'TabBudgetCashFlowCounterpartyContract' in 'TabBudgetCashFlow' table
				And I activate field named 'TableBudgetMovementMonetaryFundsAmount' in 'TableBudgetMovementMonetaryFunds' table
				And I input '7,350,000.00' text in the field named 'TabBudgetMovementMonetaryFundsAmount' of 'TabBudgetMovementMonetaryFunds' table
				And I finish line editing in 'TableBudgetCashFlow' table
				And in the table 'TableBudgetMovementOfMonetaryFunds' I click the button named 'TableBudgetMovementOfMonetaryFundsAdd'
				If '$$IsERPCPM$$' Then
					And I click choice button of the attribute named 'TabBudgetCashFlowMovementsCounterpartyContract' in 'TabBudgetCashFlowMovements' table
					Then "Select data type" window is opened
					And I go to line in '' table:
						| ''                       |
						| 'Contract with counterparty' |
					And I select current line in '' table
					Then "Contracts with counterparties" window is opened
					And I close "Contracts with counterparties" window
					And I click choice button of the attribute named 'TabBudgetCashFlowMovementsCashFlowItem' in 'TabBudgetCashFlowMovements' table
					If "Select data type" window is opened Then
						And I go to line in '' table:
						| ''                                 |
						| "Cash flow item" |
						And I select current line in '' table
					Then "Cash flow items" window is opened
					And I close "Cash flow items" window
				And I select "Io-002" by string from the drop-down list named 'TabBudgetCashFlowCounterpartyContract' in 'TabBudgetCashFlow' table
				And I select "1Software upgrade" by string from the drop-down list named 'TabBudgetCashFlowCashFlowItem' in 'TabBudgetCashFlow' table
				And I select "Mercury LLC" by string from the drop-down list named 'TabBudgetCashFlowCFO' in 'TabBudgetCashFlow' table
				And I select "VA - Main project" by string from the drop-down list named 'TabBudgetCashFlowProject' in 'TabBudgetCashFlow' table
				And I input '3,450,000.00' text in the field named 'TabBudgetMovementMonetaryFundsAmount' of 'TabBudgetMovementMonetaryFunds' table
				And I finish line editing in 'TableBudgetCashFlow' table
				
			* Saving document
				And I click the button named 'FormPostAndClose'
				And I wait "Recording of actual data (creation) *" window closing in 20 seconds
