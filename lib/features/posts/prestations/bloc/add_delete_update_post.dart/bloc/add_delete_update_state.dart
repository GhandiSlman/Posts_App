part of 'add_delete_update_bloc.dart';

sealed class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

final class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class LoadingAddUpdateDeleteState extends AddDeleteUpdateState {}

class ErrorAddUpdateDeleteState extends AddDeleteUpdateState {
  final String message;

  const ErrorAddUpdateDeleteState({required this.message});

  @override
  List<Object> get props => [];
}

class SuccessAddUpdateDeleteState extends AddDeleteUpdateState {
  final String message;

  const SuccessAddUpdateDeleteState({required this.message});

  @override
  List<Object> get props => [];
}
