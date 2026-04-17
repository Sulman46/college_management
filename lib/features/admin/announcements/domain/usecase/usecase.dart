
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class AnnouncementsUseCase{
  final AnnouncementsRepository repository;
  AnnouncementsUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
