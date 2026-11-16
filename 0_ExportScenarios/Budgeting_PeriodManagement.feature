#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для работы с подсистемой "Budgeting" - "Reporting period management"

Сценарий: Я создаю документ управления периодом со сценарием 'TheScenario' регламентом 'TheRegulation' периодичностью 'TheFrequency' датой начала 'TheDateBegin' датой окончания 'TheDateEnd'

	И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Reporting period management"
	Тогда открылось окно "Reporting period management"
	И я нажимаю на кнопку с именем 'FormCreate'
	Тогда открылось окно "Reporting period management (create)"
	И из выпадающего списка с именем 'Сценарий' я выбираю по строке '[TheScenario]'
	И из выпадающего списка с именем 'ScenarioFrequency' я выбираю точное значение '[TheFrequency]'
	И я нажимаю на кнопку с именем 'ChangePeriod'
	Тогда открылось окно "Select period"
	И в поле с именем 'DateBegin' я ввожу текст '[TheDateBegin]'
	И я перехожу к следующему реквизиту
	И в поле с именем 'DateEnd' я ввожу текст '[TheDateEnd]'
	И я нажимаю на кнопку с именем 'Select'
	Тогда открылось окно "Reporting period management (create) *"
	И из выпадающего списка с именем 'OrganizationalStructureVersion' я выбираю по строке '[TheRegulation]'
	И я нажимаю на кнопку с именем 'FormGoForward'
	Тогда открылось окно "1C:Enterprise"
	И я нажимаю на кнопку с именем 'Button0'
	И я запоминаю заголовок формы в переменную 'FormCaption'
	Тогда открылось окно '$ЗаголовокФормы$'
	И в таблице 'RatesEditTable' я нажимаю на кнопку с именем 'RatesEditTableRatesTable_Update'
	И я нажимаю на кнопку с именем 'FormGoForward'
	Тогда открылось окно "1C:Enterprise"
	И я нажимаю на кнопку с именем 'Button0'		
	Когда открылось окно '$ЗаголовокФормы$'
	И я нажимаю на кнопку с именем 'FormGoForward'
	Тогда открылось окно '$ЗаголовокФормы$'
	И я нажимаю на кнопку с именем 'FormClose'

Сценарий: Я заполняю таблицу курсов в управлении периодом сценария

	И я перехожу к закладке с именем 'ExchangeRates'
	И в таблице 'RatesEditTable' я нажимаю на кнопку с именем 'RatesEditTableRatesTable_Update'
	И в таблице 'RatesEditTable' я нажимаю на кнопку с именем 'RatesEditTableRatesTable_Write'
	И в таблице 'RatesViewTable' я нажимаю на кнопку с именем 'RatesTable_ChangeModeWithoutSave'		
	* EUR
		И в таблице 'RatesEditTable' я перехожу к строке:
			| "Currency" | "Multiplier" | "Rate period"   |
			| 'EUR'    | '1.0000'    | "January 2024" |
		И в таблице 'RatesEditTable' я выбираю текущую строку
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodStart_CurrentValue' я ввожу текст '90.7932'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodEnd_CurrentValue' я ввожу текст '92.2963'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriod_CurrentValue' я ввожу текст '90.4971'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' я ввожу текст '90.4537'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' я ввожу текст '91.5448'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' я ввожу текст '0'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' я ввожу текст '0'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' я ввожу текст '0'
		И в таблице 'RatesEditTable' я перехожу к строке:
			| "Currency" | "Multiplier" | "Rate period"    |
			| 'EUR'    | '1.0000'    | "February 2024" |
		И в таблице 'RatesEditTable' я выбираю текущую строку
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodStart_CurrentValue' я ввожу текст '92.2963'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodEnd_CurrentValue' я ввожу текст '90.3743'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriod_CurrentValue' я ввожу текст '89.9321'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' я ввожу текст '90.0038'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' я ввожу текст '91.3353'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' я ввожу текст '92.2963'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' я ввожу текст '90.4971'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' я ввожу текст '90.4537'	
		И в таблице 'RatesEditTable' я перехожу к строке:
			| "Currency" | "Multiplier" | "Rate period" |
			| 'EUR'    | '1.0000'    | "March 2024" |
		И в таблице 'RatesEditTable' я выбираю текущую строку
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodStart_CurrentValue' я ввожу текст '90.3743'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodEnd_CurrentValue' я ввожу текст '88.8821'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriod_CurrentValue' я ввожу текст '88.6820'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' я ввожу текст '88.7338'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' я ввожу текст '89.6282'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' я ввожу текст '90.3743'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' я ввожу текст '89.9321'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' я ввожу текст '90.0038'	
	* USD
		И в таблице 'RatesEditTable' я перехожу к строке:
			| "Currency" | "Multiplier" | "Rate period"   |
			| 'USD'    | '1.0000'    | "January 2024" |
		И в таблице 'RatesEditTable' я выбираю текущую строку
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodStart_CurrentValue' я ввожу текст '73.8757'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodEnd_CurrentValue' я ввожу текст '76.2527'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriod_CurrentValue' я ввожу текст '74.2204'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' я ввожу текст '74.1489'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' я ввожу текст '75.0642'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' я ввожу текст '0'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' я ввожу текст '0'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' я ввожу текст '0'
		И в таблице 'RatesEditTable' я перехожу к строке:
			| "Currency" | "Multiplier" | "Rate period"    |
			| 'USD'    | '1.0000'    | "February 2024" |
		И в таблице 'RatesEditTable' я выбираю текущую строку
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodStart_CurrentValue' я ввожу текст '76.2527'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodEnd_CurrentValue' я ввожу текст '74.4373'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriod_CurrentValue' я ввожу текст '74.3747'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' я ввожу текст '74.4435'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' я ввожу текст '75.3450'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' я ввожу текст '76.2527'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' я ввожу текст '74.2204'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' я ввожу текст '74.1489'	
		И в таблице 'RatesEditTable' я перехожу к строке:
			| "Currency" | "Multiplier" | "Rate period" |
			| 'USD'    | '1.0000'    | "March 2024" |
		И в таблице 'RatesEditTable' я выбираю текущую строку
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodStart_CurrentValue' я ввожу текст '74.4373'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPeriodEnd_CurrentValue' я ввожу текст '75.7023'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriod_CurrentValue' я ввожу текст '74.4035'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodCentralBank_CurrentValue' я ввожу текст '74.3689'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPeriodIFRS_CurrentValue' я ввожу текст '75.0698'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableRateAtPreviousPeriodEnd_CurrentValue' я ввожу текст '74.4373'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriod_CurrentValue' я ввожу текст '74.3747'
		И в таблице 'RatesEditTable' в поле с именем 'RatesEditTableAverageRateForPreviousPeriodCentralBank_CurrentValue' я ввожу текст '74.4435'	
	И в таблице 'RatesEditTable' я завершаю редактирование строки
	И в таблице 'RatesEditTable' я нажимаю на кнопку с именем 'RatesEditTableRatesTable_Write'

Сценарий: Я нахожу и выбираю документ управления отчетным периодом по сценарию "TheScenario" и периоду начала "ThePeriod"

	Тогда открылось окно "Reporting period management"		
	И Я в списке "Управление отчетным периодом" по полю "Scenario" ищу элемент "[TheScenario]" "Exact match"
	И Я в списке "Reporting period management" по полю "Start period" ищу элемент "[ThePeriod]" "At the beginning of the line"	
	Тогда в таблице 'List' количество строк "равно" 1
	И в таблице 'List' я выбираю текущую строку
