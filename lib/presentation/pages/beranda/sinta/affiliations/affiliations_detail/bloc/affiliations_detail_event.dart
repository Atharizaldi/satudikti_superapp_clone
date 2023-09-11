part of 'affiliations_detail_bloc.dart';

abstract class AffiliationsDetailEvent extends Equatable {
  const AffiliationsDetailEvent();
}

class GetAffiliationsDetailEvent extends AffiliationsDetailEvent {
  final String id;

  GetAffiliationsDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

