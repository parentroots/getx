import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

/// A Singleton Socket Client that handles all WebSockets/Socket.IO connections.

class SocketClient {
  // Private constructor for singleton
  SocketClient._internal();

  // Singleton instance
  static final SocketClient _instance = SocketClient._internal();

  // Public getter for the instance
  static SocketClient get instance => _instance;

  io.Socket? _socket;
  
  // Connection state stream controller
  final _connectionStatusController = StreamController<bool>.broadcast();
  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  /// Initialize the Socket Client
  /// Connects to the provided URL with optional headers (like authorization token)
  void init({required String url, Map<String, dynamic>? headers}) {
    if (_socket != null && _socket!.connected) return;

    _socket = io.io(
      url,
      io.OptionBuilder()
          .setTransports(['websocket']) // Use WebSockets for performance
          .disableAutoConnect()         // Disable auto-connect to control the flow
          .setExtraHeaders(headers ?? {}) // Pass any required headers
          .build(),
    );

    _setupListeners();
  }

  /// Establishes the socket connection
  void connect() {
    if (_socket != null && !_socket!.connected) {
      _socket!.connect();
    }
  }

  /// Disconnects the socket connection
  void disconnect() {
    if (_socket != null && _socket!.connected) {
      _socket!.disconnect();
    }
  }

  /// Listen to a specific socket event
  void on(String event, Function(dynamic) handler) {
    _socket?.on(event, handler);
  }

  /// Remove a listener from a specific socket event
  void off(String event) {
    _socket?.off(event);
  }

  /// Emit data to a specific socket event
  void emit(String event, [dynamic data]) {
    _socket?.emit(event, data);
  }
  
  /// Emit data and wait for acknowledgment
  void emitWithAck(String event, dynamic data, Function(dynamic) ackHandler) {
    _socket?.emitWithAck(event, data, ack: ackHandler);
  }

  /// Setup global listeners for debugging and connection tracking
  void _setupListeners() {
    _socket?.onConnect((_) {
      if (kDebugMode) {
        print('Socket Connected: ${_socket?.id}');
      }
      _connectionStatusController.add(true);
    });

    _socket?.onDisconnect((_) {
      if (kDebugMode) {
        print('Socket Disconnected');
      }
      _connectionStatusController.add(false);
    });

    _socket?.onConnectError((error) {
      if (kDebugMode) {
        print('Socket Connect Error: $error');
      }
      _connectionStatusController.add(false);
    });

    _socket?.onError((error) {
      if (kDebugMode) {
        print('Socket Error: $error');
      }
    });
  }

  /// Clean up resources
  void dispose() {
    _connectionStatusController.close();
    _socket?.dispose();
    _socket = null;
  }
}
