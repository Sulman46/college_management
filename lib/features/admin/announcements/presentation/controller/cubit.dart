import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  final AnnouncementsUseCase _useCase;
  AnnouncementsCubit(this._useCase) : super(AnnouncementsInit());

}
