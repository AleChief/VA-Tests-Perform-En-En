#language: ru

@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для работы с подсистемой "Budgeting" - "Report wizard"

Сценарий: Я открываю контруктор отчета с именем 'TheReportKindName'

	И Я нахожу в списке вид отчета с именем '[TheReportKindName]'
	И в таблице 'ReportKindList' я нажимаю на кнопку с именем 'DoOpenDesigner'

Сценарий: В конструкторе отчета я нажимаю кнопку контекстного меню с именем 'TheName'

	Если '$$ЭтоPerform$$' Тогда
		И я нажимаю на кнопку с именем '[TheName]'
	Иначе
		И я выбираю пункт контекстного меню с именем '[TheName]' на элементе формы с именем 'SpreadsheetFieldTemlate'
		
Сценарий: Я в конструкторе отчета добавляю строку с именем 'TheLineName' 

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Report structure"
	И я нажимаю на кнопку с именем 'RowsTreeAddRows'
	Тогда открылось окно "Adding new lines"
	И в таблице 'NewLines' я нажимаю на кнопку с именем 'NewLinesAdd'
	И в таблице 'NewLines' в поле с именем 'NewLinesDescription' я ввожу текст '[TheLineName]'
	И в таблице 'NewLines' я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'OK'

Сценарий: Я в конструкторе отчета добавляю строки 

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Report structure"
	И я нажимаю на кнопку с именем 'RowsTreeAddRows'
	Тогда открылось окно "Adding new lines"

	И я заполняю таблицу 'NewLines' данными
		| 'Table' |

	И я нажимаю на кнопку с именем 'OK'

Сценарий: Я в конструкторе отчета добавляю колонку с именем 'TheColumnName' 

	Тогда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Report structure"
	И я нажимаю на кнопку с именем 'RowsTreeAddColumn'
	Тогда открылось окно "Adding new columns"
	И в таблице 'NewLines' я нажимаю на кнопку с именем 'NewLinesAdd'
	И в таблице 'NewLines' в поле с именем 'NewLinesDescription' я ввожу текст '[TheColumnName]'
	И в таблице 'NewLines' я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'OK'

Сценарий: Я в конструкторе отчета добавляю колонки 

	Тогда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Report structure"
	И я нажимаю на кнопку с именем 'RowsTreeAddColumn'
	Тогда открылось окно "Adding new columns"

	И я заполняю таблицу 'NewLines' данными
		| 'Table' |

	И я нажимаю на кнопку с именем 'OK'

Сценарий: Я в конструкторе отчета добавляю аналитику с кодом 'TheDimensionCode' в ячейку 'TheCell' 

	Тогда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Indicator dimensions"
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	Тогда открылось окно "Dimension types (corporate)"
	И я нажимаю на кнопку с именем 'FormFind'
	Тогда открылась форма с именем 'UniversalListFindExtForm'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Code"
	И я меняю значение переключателя с именем 'CompareType' на "Exact match"
	И в поле с именем 'Pattern' я ввожу текст '[TheDimensionCode]'
	И я нажимаю на кнопку с именем 'Find'
	Тогда открылось окно "Dimension types (corporate)"
	И в таблице 'List' я выбираю текущую строку

Сценарий: Я в конструкторе отчета добавляю аналитику с наименованием 'TheDimensionName' в ячейку 'TheCell' 

	Тогда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Indicator dimensions"
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	Тогда открылось окно "Dimension types (corporate)"
	И я нажимаю на кнопку с именем 'FormFind'
	Тогда открылась форма с именем 'UniversalListFindExtForm'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
	И я меняю значение переключателя с именем 'CompareType' на "Exact match"
	И в поле с именем 'Pattern' я ввожу текст '[TheDimensionCode]'
	И я нажимаю на кнопку с именем 'Find'
	Тогда открылось окно "Dimension types (corporate)"
	И в таблице 'List' я выбираю текущую строку	

Сценарий: Я в конструкторе отчета в ячейке 'TheCell' меняю аналитику валюта 

	Тогда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Indicator dimensions"
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	Тогда открылось окно "Report wizard*"

Сценарий: Я в конструкторе отчета в ячейке 'TheCell' меняю родителя у строки на 'TheParentName'

	Тогда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Report structure"
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	Тогда открылось окно "* (Report lines)"
	И из выпадающего списка с именем 'Parent' я выбираю по строке '[TheParentName]'
	И я нажимаю на кнопку с именем 'FormWriteAndClose'
	И я жду закрытия окна "* (Report lines) *" в течение 20 секунд

Сценарий: Я в конструкторе отчета в ячейке 'TheCell' меняю свойство показателя 'TheProperty' на 'TheValue'

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Report structure"
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	Тогда открылось окно "* (Report indicators)"
	И Я для реквизита '[TheProperty]' устанавливаю значение '[TheValue]'										
	И я нажимаю на кнопку с именем 'FormWriteAndClose'
	И я жду закрытия окна "* (Report indicators)" в течение 20 секунд

Сценарий: Я в конструкторе отчета в ячейке 'TheCell' меняю свойства показателей 'TheProperty' на 'TheValue'

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Report structure"
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И я выбираю пункт контекстного меню с именем 'SpreadsheetFieldTemlateContextMenuProperties' на элементе формы с именем 'SpreadsheetFieldTemlate'
	Тогда открылось окно "Bulk edit indicators"
	И я изменяю флаг с именем '[TheProperty]Change'
	И Я для реквизита '[TheProperty]' устанавливаю значение '[TheValue]'
	И я нажимаю на кнопку с именем 'FormWriteAndClose'

Сценарий: Я в конструкторе отчета в ячейке 'TheCell' проверяю свойство показателя 'TheProperty' на 'TheValue'

	Когда открылось окно "Report wizard*"	
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Report structure"		
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	Когда открылось окно "* (Report indicators)"
	И элемент формы с именем '[TheProperty]' стал равен '[TheValue]'	
	И Я закрываю окно "* (Report indicators)"

Сценарий: Я в конструкторе отчета для ячейки 'TheCell' настраиваю связь с показателем с кодом 'TheIndicatorCode' вида отчета 'TheReportKindName'

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Indicators calculation formulas"
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке	
	И я нажимаю на кнопку с именем 'RefToIndicator1'

	Когда открылось окно "Report indicators"
	И я нажимаю кнопку выбора у поля с именем 'ReportKind'
	Тогда открылось окно "Report types"
	И я нажимаю на кнопку с именем 'Find'
	Тогда открылось окно "Find"
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Description"
	И я меняю значение переключателя с именем 'CompareType' на "Exact match"
	И в поле с именем 'Pattern' я ввожу текст '[TheReportKindName]'
	И я нажимаю на кнопку с именем 'Find'
	Тогда открылось окно "Report types"
	И в таблице 'List' я выбираю текущую строку

	И Я выбираю показатель с кодом '[TheIndicatorCode]'
	
	Тогда открылось окно "Report wizard *"
	И я нажимаю на кнопку с именем 'WriteAndCollapse'

Сценарий: Я в конструкторе отчета для ячейки 'TheCell' задаю формулу 'TheFormula'

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Indicators calculation formulas"

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	И в поле с именем 'TextDocumentFieldProcedure' я ввожу текст '[TheFormula]'
	
	И я нажимаю на кнопку с именем 'WriteAndCollapse'	

Сценарий: Я в конструкторе отчета для ячейки 'TheCell' задаю формулу копирования ячейки 'TheCell1'

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Indicators calculation formulas"

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell1]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	
	И я нажимаю на кнопку с именем 'WriteAndCollapse'	

Сценарий: Я в конструкторе отчета для ячейки 'TheCell' задаю формулу суммирования ячейки 'TheCell1'

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Indicators calculation formulas"

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell1]'
	И я нажимаю на кнопку с именем 'ButtonSum'
	
	И я нажимаю на кнопку с именем 'WriteAndCollapse'

Сценарий: Я в конструкторе отчета для ячейки 'TheCell' задаю формулу сумма ячеек 'TheCell1' 'TheCell2' 'TheCell3' 'TheCell4' 'TheCell5'

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Indicators calculation formulas"

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell1]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	И я нажимаю на кнопку с именем 'ButtonPlus'
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell2]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке

	Если 'НЕ СтрНачинаетсяС("[TheCell3]", "[") И НЕ ПустаяСтрока("[TheCell3]")' Тогда
		И я нажимаю на кнопку с именем 'ButtonPlus'
		И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell3]'
		И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке

	Если 'НЕ СтрНачинаетсяС("[TheCell4]", "[") И НЕ ПустаяСтрока("[TheCell3]")' Тогда
		И я нажимаю на кнопку с именем 'ButtonPlus'
		И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell4]'
		И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке	

	Если 'НЕ СтрНачинаетсяС("[TheCell5]", "[") И НЕ ПустаяСтрока("[TheCell3]")' Тогда
		И я нажимаю на кнопку с именем 'ButtonPlus'
		И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell5]'
		И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке	
	
	И я нажимаю на кнопку с именем 'WriteAndCollapse'	

Сценарий: Я в конструкторе отчета для ячейки 'TheCell' задаю формулу произведение ячеек 'TheCell1' 'TheCell2' 'TheCell3' 'TheCell4' 'TheCell5'

	Когда открылось окно "Report wizard*"
	И из выпадающего списка с именем 'WorkMode' я выбираю точное значение "Indicators calculation formulas"
	
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке

	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell1]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке
	И я нажимаю на кнопку с именем 'ButtonMultiply'
	И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell2]'
	И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке

	Если 'НЕ СтрНачинаетсяС("[TheCell3]", "[") И НЕ ПустаяСтрока("[TheCell3]")' Тогда
		И я нажимаю на кнопку с именем 'ButtonMultiply'
		И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell3]'
		И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке

	Если 'НЕ СтрНачинаетсяС("[TheCell4]", "[") И НЕ ПустаяСтрока("[TheCell3]")' Тогда
		И я нажимаю на кнопку с именем 'ButtonMultiply'
		И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell4]'
		И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке	

	Если 'НЕ СтрНачинаетсяС("[TheCell5]", "[") И НЕ ПустаяСтрока("[TheCell3]")' Тогда
		И я нажимаю на кнопку с именем 'ButtonMultiply'
		И в табличном документе 'SpreadsheetFieldTemlate' я перехожу к ячейке '[TheCell5]'
		И в табличном документе 'SpreadsheetFieldTemlate' я делаю двойной клик на текущей ячейке	
	
	И я нажимаю на кнопку с именем 'WriteAndCollapse'
