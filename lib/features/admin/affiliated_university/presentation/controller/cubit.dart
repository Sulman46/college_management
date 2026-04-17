import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AffiliatedUniversityCubit extends Cubit<AffiliatedUniversityState> {
  final AffiliatedUniversityUseCase _useCase;
  AffiliatedUniversityCubit(this._useCase) : super(AffiliatedUniversityInit());

}
