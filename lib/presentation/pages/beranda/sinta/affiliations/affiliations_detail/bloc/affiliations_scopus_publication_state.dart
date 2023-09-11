part of 'affiliations_scopus_publication_bloc.dart';

abstract class AffiliationsScopusPublicationState extends Equatable {
  const AffiliationsScopusPublicationState();
}

class AffiliationsScopusPublicationLoading
    extends AffiliationsScopusPublicationState {
  @override
  List<Object> get props => [];
}

class AffiliationsScopusPublicationNotFound extends AffiliationsScopusPublicationState{
  @override
  List<Object> get props => [];
}

class AffiliationsScopusPublicationNoInternet extends AffiliationsScopusPublicationState {
  @override
  List<Object> get props => [];
}

class AffiliationsScopusPublicationLoaded extends AffiliationsScopusPublicationState {
  final int totalItem;
  final int page;
  final List<Documents> documents;
  final bool hasReachedMax;

  AffiliationsScopusPublicationLoaded({
    required this.totalItem,
    required this.page,
    required this.documents,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [totalItem, page, documents, hasReachedMax];
}