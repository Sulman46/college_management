class AttendancePolicyModel {
  int id;
  String type;
  String tag;
  String title;
  String val;
  String action;

  AttendancePolicyModel({
    required this.id,
    required this.type,
    required this.tag,
    required this.title,
    required this.val,
    required this.action,
  });

  factory AttendancePolicyModel.fromMap(
      Map<String, dynamic> map) {
    return AttendancePolicyModel(
      id: map['_id'] ?? 0,
      type: map['type'] ?? 'safe',
      tag: map['tag'] ?? '',
      title: map['title'] ?? '',
      val: map['val'] ?? '',
      action: map['action'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'type': type,
      'tag': tag,
      'title': title,
      'val': val,
      'action': action,
    };
  }
}