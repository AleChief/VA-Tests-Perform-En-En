#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для работы с подсистемой "Budgeting" - "Master data"

Сценарий: Я создаю сценарий с именем 'TheName'

	* Открываем список
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Scenarios"

	* Удаляем элемент	
		И Я в списке "Scenarios" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			* Удаляем документы управления периодом сценария
				Когда открылось окно "BudgetingScenarios: [TheName] (BudgetingScenarios)"
				И я нажимаю на кнопку с именем 'FormDocumentScenarioPeriodManagementDocumentsManagementReportingPeriod'
				Тогда открылось окно "Reporting period management"
				Если в таблице 'List' количество строк 'больше' 0 Тогда				
					Тогда в таблице 'List' я выделяю все строки
					И я выбираю пункт контекстного меню с именем 'ListContextMenuSetDeletionMark' на элементе формы с именем 'List'
					Тогда открылось окно "1C:Enterprise"
					И я нажимаю на кнопку с именем 'Button0'
				И я закрываю окно "Reporting period management"
			И Я удаляю текущий элемент в окне "BudgetingScenarios: [TheName] (BudgetingScenarios)" очищая	
			
	* Создаем новый элемент
		Тогда открылось окно "Scenarios"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Scenarios: Scenarios (create)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Scenarios: Scenarios (create) *" в течение 5 секунд

	* Закрываем список
		Когда открылось окно "Scenarios"
		И Я закрываю окно "Scenarios"

Сценарий: Я для сценария 'TheName' на закладке 'ThePage' для реквизита 'TheProperty' устанавливаю значение 'TheValue' 

	* Ищем элемент	
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Scenarios"
		И Я в списке "Scenarios" по полю "Description" ищу и выбираю элемент '[TheName]' "Exact match"
		
	* Меняем реквизит
		И я запоминаю заголовок формы в переменную 'FormCaption'		
		Тогда открылось окно '$ЗаголовокФормы$'
		И я перехожу к закладке с именем '[ThePage]'
		И Я для реквизита '[TheProperty]' устанавливаю значение '[TheValue]'		

	* Сохраняем элемент
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна '$ЗаголовокФормы$ *' в течение 20 секунд

Сценарий: Я создаю проект с именем 'TheProjectName'

	* Открываем список
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Projects*"
	
	* Удаляем текущий элемент
		Тогда открылось окно "Projects*"
		И я нажимаю на кнопку с именем 'FormFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
		И я меняю значение переключателя с именем 'CompareType' на "Exact match"
		И в поле с именем 'Pattern' я ввожу текст '[TheProjectName]'
		И я нажимаю на кнопку с именем 'Find'
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'List'
			* Переименовываем
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "*(Project*"
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "*(Project*" в течение 20 секунд
			
	* Создаем новый элемент
		Тогда открылось окно "Projects*"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Projects and phases (create)"
		И в поле с именем 'Description' я ввожу текст '[TheProjectName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Проект* (создание) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Projects*"
		И Я закрываю окно "Projects*"

Сценарий: Я создаю вид аналитики с кодом 'TheAnalyticsCode' именем 'TheAnalyticsName' типом 'TheAnalyticsType'

	* Открываем список
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Dimension types (corporate)"
		
	* Удаляем элемент
		И Я в списке "Dimension types (corporate)" по полю "Code" ищу элемент '[TheAnalyticsCode]' "Exact match"	
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Произвольный классификтор
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "* (Dimension types (corporate))"
				И В текущем окне я нажимаю кнопку командного интерфейса "Arbitrary classifier"
				Если в таблице 'List' количество строк 'больше' 0 Тогда
					И я нажимаю на кнопку с именем 'FormListSettings'
					И Я устанавливаю отбор в форме списка "Description" "Does not begin with" 'Delete_'
					И Пока в таблице 'List' количество строк 'больше' 0 Тогда	
						* Ставим пометку на удаление
							И Я удаляю текущую строку в списке 'List'
						* Переименовываем
							И Я запоминаю значение выражения '"Удалить_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'	
							И в таблице 'List' я выбираю текущую строку
							Когда открылось окно "* (Arbitrary classifier)"		
							Тогда в поле с именем 'Description' я ввожу значение переменной 'UID'
							И я нажимаю на кнопку с именем 'FormWriteAndClose'
							И я жду закрытия окна "* (Arbitrary classifier)" в течение 20 секунд
					И я нажимаю на кнопку с именем 'FormListSettings'
					И Я снимаю все отборы в форме списка		
				Когда открылось окно "* (Dimension types (corporate))"
				И я закрываю окно "* (Dimension types (corporate))"																													
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'List'
			* Переименовываем	
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'		
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "* (Dimension types (corporate))"
				И в поле с именем 'Code' я ввожу текст 'Delete'
				Тогда открылось окно "1C:Enterprise"
				И я нажимаю на кнопку с именем 'Button0'
				Тогда открылось окно "* (Dimension types (corporate))"
				И в поле с именем 'Code' я ввожу текст ''
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Dimension types (corporate)) *" в течение 20 секунд
		И Я закрываю окно "Dimension types (corporate)"

	* Создаем элемент кодом
		И я выполняю код встроенного языка на сервере без контекста	
			| 'ВидАналитик = ПланыВидовХарактеристик.ВидыСубконтоКорпоративные.CreateItem();' |
			| 'Массив = Новый Массив;' |
			| 'Массив.Добавить(Тип("[TheAnalyticsType]"));' |
			| 'ВидАналитик.ТипЗначения = Новый ОписаниеТипов(Массив);' |
			| 'ВидАналитик.Код = "[TheAnalyticsCode]";' |
			| 'ВидАналитик.Наименование = "[TheAnalyticsName]";' |
			| 'ВидАналитик.Записать();' |

Сценарий: Я для вида аналитики с кодом "TheAnalyticsCode" делаю ключом реквизит "ThePropertyName"

	* Открываем список и элемент
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Dimension types (corporate)"
		И Я в списке "Dimension types (corporate)" по полю "Code" ищу и выбираю элемент '[TheAnalyticsCode]' "Exact match"	
		Когда открылось окно "* (Dimension types (corporate))"
		И в таблице 'TableBoxAttributes' я перехожу к строке:
			| "Attribute"          |
			| '[ThePropertyName]' |
		И в таблице 'TableBoxAttributes' я устанавливаю флаг с именем 'AttributesTableKey'
		И в таблице 'TableBoxAttributes' я устанавливаю флаг с именем 'AttributesTableTemplate'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "* (Dimension types (corporate)) *" в течение 20 секунд
		Когда открылось окно "Dimension types (corporate)"
		И я выбираю пункт контекстного меню с именем 'ListContextMenuCancelSearch' на элементе формы с именем 'List'

Сценарий: Я создаю субконто УХ с именем 'TheExtDimensionCPMName' и видом аналитики с кодом 'TheExtDimensionCPMKind'

	* Открываем список
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Arbitrary classifier"
		Когда открылось окно "Arbitrary classifier"

	* Устанавливаем вид
		И из выпадающего списка с именем 'Owner' я выбираю по строке '[TheExtDimensionCPMKind]'

	* Удаляем текущий элемент
		И я выбираю пункт контекстного меню с именем 'ListContextMenuFind' на элементе формы с именем 'List'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
		И в поле с именем 'Pattern' я ввожу текст '[TheExtDimensionCPMName]'
		И я меняю значение переключателя с именем 'CompareType' на "Exact match"
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно "Arbitrary classifier"
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда	
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'List'
			* Перименовываем
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'	
				И в таблице 'List' я выбираю текущую строку
				Когда открылось окно "* (Arbitrary classifier)"		
				Тогда в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Arbitrary classifier)" в течение 20 секунд 

	* Создаем новый элемент
		Когда открылось окно "Arbitrary classifier"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Arbitrary classifier (create)"
		И в поле с именем 'Description' я ввожу текст '[TheExtDimensionCPMName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Arbitrary classifier (create) *" в течение 20 секунд				

	* Закрываем список
		Когда открылось окно "Arbitrary classifier"
		И Я закрываю окно "Arbitrary classifier"

Сценарий: Я заполняю виды аналитики 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'

		И в таблице "ВидыАналитик" я активизирую поле с именем "ВидыАналитикВидАналитики"
		И в таблице "KindsOfDimensions" я выбираю текущую строку
		Если 'НЕ ПустаяСтрока("[TheAnalytics1]")' Тогда
			И в таблице "ВидыАналитик" из выпадающего списка с именем "ВидыАналитикВидАналитики" я выбираю по строке '[TheAnalytics1]'
			И в таблице "DimensionKinds" я завершаю редактирование строки
		Если 'НЕ ПустаяСтрока("[TheAnalytics2]")' Тогда
			И в таблице "DimensionKinds" я перехожу к строке:
				| '№' |
				| '2' |
			И в таблице "KindsOfDimensions" я выбираю текущую строку
			И в таблице "ВидыАналитик" из выпадающего списка с именем "ВидыАналитикВидАналитики" я выбираю по строке '[TheAnalytics2]'
			И в таблице "DimensionKinds" я завершаю редактирование строки
		Если 'НЕ ПустаяСтрока("[TheAnalytics3]")' Тогда
			И в таблице "DimensionKinds" я перехожу к строке:
				| '№' |
				| '3' |
			И в таблице "KindsOfDimensions" я выбираю текущую строку
			И в таблице "ВидыАналитик" из выпадающего списка с именем "ВидыАналитикВидАналитики" я выбираю по строке '[TheAnalytics3]'
			И в таблице "DimensionKinds" я завершаю редактирование строки
		Если 'НЕ ПустаяСтрока("[TheAnalytics4]")' Тогда
			И в таблице "DimensionKinds" я перехожу к строке:
				| '№' |
				| '4' |
			И в таблице "KindsOfDimensions" я выбираю текущую строку
			И в таблице "ВидыАналитик" из выпадающего списка с именем "ВидыАналитикВидАналитики" я выбираю по строке '[TheAnalytics4]'
			И в таблице "DimensionKinds" я завершаю редактирование строки
		Если 'НЕ ПустаяСтрока("[TheAnalytics5]")' Тогда
			И в таблице "DimensionKinds" я перехожу к строке:
				| '№' |
				| '5' |
			И в таблице "KindsOfDimensions" я выбираю текущую строку
			И в таблице "ВидыАналитик" из выпадающего списка с именем "ВидыАналитикВидАналитики" я выбираю по строке '[TheAnalytics5]'
			И в таблице "DimensionKinds" я завершаю редактирование строки
		Если 'НЕ ПустаяСтрока("[TheAnalytics6]")' Тогда
			И в таблице "DimensionKinds" я перехожу к строке:
				| '№' |
				| '6' |
			И в таблице "KindsOfDimensions" я выбираю текущую строку
			И в таблице "ВидыАналитик" из выпадающего списка с именем "ВидыАналитикВидАналитики" я выбираю по строке '[TheAnalytics6]'
			И в таблице "DimensionKinds" я завершаю редактирование строки

Сценарий: Я создаю группу аналитики статей 'TheAnalyticsGroup' с видами аналитик 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'

	* Открываем форму спика
		И Я открываю основную форму списка справочника "ItemDimensionGroups"
	
	* Удаляем элемент	
		И Я в списке "Item dimension groups" по полю "Description" ищу элемент '[TheAnalyticsGroup]' "Exact match"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheAnalyticsGroup] (Item dimension group)" очищая
	
	* Создаем элемент
		И я нажимаю на кнопку с именем 'FormCreate'
		И в поле с именем 'Description' я ввожу текст '[TheAnalyticsGroup]'
		И Я заполняю виды аналитики 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна 'Item dimension group (create) *' в течение 20 секунд
		
	* Закрываем форму списка
		Когда открылось окно 'Item dimension groups'
		И Я закрываю окно 'Item dimension groups'			

Сценарий: Я проверяю у группы аналитик 'TheAnalyticsGroup' в таблице количество заполненных аналитик 'N'
	* Проверяем количество аналитик		
		И Я открываю основную форму списка справочника "ItemDimensionGroups"
		И Я в списке "Item dimension groups" по полю "Description" ищу элемент '[TheAnalyticsGroup]' "Exact match"
		И в таблице "List" я выбираю текущую строку
		И элемент формы с именем "МаксимальныйНомерЗаполненнойАналитики" стал равен '[N]'
		И Я закрываю окно '[TheAnalyticsGroup] (Item dimension group)'
		И Я закрываю окно 'Item dimension groups'

Сценарий: Я создаю группу регламентов с именем 'TheName'

	* Открываем регламент
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Regulations for preparing reports"

	* Удаляем группу
		И Я в списке "Regulations for preparing reports" по полю "Description" ищу элемент '[TheName]' "Exact match"
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление	
				И Я удаляю текущую строку в списке 'List'
			* Перименовываем
				И Я запоминаю значение выражения '"Удалить_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "[TheName] (Regulations for preparing reports)"
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "[TheName] (Regulations for preparing reports) *" в течение 20 секунд

	* Создаем группу
		Когда открылось окно "Regulations for preparing reports"
		И я нажимаю на кнопку с именем 'FormCreateFolder'
		Тогда открылось окно "Regulations for preparing reports (create group)"
		И в поле с именем 'Description' я ввожу текст "VA - Group regulations"
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Regulations for preparing reports (create group) *" в течение 20 секунд
				
Сценарий: Я для регламента 'TheRegulationName' изменяю флаг 'TheFlagName'

	И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Regulations for preparing reports"
	Тогда открылось окно "Regulations for preparing reports"
	И я нажимаю на кнопку с именем 'FormFind'
	Тогда открылось окно "Find"
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
	И в поле с именем 'Pattern' я ввожу текст '[TheRegulationName]'
	И я меняю значение переключателя с именем 'CompareType' на "Exact match"
	И я нажимаю на кнопку с именем 'Find'
	Тогда открылось окно "Regulations for preparing reports"
	И в таблице 'List' я выбираю текущую строку
	Тогда Открылся регламент подготовки отчетности 'TheRegulationName'
	И я перехожу к закладке с именем 'GroupMainPage'
	И я изменяю флаг с именем '[TheFlagName]'
	И я нажимаю на кнопку с именем 'FormWriteAndClose'
	И я жду закрытия окна '$ЗаголовокОкна$' в течение 20 секунд

Сценарий: Я создаю тип информационной базы с именем 'TheName' с версией 'ThePlatformVersion'

	* Открываем список
		И В командном интерфейсе я выбираю "Integration and master data management" "Infobase types"

	* Удаляем элемент	
		И Я в списке "Infobase types" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheName] (Infobase type)" очищая
	
	* Создаем новый элемент
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Infobase type (create)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И из выпадающего списка с именем 'PlatformVersion' я выбираю точное значение '[ThePlatformVersion]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Infobase type (create) *" в течение 20 секунд		
		
	* Закрываем список
		Когда открылось окно "Infobase types"
		И Я закрываю окно "Infobase types"	

Сценарий: Я создаю внешнюю информационную базу 'TheName' тип 'TheType' каталог 'TheCatalog' тип хранилища 'TheTypeOfStorage'

	* Открываем список
		И В командном интерфейсе я выбираю "Integration and master data management" "External infobases"

	* Удаляем элемент	
		И Я в списке "External infobases" по полю "External infobase" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheName] (External infobases)" очищая

	* Создаем новый элемент			
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "External infobases (create)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И я нажимаю кнопку выбора у поля с именем 'ExternalSourceType'
		И Я в списке "Infobase types" по полю "Description" ищу и выбираю элемент '[TheType]' "At the beginning of the line"
		И в поле с именем 'NameBeginning' я ввожу текст '[TheCatalog]'
		Если '"[TheTypeOfStorage]" = "Excel"' Тогда 
			И я меняю значение переключателя с именем 'ADOStorageType' на "MS Excel (.xls) files"
			И в поле с именем 'ReferenceDirectory' я ввожу текст '[TheCatalog]'
			И я нажимаю на кнопку с именем 'TestConnection'
			Тогда открылось окно "1C:Enterprise"
			И я нажимаю на кнопку с именем 'Button0'
		Если '"[TheTypeOfStorage]" = "FoxPro"' Тогда
			И я меняю значение переключателя с именем 'ADOStorageType' на "FoxPro (.dbf) files"
			И в поле с именем 'ReferenceDirectory' я ввожу текст '[TheCatalog]'
		Если '"[TheTypeOfStorage]" = "Access"' Тогда
			И я меняю значение переключателя с именем 'ADOStorageType' на "MS Access databases (.mdb)"
			И в поле с именем 'ReferenceDirectory' я ввожу текст '[TheCatalog]'
		И я запоминаю строку "[TheName] (External infobases)*" в переменную 'WindowTitle'
		И я нажимаю на кнопку с именем 'FormWrite'
		И я жду открытия окна '$ЗаголовокОкна$' в течение 20 секунд
	
Сценарий: Я добавляю элемент пути к файлам организаций для типа 'TheType' объект 'TheObject' значение 'TheValue'	

	Тогда открылось окно "Company file path items: List form"	
	И я перехожу к закладке с именем 'Page_[TheType]'	

	* Удаляем старый элемент
		И в таблице 'List_[TheType]' я нажимаю на кнопку с именем 'List_[TheType]Find'
		Тогда открылось окно "Find"
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Object"
		И я меняю значение переключателя с именем 'CompareType' на "Anywhere in the line"
		И в поле с именем 'Pattern' я ввожу текст '[TheObject]'
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно "Company file path items: List form"
		И Пока в таблице 'List_[TheType]' количество строк 'больше' 0 Тогда 
			И я выбираю пункт контекстного меню с именем 'List_[TheType]ContextMenuDelete' на элементе формы с именем 'List_[TheType]'
			Тогда открылось окно "1C:Enterprise"
			И я нажимаю на кнопку с именем 'Button0'
				
	* Добавляем новый элемент
		И в таблице 'List_[TheType]' я нажимаю на кнопку с именем 'List_[TheType]Create'
		Тогда открылось окно "Company file path items (create)"
		И из выпадающего списка с именем 'Object' я выбираю по строке '[TheObject]'
		И в поле с именем 'Name' я ввожу текст '[TheValue]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Company file path items (create) *" в течение 20 секунд

Сценарий: Я создаю шаблон универсального процесса с именем "TheName" режимом "TheMode"

	* Открываем форму справочника
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Templates of report preparation process"

	* Удаляем элемент
		И Я в списке "Universal process templates" по полю "Description" ищу элемент '[TheName]' "Exact match" 
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Переименовываем
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "Editing process stages: [TheName]"
				И я нажимаю на кнопку с именем 'FormOpenProcessProperties'
				Когда открылось окно "[TheName] (Universal process template)"
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "[TheName] (Universal process template) *" в течение 20 секунд
				Тогда открылось окно "Editing process stages: *"
				И Я закрываю окно "Editing process stages: *"

	* Создаем элемент
		Когда открылось окно "Universal process templates"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Universal process template (create)"		
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		Когда открылось окно "Universal process template (create)"
		И из выпадающего списка с именем 'ProcessPurpose' я выбираю точное значение '[TheMode]'
		Когда открылось окно "Universal process template (create) *"
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Universal process template (create) *" в течение 20 секунд
		Тогда открылось окно "Editing process stages: *"
		И Я закрываю окно "Editing process stages: *"
