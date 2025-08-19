import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../helpers/responsive.dart';

class RoundButtonWidget extends StatelessWidget {
  const RoundButtonWidget(
      {super.key,
      required this.title,
      required this.onTap,
      this.icon,
      this.maxWidth});
  final String title;
  final IconData? icon;
  final Function() onTap;
  final double? maxWidth;
  @override
  Widget build(BuildContext context) {
    var width = maxWidth ?? EnvisionSize.defaultInputWidth;
    return InkWell(
      onTap: onTap,
      child: Responsive.isDesktop(context)
          ? Container(
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: EnvisionColor.colorGreen,
                  borderRadius:
                      BorderRadius.circular(EnvisionSize.borderRadius)),
              child: icon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icon,
                          size: 24.0,
                          color: EnvisionColor.defaultFontColor,
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: EnvisionSize.mediumFontSize,
                            // fontWeight: FontWeight.w800,
                            color: EnvisionColor.defaultFontColor,
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: EnvisionSize.mediumFontSize,
                          // fontWeight: FontWeight.w800,
                          color: EnvisionColor.defaultFontColor,
                        ),
                      ),
                    ),
            )
          : Container(
              height: 50,
              width: MediaQuery.of(context).size.width >
                      EnvisionSize.defaultInputWidth
                  ? EnvisionSize.defaultInputWidth
                  : MediaQuery.of(context).size.width * 0.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: EnvisionColor.colorGreen,
                  borderRadius: BorderRadius.circular(32)),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: EnvisionSize.mediumFontSize,
                  // fontWeight: FontWeight.w800,
                  color: EnvisionColor.defaultFontColor,
                ),
              ),
            ),
    );
  }
}
