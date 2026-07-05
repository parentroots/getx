import 'package:flutter/material.dart';
import 'package:getx_template/utils/app_log/app_logger.dart';

/// A [NavigatorObserver] that logs navigation flows, including pushes, pops,
/// replaces, and removals.
///
/// Also provides manual utility methods for logging navigation changes
/// from external routing packages (e.g. GetX, AutoRoute, or GoRouter).
class NavigationLogger extends NavigatorObserver {
  NavigationLogger();

  // ==========================================
  // NAVIGATOR OBSERVER OVERRIDES
  // ==========================================

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final from = previousRoute?.settings.name ?? 'Root';
    final to = route.settings.name ?? _getRouteDescription(route);
    logPush(to, from);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final popped = route.settings.name ?? _getRouteDescription(route);
    final current = previousRoute?.settings.name ?? 'Root';
    logPop(popped, current);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final replaced = oldRoute?.settings.name ?? 'Unknown';
    final replacement = newRoute?.settings.name ?? _getRouteDescription(newRoute);
    logReplace(replaced, replacement);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    final removed = route.settings.name ?? _getRouteDescription(route);
    logRemove(removed);
  }

  // ==========================================
  // MANUAL LOGGING UTILITY METHODS
  // ==========================================

  /// Logs a manual route PUSH.
  static void logPush(String toRoute, [String? fromRoute]) {
    final fromStr = fromRoute != null ? 'from $fromRoute ' : '';
    log.navigation('🧭 PUSH Route: $fromStr-> to "$toRoute"');
  }

  /// Logs a manual route POP.
  static void logPop(String poppedRoute, [String? targetRoute]) {
    final targetStr = targetRoute != null ? ' returning to "$targetRoute"' : '';
    log.navigation('🧭 POP Route: "$poppedRoute"$targetStr');
  }

  /// Logs a manual route REPLACE.
  static void logReplace(String oldRoute, String newRoute) {
    log.navigation('🧭 REPLACE Route: "$oldRoute" replaced with "$newRoute"');
  }

  /// Logs a manual route REMOVE.
  static void logRemove(String removedRoute) {
    log.navigation('🧭 REMOVE Route: "$removedRoute" removed from stack');
  }

  /// Logs the current route status directly.
  static void logCurrentRoute(String routeName) {
    log.navigation('🧭 Current Route: "$routeName"');
  }

  // ==========================================
  // HELPER METHODS
  // ==========================================

  /// Resolves a descriptive name for a route if the route settings name is empty.
  String _getRouteDescription(Route<dynamic>? route) {
    if (route == null) return 'None';
    return '${route.runtimeType}(hashCode: ${route.hashCode})';
  }
}
