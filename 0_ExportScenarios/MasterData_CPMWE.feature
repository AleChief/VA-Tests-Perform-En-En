#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for creating reference data in 1C:CPMWE

Сценарий: Я создаю страну с кодом1 'ТекКодСтраны1' кодом2 'ТекКодСтраны2' кодом3 'ТекКодСтраны3' именем1 'ТекИмяСтраны1' именем2 'ТекИмяСтраны2' именем3 'ТекИмяСтраны3' если ее нет в 1C:CPMWE

	* Opening a reference form
		And I open 'WorldCountries' catalog default form

	* Searching for an element
		Then "Countries" window is opened
		And I select context menu item named 'ListContextMenuFind' of the form attribute named 'List'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I input '[TextCountryCode1]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		Then "Countries" window is opened
		If number of 'List' table lines is 'equal' 0 Then
			And I click the button named 'ListCreate'
		Else
			And I select current line in 'List' table
	
	* Creating element
		Then "*Country*" window is opened
		And I input '[TextCountryCode1]' text in the field named 'Code'
		And I input '[TextCountryCode2]' text in the field named 'CodeAlpha2'
		And I input '[TextCountryCode3]' text in the field named 'CodeAlpha3'
		And I input '[TextCountryName1]' text in the field named 'Description'
		And I input '[TextCountryName2]' text in the field named 'DescriptionFull'
		And I input '[TextCountryName3]' text in the field named 'InternationalDescription'
		If '[TextCountryCode1] = 643' Then
			And I set checkbox named 'EEUMember'
		And I click the button named 'FormWriteAndClose'
		And I wait "Country (create)" window closing in 20 seconds

	* Closing a list
		When "Countries" window is opened
		And I close "Countries" window

Сценарий: Я устанавливаю цену с типом 'ТекТипЦены' номенклатуры 'ТекИмяНоменклатуры' на дату 'ТекДатаКурса' в значение 'ТекЗначение' 'ТекВалюта' в 1C:CPMWE

	* Opening a list
		And In the command interface I select "Quick menu" "Product range"
		Then "Product range" window is opened

	* Finding current element
		And I select context menu item named 'ListContextMenuFind' of the form attribute named 'List'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I input '[TextNomenclatureName]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		Then "Product range" window is opened
		Then the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table
		Then "* (Product range)" window is opened
		And In this window I click command interface button "Product range prices"
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Period" exact value from the drop-down list named 'FieldSelector'
		And I input '[TextDateOfCourse]' text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "* (Product range)" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Price type" exact value from the drop-down list named 'FieldSelector'
		And I select from the drop-down list named 'Pattern'  by '[TextPriceType]' string
		And I click the button named 'Find'
		Then "* (Product range)" window is opened
		If number of 'List' table lines is 'equal' 0 Then
			And I click the button named 'FormCreate'
		Else
			And I select current line in 'List' table

	* Creating a position
		When "Product range prices*" window is opened
		And I input '[TextDateOfCourse]' text in the field named 'Period'
		And I select from the drop-down list named 'PriceType_'  by '[TextPriceType]' string
		And I select from the drop-down list named 'Products'  by '[TextNomenclatureName]' string
		And I select '[TextCurrency]' exact value from the drop-down list named 'Currency'
		And I input '[TextValue]' text in the field named 'Price'
		And I click the button named 'FormWriteAndClose'
		And I wait "Product range prices (create) *" window closing in 20 seconds

	* Closing forms
		Then "* (Product range)" window is opened
		And I close "* (Product range)" window
		Then "Product range" window is opened
		And I close "Product range" window
