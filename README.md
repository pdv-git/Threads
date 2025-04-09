Projects/DelphiX/ProjectGroup.groupproj

1. При старте программы, модально выводится диалог подключения с БД. Необходимо нажать кнопку OK для формирования ConnectionString. Подключение к БД на самом деле не выполняется.
2. После нажатия кнопики OK будет выполненно заполнение дерева FileTreeDockWindow.TreeView содержимым каталога \Projects\DelphiX\Modules.
3. При разворачивании узла дерева FileTreeDockWindow.TreeView выполняются методы TFileTreeDockWindow.GetCatalogList и TFileTreeDockWindow.GetFileList для получения дочерних каталогов и файлов.
4. Метод TFileTreeDockWindow.GetCatalogList вызывает FileDataModule.FileReaderDataModule.GetCatalogList для получения дочерних каталогов, а метод TFileTreeDockWindow.GetFileList вызывает FileDataModule.FileReaderDataModule.GetFileList для получения дочерних .dll.
5. После получения списка дочерних .dll в методе TFileTreeDockWindow.GetFileList вызывается процедура FileDataModule.FileReaderDataModule.GetFileTaskList для получения API .dll ввиде XML возвращаемого из .dll экспортруемой функцией FileInfo.
6. После получения XML из .dll определяется набор задач и параметров в .dll, которые затем отображаются в дереве FileTreeDockWindow.TreeView.
7. При двойном клике на задаче в дереве выполняется метод TFileTreeDockWindow.OpenFile, в котором динамически загружается .dll и выполняются процедуры .dll полученные из XML.
8. Тестовая .dll реализована в Module1.dpr.
