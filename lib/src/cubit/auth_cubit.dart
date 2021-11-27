import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../api/imgur.dart' as imgur;
import '../models/auth.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void setData(Auth auth) {
    imgur.setAuth(auth);
    emit(AuthLoaded(auth));
  }

  Future<void> signOut() async {
    final Future<void> future = imgur.logout();
    emit(AuthInitial());
    await future;
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    if (json.containsKey('value')) {
      final Auth auth = Auth.fromJson(json['value'] as Map<String, dynamic>);
      imgur.setAuth(auth);
      return AuthLoaded(auth);
    } else {
      return AuthInitial();
    }
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    if (state is AuthLoaded) {
      return <String, dynamic>{ 'value': state.auth.toJson() };
    } else {
      return <String, AuthState>{};
    }
  }
}
