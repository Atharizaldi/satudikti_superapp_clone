part of 'journals_scopus_publication_bloc.dart';

abstract class JournalsScopusPublicationEvent extends Equatable {
  const JournalsScopusPublicationEvent();
}

class GetJournalsScopusEvent extends JournalsScopusPublicationEvent {
  final String id;

  GetJournalsScopusEvent({required this.id});

  @override
  List<Object> get props => [id];
}
