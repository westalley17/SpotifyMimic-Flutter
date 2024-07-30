import 'dart:io';

import 'env/android_env.dart' as android_env;
import 'env/web_env.dart' as web_env;
import 'env/windows_env.dart' as windows_env;

String get baseUrl {
  if (Platform.isAndroid) {
    return android_env.baseUrl;
  } else if (Platform.isWindows) {
    return windows_env.baseUrl;
  } else if (Platform.isIOS) {
    // Add IOS specific baseUrl if needed
  }
  // You can add other platform checks if needed
  return web_env.baseUrl;
}
