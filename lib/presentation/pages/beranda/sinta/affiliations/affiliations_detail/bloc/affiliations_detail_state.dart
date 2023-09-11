part of 'affiliations_detail_bloc.dart';

abstract class AffiliationsDetailState extends Equatable {
  const AffiliationsDetailState();
}

class AffiliationsDetailLoading extends AffiliationsDetailState {
  @override
  List<Object> get props => [];
}

class AffiliationsDetailLoaded extends AffiliationsDetailState {
  final Affiliations affiliations;
  final String overall;
  final String overall3y;
  final String productivity;
  final String productivity3y;
  final List<List<String>> tables;

  AffiliationsDetailLoaded({
    required this.affiliations,
    required this.overall,
    required this.overall3y,
    required this.productivity,
    required this.productivity3y,
    required this.tables,
  });

  @override
  List<Object> get props => [affiliations, overall, overall3y, productivity, productivity3y, tables];
}
