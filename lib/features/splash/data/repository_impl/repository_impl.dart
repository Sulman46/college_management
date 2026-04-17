
import 'package:dartz/dartz.dart';

import '../datasource/datasource.dart';

class RepositoryImpl extends DataSourceName{
  final DataSourceName dataSourceName;
  RepositoryImpl({required this.dataSourceName});


  @override
  Future<Either<String, bool>> function1() {
    return dataSourceName.function1();
  }

}