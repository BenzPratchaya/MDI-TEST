import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../models/mdi/user_model.dart';
import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/input_entry_inline_field.dart';

class UserFormWidget extends StatefulWidget {
  const UserFormWidget(
      {super.key,
      required this.context,
      required this.model,
      required this.userData,
      this.isEdit = false});
  final BuildContext context;
  final MdiConfigViewModel model;
  final User userData;
  final bool isEdit;

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title:
              widget.isEdit ? const Text('Edit User') : const Text('Add User'),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              return ContainerWidget(
                height: height - 400,
                width: width - 400,
                // background: EnvisionColor.secondaryColor,
                child: Wrap(children: [
                  Wrap(children: [
                    InputEntryInlineFieldWidget(
                        maxWidth: 270 / 2,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'Title',
                        value: widget.userData.userTitle,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'Firstname',
                        value: widget.userData.userFName,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'Middlename',
                        value: widget.userData.userMName,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'Lastname',
                        value: widget.userData.userLName,
                        valueChanged: (value) {}),
                  ]),
                  Wrap(children: [
                    InputEntryInlineFieldWidget(
                        maxWidth: 270 / 2,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'Eng Title',
                        value: widget.userData.userTitleEng,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'Eng Firstname',
                        value: widget.userData.userFNameEng,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'Eng Middle',
                        value: widget.userData.userMNameEng,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        // isEnabled: false,
                        isPassword: false,
                        title: 'Eng Lastname',
                        value: widget.userData.userLNameEng,
                        valueChanged: (value) {}),
                  ]),
                  Wrap(children: [
                    InputEntryInlineFieldWidget(
                        maxWidth: 270 / 2,
                        isPassword: false,
                        title: 'User Code',
                        value: widget.userData.userUid,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        isPassword: false,
                        title: 'User Name',
                        value: widget.userData.userName,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        isPassword: true,
                        title: 'Password',
                        value: widget.userData.userPwd,
                        valueChanged: (value) {}),
                    InputEntryInlineFieldWidget(
                        maxWidth: 270,
                        isPassword: false,
                        title: 'User Type',
                        value: widget.userData.userType,
                        valueChanged: (value) {}),
                  ]),
                  Wrap(children: [
                    InputEntryInlineFieldWidget(
                        inputType: 'checkbox',
                        maxWidth: 270 / 2,
                        isPassword: false,
                        title: 'Is Delete',
                        value: widget.userData.isDeleted
                            .toString(), // == 1 ? true : false,
                        valueChanged: (value) {
                          setState(() {
                            widget.userData.isDeleted = value ? 1 : 0;
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
                          'Save Edit User',
                          style: TextStyle(
                            color: EnvisionColor.colorGrey,
                          ),
                        )
                      : const Text(
                          'Save Add User',
                          style: TextStyle(
                            color: EnvisionColor.colorGrey,
                          ),
                        )),
            ),
          ],
        ));
  }
}
