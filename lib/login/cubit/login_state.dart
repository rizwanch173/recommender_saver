part of 'login_cubit.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.isSubmitted = false,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool isSubmitted;
  final String? errorMessage;

  @override
  List<Object?> get props => [email, password, status, isValid, errorMessage];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isSubmitted,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
