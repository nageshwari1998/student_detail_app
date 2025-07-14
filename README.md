# Student Detail App

A Flutter application for managing student details, including viewing, adding, editing, and deleting students by course.

## Features

- View students by course (EEE, ECE, MECH, CSE, AI & Data Science)
- Add new students
- Edit student details
- Delete students
- Works on Android emulator, real device, and web

## Setup

1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Clone this repository
3. Update the API base URL in `lib/api_base.dart` if your backend IP changes
4. Run the app:
   - For emulator: `flutter run`
   - For web: `flutter run -d chrome`
   - For real device: `flutter run -d <device_id>`

## API Connection

- The app connects to the backend API for all student operations
- Make sure the backend is running and accessible on your network

## Folder Structure

- `lib/` - Main Flutter code
- `lib/screens/` - UI screens
- `lib/models/` - Data models
- `lib/services/` - API services

## Troubleshooting

- If you see network errors, check your API base URL and network connectivity
- For emulator, use `10.0.2.2` as the API host
- For real device/web, use your actual local IP

## License

MIT

# student_detail_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
