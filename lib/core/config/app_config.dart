/// General application configuration.
///
/// Defines app-wide constants and settings
/// that are not environment-specific.
abstract class AppConfig {
  static const String appVersion = '1.0.0';
  static const int connectTimeout = 30000; // milliseconds
  static const int receiveTimeout = 30000; // milliseconds
}
