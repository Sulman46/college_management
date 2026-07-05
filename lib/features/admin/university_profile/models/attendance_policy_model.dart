class AttendancePolicyModel {
  String id;
  String? objectId;
  String type;
  String tag;
  String title;
  String val;
  String action;

  AttendancePolicyModel({
    required this.id,
     this.objectId,
    required this.type,
    required this.tag,
    required this.title,
    required this.val,
    required this.action,
  });

  factory AttendancePolicyModel.fromMap(
      Map<String, dynamic> map) {
    return AttendancePolicyModel(
      id: map['id'] ?? "",
      objectId: map['_id'] ?? "",
      type: map['type'] ?? 'safe',
      tag: map['tag'] ?? '',
      title: map['title'] ?? '',
      val: map['val'] ?? '',
      action: map['action'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      if(objectId!=null)
        "_id":objectId,
      'type': type,
      'tag': tag,
      'title': title,
      'val': val,
      'action': action,
    };
  }
}