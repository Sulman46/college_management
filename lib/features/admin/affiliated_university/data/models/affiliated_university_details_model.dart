class AffiliatedUniversityDetailsModel {
  final String name;
  final String status;
  final String sector;
  final String location;
  final String website;

  final int mids;
  final int sess;
  final int finalMarks;

  final int practicalMarks;

  AffiliatedUniversityDetailsModel({
    required this.name,
    required this.status,
    required this.sector,
    required this.location,
    required this.website,
    required this.mids,
    required this.sess,
    required this.finalMarks,
    required this.practicalMarks,
  });

  int get totalTheory => mids + sess + finalMarks;
}