#language: en

@tree
@ExportScenarios
@IgnoreOnCIMainBuild
 
Feature: Export scenarios

As a business analyst I want to
simplify creating directories and documents
to simplify maintaining scenario tests

Scenario: I create NewOrganization "TextDescription", TIN = "TextTIN", KPP = "TextKPP", OGRN = "TextOGRN", registration date = "TextRegistrationDate"

		And In the command interface I select 'General catalogs and settings' 'Business units'
		Then 'Business units' window is opened
		
		And I click the button named 'CreateNewCompany'
		Then 'Company type' window is opened
		And I click the button named 'SelectRussia'
		Then 'Company kind' window is opened
		And I click the button named 'SelectLegalEntity'
		Then 'Legal entity' window is opened
		And I click the button named 'SystemTaxationGeneralLegalEntity'
		
		And I input '[TextDescription]' text in the field named 'DescriptionShort'
		And I move to the next attribute
		And I input '[TextTIN]' text in the field named 'TIN'
		And I move to the next attribute
		And I input '[TextKPP]' text in the field named 'KPP'
		And I move to the next attribute
		And I input '[TextOGRN]' text in 'OGRN' field
		And I move to the next attribute
		And I input '[TextRegistrationDate]' text in the field named 'DateOfRegistration'
		And I move to the next attribute
		And I click 'Save' button
		And I click the button named 'FormWriteAndClose'
		And I wait '[TextDescription] *' window closing in 20 seconds

		And I close all client application windows

Scenario: I create NewOrganization223 "TextDescription", TIN = "TextTIN", KPP = "TextKPP", OGRN = "TextOGRN", registration date = "TextRegistrationDate"

		And In the command interface I select 'General catalogs and settings' 'Business units'
		Then 'Business units' window is opened
		
		And I click the button named 'CreateNewCompany'
		Then 'Company type' window is opened
		And I click the button named 'SelectRussia'
		Then 'Company kind' window is opened
		And I click the button named 'SelectLegalEntity'
		Then 'Legal entity' window is opened
		And I click the button named 'SystemTaxationGeneralLegalEntity'
		
		And I input '[TextDescription]' text in the field named 'DescriptionShort'
		And I move to the next attribute
		And I input '[TextTIN]' text in the field named 'TIN'
		And I move to the next attribute
		And I input '[TextKPP]' text in the field named 'KPP'
		And I move to the next attribute
		And I input '[TextOGRN]' text in 'OGRN' field
		And I move to the next attribute
		And I input '[TextRegistrationDate]' text in the field named 'DateOfRegistration'
		And I move to the next attribute
		And I set checkbox 'Accounting of purchases under 223-FZ'
		And I select '500 000' exact value from "Amount of small purchases" drop-down list
		And I click 'Save' button
		And I click the button named 'FormWriteAndClose'
		And I wait '[TextDescription] *' window closing in 20 seconds

		And I close all client application windows

Scenario: I create NewOrganizationIP "TextLastName", Name = "TextName", TIN = "TextTIN", OGRNIP = "TextOGRNIP", registration date = "TextRegistrationDate"

		And In the command interface I select 'General catalogs and settings' 'Business units'
		Then 'Business units' window is opened

		And I click the button named 'CreateNewCompany'
		Then 'Company type' window is opened
		And I click the button named 'SelectRussia'
		Then 'Company kind' window is opened
		And I click the button named 'SelectIndividualEntrepreneur'
		Then 'Individual entrepreneur' window is opened
		And I click the button named 'SystemTaxationTaxOnProfessionalIncomeIndividualEntrepreneur'
		
		And I select 'Self-employed' exact value from the drop-down list named "StatusNaturalPerson"
		And I select 'Sole proprietor' exact value from the drop-down list named "StatusNaturalPerson"
		
		And I input '[TextLastName]' text in 'LastName' field
		And I input '[TextName]' text in 'Name' field
		And I move to the next attribute
		And I input '[TextTIN]' text in the field named 'TIN'
		And I move to the next attribute
		And I input '[TextOGRNIP]' text in 'OGRNIP' field
		And I move to the next attribute
		And I input '[TextRegistrationDate]' text in the field named 'DateOfRegistration'
		And I move to the next attribute
		And I click 'Save' button
		And I click the button named 'FormWriteAndClose'
		And I wait 'Business unit*' window closing in 20 seconds

		And I close all client application windows

Scenario: I create NewCFO "TextDescription", Group = "TextGroup"

		And In the command interface I select 'General catalogs and settings' 'Business units'
		Then 'Business units' window is opened
		
		And I click the button named 'CreateNewCompany'
		Then 'Company type' window is opened
		And I click the button named 'SelectCentralFederalDistrict'
		Then 'Business unit (create)' window is opened
		And I input '[TextDescription]' text in the field named 'DescriptionShort'
		And I move to the next attribute

		And I expand "Default regulation parameters" group
		And I click Select button of "Consolidating company" field
		Then 'Business units' window is opened
		And I go to line in "List" table:
			| 'Name in the application' | 
			| '[TextGroup]' |
		And I select current line in "List" table
		
		And I click the button named 'FormWriteAndClose'
		And I wait 'Business unit *' window closing in 20 seconds

		And I close all client application windows

Scenario: I create warehouse "TextWarehouse"

		And In the command interface I select 'Catalogs' 'Warehouses'
		Then 'Warehouses' window is opened
		And I click the button named 'FormCreate'
		Then 'Warehouse (create)' window is opened
		And I input '[TextWarehouse]' text in 'Description' field
		And I click Select button of "Price type" field
		Then 'Product range price types' window is opened
		And I go to line in "List" table:
			| 'Description'  | 'Currency' |
			| 'Delivery price' | 'RUB'    |
		And I select current line in "List" table
		And I click the button named 'FormWriteAndClose'

		And I close all client application windows

Scenario: I set SettingNomenclaturePrices "TextNomenclature", price = "TextPrice"

		And in the table "Goods" I click the button named 'GoodsAdd'
		And I click choice button of the attribute named "GoodsProductRange" in "Goods" table
		Then 'Product range' window is opened
		And I go to line in "List" table:
			| 'Description'      |
			| '[TextNomenclature]' |
		And I select current line in "List" table
		Then 'Setting nomenclature prices (creating) *' window is opened
		
		And I activate field named "GoodsPrice" in "Goods" table
		And I input '[TextPrice]' text in the field named 'GoodsPrice' of "Goods" table
		And I finish line editing in "Goods" table