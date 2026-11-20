# VA-Tests-Perform-En-En
Сценарии автоматизированного тестирования для конфигурации 1C:Perform (En)
Automated test scenarios for the 1C:Perform (En) configuration

*Русский текст — ниже, English — after it.*

## Источник и что изменено

Исходный набор — `1C-CPM/VA-Tests-Perform-En-En`, коммит `d38463d` от 26.04.2024 (первый коммит этого репозитория,
файлы без изменений). Набор доработан для 1C:Perform 3.2.9.56 EN и платформы 8.3.24 EN; изменения разложены по коммитам по видам
правок:

- каталоги и файлы — латиницей (`0_ExportScenarios`, `1_MasterData`, `3_Budgeting\Layouts`), содержимое без
  изменений;
- русские и недопереведённые имена исходного набора заменены английскими — в сценариях и эталонных макетах .mxl;
- перевод строка в строку на английский Gherkin, без смысловых правок: набор должен работать на платформе только
  с английским языком;
- переименования релиза 3.2.9.56 EN и платформы 8.3.24 EN: колонки и показатели, элементы форм, подписи, тексты
  сообщений;
- изменённые, добавленные и убранные шаги — исправления релиза, общие с VA-Tests-Perform (01.01, 01.03, 09.04, 14,
  19.04, 19.09), явный язык интерфейса, библиотека экспортных сценариев, новые файлы макетов; смысловые правки —
  смотреть в первую очередь;
- устойчивость: 03.03 — эталон бланка на текущий год, 02.11 — выбор значения по строке, макеты Excel —
  фиксированный формат дат m/d/yyyy;
- предусловие 1_MasterData 00.24 — тип БД текущей ИБ и периоды 2024–2026.

Все 260 сценариев исходного набора на месте (плюс 00.24), ни одна проверка не убрана и не закомментирована, ни одно
ожидаемое число не изменилось по значению; одна проверка исправлена в сторону строгости (18: «поле не существует»
проверяло неверное имя и проходило всегда).

Кириллица в активных строках осталась в одном месте — `Ванесса.Объект.КаталогПроекта` в 03.03: это имя реквизита
формы самой Vanessa Automation (английского синонима нет); на платформе с английским языком работает.

## Проверено

1C:Perform 3.2.9.56 EN, платформа 8.3.24.1528, Vanessa Automation 1.2.043.47, файловая база (ветка `file-base-env`):
1_MasterData — 27 из 27; 3_Budgeting — 240 сценариев, из них 230 без ошибок на стенде без Microsoft Excel;
02 и 10 (нужен Excel) — 26 из 26 на машине с Excel.
17 «Аналитические отчёты и панели» у вендора помечен `@IgnoreOnCIMainBuild` и не исполняется. Тест устарел: в
Perform 3.2.9.56 справочник аналитических отчётов выведен из употребления («(Не использовать) Аналитические отчеты»,
команда скрыта), аналитические панели переделаны. Нужен новый тест, правкой старый не чинится.

---

## Source and what was changed

The original suite is `1C-CPM/VA-Tests-Perform-En-En`, commit `d38463d` of 26.04.2024 (the first commit of this
repository, files unchanged). The suite is adapted to 1C:Perform 3.2.9.56 EN and platform 8.3.24 EN; the changes are split into commits by kind:

- folders and files in Latin script (`0_ExportScenarios`, `1_MasterData`, `3_Budgeting\Layouts`), content
  unchanged;
- Russian and half-translated names of the original suite replaced with English ones — in the scenarios and in
  the reference .mxl layouts;
- line-for-line translation to English Gherkin, no change of meaning: the suite must run on a platform with the
  English language only;
- renames of release 3.2.9.56 EN and platform 8.3.24 EN: columns and indicators, form elements, captions, message
  texts;
- changed, added and removed steps — release fixes shared with VA-Tests-Perform (01.01, 01.03, 09.04, 14, 19.04,
  19.09), the interface language set explicitly, the library of export scenarios, new layout files; changes of
  meaning — review these first;
- stability: 03.03 — the template reference for the current year, 02.11 — a value is selected by string, Excel
  layouts — fixed date format m/d/yyyy;
- precondition 1_MasterData 00.24 — database type of the current infobase and periods 2024–2026.

All 260 scenarios of the original suite are present (plus 00.24), no check is removed or commented out, no expected
number changed its value; one check is made stricter (18: "field does not exist" checked a wrong name and always
passed).

Cyrillic is left in one active line — `Ванесса.Объект.КаталогПроекта` in 03.03: it is the name of a form attribute of
Vanessa Automation itself (there is no English synonym); it works on a platform with the English language.

## Verified

1C:Perform 3.2.9.56 EN, platform 8.3.24.1528, Vanessa Automation 1.2.043.47, file infobase (branch `file-base-env`):
1_MasterData — 27 of 27; 3_Budgeting — 240 scenarios, 230 of them pass on a stand without Microsoft Excel;
02 and 10 (need Excel) — 26 of 26 on a machine with Excel.
17 "Analytical reports and dashboards" is tagged `@IgnoreOnCIMainBuild` by the vendor and is not executed. The test is
obsolete: in Perform 3.2.9.56 the analytical reports catalog is deprecated ("(Do not use) Analytical reports", command
hidden) and analytical dashboards were redesigned; a new test is needed, the old one cannot be fixed.

## Ветка file-base-env

`main` плюс слой окружения для запуска на файловой базе с лицензией для разработчиков. Проверки сценариев не
меняются, добавлены только условия выполнения:

- подключение тестового клиента обёрнуто в `Try ... Except / And Delay 30 / повторное подключение` (75 мест):
  при медленном старте клиента первая попытка не успевает;
- паузы, которых нет в исходном наборе (9 мест): 02 (20 и 45 с) и 20.09 (20 с перед каждым переключением
  пользователя) — сеанс закрытого клиента освобождается с задержкой;
- 02.10: в начале сценария клиент закрывается и подключается заново под Budgeting1 (в наборе VA-Tests-Perform
  это снято — конфликт периодов закрывает предусловие 00.24; здесь оставлено, без него EN-набор не прогонялся);
- 01.01: администратору выключается вопрос «Exit the app?» (`AskConfirmationOnExit = False`). Иначе Vanessa
  Automation не может закрыть клиента штатно и закрывает процесс, а сеанс закрытого так клиента остаётся в файловой
  базе и занимает место лицензии для разработчиков — после нескольких переключений следующие клиенты не запускаются.
  Для пользователей Budgeting1–4 вопрос выключается так же — служебным шагом перед прогоном 3_Budgeting (в набор не
  входит).

## Branch file-base-env

`main` plus an environment layer for running on a file infobase with the developer licence. Scenario checks are not
changed, only run conditions are added:

- connecting the test client is wrapped in `Try ... Except / And Delay 30 / connect again` (75 places): when the
  client starts slowly the first attempt fails;
- delays the original suite does not have (9 places): 02 (20 and 45 s) and 20.09 (20 s before every switch of the
  user) — the session of a closed client is released with a delay;
- 02.10: at the start of the scenario the client is closed and connected again as Budgeting1 (removed in
  VA-Tests-Perform — precondition 00.24 fixes the period conflict; kept here, the EN suite was not run without it);
- 01.01: the "Exit the app?" question is turned off for the administrator (`AskConfirmationOnExit = False`). Otherwise
  Vanessa Automation cannot close the client normally and kills the process; the session of the killed client stays in
  the file infobase and holds a seat of the developer licence — after several switches the next clients do not start.
  For users Budgeting1–4 the question is turned off the same way by a run-only step before 3_Budgeting (not part of
  the suite).

## Зачем этот репозиторий

Тренировка работы с ИИ-помощником: через MCP Vanessa Automation помощник прогоняет набор на тестовой базе,
разбирает падения по журналу и снимкам экрана и исправляет сценарии, а человек проверяет и принимает правки.

## Why this repository

Practice in working with an AI assistant: through the Vanessa Automation MCP the assistant runs the suite on a test
infobase, analyses failures by the log and screenshots and fixes the scenarios; a person reviews and accepts the
changes.
