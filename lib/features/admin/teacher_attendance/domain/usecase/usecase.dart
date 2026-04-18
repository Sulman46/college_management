
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class TeacherAttendanceUseCase{
  final TeacherAttendanceRepository repository;
  TeacherAttendanceUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
