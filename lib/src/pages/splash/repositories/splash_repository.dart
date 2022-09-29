import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../pages/shared/user_view_model.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class SplashRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: utils.baseUrlApi,
      connectTimeout: 5000,
    ),
  );

  Future<Either<String, UserViewModel>> checkExistsAdmin() async {
    try {
      final Response result = await _dio.get(
        '/Users',
        queryParameters: {
          'isAdmin': true,
        },
      );

      return Right(UserViewModel.fromJson(result.data.first));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
