import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../pages/shared/models/user_view_model.dart';

class CustomScaffoldRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: utils.baseUrlApi,
    ),
  );

  Future<Either<String, UserViewModel>> getAdminInfo() async {
    try {
      final Response result =
          await _dio.get(utils.endPointUrlApiUsers, queryParameters: {
        'isAdmin': true,
      });

      return Right(
        UserViewModel.fromJson((result.data as List<dynamic>).first),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserViewModel>> getUserInfo(
    final String userName,
    final String password,
  ) async {
    try {
      final Response result =
          await _dio.get(utils.endPointUrlApiUsers, queryParameters: {
        'userName': userName,
        'password': password,
      });

      return Right(
        UserViewModel.fromJson((result.data as List<dynamic>).first),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
