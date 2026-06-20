import 'package:dartz/dartz.dart';

import '../../models/announcement_model.dart';

abstract class AnnouncementsRepository{
  Future<Either<String,AnnouncementModel>> post({required AnnouncementModel value});
  Future<Either<String,AnnouncementModel>> update({required AnnouncementModel value});
  Future<Either<String,bool>> delete({required AnnouncementModel value});
  Future<Either<String,List<AnnouncementModel>>> get();
}