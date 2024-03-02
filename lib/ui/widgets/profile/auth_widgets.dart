import 'package:flutter/material.dart';
import '../../constant.dart';

mixin AuthWidgets {
  Widget authTitleSection(
    BuildContext context, {
    required String backgroundText,
    required String welcomeText,
    required String description,
  }) {
    double height = MediaQuery.of(context).size.height / 2;

    double backgroundTextSize = 96;
    int backgroundTextLength = backgroundText.length;
    double backgroundTextWidth = backgroundTextSize * backgroundTextLength;
    int multiplier = 1;

    while (MediaQuery.of(context).size.width >
        (backgroundTextWidth * multiplier)) {
      multiplier++;
    }

    Widget textBackground = Padding(
      padding: const EdgeInsets.only(left: padding * 2),
      child: Column(
        children: List.generate(
          4,
          (index) => Text(
            backgroundText * multiplier,
            overflow: TextOverflow.visible,
            maxLines: 1,
            style: TextStyle(
              height: 1,
              fontSize: backgroundTextSize,
              foreground: Paint()
                ..strokeWidth = 2
                ..color = const Color(0xFF90CAF9).withOpacity(0.2)
                ..style = PaintingStyle.stroke,
              fontWeight: FontWeight.w900,
              letterSpacing: 32,
            ),
          ),
        ),
      ),
    );

    Widget textTitles = Container(
      height: height,
      padding: const EdgeInsets.all(padding * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            welcomeText,
            style: const TextStyle(
              fontSize: 32,
              color: whiteMainColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: whiteMainColor,
            ),
          )
        ],
      ),
    );

    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.only(left: margin * 2),
      decoration: const BoxDecoration(
        color: greenMainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius * 4),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Wrap(
        children: [
          Stack(
            children: [
              textBackground,
              textTitles,
            ],
          ),
        ],
      ),
    );
  }
}
