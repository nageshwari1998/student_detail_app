# Student Detail System

This repository contains two projects:
- **Student Detail App**: A Flutter application for managing student details.
- **Student Detail API**: A Node.js + Express backend API for student data.

---

## Student Detail App (Flutter)

### Features
- View students by course (EEE, ECE, MECH, CSE, AI & Data Science)
- Add, edit, and delete students
- Works on Android emulator, real device, and web

### Setup
1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Clone this repository
3. Update the API base URL in `lib/api_base.dart` if your backend IP changes
4. Run the app:
   - For emulator: `flutter run`
   - For web: `flutter run -d chrome`
   - For real device: `flutter run -d <device_id>`

### API Connection
- The app connects to the backend API for all student operations
- Make sure the backend is running and accessible on your network

### Folder Structure
- `lib/` - Main Flutter code
- `lib/screens/` - UI screens
- `lib/models/` - Data models
- `lib/services/` - API services

### Troubleshooting
- If you see network errors, check your API base URL and network connectivity
- For emulator, use `10.0.2.2` as the API host
- For real device/web, use your actual local IP

---

## Student Detail API (Node.js + Express)

### Features
- RESTful API for students
- Filter students by course
- Add, edit, delete students
- MongoDB database
- CORS enabled for Flutter/web access

### Setup
1. Install Node.js and npm: https://nodejs.org/
2. Install MongoDB and start the service
3. Clone this repository
4. Install dependencies:
   ```
   npm install
   ```
5. Start the server:
   ```
   node index.js
   ```
   or
   ```
   npm start
   ```
6. The API runs at `http://localhost:3000`

### API Endpoints
- `GET /api/students?course=EEE` - List students by course
- `POST /api/students` - Add a student
- `PUT /api/students/:id` - Edit a student
- `DELETE /api/students/:id` - Delete a student

### Folder Structure
- `controllers/` - API logic
- `models/` - Mongoose models
- `routes/` - Express routes

### Troubleshooting
- Ensure MongoDB is running
- Check your network/firewall for API access
- Use correct IP for mobile/web clients

---

## License
MIT
