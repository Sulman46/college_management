class AffiliationModel {
  String name;
  String sector;
  String location;
  String website;
  String status;
  String? id;

  TheoryGradingCriteria? theory;
  PracticalGradingCriteria? practical;

  AffiliationModel({
     this.name="",
     this.sector="",
     this.location="",
     this.website="",
     this.status="",
     this.theory,
     this.practical,
    this.id,
  });

  factory AffiliationModel.fromMap(
      Map<String, dynamic> map) {
    return AffiliationModel(
      name: map['name'] ?? '',
      id: map['_id'] ?? '',
      sector: map['sector'] ?? '',
      location: map['location'] ?? '',
      website: map['website'] ?? '',
      status: map['status'] ?? 'Active',

      theory: TheoryGradingCriteria.fromMap(
        map['gradingCriteria']?['theory'] ?? {},
      ),

      practical: PracticalGradingCriteria.fromMap(
        map['gradingCriteria']?['practical'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if(id!=null)
      '_id':id??"",
      'name': name,
      'sector': sector,
      'location': location,
      'website': website,
      'status': status,

      'gradingCriteria': {
        'theory': theory!.toMap(),
        'practical': practical!.toMap(),
      },
    };
  }


  AffiliationModel copyWith({
    String? name,
    String? sector,
    String? location,
    String? website,
    String? status,
    String? id,
    TheoryGradingCriteria? theory,
    PracticalGradingCriteria? practical,
  }) {
    return AffiliationModel(
      name: name ?? this.name,
      sector: sector ?? this.sector,
      location: location ?? this.location,
      website: website ?? this.website,
      status: status ?? this.status,
      id: id ?? this.id,
      theory: theory ?? this.theory,
      practical: practical ?? this.practical,
    );
  }
}

class TheoryGradingCriteria {
  int mids;
  int sessional;
  int finalMarks;
  int totalTheory;
  int passPercentage;

  TheoryGradingCriteria({
    required this.mids,
    required this.sessional,
    required this.finalMarks,
    required this.totalTheory,
    required this.passPercentage,
  });

  factory TheoryGradingCriteria.fromMap(
      Map<String, dynamic> map) {
    return TheoryGradingCriteria(
      mids: map['mids'] ?? 0,
      sessional: map['sessional'] ?? 0,
      finalMarks: map['final'] ?? 0,
      totalTheory: map['totalTheory'] ?? 0,
      passPercentage: map['passPercentage'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mids': mids,
      'sessional': sessional,
      'final': finalMarks,
      'totalTheory': totalTheory,
      'passPercentage': passPercentage,
    };
  }
}

class PracticalGradingCriteria {
  int maxMarks;
  int passPercentage;

  PracticalGradingCriteria({
    required this.maxMarks,
    required this.passPercentage,
  });

  factory PracticalGradingCriteria.fromMap(
      Map<String, dynamic> map) {
    return PracticalGradingCriteria(
      maxMarks: map['maxMarks'] ?? 0,
      passPercentage: map['passPercentage'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'maxMarks': maxMarks,
      'passPercentage': passPercentage,
    };
  }
}