import 'package:equatable/equatable.dart';

abstract class AffiliatedUniversityState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class AffiliatedUniversityInit extends AffiliatedUniversityState{}
class AffiliatedUniversityLoading extends AffiliatedUniversityState{}
class AffiliatedUniversityLoaded extends AffiliatedUniversityState{}
class AffiliatedUniversityError extends AffiliatedUniversityState{}
