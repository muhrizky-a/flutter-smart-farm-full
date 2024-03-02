import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../widgets/sensor_status_card.dart';

class MainMonitoringTab extends StatefulWidget {
  const MainMonitoringTab({super.key});

  @override
  State<MainMonitoringTab> createState() => _MainMonitoringTabState();
}

class _MainMonitoringTabState extends State<MainMonitoringTab> {
  @override
  void initState() {
    super.initState();
    debugPrint("init");
    // _channel.stream.listen((message) {
    //   debugPrint("message listened: $message");
    // }).onError((e) {
    //   debugPrint("error: $e");
    // });
    debugPrint("init done");
  }

  @override
  void dispose() {
    debugPrint("disposing...");
    // _channel.sink.close();

    super.dispose();
  }

  Widget weather() {
    return Container(
      // height: 200,
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.greenAccent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cuaca",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.sunny,
                    size: 28,
                  ),
                  Text(
                    "Rabu",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "30",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.cloud,
                    size: 28,
                  ),
                  Text(
                    "Kamis",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "30",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.water_drop,
                    size: 28,
                  ),
                  Text(
                    "Jum'at",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "30",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget monitoring() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: 2,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        SensorStatusCard(
          title: "Kelembaban Tanah",
          value: "11%",
          imageUrl: "assets/soil-moisture.png",
          backgroundColor: greenMainColor,
        ),
        SensorStatusCard(
          title: "Suhu Udara",
          value: "22",
          imageUrl: "assets/temperature.png",
          backgroundColor: greenMainColor,
        ),
        SensorStatusCard(
          title: "Kelembaban Udara",
          value: "33 RH",
          imageUrl: "assets/humidity.png",
          backgroundColor: greenMainColor,
        ),
        SensorStatusCard(
          title: "pH Tanah",
          value: "44 pH",
          imageUrl: "assets/soil-ph.png",
          backgroundColor: greenMainColor,
        ),
      ],
    );
  }

  Widget cameraMonitoring() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: greenMainColor,
      ),
      child: const Text(
        "CCTV",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(padding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // StreamBuilder(
            //   stream: _channel.stream,
            //   builder: (context, snapshot) {
            //     debugPrint("${snapshot.connectionState}");
            //     debugPrint("${snapshot.hasData}");
            //     debugPrint("${snapshot.hasError}");

            //     return Text(
            //       snapshot.hasData ? '${snapshot.data}' : 'empty',
            //       style: const TextStyle(
            //         color: Colors.black,
            //       ),
            //     );
            //   },
            // ),

            weather(),
            const SizedBox(height: 8),
            monitoring(),
            const SizedBox(height: 8),
            cameraMonitoring(),
          ],
        ),
      ),
    );
  }
}
