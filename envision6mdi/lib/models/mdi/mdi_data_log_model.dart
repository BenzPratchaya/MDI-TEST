class DataLog {
  int? dataLogId;
  int? dataId;
  int? modalityVsId;
  String? modalityVsText;

  DateTime? vsDateTime;
  int? pulseRate;
  String? pulseUnit;
  String? pulseFlag;
  int? bloodPressureSystolic;
  int? bloodPressureDiastolic;
  int? bloodPressureMean;
  String? bloodPressure;
  String? bloodPressureUnit;
  String? bloodPressureMethod;
  double? spo2;
  String? spo2Unit;
  double? temperature;
  String? temperatureUnit;
  String? temperatureMethod;
  int? respirationRate;
  int? painScale;

  DataLog({
    this.dataLogId,
    this.dataId,
    this.modalityVsId,
    this.modalityVsText,
    this.vsDateTime,
    this.pulseRate,
    this.pulseUnit,
    this.pulseFlag,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.bloodPressureMean,
    this.bloodPressure,
    this.bloodPressureUnit,
    this.bloodPressureMethod,
    this.spo2,
    this.spo2Unit,
    this.temperature,
    this.temperatureUnit,
    this.temperatureMethod,
    this.respirationRate,
    this.painScale,
  });

  factory DataLog.fromMap(Map data) {
    return DataLog(
        dataLogId: data['DataLogId'],
        dataId: data['DataId'],
        modalityVsId: data['ModalityVsId'],
        modalityVsText: data['ModalityVsText'],
        vsDateTime: data['VsDateTime'],
        pulseRate: data['PulseRate'],
        pulseUnit: data['PulseUnit'],
        pulseFlag: data['PulseFlag'],
        bloodPressureSystolic: data['BloodPressureSystolic'],
        bloodPressureDiastolic: data['BloodPressureDiastolic'],
        bloodPressureMean: data['BloodPressureMean'],
        bloodPressure: data['BloodPressure'],
        bloodPressureUnit: data['BloodPressureUnit'],
        bloodPressureMethod: data['BloodPressureMethod'],
        spo2: data['Spo2'],
        spo2Unit: data['Spo2Unit'],
        temperature: data['Temperature'],
        temperatureUnit: data['TemperatureUnit'],
        temperatureMethod: data['TemperatureMethod'],
        respirationRate: data['RespirationRate'],
        painScale: data['PainScale']);
  }

  DataLog.fromJson(Map<String, dynamic> json)
      : dataLogId = json['DataLogId'],
        dataId = json['DataId'],
        modalityVsId = json['ModalityVsId'],
        modalityVsText = json['ModalityVsText'],
        vsDateTime = json['VsDateTime'] != null
            ? DateTime.parse(json['VsDateTime'])
            : json['VsDateTime'],
        pulseRate = json['PulseRate'],
        pulseUnit = json['PulseUnit'],
        pulseFlag = json['PulseFlag'],
        bloodPressureSystolic = json['BloodPressureSystolic'],
        bloodPressureDiastolic = json['BloodPressureDiastolic'],
        bloodPressureMean = json['BloodPressureMean'],
        bloodPressure = json['BloodPressure'],
        bloodPressureUnit = json['BloodPressureUnit'],
        bloodPressureMethod = json['BloodPressureMethod'],
        spo2 = json['Spo2'],
        spo2Unit = json['Spo2Unit'],
        temperature = json['Temperature'],
        temperatureUnit = json['TemperatureUnit'],
        temperatureMethod = json['TemperatureMethod'],
        respirationRate = json['RespirationRate'],
        painScale = json['PainScale'];

  Map<String, Object?> toJson() => {
        'DataLogId': dataLogId,
        'DataId': dataId,
        'ModalityVsId': modalityVsId,
        'ModalityVsText': modalityVsText,
        'VsDateTime': vsDateTime,
        'PulseRate': pulseRate,
        'PulseUnit': pulseUnit,
        'PulseFlag': pulseFlag,
        'BloodPressureSystolic': bloodPressureSystolic,
        'BloodPressureDiastolic': bloodPressureDiastolic,
        'BloodPressureMean': bloodPressureMean,
        'BloodPressure': bloodPressure,
        'BloodPressureUnit': bloodPressureUnit,
        'BloodPressureMethod': bloodPressureMethod,
        'Spo2': spo2,
        'Spo2Unit': spo2Unit,
        'Temperature': temperature,
        'TemperatureUnit': temperatureUnit,
        'TemperatureMethod': temperatureMethod,
        'RespirationRate': respirationRate,
        'PainScale': painScale,
      };
}
