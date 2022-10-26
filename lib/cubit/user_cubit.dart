// ignore_for_file: overridden_fields

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user_generator/model/user_model.dart';

import 'package:random_user_generator/repositories/user_repo.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit({required this.userRepo}) : super(LoadingState(model: UserModel()));
  final UserRepo userRepo;

  Future<void> getRandomUser({String? mode}) async {
    try {
      emit(LoadingState(model: state.model));
      Future.delayed(const Duration(milliseconds: 800));
      final result = await userRepo.getRandomUser(mode: mode);
      emit(SuccessState(model: result));
    } catch (e) {
      emit(ErrorState(model: state.model));
    }
  }
}

abstract class UserStates {
  final UserModel model;

  UserStates({required this.model});
}

class LoadingState extends UserStates {
  @override
  final UserModel model;

  LoadingState({required this.model}) : super(model: model);
}

class InitState extends UserStates {
  @override
  final UserModel model;

  InitState({required this.model}) : super(model: model);
}

class SuccessState extends UserStates {
  @override
  final UserModel model;

  SuccessState({required this.model}) : super(model: model);
}

class ErrorState extends UserStates {
  @override
  final UserModel model;

  ErrorState({required this.model}) : super(model: model);
}
