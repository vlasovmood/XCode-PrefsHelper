# XCode-PrefsHelper
**XCode PrefsHelper** — это универсальный и удобный пакет для хранения, обновления и удаления данных в приложениях на iOS и macOS. Этот пакет предоставляет простой интерфейс для работы с различными типами хранилищ данных, такими как **UserDefaults**, **Keychain**, и **CloudKit**, что позволяет вам эффективно управлять пользовательскими настройками и конфигурациями приложения.

## Особенности

- **UserDefaults**: для хранения простых настроек и предпочтений пользователя.
- **Keychain**: для безопасного хранения чувствительных данных, таких как пароли и токены.
- **CloudKit**: для синхронизации данных в облаке и обмена ими между устройствами.
- Поддержка создания, чтения, обновления и удаления данных.
- Простота в использовании с минимальной настройкой.

## Установка

1. Скачайте или клонируйте репозиторий.
2. Добавьте файлы в ваш проект.

## Использование

### UserDefaultsHelper

Для хранения простых данных, таких как настройки интерфейса или флаги.

#### Пример использования:

```swift
import XCodePrefsHelper

// Сохранить значение в UserDefaults
PrefsHelper.UserDefaultsHelper.set(key: "username", value: "john_doe")

// Получить значение из UserDefaults
if let username: String = PrefsHelper.UserDefaultsHelper.get(key: "username") {
    print("Имя пользователя: \(username)")
}

// Удалить значение из UserDefaults
PrefsHelper.UserDefaultsHelper.delete(key: "username")
```

### KeychainHelper

Для безопасного хранения чувствительных данных, таких как пароли, токены доступа и другой конфиденциальной информации.

#### Пример использования:

```swift
import XCodePrefsHelper

// Сохранить данные в Keychain
PrefsHelper.KeychainHelper.save(key: "authToken", value: "abc123securetoken")

// Получить данные из Keychain
if let authToken: String = PrefsHelper.KeychainHelper.get(key: "authToken") {
    print("Токен авторизации: \(authToken)")
}

// Удалить данные из Keychain
PrefsHelper.KeychainHelper.delete(key: "authToken")
```

### CloudKitHelper

Для синхронизации данных между устройствами с помощью CloudKit.

#### Пример использования:

```swift
import XCodePrefsHelper

let cloudKitHelper = PrefsHelper.CloudKitHelper()

// Сохранить данные в CloudKit
let fields = ["username": "john_doe", "email": "john@example.com"]
cloudKitHelper.save(recordType: "User", fields: fields) { result in
    switch result {
    case .success(let record):
        print("Запись сохранена в CloudKit: \(record)")
    case .failure(let error):
        print("Ошибка сохранения в CloudKit: \(error)")
    }
}

// Получить данные из CloudKit
cloudKitHelper.fetch(recordType: "User") { result in
    switch result {
    case .success(let records):
        print("Записи получены из CloudKit: \(records)")
    case .failure(let error):
        print("Ошибка получения из CloudKit: \(error)")
    }
}

// Удалить запись из CloudKit
if let recordID = someRecord.recordID {
    cloudKitHelper.delete(recordID: recordID) { result in
        switch result {
        case .success:
            print("Запись удалена из CloudKit")
        case .failure(let error):
            print("Ошибка удаления из CloudKit: \(error)")
        }
    }
}
```

## Дополнительные возможности

- **Проверка существования данных**: Вы можете проверить, существует ли ключ в **UserDefaults** или **Keychain** перед чтением.
  
  Пример для **Keychain**:
  ```swift
  if PrefsHelper.KeychainHelper.get(key: "authToken") != nil {
      print("Токен существует")
  } else {
      print("Токен не найден")
  }
  ```

- **Очистка всех данных**: Вы можете очистить все данные из **UserDefaults** или **Keychain**, если необходимо.

  Пример для **UserDefaults**:
  ```swift
  PrefsHelper.UserDefaultsHelper.clearAll()
  ```
