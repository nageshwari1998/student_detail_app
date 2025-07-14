import 'dart:io';
import 'package:flutter/foundation.dart';

// Automatically select the correct base URL for API calls
String getBaseUrl() {
  // Android emulator uses 10.0.2.2, real device/web uses actual IP
  if (!kIsWeb && Platform.isAndroid) {
    return 'http://10.0.2.2:3000/api/students';
  } else {
    return 'http://192.168.1.8:3000/api/students'; // Use your actual local IP
  }
}
