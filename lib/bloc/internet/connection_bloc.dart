import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  final _webLocalStorage = WebLocalStorageHelper();

  @override
  InternetConnectionState get initialState => InternetInitializing();

  @override
  Stream<InternetConnectionState> mapEventToState(
      InternetConnectionEvent event) async* {
    if (event is InternetConnected) {
      _webLocalStorage.saveInternetState(available: true);
      yield InternetAvailable();
    } else if (event is InternetDisconnected) {
      _webLocalStorage.saveInternetState(available: false);
      yield InternetUnAvailable();
    }
  }
}
