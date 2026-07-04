class AppConfig {
  const AppConfig({
    this.appName = 'Template',
    this.apiBaseUrl = const String.fromEnvironment('API_BASE_URL'),
    this.enableNetworkLogs = const bool.fromEnvironment(
      'ENABLE_NETWORK_LOGS',
      defaultValue: true,
    ),
  }
  );

  final String appName;
  final String apiBaseUrl;
  final bool enableNetworkLogs;
}
