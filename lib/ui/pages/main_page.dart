import 'package:flutter/material.dart';
import '../constant.dart';
// import '../pages/settings_page.dart';
import '../widgets/custom_button_card.dart';
import 'camera_page.dart';
import 'device_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget deviceButton() => CustomButtonCard(
        title: "Device",
        icon: Icons.device_hub,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) => const DevicePage(),
            ),
          );
        },
      );

  Widget diseaseDetectionButton() => CustomButtonCard(
      title: "Deteksi Penyakit Tanaman",
      icon: Icons.camera_alt,
      color: Colors.amber,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CameraPage(),
          ),
        );
      });
  Widget ecommerceButton() => CustomButtonCard(
      title: "Jual hasil Pertanian Anda ",
      icon: Icons.shopping_cart,
      color: Colors.blue,
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const CameraPage(),
        //   ),
        // );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenMainColor,
        title: const Text("AgroSense"),
        actions: [
          Tooltip(
            message: "Tambah Device",
            child: IconButton(
              tooltip: "Tambah Device",
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (c) => const CameraPage(),
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(padding * 2),
          child: Column(
            children: [
              deviceButton(),
              const SizedBox(height: 8),
              diseaseDetectionButton(),
              const SizedBox(height: 8),
              ecommerceButton(),
            ],
          ),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        children: const [
          ListTile(title: Text("Settings")),
          ListTile(title: Text("Logout")),
        ],
      )),
    );
  }
}
