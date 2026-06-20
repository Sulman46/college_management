
import 'package:dartz/dartz.dart';
import '../../models/announcement_model.dart';
import '../repository/repository.dart';

class AnnouncementsUseCase{
  final AnnouncementsRepository repository;
  AnnouncementsUseCase({required this.repository});

  Future<Either<String,AnnouncementModel>> post({required AnnouncementModel value})async{
    return repository.post(value: value);
  }

  Future<Either<String,AnnouncementModel>> update({required AnnouncementModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,bool>> delete({required AnnouncementModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<AnnouncementModel>>> get(){
    return repository.get();
  }

}
