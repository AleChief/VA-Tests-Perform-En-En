#language: ru
@tree

@UH32_NSI
@ERPUH32_NSI
@Perform_Budget

Функционал: 03. Первоначальные настройки и ввод НСИ - "Budgeting"

	Как Администратор я хочу
	Ввести все НСИ
	чтобы проверить ввод НСИ и начать тестирование прочего функционала

Контекст: 

	И я подключаю TestClient "CPM - NSI" логин "Administrator" пароль ""
	И я закрыл все окна клиентского приложения	

Сценарий: 00.01 Запуск нужного клиента тестирования

	И Инициализация переменных

Сценарий: 00.02 Настройка информационной базы

	* Настройка прав доступа
		Если '$$ЭтоЕРПУХ$$' Тогда
			И В командном интерфейсе я выбираю "Reference data and administration" "Users and rights settings"
			Тогда открылось окно "Users and rights settings"
		Иначе			
			И В командном интерфейсе я выбираю "Administration" "Users and rights settings"
			Тогда открылось окно "Users and rights settings"
			Если 'НЕ $$ЭтоPerform$$' Тогда
				И я устанавливаю флаг с именем 'UseMultipleResponsiblePersons'
		И я устанавливаю флаг с именем 'UseUserGroups'
		И я устанавливаю флаг с именем 'LimitAccessAtRecordLevel'
		Если открылось окно "1C:Enterprise" Тогда
			И я нажимаю на кнопку с именем 'Button0'
		Тогда открылось окно "Users and rights settings"
		Если '$$ЭтоPerform$$' Тогда
			* Включаем производительный режим работы
				И Я включаю производительный режим работы ограничений на уровне записей
		Иначе
			* Включаем стандартный режим работы
				И из выпадающего списка с именем 'LimitAccessAtRecordLevelUniversally' я выбираю точное значение "Standard"
				Если открылось окно "1C:Enterprise" Тогда
					И я нажимаю на кнопку с именем 'Button0'

	* Настройка даты запрета редактирования
		Тогда открылось окно "Users and rights settings"
		И я разворачиваю группу с именем 'UsersPersonalSettingsGroup'
		И я разворачиваю группу с именем 'PeriodClosingDatesGroup'
		И я устанавливаю флаг с именем 'UsePeriodClosingDates'
		И я нажимаю на кнопку с именем 'ConfigurePeriodClosingDates'
		Тогда открылось окно "Period-end closing dates"
		И в поле с именем 'PeriodEndClosingDateSimpleMode' я ввожу текст '31.12.2000'
		И я перехожу к закладке с именем 'AdvancedOptionsGroup'
		И из выпадающего списка с именем 'PeriodEndClosingDateSettingMethod' я выбираю точное значение "Single date for all sections and objects"
		И Я закрываю окно "Period-end closing dates"
		И я закрываю окно "Users and rights settings"

	* Настройка программы
		Если '$$ЭтоЕРПУХ$$' Тогда
			* Предприятие
				И В командном интерфейсе я выбираю "НСИ и администрирование" "Предприятие"
				Тогда открылось окно "Company"
				И я устанавливаю флаг с именем 'UseMultipleOrganizations'
				И я разворачиваю группу с именем 'GroupSettingsCurrencies'
				И я устанавливаю флаг с именем 'UseMultipleCurrencies'
				Тогда открылось окно "Company"
				И Я закрываю окно "Enterprise"
			* CRM и маркетинг
				И В командном интерфейсе я выбираю "Reference data and administration" "CRM and marketing"
				Тогда открылось окно "CRM and marketing"
				И я разворачиваю группу с именем "GroupSettingsCRM"
				И я устанавливаю флаг с именем 'UsePartnersAndCounterparties'								
				И я разворачиваю группу с именем 'GroupMarketing'
				И я устанавливаю флаг с именем 'UseMultiplePriceTypes'
				Тогда открылось окно "CRM and marketing"	
				И Я закрываю окно "CRM and marketing"	
			* Склад и доставка
				И В командном интерфейсе я выбираю "НСИ и администрирование" "Склад и доставка"
				Тогда открылось окно "Warehouse and delivery"
				И я устанавливаю флаг с именем 'UseMultipleWarehouses'
				Тогда открылось окно "Warehouse and delivery"
				И Я закрываю окно "Warehouse and delivery"																

	И Я создаю единицу измерения с кодом '796' если ее нет, наименование "Piece", наименование полное "PCs"

	* Установка констант и ФО
		И Я устанавливаю в константу 'UseIndicatorRecalculationTraceMode' значение 'Истина'
		Если '$$ЭтоЕРПУХ$$' Тогда
			И Я устанавливаю в константу 'ИспользоватьТоварныеКатегории' значение 'Истина'	

	* Добавим валюты, если их нет
		* RUB
			И Я создаю валюту с цифровым кодом '643' символьным кодом 'RUB' и наименованием "Russian ruble" если ее нет
		* EUR
			И Я создаю валюту с цифровым кодом '978' символьным кодом 'EUR' и наименованием "Euro" если ее нет
			И Я устанавливаю курс валюты 'EUR' на дату '01.01.2024' в значение '90,7932' кратность '1' базовая валюта 'RUB'
			И Я устанавливаю курс валюты 'EUR' на дату '01.02.2024' в значение '92,2963' кратность '1' базовая валюта 'RUB'
			И Я устанавливаю курс валюты 'EUR' на дату '01.03.2024' в значение '90,3743' кратность '1' базовая валюта 'RUB'
		* USD
			И Я создаю валюту с цифровым кодом '840' символьным кодом 'USD' и наименованием "US dollar" если ее нет
			И Я устанавливаю курс валюты 'USD' на дату '01.01.2024' в значение '73,8757' кратность '1' базовая валюта 'RUB'
			И Я устанавливаю курс валюты 'USD' на дату '01.02.2024' в значение '76,2527' кратность '1' базовая валюта 'RUB'
			И Я устанавливаю курс валюты 'USD' на дату '01.03.2024' в значение '74,4373' кратность '1' базовая валюта 'RUB'
		* KZT
			И Я создаю валюту с цифровым кодом '398' символьным кодом 'KZT' и наименованием "Tenge" если ее нет

	* Устанавливаем валюту регламентированного учета для ЕРПУХ
		Если '$$ЭтоУХ$$' Тогда
			Если '$$ЭтоPerform$$' Тогда
				И В командном интерфейсе я выбираю "Учет по МСФО" "Настройки МСФО"
				Тогда открылось окно "Настройки МСФО"
				И я разворачиваю группу с именем 'ГруппаЗначенияПоУмолчанию'								
				И из выпадающего списка с именем 'ВалютаУправленческогоУчета' я выбираю точное значение 'RUB'
				И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
				И я жду закрытия окна "Настройки МСФО *" в течение 20 секунд							
			Иначе
				И я выполняю код встроенного языка на сервере без контекста
				"""bsl
					Константы.ВалютаУправленческогоУчета.Установить(Справочники.Валюты.НайтиПоКоду("643"));
				"""	
		Если '$$ЭтоЕРПУХ$$' Тогда
			И В командном интерфейсе я выбираю "НСИ и администрирование" "Предприятие"
			Тогда открылось окно "Предприятие"
			И я разворачиваю группу с именем 'ГруппаНастройкиВалют'
			И из выпадающего списка с именем 'ВалютаУправленческогоУчета' я выбираю точное значение 'RUB'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button0'
			Тогда открылось окно "Предприятие"			
			И Я закрываю окно "Предприятие"

	Если '$$ЭтоPerform$$' Тогда
		И Я создаю страну с кодом1 '643' кодом2 'RU' кодом3 'RUS' именем1 "РОССИЯ" именем2 "Российская Федерация" именем3 "The Russian Federation" если ее нет в 1C:CPMWE

	* Отключаем работу с новостями
		Если '$$ЭтоЕРПУХ$$' Тогда
			И я устанавливаю в константу 'РазрешенаРаботаСНовостями' значение 'Ложь'
			И я устанавливаю в константу 'РазрешенаРаботаСНовостямиЧерезИнтернет' значение 'Ложь'

Сценарий: 00.03 Создание профилей и групп доступа

	И Я создаю группу доступа с именем "Open external reports and data processors" по профилю "Open external reports and data processors"

	И Я создаю профиль с именем "VA - Budgeting (Edit)" на основании профиля "Operations with customizable reporting (report instances, adjustments, and pivot table)"	
	И Я создаю группу доступа с именем "VA - Budgeting (Edit)" по профилю "VA - Budgeting (Edit)"

	И Я создаю профиль с именем "VA - Budgeting (View)" на основании профиля "View customizable reporting (report instances, adjustments, and pivot table)"	
	И Я создаю группу доступа с именем "VA - Budgeting (View)" по профилю "VA - Budgeting (View)"

Сценарий: 00.04 Создание пользователей

	И Я нахожу или создаю пользователя "Administrator" группа доступа "Administrators" группа ""	

	И Я нахожу или создаю группу пользователей с именем "VA - Budgeting"

	И Я нахожу или создаю пользователя "Budgeting1" группа доступа "VA - Budgeting (Edit)" группа "VA - Budgeting"
	И Я нахожу или создаю пользователя "Budgeting2" группа доступа "VA - Budgeting (Edit)" группа "VA - Budgeting"
	И Я нахожу или создаю пользователя "Budgeting3" группа доступа "VA - Budgeting (View)" группа "VA - Budgeting"
	И Я нахожу или создаю пользователя "Budgeting4" группа доступа "VA - Budgeting (View)" группа "VA - Budgeting"

Сценарий: 00.05 Создание группы Видов отчетов

	И Я создаю группу видов отчетов с именем "VA - Report group" и родителем ''

Сценарий: 00.06 Создание вида организационной единицы

	И Я создаю вид организационной единицы с именем "VA - Package CFR"

Сценарий: 00.07 Создание отношения к группе

	И Я создаю отношение к группе с именем "ВА - Дочернее предприятие" и видом "Дочернее предприятие"

Сценарий: 00.08 Создание организаций и ЦФО
	
	* Создаем организацию Система
		И Я создаю организацию с именем "System LLC" типом 'ВыбратьРФ' видом 'ВыбратьЮЛ' налогооблажением 'СистемаНалогообложенияОбщаяЮЛ'
		Если '$$ЭтоУХ$$' Тогда
			И Я для организации "System LLC" для реквизита 'CompanyType' выбираю значение "VA - Package CFR"	
			И Я для организации "System LLC" создаю подразделение с именем "Administration"
			И Я для организации "System LLC" создаю подразделение с именем "Accounting"
		Если '$$ЭтоЕРПУХ$$' Тогда
			И Я для организации "System LLC" для реквизита 'CompanyType1' выбираю значение "VA - Package CFR"	
			И Я для организации "System LLC" создаю подразделение с именем "Administration" в 1C:ERPУХ
			И Я для организации "System LLC" создаю подразделение с именем "Accounting" в 1C:ERPУХ

		Если '$$ЭтоPerform$$' Тогда
			И Я для организации "System LLC" для реквизита 'GroupCounterparty' выбираю значение "VA - Subsidiary"
		Иначе
			И Я для организации "System LLC" для реквизита 'CounterpartyGroups' выбираю значение "VA - Subsidiary"		

	* Создаем организацию Меркурий
		И Я создаю организацию с именем "Mercury LLC" типом 'ВыбратьРФ' видом 'ВыбратьЮЛ' налогооблажением 'СистемаНалогообложенияОбщаяЮЛ'
		И Я для организации "Mercury LLC" для реквизита 'Parent' выбираю значение "System LLC"	
		
		Если '$$ЭтоУХ$$' Тогда
			И Я для организации "Mercury LLC" для реквизита 'CompanyType' выбираю значение "VA - Package CFR"			
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И Я для организации "Mercury LLC" для реквизита 'CompanyType1' выбираю значение "VA - Package CFR"
		
		Если '$$ЭтоPerform$$' Тогда
			И Я для организации "Mercury LLC" для реквизита 'GroupCounterparty' выбираю значение "VA - Subsidiary"
		Иначе
			И Я для организации "Mercury LLC" для реквизита 'CounterpartyGroups' выбираю значение "VA - Subsidiary"

	* Создаем организацию Венера
		И Я создаю организацию с именем "Venus LLC" типом 'SelectCFO' видом '' налогооблажением ''
		И Я для организации "Венера ООО" для реквизита 'Parent' выбираю значение "Система ООО"
		
		Если '$$ЭтоУХ$$' Тогда
			И Я для организации "Venus LLC" для реквизита 'CompanyType' выбираю значение "VA - Package CFR"
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И Я для организации "Venus LLC" для реквизита 'CompanyType1' выбираю значение "VA - Package CFR"

	* Создаем организацию Земля
		И Я создаю организацию с именем "Earth LLC" типом 'SelectCFO' видом '' налогооблажением ''
		И Я для организации "Earth LLC" для реквизита 'Parent' выбираю значение "System LLC"
		
		Если '$$ЭтоУХ$$' Тогда
			И Я для организации "Earth LLC" для реквизита 'CompanyType' выбираю значение "VA - Package CFR"
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И Я для организации "Earth LLC" для реквизита 'CompanyType1' выбираю значение "VA - Package CFR"
		
	* Создаем организацию Марс
		И Я создаю организацию с именем "Mars LLC" типом 'ВыбратьЦФО' видом 'ВыбратьЭл' налогооблажением ''
		И Я для организации "Mars LLC" для реквизита 'Parent' выбираю значение "System LLC"
		
		Если '$$ЭтоУХ$$' Тогда
			И Я для организации "Mars LLC" для реквизита 'CompanyType' выбираю значение "VA - Package CFR"
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И Я для организации "Mars LLC" для реквизита 'CompanyType1' выбираю значение "VA - Package CFR"

Сценарий: 00.09 Настройка ограничений доступа по организациям

	И Я добавляю в профиль "VA - Budgeting (Edit)" ограничение доступа с видом "Companies" значением "All denied, configure exceptions in access groups"
	И Я добавляю в группу доступа "VA - Budgeting (Edit)" значения доступа с видом "Companies" из таблицы
		| "Access Value" | "Include subordinate items" |
		| "System LLC"      | "Да"                  |

	И Я добавляю в профиль "VA - Budgeting (View)" ограничение доступа с видом "Companies" значением "All denied, configure exceptions in access groups"
	И Я добавляю в группу доступа "VA - Budgeting (View)" значения доступа с видом "Companies" из таблицы
		| "Access Value" | "Include subordinate items" |
		| "Mercury LLC"     | "Нет"                 |
		| "Venus LLC"       | "Нет"                 |

Сценарий: 00.10 Создание Сценария

	И Я создаю сценарий с именем "VA - Main scenario"

Сценарий: 00.11 Создание Проекта

	И Я создаю проект с именем "VA - Main project"
				
Сценарий: 00.12 Создание Регламента подготовки отчетности

	И Я создаю группу регламентов с именем "VA - Group regulations"

	* Удаляем текущий элемент	
		И Я в списке "Регламенты подготовки отчетности" по полю "Description" ищу элемент "ВА - Основной регламент" "Exact match"
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление	
				И Я удаляю текущую строку в списке 'List'
			* Перименовываем
				И Я запоминаю значение выражения '"Удалить_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда Открылся регламент подготовки отчетности "VA - Main regulations"
				И я перехожу к закладке с именем 'GroupMainPage'		
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна '$ЗаголовокОкна$' в течение 20 секунд

	* Создаем элемент	
		Тогда открылось окно "Regulations for preparing reports"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда Открылся регламент подготовки отчетности ''
		И в поле с именем 'Description' я ввожу текст "VA - Main regulations"		
		И в поле с именем 'Parent' я ввожу текст "VA - Group regulations"
	
	* Выбираем группу видов отчетов	
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю кнопку выбора у поля с именем 'ReportKind'
		Тогда открылось окно "Report types"
		И я выбираю пункт контекстного меню с именем 'ListContextMenuFind' на элементе формы с именем 'List'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И в поле с именем 'Pattern' я ввожу текст "VA - Report group"
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно "Report types"
		И в таблице 'List' я активизирую поле с именем 'Description'
		И в таблице 'List' я выбираю текущую строку
	
	* Скроем организации включим периметры
		Тогда открылось окно '$ЗаголовокОкна$'
		И я перехожу к закладке с именем 'PerimeterSetting'
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'GroupStructureClearBusinessUnits'
		И я изменяю флаг с именем 'UsePerimeters'
		Когда открылось окно '$ЗаголовокОкна$'
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'GroupStructurePickOfCompaines'
		И я нажимаю на кнопку с именем 'OrganizationalUnitsFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'Pattern' я выбираю по строке "System LLC"
		И я нажимаю на кнопку с именем 'Find'	
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'BusinessUnitsCopyWithHierarchy'	

	* Развернем группы
		Когда открылось окно '$ЗаголовокОкна$'
		И в таблице 'GroupStructure' я перехожу к строке:
			| "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
			| "System LLC"                                            | '- '                   | "Group"             | '- '                  |
		И в таблице 'СтруктураГруппы' я разворачиваю текущую строку

	* Установим валюту, если необходимо		
		Если в таблице 'СтруктураГруппы' есть строка Тогда
			| "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Основная валюта" | "Company status for consolidation" | "Effective share, %" |
			| "System LLC"                                            | '- '                   | ''                | "Group"             | '- '                  |
			И в таблице 'СтруктураГруппы' я перехожу к строке:
				| "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Основная валюта" | "Company status for consolidation" | "Effective share, %" |
				| "System LLC"                                            | '- '                   | ''                | "Group"             | '- '                  |
			И в таблице 'СтруктураГруппы' я активизирую поле с именем 'СтруктураГруппыВалюта'
			И в таблице 'СтруктураГруппы' я выбираю текущую строку
			И в таблице 'СтруктураГруппы' из выпадающего списка с именем 'СтруктураГруппыВалюта' я выбираю точное значение 'RUB'
		Если в таблице 'СтруктураГруппы' есть строка Тогда
			| "Вид организации" | "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Эффективная доля, %" |
			| "ВА - Пакет ЦФО"  | "Меркурий ООО"                                           | ''                | '100,000'             |
			И в таблице 'СтруктураГруппы' я перехожу к строке:
				| "Вид организации" | "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Эффективная доля, %" |
				| "ВА - Пакет ЦФО"  | "Меркурий ООО"                                           | ''                | '100,000'             |
			И в таблице 'СтруктураГруппы' я активизирую поле с именем 'СтруктураГруппыВалюта'
			И в таблице 'СтруктураГруппы' я выбираю текущую строку
			И в таблице 'СтруктураГруппы' из выпадающего списка с именем 'СтруктураГруппыВалюта' я выбираю точное значение 'RUB'
		Если в таблице 'СтруктураГруппы' есть строка Тогда
			| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
			| "Венера ООО"                                             | ''                | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			И в таблице 'СтруктураГруппы' я перехожу к строке:
				| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
				| "Венера ООО"                                             | ''                | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			И в таблице 'СтруктураГруппы' я активизирую поле с именем 'СтруктураГруппыВалюта'
			И в таблице 'СтруктураГруппы' я выбираю текущую строку
			И в таблице 'СтруктураГруппы' из выпадающего списка с именем 'СтруктураГруппыВалюта' я выбираю точное значение 'RUB'
		Если в таблице 'СтруктураГруппы' есть строка Тогда
			| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
			| "Земля ООО"                                              | ''                | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			И в таблице 'СтруктураГруппы' я перехожу к строке:
				| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Intercompany transactions exclusion method" | "Company status for consolidation" | "Effective share, %" |
				| "Земля ООО"                                              | ''                | "Financial responsibility center"                  | "Financial responsibility center"                | '100'                 |
			И в таблице 'СтруктураГруппы' я активизирую поле с именем 'СтруктураГруппыВалюта'
			И в таблице 'СтруктураГруппы' я выбираю текущую строку
			И в таблице 'СтруктураГруппы' из выпадающего списка с именем 'СтруктураГруппыВалюта' я выбираю точное значение 'RUB'
		Если в таблице 'СтруктураГруппы' есть строка Тогда
			| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Метод исключения ВГО" | "Отношение к Группе" | "Эффективная доля, %" |
			| "Mars LLC"                                               | ''                | "ЦФО"                  | "ЦФО"                | '100'                 |
			И в таблице 'СтруктураГруппы' я перехожу к строке:
				| "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Метод исключения ВГО" | "Отношение к Группе" | "Эффективная доля, %" |
				| "Mars LLC"                                               | ''                | "ЦФО"                  | "ЦФО"                | '100'                 |
			И в таблице 'СтруктураГруппы' я активизирую поле с именем 'СтруктураГруппыВалюта'
			И в таблице 'СтруктураГруппы' я выбираю текущую строку
			И в таблице 'СтруктураГруппы' из выпадающего списка с именем 'СтруктураГруппыВалюта' я выбираю точное значение 'RUB'

	* Настроим отношение к группе и долю владения 
		Когда открылось окно '$ЗаголовокОкна$'
		И в таблице 'СтруктураГруппы' я перехожу к строке:
			| "Вид организации" | "Консолидирующая организация\n/ Организационная единица" | "Основная валюта" | "Эффективная доля, %" |
			| "ВА - Пакет ЦФО"  | "Меркурий ООО"                                           | 'RUB'             | '100,000'             |
		И в таблице 'СтруктураГруппы' я активизирую поле с именем 'СтруктураГруппыЭффективнаяДоля'
		И в таблице 'СтруктураГруппы' я выбираю текущую строку
		И в таблице 'СтруктураГруппы' в поле с именем 'СтруктураГруппыЭффективнаяДоля' я ввожу текст '50,000'
		И в таблице 'СтруктураГруппы' я завершаю редактирование строки
		И в таблице 'СтруктураГруппы' я активизирую поле с именем 'СтруктураГруппыГруппаКонтрагента'
		И в таблице 'СтруктураГруппы' я выбираю текущую строку
		И в таблице 'СтруктураГруппы' из выпадающего списка с именем 'СтруктураГруппыГруппаКонтрагента' я выбираю точное значение "ВА - Дочернее предприятие"
		И в таблице 'СтруктураГруппы' я завершаю редактирование строки
		И в таблице 'СтруктураГруппы' я активизирую поле с именем 'СтруктураГруппыМетодИсключенияВГО'
		И в таблице 'СтруктураГруппы' я выбираю текущую строку
		И в таблице 'СтруктураГруппы' из выпадающего списка с именем 'СтруктураГруппыМетодИсключенияВГО' я выбираю точное значение "Остатки и обороты"
		И в таблице 'СтруктураГруппы' я завершаю редактирование строки				
				
	* Протестируем кнопки 'Вверх' и 'Вниз'	
		И в таблице 'GroupStructure' я перехожу к строке:
			| "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation" | "Effective share, %" |
			| "Mars LLC"                                               | "Eliminating"        | 'RUB'             | "Eliminating"      | '100'                 |
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'GroupStructureCommandBarMoveUp'
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'GroupStructureCommandBarMoveUp'
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'GroupStructureCommandBarMoveUp'
		И в таблице 'GroupStructure' я перехожу к строке:
			| "Company kind" | "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation"        | "Effective share, %" |
			| "VA - Package CFR"  | "Mercury LLC"                                           | "Balance and turnovers"    | 'RUB'             | "VA - Subsidiary" | '50.000'              |
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'GroupStructureCommandBarMoveDown'
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'GroupStructureCommandBarMoveDown'
	
	* Запишем элемент
		Когда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'FormWrite'

	* Установим дополнительные валюты
		Тогда Открылся регламент подготовки отчетности "VA - Main regulations"
		И я перехожу к закладке с именем 'PerimeterSetting'
		И я перехожу к закладке с именем 'GroupMainPage'	
		* Марс
			Тогда открылось окно '$ЗаголовокОкна$'
			И в таблице 'GroupStructure' я перехожу к строке:
				| "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation" | "Effective share, %" |
				| "Mars LLC"                                               | "Eliminating"        | 'RUB'             | "Eliminating"      | '100'                 |
			И в таблице 'GroupStructure' я активизирую поле с именем 'GroupStructureAdditionalCurrencies'
			И в таблице 'GroupStructure' я выбираю текущую строку
			И в таблице 'GroupStructure' я нажимаю кнопку выбора у реквизита с именем 'GroupStructureAdditionalCurrencies'
			Тогда открылось окно "Currency list"
			И я нажимаю на кнопку с именем 'AdditionalCurrenciesAdd'
			И в таблице 'AdditionalCurrencies' из выпадающего списка с именем 'ДополнительныеВалютыВалюта' я выбираю точное значение "EUR"
			И в таблице 'AdditionalCurrencies' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'ДополнительныеВалютыДобавить'
			И в таблице 'AdditionalCurrencies' из выпадающего списка с именем 'AdditionalCurrenciesCurrency' я выбираю точное значение "USD"
			И в таблице 'AdditionalCurrencies' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'FormOkCommand'
		* Меркурий
			Тогда открылось окно '$ЗаголовокОкна$'
			И в таблице 'GroupStructure' я завершаю редактирование строки
			И в таблице 'GroupStructure' я перехожу к строке:
				| "Company kind" | "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation"        | "Effective share, %" |
				| "VA - Package CFR"  | "Mercury LLC"                                           | "Balance and turnovers"    | 'RUB'             | "VA - Subsidiary" | '50.000'              |
			И в таблице 'GroupStructure' я выбираю текущую строку
			И в таблице 'GroupStructure' я нажимаю кнопку выбора у реквизита с именем 'GroupStructureAdditionalCurrencies'
			Тогда открылось окно "Currency list"
			И я нажимаю на кнопку с именем 'AdditionalCurrenciesAdd'
			И в таблице 'AdditionalCurrencies' из выпадающего списка с именем 'ДополнительныеВалютыВалюта' я выбираю точное значение "EUR"
			И в таблице 'AdditionalCurrencies' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'ДополнительныеВалютыДобавить'
			И в таблице 'AdditionalCurrencies' из выпадающего списка с именем 'AdditionalCurrenciesCurrency' я выбираю точное значение "USD"
			И в таблице 'AdditionalCurrencies' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'FormOkCommand'
		* Венера
			Тогда открылось окно '$ЗаголовокОкна$'
			И в таблице 'GroupStructure' я завершаю редактирование строки
			И в таблице 'GroupStructure' я перехожу к строке:
				| "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation" | "Effective share, %" |
				| "Venus LLC"                                             | "Financial responsibility center"                  | 'RUB'             | "Financial responsibility center"                | '100'                 |
			И в таблице 'GroupStructure' я выбираю текущую строку
			И в таблице 'GroupStructure' я нажимаю кнопку выбора у реквизита с именем 'GroupStructureAdditionalCurrencies'
			Тогда открылось окно "Currency list"
			И я нажимаю на кнопку с именем 'AdditionalCurrenciesAdd'
			И в таблице 'AdditionalCurrencies' из выпадающего списка с именем 'ДополнительныеВалютыВалюта' я выбираю точное значение "EUR"
			И в таблице 'AdditionalCurrencies' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'ДополнительныеВалютыДобавить'
			И в таблице 'AdditionalCurrencies' из выпадающего списка с именем 'AdditionalCurrenciesCurrency' я выбираю точное значение "USD"
			И в таблице 'AdditionalCurrencies' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'FormOkCommand'
		* Земля
			Тогда открылось окно '$ЗаголовокОкна$'
			И в таблице 'GroupStructure' я завершаю редактирование строки
			И в таблице 'GroupStructure' я перехожу к строке:
				| "Консолидирующая организация\n/ Организационная единица" | "Intercompany transactions exclusion method" | "Primary currency" | "Company status for consolidation" | "Effective share, %" |
				| "Earth LLC"                                              | "Financial responsibility center"                  | 'RUB'             | "Financial responsibility center"                | '100'                 |
			И в таблице 'GroupStructure' я выбираю текущую строку
			И в таблице 'GroupStructure' я нажимаю кнопку выбора у реквизита с именем 'GroupStructureAdditionalCurrencies'
			Тогда открылось окно "Currency list"
			И я нажимаю на кнопку с именем 'AdditionalCurrenciesAdd'
			И в таблице 'AdditionalCurrencies' из выпадающего списка с именем 'AdditionalCurrenciesCurrency' я выбираю точное значение "USD"
			И в таблице 'AdditionalCurrencies' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'FormOkCommand'

	* Тестируем отчеты и связанные ссылки
		Тогда Открылся регламент подготовки отчетности "VA - Main regulations"
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'FormInvestorsComposition'
		Тогда открылось окно "Ownership structure"
		И Я закрываю окно "Ownership structure"
		Тогда открылось окно '$ЗаголовокОкна$'
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'GroupStructureReportRegulationOrganizationalStructuresOrganizationalStructureChart'
		Тогда открылось окно "Organizational structure briefly"
		И Я закрываю окно "Organizational structure briefly"
		Тогда открылось окно '$ЗаголовокОкна$'
		И в таблице 'GroupStructure' я нажимаю на кнопку с именем 'GroupStructureReportRegulationOrganizationalStructuresOrganizationalStructureTable'
		Тогда открылось окно "Organizational structure briefly"
		И Я закрываю окно "Organizational structure briefly"
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'FormDocumentScenarioPeriodManagementAccountingPeriodManagementDocuments'
		Тогда открылось окно "Reporting period management"
		И Я закрываю окно "Reporting period management"
		Тогда открылось окно '$ЗаголовокОкна$'
		И я перехожу к закладке с именем 'GroupMainPage'
	
	* Запишем и закроем элемент
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна '$ЗаголовокОкна$' в течение 20 секунд
		Тогда открылось окно "Regulations for preparing reports"
		И в таблице 'List' я выбираю текущую строку
	
Сценарий: 00.13 Создание документа Управление отчетным периодом

	* Откроем форму нового документа
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Reporting period management"
		Тогда открылось окно "Reporting period management"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Reporting period management (create)"
	
	* Заполняем поля на первой вкладке
		И из выпадающего списка с именем 'Scenario' я выбираю по строке "VA - Main scenario"
		И из выпадающего списка с именем 'ScenarioFrequency' я выбираю точное значение "Month"
		И я нажимаю на кнопку с именем 'ChangePeriod'
		Тогда открылось окно "Select period"
		И в поле с именем 'DateBegin' я ввожу текст '01.01.2024'
		И в поле с именем 'DateEnd' я ввожу текст '31.03.2024'
		И я нажимаю на кнопку с именем 'Select'	
		Тогда открылось окно "Reporting period management (create) *"
		И из выпадающего списка с именем 'OrganizationalStructureVersion' я выбираю по строке "VA - Main regulations"	
//		И я устанавливаю флаг с именем 'LimitsSet'
//		И я нажимаю на кнопку с именем 'OpenReportTypesToSetLimits'
//		Тогда открылось окно "Types of reports for limit setting"
//		И Я закрываю окно "Types of reports for limit setting"
//		Тогда открылось окно "Reporting period management (create) *"
//		И я снимаю флаг с именем 'LimitsSet'
		И я нажимаю на кнопку с именем 'FormGoForward'
		Тогда открылось окно "1C:Enterprise"
		И я нажимаю на кнопку с именем 'Button0'

	* Заполняем курсы валют
		Тогда Открылся документ управления периодом для сценария "VA - Main scenario" периодичность "Month"
		И Я заполняю таблицу курсов в управлении периодом сценария
		И я нажимаю на кнопку с именем 'FormGoForward'
		Тогда открылось окно "1C:Enterprise"
		И я нажимаю на кнопку с именем 'Button0'

	* Тестируем кнопки 
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'FormGoForward'				
		* Блокируем период
			И я нажимаю на кнопку с именем 'PeriodsManagement1'
			Когда открылось окно "Manage period lock duration and indicator updates"
			И в табличном документе 'SpreadsheetFieldPeriodsManagement' я перехожу к ячейке "R5C2:R5C4"
			И я нажимаю на кнопку с именем 'ClosePeriod'
			И я нажимаю на кнопку с именем 'OpenPeriod'
			И в табличном документе 'SpreadsheetFieldPeriodsManagement' я перехожу к ячейке "R5C2:R5C3"
			И я нажимаю на кнопку с именем 'ClosePeriod'
			И Я закрываю окно "Manage period lock duration and indicator updates"
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'ButtonDeleteVersions'
		Тогда открылось окно "1C:Enterprise"
		И я нажимаю на кнопку с именем 'Button0'
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'FormClose'

	* Открываем уже записанную форму
		Когда открылось окно "Reporting period management"
		И в таблице 'List' я выбираю текущую строку
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'ReportOrganizationStructure'
		Тогда открылось окно "Organizational structure briefly"
		И Я закрываю окно "Organizational structure briefly"
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'FormGoForward'
		И я нажимаю на кнопку с именем 'FormGoForward'
		И я нажимаю на кнопку с именем 'FormGoForward'
		И я нажимаю на кнопку с именем 'FormBack'
		И я нажимаю на кнопку с именем 'FormBack'
		И я нажимаю на кнопку с именем 'FormBack'
		И я нажимаю на кнопку с именем 'FormClose'

Сценарий: 00.14 Создание Видов аналитики (корпоративные)
	
	* Настроим аналитику 'Currency'	
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Dimension types (corporate)"
		И Я в списке "Dimension types (corporate)" по полю "Description" ищу и выбираю элемент 'Currencies' "Exact match" 
		Когда открылось окно '* (Dimension types (corporate))'
		И в поле с именем 'Description' я ввожу текст "Currencies"
		И я запоминаю значение поля с именем 'Code' как 'КодВалюта'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "* (Dimension types (corporate)) *" в течение 20 секунд
		И Я для вида аналитики с кодом "$КодВалюта$" делаю ключом реквизит "Alphabetic code"

	Если '$$ЭтоPerform$$' Тогда
		И Я создаю вид аналитики с кодом "VA0ProCate" именем "Product categories" типом 'CatalogRef.ArbitraryClassifierCPM'
	Иначе
		И Я создаю вид аналитики с кодом "VA0ProCate" именем "Product categories" типом 'CatalogRef.ProductCategories'
	И Я для вида аналитики с кодом "VA0ProCate" делаю ключом реквизит "Description"

	И Я создаю вид аналитики с кодом "VA0Product" именем "Product range" типом 'CatalogRef.Products'
	И Я для вида аналитики с кодом "VA0Product" делаю ключом реквизит "Description"
	И Я для вида аналитики с кодом "VA0Product" делаю ключом реквизит "Product ID"

	И Я создаю вид аналитики с кодом "VA0Counter" именем "Counterparties" типом 'CatalogRef.Counterparties'
	Если '$$ЭтоЕРПУХ$$' Тогда
		И Я для вида аналитики с кодом "VA0Counter" делаю ключом реквизит "Working name"
	Иначе
		И Я для вида аналитики с кодом "VA0Counter" делаю ключом реквизит "Name in the application"

	И Я создаю вид аналитики с кодом "VA0Contrac" именем "Counterparty contracts" типом 'CatalogRef.CounterpartyContracts'
	Если '$$ЭтоЕРПУХ$$' Тогда
		И Я для вида аналитики с кодом "VA0Contrac" делаю ключом реквизит "Working name"
	Иначе
		И Я для вида аналитики с кодом "VA0Contrac" делаю ключом реквизит "Description"

	И Я создаю вид аналитики с кодом "VA0CFItems" именем "Cash flow items" типом 'CatalogRef.CashFlowReportItems'
	И Я для вида аналитики с кодом "VA0CFItems" делаю ключом реквизит "Description"

	И Я создаю вид аналитики с кодом "VA0IEItems" именем "Income and expense items" типом 'CatalogRef.IncomeAndExpenseItems'
	И Я для вида аналитики с кодом "VA0IEItems" делаю ключом реквизит "Description"

Сценарий: 00.15 Создание Вида номенклатуры

	Если '$$ЭтоУХ$$' Тогда
		И Я создаю группу номенклатуры с именем "VA - Products"
		Если 'НЕ $$ЭтоPerform$$' Тогда
			И Я создаю вид номенклатуры с именем "VA - Products"
			И Я создаю вид номенклатуры с именем "DimenKind - Other"

	Если '$$ЭтоЕРПУХ$$' Тогда
		И Я создаю вид номенклатуры с именем "VA - Products" тип 'Goods' в 1C:ERPУХ
		И Я создаю вид номенклатуры с именем "DimenKind - Other" тип 'Goods' в 1C:ERPУХ

Сценарий: 00.16 Создание Товарной категории

	Если '$$ЭтоPerform$$' Тогда
		И Я создаю субконто УХ с именем "Software products" и видом аналитики с кодом "VA0ProCate"
	Иначе
		И Я создаю товарную категорию с именем "Software products" видом номенклатуры "VA - Products"

Сценарий: 00.17 Создание номенклатурной группы

	Если 'НЕ $$ЭтоЕРПУХ$$' Тогда
		И Я создаю номенклатурную группу с именем "VA - Product range group"

Сценарий: 00.18 Создание Номенклатуры

	И Я создаю номенклатуру с именем "4C:Enterprise 8.3 CORP. Server License (x86-64)" родителем "VA - Products" видом номенклатуры "VA - Products" артикулом '2900001916059'
	И Я создаю номенклатуру с именем "3C:Enterprise 8 CORP. Client license for 100 users" родителем "VA - Products" видом номенклатуры "VA - Products" артикулом '4601546106674'
	И Я создаю номенклатуру с именем "5C:Corporate performance management" родителем "VA - Products" видом номенклатуры "VA - Products" артикулом '2900001871389'
	И Я создаю номенклатуру с именем "2C:Corporation" родителем "VA - Products" видом номенклатуры "VA - Products" артикулом '2900001871419'
	И Я создаю номенклатуру с именем "1C:ERP. Corporate performance management" родителем "VA - Products" видом номенклатуры "VA - Products" артикулом '2900001970198'

	Если '$$ЭтоУХ$$' Тогда
		И Я Для номенклатуры с именем "4C:Enterprise 8.3 CORP. Server License (x86-64)" для реквизита 'Product_Category' выбираю значение "VA - Product range group" в группе ''
		И Я Для номенклатуры с именем "3C:Enterprise 8 CORP. Client license for 100 users" для реквизита 'Product_Category' выбираю значение "VA - Product range group" в группе ''
		И Я Для номенклатуры с именем "5C:Corporate performance management" для реквизита 'Product_Category' выбираю значение "VA - Product range group" в группе ''
		И Я Для номенклатуры с именем "2C:Corporation" для реквизита 'Product_Category' выбираю значение "VA - Product range group" в группе ''
		И Я Для номенклатуры с именем "1C:ERP. Corporate performance management" для реквизита 'Product_Category' выбираю значение "VA - Product range group" в группе ''
		
		Если 'НЕ $$ЭтоPerform$$' Тогда
			И Я Для номенклатуры с именем "4C:Enterprise 8.3 CORP. Server License (x86-64)" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'ГруппаЗакупкиУХ'
			И Я Для номенклатуры с именем "3C:Enterprise 8 CORP. Client license for 100 users" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'ГруппаЗакупкиУХ'
			И Я Для номенклатуры с именем "5C:Corporate performance management" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'ГруппаЗакупкиУХ'
			И Я Для номенклатуры с именем "2C:Corporation" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'ГруппаЗакупкиУХ'
			И Я Для номенклатуры с именем "1C:ERP. Corporate performance management" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'ГруппаЗакупкиУХ'

	ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
		И Я Для номенклатуры с именем "4C:Enterprise 8.3 CORP. Server License (x86-64)" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'СворачиваемаяГруппаПланированиеИМаркетинг'
		И Я Для номенклатуры с именем "3C:Enterprise 8 CORP. Client license for 100 users" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'СворачиваемаяГруппаПланированиеИМаркетинг'
		И Я Для номенклатуры с именем "5C:Corporate performance management" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'СворачиваемаяГруппаПланированиеИМаркетинг'
		И Я Для номенклатуры с именем "2C:Corporation" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'СворачиваемаяГруппаПланированиеИМаркетинг'
		И Я Для номенклатуры с именем "1C:ERP. Corporate performance management" для реквизита 'ТоварнаяКатегория' выбираю значение "Software products" в группе 'СворачиваемаяГруппаПланированиеИМаркетинг'	

Сценарий: 00.19 Установка цен номенклатуры

	Если '$$ЭтоУХ$$' Тогда
		И Я создаю тип цен с именем "VA - Products" валютой 'RUB'
		Если '$$ЭтоPerform$$' Тогда
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "4C:Enterprise 8.3 CORP. Server License (x86-64)" на дату '01.01.2024' в значение '180000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "3C:Enterprise 8 CORP. Client license for 100 users" на дату '01.01.2024' в значение '600000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "5C:Corporate performance management" на дату '01.01.2024' в значение '1250000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "2C:Corporation" на дату '01.01.2024' в значение '2050000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "1C:ERP. Corporate performance management" на дату '01.01.2024' в значение '1950000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "4C:Enterprise 8.3 CORP. Server License (x86-64)" на дату '01.02.2024' в значение '198000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "3C:Enterprise 8 CORP. Client license for 100 users" на дату '01.02.2024' в значение '660000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "5C:Corporate performance management" на дату '01.02.2024' в значение '1375000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "2C:Corporation" на дату '01.02.2024' в значение '2255000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "1C:ERP. Corporate performance management" на дату '01.02.2024' в значение '2145000,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "4C:Enterprise 8.3 CORP. Server License (x86-64)" на дату '01.03.2024' в значение '223700,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "3C:Enterprise 8 CORP. Client license for 100 users" на дату '01.03.2024' в значение '745800,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "5C:Corporate performance management" на дату '01.03.2024' в значение '1553800,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "2C:Corporation" на дату '01.03.2024' в значение '2548200,00' 'RUB' в 1C:CPMWE
			И Я устанавливаю цену с типом "VA - Products" номенклатуры "1C:ERP. Corporate performance management" на дату '01.03.2024' в значение '2423900,00' 'RUB' в 1C:CPMWE
		Иначе
			* 1С:УХ	

				// УХ - Открываем список документов
				И В командном интерфейсе я выбираю "Warehouse" "Setting nomenclature prices"
				Тогда открылось окно "Setting nomenclature prices"		
				
				// Создаем новый документ
				И я нажимаю на кнопку с именем 'FormCreate'
				Тогда открылось окно "Setting nomenclature prices (creation)"
				И в поле с именем 'Date' я ввожу текст '01.01.2024  0:00:00'
				И из выпадающего списка с именем 'PriceType_' я выбираю по строке "VA - Products"

				// Товары
				Когда открылось окно "Setting nomenclature prices (creation) *"
				И в таблице 'Goods' я нажимаю на кнопку с именем 'GoodsAdd'
				И в таблице 'Goods' из выпадающего списка с именем 'GoodsProductRange' я выбираю по строке "4C:Enterprise 8.3 CORP. Server License (x86-64)"
				И в таблице 'Goods' в поле с именем 'ТоварыЦена' я ввожу текст '180000,00'
				И в таблице 'Goods' я нажимаю на кнопку с именем 'GoodsAdd'
				И в таблице 'Goods' из выпадающего списка с именем 'GoodsProductRange' я выбираю по строке "3C:Enterprise 8 CORP. Client license for 100 users"
				И в таблице 'Goods' в поле с именем 'ТоварыЦена' я ввожу текст '600000,00'
				И в таблице 'Goods' я нажимаю на кнопку с именем 'GoodsAdd'
				И в таблице 'Goods' из выпадающего списка с именем 'GoodsProductRange' я выбираю по строке "5C:Corporate performance management"
				И в таблице 'Goods' в поле с именем 'ТоварыЦена' я ввожу текст '1250000,00'
				И в таблице 'Goods' я нажимаю на кнопку с именем 'GoodsAdd'
				И в таблице 'Goods' из выпадающего списка с именем 'GoodsProductRange' я выбираю по строке "2C:Corporation"
				И в таблице 'Goods' в поле с именем 'ТоварыЦена' я ввожу текст '2050000,00'
				И в таблице 'Goods' я нажимаю на кнопку с именем 'GoodsAdd'
				И в таблице 'Goods' из выпадающего списка с именем 'GoodsProductRange' я выбираю по строке "1C:ERP. Corporate performance management"
				И в таблице 'Goods' в поле с именем 'ТоварыЦена' я ввожу текст '1950000,00'
			
				// Запишем документ
				И я нажимаю на кнопку с именем 'FormPostAndClose'
				И я жду закрытия окна "Setting product range prices (creation) *" в течение 30 секунд
						
				// Создадим еще один документ
				Когда открылось окно "Setting nomenclature prices"
				И я нажимаю на кнопку с именем 'FormCreate'
				Тогда открылось окно "Setting nomenclature prices (creation)"
				И в поле с именем 'Date' я ввожу текст '01.02.2024  0:00:00'
				И из выпадающего списка с именем 'PriceType_' я выбираю по строке "VA - Products"
				И в таблице 'Goods' я нажимаю на кнопку с именем 'FillByNomenclatureGroup'
				Тогда открылось окно "Product range"
				И я выбираю пункт контекстного меню с именем 'ListContextMenuFind' на элементе формы с именем 'List'
				Тогда открылась форма с именем 'UniversalListFindExtForm'
				И в поле с именем 'Pattern' я ввожу текст "VA - Products"
				И я нажимаю на кнопку с именем 'Find'
				Тогда открылось окно "Product range"
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "Setting nomenclature prices (creation) *"
				И в таблице 'Goods' я нажимаю на кнопку с именем 'GoodsChangeGoods'
				Тогда открылось окно "Update of goods table"
				И из выпадающего списка с именем 'ТекущееДействие' я выбираю точное значение "Изменить цены на процент"
				И в поле с именем 'ВариантЗначенияЧислоПроцент' я ввожу текст '10,00'
				И я нажимаю на кнопку с именем 'Execute'
				И я нажимаю на кнопку с именем 'FormMoveToDocument'
				Тогда открылось окно "Setting nomenclature prices (creation) *"
				И я нажимаю на кнопку с именем 'FormPostAndClose'
				И я жду закрытия окна "Setting product range prices (creation) *" в течение 20 секунд
			
				// Создадим документ копированием
				Когда открылось окно "Setting nomenclature prices"
				И я выбираю пункт контекстного меню с именем 'ListContextMenuCopy' на элементе формы с именем 'List'
				Тогда открылось окно "Setting nomenclature prices (creation)"
				И в поле с именем 'Date' я ввожу текст '01.03.2024  0:00:00'
				И в таблице 'Goods' я нажимаю на кнопку с именем 'GoodsChangeGoods'
				Тогда открылось окно "Update of goods table"
				И в поле с именем 'ВариантЗначенияЧислоПроцент' я ввожу текст '13,00'
				И я нажимаю на кнопку с именем 'Execute'
				И из выпадающего списка с именем 'ТекущееДействие' я выбираю точное значение "Округлить цены до"
				И из выпадающего списка с именем 'VariantValuesOrderRounding' я выбираю точное значение "100"
				И я нажимаю на кнопку с именем 'Execute'
				И я нажимаю на кнопку с именем 'FormMoveToDocument'
				Тогда открылось окно "Setting nomenclature prices (creation) *"
				И я нажимаю на кнопку с именем 'FormPostAndClose'
				И я жду закрытия окна "Setting product range prices (creation) *" в течение 20 секунд

				// Проверим результат
				Когда открылось окно "Setting nomenclature prices"
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "Setting nomenclature prices * from *"
				Тогда таблица 'Goods' стала равной:
				| 'N' | "Product range"                                                   | "Price"         | "Currency" | "Indent" |
				| '1' | "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '223 700,00'   | 'RUB'    | ''       |
				| '2' | "3C:Enterprise 8 CORP. Client license for 100 users" | '745 800,00'   | 'RUB'    | ''       |
				| '3' | "5C:Corporate performance management"                                      | '1 553 800,00' | 'RUB'    | ''       |
				| '4' | "2C:Corporation"                                                  | '2 548 200,00' | 'RUB'    | ''       |
				| '5' | "1C:ERP. Corporate performance management"                                   | '2 423 900,00' | 'RUB'    | ''       |
				И Я закрываю окно "Setting nomenclature prices * from *"				

	Если '$$ЭтоЕРПУХ$$' Тогда	

		* Создаем новый вид цен
			И В командном интерфейсе я выбираю "CRM и маркетинг" "Настройки и справочники"
			Тогда открылось окно "Settings and directories for CRM and marketing"
			И я нажимаю на кнопку с именем 'OpenPriceTypes'
			Тогда открылось окно "Price types "
			И я меняю значение переключателя с именем 'GroupWarehousesViewOptionTypesOfPrices' на 'All'
			И я жду открытия формы "Price types " в течение 10 секунд
			Если в таблице 'List' количество строк 'равно' 0 Тогда
				И Я запоминаю значение выражения 'Ложь' в переменную 'ЕстьВыборВидовЦен'
			Иначе
				И Я запоминаю значение выражения 'Истина' в переменную 'ЕстьВыборВидовЦен'
			И Пауза 1			
			И Я в списке "Price types" по полю "Description" ищу элемент "VA - Products" "Exact match" 
			И Пока в таблице 'List' количество строк 'больше' 0 Тогда
				И Я запоминаю значение выражения '"Удалить_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "VA - Products (Price type)"
				И я нажимаю на кнопку с именем 'AllowObjectAttributeEdit'
				Тогда открылось окно "Unlock attribute"
				И я нажимаю на кнопку с именем 'EnableEdit'
				Тогда открылось окно "VA - Products (Price type) *"
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "VA - Products (Price type) *" в течение 20 секунд
			И я нажимаю на кнопку с именем 'FormCreate'
			Тогда открылось окно "Price type (creation)"
			И в поле с именем 'Description' я ввожу текст "VA - Products"
			И из выпадающего списка с именем 'PriceCurrency' я выбираю точное значение 'RUB'
			И я изменяю флаг с именем 'PriceIncludesVAT'
			И я изменяю флаг с именем 'UseOnWholesaleSale'
			И я изменяю флаг с именем 'UseOnRetailSale'
			И я изменяю флаг с именем 'UseOnProductRelease'
			И я устанавливаю флаг с именем 'Round'
			И из выпадающего списка с именем 'AccuracyRounding' я выбираю точное значение "100"				
			И я нажимаю на кнопку с именем 'FormWriteAndClose'
			И я жду закрытия окна "Price type (creation) *" в течение 20 секунд

		* Вводим документ за Январь
			Когда В командном интерфейсе я выбираю "CRM and marketing" "Prices (price list)"
			Тогда открылось окно "Price list for *"
			И я нажимаю на кнопку с именем 'HistoryChangesPrices'
			Тогда открылось окно "History of price changes"
			И в таблице 'List' я нажимаю на кнопку с именем 'ListCreate'
			И я жду открытия формы  "Setting nomenclature prices (Creating)" в течение 10 секунд
			Если '$ЕстьВыборВидовЦен$' Тогда
				И в таблице 'ВыбранныеЦены' я активизирую поле с именем 'ВыбранныеЦеныСсылка'
				И я выбираю пункт контекстного меню с именем 'ВыбранныеЦеныНайти' на элементе формы с именем 'ВыбранныеЦены'
				Тогда открылась форма с именем 'UniversalListFindExtForm'
				И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Price types"
				И из выпадающего списка с именем 'Pattern' я выбираю по строке "VA - Products"
				И я нажимаю на кнопку с именем 'Find'
				Тогда открылось окно "Setting nomenclature prices (creation)"
				И в таблице 'ВыбранныеЦены' я изменяю флаг с именем 'ВыбранныеЦеныРедактировать'
				И я нажимаю на кнопку с именем 'PriceTypesNextCommand'
			И в поле с именем 'Date' я ввожу текст '01.01.2024'
			И в таблице 'ДеревоЦен' я нажимаю на кнопку с именем 'ДеревоЦенДобавитьНоменклатуру'
			И в таблице 'ДеревоЦен' из выпадающего списка с именем 'ДеревоЦенНоменклатура' я выбираю по строке "4C:Enterprise 8.3 CORP. Server License (x86-64)"
			И в таблице 'ДеревоЦен' в поле с именем 'ДеревоЦенВидЦены*' я ввожу текст '180000,00'
			И в таблице 'ДеревоЦен' я нажимаю на кнопку с именем 'ДеревоЦенДобавитьНоменклатуру'
			И в таблице 'ДеревоЦен' из выпадающего списка с именем 'ДеревоЦенНоменклатура' я выбираю по строке "3C:Enterprise 8 CORP. Client license for 100 users"
			И в таблице 'ДеревоЦен' в поле с именем 'ДеревоЦенВидЦены*' я ввожу текст '600000,00'
			И в таблице 'ДеревоЦен' я нажимаю на кнопку с именем 'ДеревоЦенДобавитьНоменклатуру'
			И в таблице 'ДеревоЦен' из выпадающего списка с именем 'ДеревоЦенНоменклатура' я выбираю по строке "5C:Corporate performance management"
			И в таблице 'ДеревоЦен' в поле с именем 'ДеревоЦенВидЦены*' я ввожу текст '1250000,00'
			И в таблице 'ДеревоЦен' я нажимаю на кнопку с именем 'ДеревоЦенДобавитьНоменклатуру'
			И в таблице 'ДеревоЦен' из выпадающего списка с именем 'ДеревоЦенНоменклатура' я выбираю по строке "2C:Corporation"
			И в таблице 'ДеревоЦен' в поле с именем 'ДеревоЦенВидЦены*' я ввожу текст '2050000,00'
			И в таблице 'ДеревоЦен' я нажимаю на кнопку с именем 'ДеревоЦенДобавитьНоменклатуру'
			И в таблице 'ДеревоЦен' из выпадающего списка с именем 'ДеревоЦенНоменклатура' я выбираю по строке "1C:ERP. Corporate performance management"
			И в таблице 'ДеревоЦен' в поле с именем 'ДеревоЦенВидЦены*' я ввожу текст '1950000,00'
			Если элемент 'НомерВПределахДня' присутствует на форме Тогда
				И в поле с именем 'NumberWithinDay' я ввожу текст '1'
			И я нажимаю на кнопку с именем 'FormPostAndClose'
			И я жду закрытия окна "Setting product range prices (creation) *" в течение 20 секунд
				
		* Вводим документ за Февраль
			Когда открылось окно "History of price changes"
			И в таблице 'List' я нажимаю на кнопку с именем 'ListCreate'
			И я жду открытия формы  "Setting nomenclature prices (Creating)" в течение 10 секунд
			Если '$ЕстьВыборВидовЦен$' Тогда
				И в таблице 'ВыбранныеЦены' я активизирую поле с именем 'ВыбранныеЦеныСсылка'
				И я выбираю пункт контекстного меню с именем 'ВыбранныеЦеныНайти' на элементе формы с именем 'ВыбранныеЦены'
				Тогда открылась форма с именем 'UniversalListFindExtForm'
				И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Price types"
				И из выпадающего списка с именем 'Pattern' я выбираю по строке "VA - Products"
				И я нажимаю на кнопку с именем 'Find'
				Тогда открылось окно "Setting nomenclature prices (creation)"
				И в таблице 'ВыбранныеЦены' я изменяю флаг с именем 'ВыбранныеЦеныРедактировать'
				И я нажимаю на кнопку с именем 'PriceTypesNextCommand'
			И в поле с именем 'Date' я ввожу текст '01.02.2024'
			И в таблице 'ДеревоЦен' я нажимаю на кнопку с именем 'ДеревоЦенДобавитьТоварыПоОтбору'
			Тогда открылось окно "Pick goods by selection"
			И в таблице 'SettingsComposerSettingsFilter' я перехожу к строке:
				| 'Comparison type' | 'Value'          | 'Use' | 'Field'             | 'Application' | 'Display mode' |
				| 'In list'      | '<Пустое значение>' | 'Нет'           | 'Вид номенклатуры' | 'Обычное'    | 'Quick access'    |
			И в таблице 'SettingsComposerSettingsFilter' я нажимаю кнопку выбора у реквизита с именем 'SettingsComposerSettingsFilterRightValue'
			Тогда открылось окно "Value list"
			И в таблице 'ValueList' я выбираю текущую строку
			И в таблице 'ValueList' из выпадающего списка с именем 'Value' я выбираю по строке "VA - Products"
			И я нажимаю на кнопку с именем 'OK'
			Тогда открылось окно "Pick goods by selection"
			И в таблице 'SettingsComposerSettingsFilter' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'Fill'
			И я нажимаю на кнопку с именем 'MoveToDocument'
			Тогда открылось окно "Setting nomenclature prices (creation) *"
			И в таблице 'ДеревоЦен' я нажимаю на кнопку с именем 'ДеревоЦенЗагрузитьСтарыеЦены'
			Тогда открылось окно "Selection of price calculation parameters"
			И я нажимаю на кнопку с именем 'OK'
			Тогда открылось окно "Setting nomenclature prices (creation) *"
			И в таблице 'ДеревоЦен' я нажимаю на кнопку с именем 'ДеревоЦенИзменитьЦены'
			Тогда открылось окно "Change to percent"
			И в таблице 'ВидыЦен' я активизирую поле с именем 'ВидыЦенПроцентИзменения'
			И в таблице 'KindsOfPrices' я выбираю текущую строку
			И в таблице 'ВидыЦен' в поле с именем 'ВидыЦенПроцентИзменения' я ввожу текст '10,00'
			И в таблице 'PriceKinds' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'OK'
			Тогда открылось окно "Setting nomenclature prices (creation) *"
			Если элемент 'НомерВПределахДня' присутствует на форме Тогда	
				И в поле с именем 'NumberWithinDay' я ввожу текст '1'
			И я нажимаю на кнопку с именем 'FormPostAndClose'
			И я жду закрытия окна "Setting product range prices (creation) *" в течение 20 секунд

		* Вводим документ за Март копированием
			Когда открылось окно "History of price changes"
			И я выбираю пункт контекстного меню с именем 'ListContextMenuCopy' на элементе формы с именем 'List'
			Тогда открылось окно "Setting nomenclature prices (creation)"
			И в поле с именем 'Date' я ввожу текст '01.03.2024'
			И в таблице 'ДеревоЦен' я нажимаю на кнопку с именем 'ДеревоЦенИзменитьЦены'
			Тогда открылось окно "Change to percent"
			И в таблице 'ВидыЦен' я изменяю флаг с именем 'ВидыЦенПересчитать'
			И в таблице 'ВидыЦен' в поле с именем 'ВидыЦенПроцентИзменения' я ввожу текст '13,00'
			Когда открылось окно "Change to percent"
			И я нажимаю на кнопку с именем 'OK'
			Тогда открылось окно "Setting nomenclature prices (creation) *"
			Если элемент 'НомерВПределахДня' присутствует на форме Тогда	
				И в поле с именем 'NumberWithinDay' я ввожу текст '1'		
			И я нажимаю на кнопку с именем 'FormPostAndClose'
			И я жду закрытия окна "Setting product range prices (creation) *" в течение 20 секунд

		* Проверяем результат
			Когда открылось окно "History of price changes"
			И в таблице 'List' я выбираю текущую строку
			Тогда открылось окно "Setting nomenclature prices * from *"
			Тогда таблица 'PriceTree' стала равной:
			| "Product range"                                                   | "Price"         |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '223 700,00'   |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '745 800,00'   |
			| "5C:Corporate performance management"                                      | '1 553 800,00' |
			| "2C:Corporation"                                                  | '2 548 200,00' |
			| "1C:ERP. Corporate performance management"                                   | '2 423 900,00' |
			И Я закрываю окно "Setting nomenclature prices * from *"

Сценарий: 00.20 Создание Контрагентов и Договоров контрагентов

	Если '$$ЭтоУХ$$' Тогда
		Если 'НЕ $$ЭтоPerform$$' Тогда
			И Я создаю условие оплаты с именем "VA - Agreement with client"
			И я перезаполняю константу 'ИспользоватьНумерациюДоговоровСПокупателями' значением 'ЛОЖЬ'			

		И Я создаю группу контрагентов с именем "VA - Counterparties"

		И Я создаю контрагента с именем "ООО \"Ганимед\"" родителем "ВА - Контрагенты" страной регистрации '643'
		И Я создаю договор для контрагента "ООО \"Ганимед\"" номер "Ganymede-001" дата '01.01.2024' валюта 'RUB' организация "Mercury LLC" вид "With customer" сумма '10000,00' условие оплаты "ВА - Соглашение с клиентом"
		И Я создаю договор для контрагента "ООО \"Ганимед\"" номер "Ганимед-002" дата '01.01.2024' валюта 'RUB' организация "Mercury LLC" вид "With supplier" сумма '20000,00' условие оплаты "ВА - Соглашение с клиентом"
		
		И Я создаю контрагента с именем "ООО \"Ио\"" родителем "ВА - Контрагенты" страной регистрации '643'
		И Я создаю договор для контрагента "ООО \"Ио\"" номер "Ио-001" дата '01.01.2024' валюта 'RUB' организация "Mercury LLC" вид "With customer" сумма '10000,00' условие оплаты "ВА - Соглашение с клиентом"
		И Я создаю договор для контрагента "ООО \"Ио\"" номер "Ио-002" дата '01.01.2024' валюта 'RUB' организация "Mercury LLC" вид "With customer" сумма '20000,00' условие оплаты "ВА - Соглашение с клиентом"
		
	Если '$$ЭтоЕРПУХ$$' Тогда					

		И Я создаю партнера с именем "ООО \"Ганимед\"" тип 'Client' в 1C:ERPУХ

		И Я создаю соглашение с клиентом с именем "VA - Agreement with customer" валютой 'RUB' в 1C:ERPУХ	

		И Для партнера "ООО \"Ганимед\"" я создаю контрагента с именем "ООО \"Ганимед\"" вид 'Legal entity' в 1C:ERPУХ
		И Для партнера "ООО \"Ганимед\"" контрагента "ООО \"Ганимед\"" я создаю договор с видом "With customer" номер "Ganymede-001" от '01.01.2024' организация "Mercury LLC" валюта 'RUB' сумма '10000,00' соглашение "ВА - Соглашение с клиентом" в 1C:ERPУХ		
		И Для партнера "ООО \"Ганимед\"" контрагента "ООО \"Ганимед\"" я создаю договор с видом "With customer" номер "Ганимед-002" от '01.01.2024' организация "Mercury LLC" валюта 'RUB' сумма '20000,00' соглашение "ВА - Соглашение с клиентом" в 1C:ERPУХ		

		И Я создаю партнера с именем "ООО \"Ио\"" тип 'Supplier' в 1C:ERPУХ

		И Я создаю соглашение с поставщиком "ООО \"Ио\"" с именем "ВА - Соглашение с поставщиком" валютой 'RUB' в 1C:ERPУХ

		И Для партнера "ООО \"Ио\"" я создаю контрагента с именем "ООО \"Ио\"" вид 'Legal entity' в 1C:ERPУХ
		И Для партнера "ООО \"Ио\"" контрагента "ООО \"Ио\"" я создаю договор с видом "With supplier" номер "Ио-001" от '01.01.2024' организация "Mercury LLC" валюта 'RUB' сумма '10000,00' соглашение "ВА - Соглашение с поставщиком" в 1C:ERPУХ		
		И Для партнера "ООО \"Ио\"" контрагента "ООО \"Ио\"" я создаю договор с видом "With supplier" номер 'Ио-002' от '01.01.2024' организация "Mercury LLC" валюта 'RUB' сумма '20000,00' соглашение "ВА - Соглашение с поставщиком" в 1C:ERPУХ		

Сценарий: 00.21 Создание Статей движения денежных средств

	И Я создаю группу статей ДДС с именем "VA - Cash flow items"
	И Я создаю статью ДДС с именем "3Software sale" родителем "VA - Cash flow items"
	И Я создаю статью ДДС с именем "2Software implementation" родителем "VA - Cash flow items"
	И Я создаю статью ДДС с именем "1Software upgrade" родителем "VA - Cash flow items"

Сценарий: 00.22 Создание Статьей доходов и расходов

	И Я создаю группу статей ДиР с именем "VA - Income and expense items"
	И Я создаю статью ДиР с именем "3Software sale" родителем "VA - Income and expense items"
	И Я создаю статью ДиР с именем "2Software implementation" родителем "VA - Income and expense items"

Сценарий: 00.23 Создание документа "Reflection of actual data"

	Если 'НЕ $$ЭтоPerform$$' Тогда

		* Создаем новый документ №1
			И В командном интерфейсе я выбираю "Казначейство" "Отражения фактических данных"
			Тогда открылось окно "Reflections of actual data"
			И я нажимаю на кнопку с именем 'FormCreate'

			* Страница 'Main'	
				Тогда открылось окно "Reflection of actual data (Creating)"
				И в поле с именем 'Date' я ввожу текст '01.01.2024  0:00:00'
				И из выпадающего списка с именем 'DBDocument' я выбираю по строке 'SaleOfGoodsAndServices'		
				И из выпадающего списка с именем 'Scenario' я выбираю по строке "VA - Main scenario"
				И из выпадающего списка с именем 'Organization' я выбираю по строке "Mercury LLC"
				И я нажимаю кнопку выбора у поля с именем 'Counterparty'
				Тогда открылось окно "Select data type"
				И в таблице 'TypeTree' я перехожу к строке
					| 'Column1' |
					| 'Counterparty' |
				И в таблице 'TypeTree' я выбираю текущую строку
				Тогда открылось окно "Counterparties*"
				И я нажимаю на кнопку с именем 'FormFind'
				Тогда открылась форма с именем 'UniversalListFindExtForm'
				Если '$$ЭтоУХ$$' Тогда
					И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Name in the application"
				Если '$$ЭтоЕРПУХ$$' Тогда
					И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
				И я меняю значение переключателя с именем 'CompareType' на "Exact match"
				И в поле с именем 'Pattern' я ввожу текст "ООО \"Ганимед\""
				И я нажимаю на кнопку с именем 'Find'
				Тогда открылось окно "Counterparties*"
				И в таблице 'List' я выбираю текущую строку
				И из выпадающего списка с именем 'DocumentCurrency' я выбираю точное значение "RUB"
				И из выпадающего списка с именем 'ArrivalExpense' я выбираю точное значение "Income"
			
			* Бюджет движения денежных средств
				Когда открылось окно "Recording actual data (creation) *"
				И я перехожу к закладке с именем 'GroupCFB'
				И из выпадающего списка с именем 'ПериодБДДС' я выбираю по строке '1 неделя. Январь 2024 г.'
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' я нажимаю на кнопку с именем 'ТабБюджетДвиженияДенежныхСредствДобавить'
				Если '$$ЭтоЕРПУХ$$' Тогда
					И в таблице 'ТабБюджетДвиженияДенежныхСредств' я нажимаю кнопку выбора у реквизита с именем 'ТабБюджетДвиженияДенежныхСредствДоговорКонтрагента'
					Тогда открылось окно "Select data type"
					И в таблице '' я перехожу к строке:
						| ''                       |
						| 'Contract with counterparty' |
					И в таблице '' я выбираю текущую строку
					Тогда открылось окно "Contracts with counterparties"
					И Я закрываю окно "Contracts with counterparties"
					И в таблице 'ТабБюджетДвиженияДенежныхСредств' я нажимаю кнопку выбора у реквизита с именем 'ТабБюджетДвиженияДенежныхСредствСтатьяДвиженияДенежныхСредств'
					Если открылось окно "Select data type" Тогда
						И в таблице '' я перехожу к строке:
							| ''                                 |
							| "Cash flow item" |
						И в таблице '' я выбираю текущую строку
					Тогда открылось окно "Cash flow items"
					И Я закрываю окно "Cash flow items"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствДоговорКонтрагента' я выбираю по строке "Ganymede-001"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствСтатьяДвиженияДенежныхСредств' я выбираю по строке "3Software sale"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствЦФО' я выбираю по строке "Mercury LLC"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствПроект' я выбираю по строке "VA - Main project"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' в поле с именем 'ТабБюджетДвиженияДенежныхСредствСумма' я ввожу текст '780 000,00'			
				И в таблице 'TableBudgetCashFlow' я завершаю редактирование строки
				И я выбираю пункт контекстного меню с именем 'ТабБюджетДвиженияДенежныхСредствКонтекстноеМенюСкопировать' на элементе формы с именем 'ТабБюджетДвиженияДенежныхСредств'
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствДоговорКонтрагента' я выбираю по строке "Ганимед-002"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствСтатьяДвиженияДенежныхСредств' я выбираю по строке "2Software implementation"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' в поле с именем 'ТабБюджетДвиженияДенежныхСредствСумма' я ввожу текст '2 340 000,00'
				И в таблице 'TableBudgetCashFlow' я завершаю редактирование строки		
				
			* Запишем документ, проверим движения
				Когда открылось окно "Recording actual data (creation) *"
				И я нажимаю на кнопку с именем 'FormPost'
				Тогда открылось окно "Reflection of actual data * from *"
				И я нажимаю на кнопку с именем 'FormProcessingDocumentRegisterRecordsDocumentRegisterRecordsReport'
				Тогда открылось окно "Document register records: Reflection of actual data * from *"
				Если '$$ЭтоУХ$$' Тогда
					И я перехожу к закладке с именем 'GroupCashFlowCPM'
					Тогда таблица 'CashFlowCPM' стала равной:
						| 'N' | "Cash flow item" | "Банковский счет / касса" | "Income expense" | "Вид денежных средств" | "Контрагент, подотчетник, касса ККМ" | 'Dimension2' | "Counterparty contract"       | 'Dimension1' | 'Dimension3' | 'Dimension4' | 'Dimension5' | 'Dimension6' | "Сумма упр. учета" | 'Amount'        |
						| '1' | "3Software sale" | ''                        | 'Income'        | 'Безналичная'          | 'ООО "Ганимед"'                      | ''           | 'Ganymede-001 from 1/1/2024' | ''           | ''           | ''           | ''           | ''           | '780 000,00'       | '780 000,00'   |
						| '2' | "2Software implementation"  | ''                        | 'Income'        | 'Безналичная'          | 'ООО "Ганимед"'                      | ''           | 'Ganymede-002 from 1/1/2024' | ''           | ''           | ''           | ''           | ''           | '2 340 000,00'     | '2 340 000,00' |
				Если '$$ЭтоЕРПУХ$$' Тогда
					Тогда таблица "BudgetsOperations" стала равной:
						| 'N' | 'Budget profile'                      | 'Income expense' | 'Amount' | 'Аналитика партнеров'                                    | 'Курс планирования' | 'Сумма исполнено' | 'Аналитика структуры'                              | 'Количество' | 'Currency' | 'Аналитика статей бюджетов'               |
						| '1' | 'Cash flow budget' | 'Income'        | ''      | 'Меркурий ООО; ООО "Ганимед"; Ганимед-001 от 01.01.2024' | '1,0000'            | '780 000,00'      | 'Меркурий ООО; ВА - Основной проект; Меркурий ООО' | ''           | 'RUB'    | 'Реализация программных продуктов Приход' |
						| '2' | 'Cash flow budget' | 'Income'        | ''      | 'Меркурий ООО; ООО "Ганимед"; Ганимед-002 от 01.01.2024' | '1,0000'            | '2 340 000,00'    | 'Меркурий ООО; ВА - Основной проект; Меркурий ООО' | ''           | 'RUB'    | 'Внедрение программных продуктов Приход'  |

			* Закроем документ	
				Когда открылось окно "Document register records: Recording actual data * from *"
				И Я закрываю окно "Document register records: Posting actual data * from *"
				Тогда открылось окно "Reflection of actual data * from *"
				И я нажимаю на кнопку с именем 'FormPostAndClose'
				И я жду закрытия окна "Recording of actual data * from *" в течение 20 секунд

		* Создаем новый документ №2
			Когда открылось окно "Actual data recordings"
			И я выбираю пункт контекстного меню с именем 'ListContextMenuCopy' на элементе формы с именем 'List'
			Тогда открылось окно "Reflection of actual data (Creating)"
			И в поле с именем 'Date' я ввожу текст '01.02.2024  0:00:00'
			И из выпадающего списка с именем 'Counterparty' я выбираю по строке "ООО \"Ио\""				

			* Бюджет движения денежных средств
				И я перехожу к закладке с именем 'GroupCFB'
				И из выпадающего списка с именем 'ПериодБДДС' я выбираю по строке '1 неделя. Февраль 2024 г.'
				И в таблице 'TabBudgetMovementOfMonetaryFunds' я выбираю текущую строку
				Если '$$ЭтоЕРПУХ$$' Тогда
					И в таблице 'ТабБюджетДвиженияДенежныхСредств' я нажимаю кнопку выбора у реквизита с именем 'ТабБюджетДвиженияДенежныхСредствДоговорКонтрагента'
					Тогда открылось окно "Select data type"
					И в таблице '' я перехожу к строке:
						| ''                       |
						| 'Contract with counterparty' |
					И в таблице '' я выбираю текущую строку
					Тогда открылось окно "Contracts with counterparties"
					И Я закрываю окно "Contracts with counterparties"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствДоговорКонтрагента' я выбираю по строке 'Ио-002'
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' я активизирую поле с именем 'ТабБюджетДвиженияДенежныхСредствСумма'
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' в поле с именем 'ТабБюджетДвиженияДенежныхСредствСумма' я ввожу текст '5 200 000,00'
				И в таблице 'TableBudgetCashFlow' я завершаю редактирование строки
				И в таблице 'TableBudgetMovementOfMonetaryFunds' я перехожу к следующей строке
				Если '$$ЭтоЕРПУХ$$' Тогда
					И в таблице 'ТабБюджетДвиженияДенежныхСредств' я нажимаю кнопку выбора у реквизита с именем 'ТабБюджетДвиженияДенежныхСредствДоговорКонтрагента'
					Тогда открылось окно "Select data type"
					И в таблице '' я перехожу к строке:
						| ''                       |
						| 'Contract with counterparty' |
					И в таблице '' я выбираю текущую строку
					Тогда открылось окно "Contracts with counterparties"
					И Я закрываю окно "Contracts with counterparties"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствДоговорКонтрагента' я выбираю по строке "Ио-002"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' я активизирую поле с именем 'ТабБюджетДвиженияДенежныхСредствСумма'
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' в поле с именем 'ТабБюджетДвиженияДенежныхСредствСумма' я ввожу текст '7 350 000,00'
				И в таблице 'TableBudgetCashFlow' я завершаю редактирование строки
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' я нажимаю на кнопку с именем 'ТабБюджетДвиженияДенежныхСредствДобавить'
				Если '$$ЭтоЕРПУХ$$' Тогда
					И в таблице 'ТабБюджетДвиженияДенежныхСредств' я нажимаю кнопку выбора у реквизита с именем 'ТабБюджетДвиженияДенежныхСредствДоговорКонтрагента'
					Тогда открылось окно "Select data type"
					И в таблице '' я перехожу к строке:
						| ''                       |
						| 'Contract with counterparty' |
					И в таблице '' я выбираю текущую строку
					Тогда открылось окно "Contracts with counterparties"
					И Я закрываю окно "Contracts with counterparties"
					И в таблице 'ТабБюджетДвиженияДенежныхСредств' я нажимаю кнопку выбора у реквизита с именем 'ТабБюджетДвиженияДенежныхСредствСтатьяДвиженияДенежныхСредств'
					Если открылось окно "Select data type" Тогда
						И в таблице '' я перехожу к строке:
						| ''                                 |
						| "Cash flow item" |
						И в таблице '' я выбираю текущую строку
					Тогда открылось окно "Cash flow items"
					И Я закрываю окно "Cash flow items"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствДоговорКонтрагента' я выбираю по строке "Ио-002"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствСтатьяДвиженияДенежныхСредств' я выбираю по строке "1Software upgrade"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствЦФО' я выбираю по строке "Mercury LLC"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' из выпадающего списка с именем 'ТабБюджетДвиженияДенежныхСредствПроект' я выбираю по строке "VA - Main project"
				И в таблице 'ТабБюджетДвиженияДенежныхСредств' в поле с именем 'ТабБюджетДвиженияДенежныхСредствСумма' я ввожу текст '3 450 000,00'
				И в таблице 'TableBudgetCashFlow' я завершаю редактирование строки
				
			* Запишем документ
				И я нажимаю на кнопку с именем 'FormPostAndClose'
				И я жду закрытия окна "Recording of actual data (creation) *" в течение 20 секунд						
