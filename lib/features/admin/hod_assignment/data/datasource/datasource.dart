import 'package:dartz/dartz.dart';

abstract class HODAssignmentDataSource{
  Future<Either<String,bool>> function1();
}


class FunctionClassHODAssignment extends HODAssignmentDataSource{

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