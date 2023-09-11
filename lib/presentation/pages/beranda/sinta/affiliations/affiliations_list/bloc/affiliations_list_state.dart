part of 'affiliations_list_bloc.dart';

abstract class AffiliationsListState extends Equatable {
  const AffiliationsListState();
}

class AffiliationsListInitial extends AffiliationsListState {
  @override
  List<Object> get props => [];
}

class AffiliationsListLoading extends AffiliationsListState {
  @override
  List<Object> get props => [];
}

class AffiliationsListNoInternet extends AffiliationsListState {
  @override
  List<Object> get props => [];
}

class AffiliationsListError extends AffiliationsListState {
  @override
  List<Object> get props => [];
}

class AffiliationsListNotFound extends AffiliationsListState {
  final int totalItem;
  AffiliationsListNotFound({required this.totalItem});

  @override
  List<Object> get props => [totalItem];
}

class AffiliationsListLoaded extends AffiliationsListState {
  final int totalItem;
  final bool hasReachedMax;
  final int page;
  final List<Affiliations> affiliationsList;

  AffiliationsListLoaded({
    required this.totalItem,
    required this.hasReachedMax,
    required this.page,
    required this.affiliationsList,
  });

  @override
  List<Object> get props => [totalItem, hasReachedMax, page, affiliationsList];
}
