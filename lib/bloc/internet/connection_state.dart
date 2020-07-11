part of 'connection_bloc.dart';

abstract class InternetConnectionState extends Equatable {
  @override
  List<Object> get props => [];
}

class InternetInitializing extends InternetConnectionState {}

class InternetAvailable extends InternetConnectionState {}

class InternetUnAvailable extends InternetConnectionState {}
