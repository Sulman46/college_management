import 'package:dartz/dartz.dart';

abstract class NeuralGeneratorDataSource{
  Future<Either<String,bool>> function1();
}


class FunctionClassNeuralGenerator extends NeuralGeneratorDataSource{

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