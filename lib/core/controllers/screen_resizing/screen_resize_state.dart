import 'package:equatable/equatable.dart';

abstract class ScreenResizeState  extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ScreenResizeInit extends ScreenResizeState{}
class ScreenResizeLoading extends ScreenResizeState{}
class ScreenResizeLoaded extends ScreenResizeState{}
class ScreenResizeError extends ScreenResizeState{}