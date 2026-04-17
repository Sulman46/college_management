import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class DataSourceConnection{
  Future<Either<String,bool>> connection({required Connectivity connectivity, required InternetConnectionChecker internetConnectionChecker});
}


class CheckInternetClassConnection extends DataSourceConnection{
  Future<Either<String, bool>> connection({required Connectivity connectivity, required InternetConnectionChecker internetConnectionChecker})async{
    try{
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return const Right(false);
      }
      final hasInternet = await internetConnectionChecker.hasConnection;
      return Right(hasInternet);


    }catch(e){
      return Left(e.toString());
    }
  }


}