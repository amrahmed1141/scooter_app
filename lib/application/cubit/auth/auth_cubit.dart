import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_app/application/cubit/auth/auth_state.dart';
import 'package:scooter_app/domain/repository/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;
  AuthCubit(this.repo) : super(AuthInitial());

  void checkAuthStatus() {
    if (repo.currentUser != null) {
      emit(Authenticated(repo.currentUser!));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    emit(AuthLoading());

    try {
      final user =
          await repo.signUp(name: name, email: email, password: password);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await repo.signIn(email: email, password: password);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout()async {
    emit(AuthLoading());
    try{
      await repo.signOut();
      emit(Unauthenticated());
    } catch(e){
      emit(AuthError(e.toString()));
    }
  }
}
