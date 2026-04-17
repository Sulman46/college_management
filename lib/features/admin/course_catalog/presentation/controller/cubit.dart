import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class CourseCatalogAdminCubit extends Cubit<CourseCatalogAdminState> {
  final CourseCatalogAdminUseCase _useCase;
  CourseCatalogAdminCubit(this._useCase) : super(CourseCatalogAdminInit());

}
