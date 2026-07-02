import 'package:dartz/dartz.dart';

import '../../models/announcement_model.dart';

abstract class AnnouncementsRepository{
  Future<Either<String,String>> post({required AnnouncementModel value});
  Future<Either<String,String>> update({required AnnouncementModel value});
  Future<Either<String,String>> delete({required AnnouncementModel value});
  Future<Either<String,List<AnnouncementModel>>> get();
}