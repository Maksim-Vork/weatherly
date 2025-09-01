# 🌤️ Forecast

**Мобильное приложение для просмотра прогноза погоды.**  
Простое и интуитивное приложение для получения актуальной информации о погоде с поддержкой прогноза на текущий день, почасового прогноза и прогноза на ближайшие 3 дня.

---

## 🚀 Функционал  

✨ **Основные возможности:**  
- 🌆 Выбор города для отображения прогноза погоды  
- 📅 Прогноз погоды на текущий день и ближайшие 3 дня  
- ⏰ Почасовой прогноз для текущего дня  
- ⚙️ Настройки: выбор темы оформления и изменение города  
- 💾 Локальное сохранение выбранного города между сессиями с помощью SharedPreferences  
- 🌐 Получение данных о погоде через сторонний REST API  
- 📊 Обработка больших JSON-данных для отображения прогноза  

📱 **Платформы:**  
- Android  
- iOS  

---

## 🛠️ Технологии  

- **Flutter / Dart**  
- **Dio (HTTP-клиент для работы с REST API)**  
- **Flutter Bloc (State Management)**  
- **SharedPreferences (Локальное сохранение данных)**  
- **Flutter ScreenUtil**  
- **Get_it (dependency injections)**  
- **Clean Architecture**  
- **SOLID**  

---

## 📂 Установка и запуск  

1️⃣ **Клонирование репозитория**  
```bash
git clone https://github.com/username/forecast.git
cd forecast
```

2️⃣ **Установка зависимостей**  
```bash
flutter pub get
```

3️⃣ **Запуск проекта**  
```bash
flutter run
```

---

## 📌 Структура проекта  

```plaintext
lib/
 ├── main.dart
 ├── core/
 │   ├── service/
 │   ├── locator/
 │   ├── theme/
 ├── features/
 │   ├── weather/
 │   ├── city/
 │   ├── settings/
 
```

---

## 🤝 Контрибьюция  

Если хотите предложить изменения:  

1. Сделайте форк репозитория  
2. Создайте новую ветку  
   ```bash
   git checkout -b feature/my-feature
   ```
3. Сделайте коммит  
   ```bash
   git commit -m "Add my feature"
   ```
4. Запушьте ветку  
   ```bash
   git push origin feature/my-feature
   ```

---

## 🧑‍💻 Автор  

**Chillowi coder**

[![GitHub](https://img.shields.io/badge/GitHub-000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Chillowi_coder)  [![Telegram](https://img.shields.io/badge/Telegram-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/l_2b2t_l)
