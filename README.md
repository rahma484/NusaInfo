# NusaInfo

Aplikasi Flutter sederhana untuk menampilkan, melihat detail, dan membuat pengumuman
menggunakan API [JSONPlaceholder](https://jsonplaceholder.typicode.com) dan package `http`.

## Fitur

- Daftar pengumuman (`GET /posts`) dengan `FutureBuilder` + `ListView.builder`, loading, pesan error, dan tombol **Coba Lagi**
- Tarik ke bawah untuk memuat ulang (`RefreshIndicator`)
- Detail pengumuman beserta komentar (`GET /posts/{id}/comments`)
- Tambah pengumuman (`POST /posts`) dengan validasi form `GlobalKey<FormState>`
- `SnackBar` di Home Screen setelah pengumuman berhasil dibuat (`await Navigator.push()`)

## Struktur Folder

```
lib/
├── models/
│   └── post.dart
├── services/
│   └── post_service.dart
├── screens/
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   └── add_post_screen.dart
└── main.dart
```

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

Pada Android, pastikan `android/app/src/main/AndroidManifest.xml` memiliki izin internet:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## Screenshot

### Home Screen
<!-- Ganti dengan screenshot Anda -->
![Home Screen](screenshots/home.png)

### Detail Screen
![Detail Screen](screenshots/detail.png)

### Add Post Screen
![Add Post Screen](screenshots/add_post.png)

### Pesan Error Saat Internet Mati
![Error Internet Mati](screenshots/error.png)

### SnackBar Setelah Pengumuman Berhasil Dibuat
![SnackBar](screenshots/snackbar.png)
