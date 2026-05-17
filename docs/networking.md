# Networking

Networking is centered around `ApiClient`, which wraps Dio and applies common settings.

## Important Files

- `lib/core/network/api_client.dart`
- `lib/core/network/api_interceptor.dart`
- `lib/core/network/token_manager.dart`
- `lib/core/network/network_info.dart`
- `lib/core/constants/api_constants.dart`

## Base URL

Set the API base URL with Dart defines:

```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com
```

`AppConfig` reads it here:

```dart
this.apiBaseUrl = const String.fromEnvironment('API_BASE_URL')
```

## Making Requests

Use repositories, not widgets.

```dart
class AccountRepository extends BaseRepository {
  AccountRepository(super.apiClient);

  Future<Map<String, dynamic>> getAccount() async {
    final response = await apiClient.get<Map<String, dynamic>>('/account');
    return response.data ?? {};
  }
}
```

## Token Handling

`ApiInterceptor` reads the access token from `TokenManager` and attaches it to requests:

```dart
Authorization: Bearer <token>
```

Save tokens after login:

```dart
await Get.find<TokenManager>().saveTokens(
  accessToken: accessToken,
  refreshToken: refreshToken,
);
```

Clear tokens on logout:

```dart
await Get.find<TokenManager>().clear();
```

## Error Handling

Dio errors are mapped to `NetworkException`.

Controllers can use `runBusy`:

```dart
Future<void> submit() async {
  await runBusy(() async {
    await repository.submitForm();
  });
}
```

Global unexpected errors are recorded by `GlobalErrorHandler`.

## Connectivity

Use `NetworkInfo` or `ConnectivityService`:

```dart
final isConnected = await Get.find<NetworkInfo>().isConnected;
```

For UI, route users to `NoInternetScreen` or show `NoInternetWidget`.

## Repository Rule

Every feature should hide API details behind a repository. The controller should call readable methods such as `loadProfile`, `fetchItems`, or `submitForm`, not raw URLs.
