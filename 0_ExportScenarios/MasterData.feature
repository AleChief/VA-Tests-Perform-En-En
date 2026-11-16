#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for creating reference data

Scenario: I create unit of measure with code 'TheCode' if it does not exist, name 'TheName', full name 'TheNameFull'

	* Opening list form
		And I open 'UnitOfMeasureClassifier' catalog default form
		Then "Classifier of Measurement Units" window is opened

	* Creating element if it doesn't exist
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheCode]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		If number of 'List' table lines is 'equal' 0 Then
			If '$$IsPerform$$' Then
				And I click the button named 'FormCreate'
				Then "Classifier of Measurement Units (create)" window is opened
				And I input '[TheCode]' text in the field named 'Code'
				And I input '[TheName]' text in the field named 'Description'
				And I input '[TheNameFull]' text in the field named 'DescriptionFull'
				And I click the button named 'FormWriteAndClose'
				And I wait "Classifier of Measurement Units (create) *" window closing in 20 seconds
			Else
				And I click the button named 'FormPickFromTemplate'
				Then "All-Russian Classifier of Measurement Units" window is opened
				And I input '[TheCode]' text in the field named 'SearchString'
				And I click the button named 'SearchForward'
				And Delay 1
				And I click the button named 'FormSelect'
				Then "Classifier of Measurement Units (create)" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Classifier of Measurement Units (create)" window closing in 20 seconds
				Then "All-Russian Classifier of Measurement Units" window is opened
				And I click the button named 'Close'

	* Closing a list
		When "Classifier of Measurement Units" window is opened
		And I close "Classifier of Measurement Units" window

Scenario: I create currency with digital code 'TheCodeDigital' symbol code 'TheCodeSymbol' and name 'TheCurrencyName' if it does not exist

	* Opening list form
		And In the command interface I select "General catalogs and settings" "Currencies"
		Then "Currencies" window is opened

	* Creating currency if it doesn't exist
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Numeric code" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheCodeDigital]' text in the field named 'Pattern'
		And I click the button named 'Find'
		If number of 'Currencies' table lines is 'equal' 0 Then
			And I click the button named 'CreateCurrency'
			Then "Currency (create)" window is opened
			And I save the current window title as 'WindowTitle'
		Else
			And I select current line in 'Currencies' table
			And I save the current window title as 'WindowTitle'
		And I input '[TheCurrencyName]' text in the field named 'DescriptionFull'
		And I input '[TheCodeDigital]' text in the field named 'Code'
		And I input '[TheCodeSymbol]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "$WindowTitle$ *" window closing in 20 seconds

	* Closing a list
		When "Currencies" window is opened
		And I close "Currencies" window

Scenario: I set currency rate 'TheCodeSymbol' on date 'TheCourseDate' to value 'TheCourseValue' repetition 'TheCourseRepetition' base currency 'TheBaseCurrencyCodeSymbol'

	* Opening currency
		And In the command interface I select "General catalogs and settings" "Currencies"
		Then "Currencies" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Alphabetic code" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheCodeSymbol]' text in the field named 'Pattern'
		And I click the button named 'Find'
		Then the number of 'Currencies' table lines is 'equal' 1
		And I select current line in 'Currencies' table
		Then "* (Currency)" window is opened

	* Setting exchange rate
		And In this window I click command interface button "Exchange rates"
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Effective on" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheCourseDate]' text in the field named 'Pattern'
		And I click the button named 'Find'
		If number of 'List' table lines is 'equal' 0 Then
			And I click the button named 'FormCreate'
		Else
			And I select current line in 'List' table
		Then "Exchange rate*" window is opened
		And I input '[TheCourseDate]' text in the field named 'Period'
		If '$$IsCPM$$' Then
			And I input '[TheCourseValue]' text in the field named 'Rate'
			And I input '[TheCourseRepetition]' text in the field named 'Кратность'
		ElseIf '$$IsERPCPM$$' Then
			And I input '[TheCourseRepetition]' text in the field named 'RateDenominator'
			And I select '[TheCodeSymbol]' exact value from the drop-down list named 'Currency'
			And I input '[TheCourseValue]' text in the field named 'RateNumerator'
			And I select '[TheBaseCurrencyCodeSymbol]' exact value from the drop-down list named 'BasicCurrency'
		And I click the button named 'FormWriteAndClose'
		And I wait "Exchange rate*" window closing in 20 seconds

	* Closing windows
		Then "* (Currency)" window is opened
		And I close "* (Currency)" window
		Then "Currencies" window is opened
		And I close "Currencies" window

Scenario: I create organizational unit type with name 'TheBusinessUnitName'

	* Opening a reference form
		And I open 'BusinessUnitKinds' catalog default form

	* Deleting an element
		Then "Business unit kinds" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheBusinessUnitName]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		Then "Business unit kinds" window is opened
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "* (Business unit kind)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Business unit kind) *" window closing in 20 seconds
	
	* Creating element
		And I click the button named 'FormCreate'
		Then "Business unit kind (create)" window is opened
		And I input '[TheBusinessUnitName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Business unit kind (create) *" window closing in 20 seconds

	* Closing a list
		When "Business unit kinds" window is opened
		And I close "Business unit kinds" window

Scenario: I find company with name 'TheBusinessUnitName'
	If '$$IsCPM$$' Then
		And In the command interface I select "Budgeting, reporting, and analysis" "Business units"
	If '$$IsERPCPM$$' Then
		And In the command interface I select "Budgeting, reporting, and analysis" "Companies"

	* Opening company
		When "Business units" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		If '$$IsERPCPM$$' Then
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
		ElseIf '$$IsPerform$$' Then
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
		ElseIf '$$IsCPM$$' Then
			And I select "Name in the application" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheBusinessUnitName]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "At the beginning of the line"
		And I click the button named 'Find'
		Then "Business units" window is opened
		If number of 'List' table lines is 'more' 0 Then
			And I select current line in 'List' table
			Then "* (Business unit)" window is opened

Scenario: I create company with name 'TheBusinessUnitName' type 'TheBusinessUnitType' kind 'TheBusinessUnitKind' taxation 'TheTaxation'

	If '$$IsCPM$$' Then
		And In the command interface I select "Budgeting, reporting, and analysis" "Business units"
	If '$$IsERPCPM$$' Then
		And In the command interface I select "Budgeting, reporting, and analysis" "Companies"

	* Deleting the current element
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		If '$$IsERPCPM$$' Then
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
		ElseIf '$$IsPerform$$' Then
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
		ElseIf '$$IsCPM$$' Then
			And I select "Name in the application" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "At the beginning of the line"
		And I input '[TheBusinessUnitName]' text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Business units" window is opened
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			And I select current line in 'List' table
			When "* (Business unit)" window is opened
			If '$$IsCPM$$' Then
				* Deleting all subdivisions
					And In this window I click command interface button "Departments"
					And I click the button named 'FormListSettings'
					And I set filter in list form "Description" "Does not begin with" 'Delete_'
					And While the number of 'List' table lines 'more' 0 Then
						And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
						And I select current line in 'List' table
						Then "* (Department)" window is opened
						And I input 'UID' variable value in the field named 'Description'
						And I click the button named 'FormWriteAndClose'
					When "* (Business unit)" window is opened
					And I click the button named 'FormListSettings'
					And I remove all filters in list form
					And In this window I click command interface button "IsMain"
			* Renaming company
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I input 'UID' variable value in the field named 'Description'
				And I input 'UID' variable value in the field named 'DescriptionFull'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Business unit) *" window closing in 20 seconds

	* Creating new company
		If '$$IsPerform$$' Then
			And I click the button named 'FormCreate'
			Then "Business unit (create)" window is opened
			If '"[TheBusinessUnitType]"="SelectRF"' Then
				And I select "Company" exact value from the drop-down list named 'CompanyTypeCPM'
			ElseIf '"[TheBusinessUnitKind]"="SelectEl"' Then
				And I select "Eliminating business unit" exact value from the drop-down list named 'CompanyTypeCPM'
			ElseIf '"[TheBusinessUnitType]"="SelectCFO"' Then
				And I select "Financial responsibility center or consolidating business unit" exact value from the drop-down list named 'CompanyTypeCPM'
		ElseIf '$$IsERPCPM$$' Then
			If '"[TheBusinessUnitType]"="SelectRF"' Then
				If '"[TheBusinessUnitKind]"="SelectLE"' Then
					And I click the button named 'LegalEntity'
				Else
					And I click the button named 'IndividualEntrepreneur'
				If the field named 'RegistrationCountry' exists on the form Then
					And I select from the drop-down list named 'RegistrationCountry'  by "643" string
			ElseIf '"[TheBusinessUnitType]"="SelectCFO"' Then
				If '"[TheBusinessUnitKind]"="SelectEl"' Then
					And I click the button named 'FormCreateEliminating'
				Else
					And I click the button named 'FormCreateConsolidating'
				If the field named 'RegistrationCountry' exists on the form Then
					And I select from the drop-down list named 'RegistrationCountry'  by "643" string
			ElseIf '"[TheBusinessUnitType]"="SelectInstance"' Then
				// No examples
		ElseIf '$$IsCPM$$' Then
			And I click the button named 'CreateNewCompany'
			Then "Company type" window is opened
			And I click the button named '[TheBusinessUnitType]'
			If '"[TheBusinessUnitType]"="SelectRF"' Then
				When "Company kind" window is opened
				And I click the button named '[TheBusinessUnitKind]'
				If '"[TheBusinessUnitKind]"="SelectLE"' Then
					When "Legal entity" window is opened
					And I click the button named '[TheTaxation]'
			ElseIf '"[TheBusinessUnitType]"="SelectInstance"' Then
				// No examples
			ElseIf '"[TheBusinessUnitType]"="SelectCFO"' Then
				If '"[TheBusinessUnitKind]"="SelectEl"' Then
					And I select "Eliminating business unit" exact value from the drop-down list named 'CompanyTypeCPM'
			And I input '[TheBusinessUnitName]' text in the field named 'DescriptionShort'
		And I input '[TheBusinessUnitName]' text in the field named 'Description'
		And I input '[TheBusinessUnitName]' text in the field named 'DescriptionFull'
		And I click the button named 'FormWriteAndClose'
		And I wait "Compan *" window closing in 20 seconds

	* Closing a list form
		When "Business units" window is opened
		And I close "Business units" window

Scenario: I create subdivision with name 'TheSubdivisionName' for company 'TheBusinessUnitName'

	* Opening company list
		And In the command interface I select "Budgeting, reporting, and analysis" "Business units"

	* Opening company
		When "Business units" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		If '$$IsERPCPM$$' Then
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
		ElseIf '$$IsPerform$$' Then
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
		ElseIf '$$IsCPM$$' Then
			And I select "Name in the application" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheBusinessUnitName]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "At the beginning of the line"
		And I click the button named 'Find'
		Then "Business units" window is opened
		If number of 'List' table lines is 'more' 0 Then
			And I select current line in 'List' table
			Then "* (Business unit)" window is opened
			And In this window I click command interface button "Departments"
			When "* (Business unit)" window is opened
			And I click the button named 'FormFind'
			Then the form named 'UniversalListFindExtForm' is opened
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
			And I input '[TheSubdivisionName]' text in the field named 'Pattern'
			And I click the button named 'Find'
			And While the number of 'List' table lines 'more' 0 Then
				* Marking for deletion
					And I delete current row in list 'List'
				* Renaming subdivision
					And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
					And I select current line in 'List' table
					Then "* (Department)" window is opened
					And I input 'UID' variable value in the field named 'Description'
					And I click the button named 'FormWriteAndClose'
					And I wait "* (Department) *" window closing in 20 seconds
	
	* Creating an element
		When "* (Business unit)" window is opened
		And I click the button named 'FormCreate'
		Then "Department (create)" window is opened
		And I input '[TheSubdivisionName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Department (create) *" window closing in 20 seconds

	* Closing company
		When "* (Business unit)" window is opened
		And I close "* (Business unit)" window

	* Closing company list
		When "Business units" window is opened
		And I close "Business units" window

Scenario: I select value 'TheValuesName' for attribute 'TheAttributeName' for company 'TheBusinessUnitName'

	If '$$IsCPM$$' Then
		And In the command interface I select "Budgeting, reporting, and analysis" "Business units"
	If '$$IsERPCPM$$' Then
		And In the command interface I select "Budgeting, reporting, and analysis" "Companies"

	* Opening company
		When "Business units" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		If '$$IsERPCPM$$' Then
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
		ElseIf '$$IsPerform$$' Then
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
		ElseIf '$$IsCPM$$' Then
			And I select "Name in the application" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheBusinessUnitName]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "At the beginning of the line"
		And I click the button named 'Find'
		Then "Business units" window is opened
		If number of 'List' table lines is 'more' 0 Then
			And I select current line in 'List' table
			Then "* (Business unit)" window is opened
			And I expand the group named 'GroupConsolidationParametersCPM'
			And I select from the drop-down list named '[TheAttributeName]'  by '[TheValuesName]' string
			And I click the button named 'FormWriteAndClose'
			And I wait "* (Business unit) *" window closing in 20 seconds

	* Closing company list
		When "Business units" window is opened
		And I close "Business units" window

Scenario: I enter value 'TheValuesName' for attribute 'TheAttributeName' for company 'TheBusinessUnitName'
	* Finding company
		And I find company with name '[TheBusinessUnitName]'
	
	* Entering value for attribute
		And I input '[TheValuesName]' text in the field named '[TheAttributeName]'
		And I move to the next attribute
		And I click the button named 'FormWriteAndClose'
		And I wait "* (Business unit) *" window closing in 20 seconds

Scenario: I specify TIN 'TheTIN', RRC 'TheRRC', OGRN 'TheOGRN', registration date 'TheRegistrationDate' for company with name 'TheBusinessUnitName'
	* Finding company
		And I find company with name '[TheBusinessUnitName]'
	
	* Entering values
		And I select current line in "List" table
		And I input '[TheTIN]' text in the field named 'TIN'
		And I move to the next attribute
		And I input '[TheRRC]' text in the field named 'KPP'
		And I move to the next attribute
		And I input '[TheOGRN]' text in 'OGRN' field
		And I move to the next attribute
		And I input '[TheRegistrationDate]' text in the field named 'DateRegistration'
		And I move to the next attribute
		And I click the button named 'FormWrite'
		Then the form attribute named "TIN" became equal to '[TheTIN]'
		Then the form attribute named "RRC" became equal to '[TheRRC]'
		Then the form attribute named "OGRN" became equal to '[TheOGRN]'
		Then the form attribute named "RegistrationDate" became equal to '[TheRegistrationDate]'
		And I click the button named 'FormWriteAndClose'
		And I wait "* (Business unit) *" window closing in 20 seconds

Scenario: I create bank account 'TheBank' 'TheBankAccount' for company 'TheBusinessUnitName'
	* Creating element
		If '$$IsCPM$$' Then
			And In the command interface I select "Budgeting, reporting, and analysis" "Business units"
			And I click the button named 'FormFind'
			Then 'Find' window is opened
			And I input '[TheBusinessUnitName]' text in the field named 'Pattern'
			And I click the button named 'Find'
			And I select current line in "List" table
			And In this window I click command interface button 'Bank accounts'
			And I click the button named 'CreateBankAccount'
			And I select from the drop-down list named "Bank"  by '[TheBank]' string
			And I move to the next attribute
			And I input '[TheBankAccount]' text in the field named 'AccountNumber'
			And I click the button named 'FormCommandSaveAndClose'
			And I wait 'Bank account (create) *' window closing in 20 seconds
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Budgeting, reporting, and analysis" "Companies"
			And I click the button named 'FormFind'
			Then 'Find' window is opened
			And I input '[TheBusinessUnitName]' text in the field named 'Pattern'
			And I click the button named 'Find'
			And I select current line in "List" table
			And In this window I click command interface button 'Bank accounts'
			And in the table "List" I click the button named 'ListCreate'
			Then 'Company bank account (create)' window is opened
			And I input '[TheBankAccount]' text in the field named 'AccountNumber'
			And I click the button named 'FormWriteAndClose'
			And I wait 'Company bank account (create) *' window closing in 20 seconds

Scenario: I create relation to group with name 'TheRelationsToGroupName' and kind 'TheRelationsToGroupKind'

	* Opening a reference form
		And I open 'CounterpartiesGroups' catalog default form

	* Deleting an element
		Then "Company statuses for consolidation" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheRelationsToGroupName]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		Then "Company statuses for consolidation" window is opened
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "* (Company statuses for consolidation)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Company statuses for consolidation) *" window closing in 20 seconds
	
	* Creating element
		And I click the button named 'FormCreate'
		Then "Company statuses for consolidation (create)" window is opened
		And I input '[TheRelationsToGroupName]' text in the field named 'Description'
		And I select '[TheRelationsToGroupKind]' exact value from the drop-down list named 'GroupRelationType'
		And I click the button named 'FormWriteAndClose'
		And I wait "Company statuses for consolidation (create) *" window closing in 20 seconds

	* Closing a list
		When "Company statuses for consolidation" window is opened
		And I close "Company statuses for consolidation" window

Scenario: I create nomenclature folder with name 'TheProductGroupName'

	* Opening a list
		If sections panel contains 'Catalogs' command Then
			And In the command interface I select "Catalogs" "Product range"
		Else
			And In the command interface I select "Quick menu" "Product range"

	* Deleting the current element
		And I search element '[TheProductGroupName]' "At the beginning of the line" by field "Description" in list "Product range"
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				When "* (Product range)" window is opened
				Then I input 'UID' variable value in the field named 'Description'
				Если элемент 'Parent' присутствует на форме Тогда
					And I input '' text in the field named 'Parent'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Product range)" window closing in 20 seconds

	* Creating a new element
		When "Product range" window is opened
		And I click the button named 'FormCreateFolder'
		Then "Product range (create group)" window is opened
		And I input '[TheProductGroupName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Product range (create group) *" window closing in 20 seconds

	* Closing a list
		When "Product range" window is opened
		And I close "Product range" window

Scenario: I create price type with name 'TheName' currency 'TheCurrency'

	* Opening a reference form
		And I open 'ProductsPricesTypes' catalog default form

	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Product range price types"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "* (Product range price type)" clearing
	
	* Creating element
		And I click the button named 'FormCreate'
		Then "Product range price type (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		Если элемент 'CurrencyPrice' присутствует на форме Тогда
			And I select '[TheCurrency]' exact value from the drop-down list named 'CurrencyPrice'
		Если элемент 'PriceIncludesVAT' присутствует на форме Тогда
			And I change checkbox named 'PriceIncludesVAT'
		And I click the button named 'FormWriteAndClose'
		And I wait "Product range price type (create) *" window closing in 20 seconds

	* Closing a list
		When "Product range price types" window is opened
		And I close "Product range price types" window

Scenario: I create payment terms with name 'TheName'

	* Opening list form
		And In the command interface I select "Liability management" "Payment terms"

	* Deleting the current element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Payment terms"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "* (Payment condition)" clearing

	* Creating an element
		Then "Payment terms" window is opened
		And I click the button named 'FormCreate'
		Then "Payment condition (creation)" window is opened
		And in the table 'PaymentStages' I click the button named 'PaymentStagesAdd'
		And I select "Postpayment (after base date)" exact value from the drop-down list named 'PaymentStagesPaymentVariant' in 'PaymentStages' table
		And I select "60" exact value from the drop-down list named 'StepsPaymentDueDate' in 'StepsPayment' table
		And I input '100' text in the field named 'StepsPaymentPercentPayment' of 'StepsPayment' table
		And I finish line editing in 'PaymentStages' table
		And I change checkbox named 'AutoName'
		And I input '[TheName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Payment condition (creation) *" window closing in 20 seconds

	* Closing a list
		Then "Payment terms" window is opened
		And I close "Payment terms" window

Scenario: I create payment terms advance 'S1'\'P1' and postpayment 'S2'\'P2'

	* Opening list form
		And In the command interface I select "Liability management" "Payment terms"

	* Deleting the current element
		And I search element "Аванс [P1]% за [S1] к.д., Постоплата [P2]% через [S2] к.д." "Anywhere in the line" by field "Description" in list "Payment terms"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I remove checkbox named 'AutoName'
			And I click the button named 'FormWrite'
			And I delete current element in window "* (Payment condition)" clearing

	* Creating an element
		Then "Payment terms" window is opened
		And I click the button named 'FormCreate'
		Then "Payment condition (creation)" window is opened
		And in the table 'PaymentStages' I click the button named 'PaymentStagesAdd'
		And I select "Advance (before base date)" exact value from the drop-down list named 'PaymentStagesPaymentVariant' in 'PaymentStages' table
		And I input '[S1]' text in the field named 'StagesPaymentDueDate' of 'StagesPayment' table
		And I input '[P1]' text in the field named 'StagesPaymentPercentPayment' of 'StagesPayment' table
		And I finish line editing in 'PaymentStages' table
		If 'NOT IsBlankString("[S2]")' Then
			And in the table 'PaymentStages' I click the button named 'PaymentStagesAdd'
			And I select "Postpayment (after base date)" exact value from the drop-down list named 'PaymentStagesPaymentVariant' in 'PaymentStages' table
			And I input '[S2]' text in the field named 'StagesPaymentDueDate' of 'StagesPayment' table
			And I input '[P2]' text in the field named 'StagesPaymentPercentPayment' of 'StagesPayment' table
			And I finish line editing in 'PaymentStages' table
		And I click the button named 'FormWrite'
		And I save the value of the field named 'Description' as 'ConditionPayment'
		And I click the button named 'FormWriteAndClose'
		And I wait "Payment condition (creation) *" window closing in 20 seconds

	* Closing a list
		Then "Payment terms" window is opened
		And I close "Payment terms" window

Scenario: I create counterparty group with name 'TheName'

	* Opening list form
		If '$$IsPerform$$' Then
			And In the command interface I select "Quick menu" "Counterparties"
			And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Counterparties"
		Else
			And In the command interface I select "Catalogs" "Counterparties"
			And I search element '[TheName]' "At the beginning of the line" by field "Name in the application" in list "Counterparties"
	
	* Deleting the current element
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "* (Counterparties)" clearing

	* Creating a new element
		And I click the button named 'FormCreateFolder'
		Then "Counterparties (create group)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Counterparties (create group) *" window closing in 20 seconds

	* Closing a list
		When "Counterparties" window is opened
		And I close "Counterparties" window

Scenario: I create counterparty with name 'TheName' parent 'TheParent' registration country 'TheCountry'

	* Opening list form
		If '$$IsPerform$$' Then
			And In the command interface I select "Quick menu" "Counterparties"
			And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Counterparties"
		Else
			And In the command interface I select "Catalogs" "Counterparties"
			And I search element '[TheName]' "At the beginning of the line" by field "Name in the application" in list "Counterparties"

	* Deleting the current element
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			And I select current line in 'List' table
			When "* (Counterparty)" window is opened
			* Deleting all contracts
				And In this window I click command interface button "Contracts"
				And I click the button named 'FormListSettings'
				And I set filter in list form "Description" "Does not begin with" 'Delete_'
				And While the number of 'List' table lines 'more' 0 Then
					And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
					And I select current line in 'List' table
					Then "*" window is opened
					And I input 'UID' variable value in the field named 'Description'
					And I click the button named 'FormWrite'
					Then "*" window is opened
					And I close "*" window
				And I click the button named 'FormListSettings'
				And I remove all filters in list form
				And In this window I click command interface button "IsMain"
			* Deleting counterparty
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I input 'UID' variable value in the field named 'Description'
				If '$$IsPerform$$' Then
					And I click the button named 'FormWriteAndClose'
				Else
					And I click the button named 'FormCommandSaveAndClose'
				And I wait "* (Counterparty)" window closing in 20 seconds

	* Creating a new element
		And I click the button named 'FormCreate'
		Then "Counterparty (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I select from the drop-down list named 'Parent'  by '[TheParent]' string
		And I select from the drop-down list named 'RegistrationCountry'  by '[TheCountry]' string
		If '$$IsPerform$$' Then
			And I click the button named 'FormWriteAndClose'
		Else
			And I click the button named 'FormCommandSaveAndClose'
		And I wait "Counterparty (create) *" window closing in 20 seconds

	* Closing a list
		When "Counterparties" window is opened
		And I close "Counterparties" window

Scenario: I create bank account 'TheBank' 'TheBankAccount' for counterparty with name 'TheName'
	* Creating element
		If '$$IsCPM$$' Then
			And In the command interface I select 'Catalogs' 'Counterparties'
			And I click the button named 'FormFind'
			Then 'Find' window is opened
			And I input '[TheName]' text in the field named 'Pattern'
			And I click the button named 'Find'
			Then 'Counterparties' window is opened
			And I select current line in "List" table
			And In this window I click command interface button 'Bank accounts'
			And I click the button named 'Create'
			Then 'Bank account (create)' window is opened
			And I select from the drop-down list named "Bank"  by '[TheBank]' string
			And I input '[TheBankAccount]' text in the field named 'AccountNumber'
			And I click the button named 'FormCommandSaveAndClose'
			And I wait 'Bank account (create) *' window closing in 20 seconds
		ElseIf '$$IsERPCPM$$' Then
			And In the command interface I select 'General catalogs and settings' 'Counterparties'
			When 'Counterparties (legal or natural persons)' window is opened
			And in the table "List" I click the button named 'ListFind'
			Then 'Find' window is opened
			And I input '[TheName]' text in the field named 'Pattern'
			And I click the button named 'Find'
			Then 'Counterparties (legal or natural persons)' window is opened
			And I select current line in "List" table
			And In this window I click command interface button 'Bank accounts'
			And I click the button named 'FormCreate'
			Then 'Bank account (create)' window is opened
			And I input '[TheBankAccount]' text in the field named 'AccountNumber'
			And I click the button named 'FormWriteAndClose'
			And I wait 'Bank account (create) *' window closing in 20 seconds

Scenario: I specify TIN 'TheTIN' and RRC 'TheRRC' for counterparty with name 'TheName'
		If '$$IsCPM$$' Then
			And In the command interface I select 'Catalogs' 'Counterparties'
			And I click the button named 'FormFind'
			Then 'Find' window is opened
			And I input '[TheName]' text in the field named 'Pattern'
			And I click the button named 'Find'
			Then 'Counterparties' window is opened
			And I select current line in "List" table
			And I input '[TheTIN]' text in the field named 'TIN'
			And I move to the next attribute
			And I input '[TheRRC]' text in the field named 'KPP'
			And I move to the next attribute
			And I click the button named 'FormWrite'
			If '1C:Enterprise' window is opened Then
				And I click 'Save' button
			Then the form attribute named "TIN" became equal to '[TheTIN]'
			Then the form attribute named "RRC" became equal to '[TheRRC]'

		ElseIf '$$IsERPCPM$$' Then
			And In the command interface I select 'General catalogs and settings' 'Counterparties'
			When 'Counterparties (legal or natural persons)' window is opened
			And in the table "List" I click the button named 'ListFind'
			Then 'Find' window is opened
			And I input '[TheName]' text in the field named 'Pattern'
			And I click the button named 'Find'
			Then 'Counterparties (legal or natural persons)' window is opened
			And I select current line in "List" table
			And I input '[TheTIN]' text in the field named 'TIN'
			And I move to the next attribute
			If '1C:Enterprise' window is opened Then
				And I click the button named 'Button0'
			And I input '[TheRRC]' text in the field named 'KPP'
			And I move to the next attribute
			If '1C:Enterprise' window is opened Then
				And I click the button named 'Button0'
			And I click the button named 'FormWrite'
			Then the form attribute named "TIN" became equal to '[TheTIN]'
			Then the form attribute named "RRC" became equal to '[TheRRC]'

Scenario: I create contract for counterparty 'TheName' number 'TheNumber' date 'TheDate' currency 'TheCurrency' company 'TheBusinessUnit' kind 'TheContractKind' sum 'TheSum' payment terms 'TheTermsOfPayment'

	* Opening list form
		If '$$IsPerform$$' Then
			And In the command interface I select "Quick menu" "Counterparties"
			And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Counterparties"
		Else
			And In the command interface I select "Catalogs" "Counterparties"
			And I search element '[TheName]' "At the beginning of the line" by field "Name in the application" in list "Counterparties"

	* Finding counterparty
		And the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table
		Then "* (Counterparty)" window is opened
		And In this window I click command interface button "Contracts"

	* Deleting the current element
		And I search element "[TheNumber] from [TheDate]" "At the beginning of the line" by field "Description" in list "* (Counterparty)"
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "*" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWrite'
				Then "*" window is opened
				And I close "*" window

	* Creating an element
		When "* (Counterparty)" window is opened
		And I click the button named 'FormCreate'
		If '$$IsPerform$$' Then
			When "Contract (create)*" window is opened
			And I select "TheContractKind" exact value from the drop-down list named 'TypeOfAgreement'
		Else
			Then "Select contract type" window is opened
			And I go to line in 'TypesOfContracts' table:
				| "Contract kind"     |
				| '[TheContractKind]' |
			And I select current line in 'KindsOfContracts' table
		Then "* (create)*" window is opened
		And I input '[TheNumber]' text in the field named 'Number'
		And I input '[TheDate]' text in the field named 'Date'
		And I input "[TheNumber] from [TheDate]" text in the field named 'Description'
		And I select from the drop-down list named 'Organization'  by '[TheBusinessUnit]' string
		And I select '[TheCurrency]' exact value from the drop-down list named 'ARAPCurrency'
		If '$$IsPerform$$' Then
			And I input '[TheSum]' text in the field named 'Sum'
			And I click the button named 'FormWriteAndClose'
		Else
			If checkbox named "FixedAmountContract" is equal to "False" Then
				And I change checkbox named 'FixedContractAmount'
			And I input '[TheSum]' text in the field named 'AmountContract'
			And I move to the tab named 'GroupCalculations'
			And I select from the drop-down list named 'PaymentCondition'  by '[TheTermsOfPayment]' string
			And I click the button named 'FormPostAndClose'
		And I wait "Contract (create) *" window closing in 20 seconds

	* Closing forms
		When "* (Counterparty)" window is opened
		And I close "* (Counterparty)" window
		Then "Counterparties" window is opened
		And I close "Counterparties" window

Scenario: I create nomenclature with name 'TheProductName' parent 'TheProductParent' nomenclature kind 'TheProductKind' article 'TheProductID'

	* Opening a list
		If '$$IsPerform$$' Then
			And In the command interface I select "Quick menu" "Product range"
		ElseIf '$$IsCPM$$' Then
			And In the command interface I select "Catalogs" "Product range"
		ElseIf '$$IsERPCPM$$' Then
			And In the command interface I select "Quick menu" "Product range"
			And I remove checkbox named 'UseFilters'
		Then "Product range" window is opened

	* Deleting the current element
		If '$$IsCPM$$' Then
			And I search element '[TheProductName]' "At the beginning of the line" by field "Description" in list "Product range"
			And While the number of 'List' table lines 'more' 0 Then
				And I select current line in 'List' table
				And I delete current element in window "* (Product range)" clearing 'Product ID'
		ElseIf '$$IsERPCPM$$' Then
			And Delay 1
			And I click Clear button of the field named 'SearchStringProductRange'
			And I input '[TheProductName]' text in the field named 'SearchStringProductRange'
			And I click the button named 'Find'
			If the window with 'Search' header appeared in 1 seconds Then
				And I click the button named 'Button0'
			Then "Product range" window is opened
			And While the number of 'ListAdvancedSearchProducts' table lines 'more' 0 Then
				* Marking for deletion
					If the current row in 'ListAdvancedSearchProducts' table is not marked for deletion Then
						And I select context menu item named 'ListAdvancedSearchProductsContextMenuSetDeletionMark' of the form attribute named 'ListAdvancedSearchProducts'
						Then "1C:Enterprise" window is opened
						And I click the button named 'Button0'
				* Renaming
					And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
					And I select current line in 'ListAdvancedSearchProducts' table
					When "* (Product range)" window is opened
					And I move to the tab named 'PageProductAttributes'
					If the window with 'Useful tip' header appeared in 1 seconds Then
						And I click the button named 'Button0'
					When "* (Product range)" window is opened
					Then I input 'UID' variable value in the field named 'Description'
					And I input ' ' text in the field named 'SKU'
					And I click the button named 'FillDescriptionForPrintByTemplate'
					And I click the button named 'FormWriteAndClose'
					And I wait "* (Product range)" window closing in 20 seconds
					If the window with 'Search' header appeared in 1 seconds Then
						And I click the button named 'Button0'

	* Creating a new element
		When "Product range" window is opened
		If '$$IsCPM$$' Then
			And I click the button named 'FormCreate'
			Then "Product range (create)" window is opened
			And I input '[TheProductName]' text in the field named 'Description'
			And I input '[TheProductID]' text in the field named 'SKU'
			And I select from the drop-down list named 'Parent'  by '[TheProductParent]' string
			And I select from the drop-down list named 'UnitOfMeasure'  by "PCs" string
			If 'NOT $$IsPerform$$' Then
				And I select from the drop-down list named 'ProductKind'  by '[TheProductKind]' string
		ElseIf '$$IsERPCPM$$' Then
			And I click the button named 'ListAdvancedSearchProductsCreate'
			Then "Product range (create)" window is opened
			And I select from the drop-down list named 'ProductKindRequiredFields'  by '[TheProductKind]' string
			And I change the radio button named 'SettingVisibilityForm' value to 'Show all'
			And I input '[TheProductName]' text in the field named 'Description'
			And I input '[TheProductID]' text in the field named 'SKU'
		And I click the button named 'FormWriteAndClose'
		And I wait "Product range (create) *" window closing in 20 seconds

	* Closing a list
		When "Product range" window is opened
		If '$$IsERPCPM$$' Then
			And I set checkbox named 'UseFilters'
		And I close "Product range" window

Scenario: I create nomenclature kind with name 'TheProductKindName'

	* Opening a list
		And In the command interface I select "Catalogs" "Product range"
		When "Product range" window is opened
		And In this window I click command interface button "Nomenclature types"

	* Deleting the current element
		And I search element '[TheProductKindName]' "At the beginning of the line" by field "Description" in list "Product range"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "* (Product range types)" clearing

	* Creating a new element
		When "Product range" window is opened
		And I click the button named 'FormCreate'
		Then "Product range types (creation)" window is opened
		And I input '[TheProductKindName]' text in the field named 'Description'
		And I change the radio button named 'UH_TypeObjectPurchases' value to 'Goods'
		And I click the button named 'FormWriteAndClose'
		And I wait "Product range types (creation) *" window closing in 20 seconds

	* Closing a list
		When "Product range" window is opened
		And I close "Product range" window

Scenario: I create product category with name 'TheProductCategoryName' nomenclature kind 'TheProductKind'

	* Finding nomenclature type
		If '$$IsCPM$$' Then
			And In the command interface I select "Corporate purchasing" "Product categories"
			Then "Product categories" window is opened
			And I click the button named 'FormFind'
			Then the form named 'UniversalListFindExtForm' is opened
			And I select "Description" exact value from the drop-down list named 'FieldSelector'
		If '$$IsERPCPM$$' Then
			And In the command interface I select "CRM and marketing" "Settings and directories"
			Then "Settings and directories for CRM and marketing" window is opened
			And I click the button named 'OpenProductCategories'
			When "Product categories" window is opened
			And I select context menu item named 'ListProductRangeKindsContextMenuFind' of the form attribute named 'ListProductRangeKinds'
			Then the form named 'UniversalListFindExtForm' is opened
			And I select "Product range type" exact value from the drop-down list named 'FieldSelector'
			And I input '[TheProductKind]' text in the field named 'Pattern'
			And I change the radio button named 'CompareType' value to "Exact match"
			And I click the button named 'Find'
			Then "Product categories" window is opened
			And the number of 'ListOfNomenclatureTypes' table lines is 'equal' 1
			And in the table 'List' I click the button named 'ListFind'
			Then the form named 'UniversalListFindExtForm' is opened
			And I select "Product category" exact value from the drop-down list named 'FieldSelector'

	* Deleting the current element
		And I input '[TheProductCategoryName]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				When "* (Product categories)" window is opened
				Then I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Product categories) *" window closing in 20 seconds

	* Creating a new element
		If '$$IsCPM$$' Then
			And I click the button named 'FormCreate'
			And I select from the drop-down list named 'ProductKind'  by '[TheProductKind]' string
		If '$$IsERPCPM$$' Then
			And in the table 'List' I click the button named 'List'
			And I select from the drop-down list named 'Owner'  by '[TheProductKind]' string
		Then "Product categories (creation) *" window is opened
		And I input '[TheProductCategoryName]' text in the field named 'Description'
		And I select "20%" exact value from the drop-down list named 'VATRate'
		And I select from the drop-down list named 'UnitOfMeasure'  by "PCs" string
		And I click the button named 'FormWriteAndClose'
		And I wait "Product categories (creation) *" window closing in 20 seconds

	* Closing a list
		When "Product categories" window is opened
		And I close "Product categories" window

Scenario: I create nomenclature group with name 'TheName'

	* Opening a list
		And I open 'ProductRangeGroups' catalog default form
		Then "Product range groups" window is opened

	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Product range groups"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (Product range group)" clearing

	* Creating element
		And I click the button named 'FormCreate'
		Then "Product range group (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Product range group (create) *" window closing in 20 seconds

	* Closing a list
		When "Product range groups" window is opened
		And I close "Product range groups" window

Scenario: I select value 'TheValuesName' in group 'TheGroupName' for attribute 'TheAttributeName' for nomenclature with name 'TheProductName'

	* Opening a list
		If '$$IsPerform$$' Then
			And In the command interface I select "Quick menu" "Product range"
		ElseIf '$$IsCPM$$' Then
			And In the command interface I select "Catalogs" "Product range"
		ElseIf '$$IsERPCPM$$' Then
			And In the command interface I select "Quick menu" "Product range"
			And I remove checkbox named 'UseFilters'
		Then "Product range" window is opened

	* Finding current element
		If '$$IsCPM$$' Then
			And I search and select element '[TheProductName]' "At the beginning of the line" by field "Description" in list "Product range"
		ElseIf '$$IsERPCPM$$' Then
			And Delay 1
			And I click Clear button of the field named 'SearchStringProductRange'
			And I input '[TheProductName]' text in the field named 'SearchStringProductRange'
			And I click the button named 'Find'
			If the window with 'Search' header appeared in 1 seconds Then
				And I click the button named 'Button0'
			When "Product range" window is opened
			And I set checkbox named 'UseFilters'
			And I select current line in 'ListAdvancedSearchProducts' table
			Then "* (Product range)" window is opened
			And I move to the tab named 'PageProductAttributes'
			If the window with 'Useful tip' header appeared in 1 seconds Then
				And I click the button named 'Button0'

	* Setting attribute
		Then "* (Product range)" window is opened
		If 'NOT IsBlankString(\"[TheGroupName]\")' Then
			And I expand the group named '[TheGroupName]'
		If 'IsBlankString(\"[TheValuesName]\")' Then
			And I input '' text in the field named '[TheAttributeName]'
		Else
			And I select from the drop-down list named '[TheAttributeName]'  by '[TheValuesName]' string
		And I click the button named 'FormWriteAndClose'
		And I wait "* (Product range) *" window closing in 20 seconds

	* Closing forms
		Then "Product range" window is opened
		And I close "Product range" window

Scenario: I set value 'TheValuesName' for price type with name 'TheName' for nomenclature with name 'TheProductName'

	* Opening a list
		And In the command interface I select "Catalogs" "Product range"
		Then "Product range" window is opened

	* Finding current element
		And I search and select element '[TheProductName]' "At the beginning of the line" by field "Description" in list "Product range"
	
		* Setting attribute
		Then "* (Product range)" window is opened
		And In this window I click command interface button 'Prices'
		And I input "String(BeginOfYear(CurrentDate()))" expression value in the field named 'ДатаЦен'
		And I move to the next attribute
		And I search value '[TheName]' by field 'Price type' in table 'ItemsPricesPrice'
		And I activate field named "ItemsPricesPrice" in "ItemsPrices" table
		And I select current line in "ItemsPricesPrice" table
		And I input '[TheValuesName]' text in the field named 'ItemsPricesPrice' of "ItemsPrices" table
		And I finish line editing in "ItemsPrices" table
		And in the table "ItemsPrices" I click the button named 'WritePrices'

	* Closing forms
		And I close '* (Product range)' window
		Then "Product range" window is opened
		And I close "Product range" window

Scenario: I create delivery place with name 'TheName' kind 'TheField' at warehouse 'TheStorage'
	* Opening a list
		And I open 'DeliveryPlaces' catalog default form
		Then 'Places of delivery of goods (rendering of services)' window is opened

	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Places of goods delivery (service provision)"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (Place of goods delivery (services rendering))" clearing

	* Creating element
		And I click the button named 'FormCreate'
		And I input '[TheName]' text in the field named 'Description'
		And I select '[TheField]' exact value from the drop-down list named "Kind"
		If '$$IsCPM$$' Then
			And I click Choice button of the field named "Warehouse"
			And I search and select element "[TheStorage]" "Exact match" by field "Description" in list "List"
		ElseIf '$$IsERPCPM$$' Then
			If 'Type' form attribute became equal to 'Warehouse'
				And I click Choice button of the field named "Warehouse"
				And I search and select element "[TheStorage]" "Exact match" by field "Description" in list "List"
		And I click the button named 'FormWriteAndClose'
		And I wait "Place of delivery of goods (rendering of services) (creation) *" window closing in 20 seconds

	* Closing a list
			And I close 'Delivery locations for goods (services)' window

Scenario: I create warehouse with name 'TheName' kind 'TheField' price type 'ThePrice'
	* Opening a list
		And I open 'Warehouses' catalog default form

	* Deleting an element
		If '$$IsCPM$$' Then
			And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Warehouses"
		ElseIf '$$IsERPCPM$$' Then
			And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Warehouses and stores"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (Warehouse)" clearing

	* Creating element
		If '$$IsCPM$$' Then
			And I click the button named 'FormCreate'
		ElseIf '$$IsERPCPM$$' Then
			And I click the button named 'ListCreateWholesaleWarehouse'
		And I input '[TheName]' text in the field named 'Description'
		If '$$IsCPM$$' Then
			And I select '[TheField]' exact value from the drop-down list named "WarehouseType"
			And I click Select button of "Price type" field
			And I search and select element "[ThePrice]" "Exact match" by field "Description" in list "List"
		And I click the button named 'FormWriteAndClose'
		And I wait "Warehouse (create) *" window closing in 20 seconds

	* Closing a list
		If '$$IsCPM$$' Then
			And I close 'Warehouses' window
		ElseIf '$$IsERPCPM$$' Then
			And I close 'Warehouses and stores' window

Scenario: I create procurement commission appointment order for company 'TheBusinessUnitName'

		And In the command interface I select 'Corporate procurement' 'Procurement commission orders'
		Then 'Procurement commission orders' window is opened
		And I click the button named 'FormCreate'
		Then 'Procurement commission orders (creating)' window is opened
		And in the table "PurchaseCommission" I click the button named 'PurchaseCommissionAdd'
		And I click choice button of the attribute named "PurchaseCommissionOrganization" in "PurchaseCommission" table
		If '$$IsCPM$$' Then
			And I search and select element "[TheBusinessUnitName]" "Exact match" by field "Name in the application" in list "List"
		If '$$IsERPCPM$$' Then
			And I search and select element "[TheBusinessUnitName]" "Exact match" by field "Working name" in list "List"

		And I finish line editing in "PurchaseCommission" table
		And I click the button named 'FormPostAndClose'
		And I wait 'Purchasing committee orders (Creating) *' window closing in 20 seconds
		Then 'Procurement commission orders' window is opened
		And I close 'Purchasing committee orders' window