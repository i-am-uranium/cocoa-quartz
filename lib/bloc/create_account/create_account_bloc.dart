import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../models/models.dart';
import '../../repository/repository.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc({
    @required this.memberRepository,
  }) : assert(memberRepository != null,
            'memberRepository repository cannot be null');

  final MemberRepository memberRepository;

  @override
  CreateAccountState get initialState => CreateAccountInitial();

  @override
  Stream<CreateAccountState> mapEventToState(CreateAccountEvent event) async* {
    if (event is CreateAccountButtonPressed) {
      final response = await memberRepository.createAccount(CreateMemberRequest(
          fullName: event.fullName,
          email: event.email,
          password: event.password));
      if (!response.success) {
        yield CreateAccountFailure(
            error: response.error, errorCode: response.errorCode);
        return;
      }
      yield CreateAccountSuccess();
      return;
    }
  }
}
