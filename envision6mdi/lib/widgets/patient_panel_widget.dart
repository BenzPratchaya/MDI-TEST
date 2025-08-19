import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/constants.dart';
import '../models/common/patient_model.dart';

class PatientPanelWidget extends StatelessWidget {
  final PatientModel? patient;
  final bool? isVisit;
  final bool? isUpload;
  final String? vn;
  final String? visitId;
  final String? encType;
  final DateTime? visitDate;
  const PatientPanelWidget(
      {super.key,
      this.patient,
      this.isVisit = false,
      this.isUpload = false,
      this.vn,
      this.visitId,
      this.encType,
      this.visitDate});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(EnvisionSize.inputPadding),
        height: isVisit! || isUpload! ? 185 : 154,
        decoration: BoxDecoration(
          color: EnvisionColor.primaryColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: const Color(0xFFA4A6B3).withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 32 + 12,
                      backgroundColor: EnvisionColor.themeColor,
                      child: CircleAvatar(
                        radius: 32 + 10,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 32,
                          backgroundImage: AssetImage(
                              '${patient!.Picture ?? 'images/user.png'}'),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0.5,
                      bottom: 0.5,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: EnvisionColor.themeColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: EnvisionSize.cardPadding),
            Expanded(
                // alignment: Alignment.center,
                child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textInfo('HN : ', patient!.hn ?? ' - '),
                    const SizedBox(height: EnvisionSize.inputPadding),
                    textInfo(
                        'DOB : ',
                        patient!.DOB == null
                            ? ' - '
                            : DateFormat(EnvisionFormat.displayFormattedDate)
                                .format(patient!.DOB as DateTime)),
                    const SizedBox(height: EnvisionSize.inputPadding),
                    isVisit! ? textInfo('VN : ', vn ?? ' - ') : const SizedBox()
                  ],
                ),
                const SizedBox(width: EnvisionSize.cardPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textInfo('Gender : ', patient!.Gender ?? ' - '),
                    const SizedBox(height: EnvisionSize.inputPadding),
                    textInfo('Age : ', '${patient!.Age ?? ' - '}'),
                  ],
                ),
                const SizedBox(width: EnvisionSize.cardPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textInfo('Name : ',
                        '${patient!.Fname ?? ' - '} ${patient!.Mname ?? ''} ${patient!.Lname ?? ''}'),
                    const SizedBox(height: EnvisionSize.inputPadding),
                    textInfo('phone : ', patient!.Phone1 ?? ' - '),
                  ],
                ),
                const SizedBox(width: EnvisionSize.cardPadding),
                isUpload!
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textInfo('Visit ID : ', visitId ?? ''),
                          const SizedBox(height: EnvisionSize.inputPadding),
                          textInfo('Enc Type : ', encType ?? ''),
                          const SizedBox(height: EnvisionSize.inputPadding),
                          textInfo(
                              'Visit Date : ',
                              DateFormat(EnvisionFormat.displayFormattedDate)
                                  .format(visitDate as DateTime)),
                        ],
                      )
                    : const SizedBox()
              ],
            ))
          ],
        ));
  }

  Widget textInfo(String header, String value) {
    return Row(
      children: [
        Text(
          header,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: EnvisionColor.defaultFontColor,
              fontSize: EnvisionSize.largeFontSize),
        ),
        Text(
          value,
          style: const TextStyle(
              color: EnvisionColor.defaultFontColor,
              fontSize: EnvisionSize.largeFontSize),
        ),
      ],
    );
  }
}
