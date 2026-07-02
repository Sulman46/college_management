
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/announcement_model.dart';
import '../datasource/datasource.dart';

class AnnouncementsRepositoryImpl extends AnnouncementsRepository{
  final AnnouncementsDataSource dataSource;
  AnnouncementsRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,String>> post({required AnnouncementModel value})async{
    return dataSource.post(value: value);
  }

  @override
  Future<Either<String,String>> update({required AnnouncementModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,String>> delete({required AnnouncementModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<AnnouncementModel>>> get(){
    return dataSource.get();
  }


}