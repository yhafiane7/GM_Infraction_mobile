class AppConfig {
  // Production API URL (Render)
  static const String productionUrl =
      'https://infraction-commune-api.onrender.com/api';

  // Development API URL (local)
  static const String devUrl = 'http://192.168.1.157:8000/api';

  // Use environment variable or default to production
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: productionUrl,
  );

  // Get the current URL based on environment
  static String get currentBaseUrl {
    // In debug mode, use dev URL, otherwise use production
    return const bool.fromEnvironment('dart.vm.product')
        ? baseUrl
        : productionUrl;
  }
}
