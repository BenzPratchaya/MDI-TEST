import 'package:envision6mdi/helpers/constants.dart';
import 'package:flutter/material.dart';

import 'navdrawer_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  final Widget body;
  const ScaffoldWidget({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: EnvisionColor.colorGreen),
          // title: Text(
          //   'Order Food',
          //   style: Theme.of(context).textTheme.headline4?.copyWith(
          //         fontSize: 36,
          //         color: const Color(0xFFF64209),
          //         fontWeight: FontWeight.bold,
          //       ),
          // ),
          backgroundColor: EnvisionColor.primaryColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'ENVISION MDI',
                    style: TextStyle(
                        color: EnvisionColor.secondaryColor,
                        fontSize: EnvisionSize.largeFontSize),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Medical Device Interface',
                    style: TextStyle(
                        color: EnvisionColor.secondaryColor.withOpacity(0.2),
                        fontSize: EnvisionSize.defaultFontSize),
                  ),
                ],
              ),
              const Text('Miracle'),
            ],
          ),
        ),
        body: body);
  }
}
