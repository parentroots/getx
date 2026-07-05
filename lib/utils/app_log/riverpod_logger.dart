import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getx_template/utils/app_log/app_logger.dart';

/// A Riverpod [ProviderObserver] that automatically monitors and logs state shifts.
///
/// Traces provider initialization, value transitions (before/after values),
/// object disposals, and asynchronous errors encountered within providers.
class RiverpodLogger extends ProviderObserver {
  const RiverpodLogger();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    final providerName = provider.name ?? provider.runtimeType.toString();
    log.d('Provider Initialized: $providerName\nValue: $value');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final providerName = provider.name ?? provider.runtimeType.toString();
    log.d(
      'Provider Updated: $providerName\n'
      'Old Value: $previousValue\n'
      'New Value: $newValue',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    final providerName = provider.name ?? provider.runtimeType.toString();
    log.d('Provider Disposed: $providerName');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    final providerName = provider.name ?? provider.runtimeType.toString();
    log.e(
      'Provider Failed: $providerName',
      error,
      stackTrace,
    );
  }
}
