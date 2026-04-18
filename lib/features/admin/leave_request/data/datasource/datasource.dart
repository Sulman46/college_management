import 'package:dartz/dartz.dart';

abstract class LeaveRequestDataSource{
  Future<Either<String,bool>> function1();
}


class FunctionClassLeaveRequest extends LeaveRequestDataSource{

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