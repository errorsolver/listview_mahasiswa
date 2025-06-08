# listview_mahasiswa
Mobile Device Programming assignment

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
    flutter build web
    ```