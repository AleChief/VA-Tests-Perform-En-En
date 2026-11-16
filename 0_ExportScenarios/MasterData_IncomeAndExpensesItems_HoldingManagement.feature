#language: ru

@tree
@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для управлением НСИ - Статьи доходов и расходов

Как Тестировщик я хочу
иметь экспортные сценарии по статьям ДДС
чтобы было проще писать и поддерживать тесты

Контекст:
	   И Я запускаю сценарий открытия TestClient или подключаю уже существующий
	   И я закрываю все окна клиентского приложения

Сценарий: Я создаю группу статей ДиР с именем 'TheName'

	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'IncomeAndExpenseItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Income and expense items"
	
	* Удаляем элемент
		И Я в списке "Income and expense items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheName] (Income and expense items)" очищая

	* Создаем элемент
		Тогда открылось окно "Income and expense items"
		И я нажимаю на кнопку с именем 'FormCreateFolder'
		Тогда открылось окно "Income and expense items (create group)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Income and expense items (create group) *" в течение 20 секунд

	* Закрываем форму списка
		Когда открылось окно "Income and expense items"
		И Я закрываю окно "Income and expense items"

Сценарий: Я создаю статью ДиР с именем 'TheName' родителем 'TheParent'

	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'IncomeAndExpenseItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Income and expense items"
	
	* Удаляем элемент
		И Я в списке "Income and expense items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheName] (Income and expense item)" очищая

	* Создаем элемент
		Тогда открылось окно "Income and expense items"'
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Income and expense item (create)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И из выпадающего списка с именем 'Parent' я выбираю по строке '[TheParent]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Income and expense item (create) *" в течение 20 секунд

	* Закрываем форму списка
		Когда открылось окно "Income and expense items"'
		И Я закрываю окно "Income and expense items"'


Сценарий: Я для статьи ДиР с именем 'TheName' определяю группу раскрытия 'TheAnalyticsGroup'
	
	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'IncomeAndExpenseItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Income and expense items"

	* Находим и заполняем элемент
		И Я в списке "Income and expense items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"
		И в таблице "List" я выбираю текущую строку
		Тогда открылось окно '[TheName] (Income and expense item)'
		Если элемент формы с именем "DrillDownGroup" стал равен '[TheAnalyticsGroup]' тогда
			И я жду закрытия окна '[TheName] (Income and expense item) *' в течение 20 секунд
		Иначе 
			И я меняю значение переключателя с именем 'DrillDownGroupRadioButton' на '1'
			И из выпадающего списка с именем "DrillDownGroup" я выбираю по строке '[TheAnalyticsGroup]'
			
	* Закрываем форму элемента
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна '[TheName] (Income and expense item) *' в течение 20 секунд
		И Я закрываю окно "Income and expense items"'

Сценарий: Я для статьи ДиР с именем 'TheName' определяю виды аналитики 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'
	
	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'IncomeAndExpenseItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Income and expense items"

	* Находим и заполняем элемент
		И Я в списке "Income and expense items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"
		И в таблице "List" я выбираю текущую строку
		Тогда открылось окно '[TheName] (Income and expense item)'

		Если элемент формы с именем "DrillDownGroup" стал равен '' тогда
			И Я заполняю виды аналитики 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'
			И я нажимаю на кнопку с именем 'FormWrite'
		Иначе 
			И я жду закрытия окна '[TheName] (Income and expense item) *' в течение 20 секунд

	* Закрываем форму элемента
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна '[TheName] (Income and expense item) *' в течение 20 секунд
		И Я закрываю окно "Income and expense items"'

Сценарий: Я для статьи ДиР с именем 'TheName' определяю тип движения статьи 'TheTypeDirection'

	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'IncomeAndExpenseItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Income and expense items"

	* Находим и заполняем элемент
		И Я в списке "Income and expense items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"
		И в таблице "List" я выбираю текущую строку
		И я меняю значение переключателя с именем 'ArrivalExpense' на '[TheTypeDirection]'
		И я нажимаю на кнопку с именем 'FormWrite'
	
	* Закрываем форму элемента
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна '[TheName] (Income and expense item) *' в течение 20 секунд
		И Я закрываю окно "Income and expense items"'
