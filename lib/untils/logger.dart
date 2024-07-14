import 'dart:developer' as developer;

class Logger {
  static void I(String message) {
    developer.log(message, level: 800, name: 'INFO');
  }

  static void E(String message, [error, StackTrace? stackTrace]) {
    developer.log(
      message,
      error: error,
      stackTrace: stackTrace,
      level: 1000,
      name: 'ERROR',
    );
  }

  static void W(String message) {
    developer.log(message, level: 900, name: 'WARNING');
  }
}