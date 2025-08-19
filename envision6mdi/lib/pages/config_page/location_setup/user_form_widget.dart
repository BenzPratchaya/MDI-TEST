import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../models/mdi/location_model.dart';
import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/input_entry_inline_field.dart';

class LocationFormWidget extends StatefulWidget {
  const LocationFormWidget(
      {super.key,
      required this.context,
      required this.model,
      required this.locationData,
      this.isEdit = false});
  final BuildContext context;
  final MdiConfigViewModel model;
  final Location locationData;
  final bool isEdit;

  @override
  State<LocationFormWidget> createState() => _LocationFormWidgetState();
}

class _LocationFormWidgetState extends State<LocationFormWidget> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: widget.isEdit
              ? const Text('Edit location')
              : const Text('Add location'),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              return ContainerWidget(
                height: height - 270,
                width: width - 270,
                // background: EnvisionColor.secondaryColor,
                child: Wrap(children: [
                  Wrap(children: [
                    InputEntryInlineFieldWidget(
                        headerWidth: 140,
                        maxWidth: 270,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'location Code',
                        value: widget.locationData.locationUid,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        headerWidth: 140,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'location Name',
                        value: widget.locationData.locationName,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        headerWidth: 140,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'location Desc',
                        value: widget.locationData.locationDesc,
                        valueChanged: (value) {}),
                  ]),
                  Wrap(children: [
                    InputEntryInlineFieldWidget(
                        inputType: 'checkbox',
                        maxWidth: 270 / 2,
                        isPassword: false,
                        title: 'Is Delete',
                        value: widget.locationData.isDeleted
                            .toString(), // == 1 ? true : false,
                        valueChanged: (value) {
                          setState(() {
                            widget.locationData.isDeleted = value ? 1 : 0;
                          });
                        }),
                  ]),
                ]),
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
                    'Cancel',
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
                  child: widget.isEdit
                      ? const Text(
                          'Save Edit location',
                          style: TextStyle(
                            color: EnvisionColor.colorGrey,
                          ),
                        )
                      : const Text(
                          'Save Add location',
                          style: TextStyle(
                            color: EnvisionColor.colorGrey,
                          ),
                        )),
            ),
          ],
        ));
  }
}
