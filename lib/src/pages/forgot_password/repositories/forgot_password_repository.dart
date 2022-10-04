import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../shared/user_view_model.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class ForgotPasswordRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: utils.baseUrlApi));

  Future<Either<String, UserViewModel>> getUserInfo(
      final String userName, final String mobile) async {
    try {
      final Response result = await _dio.get(
        utils.endPointUrlApiUsers,
        queryParameters: {
          'userName': userName,
          'mobile': mobile,
        },
      );

      return Right(
        UserViewModel.fromJson(
          result.data.first,
        ),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }
}
