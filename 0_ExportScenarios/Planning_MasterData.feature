#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for creating reference data




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

Scenario: I fill dimension types 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'

		And I activate field named "DimensionKindsDimensionKind" in "DimensionKinds" table
		And I select current line in "KindsOfDimensions" table
		If 'NOT IsBlankString("[TheAnalytics1]")' Then
			And I select '[TheAnalytics1]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics2]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '2' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics2]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics3]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '3' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics3]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics4]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '4' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics4]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics5]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '5' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics5]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics6]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '6' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics6]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table

Scenario: I create article dimension group 'TheAnalyticsGroup' with dimension types 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'

	* Opening a list form
		And I open "ItemDimensionGroups" catalog default form
	
	* Deleting an element
		And I search element '[TheAnalyticsGroup]' "Exact match" by field "Description" in list "Item dimension groups"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheAnalyticsGroup] (Item dimension group)" clearing
	
	* Creating an element
		And I click the button named 'FormCreate'
		And I input '[TheAnalyticsGroup]' text in the field named 'Description'
		And I fill dimension types 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'
		And I click the button named 'FormWriteAndClose'
		And I wait 'Item dimension group (create) *' window closing in 20 seconds
		
	* Closing a list form
		When 'Item dimension groups' window is opened
		And I close 'Item dimension groups' window

Scenario: I check filled dimensions count 'N' in table for dimension group 'TheAnalyticsGroup'
	* Checking the number of dimensions
		And I open "ItemDimensionGroups" catalog default form
		And I search element '[TheAnalyticsGroup]' "Exact match" by field "Description" in list "Item dimension groups"
		And I select current line in "List" table
		And the form attribute named "МаксимальныйНомерЗаполненнойАналитики" became equal to '[N]'
		And I close '[TheAnalyticsGroup] (Item dimension group)' window
		And I close 'Item dimension groups' window

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
			When 'Product range (create) *' window is opened
			And I select from the drop-down list named "UnitOfMeasure"  by 'PCs' string
								
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

Scenario: I create information base type with name 'TheName' version 'ThePlatformVersion'

	* Opening a list
		And In the command interface I select "Integration and master data management" "Infobase types"

	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Infobase types"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (Infobase type)" clearing
	
	* Creating a new element
		And I click the button named 'FormCreate'
		Then "Infobase type (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I select '[ThePlatformVersion]' exact value from the drop-down list named 'PlatformVersion'
		And I click the button named 'FormWriteAndClose'
		And I wait "Infobase type (create) *" window closing in 20 seconds
		
	* Closing a list
		When "Infobase types" window is opened
		And I close "Infobase types" window

Scenario: I create external information base 'TheName' type 'TheType' catalog 'TheCatalog' storage type 'TheTypeOfStorage'

	* Opening a list
		And In the command interface I select "Integration and master data management" "External infobases"

	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "External infobase" in list "External infobases"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (External infobases)" clearing

	* Creating a new element
		And I click the button named 'FormCreate'
		Then "External infobases (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I click Choice button of the field named 'ExternalSourceType'
		And I search and select element '[TheType]' "At the beginning of the line" by field "Description" in list "Infobase types"
		And I input '[TheCatalog]' text in the field named 'NameBeginning'
		If '"[TheTypeOfStorage]" = "Excel"' Then
			And I change the radio button named 'ADOStorageType' value to "MS Excel (.xls) files"
			And I input '[TheCatalog]' text in the field named 'ReferenceDirectory'
			And I click the button named 'TestConnection'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
		If '"[TheTypeOfStorage]" = "FoxPro"' Then
			And I change the radio button named 'ADOStorageType' value to "FoxPro (.dbf) files"
			And I input '[TheCatalog]' text in the field named 'ReferenceDirectory'
		If '"[TheTypeOfStorage]" = "Access"' Then
			And I change the radio button named 'ADOStorageType' value to "MS Access databases (.mdb)"
			And I input '[TheCatalog]' text in the field named 'ReferenceDirectory'
		And I save "[TheName] (External infobases)*" line to the variable 'WindowTitle'
		And I click the button named 'FormWrite'
		And I wait '$WindowTitle$' window opening in 20 seconds
	
Scenario: I add company files path element for type 'TheType' object 'TheObject' value 'TheValue'

	Then "Company file path items: List form" window is opened
	And I move to the tab named 'Page_[TheType]'

	* Deleting an old element
		And in the table 'List_[TheType]' I click the button named 'List_[TheType]Find'
		Then "Find" window is opened
		And I select "Object" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input '[TheObject]' text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Company file path items: List form" window is opened
		And While the number of 'List_[TheType]' table lines 'more' 0 Then
			And I select context menu item named 'List_[TheType]ContextMenuDelete' of the form attribute named 'List_[TheType]'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
				
	* Adding a new element
		And in the table 'List_[TheType]' I click the button named 'List_[TheType]Create'
		Then "Company file path items (create)" window is opened
		And I select from the drop-down list named 'Object'  by '[TheObject]' string
		And I input '[TheValue]' text in the field named 'Name'
		And I click the button named 'FormWriteAndClose'
		And I wait "Company file path items (create) *" window closing in 20 seconds

Scenario: I enable performance mode of restrictions at record level

	And In the command interface I select "Administration" "Users and rights settings"
	Then "Users and rights settings" window is opened
	And I expand the group named 'AccessGroupsGroup'
	If the field named 'LimitAccessAtRecordLevelUniversally' exists on the form Then
		And I select "High performance" exact value from the drop-down list named 'LimitAccessAtRecordLevelUniversally'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		
	Then "Users and rights settings" window is opened
	And I click the button named 'AccessUpdateOnRecordsLevel'
	Then "Update record-level access" window is opened
	And Delay 1

	And I expand the group named 'BriefDetailed'
	If form attribute named 'StartAccessUpdateImmediately' is available Then
		And I click the button named 'StartAccessUpdateImmediately'
		If "1C:Enterprise" window is opened Then
			And I click the button named 'Button0'
	And I wait "(completed *)" value by template of the attribute named 'LastAccessUpdateCompletion' for 600 seconds
	And I wait that in 'Lists' table number of lines will be "equal" 0 for 60 seconds
	When the number of 'Lists' table lines is "equal" 0

	When "Update record-level access" window is opened
	And I close "Update record-level access" window

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