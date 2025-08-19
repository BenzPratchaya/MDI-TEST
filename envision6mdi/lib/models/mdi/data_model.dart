class Data {
  int? id;
  String? uid;
  String? description;
  int? isVisible;

  Data({this.id, this.uid, this.description, this.isVisible});

  factory Data.fromMap(Map data) {
    return Data(
        id: data['Id'],
        uid: data['UId'],
        description: data['Description'],
        isVisible: data['IsVisible']);
  }

  Data.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        uid = json['UId'],
        description = json['Description'],
        isVisible = json['IsVisible'];

  Map<String, Object?> toJson() => {
        'Id': id,
        'UId': uid,
        'Description': description,
        'IsVisible': isVisible
      };
}
