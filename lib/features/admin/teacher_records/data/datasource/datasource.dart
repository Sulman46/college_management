import 'package:dartz/dartz.dart';

abstract class TeacherRecordsDataSource{
  Future<Either<String,bool>> function1();
}


class FunctionClassTeacherRecords extends TeacherRecordsDataSource{

  // function
  Future<Either<String, bool>> function1()async{
    try{
      bool isFirstTime= 1==1;
      return Right(isFirstTime);
    }catch(e){
      return Left(e.toString());
    }
  }
}