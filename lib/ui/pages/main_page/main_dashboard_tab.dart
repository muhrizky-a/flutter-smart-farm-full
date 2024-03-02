import 'package:flutter/material.dart';
import '../../constant.dart';
import '../camera_page.dart';

class MainDashboardTab extends StatefulWidget {
  const MainDashboardTab({super.key});

  @override
  State<MainDashboardTab> createState() => _MainDashboardTabState();
}

class _MainDashboardTabState extends State<MainDashboardTab> {
  Widget banner() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: const DecorationImage(
          image: AssetImage("assets/farm.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(padding),
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.25),
              Colors.black.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Kualitas Lahan Pertanian",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.greenAccent,
                      Colors.greenAccent.withOpacity(0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: const Text(
                  "Baik",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _box({
    required String title,
    required IconData icon,
    required void Function() onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: greenMainColor,
      ),
      child: Material(
        color: Colors.transparent,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(borderRadius),
        // ),
        child: InkWell(
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Icon(
                icon,
                size: 86,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logButton() => _box(
        title: "Log Kualitas Tanaman",
        icon: Icons.bar_chart,
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(padding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            banner(),
            const SizedBox(height: 16),
            const Text(
              "Fitur:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            logButton(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
