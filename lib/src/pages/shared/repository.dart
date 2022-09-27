import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../infrastructure/utils/utils.dart' as utils;
import 'user_view_model.dart';

class Repository {
  final Dio _dio = Dio(BaseOptions(baseUrl: utils.baseUrlApi));

  Future<Either<String, UserViewModel>> login(
      final String userName, final String password) async {
    try {
      final Response result = await _dio.get('/Users',
          queryParameters: {'userName': userName, 'password': password});

      return Right(UserViewModel.fromJson(result.data.first));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
