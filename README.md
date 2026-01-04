# 📦 Lost & Found Mobile App

A mobile application built with **Flutter**, **PHP**, and **MySQL** that allows users to report and track **lost and found items** in a campus or city environment.

---

## 📱 Features

- Add lost items with description, location, and image  
- View all lost and found items in a clean list  
- Mark items as **Found**  
- Upload and display item images  
- Filter items by status (All / Lost / Found)  
- Clean and modern Material Design UI  
- RESTful backend with PHP & MySQL  
- Image handling via server-side proxy  

---

## 🛠️ Technologies Used

### Frontend
- Flutter  
- Dart  
- Material 3 UI  

### Backend
- PHP  
- MySQL  
- REST API  

### Tools
- Android Studio  
- phpMyAdmin  
- Git & GitHub  

---

## 🧠 Application Logic

- All items are created with status **Lost**
- Items can only be updated once to **Found**
- Images are uploaded during item creation
- Item details screen is read-only (except status update)
- Data is fetched dynamically from a remote database

---

## 🗄️ Database Schema

### `users`

| Field | Type |
|------|------|
| id | INT (PK) |
| name | VARCHAR |
| phone | VARCHAR |

### `items`

| Field | Type |
|------|------|
| id | INT (PK) |
| user_id | INT (FK) |
| title | VARCHAR |
| description | TEXT |
| location | VARCHAR |
| status | ENUM(Lost, Found) |
| image_url | VARCHAR |
| created_at | TIMESTAMP |

---

## 🔌 API Endpoints

| Endpoint | Method | Description |
|---------|--------|------------|
| `/get_items.php` | GET | Fetch all items |
| `/add_item.php` | POST | Add new item |
| `/update_status.php` | POST | Mark item as Found |
| `/upload_image.php` | POST | Upload item image |
| `/get_image.php` | GET | Serve item image |

---

## ▶️ How to Run the App

### 1. Clone the repository
```bash
git clone https://github.com/OmarBader-dev/lost-and-found-app.git
cd lost-and-found-app
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Run the app
```bash
flutter run
```
---

## 🎓 Academic Purpose
This project was developed as part of a university mobile application course to demonstrate:

 -Mobile app development using Flutter

 -Client–server communication

 -Database integration

 -Image handling

 -Clean UI/UX design

 -Version control with GitHub

---

## 👤 Authors

**Omar Bader & Abdul Hussein Ibrahim**

Lebanon 🇱🇧
