import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import '../../models/farm_monitoring_data.dart';

import '../base/socket_io_service.dart';

class FarmDataMonitoringService {
  final SocketIOService service;
  FarmDataMonitoringService(this.service);

  final String event = "farm-monitoring";

  void getData({required Function(FarmMonitoringData) onDataReceived}) {
    service.handleEvent(
      event: event,
      handler: (data) async {
        ReceivePort port = ReceivePort();

        final isolate = await Isolate.spawn<List<dynamic>>(
          (List<dynamic> values) {
            SendPort sendPort = values[0];
            dynamic data = values[1];
            sendPort.send(data);
          },
          [port.sendPort, data],
        );

        final isolatedData = await port.first;
        debugPrint("isolated data: $isolatedData");

        try {
          Map<String, dynamic> decodedData =
              isolatedData is Map<String, dynamic>
                  ? isolatedData
                  : jsonDecode(isolatedData);

          data = FarmMonitoringData.fromJson(decodedData);
          onDataReceived(data);
          // if (decodedData.containsKey("status")) {
          //   try {
          //     data = FarmMonitoringData.fromJson(decodedData);
          //     onDataReceived(data);
          //   } catch (e) {
          //     debugPrint(e.toString());
          //   }
          // }
        } catch (e) {
          debugPrint(e.toString());
        }

        isolate.kill(priority: Isolate.immediate);
      },
    );
  }

  void emit(FarmMonitoringData data) {
    service.emit(event: event, data: jsonEncode(data.toJson()));
  }

  void connect() => service.connect();
  void dispose() => service.dispose();
}
