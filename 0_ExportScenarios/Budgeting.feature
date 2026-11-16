#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для работы с подсистемой "Budgeting"

Сценарий: Я вставляю из буфера обмена в макете

	И я очищаю окно сообщений пользователю		
	И я делаю 3 раз
		И я нажимаю на кнопку с именем 'InsertTemplateFromClipboard'
		Если в текущем окне есть сообщения пользователю Тогда
			И Пауза 3
		Иначе
			И я прерываю цикл

Сценарий: Я ввожу значение 'TheValue' в ячейку 'TheCell'

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	И в табличный документ 'SpreadsheetFieldTemlate' я ввожу текст '[TheValue]'

Сценарий: Я ввожу значение 'TheValue' с раскрытием показателей в ячейку 'TheCell'

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И я нажимаю на кнопку с именем 'DisplayADrilldown'

	Тогда открылось окно "Drill down indicators: *"
	И в таблице 'IndicatorsDrilldown' я выбираю текущую строку
	И в таблице 'IndicatorsDrilldown' в поле с именем 'Value1' я ввожу текст '[TheValue]'
	И я нажимаю на кнопку с именем 'FormOKButton'

	И я жду закрытия окна "Drill down indicators: *" в течение 20 секунд	

Сценарий: Я добавляю значения с раскрытием показателей в ячейку 'TheCell'

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И я нажимаю на кнопку с именем 'DisplayADrilldown'
	
	Тогда открылось окно "Drill down indicators: *"
	Если элемент 'IndicatorsDrilldownPeriodsInColumns' доступен для редактирования Тогда
		Если у элемента формы с именем 'IndicatorsDrilldownPeriodsInColumns' не установлена пометка Тогда
			И в таблице 'IndicatorsDrilldown' я нажимаю на кнопку с именем 'IndicatorsDrilldownPeriodsInColumns'

	И я заполняю таблицу 'IndicatorsDrilldown' данными
		| 'Table' |

	И я нажимаю на кнопку с именем 'FormOKButton'
	И я жду закрытия окна "Drill down indicators: *" в течение 20 секунд

Сценарий: Я ввожу комментарий 'TheComment' в ячейку 'TheCell'

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И я нажимаю на кнопку с именем 'LeaveCommentToIndicator'

	Тогда открылось окно "Комментарии"
	И в поле с именем 'NewComment' я ввожу текст '[TheComment]'

	И я нажимаю на кнопку с именем 'WriteComment'

Сценарий: Я изменяю значение на 'TheValue' процентов в ячейке 'TheCell'

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И я нажимаю на кнопку с именем 'ChangeIndicators'

	Тогда открылось окно "Change values"
	И я меняю значение переключателя с именем 'AdjustmentKind' на "Percentage"
	И в поле с именем 'ValueAdjustments' я ввожу текст '[TheValue]'
	И я нажимаю на кнопку с именем 'Apply'

Сценарий: Я изменяю значение на 'TheValue' в ячейке 'TheCell'

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И я нажимаю на кнопку с именем 'ChangeIndicators'
	
	Тогда открылось окно "Change values"
	И я меняю значение переключателя с именем 'AdjustmentKind' на "Value"
	И в поле с именем 'ValueAdjustments' я ввожу текст '[TheValue]'
	И я нажимаю на кнопку с именем 'Apply'

Сценарий: Я выбираю показатель с кодом 'TheIndicatorCode' вида отчета 'TheReportKindName'

	Когда открылось окно "Report indicators"
	И я нажимаю кнопку выбора у поля с именем 'ReportKind'
	Тогда открылось окно "Report types"
	И я нажимаю на кнопку с именем 'FormFind'
	Тогда открылось окно "Find"
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
	И я меняю значение переключателя с именем 'CompareType' на "Exact match"
	И в поле с именем 'Pattern' я ввожу текст '[TheReportKindName]'
	И я нажимаю на кнопку с именем 'Find'
	Тогда открылось окно "Report types"
	И в таблице 'List' я выбираю текущую строку

	И Я выбираю показатель с кодом '[TheIndicatorCode]'
	
Сценарий: Я открываю управление процессом подготовки отчетности для сценария 'TheScenario'

	И В командном интерфейсе я выбираю "Processes and approval" "Reporting preparation management"
	Тогда открылось окно "Reporting preparation management"
	И я нажимаю кнопку выбора у поля с именем 'PeriodManagement'
	И Я в списке "Reporting period management" по полю "Scenario" ищу и выбираю элемент '[TheScenario]' "Exact match" 
	Тогда открылось окно "Reporting preparation management"
	И в таблице 'StepsTree' я нажимаю на кнопку с именем 'StepsTreeExpandAll'

Сценарий: Я добавляю право 'TheRule' для вида отчета 'TheReportKind' пользователя 'TheUser' организации 'TheBusinessUnit' 

	И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Report type access matrix"
	Тогда открылось окно "Customizable reporting user access rights"
	И из выпадающего списка с именем 'ОтборВидыОтчетов' я выбираю по строке '[TheReportKind]'	
	И из выпадающего списка с именем 'ОтборПользователи' я выбираю по строке '[TheUser]'
	И из выпадающего списка с именем 'FilterCompanies' я выбираю по строке '[TheBusinessUnit]'
	И я меняю значение переключателя с именем 'ShowInColumnsNumber' на 'companies'
	И я устанавливаю флаг с именем 'ShouldShowReportTemplates'
	
	И я нажимаю на кнопку с именем 'FormUpdateTable'
	И в табличном документе 'CustomField' я перехожу к ячейке 'DetailsReportKind'
	И в табличном документе 'CustomField' я делаю двойной клик на текущей ячейке
	Тогда открылось окно "Select access kind"
	И Я запоминаю значение выражения '[TheRule]' в переменную 'ТекущеПравило'
	И в таблице 'List' я перехожу к строке:
		| "Reference"          |
		| '$ТекущеПравило$' |
	И в таблице 'List' я выбираю текущую строку

	Тогда открылось окно "Customizable reporting user access rights *"
	И я нажимаю на кнопку с именем 'FormApplySettings'
	Тогда открылось окно "Customizable reporting user access rights"
	И я нажимаю на кнопку с именем 'RereadData'

	Когда открылось окно "Customizable reporting user access rights"
	И Я закрываю окно "Customizable reporting user access rights"

Сценарий: Я добавляю право 'TheRule' для вида отчета 'TheReportKind' пользователя 'TheUser' по всем организациям

	И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Report type access matrix"
	Тогда открылось окно "Customizable reporting user access rights"
	И из выпадающего списка с именем 'ОтборВидыОтчетов' я выбираю по строке '[TheReportKind]'
	И из выпадающего списка с именем 'ОтборПользователи' я выбираю по строке '[TheUser]'
	И я нажимаю кнопку очистить у поля с именем 'FilterCompanies'		
	И я меняю значение переключателя с именем 'ShowInColumnsNumber' на 'companies'
	И я устанавливаю флаг с именем 'ShouldShowReportTemplates'

	И я нажимаю на кнопку с именем 'FormUpdateTable'
	И в табличном документе 'CustomField' я перехожу к ячейке 'ReportKind'
	И в табличном документе 'CustomField' я делаю двойной клик на текущей ячейке
	Тогда открылось окно "Set up access rights to report type"
	И в таблице 'ТаблицаНастроекПрав' я нажимаю на кнопку с именем 'ТаблицаНастроекПравЗаполнитьПраваДоступа'
	Тогда открылось окно "Select access kind"
	И Я запоминаю значение выражения '[TheRule]' в переменную 'ТекущеПравило'
	И в таблице 'List' я перехожу к строке:
		| "Reference"          |
		| '$ТекущеПравило$' |
	И в таблице 'List' я выбираю текущую строку
	Тогда открылось окно "Set up access rights to report type"
	И я нажимаю на кнопку с именем 'FormOK'

	Тогда открылось окно "Customizable reporting user access rights *"
	И я нажимаю на кнопку с именем 'FormApplySettings'
	Тогда открылось окно "Customizable reporting user access rights"
	И я нажимаю на кнопку с именем 'RereadData'

	Когда открылось окно "Customizable reporting user access rights"
	И Я закрываю окно "Customizable reporting user access rights"

Сценарий: Я создаю группу аналитических отчетов с кодом 'TheCode' именем 'TheName' родителем 'TheParent'

	* Открываем форму справочника
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Analytical reports"

	* Удаляем элемент
		И Я в списке "Analytical reports" по полю "Description" ищу элемент '[TheName]' "Exact match" 
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление	
				И Я удаляю текущую строку в списке 'List'
			* Переименовываем
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "* (Analytical reports)"
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю кнопку очистить у поля с именем 'Code'
				Тогда открылось окно "1C:Enterprise"
				И я нажимаю на кнопку с именем 'Button0'				
				И в поле с именем 'Code' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Analytical reports) *" в течение 20 секунд
		И я выбираю пункт контекстного меню с именем 'ListContextMenuCancelSearch' на элементе формы с именем "List"

	* Создаем элемент
		Когда открылось окно "Analytical reports"
		И я нажимаю на кнопку с именем 'FormCreateFolder'
		Тогда открылось окно 'Analytical reports (create group)'
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И я нажимаю кнопку очистить у поля с именем 'Code'
		Тогда открылось окно "1C:Enterprise"
		И я нажимаю на кнопку с именем 'Button0'				
		И в поле с именем 'Code' я ввожу текст '[TheCode]'
		Если 'IsBlankString("[TheParent]")' Тогда
			И я нажимаю кнопку очистить у поля с именем 'Parent'
		Иначе
			И из выпадающего списка с именем 'Parent' я выбираю по строке '[TheParent]'									
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна 'Analytical reports (create group) *' в течение 20 секунд

Сценарий: Я создаю аналитический отчет с кодом 'TheCode' вид отчета 'TheReportKind' период 'ThePeriod' организация 'TheBusinessUnit' родитель 'TheParent'

	* Открываем форму справочника
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Analytical reports"

	* Удаляем элемент
		И Я в списке "Analytical reports" по полю "Description" ищу элемент '[TheReportKind] ([TheBusinessUnit])' "Exact match" 
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление	
				И Я удаляю текущую строку в списке 'List'
			* Переименовываем
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "* (Analytical report)"
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю кнопку очистить у поля с именем 'Code'
				Тогда открылось окно "1C:Enterprise"
				И я нажимаю на кнопку с именем 'Button0'				
				И в поле с именем 'Code' я ввожу значение переменной 'UID'							
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Analytical report) *" в течение 20 секунд

	* Создаем элемент
		Когда открылось окно "Analytical reports"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Analytical report (create)"
		И в поле с именем 'Description' я ввожу текст '[TheReportKind] ([TheBusinessUnit])'
		И я нажимаю кнопку очистить у поля с именем 'Code'
		Тогда открылось окно "1C:Enterprise"
		И я нажимаю на кнопку с именем 'Button0'				
		И в поле с именем 'Code' я ввожу текст '[TheCode]'	
		Если 'IsBlankString("[TheParent]")' Тогда
			И я нажимаю кнопку очистить у поля с именем 'Parent'
		Иначе
			И из выпадающего списка с именем 'Parent' я выбираю по строке '[TheParent]'
		И я нажимаю на кнопку с именем 'FormWrite'

	* Настраиваем элемент	
		Когда открылось окно "[TheReportKind] ([TheBusinessUnit]) (Analytical report)"
		* Источник данных
			И я нажимаю кнопку выбора у поля с именем 'ReportDataSource'
			Тогда открылось окно "Select data type"
			И в таблице "" я выбираю текущую строку		
			Тогда открылось окно "Queries to infobase"
			И я нажимаю на кнопку с именем 'FormCreate'
			Тогда открылось окно "Query to infobase (create)"
			И в поле с именем 'Description' я ввожу текст '[TheReportKind] ([TheBusinessUnit])'
			И я нажимаю на кнопку с именем 'Write'
			Тогда открылось окно "[TheReportKind] ([TheBusinessUnit]) (Query to infobase)"
			И я перехожу к закладке с именем 'CaclSetup'
			И я нажимаю на кнопку с именем 'FormGetIndicatorsValues'
			И я нажимаю на кнопку с именем 'WriteAndClose'
			И я жду закрытия окна "[TheReportKind] ([TheBusinessUnit]) (Query to infobase)" в течение 20 секунд
			Тогда открылось окно "Queries to infobase"
			И в таблице 'List' я выбираю текущую строку
		Тогда открылось окно "[TheReportKind] ([TheBusinessUnit]) (Analytical report) *"
		И я нажимаю на кнопку с именем 'FormWrite'

	* Редактирование схемы	
		И я нажимаю на кнопку с именем 'EditSchemaOption'
		Тогда открылось окно "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))"
		
		И в таблице 'RowsGroupingTableBoxPageTable' я нажимаю на кнопку с именем 'RowsGroupingTableBoxPageTableAddGroupingField'
		И в таблице 'RowsGroupingTableBoxPageTable' из выпадающего списка с именем 'ТабличноеПолеГруппировкиСтрокСтраницаТаблицаПоле' я выбираю точное значение "Организация"
		И в таблице 'RowsGroupingTableBoxPageTable' из выпадающего списка с именем 'ТабличноеПолеГруппировкиСтрокСтраницаТаблицаТипГруппировки' я выбираю точное значение "Без иерархии"
		И в таблице 'RowsGroupingTableBoxPageTable' я нажимаю на кнопку с именем 'RowsGroupingTableBoxPageTableAddGroupingField'
		И в таблице 'RowsGroupingTableBoxPageTable' из выпадающего списка с именем 'RowsGroupingTableBoxPageTableField' я выбираю точное значение "Report period"
		И в таблице 'RowsGroupingTableBoxPageTable' из выпадающего списка с именем 'ТабличноеПолеГруппировкиСтрокСтраницаТаблицаТипГруппировки' я выбираю точное значение "Без иерархии"
		
		И в таблице 'SelectedFieldsPageTable' я нажимаю на кнопку с именем 'SelectedFieldsPageTableAddSelectedField'
		И в таблице 'SelectedFieldsPageTable' из выпадающего списка с именем 'SelectedFieldsPageTableField' я выбираю точное значение "Indicator"
		И в таблице 'SelectedFieldsPageTable' я завершаю редактирование строки
		И в таблице 'SelectedFieldsPageTable' я нажимаю на кнопку с именем 'SelectedFieldsPageTableAddSelectedField'
		И в таблице 'SelectedFieldsPageTable' из выпадающего списка с именем 'SelectedFieldsPageTableField' я выбираю точное значение "Value"

		И я перехожу к закладке с именем 'FilterAndOrder'
		И в таблице 'TableBoxFilterPageWithoutParameters' я нажимаю на кнопку с именем 'TableBoxFilterPageWithoutParametersAddFilterItem'
		И в таблице 'TableBoxFilterPageWithoutParameters' из выпадающего списка с именем 'ТабличноеПолеОтборСтраницаБезПараметровЛевоеЗначение' я выбираю точное значение "Организация"
		И в таблице 'TableBoxFilterPageWithoutParameters' из выпадающего списка с именем 'ТабличноеПолеОтборСтраницаБезПараметровВидСравнения' я выбираю точное значение "Равно"
		И в таблице 'TableBoxFilterPageWithoutParameters' я нажимаю кнопку выбора у реквизита с именем 'TableBoxFilterPageWithoutParametersRightValue'
		И Я выбираю организацию '[TheBusinessUnit]'
		Тогда открылось окно "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))"
		И в таблице 'TableBoxFilterPageWithoutParameters' я нажимаю на кнопку с именем 'TableBoxFilterPageWithoutParametersAddFilterItem'
		И в таблице 'TableBoxFilterPageWithoutParameters' из выпадающего списка с именем 'TableBoxFilterPageWithoutParametersLeftValue' я выбираю точное значение "Report period"
		И в таблице 'TableBoxFilterPageWithoutParameters' из выпадающего списка с именем 'ТабличноеПолеОтборСтраницаБезПараметровВидСравнения' я выбираю точное значение "Равно"
		И в таблице 'TableBoxFilterPageWithoutParameters' я нажимаю кнопку выбора у реквизита с именем 'TableBoxFilterPageWithoutParametersRightValue'
		И Я в списке "Periods" по полю "Description" ищу и выбираю элемент '[ThePeriod]' "At the beginning of the line"
		Когда открылось окно "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))"
		И в таблице 'TableBoxFilterPageWithoutParameters' я нажимаю на кнопку с именем 'TableBoxFilterPageWithoutParametersAddFilterItem'
		И в таблице 'TableBoxFilterPageWithoutParameters' из выпадающего списка с именем 'TableBoxFilterPageWithoutParametersLeftValue' я выбираю точное значение "Currency"
		И в таблице 'TableBoxFilterPageWithoutParameters' из выпадающего списка с именем 'ТабличноеПолеОтборСтраницаБезПараметровВидСравнения' я выбираю точное значение "Равно"
		И в таблице 'TableBoxFilterPageWithoutParameters' из выпадающего списка с именем 'TableBoxFilterPageWithoutParametersRightValue' я выбираю точное значение "RUB"
		И в таблице 'TableBoxFilterPageWithoutParameters' я завершаю редактирование строки
		Когда открылось окно "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))"
		И в таблице "Filter" я нажимаю на кнопку с именем 'FilterAddFilterItem'
		И в таблице "Filter" из выпадающего списка с именем "FilterLeftValue" я выбираю по строке "Factor.Report type"
		И в таблице "Filter" я активизирую поле с именем "FilterRightValue"
		И в таблице "Filter" я нажимаю кнопку выбора у реквизита с именем "FilterRightValue"
		Тогда открылось окно "Select data type"
		И в таблице "" я выбираю текущую строку
		И Я в списке "Report types" по полю "Description" ищу и выбираю элемент '[TheReportKind]' "At the beginning of the line"
		
		Когда открылось окно "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))"
		И я перехожу к закладке с именем 'OrderPage'
		И в таблице 'Table_SortFields' я нажимаю на кнопку с именем 'Table_SortFieldsAddOrderItem'
		И в таблице 'Table_SortFields' из выпадающего списка с именем 'Таблица_ПоляСортировкиПоле' я выбираю по строке "Показатель.Строка.Порядковый номер"
		И в таблице 'Table_SortFields' я завершаю редактирование строки
		И в таблице 'Table_SortFields' я нажимаю на кнопку с именем 'Table_SortFieldsAddOrderItem'
		И в таблице 'Table_SortFields' из выпадающего списка с именем 'Таблица_ПоляСортировкиПоле' я выбираю по строке "Показатель.Колонка.Порядковый номер"
		И в таблице 'Table_SortFields' я завершаю редактирование строки				
		
		И я нажимаю на кнопку с именем 'FormOK'

	Тогда открылось окно "[TheReportKind] ([TheBusinessUnit]) (Analytical report)"
	И я нажимаю на кнопку с именем 'FormWrite'
	И я устанавливаю флаг с именем 'CustomSettings'
	И я нажимаю на кнопку с именем 'FormWrite'

	Тогда открылось окно "[TheReportKind] ([TheBusinessUnit]) (Analytical report)"
	И я нажимаю на кнопку с именем 'EditSchemaOption'
	Тогда открылось окно "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))"
	И я перехожу к закладке с именем 'OutputParametersPage'
	И в таблице "Table_OutputParameters" я перехожу к строке:
		| "Value" | "Use" | "Parameter"                               |
		| "Auto"     | "Нет"           | "Расположение общих итогов по вертикали" |
	И в таблице 'Table_OutputParameters' я активизирую поле с именем 'Table_OutputParametersValue'
	И в таблице 'Table_OutputParameters' я выбираю текущую строку
	И в таблице 'Table_OutputParameters' из выпадающего списка с именем 'Таблица_ПараметрыВыводаЗначение' я выбираю точное значение "Нет"
	И в таблице 'Table_OutputParameters' я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'FormOK'

	Тогда открылось окно "[TheReportKind] ([TheBusinessUnit]) (Analytical report)"
	И я нажимаю на кнопку с именем 'FormWriteAndClose'
	И я жду закрытия окна "[TheReportKind] ([TheBusinessUnit]) (Analytical report)" в течении 20 секунд
