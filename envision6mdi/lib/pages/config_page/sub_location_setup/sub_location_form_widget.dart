import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/responsive.dart';
import '../../../models/mdi/location_model.dart';
import '../../../models/mdi/organization_model.dart';
import '../../../models/mdi/sub_location_model.dart';
import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/dropdown_search_widget.dart';
import '../../../widgets/input_entry_inline_field.dart';

class SubLocationFormWidget extends StatefulWidget {
  const SubLocationFormWidget(
      {super.key,
      required this.context,
      required this.model,
      required this.subLocationData,
      this.isEdit = false,
      required this.onDataChanged});
  final BuildContext context;
  final MdiConfigViewModel model;
  final SubLocation subLocationData;
  final bool isEdit;
  final ValueChanged<List<SubLocation>> onDataChanged;

  @override
  State<SubLocationFormWidget> createState() => _SubLocationFormWidgetState();
}

class _SubLocationFormWidgetState extends State<SubLocationFormWidget> {
  final verticalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var selectLocationList = widget.model.locationList
        .where((e) => e.locationId == widget.model.subLocation.locationId)
        .toList();
    var selectLocation =
        selectLocationList.isNotEmpty ? selectLocationList.first : null;
    double inputwidth = 430;
    double headerWidth = 196;
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: widget.isEdit
              ? const Text('Edit Sublocation')
              : const Text('Add Sublocation'),
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
                          maxWidth: inputwidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'SubLocation Code',
                          value: widget.model.subLocation.subLocationUid,
                          valueChanged: (value) {
                            var subLocation = widget.model.subLocation;
                            subLocation.subLocationUid = value;
                            widget.model.setSubLocationData(subLocation);
                          }),
                      InputEntryInlineFieldWidget(
                          maxWidth: inputwidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'SubLocation Name',
                          value: widget.model.subLocation.subLocationName,
                          valueChanged: (value) {
                            var subLocation = widget.model.subLocation;
                            subLocation.subLocationName = value;
                            widget.model.setSubLocationData(subLocation);
                          }),
                      InputEntryInlineFieldWidget(
                          maxWidth: inputwidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'SubLocation Desc',
                          value: widget.model.subLocation.subLocationDesc,
                          valueChanged: (value) {
                            var subLocation = widget.model.subLocation;
                            subLocation.subLocationDesc = value;
                            widget.model.setSubLocationData(subLocation);
                          }),
                    ]),
                    Wrap(children: [
                      InputEntryInlineFieldWidget(
                          maxWidth: inputwidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'Building',
                          value: widget.model.subLocation.subLocationBuilding,
                          valueChanged: (value) {
                            var subLocation = widget.model.subLocation;
                            subLocation.subLocationBuilding = value;
                            widget.model.setSubLocationData(subLocation);
                          }),
                      InputEntryInlineFieldWidget(
                          maxWidth: inputwidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'Floor',
                          value: widget.model.subLocation.subLocationFloor,
                          valueChanged: (value) {
                            var subLocation = widget.model.subLocation;
                            subLocation.subLocationFloor = value;
                            widget.model.setSubLocationData(subLocation);
                          }),
                      InputEntryInlineFieldWidget(
                          maxWidth: inputwidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'Room',
                          value: widget.model.subLocation.subLocationRoom,
                          valueChanged: (value) {
                            var subLocation = widget.model.subLocation;
                            subLocation.subLocationRoom = value;
                            widget.model.setSubLocationData(subLocation);
                          }),
                    ]),
                    Wrap(children: [
                      SizedBox(
                        width: inputwidth,
                        child: Responsive.isMobile(context)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  const Text(
                                    'Location',
                                    style: EnvisionFormat.normalText,
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  DropdownListWidget(
                                    maxWidth: inputwidth - headerWidth,
                                    defaultText: 'Select Location',
                                    selectedItem: selectLocation,
                                    dropdownMenuItems: widget.model.locationList
                                        .map((Location items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items.locationName ??
                                            items.locationDesc ??
                                            ''),
                                      );
                                    }).toList(),
                                    onChanged: (location) {
                                      setState(() {
                                        selectLocation = location;
                                        var subLocation =
                                            widget.model.subLocation;
                                        subLocation.locationId =
                                            selectLocation?.locationId;
                                        widget.model
                                            .setSubLocationData(subLocation);
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 14,
                                        ),
                                        Text(
                                          'Location',
                                          style: EnvisionFormat.normalText,
                                        ),
                                        SizedBox(
                                          width: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownListWidget(
                                    maxWidth: inputwidth - headerWidth - 22,
                                    defaultText: 'Select Location',
                                    selectedItem: selectLocation,
                                    dropdownMenuItems: widget.model.locationList
                                        .map((Location items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items.locationName ??
                                            items.locationDesc ??
                                            ''),
                                      );
                                    }).toList(),
                                    onChanged: (location) {
                                      setState(() {
                                        selectLocation = location;
                                        var subLocation =
                                            widget.model.subLocation;
                                        subLocation.locationId =
                                            selectLocation?.locationId;
                                        widget.model
                                            .setSubLocationData(subLocation);
                                      });
                                    },
                                  ),
                                ],
                              ),
                      ),
                      orgSelect(headerWidth, inputwidth),
                      InputEntryInlineFieldWidget(
                          inputType: 'checkbox',
                          maxWidth: 270 / 2,
                          isPassword: false,
                          title: 'Is Delete',
                          value: widget.model.subLocation.isDeleted
                              .toString(), // == 1 ? true : false,
                          valueChanged: (value) {
                            setState(() {
                              // widget.model.subLocation.isDeleted = value ? 1 : 0;
                              var subLocation = widget.model.subLocation;
                              subLocation.isDeleted = value ? 1 : 0;
                              widget.model.setSubLocationData(subLocation);
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
                        _showConfirmDialog(
                            context, 'Save Edit SubLocation ?', '', () {
                          widget.model.updateSubLocation().then((value) {
                            if (value.acknowledgementCode == 'AA') {
                              widget.model.getSelectSubLocationView().then(
                                  (value) => {
                                        widget.onDataChanged(
                                            widget.model.subLocationList)
                                      });
                            }
                            _showAlertDialog(
                                context,
                                value.acknowledgementCode == 'AA'
                                    ? 'Success Edit SubLocation'
                                    : 'Fail To Edit SubLocation',
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
                        _showConfirmDialog(
                            context, 'Save New SubLocation ?', '', () {
                          widget.model.insertSubLocation().then((value) {
                            var header = '';
                            var datail = value.acknowledgementCode == 'AA'
                                ? 'Success'
                                : '${value.acknowledgementCode} : ${value.textMessage}';
                            if (value.acknowledgementCode == 'AA') {
                              header = 'Success Add New SubLocation';
                              widget.model.getSelectSubLocationView().then(
                                  (value) => {
                                        widget.onDataChanged(
                                            widget.model.subLocationList)
                                      });
                            } else {
                              header = 'Fail To Add New SubLocation';
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
        .where(
            (e) => e.organizationId == widget.model.subLocation.organizationId)
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
                  isEnabled: false,
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
                      var subLocation = widget.model.subLocation;
                      subLocation.organizationId =
                          selectOrganization?.organizationId;
                      widget.model.setSubLocationData(subLocation);
                    });
                  },
                ),
              ],
            )
          : Row(
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
                  isEnabled: false,
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
                      var subLocation = widget.model.subLocation;
                      subLocation.organizationId =
                          selectOrganization?.organizationId;
                      widget.model.setSubLocationData(subLocation);
                    });
                  },
                ),
              ],
            ),
    );
  }
}
