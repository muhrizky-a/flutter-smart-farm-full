import 'package:flutter/material.dart';

import '../constant.dart';

class CustomButtonCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;
  final Color color;

  const CustomButtonCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color = greenMainColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
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
}
