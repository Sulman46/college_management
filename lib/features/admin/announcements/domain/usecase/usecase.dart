
import 'package:dartz/dartz.dart';
import '../../models/announcement_model.dart';
import '../repository/repository.dart';

class AnnouncementsUseCase{
  final AnnouncementsRepository repository;
  AnnouncementsUseCase({required this.repository});

  Future<Either<String,String>> post({required AnnouncementModel value})async{
    return repository.post(value: value);
  }

  Future<Either<String,String>> update({required AnnouncementModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,String>> delete({required AnnouncementModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<AnnouncementModel>>> get(){
    return repository.get();
  }

}
