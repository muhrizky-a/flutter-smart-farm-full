import 'package:flutter/foundation.dart';
import 'api_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class SocketIOService extends APIService {
  late final socketio.Socket socket;

  SocketIOService() {
    debugPrint("init socket.io");

    socket = socketio.io(super.API_BASE_URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      debugPrint('socket.io Connection established');
    });
    socket
        .onDisconnect((_) => debugPrint(' socket.io Connection Disconnection'));
    socket.onConnectError((err) {
      debugPrint("Socket Connection Error:");
      debugPrint(err.toString());
      socket.connect();
    });
    socket.onError((err) {
      debugPrint("Socket Error:");
      debugPrint(err.toString());
      socket.connect();
    });
    socket.connect();
  }

  void handleEvent({
    required String event,
    required Function(dynamic data) handler,
  }) {
    socket.on(event, handler);
  }

  void emit({required String event, dynamic data}) {
    socket.emit(event, data);
  }

  void connect() => socket.connect();
  bool isConnected() => socket.connected;

  void dispose() {
    socket.close();
    socket.disconnect();
    socket.dispose();
  }
}
