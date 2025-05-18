# 📌 FlutterAPP_AI_sinhala_to_english

## 🌟 Overview
FlutterAPP_AI_sinhala_to_english is a mobile application designed to provide seamless translations between **Sinhala** and **English** using **AI-powered language models**. The app integrates **Google Gemini AI** to deliver accurate, context-aware, and formal translations while maintaining natural sentence structure.


![Image](https://github.com/user-attachments/assets/4dea4aa7-4fb6-41fd-b7ea-3ed7d2558688)



https://github.com/user-attachments/assets/f2388629-9846-49b7-8249-21f08f9f9b4f



## 🔥 Key Features
- 🎯 **Sinhala ↔ English Translation**
- 🔄 **Language Swap** Feature
- 📝 **Input & Output Text Boxes**
- 📋 **Copy Translations to Clipboard**
- ⭐ **Save Translations as Favorites**
- 📖 **Translation History (Coming Soon!)**
- 🔊 **Text-to-Speech Feature** (Future Update)

## 🛠️ Tech Stack
- **Flutter** (Framework for Cross-Platform App Development)
- **Dart** (Programming Language)
- **Google Gemini AI API** (Translation Engine)
- **REST API (HTTP Requests)**
- **SQLite** (For Future Translation History Storage)

## 📂 Project Structure
```
lib/
│── screens/
│   ├── home_screen.dart
│   ├── splash_screen.dart
│── services/
│   ├── gemini_translation_service.dart
│── utils/
│   ├── api_key.dart
│── widgets/
│   ├── language_selector.dart
│   ├── translation_box.dart
│── main.dart
```
- `screens/` → Manages UI components for Home and Splash Screens
- `services/` → Handles **AI translation requests** via **Google Gemini API**
- `utils/` → Stores API keys & other configurations
- `widgets/` → Reusable UI components (language selector, translation box, etc.)
- `main.dart` → **App entry point**

## 📥 Installation & Setup
1️⃣ **Clone the Repository**
```bash
git clone https://github.com/yourusername/FlutterAPP_AI_sinhala_to_english.git
cd FlutterAPP_AI_sinhala_to_english
```

2️⃣ **Install Dependencies**
```bash
flutter pub get
```

3️⃣ **Add API Key** *(Required for translation service)*
- Navigate to `lib/utils/api_key.dart`
- Replace `YOUR_GEMINI_API_KEY` with your actual API Key:
```dart
const String apiKey = "YOUR_GEMINI_API_KEY";
```

4️⃣ **Run the App** 🚀
```bash
flutter run
```

## 📊 Dataset & Predictions
- The translation **dataset is powered by Google Gemini AI**, ensuring **context-aware and natural translations**.
- Prediction results are directly fetched from the **Google AI model**, ensuring **accurate and formal output** while maintaining a **natural tone**.

## ⚙️ Importing Required Packages
This app requires the following **Flutter packages**:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.5
  flutter_tts: ^3.2.2  # (For future text-to-speech feature)
```
Run:
```bash
flutter pub get
```

## 📝 How It Works
1. **User Inputs Text** in either **Sinhala or English**.
2. **Google Gemini AI API** processes the text & generates **accurate translations**.
3. Translations are displayed **instantly**.
4. Users can **copy**, **save**, or **favorite** translations for future reference.

## 📌 Future Enhancements
- ✅ **Offline Translation Support**
- ✅ **Speech-to-Text Integration**
- ✅ **Text-to-Speech Output**
- ✅ **Better UI/UX Improvements**

## 🤝 Contributors
- **[Your Name]** *(Developer)*
- **[Contributor's Name]** *(Designer/Support)*

---
⭐ **If you like this project, give it a star on GitHub!** ⭐

