#language: ru

@tree
@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для управлением НСИ - Статьи движения денежных средств

Как Тестировщик я хочу
иметь экспортные сценарии по статьям ДДС
чтобы было проще писать и поддерживать тесты

Контекст:
	   И Я запускаю сценарий открытия TestClient или подключаю уже существующий
	   И я закрываю все окна клиентского приложения

Сценарий: Я создаю группу статей ДДС с именем 'TheName'	

	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'CashFlowReportItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Cash flow items"

	* Удаляем элемент	
		И Я в списке "Cash flow items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheName] (Cash flow items)" очищая

	* Создаем элемент
		Тогда открылось окно "Cash flow items"
		И я нажимаю на кнопку с именем 'FormCreateFolder'
		Тогда открылось окно "Cash flow items (create group)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Cash flow items (create group) *" в течение 20 секунд

	* Закрываем форму списка
		Когда открылось окно "Cash flow items"
		И Я закрываю окно "Cash flow items"

Сценарий: Я создаю статью ДДС с именем 'TheName' родителем 'TheParent'

	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'CashFlowReportItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Cash flow items"
	
	* Удаляем элемент
		И Я в списке "Cash flow items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheName] (Cash flow item)" очищая
		
	* Создаем элемент
		Тогда открылось окно "Cash flow items"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Cash flow item (create)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И из выпадающего списка с именем 'Parent' я выбираю по строке '[TheParent]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Cash flow item (create) *" в течение 20 секунд

	* Закрываем форму списка
		Когда открылось окно "Cash flow items"
		И Я закрываю окно "Cash flow items"	

Сценарий: Я для статьи ДДС с именем 'TheName' определяю группу раскрытия 'TheAnalyticsGroup'
	
	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'CashFlowReportItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Cash flow items"

	* Находим и заполняем элемент
		И Я в списке "Cash flow items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"
		И в таблице "List" я выбираю текущую строку
		Тогда открылось окно '[TheName] (Cash flow item)'
		Если элемент формы с именем "DrillDownGroup" стал равен '[TheAnalyticsGroup]' тогда
			И я жду закрытия окна '[TheName] (Cash flow item) *' в течение 20 секунд
		Иначе 
			И я меняю значение переключателя с именем 'DrillDownGroupRadioButton' на ' '
			И из выпадающего списка с именем "DrillDownGroup" я выбираю по строке '[TheAnalyticsGroup]'	
			
	* Закрываем форму элемента
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна '[TheName] (Cash flow item) *' в течение 20 секунд
		И Я закрываю окно "Cash flow items"

Сценарий: Я для статьи ДДС с именем 'TheName' определяю виды аналитики 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'
	
	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'CashFlowReportItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Cash flow items"

	* Находим и заполняем элемент
		И Я в списке "Cash flow items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"
		И в таблице "List" я выбираю текущую строку
		Тогда открылось окно '[TheName] (Cash flow item)'

		Если элемент формы с именем "DrillDownGroup" стал равен '' тогда
			И Я заполняю виды аналитики 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'
			И я нажимаю на кнопку с именем 'FormWrite'
		Иначе 
			И я жду закрытия окна '[TheName] (Cash flow item) *' в течение 20 секунд
	
	* Закрываем форму элемента
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна '[TheName] (Cash flow item) *' в течение 20 секунд
		И Я закрываю окно "Cash flow items"

Сценарий: Я для статьи ДДС с именем 'TheName' определяю тип движения статьи 'TheTypeDirection'

	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И я открываю основную форму списка справочника 'CashFlowReportItems'
		Иначе
			И В командном интерфейсе я выбираю "Planning and control" "Cash flow items"

	* Находим и заполняем элемент
		И Я в списке "Cash flow items" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"
		И в таблице "List" я выбираю текущую строку
		И я меняю значение переключателя с именем 'ArrivalExpense' на '[TheTypeDirection]'
		И я нажимаю на кнопку с именем 'FormWrite'
			
	* Закрываем форму элемента
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна '[TheName] (Cash flow item) *' в течение 20 секунд
		И Я закрываю окно "Cash flow items"

