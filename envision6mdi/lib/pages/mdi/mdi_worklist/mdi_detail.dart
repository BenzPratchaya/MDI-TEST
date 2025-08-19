import 'dart:ui';

import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../helpers/constants.dart';
import '../../../models/mdi/mdi_data_log_model.dart';
import '../../../modelviews/mdi_view_model.dart';

class MdiDetail extends StatefulWidget {
  const MdiDetail(
      {super.key,
      required this.context,
      required this.model,
      required this.mdiData});
  final BuildContext context;
  final MdiViewModel model;
  final MdiDataViewModel mdiData;

  @override
  State<MdiDetail> createState() => _MdiDetailState();
}

final _scrollVerticalController = ScrollController();

class _MdiDetailState extends State<MdiDetail> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: const Color.fromARGB(255, 255, 255, 255),
                    textColor: EnvisionColor.colorBlue,
                    padding: const EdgeInsets.all(16),
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                  )),
              const Center(
                child: Text('MDI Data Detail',
                    style: TextStyle(
                      fontFamily: 'TTNorms',
                      fontWeight: FontWeight.bold,
                      wordSpacing: 0,
                      letterSpacing: 0,
                      fontSize: 25,
                      // color: Colors.yellow,
                    )),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              return SizedBox(
                  height: height * 0.8,
                  width: width * 0.8 < 828 ? 828 : width * 0.8,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: _scrollVerticalController,
                      child: SizedBox(
                        width: width * 0.6 < 828 ? width * 0.8 : 828,
                        child: Column(
                          children: [
                            Wrap(spacing: 40, runSpacing: 25, children: [
                              Wrap(
                                  direction: Axis.vertical,
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: <Widget>[
                                    chipWord('HN', widget.mdiData.hn!),
                                    chipWord('Gender',
                                        widget.mdiData.patientGenderText!),
                                    chipWord('Patient Type',
                                        widget.mdiData.patientTypeText!),
                                  ]),
                              Wrap(
                                  direction: Axis.vertical,
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: <Widget>[
                                    chipWord('Patient Name',
                                        widget.mdiData.patientName!),
                                    chipWord(
                                        'Age', widget.mdiData.patientAgeText!),
                                    chipWord('Location',
                                        widget.mdiData.locationText!),
                                  ]),
                              Wrap(
                                  direction: Axis.vertical,
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: <Widget>[
                                    chipWord(
                                        'Visit No', widget.mdiData.visitNo!),
                                    chipWord('Weight',
                                        widget.mdiData.patientWeightText!),
                                    chipWord('Status',
                                        widget.mdiData.dataStatusText!),
                                  ]),
                              Wrap(
                                  direction: Axis.vertical,
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: <Widget>[
                                    const Text(
                                      '',
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    chipWord('Height',
                                        widget.mdiData.patientHeightText!),
                                    chipWord(
                                        'BMI', '${widget.mdiData.patientBmi}'),
                                  ])
                            ]),
                            const SizedBox(height: EnvisionSize.cardPadding),
                            SizedBox(
                                width: 1200,
                                height: 1000,
                                // background: EnvisionColor.secondaryColor,
                                child: detailTable(widget.model.dataDetail)),
                          ],
                        ),
                      )));
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
          ],
        ));
  }

  Widget detailTable(List<DataLog> dataLog) {
    return DataTable(
        dataRowMaxHeight: 100,
        headingRowColor: WidgetStateColor.resolveWith(
            (states) => EnvisionColor.primaryColor.withOpacity(0.5)),
        columns: const [
          DataColumn(
              label: Text('Blood Pressure',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white))),
          DataColumn(
              label: Text(
            '',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          )),
          DataColumn(
              label: Text('',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white))),
          DataColumn(
              label: Text('Pain Scale',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white))),
          DataColumn(
              label: Text('Create On',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white)))
        ],
        rows: List.generate(
          dataLog.length,
          (index) => bindingDataRow(dataLog[index], index, () {}, context),
        ));
  }

  DataRow bindingDataRow(
      DataLog data, int index, Function() onTap, BuildContext context) {
    return DataRow(cells: [
      // DataCell(Text(data.visitNo ?? '')),
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${data.bloodPressure ?? ''} ${data.bloodPressureUnit ?? ''}'),
          chipWord('Method', data.bloodPressureMethod ?? ''),
        ],
      )),
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          chipWord(
              'Pulse Rate', '${data.pulseRate ?? ''} ${data.pulseUnit ?? ''}'),
          chipWord('Respiration Rate', '${data.respirationRate ?? ''}'),
        ],
      )),
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          chipWord('Temperature',
              '${data.temperature ?? ''} ${data.temperatureUnit ?? ''}'),
          chipWord('spo2', '${data.spo2 ?? ''} ${data.spo2Unit ?? ''}'),
        ],
      )),
      DataCell(Text('${data.painScale ?? ''}')),
      DataCell(Text(DateFormat(EnvisionFormat.displayFormattedDateTime)
          .format(data.vsDateTime!))),
    ]);
  }

  Widget chipWord(String header, String? text) {
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
            text: text ?? '',
          ),
        ],
      ),
    );
  }
}
