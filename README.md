# PBM Shop — Tugas Praktikum PBM 2026

Aplikasi Flutter untuk tugas praktikum Pemrograman Berbasis Mobile 2026. Aplikasi ini terhubung ke REST API untuk manajemen produk dengan sistem autentikasi berbasis token. Tampilan dibungkus dalam frame iPhone 16 Orange untuk memberikan pengalaman visual yang lebih menarik.

---

## Fitur

- Login menggunakan NIM sebagai username dan password
- Menyimpan token autentikasi secara aman menggunakan `flutter_secure_storage`
- Menampilkan katalog produk milik akun sendiri dalam tampilan grid
- Pencarian produk secara realtime
- Menambahkan produk baru ke dalam katalog
- Menghapus produk dari katalog (soft delete)
- Submit tugas beserta link repository GitHub
- Logout dari akun

---

## Struktur Project

```
lib/
├── main.dart
├── core/
│   └── app_theme.dart
├── models/
│   └── product_model.dart
├── screens/
│   ├── login_screen.dart
│   ├── catalog_screen.dart
│   └── add_product_screen.dart
└── services/
    └── api_service.dart
```

---

## Teknologi

- **Flutter** & **Dart**
- **REST API** — `https://task.itprojects.web.id`
- Package `http` untuk HTTP request
- Package `flutter_secure_storage` untuk menyimpan token autentikasi
- Package `google_fonts` untuk tipografi

---

## Cara Menjalankan

1. Clone repository ini

```bash
git clone https://github.com/username/task-pbm.git
cd task-pbm
```

2. Install dependencies

```bash
flutter pub get
```

3. Jalankan aplikasi

```bash
# Di browser Chrome
flutter run -d chrome

# Di emulator Android
flutter run -d android
```

4. Login menggunakan NIM masing-masing sebagai username dan password

---

## Dokumentasi API

| Method | Endpoint | Keterangan |
|--------|----------|------------|
| POST | `/api/auth/login` | Login & mendapatkan token |
| GET | `/api/products` | Ambil daftar produk |
| POST | `/api/products` | Tambah produk baru |
| DELETE | `/api/products/:id` | Hapus produk |
| POST | `/api/products/submit` | Submit tugas |

---

## Screenshot

> Tampilan aplikasi 

<img width="494" height="790" alt="Screenshot 2026-05-14 120046" src="https://github.com/user-attachments/assets/5711f401-9ada-4cf0-8328-ba59ebbc0e8a" />

<img width="455" height="799" alt="Screenshot 2026-05-14 120115" src="https://github.com/user-attachments/assets/a0d0cb46-86fe-4b8a-a32e-d6cd6158fc91" />

<img width="432" height="806" alt="Screenshot 2026-05-14 120127" src="https://github.com/user-attachments/assets/024f823d-2a62-4655-af79-cdf6f82abb84" />

<img width="463" height="773" alt="Screenshot 2026-05-14 120144" src="https://github.com/user-attachments/assets/9e8d8842-a6d3-4170-a98b-509b137cce73" />





## Developer

Dibuat untuk memenuhi tugas praktikum mata kuliah **Pemrograman Berbasis Mobile 2026**.
