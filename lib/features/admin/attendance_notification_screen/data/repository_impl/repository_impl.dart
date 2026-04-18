
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class AttendanceNotificationRepositoryImpl extends AttendanceNotificationRepository{
  final AttendanceNotificationDataSource dataSource;
  AttendanceNotificationRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}