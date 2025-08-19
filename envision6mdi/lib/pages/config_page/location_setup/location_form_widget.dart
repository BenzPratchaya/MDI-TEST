import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
// import '../../../models/mdi/location_model.dart';
import '../../../helpers/responsive.dart';
import '../../../models/mdi/location_model.dart';
import '../../../models/mdi/organization_model.dart';
import '../../../modelviews/location_config_view_model.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/dropdown_search_widget.dart';
import '../../../widgets/input_entry_inline_field.dart';

class LocationFormWidget extends StatefulWidget {
  const LocationFormWidget(
      {super.key,
      required this.context,
      required this.model,
      required this.locationData,
      this.isEdit = false,
      required this.onDataChanged});
  final BuildContext context;
  final LocationConfigViewModel model;
  final Location locationData;
  final bool isEdit;
  final ValueChanged<List<Location>> onDataChanged;

  @override
  State<LocationFormWidget> createState() => _LocationFormWidgetState();
}

class _LocationFormWidgetState extends State<LocationFormWidget> {
  final verticalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // var selectLocationList = widget.model.locationList
    //     .where((e) => e.locationId == widget.model.location.locationId)
    //     .toList();
    // var selectLocation =
    //     selectLocationList.isNotEmpty ? selectLocationList.first : null;
    double inputWidth = 430;
    double headerWidth = 196;
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
                height: Responsive.isDesktop(context) ? height - 270 : height,
                width: Responsive.isDesktop(context) ? width - 270 : width,
                // background: EnvisionColor.secondaryColor,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: verticalScrollController,
                  child: Wrap(children: [
                    Wrap(children: [
                      InputEntryInlineFieldWidget(
                          maxWidth: inputWidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'Location Code',
                          value: widget.model.location.locationUid,
                          valueChanged: (value) {
                            var location = widget.model.location;
                            location.locationUid = value;
                            widget.model.setLocationData(location);
                          }),
                      InputEntryInlineFieldWidget(
                          maxWidth: inputWidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'Location Name',
                          value: widget.model.location.locationName,
                          valueChanged: (value) {
                            var location = widget.model.location;
                            location.locationName = value;
                            widget.model.setLocationData(location);
                          }),
                      InputEntryInlineFieldWidget(
                          maxWidth: inputWidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'Location Desc',
                          value: widget.model.location.locationDesc,
                          valueChanged: (value) {
                            var location = widget.model.location;
                            location.locationDesc = value;
                            widget.model.setLocationData(location);
                          }),
                    ]),
                    Wrap(children: [
                      orgSelect(headerWidth, inputWidth),
                      InputEntryInlineFieldWidget(
                          inputType: 'checkbox',
                          maxWidth: 270 / 2,
                          isPassword: false,
                          title: 'Is Delete',
                          value: widget.model.location.isDeleted
                              .toString(), // == 1 ? true : false,
                          valueChanged: (value) {
                            setState(() {
                              // widget.model.location.isDeleted = value ? 1 : 0;
                              var location = widget.model.location;
                              location.isDeleted = value ? 1 : 0;
                              widget.model.setLocationData(location);
                            });
                          }),
                    ]),
                  ]),
                ),
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
              child: widget.isEdit
                  ? TextButton(
                      onPressed: () {
                        _showConfirmDialog(context, 'Save Edit Location ?', '',
                            () {
                          widget.model.updateLocation().then((value) {
                            if (value.acknowledgementCode == 'AA') {
                              widget.model.getSelectLocationView().then(
                                  (value) => {
                                        widget.onDataChanged(
                                            widget.model.locationList)
                                      });
                            }
                            _showAlertDialog(
                                context,
                                value.acknowledgementCode == 'AA'
                                    ? 'Success Edit Location'
                                    : 'Fail To Edit Location',
                                value.acknowledgementCode == 'AA'
                                    ? 'Success'
                                    : '${value.acknowledgementCode} : ${value.textMessage}');
                          });
                          Navigator.pop(context, 'Save Edit');
                          Navigator.pop(context, 'OK');
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(EnvisionColor.colorGreen),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            // side: BorderSide(color: Colors.red)
                          ))),
                      child: const Text(
                        'Save Edit',
                        style: TextStyle(
                          color: EnvisionColor.colorGrey,
                        ),
                      ))
                  : TextButton(
                      onPressed: () {
                        _showConfirmDialog(context, 'Save New Location ?', '',
                            () {
                          widget.model.insertLocation().then((value) {
                            var header = '';
                            var datail = value.acknowledgementCode == 'AA'
                                ? 'Success'
                                : '${value.acknowledgementCode} : ${value.textMessage}';
                            if (value.acknowledgementCode == 'AA') {
                              header = 'Success Add New Location';
                              widget.model.getSelectLocationView().then(
                                  (value) => {
                                        widget.onDataChanged(
                                            widget.model.locationList)
                                      });
                            } else {
                              header = 'Fail To Add New Location';
                            }
                            _showAlertDialog(context, header, datail);
                          });
                          Navigator.pop(context, 'Save');
                          Navigator.pop(context, 'OK');
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(EnvisionColor.colorGreen),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
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

  _showConfirmDialog(
      context, String header, String content, Function()? onConfirm) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(header),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => {Navigator.pop(context, 'Cancel')},
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: onConfirm,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  _showAlertDialog(context, String header, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(header),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => {Navigator.pop(context, 'OK')},
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget orgSelect(headerWidth, inputWidth) {
    var selectorganizationList = widget.model.organizationList
        .where((e) => e.organizationId == widget.model.location.organizationId)
        .toList();
    var selectOrganization =
        selectorganizationList.isNotEmpty ? selectorganizationList.first : null;
    return SizedBox(
      width: inputWidth,
      child: Responsive.isMobile(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 14,
                ),
                const Text(
                  'Organization',
                  style: EnvisionFormat.normalText,
                ),
                const SizedBox(
                  width: 14,
                ),
                DropdownListWidget(
                  // isEnabled: false,
                  maxWidth: 250,
                  defaultText: 'Select Organization',
                  selectedItem: selectOrganization,
                  dropdownMenuItems:
                      widget.model.organizationList.map((Organization items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items.organizationName ??
                          items.organizationAlias ??
                          ''),
                    );
                  }).toList(),
                  onChanged: (organization) {
                    setState(() {
                      selectOrganization = organization;
                      var location = widget.model.location;
                      location.organizationId =
                          selectOrganization?.organizationId;
                      widget.model.setLocationData(location);
                    });
                  },
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: headerWidth,
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        'Organization',
                        style: EnvisionFormat.normalText,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                    ],
                  ),
                ),
                DropdownListWidget(
                  // isEnabled: false,
                  maxWidth: inputWidth - headerWidth - 22,
                  defaultText: 'Select Organization',
                  selectedItem: selectOrganization,
                  dropdownMenuItems:
                      widget.model.organizationList.map((Organization items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items.organizationName ??
                          items.organizationAlias ??
                          ''),
                    );
                  }).toList(),
                  onChanged: (organization) {
                    setState(() {
                      selectOrganization = organization;
                      var location = widget.model.location;
                      location.organizationId =
                          selectOrganization?.organizationId;
                      widget.model.setLocationData(location);
                    });
                  },
                ),
              ],
            ),
    );
  }
}
