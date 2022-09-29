import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharmacy/src/pages/sign_up/models/insert_user_dto.dart';

import '../../../pages/shared/user_view_model.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class SignUpRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: utils.baseUrlApi,
    ),
  );

  Future<Either<String, UserViewModel>> signUpUser(
      final InsertUserDto dto) async {
    try {
      final Response result = await _dio.post(
        '/Users',
        data: dto.toJson(),
      );

      return Right(UserViewModel.fromJson(result.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
