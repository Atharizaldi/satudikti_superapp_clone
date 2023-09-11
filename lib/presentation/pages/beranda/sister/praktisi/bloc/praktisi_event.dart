part of 'praktisi_bloc.dart';


abstract class PraktisiSisterEvent extends Equatable{
  const PraktisiSisterEvent();

  @override
  List<Object> get props => [];

}

class  GetPraktisiSisterEvent extends PraktisiSisterEvent{
  final String nidn;

  GetPraktisiSisterEvent({required this.nidn});
}