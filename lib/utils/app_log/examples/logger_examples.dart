import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getx_template/utils/app_log/logger.dart';

/// A class demonstrating a sample user model for pretty-print JSON testing.
class SampleUser {
  final int id;
  final String name;
  final String email;

  SampleUser({required this.id, required this.name, required this.email});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };

  @override
  String toString() => 'SampleUser(id: $id, name: $name)';
}

/// Runs a sequence of logging examples to showcase every feature in the system.
///
/// Call this method from anywhere in your application to test the visual outputs.
void runLoggerExamples() {
  // ==========================================
  // 1. BASE LEVEL LOGGING DEMONSTRATIONS
  // ==========================================
  log.i('==== STAGE 1: Standard Severity Levels ====');

  log.d('User Loaded');

  log.i('Application Started');

  log.success('Login Successful');

  log.w('No Internet');

  try {
    throw Exception('[core/no-app] Firebase has not been configured.');
  } catch (error, stackTrace) {
    log.e('Firebase initialization failed', error, stackTrace);
  }

  // ==========================================
  // 2. DOMAIN-SPECIFIC LOGGING
  // ==========================================
  log.i('==== STAGE 2: Domain-Specific Subsystems ====');

  log.firebase('FCM Token', 'dGhpcyBpcyBhIHNhbXBsZSB0b2tlbiBmb3IgZmlyZWJhc2U=');

  log.auth('User session refreshed successfully', {'userId': 12459, 'roles': ['admin', 'editor']});

  log.network('Connected to WebSocket server: wss://echo.websocket.org');

  log.cache('User profile stored in encrypted secure storage');

  log.database('Inserted 25 rows into table "cached_orders"');

  log.navigation('Home -> ProfileSettings -> SecuritySettings');

  log.analytics('Purchase Event triggered - Item ID: 9982, Price: \$49.99');

  // ==========================================
  // 3. API REQUEST & RESPONSE LOGGING
  // ==========================================
  log.i('==== STAGE 3: API Request & Response Formatting ====');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
  };

  final requestBody = {
    'username': 'john_doe',
    'password': 'supersecretpassword123',
    'device': 'Pixel 7 Pro',
  };

  log.apiRequest(
    method: 'POST',
    url: 'https://example.com/api/v1/auth/login',
    headers: headers,
    body: requestBody,
  );

  final responseData = {
    'status': 'success',
    'data': {
      'user': {
        'id': 4512,
        'username': 'john_doe',
        'email': 'john.doe@example.com',
      },
      'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwi...',
    }
  };

  log.apiResponse(
    statusCode: 200,
    duration: const Duration(milliseconds: 143),
    body: responseData,
  );

  // ==========================================
  // 4. PERFORMANCE STOPWATCH MONITORING
  // ==========================================
  log.i('==== STAGE 4: Performance Latency Audits ====');

  final timer = PerformanceLogger.start();
  // Simulating a minor execution pause
  for (var i = 0; i < 1000000; i++) {
    // Arbitrary work
  }
  timer.stop('Login API Process');

  // Multi-lap audits
  final lapTimer = PerformanceLogger.start();
  // Stage 1
  lapTimer.lap('Database Lookup Stage');
  // Stage 2
  lapTimer.lap('Authentication Token Creation Stage');
  lapTimer.stop('Total Auth Transaction Pipeline');

  // ==========================================
  // 5. EXTENSION METHODS (INLINE LOGGING)
  // ==========================================
  log.i('==== STAGE 5: Convenient Inline Extension Logs ====');

  'Immediate Text Debug'.logDebug();
  'Immediate Text Warning'.logWarning();
  
  final userModel = SampleUser(id: 101, name: 'Alice Smith', email: 'alice@example.com');
  userModel.logSuccess();

  final userMap = userModel.toJson();
  userMap.logInfo();

  // ==========================================
  // 6. DIO INTERCEPTOR CONFIGURATION SHOWCASE
  // ==========================================
  log.i('==== STAGE 6: Configuring Dio Network Clients ====');

  final dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 5),
  ));

  // Add the custom interceptor to Dio
  dio.interceptors.add(const DioLogInterceptor());
  
  log.success('Dio Client initialized with custom DioLogInterceptor.');

  // ==========================================
  // 7. RIVERPOD PROVIDER OBSERVER SHOWCASE
  // ==========================================
  log.i('==== STAGE 7: Riverpod Integration Example ====');

  // To wire this observer up, add it to your ProviderScope:
  //
  // void main() {
  //   runApp(
  //     ProviderScope(
  //       observers: [const RiverpodLogger()],
  //       child: const MyApp(),
  //     ),
  //   );
  // }
  log.success('Riverpod ProviderObserver implementation ready (RiverpodLogger).');

  // ==========================================
  // 8. NAVIGATION OBSERVER SHOWCASE
  // ==========================================
  log.i('==== STAGE 8: Route Navigation Integration Example ====');

  // To wire this observer up, add it to your MaterialApp's navigatorObservers:
  //
  // MaterialApp(
  //   navigatorObservers: [NavigationLogger()],
  //   home: const HomeScreen(),
  // );
  //
  // Alternatively, you can log manual route updates when using custom routers:
  NavigationLogger.logPush('/dashboard', '/login');
  NavigationLogger.logCurrentRoute('/dashboard/reports');
  NavigationLogger.logPop('/dashboard/reports', '/dashboard');

  // ==========================================
  // 9. CONFIGURATION CUSTOMIZATION
  // ==========================================
  log.i('==== STAGE 9: Dynamically Changing Configurations ====');

  // Disable API & performance logs (e.g. for less noise during UI debugging)
  AppLogger.instance.configure(
    config: const LoggerConfig(
      enableApi: false,
      enablePerformance: false,
      enableDebug: true,
      enableErrors: true,
      enableFirebase: true,
      enableAuth: true,
      enableNavigation: true,
      enableAnalytics: true,
      enableDatabase: true,
      enableCache: true,
    ),
  );

  log.success('Logger re-configured: API and Performance logs disabled.');
  
  // This request log will be suppressed due to the config changes above
  log.apiRequest(method: 'GET', url: '/should/not/log');

  // Reset logger to default configuration
  AppLogger.instance.configure(config: const LoggerConfig());
  log.success('Logger restored to default active configurations.');
}
