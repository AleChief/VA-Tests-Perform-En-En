#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for creating reference data in 1C:ERP Business Management

Scenario: I create a nomenclature type with name 'TextNomenclatureTypeName' type 'TextType' in 1C:ERP_UH

	* Deleting product categories
		And In the command interface I select "CRM and marketing" "Settings and directories"
		Then "Settings and directories for CRM and marketing" window is opened
		And I click the button named 'OpenProductCategories'
		When "Product categories" window is opened
		And I select context menu item named 'ListProductRangeKindsContextMenuFind' of the form attribute named 'ListProductRangeKinds'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Product range type" exact value from the drop-down list named 'FieldSelector'
		And I input '[TextNomenclatureTypeName]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		Then "Product categories" window is opened
		If number of 'ListNomenclatureTypes' table lines is 'more' 0 Then
			And in the table 'List' I click the button named 'ListListSettings'
			And I set filter in list form 'Description' 'Does not begin with' 'Delete_'
			And While the number of 'List' table lines 'more' 0 Then
				* Marking for deletion
					If the current row in 'List' table is not marked for deletion Then
					And I select context menu item named 'ListContextMenuSetDeletionMark' of the form attribute named 'List'
					Then "1C:Enterprise" window is opened
					And I click the button named 'Button0'
				* Renaming
					And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
					And I select current line in 'List' table
					Then "* (Product categories)" window is opened
					And I input 'UID' variable value in the field named 'Description'
					And I click the button named 'FormWriteAndClose'
					And I wait '* (Product categories)' window closing in 20 seconds
			And in the table 'List' I click the button named 'ListListSettings'
			And I remove all filters in list form

			* Deleting nomenclature type
				When "Product categories" window is opened
				And I select current line in 'ListProductRangeKinds' table
				Then "[TextProductRangeTypeName] (Product range type)" window is opened
				And I expand the group named 'PageGeneral'
				And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormSetDeletionMark'
				Then "1C:Enterprise" window is opened
				And I click the button named 'Button0'
				And I click the button named 'FormWriteAndClose'
				And I wait '[TextNomenclatureTypeName] (Nomenclature type) *' window closing in 20 seconds
				Then "Product categories" window is opened
				And I close "Product categories" window

	* Opening list form
		And In the command interface I select "Quick menu" "Product range"
		When "Product range" window is opened
	
	* Creating a new element
		And I set checkbox named 'UseFilters'
		And I click the button named 'CreateProductKind'
		Then "Product range type (creation)" window is opened
		And I click 'specify' hyperlink of the field named 'TypeProductRange'
		Then "Select product range type" window is opened
		And I change the radio button named 'TypeNomenclatureGoods' value to '[TextType]'
		And I click the button named 'OK'
		Then "Product range type (creation) *" window is opened
		And I input '' text in the field named 'Parent'
		And I input '[TextNomenclatureTypeName]' text in the field named 'Description'
		And I expand the group named 'PageValuesDefault'
		And I select '20%' exact value from the drop-down list named 'VATRate'
		And I select from the drop-down list named 'UnitOfMeasure'  by "PCs" string
		And I click the button named 'FormWriteAndClose'
		And I wait 'Nomenclature type (Creating) *' window closing in 20 seconds

	* Closing forms
		When "Product range" window is opened
		And I close "Product range" window

Scenario: I create an agreement with a client with name 'TextAgreementName' currency 'TextCurrency' in 1C:ERP_UH

	* Deleting existing elements
		And In the command interface I select "CRM and marketing" "Standard agreements with customers"
		And I search element '[TextNameAgreement]' "Exact match" by field "Description" in list "Standard sales terms agreements"
		And While the number of 'List' table lines 'more' 0 Then
			And I delete current row in list 'List'
			And I select current line in 'List' table
			Then "Standard sales terms agreement" window is opened
			And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
			And I input 'UID' variable value in the field named 'Description'
			And I click the button named 'FormWriteAndClose'
			And I wait 'Standard sales terms agreement *' window closing in 20 seconds

	* Creating an element
		Then "Standard sales terms agreements" window is opened
		And in the table 'List' I click the button named 'ListCreate'
		Then "Standard sales terms agreement (creation)" window is opened
		And I input '[TextAgreementName]' text in the field named 'Description'
		And I move to the tab named 'PageSalesConditions'
		And I select '[TextCurrency]' exact value from the drop-down list named 'Currency'
		And I change checkbox named 'PriceIncludesVAT'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Standard sales terms agreement (creation) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Standard sales terms agreement (creation) *" window closing in 20 seconds

	* Closing a list form
		Then "Standard sales terms agreements" window is opened
		And I close "Standard sales terms agreements" window

Scenario: I create an agreement with a supplier 'TextSupplier' with name 'TextAgreementName' currency 'TextCurrency' in 1C:ERP_UH

	* Deleting existing elements
		And In the command interface I select "Purchases" "Agreements with suppliers"
		And I search element '[TextAgreementName]' "Exact match" by field "Description" in list "Purchase Terms Agreements"
		And While the number of 'List' table lines 'more' 0 Then
			And I delete current row in list 'List'
			And I select current line in 'List' table
			Then "[TextAgreementName] (Purchase terms agreement)" window is opened
			And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
			And I input 'UID' variable value in the field named 'Description'
			And I click the button named 'FormWriteAndClose'
			And I wait "[TextAgreementName] (Purchase terms agreement) *" window closing in 20 seconds

	* Creating an element
		Then "Purchase terms agreements" window is opened
		And in the table 'List' I click the button named 'ListCreate'
		Then "Purchase terms agreement (creation)" window is opened
		And I input '[TextAgreementName]' text in the field named 'Description'
		And I select from the drop-down list named "Partner"  by '[TextSupplier]' string
		And I move to the tab named 'GroupPurchasesConditions'
		And I select '[TextCurrency]' exact value from the drop-down list named 'Currency'
		And I change checkbox named 'PriceIncludesVAT'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Purchase terms agreement (creation) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Purchase terms agreement (creation) *" window closing in 20 seconds

	* Closing a list form
		Then "Purchase terms agreements" window is opened
		And I close "Agreements on purchase terms" window

Scenario: I create a partner with name 'TextPartnerName' type 'TextType' in 1C:ERP_UH

	* Opening list form
		And In the command interface I select "Quick menu" "Partners"
		And I wait 'Partners' window opening in 20 seconds
		And Delay 1

	* Deleting existing elements
		And I search element '[TextPartnerName]' "Exact match" by field "Description" in list "Partners"
		And While the number of 'List' table lines 'more' 0 Then
			And I delete current row in list 'List'
			And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
			And I select current line in 'List' table
			Then "[TextPartnerName] (Partner)" window is opened
			* Deleting counterparties
				And In this window I click command interface button "Counterparties"
				When "[TextPartnerName] (Partner)" window is opened
				And I click the button named 'FormListSettings'
				And I set filter in list form 'Working name' 'Does not begin with' 'Delete_'
				And While the number of 'List' table lines 'more' 0 Then
					And I delete current row in list 'List'
					And I select current line in 'List' table
					Then "* (Counterparty*)" window is opened
					And I input 'UID' variable value in the field named 'Description'
					And I click the button named 'FormWriteAndClose'
					And I wait '* (Counterparty*)' window closing in 20 seconds
				And I click the button named 'FormListSettings'
				And I remove all filters in list form
			* Deleting contracts
				And In this window I click command interface button "Contracts"
				And in the table 'List' I click the button named 'ListListSettings'
				And I set filter in list form 'Working name' 'Does not begin with' 'Delete_'
				And While the number of 'List' table lines 'more' 0 Then
					And I delete current row in list 'List'
					And I select current line in 'List' table
					Then "* (Contract*)" window is opened
					If 'EditVersion' attribute is editable Then
						And I click the button named 'EditVersion'
					And I input 'UID' variable value in the field named 'Description'
					And I click the button named 'FormWrite'
					Then "*" window is opened
					And I close "*" window
				And in the table 'List' I click the button named 'ListListSettings'
				And I remove all filters in list form
			* Renaming
				And In this window I click command interface button "IsMain"
				Then "* (Partner)" window is opened
				And I input 'UID' variable value in the field named 'DescriptionFullCompany'
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait '* (Partner) *' window closing in 20 seconds

	* Creating an element
		Then "Partners" window is opened
		And in the table 'List' I click the button named 'CreateNew'
		Then "Partner (Creating)" window is opened
		And I input '[TextPartnerName]' text in the field named 'DescriptionFullCompany'
		And I change checkbox named 'CurrentType'
		And I click the button named 'FormWriteAndClose'
		And I wait 'Partner (Creating) *' window closing in 20 seconds

	* Closing forms
		When "Partners" window is opened
		And I close "Partners" window

Scenario: For partner 'TextPartnerName' I create a counterparty with name 'TextCounterpartyName' type 'TextCounterpartyType' in 1C:ERP_UH

	* Opening list form
		And In the command interface I select "Quick menu" "Partners"
		And I wait 'Partners' window opening in 20 seconds

	* Finding a partner
		And I search and select element '[TextPartnerName]' "Exact match" by field "Description" in list "Partners"
		//And in table 'List' the number of rows 'equals' 1
		//And in table 'List' I select the current row
		Then "[TextPartnerName] (Partner)" window is opened

	* Deleting existing elements
		And In this window I click command interface button "Counterparties"
		And I search element '[TextCounterpartyName]' "Exact match" by field "Working name" in list "[TextPartnerName] (Partner)"
		And While the number of 'List' table lines 'more' 0 Then
			And I delete current row in list 'List'
			And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
			And I select current line in 'List' table
			Then "* (Counterparty*)" window is opened
			And I input 'UID' variable value in the field named 'Description'
			And I click the button named 'FormWriteAndClose'
			And I wait '* (Counterparty*)' window closing in 20 seconds

	* Creating a counterparty
		Then "[TextPartnerName] (Partner)" window is opened
		And I click the button named 'FormCreate'
		Then "Counterparty (create)" window is opened
		And I input '[TextCounterpartyName]' text in the field named 'Description'
		When "Counterparty (create)" window is opened
		And I select '[CurrentCounterpartyKind]' exact value from the drop-down list named 'CounterpartyKind'
		And I click the button named 'FormWriteAndClose'

	* Closing the form
		When "[TextPartnerName] (Partner)" window is opened
		And I close "[TextPartnerName] (Partner)" window
		Then "Partners" window is opened
		And I close "Partners" window

Scenario: For partner 'TextPartnerName' counterparty 'TextCounterpartyName' I create a contract with type 'TextTypeOfAgreement' number 'TextNumber' from 'TextDate' company 'TextOrganization' currency 'TextCurrency' amount 'TextAmount' agreement 'TextAgreement' in 1C:ERP_UH

	* Opening list form
		And In the command interface I select "Quick menu" "Partners"
		And I wait 'Partners' window opening in 20 seconds

	* Finding a partner
		And I search element '[TextPartnerName]' "Exact match" by field "Description" in list "Partners"
		And the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table
		Then "[TextPartnerName] (Partner)" window is opened

	* Finding a counterparty
		And In this window I click command interface button "Counterparties"
		And I search and select element '[CurrentCounterpartyName]' "Exact match" by field "Working name" in list "[CurrentPartnerName] (Partner)"
		Then "[TextCounterpartyName] (Counterparty *)" window is opened

	* Deleting a contract
		And In this window I click command interface button "Contracts"
		Then '[TextCounterpartyName] (Counterparty *)' window is opened
		If 'Check counterparties' window is opened Then
			And I click the button named 'ManualCheck'
		And I search element '[TextNumber] from [TextDate]' "Exact match" by field "Working name" in list "[TextCounterpartyName] (Counterparty *)"
		And While the number of 'List' table lines 'more' 0 Then
			And I delete current row in list 'List'
			And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
			And I select current line in 'List' table
			Then "* (Contract*)" window is opened
			If 'EditVersion' attribute is editable Then
				And I click the button named 'EditVersion'
			And I input 'UID' variable value in the field named 'Description'
			And I click the button named 'FormWrite'
			Then "*" window is opened
			And I close "*" window

	* Creating a contract
		And in the table 'List' I click the button named 'ListCreate'
		If 'Check counterparties' window is opened Then
			And I click the button named 'ManualCheck'
		Then "Select contract type" window is opened
		And I go to line in 'TypesOfContracts' table:
			| 'Contract kind'     |
			| '[TextTypeOfAgreement]' |
		And I select current line in 'KindsOfContracts' table
		Then "Contract * (create)" window is opened
		And I input '[CurrentNumber]' text in the field named 'Number'
		And I input '[CurrentDate]' text in the field named 'Date'
		And I input "[CurrentNumber] from [CurrentDate]" text in the field named 'Description'
		And I select from the drop-down list named 'Organization'  by '[TextOrganization]' string
		And I select '[CurrentCurrency]' exact value from the drop-down list named 'ARAPCurrency'
		And I set checkbox named 'FixedContractAmount'
		And I input '[CurrentAmount]' text in the field named 'AmountContract'
		Then "Contract with * (Creating) *" window is opened
		And I click the button named 'FormPostAndClose'
		And I wait 'Contract with * (Creating) *' window closing in 20 seconds

	* Closing the form
		When "[TextCounterpartyName] (Counterparty *)" window is opened
		And I close "[TextCounterpartyName] (Counterparty *)" window
		When "[TextPartnerName] (Partner)" window is opened
		And I close "[TextPartnerName] (Partner)" window
		Then "Partners" window is opened
		And I close "Partners" window

Scenario: I for company "TextOrganization" create a department with name "TextDepartmentName" in ERP_UH

	* Deleting existing elements
		And In the command interface I select "Reference data and administration" "Company structure"
		And I search element '[TextDepartmentName]' "Exact match" by field "Description" in list "Enterprise Structure"
		And While the number of 'List' table lines 'more' 0 Then
			And I delete current row in list 'List'
			And I select current line in 'List' table
			Then "[TextDepartmentName] (Department)" window is opened
			And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
			And I input 'UID' variable value in the field named 'Description'
			And I click the button named 'FormWriteAndClose'

	* Creating an element
		Then "Company structure" window is opened
		And I click the button named 'FormCreate'
		Then "Department (create)" window is opened
		And I input '[TextDepartmentName]' text in the field named 'Description'
		And I select from the drop-down list named 'OrganizationUH'  by '[TextOrganization]' string
		And I select from the drop-down list named 'CenterForFinancialResponsibility'  by '[TextOrganization]' string
		Then "Department (create) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Department (create) *" window closing in 20 seconds

	* Closing a list form
		Then "Company structure" window is opened
		And I close "Enterprise structure" window

Scenario: I create nomenclature financial accounting groups with name 'TheName' in 1C:ERPUH

	* Opening a list
		And I open 'GroupsFinancialAccountingNomenclature' catalog default form
		Then 'Groups of financial accounting settings for nomenclature' window is opened

	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Groups of financial accounting settings for nomenclature"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (Product range financial accounting settings group)" clearing

	* Creating element
		And I click the button named 'FormCreate'
		And I input '[TheName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Settings group of financial accounting of product range (creation) *" window closing in 20 seconds

	* Closing a list
			And I close 'Groups of financial accounting settings for nomenclature' window

Scenario: I create price kind with name 'TheName' currency 'TheCurrency' in 1C:ERPUH
	
	* Opening a reference form
		Given I open "PriceKinds" catalog default form
		Then 'Price types ' window is opened
	
	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Price types"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "* (Price type)" clearing

	* Creating an element

		And I click the button named 'FormCreate'
		Then 'Price type (creation)' window is opened
		And I input '[TheName]' text in the field named 'Description'
		If the field named 'CurrencyPrice' exists on the form Then
			And I select '[TheCurrency]' exact value from the drop-down list named 'CurrencyPrice'
		If the field named 'PriceIncludesVAT' exists on the form Then
			And I change checkbox named 'PriceIncludesVAT'
		And I click the button named 'FormWriteAndClose'
		And I wait "Price type (creation) *" window closing in 20 seconds

	* Closing a list
		When "Price types*" window is opened
		And I close "Price types*" window
