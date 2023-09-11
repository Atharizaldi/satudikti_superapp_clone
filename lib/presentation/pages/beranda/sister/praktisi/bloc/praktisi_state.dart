part of 'praktisi_bloc.dart';

abstract class PraktisiSisterState extends Equatable {

  const PraktisiSisterState();

  @override
  List<Object> get props => [];
}

class PraktisiSisterInitial extends PraktisiSisterState {}

class PraktisiSisterLoadedState extends PraktisiSisterState {
  final List<PraktisiData> praktisiSister;
  final String nidn;

  PraktisiSisterLoadedState({required this.nidn, required this.praktisiSister});

  @override
  List<Object> get props => [praktisiSister];
}

class PraktisiSisterNoInternetState extends PraktisiSisterState {

  final String nidn;

  PraktisiSisterNoInternetState({required this.nidn});

  @override
  List<Object> get props => [this.nidn];
}

class PraktisiSisterErrorState extends PraktisiSisterState {
  final String nidn;

  PraktisiSisterErrorState({required this.nidn});

  @override
  List<Object> get props => [];
}

class PraktisiSisterNotFoundState extends PraktisiSisterState {

  final PraktisiSister? praktisiSister;

  PraktisiSisterNotFoundState(this.praktisiSister);

  @override
  List<Object> get props => [];

}