Реализованная функциональность
    
    Определение координат устройства
    Регистрация через сервер
    Авторизация через сервер
    Обмен данными с сервером
    Отрисовка карты
    Отрисовка меток членов семьи(включая собственую)
    Создание QR кода для присоединения к семье

Особенность проекта в следующем:

    Возможность быстрого портирования на большое колличество операционнх систем

Основной стек технологий:

    Flutter
    Dart
    Git
    GitHub
    Rest api

Среда запуска
    
    Windows
    MacOS
    Linux
    Android Studio
    IntelliJ IDEA
    
Как скомпилировать
    
    Windows
      Скачать Flutter SDK https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_2.5.3-stable.zip
      Разархивировать скаченный архив в корневую папку на системном диске
      Открываем "Изменение системных переменных среды"
      Переходим на вкладку дополнительно
      Нажимаем на кнопку "Переменные среды"
      В верхнем окне выбираем переменную "Path" и нажимаем кнопку "Изменить"
      Нажимаем кнопку создать
      Если разархивировали в корень системного диска, вставляем этот путь "C:\flutter\bin", если в иное место то путь до "flutter\bin"
      Два раза нажимаем "Окей"
      Для проверки правильной установки Flutter в "Командной строке прописываем следующую команду "flutter --version"
      Для восстановления всех зависмостей выполните команду в "Командной строке" "flutter doctor"
      Устанавливаем AndroidStudio или InteliJ IDEA
      Нажимаем на "Configure" и открываем SDK Manager, в Android SDK устанавливаем последний доступный SDK
      Ждем установки SDK
      Возвращаемся к конфигурации IDE
      Находим Flutter, жмем установить, автоматически предложит установить Dart, соглашаемся
      Клонируем проект и открываем его через IDE
      Запускаем AVD Manager( обычно кнопка запуска находится в правом верхнем углу)
      Создаем эмулятор на самой новой доступной версии SDK
      Запускаем его
      Для надежности компиляции в конфигурации проекта в пункт "Additional run args" прописываем "--no-sound-null-safety" применяем
      Запускаем сборку
      
    Для других платформ и в случае возникновения непредвиденных в README ошибок:
      Ссылка на документацию по установке: https://docs.flutter.dev/get-started/install
      Пример установки Flutter и начальной настройки IDE в виде видеоролика: https://www.youtube.com/watch?v=Nw39Se5xFQM
      
Перестройка под серверное приложение не на нашем сервере
    
    В проекте открываем файл lib/requests/send_map_data.dart
    Во всех 3 методах в переменной final uri = Uri.parse("'%адресс сервера%'/..."+'переменная') заменяем адресс сервера на свой
    
Разработчики

    Первушин Максим https://t.me/@whiskas44   
    Светличная Карина https://t.me/@kflnch   
    Кириченко Кирилл https://t.me/@smartsem    
