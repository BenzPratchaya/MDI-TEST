import 'dart:ui';

import 'package:envision6mdi/helpers/constants.dart';
import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:envision6mdi/modelviews/mdi_view_model.dart';
import 'package:envision6mdi/widgets/container_scroll_widget.dart';
import 'package:flutter/material.dart';

class MdiFormReconcile extends StatelessWidget {
  const MdiFormReconcile(
      {super.key,
      required this.context,
      required this.model,
      required this.mdiData});
  final BuildContext context;
  final MdiViewModel model;
  final MdiDataViewModel mdiData;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Row(
            children: [
              const Text('Save by'),
              const SizedBox(
                width: EnvisionSize.cardPadding,
              ),
              TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(EnvisionColor.colorGreen),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Colors.red)
                      ))),
                  child: const Text(
                    'Study',
                    style: TextStyle(color: EnvisionColor.colorGrey),
                  )),
              const SizedBox(
                width: EnvisionSize.cardPadding,
              ),
              TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(EnvisionColor.colorGrey),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Colors.red)
                      ))),
                  child: const Text(
                    'Patient',
                    style: TextStyle(color: EnvisionColor.primaryColor),
                  )),
            ],
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              return SizedBox(
                height: height - 400,
                width: width - 400,
                child: detail(),
              );
            },
          ),
          actions: <Widget>[
            SizedBox(
              height: 40,
              width: 150,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(EnvisionColor.colorGrey),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Colors.red)
                      ))),
                  child: const Text(
                    'Close',
                    style: TextStyle(color: EnvisionColor.primaryColor),
                  )),
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(EnvisionColor.colorGreen),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Colors.red)
                      ))),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: EnvisionColor.colorGrey,
                    ),
                  )),
            ),
          ],
        ));
  }

  Widget detail() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ContainerScrollWidget(
            alignment: Alignment.topLeft,
            background: EnvisionColor.colorGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(spacing: 15.0, runSpacing: 10.0, children: <Widget>[
                  chipWord('HN', mdiData.hn!),
                ]),
                Wrap(spacing: 15.0, runSpacing: 10.0, children: <Widget>[
                  chipWord('Patient Name', mdiData.patientName!),
                ]),
                Wrap(spacing: 15.0, runSpacing: 10.0, children: <Widget>[
                  chipWord('Patient Name', mdiData.patientName!),
                ]),
                Wrap(spacing: 15.0, runSpacing: 10.0, children: <Widget>[
                  chipWord('Gender', mdiData.patientGenderText!),
                  chipWord('Date Of Birth', mdiData.patientDob.toString()),
                  // chipWord('SSN', mdiData.patientSsn!),
                ]),
              ],
            )),
        ContainerScrollWidget(
          alignment: Alignment.topLeft,
          child: const Text('data'),
        )
      ],
    );
  }

  Widget chipWord(String header, String text) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
              text: '$header : ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: text,
          ),
        ],
      ),
    );
  }
}
