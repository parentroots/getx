class AppConfig {
  const AppConfig({
    this.appName = 'Template',
    this.apiBaseUrl = const String.fromEnvironment('API_BASE_URL'),
    this.apiSocketUrl = const String.fromEnvironment('API_SOCKET_URL'),
    this.enableNetworkLogs = const bool.fromEnvironment(
      'ENABLE_NETWORK_LOGS',
      defaultValue: true,
    ),
  }
  );

  final String appName;
  final String apiBaseUrl;
  final String apiSocketUrl;
  final bool enableNetworkLogs;
}
