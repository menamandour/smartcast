import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/domain/entities/user.dart';
import 'package:smartcast/src/domain/usecases/get_current_user_usecase.dart';
import 'package:smartcast/src/domain/usecases/login_usecase.dart';
import 'package:smartcast/src/domain/usecases/logout_usecase.dart';
import 'package:smartcast/src/domain/usecases/register_usecase.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const AuthLoginEvent({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String? phone;

  const AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.fullName,
    this.phone,
  });

  @override
  List<Object?> get props => [email, password, fullName, phone];
}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent();
}

class AuthGetCurrentUserEvent extends AuthEvent {
  const AuthGetCurrentUserEvent();
}

class AuthCheckStatusEvent extends AuthEvent {
  const AuthCheckStatusEvent();
}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthAuthenticatedState extends AuthState {
  final User user;

  const AuthAuthenticatedState({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticatedState extends AuthState {
  const AuthUnauthenticatedState();
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(const AuthInitialState()) {
    on<AuthLoginEvent>(_onLoginEvent);
    on<AuthRegisterEvent>(_onRegisterEvent);
    on<AuthLogoutEvent>(_onLogoutEvent);
    on<AuthGetCurrentUserEvent>(_onGetCurrentUserEvent);
    on<AuthCheckStatusEvent>(_onCheckStatusEvent);
  }

  Future<void> _onLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    final result = await loginUseCase(
      email: event.email,
      password: event.password,
      rememberMe: event.rememberMe,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthAuthenticatedState(user: user)),
    );
  }

  Future<void> _onRegisterEvent(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    final result = await registerUseCase(
      email: event.email,
      password: event.password,
      fullName: event.fullName,
      phone: event.phone,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthAuthenticatedState(user: user)),
    );
  }

  Future<void> _onLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    final result = await logoutUseCase();

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (_) => emit(const AuthUnauthenticatedState()),
    );
  }

  Future<void> _onGetCurrentUserEvent(
    AuthGetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    final result = await getCurrentUserUseCase();

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthAuthenticatedState(user: user)),
    );
  }

  Future<void> _onCheckStatusEvent(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    final result = await getCurrentUserUseCase();

    result.fold(
      (failure) => emit(const AuthUnauthenticatedState()),
      (user) => emit(AuthAuthenticatedState(user: user)),
    );
  }
}
