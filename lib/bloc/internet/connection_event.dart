part of 'connection_bloc.dart';

abstract class InternetConnectionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InternetConnected extends InternetConnectionEvent {}

class InternetDisconnected extends InternetConnectionEvent {}
