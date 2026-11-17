# VA-Tests-Perform-En-En
Сценарии автоматизированного тестирования для конфигурации 1C:Perform (En)
Automated test scenarios for the 1C:Perform (En) configuration

*Русский текст — ниже, English — after it.*

## Источник и что изменено

Исходный набор — `1C-CPM/VA-Tests-Perform-En-En`, коммит `d38463d` от 26.04.2024 (первый коммит этого репозитория,
файлы без изменений). Набор доработан для 1C:Perform 3.2.9.56 EN и платформы 8.3.24 EN; изменения разложены по
коммитам, каждый влит в `main` отдельной веткой:

| Ветка | Что | Почему |
|---|---|---|
| `rename` | Каталоги и файлы — латиницей (`0_ExportScenarios`, `1_MasterData`, `3_Budgeting\Layouts`), содержимое без изменений | Пути без кириллицы; история каждого файла прослеживается |
| `fix` | Сценарии: русские и недопереведённые имена исходного набора заменены английскими (в его же тексте) — элементы форм, разделы и заголовки окон, данные, полупереводы («DimenKind - …»), числа в русском формате | В английской конфигурации таких имён нет |
| `fix-layouts` | То же в эталонных макетах .mxl: имена колонок и параметров, строки формата «ЧН=0; ЧГ=3,0…» → «NZ=0; NG=3,0…» | Отдельно: строки .mxl в тысячи символов, дифф по ним нечитаем |
| `lang` | Перевод строка в строку: `#language: en`, шаги VA по таблице перевода, код и запросы на английском, переменные и пути, оставшиеся русские значения, формат чисел и дат (en-US, m/d/yyyy); строки не добавляются и не удаляются, английские значения не меняются | Набор должен работать на платформе только с английским языком; исходный набор был написан русским Gherkin |
| `rel-names` | Переименования релиза 3.2.9.56 EN и платформы 8.3.24 EN в строках, шаг которых не меняется: колонки и показатели (Line→String, Coefficient→ZoomRatio, Product ID→SKU…), коды в формулах, элементы форм, подписи, тексты сообщений, английская сортировка | Имена в текущем релизе отличаются от исходного набора |
| `rel-steps` | Изменённые, добавленные и убранные шаги: исправления релиза, общие с VA-Tests-Perform (01.01, 01.03, 09.04, 14, 19.04, 19.09), язык интерфейса задаётся явно, переписанная библиотека экспортных сценариев, новые файлы макетов | Смысловые правки сценариев — смотреть в первую очередь |
| `tech` | 03.03 — эталон бланка на текущий год; 02.11 — выбор значения по строке; макеты Excel — фиксированный формат дат m/d/yyyy | Тесты зависели от текущего года, истории выбора и региональных настроек Windows; проверки не ослаблены |
| `pre` | 1_MasterData, 00.24 — тип БД текущей ИБ и периоды 2024–2026 | Без периодов проверка интервала перезаписывает год, записи конфликтуют по версии |

Разделение автоматическое. `fix` и `fix-layouts` меняют только значения в кавычках в тексте исходного набора
(русские и недопереведённые имена, подтверждённые словарём из русской и английской выгрузок релиза или независимой
сверкой). `lang` переводит строку в строку: шаг переводится, только если его английский шаблон совпадает с итоговым
(по таблице перевода шагов Vanessa Automation и проверенному списку соответствий), английские значения не трогаются,
строки не добавляются и не удаляются — поэтому в нём нет смысловых правок. `rel-names` меняет только значения в
строках с прежним шагом. Всё остальное — в `rel-steps`; туда же попали строки, которым не нашлось однозначной пары
(перевод и правка вместе).

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
repository, files unchanged). The suite is adapted to 1C:Perform 3.2.9.56 EN and platform 8.3.24 EN; the changes are
split into commits, each merged into `main` from its own branch:

| Branch | What | Why |
|---|---|---|
| `rename` | Folders and files in Latin script (`0_ExportScenarios`, `1_MasterData`, `3_Budgeting\Layouts`), content unchanged | No Cyrillic in paths; the history of every file can be followed |
| `fix` | Scenarios: Russian and half-translated names of the original suite replaced with English ones (in its own text) — form element names, sections and window titles, data, half-translations ("DimenKind - …"), numbers in Russian format | The English configuration has no such names |
| `fix-layouts` | The same in the reference .mxl layouts: column and parameter names, format strings "ЧН=0; ЧГ=3,0…" → "NZ=0; NG=3,0…" | Separate: .mxl lines are thousands of characters long, a line diff of them is unreadable |
| `lang` | Line-for-line translation: `#language: en`, VA steps by the translation table, built-in language and queries in English syntax, variables and paths, remaining Russian values, number and date format (en-US, m/d/yyyy); no line is added or removed, English values are not changed | The suite must run on a platform with the English language only; the original suite was written in Russian Gherkin |
| `rel-names` | Renames of release 3.2.9.56 EN and platform 8.3.24 EN in lines whose step does not change: columns and indicators (Line→String, Coefficient→ZoomRatio, Product ID→SKU…), codes in formulas, form elements, captions, message texts, English sort order | Names in the current release differ from the original suite |
| `rel-steps` | Changed, added and removed steps: release fixes shared with VA-Tests-Perform (01.01, 01.03, 09.04, 14, 19.04, 19.09), the interface language is set explicitly, the rewritten library of export scenarios, new layout files | Changes of meaning — review these first |
| `tech` | 03.03 — the template reference for the current year; 02.11 — a value is selected by string; Excel layouts — fixed date format m/d/yyyy | The tests depended on the current year, the choice history and the Windows regional settings; checks are not weakened |
| `pre` | 1_MasterData, 00.24 — database type of the current infobase and periods 2024–2026 | Without the periods the interval check rewrites the year and writes conflict on the version |

The split is automatic. `fix` and `fix-layouts` change only quoted values in the text of the original suite (Russian
and half-translated names confirmed by a dictionary built from the Russian and English dumps of the release, or by an
independent review). `lang` translates line for line: a step is translated only when its English template equals the
final one (by the Vanessa Automation step translation table and a reviewed list of equivalences), English values are
not touched, no line is added or removed — so it contains no change of meaning. `rel-names` changes only values in
lines with the same step. Everything else is in `rel-steps`, including lines that had no unambiguous pair (translation
and change together).

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
