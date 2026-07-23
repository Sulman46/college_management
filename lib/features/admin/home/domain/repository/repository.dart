import 'package:dartz/dartz.dart';

import '../../models/dashboard_model.dart';

abstract class AdminHomeRepository{
  Future<Either<String,DashboardModel>> get();
}