part of 'kedairekapt_bloc.dart';

abstract class KedairekaptState extends Equatable {
  const KedairekaptState();

  @override
  List<Object> get props => [];
}

class KedairekaptLoading extends KedairekaptState {
  @override
  List<Object> get props => [];
}

class KedairekaptNoInternet extends KedairekaptState {
  @override
  List<Object> get props => [];
}

class KedairekaptLoaded extends KedairekaptState {
  final ModelKedairekaIndustri modelKedairekaIndustriPT;

  KedairekaptLoaded({required this.modelKedairekaIndustriPT});
  @override
  List<Object> get props => [modelKedairekaIndustriPT];
}
