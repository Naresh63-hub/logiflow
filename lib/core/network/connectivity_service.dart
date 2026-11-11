import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { online, offline }

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final _controller = StreamController<NetworkStatus>.broadcast();

  ConnectivityService() {
    _init();
  }

  Stream<NetworkStatus> get statusStream => _controller.stream;

  Future<void> _init() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _controller.add(_mapResults(results));
    } catch (_) {
      _controller.add(NetworkStatus.online);
    }

    _connectivity.onConnectivityChanged.listen((results) {
      _controller.add(_mapResults(results));
    });
  }

  NetworkStatus _mapResults(List<ConnectivityResult> results) {
    if (results.isEmpty || results.every((r) => r == ConnectivityResult.none)) {
      return NetworkStatus.offline;
    }
    return NetworkStatus.online;
  }

  Future<bool> isConnected() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return _mapResults(results) == NetworkStatus.online;
    } catch (_) {
      return true;
    }
  }

  void dispose() {
    _controller.close();
  }
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
});

final networkStatusProvider = StreamProvider<NetworkStatus>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.statusStream;
});

final isOnlineProvider = Provider<bool>((ref) {
  final status = ref.watch(networkStatusProvider).valueOrNull;
  return status != NetworkStatus.offline;
});
