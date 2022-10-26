import 'package:dio/dio.dart';
import 'package:random_user_generator/model/user_model.dart';

class UserRepo {
  UserRepo({required this.dio});

  final Dio dio;

  Future<UserModel> getRandomUser({String? mode}) async {
    final result = await dio.get(
      'api/',
      queryParameters: {
        'gender': mode,
      },
    );
    return UserModel.fromJson(result.data);
  }
}
