import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../widgets/sensor_control_card.dart';

class MainControlTab extends StatefulWidget {
  const MainControlTab({super.key});

  @override
  State<MainControlTab> createState() => _MainControlTabState();
}

class _MainControlTabState extends State<MainControlTab> {
  Widget farmSuggestions() {
    return Container(
      width: double.infinity,
      // height: 200,
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.greenAccent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Saran",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Kebun anda butuh sedikit air",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget control() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: 2,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SensorControlCard(
          title: "Sprinkle Air",
          value: "ON",
          backgroundColor: greenMainColor,
          onTap: () {},
        ),
        SensorControlCard(
          title: "Lampu",
          value: "OFF",
          backgroundColor: Colors.redAccent,
          onTap: () {},
        )
      ],
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
            farmSuggestions(),
            const SizedBox(height: 8),
            control(),
          ],
        ),
      ),
    );
  }
}
