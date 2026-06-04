class RequestNewDepartmentModel {
  String name;
  String code;
  String status;
  String? id;
  RequestNewDepartmentModel({required this.name,required this.code,required this.status,this.id});

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'code':code,
      'status':status
    };
  }
}