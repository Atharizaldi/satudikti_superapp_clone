part of 'affiliations_scopus_publication_bloc.dart';

abstract class AffiliationsScopusPublicationEvent extends Equatable {
  const AffiliationsScopusPublicationEvent();
}

class GetAffiliationsScopusEvent extends AffiliationsScopusPublicationEvent {
  final String id;

  GetAffiliationsScopusEvent({required this.id});

  @override
  List<Object> get props => [id];
}