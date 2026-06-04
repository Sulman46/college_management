import 'package:dartz/dartz.dart';

abstract class PayrollAndSalaryManagementDataSource{
  Future<Either<String,bool>> function1();
}


class FunctionClassPayrollAndSalaryManagement extends PayrollAndSalaryManagementDataSource{

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