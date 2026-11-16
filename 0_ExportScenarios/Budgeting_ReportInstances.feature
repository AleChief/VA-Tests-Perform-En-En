#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для работы с подсистемой "Budgeting" - "Report instances"

Сценарий: Я создаю экземпляр отчета для вида отчета 'TheReportKind' сценарий 'TheScenario' период 'TheStartDate' 'TheEndDate' периодичность 'TheFrequency' организация 'TheBusinessUnit' проект 'TheProject' аналитики 'TheDimension1' 'TheDimension2' 'TheDimension3' 'TheDimension4' 'TheDimension5' 'TheDimension6' 

	* Откроем форму ключевых реквизитов
		Если текущее окно имеет заголовок "Specify key document attributes" Тогда
			// Форма уже открыта
		Иначе
			И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Report instances"
			Тогда открылось окно "Report instances"
			И я нажимаю кнопку очистить у поля с именем 'SavedSetting'
			И я нажимаю на кнопку с именем 'FormCreate'

	* Заполняем ключевые реквизиты
		Тогда открылось окно "Specify key document attributes"
		И из выпадающего списка с именем 'ReportKind' я выбираю по строке '[TheReportKind]'				
		И из выпадающего списка с именем 'Scenario' я выбираю по строке '[TheScenario]'
		И из выпадающего списка с именем 'ReportFrequency' я выбираю точное значение '[TheFrequency]'
		И я нажимаю на кнопку с именем 'ChangePeriod'
		Тогда открылось окно "Select period"
		И в поле с именем 'DateBegin' я ввожу текст '[TheStartDate]'
		И в поле с именем 'DateEnd' я ввожу текст '[TheEndDate]'
		И я нажимаю на кнопку с именем 'Select'
		Тогда открылось окно "Specify key document attributes *"
		И я нажимаю кнопку выбора у поля с именем 'Organization'
		И Я выбираю организацию '[TheBusinessUnit]'
		Тогда открылось окно "Specify key document attributes *"
		Если 'НЕ ПустаяСтрока("[TheProject]")' Тогда
			И из выпадающего списка с именем 'Project' я выбираю по строке '[TheProject]'
		Если 'НЕ ПустаяСтрока("[TheDimension1]")' Тогда
			И из выпадающего списка с именем 'Dimension1' я выбираю по строке '[TheDimension1]'
		Если 'НЕ ПустаяСтрока("[TheDimension2]")' Тогда
			И из выпадающего списка с именем 'Dimension2' я выбираю по строке '[TheDimension2]'
		Если 'НЕ ПустаяСтрока("[TheDimension3]")' Тогда
			И из выпадающего списка с именем 'Dimension3' я выбираю по строке '[TheDimension3]'
		Если 'НЕ ПустаяСтрока("[TheDimension4]")' Тогда
			И из выпадающего списка с именем 'Dimension4' я выбираю по строке '[TheDimension4]'
		Если 'НЕ ПустаяСтрока("[TheDimension5]")' Тогда
			И из выпадающего списка с именем 'Dimension5' я выбираю по строке '[TheDimension5]'
		Если 'НЕ ПустаяСтрока("[TheDimension6]")' Тогда
			И из выпадающего списка с именем 'Dimension6' я выбираю по строке '[TheDimension6]'
		Когда открылось окно "Specify key document attributes *"
		И я нажимаю на кнопку с именем 'FormApplyAndClose'
		
		И Открылся экземпляр отчета для вида отчета '[TheReportKind]' валюта '*' организация '[TheBusinessUnit]' сценарий '[TheScenario]' периодичность '[TheFrequency]' проект '[TheProject]' аналитики '[TheDimension1]' '[TheDimension2]' '[TheDimension3]' '[TheDimension4]' '[TheDimension5]' '[TheDimension6]' 	

Сценарий: Я открываю первый экземпляр отчета для вида отчета 'TheReportKind'

	И Я нахожу в списке вид отчета с именем '[TheReportKind]'
	И в таблице 'ReportKindList' я нажимаю на кнопку с именем 'ReportKindListOpenInstancesList'
	Тогда открылось окно "Report instances"
	И в таблице 'List' я выбираю текущую строку

Сценарий: Я открываю экземпляр отчета по сохраненной настройке 'TheName'

	И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Report instances"
	Тогда открылось окно "Report instances"
	И я нажимаю кнопку выбора у поля с именем 'SavedSetting'
	И из выпадающего списка с именем 'SavedSetting' я выбираю точное значение '[TheName]'
	И в таблице 'List' я выбираю текущую строку

Сценарий: В экземпляре отчета я удаляю все существующие версии

	И я нажимаю на кнопку с именем 'FormVersionsManagement'
	Тогда открылось окно "Indicator version management"
	И Пока в таблице 'List' количество строк ">" 0 Тогда
		И я нажимаю на кнопку с именем 'ListDeleteVersions'
		Если открылось окно "1C:Enterprise" Тогда
			И я нажимаю на кнопку с именем 'Button0'
		Если открылось окно "1C:Enterprise" Тогда
			И я нажимаю на кнопку с именем 'Button0'
	Тогда открылось окно "Indicator version management*"
	И Я закрываю окно "Indicator version management*"

Сценарий: Движения экземпляра отчета стали равны "ThePath"

	И я нажимаю на кнопку с именем 'FormDocumentRegisterRecords'
	Тогда открылось окно "Flat table of indicator values with attributes"
	И я жду когда в табличном документе 'ReportSpreadsheetDocument' заполнится ячейка 'R2C1' в течение 60 секунд
	Дано Табличный документ 'ReportSpreadsheetDocument' равен макету "[ThePath]" по шаблону
	И Я закрываю окно "Flat table of indicator values with attributes"
