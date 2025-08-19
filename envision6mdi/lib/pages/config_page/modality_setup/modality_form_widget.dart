import 'dart:ui';

import 'package:envision6mdi/models/mdi/location_model.dart';
import 'package:flutter/material.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/responsive.dart';
import '../../../models/mdi/modality_model.dart';
import '../../../models/mdi/organization_model.dart';
import '../../../models/mdi/sub_location_model.dart';
import '../../../modelviews/modality_config_view_model.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/dropdown_search_widget.dart';
import '../../../widgets/input_entry_inline_field.dart';

class ModalityFormWidget extends StatefulWidget {
  const ModalityFormWidget(
      {super.key,
      required this.context,
      required this.model,
      // required this.modalityData,
      this.isEdit = false,
      required this.onDataChanged});
  final BuildContext context;
  final ModalityConfigViewModel model;
  // final Modality modalityData;
  final bool isEdit;
  final ValueChanged<List<Modality>> onDataChanged;

  @override
  State<ModalityFormWidget> createState() => _ModalityFormWidgetState();
}

class _ModalityFormWidgetState extends State<ModalityFormWidget> {
  final verticalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var selectLocationList = widget.model.locationList
        .where((e) => e.locationId == widget.model.modality.locationId)
        .toList();
    var selectLocation =
        selectLocationList.isNotEmpty ? selectLocationList.first : null;
    var selectSubLocationList = widget.model.subLocationSelectedList
        .where((e) => e.subLocationId == widget.model.modality.subLocationId)
        .toList();
    var selectSubLocation =
        selectSubLocationList.isNotEmpty ? selectSubLocationList.first : null;
    double inputwidth = 430;
    double headerWidth = 196;
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: widget.isEdit
              ? const Text('Edit Modality')
              : const Text('Add Modality'),
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
                          headerWidth: 196,
                          // isEnabled: widget.isEdit ? false : true,
                          isPassword: false,
                          title: 'Modality Code',
                          value: widget.model.modality.modalityUid,
                          valueChanged: (value) {
                            var modality = widget.model.modality;
                            modality.modalityUid = value;
                            widget.model.setModalityData(modality);
                          }),
                      InputEntryInlineFieldWidget(
                          maxWidth: inputwidth,
                          headerWidth: 196,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'Modality Name',
                          value: widget.model.modality.modalityName,
                          valueChanged: (value) {
                            var modality = widget.model.modality;
                            modality.modalityName = value;
                            widget.model.setModalityData(modality);
                          }),
                      InputEntryInlineFieldWidget(
                          maxWidth: inputwidth,
                          headerWidth: 196,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'Modality Type',
                          value: widget.model.modality.modalityTypeAlias,
                          valueChanged: (value) {
                            var modality = widget.model.modality;
                            modality.modalityTypeAlias = value;
                            widget.model.setModalityData(modality);
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
                                  const Text('Default Location'),
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
                                        var modality = widget.model.modality;
                                        modality.locationId =
                                            selectLocation?.locationId;
                                        widget.model.setModalityData(modality);
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
                                    'Default Location',
                                    style: EnvisionFormat.normalText,
                                  ),
                                  const SizedBox(
                                    width: 14,
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
                                        var modality = widget.model.modality;
                                        modality.locationId =
                                            selectLocation?.locationId;
                                        widget.model.setModalityData(modality);
                                      });
                                    },
                                  ),
                                ],
                              ),
                      ),
                      widget.model.modality.locationId != null
                          ? SizedBox(
                              width: inputwidth,
                              child: Responsive.isMobile(context)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        const Text(
                                          'Default SubLocation',
                                          style: EnvisionFormat.normalText,
                                        ),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        DropdownListWidget(
                                          maxWidth:
                                              inputwidth - headerWidth - 22,
                                          defaultText: 'Select SubLocation',
                                          selectedItem: selectSubLocation,
                                          dropdownMenuItems: widget
                                              .model.subLocationSelectedList
                                              .map((SubLocation item) {
                                            return DropdownMenuItem(
                                              value: item,
                                              child: Text(
                                                  item.subLocationDesc ??
                                                      item.subLocationName ??
                                                      ''),
                                            );
                                          }).toList(),
                                          onChanged: (subLocation) {
                                            setState(() {
                                              selectSubLocation = subLocation;
                                              var modality =
                                                  widget.model.modality;
                                              modality.subLocationId =
                                                  selectSubLocation
                                                      ?.subLocationId;
                                              widget.model
                                                  .setModalityData(modality);
                                            });
                                          },
                                        )
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        const Text(
                                          'Default SubLocation',
                                          style: EnvisionFormat.normalText,
                                        ),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        DropdownListWidget(
                                          maxWidth:
                                              inputwidth - headerWidth - 22,
                                          defaultText: 'Select SubLocation',
                                          selectedItem: selectSubLocation,
                                          dropdownMenuItems: widget
                                              .model.subLocationSelectedList
                                              .map((SubLocation item) {
                                            return DropdownMenuItem(
                                              value: item,
                                              child: Text(
                                                  item.subLocationDesc ??
                                                      item.subLocationName ??
                                                      ''),
                                            );
                                          }).toList(),
                                          onChanged: (subLocation) {
                                            setState(() {
                                              selectSubLocation = subLocation;
                                              var modality =
                                                  widget.model.modality;
                                              modality.subLocationId =
                                                  selectSubLocation
                                                      ?.subLocationId;
                                              widget.model
                                                  .setModalityData(modality);
                                            });
                                          },
                                        )
                                      ],
                                    ),
                            )
                          : SizedBox(
                              width: inputwidth,
                            ),
                      InputEntryInlineFieldWidget(
                          maxWidth: inputwidth,
                          headerWidth: headerWidth,
                          // isEnabled: false,
                          isPassword: false,
                          title: 'Modality Host',
                          value: widget.model.modality.modalityHost,
                          valueChanged: (value) {
                            var modality = widget.model.modality;
                            modality.modalityHost = value;
                            widget.model.setModalityData(modality);
                          }),
                    ]),
                    Wrap(children: [
                      orgSelect(headerWidth, inputwidth),
                      InputEntryInlineFieldWidget(
                          inputType: 'checkbox',
                          headerWidth: 136,
                          maxWidth: inputwidth / 2,
                          isPassword: false,
                          title: 'Auto Confirm',
                          value: widget.model.modality.autoConfirm
                              .toString(), // == 1 ? true : false,
                          valueChanged: (value) {
                            setState(() {
                              var modality = widget.model.modality;
                              modality.autoConfirm = value ? 1 : 0;
                              widget.model.setModalityData(modality);
                            });
                          }),
                      InputEntryInlineFieldWidget(
                          inputType: 'checkbox',
                          maxWidth: inputwidth / 2,
                          isPassword: false,
                          title: 'Is Delete',
                          value: widget.model.modality.isDeleted
                              .toString(), // == 1 ? true : false,
                          valueChanged: (value) {
                            setState(() {
                              var modality = widget.model.modality;
                              modality.isDeleted = value ? 1 : 0;
                              widget.model.setModalityData(modality);
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
                        _showConfirmDialog(context, 'Save Edit Modality ?', '',
                            () {
                          widget.model.updateModality().then((value) {
                            var header = '';
                            var datail = value.acknowledgementCode == 'AA'
                                ? 'Success'
                                : '${value.acknowledgementCode} : ${value.textMessage}';
                            if (value.acknowledgementCode == 'AA') {
                              header = 'Success Edit Modality';
                              widget.model.getSelectModalityView().then(
                                  (value) => {
                                        widget.onDataChanged(
                                            widget.model.modalityList)
                                      });
                            } else {
                              header = 'Fail To Edit Modality';
                            }
                            _showAlertDialog(context, header, datail);
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
                        _showConfirmDialog(context, 'Save New Modality ?', '',
                            () {
                          widget.model
                              .insertModality()
                              // widget.model.data.isConfirmed = 0;
                              // widget.model
                              //     .setConfirmData(widget.model.data, 1)
                              .then((value) {
                            var header = '';
                            var datail = value.acknowledgementCode == 'AA'
                                ? 'Success'
                                : '${value.acknowledgementCode} : ${value.textMessage}';
                            if (value.acknowledgementCode == 'AA') {
                              header = 'Success Add New Modality';
                              widget.model.getSelectModalityView().then(
                                  (value) => {
                                        widget.onDataChanged(
                                            widget.model.modalityList)
                                      });
                            } else {
                              header = 'Fail To Add New Modality';
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
        .where((e) => e.organizationId == widget.model.modality.organizationId)
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
                  maxWidth: inputWidth - headerWidth,
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
                      var modality = widget.model.modality;
                      modality.organizationId =
                          selectOrganization?.organizationId;
                      widget.model.setModalityData(modality);
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
                      var modality = widget.model.modality;
                      modality.organizationId =
                          selectOrganization?.organizationId;
                      widget.model.setModalityData(modality);
                    });
                  },
                ),
              ],
            ),
    );
  }
}
