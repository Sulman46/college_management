
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class AnnouncementsRepositoryImpl extends AnnouncementsRepository{
  final AnnouncementsDataSource dataSource;
  AnnouncementsRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}