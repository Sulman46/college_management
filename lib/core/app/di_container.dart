import 'package:college_management/core/domain/connectivity/data/datasource/datasource.dart';
import 'package:college_management/core/domain/connectivity/data/repository_impl/repository_impl.dart';
import 'package:college_management/core/domain/connectivity/domain/repository/repository.dart';
import 'package:college_management/core/domain/connectivity/domain/usecase/usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import '../../features/admin/university_profile/data/datasource/datasource.dart';
import '../../features/admin/university_profile/data/repository_impl/repository_impl.dart';
import '../../features/admin/university_profile/domain/repository/repository.dart';
import '../../features/admin/university_profile/domain/usecase/usecase.dart';
import '../../features/admin/university_profile/presentation/controller/cubit.dart';
import '../domain/connectivity/presentaion/connectivity_controller.dart';


class DiContainer{
 final sl=GetIt.instance;

  Future<void> init()async{
    WidgetsFlutterBinding.ensureInitialized();
    // sl.registerLazySingleton(() => LocalizationGetx(),);
    executeFirstTime();
    cubits();
  }

  Future<void> executeFirstTime()async{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    //// internet connection
    sl.registerLazySingleton<DataSourceConnection>(() => CheckInternetClassConnection(),);
    sl.registerLazySingleton<RepositoryConnection>(() => ConnectionImpl(dataSourceConnection: sl()),);
    sl.registerLazySingleton(() => UseCaseConnection(repository: sl()),);



    // //// student dashboard
    sl.registerLazySingleton<UniversityProfileDataSource>(() => FunctionClassUniversityProfile(),);
    sl.registerLazySingleton<UniversityProfileRepository>(() => UniversityProfileRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => UniversityProfileUseCase(repository: sl()),);


    ConnectivityController().init();
    await sl.allReady();
  }

  //// cubits
  void cubits()async{
    sl.registerLazySingleton(() => UniversityProfileCubit(sl()),);

  }
}