#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для работы с подсистемой "Budgeting" - "Report types and templates"

Сценарий: Я открываю вид отчета с именем 'TheReportKindName'

	И Я нахожу в списке вид отчета с именем '[TheReportKindName]'
	И в таблице 'ReportKindList' я выбираю текущую строку
	Тогда открылось окно "* (Report types)"

Сценарий: Я создаю группу видов отчетов с именем 'TheReportKindName' и родителем 'TheReportKindParentName'

	* Открываем список
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Report types and templates"

	* Удаляем текущий элемент		
		Тогда открылось окно "Report types and templates"
		И в таблице 'ReportKindList' я нажимаю на кнопку с именем 'ReportKindListFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Report type"
		И я меняю значение переключателя с именем 'CompareType' на "Anywhere in the line"
		И в поле с именем 'Pattern' я ввожу текст '[TheReportKindName]'
		И я нажимаю на кнопку с именем 'Find'
		И Пока в таблице 'ReportKindList' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'ReportKindList'
				И я жду открытия окна "Report types and templates" в течение 120 секунд				
			* Перименовываем
				И Я запоминаю значение выражения '"Удалить_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'		
				И в таблице 'ReportKindList' я выбираю текущую строку
				Когда открылось окно "* (Report types)"		
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И в поле с именем 'Code' я ввожу значение переменной 'UID'
				И в поле с именем 'Parent' я ввожу текст ''						
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Report types)" в течение 20 секунд

	* Создаем новую группу отчетов
		Тогда открылось окно "Report types and templates"
		И в таблице 'ReportKindList' я нажимаю на кнопку с именем 'ReportKindListCreateFolder'
		Тогда открылось окно "Report types (create group)"
		И в поле с именем 'Description' я ввожу текст '[TheReportKindName]'
		Если 'СтрДлина("[TheReportKindParentName]") = 0' Тогда
			И в поле с именем 'Parent' я ввожу текст ''
		Иначе
			И из выпадающего списка с именем 'Parent' я выбираю по строке '[TheReportKindParentName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Report types (create group) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Report types and templates"
		И Я закрываю окно "Report types and templates"	

Сценарий: Я создаю вид отчета с именем 'TheReportKindName' и родителем 'TheReportKindParentName'

	* Открываем список
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Report types and templates"	

	* Удаляем текущий элемент	
		Тогда открылось окно "Report types and templates"
		И в таблице 'ReportKindList' я нажимаю на кнопку с именем 'ReportKindListFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Report type"
		И я меняю значение переключателя с именем 'CompareType' на "Anywhere in the line"
		И в поле с именем 'Pattern' я ввожу текст '[TheReportKindName]'
		И я нажимаю на кнопку с именем 'Find'
		И Пока в таблице 'ReportKindList' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'ReportKindList'
			* Перименовываем
				И Я запоминаю значение выражения '"Удалить_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'		
				И в таблице 'ReportKindList' я выбираю текущую строку
				Тогда открылось окно "* (Report types)"		
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И в поле с именем 'FullDescr' я ввожу значение переменной 'UID'
				И в поле с именем 'Code' я ввожу значение переменной 'UID'
				И в поле с именем 'Parent' я ввожу текст ''
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Report types)" в течение 20 секунд

	* Создаем новый элемент
		Тогда открылось окно "Report types and templates"
		И в таблице 'ReportKindList' я нажимаю на кнопку с именем 'ReportKindListCreate'
		Тогда открылось окно "Report types (create)"
		И в поле с именем 'Description' я ввожу текст '[TheReportKindName]'
		Если 'СтрДлина("[TheReportKindParentName]") = 0' Тогда
			И в поле с именем 'Parent' я ввожу текст ''
		Иначе
			И из выпадающего списка с именем 'Parent' я выбираю по строке '[TheReportKindParentName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Report types (create group) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Report types and templates"
		И Я закрываю окно "Report types and templates"

Сценарий: Я для вида отчета 'TheReportKindName' изменяю флаг 'TheFlagName' 

	И Я нахожу в списке вид отчета с именем '[TheReportKindName]'
	И в таблице 'ReportKindList' я выбираю текущую строку
	Тогда открылось окно "* (Report types)"

	И я изменяю флаг с именем '[TheFlagName]'
	И я нажимаю на кнопку с именем 'FormWriteAndClose'
	И я жду закрытия окна "[TheReportKindName] (Report types)" в течение 20 секунд	

	Тогда открылось окно "Report types and templates"
	И я закрываю окно "Report types and templates"

Сценарий: Я для вида отчета 'TheReportKindName' создаю бланк по умолчанию

	* Откроем вид отчета
		Если текущее окно имеет заголовок "[TheReportKindName] (Report types)" Тогда
			// Форма уже открыта
		Иначе
			И Я нахожу в списке вид отчета с именем '[TheReportKindName]'
			И в таблице 'ReportKindList' я выбираю текущую строку
			Тогда открылось окно "* (Report types)"
	
	* Формируем Бланк экземпляра отчета
		Когда открылось окно "[TheReportKindName] (Report types)"
		И я перехожу к закладке с именем 'DefaultSettings'
		И я нажимаю на кнопку открытия поля с именем 'DefaultTemplateToDisplay'
		Тогда открылось окно "Template [TheReportKindName] report type: [TheReportKindName]"
		И я нажимаю на кнопку с именем 'CreateTemplateWithDesigner'
		Если открылось окно "1C:Enterprise" Тогда
			И я нажимаю на кнопку с именем 'Button0'		
		Тогда открылось окно "Report structure"
		И из выпадающего списка с именем 'TemplateOfReportsTemplatesAppearance' я выбираю по строке 'Classic'
		И я изменяю флаг с именем 'DisplayBankingDetails'
		И я нажимаю на кнопку с именем 'FormSelect'	

	* Записываем бланк	
		Тогда открылось окно "Template [TheReportKindName] report type: [TheReportKindName] *"
		И я нажимаю на кнопку с именем 'FormButtonWriteAndClose'
		И я жду закрытия окна "Template [TheReportKindName] report type: [TheReportKindName] *" в течение 20 секунд		

Сценарий: Я для вида отчета 'TheReportKindName' в бланке для группы раскрытия с адресом 'TheCell' задаю сортировку 'TheSortingObject' 'TheSortingProperty'

	* Откроем вид отчета
		Если текущее окно имеет заголовок "[TheReportKindName] (Report types)" Тогда
			// Форма уже открыта
		Иначе
			И Я нахожу в списке вид отчета с именем '[TheReportKindName]'
			И в таблице 'ReportKindList' я выбираю текущую строку
			Тогда открылось окно "* (Report types)"
	
	* Открываем бланк по умолчанию
		Когда открылось окно "[TheReportKindName] (Report types)"
		И я перехожу к закладке с именем 'DefaultSettings'
		И я нажимаю на кнопку открытия поля с именем 'DefaultTemplateToDisplay'
		Тогда открылось окно "Template [TheReportKindName] report type: [TheReportKindName]"

	* Добавляем сортировку
		И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
		И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
		Тогда открылось окно "Set up dimension drilldown area"
		И я перехожу к закладке с именем 'SectionSort'
		И в таблице 'SettingsComposerSettingsOrder' я выбираю текущую строку
		И в таблице 'SettingsComposerSettingsOrder' из выпадающего списка с именем 'SettingsComposerSettingsOrderField' я выбираю по строке '[TheSortingObject].[TheSortingProperty]'
		И в таблице 'SettingsComposerSettingsOrder' я завершаю редактирование строки
		И я нажимаю на кнопку с именем 'Apply'
				
	* Записываем бланк	
		Тогда открылось окно "Template [TheReportKindName] report type: [TheReportKindName] *"
		И я нажимаю на кнопку с именем 'FormButtonWriteAndClose'
		И я жду закрытия окна "Template [TheReportKindName] report type: [TheReportKindName] *" в течение 20 секунд

Сценарий: Я для вида отчета 'TheReportKindName' в бланке для группы раскрытия с адресом 'TheCell' меняю сортировку 'TheSortingIinitialObject' 'TheSortingIinitialProperty' на сортировку 'TheSortingObject' 'TheSortingProperty'

	* Откроем вид отчета
		Если текущее окно имеет заголовок "[TheReportKindName] (Report types)" Тогда
			// Форма уже открыта
		Иначе
			И Я нахожу в списке вид отчета с именем '[TheReportKindName]'
			И в таблице 'ReportKindList' я выбираю текущую строку
			Тогда открылось окно "* (Report types)"
	
	* Открываем бланк по умолчанию
		Когда открылось окно "[TheReportKindName] (Report types)"
		И я перехожу к закладке с именем 'DefaultSettings'
		И я нажимаю на кнопку открытия поля с именем 'DefaultTemplateToDisplay'
		Тогда открылось окно "Template [TheReportKindName] report type: [TheReportKindName]"

	* Меняем сортировку
		И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
		И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
		Тогда открылось окно "Set up dimension drilldown area"
		И я перехожу к закладке с именем 'SectionSort'
		И Я запоминаю в переменную 'SortingIinitial' значение '[TheSortingIinitialObject].[TheSortingIinitialProperty]'
		И в таблице 'SettingsComposerSettingsOrder' я перехожу к строке:
			| "Field"              |
			| '$SortingIinitial$' |
		И в таблице 'SettingsComposerSettingsOrder' из выпадающего списка с именем 'SettingsComposerSettingsOrderField' я выбираю точное значение '[TheSortingObject].[TheSortingProperty]'
		И в таблице 'SettingsComposerSettingsOrder' я завершаю редактирование строки
		И я нажимаю на кнопку с именем 'Apply'
				
	* Записываем бланк	
		Тогда открылось окно "Template [TheReportKindName] report type: [TheReportKindName] *"
		И я нажимаю на кнопку с именем 'FormButtonWriteAndClose'
		И я жду закрытия окна "Template [TheReportKindName] report type: [TheReportKindName] *" в течение 20 секунд

Сценарий: Я для вида отчета 'TheReportKindName' создаю бланк для импорта по умолчанию

	* Откроем вид отчета
		Если текущее окно имеет заголовок "[TheReportKindName] (Report types)" Тогда
			// Форма уже открыта
		Иначе
			И Я нахожу в списке вид отчета с именем '[TheReportKindName]'
			И в таблице 'ReportKindList' я выбираю текущую строку
			Тогда открылось окно "* (Report types)"

	* Открываем бланк
		Тогда открылось окно "[TheReportKindName] (Report types)"
		И я перехожу к закладке с именем 'DefaultSettings'
		Когда открылось окно "[TheReportKindName] (Report types)"
		И я нажимаю на кнопку открытия поля с именем 'DefaultTemplateToImport'

	* Генерируем бланк
		Тогда Открылся бланк для вида отчета '[TheReportKindName]'
		И я нажимаю на кнопку с именем 'ShowIndicatorsPanel'
		И из выпадающего списка с именем 'TemplateToDisplay' я выбираю точное значение "To import and display"
		Тогда открылось окно "1C:Enterprise"
		И я нажимаю на кнопку с именем 'Button0'
		Тогда открылось окно "Report structure"
		И из выпадающего списка с именем 'TemplateOfReportsTemplatesAppearance' я выбираю по строке "Classic"
		И я снимаю флаг с именем 'DisplayBankingDetails'
		И я нажимаю на кнопку с именем 'FormSelect'

	* Записываем бланк
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'RecordButtonForm'

Сценарий: Я Для вида отчета 'TheReportKindName' открываю бланк сводной таблицы по умолчанию

	* Откроем вид отчета
		// Вариант открытия из формы
		Если текущее окно имеет заголовок "[TheReportKindName] (Report types)" Тогда
			// Форма уже открыта
		Иначе
			И Я нахожу в списке вид отчета с именем '[TheReportKindName]'
			И в таблице 'ReportKindList' я выбираю текущую строку
		Когда открылось окно "[TheReportKindName] (Report types)"
		И я перехожу к закладке с именем 'DefaultSettings'
		И я нажимаю на кнопку открытия поля с именем 'DefaultPivotTableTemplate'

	* Формируем Бланк сводной таблиц
		Тогда Открылся бланк сводной таблицы для вида отчета '[TheReportKindName]'
		
Сценарий: Я для вида отчета 'TheReportKindName' создаю бланк сводной таблицы по умолчанию с отборами 'TheFilter1' 'TheFilter2' 'TheFilter3'
	
	* Откроем вид отчета
		// Вариант открытия из формы
		Если текущее окно имеет заголовок "[TheReportKindName] (Report types)" Тогда
			// Форма уже открыта
		Иначе
			И Я нахожу в списке вид отчета с именем '[TheReportKindName]'
			И в таблице 'ReportKindList' я выбираю текущую строку
		Когда открылось окно "[TheReportKindName] (Report types)"
		И я перехожу к закладке с именем 'DefaultSettings'
		И я нажимаю на кнопку открытия поля с именем 'DefaultPivotTableTemplate'

	* Формируем Бланк сводной таблиц
		Тогда Открылся бланк сводной таблицы для вида отчета '[TheReportKindName]'
		И я нажимаю на кнопку с именем 'ShowListOfRows'
		Тогда открылось окно "Set up line list"
		И я нажимаю на кнопку с именем 'MoveLeftAll'
		И я нажимаю на кнопку с именем 'ApplyTheChanges'
		Тогда открылось окно '$ЗаголовокОкна$ *'
		И я нажимаю на кнопку с именем 'ShowListOfColumns'
		Тогда открылось окно "Set up column list"
		И в таблице 'PivotTableColumnsListSettings' я нажимаю на кнопку с именем 'PivotTableColumnsListSettingsPopulateColumns'
		И я нажимаю на кнопку с именем 'FormApply'
		Тогда открылось окно '$ЗаголовокОкна$ *'
		И я нажимаю на кнопку с именем 'ShowTableSettingsByAxes'
		Тогда открылось окно "Set up field location"
		И я запоминаю строку '[TheFilter1]' в переменную 'FieldName'
		Если в таблице 'TableAvailableFields' есть строка Тогда
			| "Available dimensions" |
			| '$ИмяПоля$'           |
			И в таблице 'TableAvailableFields' я перехожу к строке:
				| "Available dimensions" |
				| '$ИмяПоля$'           |
			И я выбираю пункт контекстного меню с именем 'ТаблицаДоступныеПоляКонтекстноеМенюПеренестиВОтборы' на элементе формы с именем 'ТаблицаДоступныеПоля'
		И я запоминаю строку '[TheFilter2]' в переменную 'FieldName'	
		Если в таблице 'TableAvailableFields' есть строка Тогда
			| "Available dimensions" |
			| '$ИмяПоля$'           |
			И в таблице 'TableAvailableFields' я перехожу к строке:
				| "Available dimensions" |
				| '$ИмяПоля$'           |
			И я выбираю пункт контекстного меню с именем 'ТаблицаДоступныеПоляКонтекстноеМенюПеренестиВОтборы' на элементе формы с именем 'ТаблицаДоступныеПоля'
		И я запоминаю строку '[TheFilter3]' в переменную 'FieldName'	
		Если в таблице 'TableAvailableFields' есть строка Тогда
			| "Available dimensions" |
			| '$ИмяПоля$'           |
			И в таблице 'TableAvailableFields' я перехожу к строке:
				| "Available dimensions" |
				| '$ИмяПоля$'           |
			И я выбираю пункт контекстного меню с именем 'TableAvailableFieldsContextMenuMoveToFilters' на элементе формы с именем 'TableAvailableFields'		
		И Пока в таблице 'TableAvailableFields' количество строк 'больше' 0 Тогда
			И я выбираю пункт контекстного меню с именем 'TableAvailableFieldsContextMenuMoveToRows' на элементе формы с именем 'TableAvailableFields'
		И я запоминаю строку "Project" в переменную 'FieldName'
		Если '"[TheFilter1]" <> "$ИмяПоля$" И "[TheFilter2]" <> "$ИмяПоля$" И "[TheFilter3]" <> "$ИмяПоля$"' Тогда
			Когда открылось окно "Set up field location"
			И в таблице 'TableRows1' я перехожу к строке:
				| "Horizontally (in rows)" |
				| "Project"                     |
			И я выбираю пункт контекстного меню с именем 'TableRows1ContextMenuMoveToAvailableFields' на элементе формы с именем 'TableRows1'
			
		И я нажимаю на кнопку с именем 'RowsMoveUp'
		И я нажимаю на кнопку с именем 'RowsMoveDown'
		И я нажимаю на кнопку с именем 'DimensionsLayoutOption'
		И в меню формы я выбираю "Hierarchical dimensions"
		И я устанавливаю флаг с именем 'TotalByColumns'
		И в таблице 'ColumnsTable' я перехожу к строке:
			| "Vertically (in columns)" |
			| "Report columns"           |
		И я нажимаю на кнопку с именем 'ColumnsMoveUp'
		И я нажимаю на кнопку с именем 'ColumnsMoveDown'
		И я нажимаю на кнопку с именем 'ButtonApply'
		
		Тогда открылось окно '$ЗаголовокОкна$ *'		
		И я нажимаю на кнопку с именем 'ShowPeriodsSettings'
		И я нажимаю на кнопку с именем 'FormApply'

	* Сохраняем
		Тогда открылось окно '$ЗаголовокОкна$ *'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна '$ЗаголовокОкна$ *' в течение 20 секунд
