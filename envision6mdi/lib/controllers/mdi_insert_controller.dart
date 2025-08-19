// ignore_for_file: avoid_init_to_null

import 'package:envision6mdi/helpers/constants.dart';
import 'package:envision6mdi/models/mdi/gbl_general_model.dart';
import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:envision6mdi/models/mdi/modality_model.dart';
import 'package:envision6mdi/models/mdi/organization_model.dart';
import 'package:envision6mdi/models/response/envision_response_model.dart';
import 'package:envision6mdi/services/mdi_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../locator.dart';

class MdiInsertController extends ChangeNotifier {
  final _api = locator<MDIService>();

  late EnvisionResponseModel _response;

  late String _confirmedByUid;
  String get confirmedByUid => _confirmedByUid;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingHn = false;
  bool get isLoadingHn => _isLoadingHn;

  bool _isRefresh = false;
  bool get isRefresh => _isRefresh;

  late String? _message = null;
  String? get message => _message;

  late String? _loginMessage = null;
  String? get loginMessage => _loginMessage;

  late String? _comment = '';
  String? get comment => _comment;

  String _messageLastUpdate = '';
  String get messageLastUpdate => _messageLastUpdate;

  late Color _weightFieldColor;
  Color get weightFieldColor => _weightFieldColor;

  late int _dataFrequency = 30;
  int get dataFrequency => _dataFrequency;

  final List<GblGeneralModel> _patTypeList = [];
  List<GblGeneralModel> get patTypeList => _patTypeList;

  late GblGeneralModel _patTypeSelected = GblGeneralModel();
  GblGeneralModel get patTypeSelected => _patTypeSelected;

  late Modality _modality;
  Modality get modality => _modality;

  late Organization _organization = Organization();
  Organization get organization => _organization;

  late MdiDataViewModel _mdiData = MdiDataViewModel();
  MdiDataViewModel get mdiData => _mdiData;

  onUpdate() {
    notifyListeners();
  }

  setUser(String user) {
    _confirmedByUid = user;
    notifyListeners();
  }

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  toggleLoadingHn() {
    _isLoadingHn = !_isLoadingHn;
    notifyListeners();
  }

  toggleRefresh() {
    _isRefresh = !_isRefresh;
    notifyListeners();
  }

  setMessage(String msg) {
    _message = msg;
    notifyListeners();
  }

  setRemark(String remark) {
    _comment = remark;
    notifyListeners();
  }

  setMdiData(MdiDataViewModel mdiData) {
    _mdiData = mdiData;
    notifyListeners();
  }

  setMessageLastUpdate(DateTime lastUpdate) {
    String msg =
        'last update: ${DateFormat(EnvisionFormat.displayFormattedTime).format(lastUpdate)}';
    _messageLastUpdate = msg;
    notifyListeners();
  }

  Future setDataFrequency() async {
    var feq = await _api.getUpdateDataFrequency();
    _dataFrequency = feq['dataFrequency'] ?? 30;
    notifyListeners();
  }

  Future setDataToInsertForm() async {
    await setPatTypeList();
  }

  Future setPatTypeList() async {
    _patTypeList.clear();
    await getGeneralList('PATIENT_TYPE');
    for (var e in _response.general_1) {
      GblGeneralModel gbl = GblGeneralModel.fromJson(e);
      _patTypeList.add(gbl);
      if (gbl.isDefault == 1) {
        _patTypeSelected = gbl;
      }
    }
    notifyListeners();
  }

  Future setSelectPatType(GblGeneralModel patType) async {
    _patTypeSelected = patType;
    notifyListeners();
  }

  Future<dynamic> getGeneralList(String group) async {
    try {
      await _api.getSelectGeneralViewByGroup(group).then((value) {
        if (value != null) {
          _response = EnvisionResponseModel.fromJson(value);
          if (_response.acknowledgementCode == 'AA') {
            if (_response.general_1 != null) {
              return _response.general_1;
            }
          } else {
            _message = '${_response.textMessage}';
          }
        }
      });
    } catch (e) {
      _message = e as String;
    }
  }

  Future getOrganizationAndModalityByModalityUid(String modalityUid) async {
    await _getModalityByUid(modalityUid);
    if (_modality.organizationId != null) {
      await _getOrganizationById(_modality.organizationId!);
    }
  }

  Future _getModalityByUid(String modalityUid) async {
    _modality = Modality();
    _loginMessage = null;
    try {
      await _api.getSelectModalityByUid(modalityUid).then((_) {
        _response = _api.response;
        if (_response.acknowledgementCode == 'AA') {
          if (_response.modality_1 != null) {
            _modality = Modality.fromJson(_response.modality_1[0]);
          } else {
            _loginMessage = 'Modality: $modalityUid dose not exist.';
          }
        } else {
          _loginMessage =
              '${_response.acknowledgementCode}: ${_response.textMessage}';
        }
      });
    } catch (e) {
      _loginMessage = e.toString();
    }
    notifyListeners();
  }

  Future _getOrganizationById(int orgId) async {
    await _api.getSelectOrganizationById(orgId).then((value) {
      if (value != null) {
        _response = EnvisionResponseModel.fromJson(value);
        if (_response.acknowledgementCode == 'AA') {
          _organization = Organization();
          if (_response.organization_1 != null) {
            for (var e in _response.organization_1) {
              _organization = Organization.fromJson(e);
              // _organizationSelected = Organization.fromJson(e);
            }
          }
        }
      }
    });
    notifyListeners();
  }
}
