part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => <Object>[];
}

class AuthLoaded extends AuthState {
  const AuthLoaded(this.auth);

  final Auth auth;

  @override
  List<Object> get props => auth.props;
}
