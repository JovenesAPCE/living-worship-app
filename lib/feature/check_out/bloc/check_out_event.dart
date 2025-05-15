part of 'check_out_bloc.dart';

sealed class CheckOutEvent extends Equatable {
  const CheckOutEvent();
  @override
  List<Object> get props => [];
}


class CheckOutPageSubscriptionRequested extends CheckOutEvent {}