# 📌 Expense Tracker App

## 📖 Overview

The **Expense Tracker App** is a mobile application that helps users manage and track their expenses across various categories. The app is built using **Clean Architecture** combined with **MVVM** principles to ensure scalability, maintainability, and separation of concerns.

---

## 🏗 Architecture & Structure

The project follows **Clean Architecture** + **MVVM**:

- **Domain Layer**: Business logic, use cases, and entities.
- **Data Layer**: Handles API requests and local data caching.
- **Presentation Layer**: UI screens, widgets, and state management.
- **Core Layer**: Common utilities, constants, and helpers.

This structure ensures:

- Clear separation between business logic and UI.
- Easier testing and debugging.
- Reusability of components.

---

## 🔄 State Management Approach

The app uses **BLoC (Business Logic Component)** for state management:

- Ensures unidirectional data flow.
- Improves testability.
- Keeps the UI reactive and synchronized with data changes.

---

## 🌐 API Integration

API integration is implemented using **Dio**:

- Handles HTTP requests and responses.
- Supports interceptors for logging and error handling.
- Integrated with **infinite scroll pagination** for large datasets.

---

## 📦 Pagination Strategy

- **Type**: API-based pagination with local caching.
- **Library Used**: `infinite_scroll_pagination`.
- Data is **cached** using **SharedPreferences** to improve performance and offline access.

---

## 🖼 UI Screenshots

### Categories & Add Expense



---

## 🚀 How to Run the Project

1. Install **Flutter 3.24.3**.
2. Clone the repository:
   ```bash
   git clone https://github.com/ezzat2019/tracker_lite
   ```
3. Open in **Android Studio**.
4. Run:
   ```bash
   flutter pub get
   flutter run
   ```

---

## 📱 APK Download

You can download and install the APK directly: [📥 Download APK](https://www.mediafire.com/file/86tg7wxkabougrb/ezzat_expense_app.apk/file)

---

## 🛠 Trade-offs & Assumptions

- Used **SharedPreferences** for caching due to its simplicity and fast access, suitable for small datasets.
- UI is optimized for Android; iOS testing is limited.
- No authentication implemented in this version.

---

## 🐞 Known Bugs / Unimplemented Features

- Some API error responses are not fully localized.
- Dark mode not implemented yet.
- No data encryption for local storage.

---

## 📂 GitHub Repository

[🔗 View on GitHub](https://github.com/ezzat2019/tracker_lite)

---

## Contact

If you need adjustments to the README or want additional screenshots, tell me which parts to change and I’ll update it.

