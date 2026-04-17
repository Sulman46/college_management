import 'package:equatable/equatable.dart';

abstract class CourseCatalogAdminState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class CourseCatalogAdminInit extends CourseCatalogAdminState{}
class CourseCatalogAdminLoading extends CourseCatalogAdminState{}
class CourseCatalogAdminLoaded extends CourseCatalogAdminState{}
class CourseCatalogAdminError extends CourseCatalogAdminState{}
