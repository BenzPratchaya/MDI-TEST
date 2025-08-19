class ApiConstants {
   static const String apiUrl = 'https://localhost:44345/';
  //real
//   static const String apiUrl = 'https://10.22.254.40/EnvisionMdiService/';
//   static const String apiUrl = 'http://10.22.188.205:8094/EnvisionMdiService/';
  //static const String apiUrl = 'http://10.10.10.124/EnvisionMdiService/';

  // static const String apiUrl = 'http://svpt2mdi:8094/EnvisionMdiService/';

//   static const String apiUrl = 'http://10.10.10.124/EnvisionMdiService/';

  //data view
  //worklist
  static const String login = '${apiUrl}User/SelectLogin';
  static const String selectDataViewByDate = '${apiUrl}Data/SelectViewByDate';
  static const String selectDataViewByDateWithLocationId =
      '${apiUrl}Data/SelectViewByDateWithLocationId';
  static const String selectDataViewByDateWithModalityId =
      '${apiUrl}Data/SelectViewByDateWithModalityId';
  static const String selectDataViewByHn = '${apiUrl}Data/SelectViewByHn';
  static const String selectDataLogByDataId = '${apiUrl}DataLog/SelectByDataId';
  static const String selectDataById = '${apiUrl}Data/SelectByDataId';
  static const String selectDataNonConfirmByModalityId =
      '${apiUrl}Data/SelectNonConfirmByModalityId';
  static const String selectDataNonConfirmByHn =
      '${apiUrl}Data/SelectNonConfirmByHn';
  static const String selectDataNonConfirmByVN =
      '${apiUrl}Data/SelectNonConfirmByVN';
  static const String selectDataLastVisitByHn =
      '${apiUrl}Data/SelectLastVisitByHn';
  //mdi data
  static const String updateData = '${apiUrl}Data/Update';
  static const String insertData = '${apiUrl}Data/Insert';
  //patient Visit
  static const String updatePatientVisit = '${apiUrl}PatientVisit/Update';
  //modality
  static const String selectModalityView = '${apiUrl}Modality/SelectView';
  static const String selectModalityByUid =
      '${apiUrl}Modality/SelectByModalityUid';
  static const String insertModality = '${apiUrl}Modality/Insert';
  static const String updateModality = '${apiUrl}Modality/Update';
  //sub location
  static const String selectSubLocationView = '${apiUrl}SubLocation/SelectView';
  static const String selectSubLocationViewByLocationId =
      '${apiUrl}SubLocation/SelectViewByLocationId';
  static const String insertSubLocation = '${apiUrl}SubLocation/Insert';
  static const String updateSubLocation = '${apiUrl}SubLocation/Update';
  //location
  static const String selectLocationView = '${apiUrl}Location/SelectView';
  static const String selectLocationByUid = '${apiUrl}Location/SelectByUid';
  static const String insertLocation = '${apiUrl}Location/Insert';
  static const String updateLocation = '${apiUrl}Location/Update';
  //patient
  static const String selectPatientByHn = '${apiUrl}Patient/SelectByHn';
  static const String selectPatientByVN = '${apiUrl}Patient/SelectByVN';
  //Organization
  static const String selectOrganizationView =
      '${apiUrl}Organization/SelectView';
  static const String selectOrganizationByUid =
      '${apiUrl}Organization/SelectByUid';
  static const String selectOrganizationById =
      '${apiUrl}Organization/SelectById';
  //General
  static const String selectGeneralViewByGroup =
      '${apiUrl}General/SelectViewByGroup';
  //Service
  static const String setData = '${apiUrl}Service/SetData';
  static const String selectByDateGroupByModality =
      '${apiUrl}Data/SelectByDateGroupByModality';
}
