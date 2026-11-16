#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии общие

Сценарий: Я устанавливаю отбор в форме списка 'TheField' 'TheComparisonType' 'TheValue' 

	Тогда открылось окно "List settings"
	И я удаляю все строки таблицы 'SettingsComposerUserSettingsItem0Filter'		
	И в таблице 'SettingsComposerUserSettingsItem0Filter' я нажимаю на кнопку с именем 'SettingsComposerUserSettingsItem0FilterAddFilterItem'
	И в таблице 'SettingsComposerUserSettingsItem0Filter' я перехожу к последней строке
	Если 'StrFind("[TheField]", ".") > 0' Тогда
		И в таблице 'SettingsComposerUserSettingsItem0Filter' в поле с именем 'SettingsComposerUserSettingsItem0FilterLeftValue' я ввожу текст '[TheField]'
	И в таблице 'SettingsComposerUserSettingsItem0Filter' из выпадающего списка с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборЛевоеЗначение' я выбираю точное значение '[TheField]'
	И в таблице 'SettingsComposerUserSettingsItem0Filter' я активизирую поле с именем 'SettingsComposerUserSettingsItem0FilterComparisonType'
	И в таблице 'SettingsComposerUserSettingsItem0Filter' из выпадающего списка с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборВидСравнения' я выбираю точное значение '[TheComparisonType]'
	И в таблице 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0Отбор' я активизирую поле с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборПравоеЗначение'
	Если 'StrFind(Lower("[TheComparisonType]"),"содержит")>0 ИЛИ StrFind(Lower("[TheComparisonType]"),"начинается с")>0 ИЛИ StrFind(Lower("[TheComparisonType]"),"contain")>0 ИЛИ StrFind(Lower("[TheComparisonType]"),"begin with")>0' Тогда 
		И в таблице 'SettingsComposerUserSettingsItem0Filter' в поле с именем 'SettingsComposerUserSettingsItem0FilterRightValue' я ввожу текст '[TheValue]'
	Иначе
		И в таблице 'SettingsComposerUserSettingsItem0Filter' из выпадающего списка с именем 'SettingsComposerUserSettingsItem0FilterRightValue' я выбираю точное значение '[TheValue]'
	И в таблице 'SettingsComposerUserSettingsItem0Filter' я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'FormEndEdit'

Сценарий: Я добавляю отбор в форме списка 'TheField' 'TheComparisonType' 'TheValue' 

	Тогда открылось окно "List settings"
	И в таблице 'SettingsComposerUserSettingsItem0Filter' я нажимаю на кнопку с именем 'SettingsComposerUserSettingsItem0FilterAddFilterItem'
	Если 'StrFind("[TheField]", ".") > 0' Тогда
		И в таблице 'SettingsComposerUserSettingsItem0Filter' в поле с именем 'SettingsComposerUserSettingsItem0FilterLeftValue' я ввожу текст '[TheField]'
	И в таблице 'SettingsComposerUserSettingsItem0Filter' из выпадающего списка с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборЛевоеЗначение' я выбираю точное значение '[TheField]'
	И в таблице 'SettingsComposerUserSettingsItem0Filter' я активизирую поле с именем 'SettingsComposerUserSettingsItem0FilterComparisonType'
	И в таблице 'SettingsComposerUserSettingsItem0Filter' из выпадающего списка с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборВидСравнения' я выбираю точное значение '[TheComparisonType]'
	И в таблице 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0Отбор' я активизирую поле с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборПравоеЗначение'
	Если 'StrFind(Lower("[TheComparisonType]"),"содержит")>0 ИЛИ StrFind(Lower("[TheComparisonType]"),"начинается с")>0 ИЛИ StrFind(Lower("[TheComparisonType]"),"contain")>0 ИЛИ StrFind(Lower("[TheComparisonType]"),"begin with")>0' Тогда 
		И в таблице 'SettingsComposerUserSettingsItem0Filter' в поле с именем 'SettingsComposerUserSettingsItem0FilterRightValue' я ввожу текст '[TheValue]'
	Иначе
		И в таблице 'SettingsComposerUserSettingsItem0Filter' из выпадающего списка с именем 'SettingsComposerUserSettingsItem0FilterRightValue' я выбираю точное значение '[TheValue]'
	И в таблице 'SettingsComposerUserSettingsItem0Filter' я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'FormEndEdit'	

Сценарий: Я снимаю все отборы в форме списка

	Тогда открылось окно "List settings"
	И я перехожу к закладке с именем 'SettingsComposerUserSettingsItem0'
	И я удаляю все строки таблицы 'SettingsComposerUserSettingsItem0Filter'
	И я нажимаю на кнопку с именем 'FormEndEdit'

Сценарий: Я в списке "TheListName" по полю "TheField" ищу элемент "ThePattern" "TheCompareType" 

//	Тогда открылось окно '[TheListName]'
	Если кнопка с именем 'FormFind' существует Тогда
		И я нажимаю на кнопку с именем 'FormFind'
	Иначе
		И я выбираю пункт контекстного меню с именем 'ListContextMenuFind' на элементе формы с именем 'List'
	Тогда открылось окно "Find"
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение '[TheField]'
	И я меняю значение переключателя с именем 'CompareType' на '[TheCompareType]'	
	И я жду открытия окна "Find" в течение 10 секунд				
	И в поле с именем 'Pattern' я ввожу текст '[ThePattern]'
	И я нажимаю на кнопку с именем 'Find'
	И я жду открытия окна '[TheListName]' в течение 10 секунд

Сценарий: Я в списке "TheListName" по полю "TheField" ищу и выбираю элемент "ThePattern" "TheCompareType" 

//	Тогда открылось окно '[TheListName]'
	Если кнопка с именем 'FormFind' существует Тогда
		И я нажимаю на кнопку с именем 'FormFind'
	Иначе
		И я выбираю пункт контекстного меню с именем 'ListContextMenuFind' на элементе формы с именем 'List'
	Тогда открылось окно "Find"
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение '[TheField]'
	И я меняю значение переключателя с именем 'CompareType' на '[TheCompareType]'
	И я жду открытия окна "Find" в течение 10 секунд				
	И в поле с именем 'Pattern' я ввожу текст '[ThePattern]'
	И я нажимаю на кнопку с именем 'Find'
//	И я жду открытия окна '[TheListName]' в течение 10 секунд
	И Я запоминаю в переменную 'VarField' значение '[TheField]'
	И Я запоминаю в переменную 'VarPattern' значение '[ThePattern]'	
	И в таблице 'List' я перехожу к строке:
		| '$VarField$'   |
		| '$VarPattern$' |
	И в таблице 'List' я выбираю текущую строку	

Сценарий: Я удаляю текущую строку в списке 'TheList'

	И я выбираю пункт контекстного меню с именем '[TheList]ContextMenuMarkForDeletion' на элементе формы с именем '[TheList]'
	Тогда открылось окно "1C:Enterprise"
	Если элемент формы с именем 'Message' стал равен "Mark * for deletion?" по шаблону Тогда
		И я нажимаю на кнопку с именем 'Button0'
	Иначе
		И я нажимаю на кнопку с именем 'Button1'
	И я жду доступности элемента с именем '[TheList]' в течение 20 секунд
			