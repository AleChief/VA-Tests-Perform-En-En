#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для работы с подсистемой "Budgeting" - "Adjustment of indicator values"

Сценарий: Я создаю шаблон корректировки значений показателей с имененм "TheName" и видами отчетов

	* Открываем форму справочника
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Indicator value adjustments templates"

	* Удаляем элемент
		И Я в списке "Indicator value adjustments templates" по полю "Description" ищу элемент '[TheName]' "Exact match" 
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление	
				И Я удаляю текущую строку в списке 'List'
			* Переименовываем
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "* (Indicator value adjustments templates)"
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я удаляю все строки таблицы 'UsedReportTypes'				
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Indicator value adjustments templates) *" в течение 20 секунд

	* Создаем элемент
		Когда открылось окно "Indicator value adjustments templates"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Indicator value adjustments templates (create)"		
		И я заполняю таблицу 'UsedReportTypes' данными
			|'Table'|
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		Когда открылось окно "Indicator value adjustments templates (create) *"
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Indicator value adjustments templates (create) *" в течение 20 секунд
				
Сценарий: Для шаблона корректировки значений показателей с имененм "TheName" я заполняю таблицу корректировок значениями

	* Открываем форму справочника
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Indicator value adjustments templates"

	* Ищем элемент
		И Я в списке "Indicator value adjustments templates" по полю "Description" ищу и выбираю элемент '[TheName]' "Exact match" 

	* Заполнение
		И я заполняю таблицу 'TableOfAdjustments' данными
			|'Table'|

	* Сохраняем элемент
		Когда открылось окно "[TheName] (Indicator value adjustments templates) *"
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "[TheName] (Indicator value adjustments templates) *" в течение 20 секунд

Сценарий: Я создаю корректировку значений показателей сценарий "TheScenario" период "TheStartDate" периодичность "TheFrequency" организация "TheBusinessUnit" значения

	И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Indicator value adjustment"
	Тогда открылось окно "Indicator value adjustment"

	И я нажимаю на кнопку с именем 'FormCreate'
	Тогда открылось окно "Indicator value adjustment (create)"

	И я нажимаю кнопку выбора у поля с именем 'PeriodManagement'
	И Я в списке "Reporting period management" по полю "Scenario" ищу элемент "[TheScenario]" "Exact match"
	И Я в списке "Управление отчетным периодом" по полю "Периодичность" ищу элемент "[TheFrequency]" "Exact match" 
	И Я в списке "Reporting period management" по полю "Start period" ищу и выбираю элемент "[TheStartDate]" "At the beginning of the line"

	Когда открылось окно "Indicator value adjustment (create) *"
	И я нажимаю кнопку выбора у поля с именем 'Organization'
	И Я выбираю организацию "[TheBusinessUnit]"

	И я заполняю таблицу 'TableOfAdjustments' данными
		|'Table'|
	
	Когда открылось окно "Indicator value adjustment (create) *"
	И я нажимаю на кнопку с именем 'FormPostAndClose'
	И я жду закрытия окна "Indicator value adjustment (create) *" в течение 20 секунд

Сценарий: Я открываю новую корректировку значений показателей сценарий "TheScenario" период "TheStartDate" периодичность "TheFrequency" организация "TheBusinessUnit"

	И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Indicator value adjustment"
	Тогда открылось окно "Indicator value adjustment"

	И я нажимаю на кнопку с именем 'FormCreate'
	Тогда открылось окно "Indicator value adjustment (create)"

	И я нажимаю кнопку выбора у поля с именем 'PeriodManagement'
	И Я в списке "Reporting period management" по полю "Scenario" ищу элемент "[TheScenario]" "Exact match"
	И Я в списке "Управление отчетным периодом" по полю "Периодичность" ищу элемент "[TheFrequency]" "Exact match" 
	И Я в списке "Reporting period management" по полю "Start period" ищу и выбираю элемент "[TheStartDate]" "At the beginning of the line"

	Когда открылось окно "Indicator value adjustment (create) *"
	И я нажимаю кнопку выбора у поля с именем 'Organization'
	И Я выбираю организацию "[TheBusinessUnit]"