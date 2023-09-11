part of 'kedairekaindustri_bloc.dart';

abstract class KedairekaindustriState extends Equatable {
  const KedairekaindustriState();

  @override
  List<Object> get props => [];
}

class KedairekaindustriLoading extends KedairekaindustriState {
  @override
  List<Object> get props => [];
}

class KedairekaindustriNoInternet extends KedairekaindustriState {
  @override
  List<Object> get props => [];
}

class KedairekaindustriLoaded extends KedairekaindustriState {
  final ModelKedairekaIndustri modelKedairekaIndustri;

  KedairekaindustriLoaded({required this.modelKedairekaIndustri});
  @override
  List<Object> get props => [modelKedairekaIndustri];
}
