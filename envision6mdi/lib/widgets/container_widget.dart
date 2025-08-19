import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget(
      {super.key,
      required this.child,
      this.background,
      this.borderRadius,
      this.width,
      this.height,
      this.alignment,
      this.title = ''});
  final Widget child;
  final Color? background;
  final double? borderRadius;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Stack(children: [
        Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height,
          alignment: alignment ?? Alignment.center,
          padding: const EdgeInsets.fromLTRB(
            EnvisionSize.cardPadding,
            EnvisionSize.cardPadding,
            EnvisionSize.cardPadding,
            EnvisionSize.textPadding,
          ),
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: EnvisionColor.colorGrey),
            color: background ?? Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: const Color(0xFFA4A6B3).withOpacity(.1),
                  blurRadius: 12)
            ],
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
          child: child,
        ),
        Positioned(
            left: 50,
            top: -5,
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                color: title == '' ? Colors.blue.withOpacity(0) : Colors.white,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 155, 155, 155)),
                ))),
      ]),
    );
  }
}
