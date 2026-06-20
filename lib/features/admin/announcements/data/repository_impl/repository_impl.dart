
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/announcement_model.dart';
import '../datasource/datasource.dart';

class AnnouncementsRepositoryImpl extends AnnouncementsRepository{
  final AnnouncementsDataSource dataSource;
  AnnouncementsRepositoryImpl({required this.dataSource});


  Future<Either<String,AnnouncementModel>> post({required AnnouncementModel value})async{
    return dataSource.post(value: value);
  }

  Future<Either<String,AnnouncementModel>> update({required AnnouncementModel value}){
    return dataSource.update(value: value);
  }

  Future<Either<String,bool>> delete({required AnnouncementModel value}){
    return dataSource.delete(value: value);
  }

  Future<Either<String,List<AnnouncementModel>>> get(){
    return dataSource.get();
  }


}