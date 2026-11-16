#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для работы с подсистемой "Budgeting" - "Pivot table"

Сценарий: Я в сводной таблице перемещаю аналитику с именем 'TheDimensionName' вверх

	Тогда открылось окно "Set up field location"
	И Я запоминаю значение выражения '[TheDimensionName]' в переменную "DimensionName"
	
	И в таблице 'TableRows1' я перехожу к строке:
		| "Horizontally (in rows)" |
		| '$DimensionName$'      |
	
	И я нажимаю на кнопку с именем 'RowsMoveUp'
	И я нажимаю на кнопку с именем 'RowsMoveUp'
	И я нажимаю на кнопку с именем 'RowsMoveUp'
	И я нажимаю на кнопку с именем 'RowsMoveUp'
	И я нажимаю на кнопку с именем 'RowsMoveUp'
	И я нажимаю на кнопку с именем 'RowsMoveUp'

Сценарий: Я октрываю сводную таблицу отчета с именем 'TheReportKindName'

	И Я нахожу в списке вид отчета с именем '[TheReportKindName]'

	Когда открылось окно "Report types and templates"
	И я запоминаю строку '[TheReportKindName]' в переменную 'ReportKindName'
	И в таблице 'List' я перехожу к строке по шаблону:
		| "Description"                       |
		| '$ReportKindName$ (сводная таблица)' |
	И я нажимаю на кнопку с именем 'SwitchToDataDisplayMode'
	И я жду открытия формы "Pivot table: *" в течение 30 секунд

	И Открылась сводная таблица для вида отчета 'TheReportKindName'	
		
Сценарий: Я устанавливаю отбор сводной таблицы 'TheFilterName' со значением 'TheFilterValue'

	Когда открылось окно "Pivot table: *"
	И я нажимаю на гиперссылку с именем 'FilterHeading'
	И я жду открытия формы "Pivot table: *" в течение 20 секунд
	Если элемент '[TheFilterName]' присутствует на форме Тогда
		И из выпадающего списка с именем '[TheFilterName]' я выбираю по строке '[TheFilterValue]'
		И я нажимаю на кнопку с именем 'UpdateTabData1'
	ИначеЕсли элемент 'Item_[TheFilterName]' присутствует на форме Тогда
		И из выпадающего списка с именем 'Item_[TheFilterName]' я выбираю по строке '[TheFilterValue]'
		И я нажимаю на кнопку с именем 'UpdateTabData1'	
	И я жду открытия формы "Pivot table: *" в течение 20 секунд

Сценарий: Я устанавливаю отборы сводной таблицы: дата начала 'TheStartDate', дата конца 'TheEndDate', валюта 'TheCurrency', сценарий 'TheScenario', организация 'TheBusinessUnit'	

	Когда открылось окно "Pivot table: *"
	И я нажимаю на гиперссылку с именем 'FilterHeading'
	И я нажимаю на кнопку с именем 'ChangePeriod'
	Тогда открылось окно "Select period"
	И в поле с именем 'DateBegin' я ввожу текст '[TheStartDate]'
	И я перехожу к следующему реквизиту
	И в поле с именем 'DateEnd' я ввожу текст '[TheEndDate]'
	И я нажимаю на кнопку с именем 'Select'
	Тогда открылось окно "Pivot table: *"
	И из выпадающего списка с именем 'DisplayCurrency' я выбираю по строке '[TheCurrency]'
	И из выпадающего списка с именем 'Элемент_Сценарий' я выбираю по строке '[TheScenario]'
	И из выпадающего списка с именем 'Item_Organization' я выбираю по строке '[TheBusinessUnit]'
	И я нажимаю на кнопку с именем 'UpdateTabData1'
	И я жду открытия формы "Pivot table: *" в течение 20 секунд
