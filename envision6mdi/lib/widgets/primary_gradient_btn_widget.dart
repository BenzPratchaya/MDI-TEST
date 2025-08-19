import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class PrimaryGradientButtonWidget extends StatelessWidget {
  const PrimaryGradientButtonWidget(
      {super.key,
      required this.onPressed,
      required this.title,
      this.iconData,
      this.maxWidth = 125,
      this.minHeight = 50,
      this.tooltip,
      this.isLightColor = false});
  final String title;
  final Function()? onPressed;
  final IconData? iconData;
  final double maxWidth;
  final double minHeight;
  final String? tooltip;
  final bool isLightColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? title,
      child: MaterialButton(
        onPressed: onPressed,
        splashColor: Colors.black12,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: Ink(
          width: MediaQuery.of(context).size.width > 400
              ? null
              : MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: isLightColor
                ? LinearGradient(
                    colors: [
                      EnvisionColor.ligthLineargradientColor2.withOpacity(0.8),
                      EnvisionColor.ligthLineargradientColor1.withOpacity(0.8),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : LinearGradient(
                    colors: [
                      EnvisionColor.lineargradientColor2.withOpacity(0.8),
                      EnvisionColor.lineargradientColor1.withOpacity(0.8),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
              constraints:
                  BoxConstraints(maxWidth: maxWidth, minHeight: minHeight),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconData != null)
                    Icon(
                      iconData,
                      color: EnvisionColor.primaryFontColor,
                    ),
                  if (iconData != null && maxWidth > 100)
                    const SizedBox(width: 10),
                  if (maxWidth > 100 || iconData == null)
                    Text(
                      title,
                      style: const TextStyle(
                          // fontSize: 18,
                          // fontWeight: FontWeight.w800,
                          color: EnvisionColor.defaultFontColor),
                    ),
                ],
              )),
        ),
      ),
    );
  }
}
