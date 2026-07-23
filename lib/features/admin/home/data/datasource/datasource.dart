import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/dashboard_model.dart';

abstract class AdminHomeDataSource{
  Future<Either<String,DashboardModel>> get();
}


class FunctionClassAdminHome extends AdminHomeDataSource{
  final DioHelper _dioHelper=DioHelper();

  // function
  @override
  Future<Either<String,DashboardModel>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.dashboardApi);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        var data=response.data;
        DashboardModel model=DashboardModel.fromMap(data);
        return Right(model);

      }
      var data=response.data;
      return Left(data['message'] ??data['msg'] ??data['error'] ??  "Failed",);

    }catch(e){
      return Left(e.toString());
    }
  }

}