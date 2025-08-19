class EnvisionResponseModel {
  String? acknowledgementCode;
  String? textMessage;
  dynamic data_1;
  dynamic data_2;
  dynamic patient_1;
  dynamic dataLog_1;
  dynamic user_1;
  dynamic modality_1;
  dynamic subLocation_1;
  dynamic location_1;
  dynamic organization_1;
  dynamic general_1;

  EnvisionResponseModel(
      {this.acknowledgementCode = 'AE',
      this.textMessage = 'Error',
      this.data_1,
      this.data_2,
      this.patient_1,
      this.dataLog_1,
      this.user_1,
      this.modality_1,
      this.subLocation_1,
      this.location_1,
      this.organization_1,
      this.general_1});

  factory EnvisionResponseModel.fromMap(Map data) {
    return EnvisionResponseModel(
        acknowledgementCode: data['AcknowledgementCode'],
        textMessage: data['TextMessage'],
        data_1: data['Data_1'],
        data_2: data['Data_2'],
        patient_1: data['Patient_1'],
        dataLog_1: data['DataLog_1'],
        user_1: data['User_1'],
        modality_1: data['Modality_1'],
        subLocation_1: data['SubLocation_1'],
        location_1: data['Location_1'],
        organization_1: data['Organization_1'],
        general_1: data['General_1']);
  }
  EnvisionResponseModel.fromJson(Map<String, dynamic> json)
      : acknowledgementCode = json['AcknowledgementCode'],
        textMessage = json['TextMessage'],
        data_1 = json['Data_1'],
        data_2 = json['Data_2'],
        patient_1 = json['Patient_1'],
        dataLog_1 = json['DataLog_1'],
        user_1 = json['User_1'],
        modality_1 = json['Modality_1'],
        subLocation_1 = json['SubLocation_1'],
        location_1 = json['Location_1'],
        organization_1 = json['Organization_1'],
        general_1 = json['General_1'];

  Map<String, dynamic> toJson() => {
        'AcknowledgementCode': acknowledgementCode,
        'TextMessage': textMessage,
        'Data_1': data_1,
        'Data_2': data_2,
        'Patient_1': patient_1,
        'DataLog_1': dataLog_1,
        'User_1': user_1,
        'Modality_1': modality_1,
        'SubLocation_1': subLocation_1,
        'Location_1': location_1,
        'General_1': general_1,
      };
}
