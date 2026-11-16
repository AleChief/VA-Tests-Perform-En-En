#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для создания НСИ




Сценарий: я нахожу организацию с именем 'TheBusinessUnitName'
	Если '$$ЭтоУХ$$' Тогда
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Business units"
	Если '$$ЭтоЕРПУХ$$' Тогда
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Companies"

	* Открываем организацию
		Когда открылось окно "Business units"
		И я нажимаю на кнопку с именем 'FormFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		Если '$$ЭтоЕРПУХ$$' Тогда
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
		ИначеЕсли '$$ЭтоPerform$$' Тогда
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
		ИначеЕсли '$$ЭтоУХ$$' Тогда
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Name in the application"
		И в поле с именем 'Pattern' я ввожу текст '[TheBusinessUnitName]'
		И я меняю значение переключателя с именем 'CompareType' на "At the beginning of the line"
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно "Business units"
		Если в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			Тогда открылось окно "* (Business unit)"



Сценарий: Я создаю условие оплаты аванс 'S1'\'P1' и постоплата 'S2'\'P2'

	* Открываем форму списка
		И В командном интерфейсе я выбираю "Управление обязательствами" "Условия оплаты"

	* Удаляем текущий элемент
		И Я в списке "Условия оплаты" по полю "Description" ищу элемент "Аванс [P1]% за [S1] к.д., Постоплата [P2]% через [S2] к.д." "Anywhere in the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И я снимаю флаг с именем 'AutoName'
			И я нажимаю на кнопку с именем 'FormWrite'										
			И Я удаляю текущий элемент в окне "* (Payment condition)" очищая

	* Создаем элемент
		Тогда открылось окно "Payment terms"	
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Payment condition (creation)"
		И в таблице 'ЭтапыОплаты' я нажимаю на кнопку с именем 'ЭтапыОплатыДобавить'
		И в таблице 'ЭтапыОплаты' из выпадающего списка с именем 'ЭтапыОплатыВариантОплаты' я выбираю точное значение "Аванс (до базовой даты)"
		И в таблице 'StagesPayment' в поле с именем 'ЭтапыОплатыСрок' я ввожу текст '[S1]'
		И в таблице 'ЭтапыОплаты' в поле с именем 'ЭтапыОплатыПроцентОплаты' я ввожу текст '[P1]'
		И в таблице 'PaymentStages' я завершаю редактирование строки
		Если 'НЕ ПустаяСтрока("[S2]")' Тогда
			И в таблице 'ЭтапыОплаты' я нажимаю на кнопку с именем 'ЭтапыОплатыДобавить'
			И в таблице 'ЭтапыОплаты' из выпадающего списка с именем 'ЭтапыОплатыВариантОплаты' я выбираю точное значение "Постоплата (после базовой даты)"
			И в таблице 'StagesPayment' в поле с именем 'ЭтапыОплатыСрок' я ввожу текст '[S2]'
			И в таблице 'ЭтапыОплаты' в поле с именем 'ЭтапыОплатыПроцентОплаты' я ввожу текст '[P2]'
			И в таблице 'PaymentStages' я завершаю редактирование строки
		И я нажимаю на кнопку с именем 'FormWrite'
		И я запоминаю значение поля с именем 'Description' как 'ConditionPayment'		
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Payment condition (creation) *" в течение 20 секунд	

	* Закрываем список	
		Тогда открылось окно "Payment terms"
		И Я закрываю окно "Payment terms"

Сценарий: Я создаю договор для контрагента 'TheName' номер 'TheNumber' дата 'TheDate' валюта 'TheCurrency' организация 'TheBusinessUnit' вид 'TheContractKind' сумма 'TheSum' условие оплаты 'TheTermsOfPayment'

	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И В командном интерфейсе я выбираю "Quick menu" "Counterparties"
			И Я в списке "Counterparties" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"
		Иначе
			И В командном интерфейсе я выбираю "Catalogs" "Counterparties"
			И Я в списке "Counterparties" по полю "Name in the application" ищу элемент '[TheName]' "At the beginning of the line"

	* Ищем контрагента
		И в таблице 'List' количество строк 'равно' 1
		И в таблице 'List' я выбираю текущую строку
		Тогда открылось окно "* (Counterparty)"
		И В текущем окне я нажимаю кнопку командного интерфейса "Contracts"

	* Удаляем текущий элемент
		И Я в списке "* (Counterparty)" по полю "Description" ищу элемент "[TheNumber] from [TheDate]" "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'List'
			* Переименовываем
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "*"
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWrite'
				Тогда открылось окно "*"
				И Я закрываю окно "*"

	* Создаем элемент
		Когда открылось окно "* (Counterparty)"
		И я нажимаю на кнопку с именем 'FormCreate'
		Если '$$ЭтоPerform$$' Тогда
			Когда открылось окно "Contract (create)*"
			И из выпадающего списка с именем 'TypeOfAgreement' я выбираю точное значение "TheContractKind"
		Иначе	
			Тогда открылось окно "Select contract type"
			И в таблице 'TypesOfContracts' я перехожу к строке:
				| "Contract kind"     |
				| '[TheContractKind]' |
			И в таблице 'KindsOfContracts' я выбираю текущую строку
		Тогда открылось окно "* (create)*"
		И в поле с именем 'Number' я ввожу текст '[TheNumber]'
		И в поле с именем 'Date' я ввожу текст '[TheDate]'
		И в поле с именем 'Наименование' я ввожу текст "[TheNumber] from [TheDate]"
		И из выпадающего списка с именем 'Organization' я выбираю по строке '[TheBusinessUnit]'
		И из выпадающего списка с именем 'ARAPCurrency' я выбираю точное значение '[TheCurrency]'
		Если '$$ЭтоPerform$$' Тогда
			И в поле с именем 'Sum' я ввожу текст '[TheSum]'
			И я нажимаю на кнопку с именем 'FormWriteAndClose'
		Иначе
			Если флаг с именем "ФиксированнаяСуммаДоговора" равен "Ложь" Тогда
				И я изменяю флаг с именем 'FixedContractAmount' 
			И в поле с именем 'СуммаДоговора' я ввожу текст '[TheSum]'
			И я перехожу к закладке с именем 'GroupCalculations'
			И из выпадающего списка с именем 'PaymentCondition' я выбираю по строке '[TheTermsOfPayment]'			
			И я нажимаю на кнопку с именем 'FormPostAndClose'	
		И я жду закрытия окна "Contract (create) *" в течение 20 секунд

	* Закрываем формы
		Когда открылось окно "* (Counterparty)"
		И Я закрываю окно "* (Counterparty)"
		Тогда открылось окно "Counterparties"
		И Я закрываю окно "Counterparties"

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

Сценарий: Я создаю номенклатуру с именем 'TheProductName' родителем 'TheProductParent' видом номенклатуры 'TheProductKind' артикулом 'TheProductID'

	* Открываем список
		Если '$$ЭтоPerform$$' Тогда
			И В командном интерфейсе я выбираю "Quick menu" "Product range"		
		ИначеЕсли '$$ЭтоУХ$$' Тогда
			И В командном интерфейсе я выбираю "Catalogs" "Product range"
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И В командном интерфейсе я выбираю "Quick menu" "Product range"
			И я снимаю флаг с именем 'UseFilters'		
		Тогда открылось окно "Product range"

	* Удаляем текущий элемент
		Если '$$ЭтоУХ$$' Тогда
			И Я в списке "Product range" по полю "Description" ищу элемент '[TheProductName]' "At the beginning of the line"		
			И Пока в таблице 'List' количество строк 'больше' 0 Тогда
				И в таблице 'List' я выбираю текущую строку
				И Я удаляю текущий элемент в окне "* (Product range)" очищая 'Product ID'
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И пауза 1
			И я нажимаю кнопку очистить у поля с именем 'SearchStringProductRange'					
			И в поле с именем 'SearchStringProductRange' я ввожу текст '[TheProductName]'
			И я нажимаю на кнопку с именем 'Find'				
			Если появилось окно с заголовком 'Search' в течение 1 секунд Тогда
				И я нажимаю на кнопку с именем 'Button0'
			Тогда открылось окно "Product range"
			И Пока в таблице 'ListAdvancedSearchProducts' количество строк 'больше' 0 Тогда
				* Ставим пометку на удаление
					Если в таблице 'ListAdvancedSearchProducts' текущая строка не помечена на удаление Тогда
						И я выбираю пункт контекстного меню с именем 'ListAdvancedSearchProductsContextMenuSetDeletionMark' на элементе формы с именем 'ListAdvancedSearchProducts'
						Тогда открылось окно "1C:Enterprise"
						И я нажимаю на кнопку с именем 'Button0'
				* Переименовываем
					И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
					И в таблице 'ListAdvancedSearchProducts' я выбираю текущую строку
					Когда открылось окно "* (Product range)"
					И я перехожу к закладке с именем 'PageProductAttributes'
					Если появилось окно с заголовком 'Useful tip' в течение 1 секунд Тогда
						И я нажимаю на кнопку с именем 'Button0'
					Когда открылось окно "* (Product range)"								
					Тогда в поле с именем 'Description' я ввожу значение переменной 'UID'
					И в поле с именем 'SKU' я ввожу текст ' '	
					И я нажимаю на кнопку с именем 'FillDescriptionForPrintByTemplate'
					И я нажимаю на кнопку с именем 'FormWriteAndClose'
					И я жду закрытия окна "* (Product range)" в течение 20 секунд
					Если появилось окно с заголовком 'Search' в течение 1 секунд Тогда
						И я нажимаю на кнопку с именем 'Button0'

	* Создаем новый элемент
		Когда открылось окно "Product range"
		Если '$$ЭтоУХ$$' Тогда			
			И я нажимаю на кнопку с именем 'FormCreate'
			Тогда открылось окно "Product range (create)"
			И в поле с именем 'Description' я ввожу текст '[TheProductName]'
			И в поле с именем 'SKU' я ввожу текст '[TheProductID]'
			И из выпадающего списка с именем 'Parent' я выбираю по строке '[TheProductParent]'
			И из выпадающего списка с именем 'UnitOfMeasure' я выбираю по строке "PCs"
			Если 'НЕ $$ЭтоPerform$$' Тогда
				И из выпадающего списка с именем 'ProductKind' я выбираю по строке '[TheProductKind]'
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И я нажимаю на кнопку с именем 'ListAdvancedSearchProductsCreate'
			Тогда открылось окно "Product range (create)"
			И из выпадающего списка с именем 'ProductKindRequiredFields' я выбираю по строке '[TheProductKind]'
			И я меняю значение переключателя с именем 'НастройкаВидимостиФормы' на 'Показать все'
			И в поле с именем 'Description' я ввожу текст '[TheProductName]'
			И в поле с именем 'SKU' я ввожу текст '[TheProductID]'	
			Когда открылось окно 'Product range (create) *'
			И из выпадающего списка с именем "UnitOfMeasure" я выбираю по строке 'PCs'			
								
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Product range (create) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Product range"
		Если '$$ЭтоЕРПУХ$$' Тогда
			И я устанавливаю флаг с именем 'UseFilters'
		И Я закрываю окно "Product range"	

Сценарий: Я создаю вид номенклатуры с именем 'TheProductKindName'

	* Открываем список
		И В командном интерфейсе я выбираю "Catalogs" "Product range"
		Когда открылось окно "Product range"
		И В текущем окне я нажимаю кнопку командного интерфейса "Nomenclature types"

	* Удаляем текущий элемент
		И Я в списке "Product range" по полю "Description" ищу элемент '[TheProductKindName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "* (Product range types)" очищая

	* Создаем новый элемент
		Когда открылось окно "Product range"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Product range types (creation)"
		И в поле с именем 'Description' я ввожу текст '[TheProductKindName]'
		И я меняю значение переключателя с именем 'УХ_ТипОбъектаЗакупки' на 'Товар'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Product range types (creation) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Product range"
		И Я закрываю окно "Product range"

Сценарий: Я создаю товарную категорию с именем 'TheProductCategoryName' видом номенклатуры 'TheProductKind'

	* Найдем вид номенклатуры
		Если '$$ЭтоУХ$$' Тогда
			И В командном интерфейсе я выбираю "Corporate purchasing" "Product categories"
			Тогда открылось окно "Product categories"
			И я нажимаю на кнопку с именем 'FormFind'
			Тогда открылась форма с именем 'UniversalListFindExtForm'
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
		Если '$$ЭтоЕРПУХ$$' Тогда
			И В командном интерфейсе я выбираю "CRM и маркетинг" "Настройки и справочники"
			Тогда открылось окно "Settings and directories for CRM and marketing"
			И я нажимаю на кнопку с именем 'OpenProductCategories'
			Когда открылось окно "Product categories"
			И я выбираю пункт контекстного меню с именем 'СписокВидовНоменклатурыКонтекстноеМенюНайти' на элементе формы с именем 'СписокВидовНоменклатуры'
			Тогда открылась форма с именем 'UniversalListFindExtForm'
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Product range type"
			И в поле с именем 'Pattern' я ввожу текст '[TheProductKind]'
			И я меняю значение переключателя с именем 'CompareType' на "Exact match"
			И я нажимаю на кнопку с именем 'Find'
			Тогда открылось окно "Product categories"
			И в таблице 'СписокВидовНоменклатуры' количество строк 'равно' 1
			И в таблице 'List' я нажимаю на кнопку с именем 'ListFind'
			Тогда открылась форма с именем 'UniversalListFindExtForm'
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Product category"		

	* Удаляем текущий элемент 
		И в поле с именем 'Pattern' я ввожу текст '[TheProductCategoryName]'
		И я меняю значение переключателя с именем 'CompareType' на "Exact match"
		И я нажимаю на кнопку с именем 'Find'
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'List'
			* Перименовываем 
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Когда открылось окно "* (Product categories)"
				Тогда в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Product categories) *" в течение 20 секунд

	* Создаем новый элемент
		Если '$$ЭтоУХ$$' Тогда
			И я нажимаю на кнопку с именем 'FormCreate'
			И из выпадающего списка с именем 'ProductKind' я выбираю по строке '[TheProductKind]'		
		Если '$$ЭтоЕРПУХ$$' Тогда
			И в таблице 'Список' я нажимаю на кнопку с именем 'List'				
			И из выпадающего списка с именем 'Owner' я выбираю по строке '[TheProductKind]'
		Тогда открылось окно "Product categories (creation) *"
		И в поле с именем 'Description' я ввожу текст '[TheProductCategoryName]'
		И из выпадающего списка с именем 'VATRate' я выбираю точное значение "20%"
		И из выпадающего списка с именем 'UnitOfMeasure' я выбираю по строке "PCs"					
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Product categories (creation) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Product categories"
		И Я закрываю окно "Product categories"

Сценарий: Я создаю номенклатурную группу с именем 'TheName'

	* Открываем список
		И я открываю основную форму списка справочника 'ProductRangeGroups'
		Тогда открылось окно "Product range groups"

	* Удаляем элемент
		И Я в списке "Product range groups" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheName] (Product range group)" очищая

	* Создаем элементм
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Product range group (create)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Product range group (create) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Product range groups"
		И Я закрываю окно "Product range groups"

Сценарий: Я для номенклатуры с именем 'TheProductName' для реквизита 'TheAttributeName' выбираю значение 'TheValuesName' в группе 'TheGroupName' 

	* Открываем список
		Если '$$ЭтоPerform$$' Тогда
			И В командном интерфейсе я выбираю "Quick menu" "Product range"		
		ИначеЕсли '$$ЭтоУХ$$' Тогда
			И В командном интерфейсе я выбираю "Catalogs" "Product range"
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И В командном интерфейсе я выбираю "Quick menu" "Product range"
			И я снимаю флаг с именем 'UseFilters'		
		Тогда открылось окно "Product range"

	* Ищем текущий элемент
		Если '$$ЭтоУХ$$' Тогда
			И Я в списке "Product range" по полю "Description" ищу и выбираю элемент '[TheProductName]' "At the beginning of the line" 
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И пауза 1
			И я нажимаю кнопку очистить у поля с именем 'SearchStringProductRange'					
			И в поле с именем 'SearchStringProductRange' я ввожу текст '[TheProductName]'
			И я нажимаю на кнопку с именем 'Find'				
			Если появилось окно с заголовком 'Search' в течение 1 секунд Тогда
				И я нажимаю на кнопку с именем 'Button0'
			Когда открылось окно "Product range"
			И я устанавливаю флаг с именем 'UseFilters'					
			И в таблице 'ListAdvancedSearchProducts' я выбираю текущую строку
			Тогда открылось окно "* (Product range)"
			И я перехожу к закладке с именем 'PageProductAttributes'
			Если появилось окно с заголовком 'Useful tip' в течение 1 секунд Тогда
				И я нажимаю на кнопку с именем 'Button0'

	* Устанавливаем реквизит		
		Тогда открылось окно "* (Product range)"
		Если 'НЕ ПустаяСтрока(\"[TheGroupName]\")' Тогда
			И я разворачиваю группу с именем '[TheGroupName]'
		Если 'ПустаяСтрока(\"[TheValuesName]\")' Тогда
			И в поле с именем '[TheAttributeName]' я ввожу текст ''
		Иначе						
			И из выпадающего списка с именем '[TheAttributeName]' я выбираю по строке '[TheValuesName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "* (Product range) *" в течение 20 секунд

	* Закрываем формы
		Тогда открылось окно "Product range"
		И Я закрываю окно "Product range"

Сценарий: Я для номенклатуры с именем 'TheProductName' для типа цен с именем 'TheName' устанавливаю значение 'TheValuesName' 

	* Открываем список
		И В командном интерфейсе я выбираю "Catalogs" "Product range"
		Тогда открылось окно "Product range"

	* Ищем текущий элемент
		И Я в списке "Product range" по полю "Description" ищу и выбираю элемент '[TheProductName]' "At the beginning of the line" 
	
		* Устанавливаем реквизит		
		Тогда открылось окно "* (Product range)"
		И В текущем окне я нажимаю кнопку командного интерфейса 'Prices'
		И в поле с именем 'ДатаЦен' я ввожу значение выражения "Строка(НачалоГода(ТекущаяДата()))" 
		И я перехожу к следующему реквизиту
		И Я в таблице 'ItemsPricesPrice' по полю 'Price type' ищу значение '[TheName]' 	
		И в таблице "ItemsPrices" я активизирую поле с именем "ItemsPricesPrice"
		И в таблице "ItemsPricesPrice" я выбираю текущую строку
		И в таблице "ItemsPrices" в поле с именем 'ItemsPricesPrice' я ввожу текст '[TheValuesName]'
		И в таблице "ItemsPrices" я завершаю редактирование строки
		И в таблице "ItemsPrices" я нажимаю на кнопку с именем 'WritePrices'

	* Закрываем формы
		И Я закрываю окно '* (Product range)'
		Тогда открылось окно "Product range"
		И Я закрываю окно "Product range"

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

Сценарий: Я включаю производительный режим работы ограничений на уровне записей

	И В командном интерфейсе я выбираю "Administration" "Users and rights settings"
	Тогда открылось окно "Users and rights settings"
	И я разворачиваю группу с именем 'AccessGroupsGroup'
	Если элемент формы с именем 'LimitAccessAtRecordLevelUniversally' присутствует на форме Тогда
		И из выпадающего списка с именем 'LimitAccessAtRecordLevelUniversally' я выбираю точное значение "High performance"
		Тогда открылось окно "1C:Enterprise"
		И я нажимаю на кнопку с именем 'Button0'
		
	Тогда открылось окно "Users and rights settings"
	И я нажимаю на кнопку с именем 'AccessUpdateOnRecordsLevel'
	Тогда открылось окно "Update record-level access"
	И Пауза 1

	И я разворачиваю группу с именем 'BriefDetailed'
	Если элемент формы с именем 'StartAccessUpdateImmediately' доступен Тогда
		И я нажимаю на кнопку с именем 'StartAccessUpdateImmediately'
		Если открылось окно "1C:Enterprise" Тогда
			И я нажимаю на кнопку с именем 'Button0'
	И у элемента с именем 'LastAccessUpdateCompletion' я жду значения "(completed *)" в течение 600 секунд по шаблону
	И я жду, что в таблице 'Lists' количество строк будет "равно" 0 в течение 60 секунд
	Когда в таблице 'Lists' количество строк "равно" 0

	Когда открылось окно "Update record-level access"
	И Я закрываю окно "Update record-level access"

Сценарий: Я для статьи бюджета с именем 'TheName' устанавливаю контрольные аналитики по виду аналитики 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'
	* в АРМ Управление лимитами открыть настройки статей
		И я перехожу к закладке с именем "SettingsLimitingBudgetItems"			

	* Найти статью АРМ Управление лимитами
		И Я в таблице статей "ListItems" по полю "Budget item" ищу и выбираю элемент '[TheName]' "Exact match"

		Если 'НЕ ПустаяСтрока("[TheAnalytics1]")' Тогда
			Если таблица "ItemsList" равна переданной тогда
				| 'Budget item' | '1'   |
				| '[TheName]'      | 'Нет' |
				И в таблице "СписокСтатей" я активизирую поле с именем "СписокСтатейКонтролироватьАналитику1"
				И в таблице "ListItems" я выбираю текущую строку
		Если 'НЕ ПустаяСтрока("[TheAnalytics2]")' Тогда
			Если таблица "ItemsList" равна переданной тогда
				| 'Budget item' | '2'   |
				| '[TheName]'      | 'Нет' |
				И в таблице "СписокСтатей" я активизирую поле с именем "СписокСтатейКонтролироватьАналитику2"
				И в таблице "ListItems" я выбираю текущую строку
		Если 'НЕ ПустаяСтрока("[TheAnalytics3]")' Тогда
			Если таблица "ItemsList" равна переданной тогда
				| 'Budget item' | '3'   |
				| '[TheName]'      | 'Нет' |
				И в таблице "СписокСтатей" я активизирую поле с именем "СписокСтатейКонтролироватьАналитику3"
				И в таблице "ListItems" я выбираю текущую строку
		Если 'НЕ ПустаяСтрока("[TheAnalytics4]")' Тогда
			Если таблица "ItemsList" равна переданной тогда
				| 'Budget item' | '4'   |
				| '[TheName]'      | 'Нет' |
				И в таблице "СписокСтатей" я активизирую поле с именем "СписокСтатейКонтролироватьАналитику4"
				И в таблице "ListItems" я выбираю текущую строку
		Если 'НЕ ПустаяСтрока("[TheAnalytics5]")' Тогда
			Если таблица "ItemsList" равна переданной тогда
				| 'Budget item' | '5'   |
				| '[TheName]'      | 'Нет' |
				И в таблице "СписокСтатей" я активизирую поле с именем "СписокСтатейКонтролироватьАналитику5"
				И в таблице "ListItems" я выбираю текущую строку
		Если 'НЕ ПустаяСтрока("[TheAnalytics6]")' Тогда
			Если таблица "ItemsList" равна переданной тогда
				| 'Budget item' | '6'   |
				| '[TheName]'      | 'Нет' |
				И в таблице "СписокСтатей" я активизирую поле с именем "СписокСтатейКонтролироватьАналитику6"
				И в таблице "ListItems" я выбираю текущую строку

Сценарий: Я создаю места поставки с именем 'TheName' с видом 'TheField' на складе 'TheStorage'
	* Открываем список
		И я открываю основную форму списка справочника 'DeliveryPlaces'
		Тогда открылось окно 'Places of delivery of goods (rendering of services)'		

	* Удаляем элемент
		И Я в списке "Places of goods delivery (service provision)" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheName] (Place of goods delivery (services rendering))" очищая

	* Создаем элементм
		И я нажимаю на кнопку с именем 'FormCreate'
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И из выпадающего списка с именем "Kind" я выбираю точное значение '[TheField]'	
		Если '$$ЭтоУХ$$' Тогда
			И я нажимаю кнопку выбора у поля с именем "Warehouse"
			И Я в списке "List" по полю "Description" ищу и выбираю элемент "[TheStorage]" "Exact match" 					
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			Если элемент формы 'Type' стал равен 'Warehouse'
				И я нажимаю кнопку выбора у поля с именем "Warehouse"
				И Я в списке "List" по полю "Description" ищу и выбираю элемент "[TheStorage]" "Exact match" 								
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Place of delivery of goods (rendering of services) (creation) *" в течение 20 секунд

	* Закрываем список
			И Я закрываю окно 'Delivery locations for goods (services)'

Сценарий: Я создаю склад с именем 'TheName' с видом 'TheField' с типом цен 'ThePrice'
	* Открываем список
		И я открываю основную форму списка справочника 'Warehouses'		

	* Удаляем элемент
		Если '$$ЭтоУХ$$' Тогда
			И Я в списке "Warehouses" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"	
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И Я в списке "Warehouses and stores" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"			
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "[TheName] (Warehouse)" очищая

	* Создаем элементм
		Если '$$ЭтоУХ$$' Тогда
			И я нажимаю на кнопку с именем 'FormCreate'
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И я нажимаю на кнопку с именем 'ListCreateWholesaleWarehouse'			
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		Если '$$ЭтоУХ$$' Тогда
			И из выпадающего списка с именем "WarehouseType" я выбираю точное значение '[TheField]'	
			И я нажимаю кнопку выбора у поля "Price type"
			И Я в списке "List" по полю "Description" ищу и выбираю элемент "[ThePrice]" "Exact match" 					
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Warehouse (create) *" в течение 20 секунд	

	* Закрываем список
		Если '$$ЭтоУХ$$' Тогда	
			И Я закрываю окно 'Warehouses'
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И Я закрываю окно'Warehouses and stores'			

Сценарий: Я для организации 'TheBusinessUnitName' создаю банковский счет 'TheBank' 'TheBankAccount' 
	* Создание элемента
		Если '$$ЭтоУХ$$' Тогда
			И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Business units"
			И я нажимаю на кнопку с именем 'FormFind'
			Тогда открылось окно 'Find'
			И в поле с именем 'Pattern' я ввожу текст '[TheBusinessUnitName]'
			И я нажимаю на кнопку с именем 'Find'
			И в таблице "List" я выбираю текущую строку
			И В текущем окне я нажимаю кнопку командного интерфейса 'Bank accounts'
			И я нажимаю на кнопку с именем 'CreateBankAccount'
			И из выпадающего списка с именем "Bank" я выбираю по строке '[TheBank]'
			И я перехожу к следующему реквизиту
			И в поле с именем 'AccountNumber' я ввожу текст '[TheBankAccount]'
			И я нажимаю на кнопку с именем 'FormCommandSaveAndClose'
			И я жду закрытия окна 'Bank account (create) *' в течение 20 секунд
		Если '$$ЭтоЕРПУХ$$' Тогда
			И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Companies"
			И я нажимаю на кнопку с именем 'FormFind'
			Тогда открылось окно 'Find'
			И в поле с именем 'Pattern' я ввожу текст '[TheBusinessUnitName]'
			И я нажимаю на кнопку с именем 'Find'
			И в таблице "List" я выбираю текущую строку
			И В текущем окне я нажимаю кнопку командного интерфейса 'Bank accounts'	
			И в таблице "List" я нажимаю на кнопку с именем 'ListCreate'
			Тогда открылось окно 'Company bank account (create)'
			И в поле с именем 'AccountNumber' я ввожу текст '[TheBankAccount]'
			И я нажимаю на кнопку с именем 'FormWriteAndClose'
			И я жду закрытия окна 'Company bank account (create) *' в течение 20 секунд					

Сценарий: Я для контрагента с именем 'TheName' создаю банковский счет 'TheBank' 'TheBankAccount' 
	* Создание элемента
		Если '$$ЭтоУХ$$' Тогда
			И В командном интерфейсе я выбираю 'Catalogs' 'Counterparties'
			И я нажимаю на кнопку с именем 'FormFind'
			Тогда открылось окно 'Find'
			И в поле с именем 'Pattern' я ввожу текст '[TheName]'
			И я нажимаю на кнопку с именем 'Find'
			Тогда открылось окно 'Counterparties'
			И в таблице "List" я выбираю текущую строку
			И В текущем окне я нажимаю кнопку командного интерфейса 'Bank accounts'
			И я нажимаю на кнопку с именем 'Create'
			Тогда открылось окно 'Bank account (create)'
			И из выпадающего списка с именем "Bank" я выбираю по строке '[TheBank]'
			И в поле с именем 'AccountNumber' я ввожу текст '[TheBankAccount]'
			И я нажимаю на кнопку с именем 'FormCommandSaveAndClose'
			И я жду закрытия окна 'Bank account (create) *' в течение 20 секунд
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И В командном интерфейсе я выбираю 'General catalogs and settings' 'Counterparties'	
			Когда открылось окно 'Counterparties (legal or natural persons)'
			И в таблице "List" я нажимаю на кнопку с именем 'ListFind'			
			Тогда открылось окно 'Find'
			И в поле с именем 'Pattern' я ввожу текст '[TheName]'
			И я нажимаю на кнопку с именем 'Find'
			Тогда открылось окно 'Counterparties (legal or natural persons)'
			И в таблице "List" я выбираю текущую строку
			И В текущем окне я нажимаю кнопку командного интерфейса 'Bank accounts'
			И я нажимаю на кнопку с именем 'FormCreate'
			Тогда открылось окно 'Bank account (create)'
			И в поле с именем 'AccountNumber' я ввожу текст '[TheBankAccount]'
			И я нажимаю на кнопку с именем 'FormWriteAndClose'
			И я жду закрытия окна 'Bank account (create) *' в течение 20 секунд

Сценарий: Я для контрагента с именем 'TheName' указываю ИНН 'TheTIN' и КПП 'TheRRC' 
		Если '$$ЭтоУХ$$' Тогда
			И В командном интерфейсе я выбираю 'Catalogs' 'Counterparties'
			И я нажимаю на кнопку с именем 'FormFind'
			Тогда открылось окно 'Find'
			И в поле с именем 'Pattern' я ввожу текст '[TheName]'
			И я нажимаю на кнопку с именем 'Find'
			Тогда открылось окно 'Counterparties'
			И в таблице "List" я выбираю текущую строку
			И в поле с именем 'TIN' я ввожу текст '[TheTIN]'
			И я перехожу к следующему реквизиту
			И в поле с именем 'KPP' я ввожу текст '[TheRRC]'
			И я перехожу к следующему реквизиту
			И я нажимаю на кнопку с именем 'FormWrite'
			Если открылось окно '1C:Enterprise' тогда
				И я нажимаю на кнопку 'Save'	
			Тогда элемент формы с именем "TIN" стал равен '[TheTIN]'
			Тогда элемент формы с именем "RRC" стал равен '[TheRRC]'

		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И В командном интерфейсе я выбираю 'General catalogs and settings' 'Counterparties'	
			Когда открылось окно 'Counterparties (legal or natural persons)'
			И в таблице "List" я нажимаю на кнопку с именем 'ListFind'			
			Тогда открылось окно 'Find'
			И в поле с именем 'Pattern' я ввожу текст '[TheName]'
			И я нажимаю на кнопку с именем 'Find'
			Тогда открылось окно 'Counterparties (legal or natural persons)'
			И в таблице "List" я выбираю текущую строку
			И в поле с именем 'TIN' я ввожу текст '[TheTIN]'
			И я перехожу к следующему реквизиту
			Если открылось окно '1C:Enterprise' тогда
				И я нажимаю на кнопку с именем 'Button0'
			И в поле с именем 'KPP' я ввожу текст '[TheRRC]'
			И я перехожу к следующему реквизиту
			Если открылось окно '1C:Enterprise' Тогда
				И я нажимаю на кнопку с именем 'Button0'
			И я нажимаю на кнопку с именем 'FormWrite'
			Тогда элемент формы с именем "TIN" стал равен '[TheTIN]'
			Тогда элемент формы с именем "RRC" стал равен '[TheRRC]'

Сценарий: Я создаю Приказ о назначении закупочной комиссии для организации 'TheBusinessUnitName' 

		И В командном интерфейсе я выбираю 'Корпоративные закупки' 'Приказы закупочной комиссии'
		Тогда открылось окно 'Procurement commission orders'
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно 'Procurement commission orders (creating)'	
		И в таблице "ЗакупочнаяКомиссия" я нажимаю на кнопку с именем 'ЗакупочнаяКомиссияДобавить'
		И в таблице "ЗакупочнаяКомиссия" я нажимаю кнопку выбора у реквизита с именем "ЗакупочнаяКомиссияОрганизация"		
		Если '$$ЭтоУХ$$' Тогда	
			И Я в списке "List" по полю "Name in the application" ищу и выбираю элемент "[TheBusinessUnitName]" "Exact match" 	
		Если '$$ЭтоЕРПУХ$$' Тогда
			И Я в списке "List" по полю "Working name" ищу и выбираю элемент "[TheBusinessUnitName]" "Exact match" 	

		И в таблице "PurchaseCommission" я завершаю редактирование строки
		И я нажимаю на кнопку с именем 'FormPostAndClose'
		И я жду закрытия окна 'Purchasing committee orders (Creating) *' в течение 20 секунд
		Тогда открылось окно 'Procurement commission orders'
		И Я закрываю окно 'Purchasing committee orders'