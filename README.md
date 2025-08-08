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
![1](https://github.com/user-attachments/assets/161e7136-432c-44c4-bc44-a4559ea9a54b)
![2](https://github.com/user-attachments/assets/1e32b7f2-e584-4896-b43e-d7bb81b577a0)
![3](https://github.com/user-attachments/assets/3d1415b1-90d3-44c5-b054-00197008a64c)
![4](https://github.com/user-attachments/assets/51dbb045-f496-4d1c-aa54-a039aac09afe)
![5](https://github.com/user-attachments/assets/8ef05424-6514-4ce6-b5bf-24f8e2e12c07)
![6](https://github.com/user-attachments/assets/02ff3d19-0cde-4337-aeab-87d39ffee52c)

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


## 📂 GitHub Repository

[🔗 View on GitHub](https://github.com/ezzat2019/tracker_lite)

---

## Contact

If you need adjustments to the README or want additional screenshots, tell me which parts to change and I’ll update it.

