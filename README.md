# listview_mahasiswa
Mobile Device Programming assignment

## Screenshot
<div style="overflow-x: auto; white-space: nowrap;">
  <img src="https://github.com/user-attachments/assets/1d40466b-aca3-4c0c-a5fc-00ac1d804130" alt="Tampilan awal" width="48%" style="display: inline-block;"/>
  <img src="https://github.com/user-attachments/assets/db79621a-a62a-4ce0-a0d6-3dfa6dc2bcf0" alt="Tambah mahasiswa" width="48%" style="display: inline-block;"/>
  <img src="https://github.com/user-attachments/assets/377e500e-460f-4065-9636-a17c3318c628" alt="Ubah mahasiswa" width="48%" style="display: inline-block;"/>
  <img src="https://github.com/user-attachments/assets/85251fea-5fcb-4d5d-9ed4-9cb32af955a9" alt="Detail mahasiswa" width="48%" style="display: inline-block;"/>
  <img src="https://github.com/user-attachments/assets/bfbc8462-f63a-426e-ac31-a2a2d15af0f0" alt="Hapus mahasiswa" width="48%" style="display: inline-block;"/>
</div>

## Getting Started
- Install all dependencies
  ```bash
  flutter pub get
  ```
- Change .env  
  1. Duplicate `.env.example`.
  2. Rename to `.env`.
  3. Change value of 'API_BASE_URL' to your API address
- Move database file
  1. Move `koneksimhs.php` to htdocs folder from xampp.
  2. Create database using `akademik.sql` file.
  3. Start MySQL and Apache on xampp.
  4. Check flutter app
    ```bash
    flutter doctor
    ```
  5. build flutter app
    ```bash
    flutter build aar
    flutter build apk
    flutter build appbundle
    flutter build bundle
    flutter build web
    flutter build windows
    ```