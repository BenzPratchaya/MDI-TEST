class MdiDataGroupByModality {
  DateTime? date;
  String? location;
  String? modality;
  int? count;

  MdiDataGroupByModality({this.date, this.location, this.modality, this.count});

  MdiDataGroupByModality.fromJson(Map<String, dynamic> json) {
    date = json['date'] == null
        ? json['date']
        : DateTime.parse(json['date']).toLocal();
    location = json['location'];
    modality = json['modality'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['location'] = location;
    data['modality'] = modality;
    data['count'] = count;
    return data;
  }
}
