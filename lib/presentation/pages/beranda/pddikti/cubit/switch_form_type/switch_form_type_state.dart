part of 'switch_form_type_cubit.dart';

abstract class SwitchFormTypeState extends Equatable {
  const SwitchFormTypeState();

  @override
  List<Object> get props => [];
}

class SwitchFormTypeInitial extends SwitchFormTypeState {}

class SwitchFormTypeMahasiswa extends SwitchFormTypeState {}

class SwitchFormTypeDosen extends SwitchFormTypeState {}

class SwitchFormTypePT extends SwitchFormTypeState {}

class SwitchFormTypeProdi extends SwitchFormTypeState {}
