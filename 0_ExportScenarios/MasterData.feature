#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для создания НСИ

Сценарий: Я создаю единицу измерения с кодом 'TheCode' если ее нет, наименование 'TheName', наименование полное 'TheNameFull'

	* Открываем форму списка
		И я открываю основную форму списка справочника 'UnitOfMeasureClassifier'
		Тогда открылось окно "Classifier of Measurement Units"

	* Создадим элемент, если его нет
		И я нажимаю на кнопку с именем 'FormFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Code"
		И в поле с именем 'Pattern' я ввожу текст '[TheCode]'
		И я меняю значение переключателя с именем 'CompareType' на "Exact match"
		И я нажимаю на кнопку с именем 'Find'
		Если в таблице 'List' количество строк 'равно' 0 Тогда
			Если '$$ЭтоPerform$$' Тогда
				И я нажимаю на кнопку с именем 'FormCreate'
				Тогда открылось окно "Classifier of Measurement Units (create)"
				И в поле с именем 'Code' я ввожу текст '[TheCode]'
				И в поле с именем 'Наименование' я ввожу текст '[TheName]'				
				И в поле с именем 'DescriptionFull' я ввожу текст '[TheNameFull]'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "Classifier of Measurement Units (create) *" в течение 20 секунд							
			Иначе
				И я нажимаю на кнопку с именем 'FormPickFromTemplate'
				Тогда открылось окно "All-Russian Classifier of Measurement Units"
				И в поле с именем 'SearchString' я ввожу текст '[TheCode]'
				И я нажимаю на кнопку с именем 'SearchForward'
				И Пауза 1
				И я нажимаю на кнопку с именем 'FormSelect'						
				Тогда открылось окно "Classifier of Measurement Units (create)"
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "Classifier of Measurement Units (create)" в течение 20 секунд
				Тогда открылось окно "All-Russian Classifier of Measurement Units"
				И я нажимаю на кнопку с именем 'Close'

	* Закрываем список
		Когда открылось окно "Classifier of Measurement Units"
		И Я закрываю окно "Classifier of Measurement Units"

Сценарий: Я создаю валюту с цифровым кодом 'TheCodeDigital' символьным кодом 'TheCodeSymbol' и наименованием 'TheCurrencyName' если ее нет

	* Открываем форму списка
		И В командном интерфейсе я выбираю "General catalogs and settings" "Currencies"
		Тогда открылось окно "Currencies"

	* Создадим валюту, если ее нет		
		И я нажимаю на кнопку с именем 'FormFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Numeric code"
		И в поле с именем 'Pattern' я ввожу текст '[TheCodeDigital]'
		И я нажимаю на кнопку с именем 'Find'
		Если в таблице 'Currencies' количество строк 'равно' 0 Тогда
			И я нажимаю на кнопку с именем 'CreateCurrency'
			Тогда открылось окно "Currency (create)"
			И я запоминаю заголовок текущего окна как 'WindowTitle'			
		Иначе
			И в таблице 'Currencies' я выбираю текущую строку
			И я запоминаю заголовок текущего окна как 'WindowTitle'
		И в поле с именем 'DescriptionFull' я ввожу текст '[TheCurrencyName]'
		И в поле с именем 'Code' я ввожу текст '[TheCodeDigital]'
		И в поле с именем 'Description' я ввожу текст '[TheCodeSymbol]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "$ЗаголовокОкна$ *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Currencies"
		И Я закрываю окно "Currencies"

Сценарий: Я устанавливаю курс валюты 'TheCodeSymbol' на дату 'TheCourseDate' в значение 'TheCourseValue' кратность 'TheCourseRepetition' базовая валюта 'TheBaseCurrencyCodeSymbol'

	* Откроем валюту
		И В командном интерфейсе я выбираю "General catalogs and settings" "Currencies"
		Тогда открылось окно "Currencies"
		И я нажимаю на кнопку с именем 'FormFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Alphabetic code"
		И в поле с именем 'Pattern' я ввожу текст '[TheCodeSymbol]'
		И я нажимаю на кнопку с именем 'Find'
		Тогда в таблице 'Currencies' количество строк 'равно' 1
		И в таблице 'Currencies' я выбираю текущую строку		
		Тогда открылось окно "* (Currency)"

	* Установим курс
		И В текущем окне я нажимаю кнопку командного интерфейса "Exchange rates"
		И я нажимаю на кнопку с именем 'FormFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Effective on"
		И в поле с именем 'Pattern' я ввожу текст '[TheCourseDate]'
		И я нажимаю на кнопку с именем 'Find'
		Если в таблице 'List' количество строк 'равно' 0 Тогда
			И я нажимаю на кнопку с именем 'FormCreate'
		Иначе
			И в таблице 'List' я выбираю текущую строку
		Тогда открылось окно "Exchange rate*"
		И в поле с именем 'Period' я ввожу текст '[TheCourseDate]'
		Если '$$ЭтоУХ$$' Тогда
			И в поле с именем 'Rate' я ввожу текст '[TheCourseValue]'
			И в поле с именем 'Кратность' я ввожу текст '[TheCourseRepetition]'
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда
			И в поле с именем 'КурсЗнаменатель' я ввожу текст '[TheCourseRepetition]'
			И из выпадающего списка с именем 'Currency' я выбираю точное значение '[TheCodeSymbol]'
			И в поле с именем 'КурсЧислитель' я ввожу текст '[TheCourseValue]'
			И из выпадающего списка с именем 'BasicCurrency' я выбираю точное значение '[TheBaseCurrencyCodeSymbol]'						
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Exchange rate*" в течение 20 секунд		

	* Закрываем окна
		Тогда открылось окно "* (Currency)"
		И Я закрываю окно "* (Currency)"
		Тогда открылось окно "Currencies"
		И Я закрываю окно "Currencies"

Сценарий: Я создаю вид организационной единицы с именем 'TheBusinessUnitName'

	* Открываем форму справочника
		И я открываю основную форму списка справочника 'BusinessUnitKinds'

	* Удаляем элемент
		Тогда открылось окно "Business unit kinds"
		И я нажимаю на кнопку с именем 'FormFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
		И в поле с именем 'Pattern' я ввожу текст '[TheBusinessUnitName]'
		И я меняю значение переключателя с именем 'CompareType' на "Exact match"
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно "Business unit kinds"
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление	
				И Я удаляю текущую строку в списке 'List'
			* Переименовываем
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "* (Business unit kind)"
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Business unit kind) *" в течение 20 секунд
	
	* Создаем элементм
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Business unit kind (create)"
		И в поле с именем 'Description' я ввожу текст '[TheBusinessUnitName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Business unit kind (create) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Business unit kinds"
		И Я закрываю окно "Business unit kinds"

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

Сценарий: Я создаю организацию с именем 'TheBusinessUnitName' типом 'TheBusinessUnitType' видом 'TheBusinessUnitKind' налогооблажением 'TheTaxation'

	Если '$$ЭтоУХ$$' Тогда
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Business units"
	Если '$$ЭтоЕРПУХ$$' Тогда
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Companies"

	* Удаляем текущий элемент		
		И я нажимаю на кнопку с именем 'FormFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		Если '$$ЭтоЕРПУХ$$' Тогда
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
		ИначеЕсли '$$ЭтоPerform$$' Тогда
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
		ИначеЕсли '$$ЭтоУХ$$' Тогда
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Name in the application"
		И я меняю значение переключателя с именем 'CompareType' на "At the beginning of the line"
		И в поле с именем 'Pattern' я ввожу текст '[TheBusinessUnitName]'
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно "Business units"
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'List'
			И в таблице 'List' я выбираю текущую строку
			Когда открылось окно "* (Business unit)"
			Если '$$ЭтоУХ$$' Тогда
				* Удаляем все подразделения
					И В текущем окне я нажимаю кнопку командного интерфейса "Departments"
					И я нажимаю на кнопку с именем 'FormListSettings'
					И Я устанавливаю отбор в форме списка "Description" "Does not begin with" 'Delete_'
					И Пока в таблице 'List' количество строк 'больше' 0 Тогда
						И Я запоминаю значение выражения '"Удалить_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
						И в таблице 'List' я выбираю текущую строку
						Тогда открылось окно "* (Department)"
						И в поле с именем 'Description' я ввожу значение переменной 'UID'
						И я нажимаю на кнопку с именем 'FormWriteAndClose'
					Когда открылось окно "* (Business unit)"						
					И я нажимаю на кнопку с именем 'FormListSettings'
					И Я снимаю все отборы в форме списка
					И В текущем окне я нажимаю кнопку командного интерфейса "IsMain"				
			* Переименовываем организацию
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И в поле с именем 'DescriptionFull' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Business unit) *" в течение 20 секунд

	* Создаем новую организацию
		Если '$$ЭтоPerform$$' Тогда
			И я нажимаю на кнопку с именем 'FormCreate'
			Тогда открылось окно "Business unit (create)"
			Если '"[TheBusinessUnitType]"="ВыбратьРФ"' Тогда
				И из выпадающего списка с именем 'CompanyTypeCPM' я выбираю точное значение "Company"
			ИначеЕсли '"[TheBusinessUnitKind]"="ВыбратьЭл"' Тогда
				И из выпадающего списка с именем 'CompanyTypeCPM' я выбираю точное значение "Eliminating business unit"
			ИначеЕсли '"[TheBusinessUnitType]"="ВыбратьЦФО"' Тогда
				И из выпадающего списка с именем 'CompanyTypeCPM' я выбираю точное значение "Financial responsibility center or consolidating business unit"	
		ИначеЕсли '$$ЭтоЕРПУХ$$' Тогда			
			Если '"[TheBusinessUnitType]"="ВыбратьРФ"' Тогда
				Если '"[TheBusinessUnitKind]"="ВыбратьЮЛ"' Тогда
					И я нажимаю на кнопку с именем 'LegalEntity'
				Иначе
					И я нажимаю на кнопку с именем 'IndividualEntrepreneur'
				Если элемент формы с именем 'RegistrationCountry' присутствует на форме Тогда
					И из выпадающего списка с именем 'RegistrationCountry' я выбираю по строке "643"										
			ИначеЕсли '"[TheBusinessUnitType]"="ВыбратьЦФО"' Тогда
				Если '"[TheBusinessUnitKind]"="ВыбратьЭл"' Тогда
					И я нажимаю на кнопку с именем 'FormCreateEliminating'
				Иначе
					И я нажимаю на кнопку с именем 'FormCreateConsolidating'
				Если элемент формы с именем 'RegistrationCountry' присутствует на форме Тогда
					И из выпадающего списка с именем 'RegistrationCountry' я выбираю по строке "643"	
			ИначеЕсли '"[TheBusinessUnitType]"="ВыбратьИн"' Тогда
				// Нет примеров											
		ИначеЕсли '$$ЭтоУХ$$' Тогда
			И я нажимаю на кнопку с именем 'CreateNewCompany'
			Тогда открылось окно "Company type"
			И я нажимаю на кнопку с именем '[TheBusinessUnitType]'
			Если '"[TheBusinessUnitType]"="ВыбратьРФ"' Тогда
				Когда открылось окно "Company kind"
				И я нажимаю на кнопку с именем '[TheBusinessUnitKind]'
				Если '"[TheBusinessUnitKind]"="ВыбратьЮЛ"' Тогда
					Когда открылось окно "Legal entity"
					И я нажимаю на кнопку с именем '[TheTaxation]'	
			ИначеЕсли '"[TheBusinessUnitType]"="ВыбратьИн"' Тогда
				// Нет примеров
			ИначеЕсли '"[TheBusinessUnitType]"="ВыбратьЦФО"' Тогда
				Если '"[TheBusinessUnitKind]"="ВыбратьЭл"' Тогда
					И из выпадающего списка с именем 'CompanyTypeCPM' я выбираю точное значение "Eliminating business unit"
			И в поле с именем 'НаименованиеСокращенное' я ввожу текст '[TheBusinessUnitName]'
		И в поле с именем 'Наименование' я ввожу текст '[TheBusinessUnitName]'
		И в поле с именем 'DescriptionFull' я ввожу текст '[TheBusinessUnitName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Compan *" в течение 20 секунд

	* Закрываем форму списка
		Когда открылось окно "Business units"
		И Я закрываю окно "Business units"	

Сценарий: Я для организации 'TheBusinessUnitName' создаю подразделение с именем 'TheSubdivisionName' 

	* Открываем список организаций
		И В командном интерфейсе я выбираю "Budgeting, reporting, and analysis" "Business units"

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
			И В текущем окне я нажимаю кнопку командного интерфейса "Departments"
			Когда открылось окно "* (Business unit)"
			И я нажимаю на кнопку с именем 'FormFind'
			Тогда открылась форма с именем 'UniversalListFindExtForm'
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
			И в поле с именем 'Pattern' я ввожу текст '[TheSubdivisionName]'
			И я нажимаю на кнопку с именем 'Find'
			И Пока в таблице 'List' количество строк 'больше' 0 Тогда
				* Ставим пометку на удаление
					И Я удаляю текущую строку в списке 'List'
				* Переименовываем подразделение
					И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
					И в таблице 'List' я выбираю текущую строку					
					Тогда открылось окно "* (Department)"
					И в поле с именем 'Description' я ввожу значение переменной 'UID'
					И я нажимаю на кнопку с именем 'FormWriteAndClose'
					И я жду закрытия окна "* (Department) *" в течение 20 секунд
	
	* Создаем элемент
		Когда открылось окно "* (Business unit)"
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Department (create)"
		И в поле с именем 'Description' я ввожу текст '[TheSubdivisionName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Department (create) *" в течение 20 секунд

	* Закрываем организацию
		Когда открылось окно "* (Business unit)"
		И Я закрываю окно "* (Business unit)"

	* Закрываем список организаций
		Когда открылось окно "Business units"
		И Я закрываю окно "Business units"

Сценарий: Я для организации 'TheBusinessUnitName' для реквизита 'TheAttributeName' выбираю значение 'TheValuesName' 

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
			И я разворачиваю группу с именем 'GroupConsolidationParametersCPM'
			И из выпадающего списка с именем '[TheAttributeName]' я выбираю по строке '[TheValuesName]'						
			И я нажимаю на кнопку с именем 'FormWriteAndClose'
			И я жду закрытия окна "* (Business unit) *" в течение 20 секунд							

	* Закрываем список организаций
		Когда открылось окно "Business units"
		И Я закрываю окно "Business units"

Сценарий: Я для организации 'TheBusinessUnitName' для реквизита 'TheAttributeName' ввожу значение 'TheValuesName'
	* Находим организацию
		И я нахожу организацию с именем '[TheBusinessUnitName]'
	
	* Вводим значение для реквизита
		И в поле с именем '[TheAttributeName]' я ввожу текст '[TheValuesName]'	
		И я перехожу к следующему реквизиту
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "* (Business unit) *" в течение 20 секунд		

Сценарий: Я для организации с именем 'TheBusinessUnitName' указываю ИНН 'TheTIN', КПП 'TheRRC', ОГРН 'TheOGRN', дата регистрации 'TheRegistrationDate'
	* Находим организацию
		И я нахожу организацию с именем '[TheBusinessUnitName]'
	
	* Вводим значения
		И в таблице "List" я выбираю текущую строку
		И в поле с именем 'TIN' я ввожу текст '[TheTIN]'
		И я перехожу к следующему реквизиту
		И в поле с именем 'КПП' я ввожу текст '[TheRRC]'
		И я перехожу к следующему реквизиту
		И в поле 'ОГРН' я ввожу текст '[TheOGRN]'
		И я перехожу к следующему реквизиту
		И в поле с именем 'ДатаРегистрации' я ввожу текст '[TheRegistrationDate]'
		И я перехожу к следующему реквизиту
		И я нажимаю на кнопку с именем 'FormWrite'	
		Тогда элемент формы с именем "TIN" стал равен '[TheTIN]'
		Тогда элемент формы с именем "КПП" стал равен '[TheRRC]'
		Тогда элемент формы с именем "ОГРН" стал равен '[TheOGRN]'
		Тогда элемент формы с именем "RegistrationDate" стал равен '[TheRegistrationDate]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "* (Business unit) *" в течение 20 секунд

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

Сценарий: Я создаю отношение к группе с именем 'TheRelationsToGroupName' и видом 'TheRelationsToGroupKind'

	* Открываем форму справочника
		И я открываю основную форму списка справочника 'CounterpartiesGroups'

	* Удаляем элемент
		Тогда открылось окно "Company statuses for consolidation"
		И я нажимаю на кнопку с именем 'FormFind'
		Тогда открылась форма с именем 'UniversalListFindExtForm'
		И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
		И в поле с именем 'Pattern' я ввожу текст '[TheRelationsToGroupName]'
		И я меняю значение переключателя с именем 'CompareType' на "Exact match"
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно "Company statuses for consolidation"
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление	
				И Я удаляю текущую строку в списке 'List'
			* Переименовываем
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
				И в таблице 'List' я выбираю текущую строку
				Тогда открылось окно "* (Company statuses for consolidation)"
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Company statuses for consolidation) *" в течение 20 секунд
	
	* Создаем элементм
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Company statuses for consolidation (create)"
		И в поле с именем 'Description' я ввожу текст '[TheRelationsToGroupName]'
		И из выпадающего списка с именем 'GroupRelationType' я выбираю точное значение '[TheRelationsToGroupKind]'				
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Company statuses for consolidation (create) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Company statuses for consolidation"
		И Я закрываю окно "Company statuses for consolidation"

Сценарий: Я создаю группу номенклатуры с именем 'TheProductGroupName'

	* Открываем список
		Если в панели разделов есть команда 'Catalogs' Тогда
			И В командном интерфейсе я выбираю "Catalogs" "Product range"
		Иначе
			И В командном интерфейсе я выбираю "Quick menu" "Product range"

	* Удаляем текущий элемент
		И Я в списке "Product range" по полю "Description" ищу элемент '[TheProductGroupName]' "At the beginning of the line" 
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда	
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'List'
			* Перименовываем
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'	
				И в таблице 'List' я выбираю текущую строку
				Когда открылось окно "* (Product range)"		
				Тогда в поле с именем 'Description' я ввожу значение переменной 'UID'
				Если элемент 'Parent' присутствует на форме Тогда
					И в поле с именем 'Parent' я ввожу текст ''								
				И я нажимаю на кнопку с именем 'FormWriteAndClose'
				И я жду закрытия окна "* (Product range)" в течение 20 секунд 

	* Создаем новый элемент
		Когда открылось окно "Product range"
		И я нажимаю на кнопку с именем 'FormCreateFolder'
		Тогда открылось окно "Product range (create group)"
		И в поле с именем 'Description' я ввожу текст '[TheProductGroupName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Product range (create group) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Product range"
		И Я закрываю окно "Product range"

Сценарий: Я создаю тип цен с именем 'TheName' валютой 'TheCurrency'

	* Открываем форму справочника
		И я открываю основную форму списка справочника 'ProductsPricesTypes'

	* Удаляем элемент
		И Я в списке "Product range price types" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "* (Product range price type)" очищая
	
	* Создаем элементм
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Product range price type (create)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		Если элемент 'CurrencyPrice' присутствует на форме Тогда
			И из выпадающего списка с именем 'CurrencyPrice' я выбираю точное значение '[TheCurrency]'
		Если элемент 'PriceIncludesVAT' присутствует на форме Тогда
			И я изменяю флаг с именем 'PriceIncludesVAT'		
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Product range price type (create) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Product range price types"
		И Я закрываю окно "Product range price types"

Сценарий: Я создаю условие оплаты с именем 'TheName'

	* Открываем форму списка
		И В командном интерфейсе я выбираю "Управление обязательствами" "Условия оплаты"

	* Удаляем текущий элемент
		И Я в списке "Payment terms" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"		
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "* (Payment condition)" очищая

	* Создаем элемент
		Тогда открылось окно "Payment terms"	
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Payment condition (creation)"
		И в таблице 'ЭтапыОплаты' я нажимаю на кнопку с именем 'ЭтапыОплатыДобавить'
		И в таблице 'ЭтапыОплаты' из выпадающего списка с именем 'ЭтапыОплатыВариантОплаты' я выбираю точное значение "Постоплата (после базовой даты)"
		И в таблице 'StepsPayment' из выпадающего списка с именем 'StepsPaymentDueDate' я выбираю точное значение "60"
		И в таблице 'ЭтапыОплаты' в поле с именем 'ЭтапыОплатыПроцентОплаты' я ввожу текст '100'
		И в таблице 'PaymentStages' я завершаю редактирование строки
		И я изменяю флаг с именем 'AutoName'
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Payment condition (creation) *" в течение 20 секунд	

	* Закрываем список	
		Тогда открылось окно "Payment terms"
		И Я закрываю окно "Payment terms"

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

Сценарий: Я создаю группу контрагентов с именем 'TheName'

	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И В командном интерфейсе я выбираю "Quick menu" "Counterparties"
			И Я в списке "Counterparties" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"
		Иначе
			И В командном интерфейсе я выбираю "Catalogs" "Counterparties"
			И Я в списке "Counterparties" по полю "Name in the application" ищу элемент '[TheName]' "At the beginning of the line"
	
	* Удаляем текущий элемент
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			И в таблице 'List' я выбираю текущую строку
			И Я удаляю текущий элемент в окне "* (Counterparties)" очищая

	* Создаем новый элемент
		И я нажимаю на кнопку с именем 'FormCreateFolder'
		Тогда открылось окно "Counterparties (create group)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И я нажимаю на кнопку с именем 'FormWriteAndClose'
		И я жду закрытия окна "Counterparties (create group) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Counterparties"
		И Я закрываю окно "Counterparties"

Сценарий: Я создаю контрагента с именем 'TheName' родителем 'TheParent' страной регистрации 'TheCountry'

	* Открываем форму списка
		Если '$$ЭтоPerform$$' Тогда
			И В командном интерфейсе я выбираю "Quick menu" "Counterparties"
			И Я в списке "Counterparties" по полю "Description" ищу элемент '[TheName]' "At the beginning of the line"
		Иначе
			И В командном интерфейсе я выбираю "Catalogs" "Counterparties"
			И Я в списке "Counterparties" по полю "Name in the application" ищу элемент '[TheName]' "At the beginning of the line"

	* Удаляем текущий элемент
		И Пока в таблице 'List' количество строк 'больше' 0 Тогда
			* Ставим пометку на удаление
				И Я удаляю текущую строку в списке 'List'
			И в таблице 'List' я выбираю текущую строку
			Когда открылось окно "* (Counterparty)"
			* Удаляем все договоры				
				И В текущем окне я нажимаю кнопку командного интерфейса "Contracts"
				И я нажимаю на кнопку с именем 'FormListSettings'
				И Я устанавливаю отбор в форме списка "Description" "Does not begin with" 'Delete_'
				И Пока в таблице 'List' количество строк 'больше' 0 Тогда
					И Я запоминаю значение выражения '"Удалить_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'
					И в таблице 'List' я выбираю текущую строку
					Тогда открылось окно "*"
					И в поле с именем 'Description' я ввожу значение переменной 'UID'
					И я нажимаю на кнопку с именем 'FormWrite'
					Тогда открылось окно "*"
					И Я закрываю окно "*"		
				И я нажимаю на кнопку с именем 'FormListSettings'
				И Я снимаю все отборы в форме списка
				И В текущем окне я нажимаю кнопку командного интерфейса "IsMain"								
			* Удаляем контрагента
				И Я запоминаю значение выражения 'СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID'	
				И в поле с именем 'Description' я ввожу значение переменной 'UID'
				Если '$$ЭтоPerform$$' Тогда
					И я нажимаю на кнопку с именем 'FormWriteAndClose'
				Иначе
					И я нажимаю на кнопку с именем 'FormCommandSaveAndClose'
				И я жду закрытия окна "* (Counterparty)" в течение 20 секунд			

	* Создаем новый элемент
		И я нажимаю на кнопку с именем 'FormCreate'
		Тогда открылось окно "Counterparty (create)"
		И в поле с именем 'Description' я ввожу текст '[TheName]'
		И из выпадающего списка с именем 'Parent' я выбираю по строке '[TheParent]'
		И из выпадающего списка с именем 'RegistrationCountry' я выбираю по строке '[TheCountry]'				
		Если '$$ЭтоPerform$$' Тогда
			И я нажимаю на кнопку с именем 'FormWriteAndClose'
		Иначе
			И я нажимаю на кнопку с именем 'FormCommandSaveAndClose'
		И я жду закрытия окна "Counterparty (create) *" в течение 20 секунд

	* Закрываем список
		Когда открылось окно "Counterparties"
		И Я закрываю окно "Counterparties"

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