part of 'majalah_detail_gmagz_bloc.dart';

abstract class MajalahDetailGMagzState extends Equatable {
  const MajalahDetailGMagzState();

  @override
  List<Object> get props => [];
}

class MajalahDetailGMagzinInitial extends MajalahDetailGMagzState {}

class MajalahDetailLoading extends MajalahDetailGMagzState {}

class MajalahDetailGMagzLoadedState extends MajalahDetailGMagzState {
  final List<Review> review;
  final DataMajalah dataMajalah;

  MajalahDetailGMagzLoadedState({
    required this.review,
    required this.dataMajalah,
  });
  @override
  List<Object> get props => [
        review,
        dataMajalah,
      ];
}

class MajalahDetailGMagzNoInternetState extends MajalahDetailGMagzState {
  final String id;

  MajalahDetailGMagzNoInternetState({required this.id});

  @override
  List<Object> get props => [this.id];
}

class MajalahDetailGMagzErrorState extends MajalahDetailGMagzState {
  final String id;

  MajalahDetailGMagzErrorState({required this.id});

  @override
  List<Object> get props => [];
}

class MajalahDetailGMagzNotFoundState extends MajalahDetailGMagzState {
  final MajalahDetailGMagz? majalahDetailGMagz;

  MajalahDetailGMagzNotFoundState(this.majalahDetailGMagz);

  @override
  List<Object> get props => [];
}
