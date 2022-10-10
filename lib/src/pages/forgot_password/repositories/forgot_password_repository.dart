import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../shared/models/user_view_model.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../models/password_update_dto.dart';

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

  Future<Either<String, UserViewModel>> changeUserPassword(
      final int id, final PasswordUpdateDto dto) async {
    try {
      final Response result = await _dio.patch(
        '${utils.endPointUrlApiUsers}/$id',
        data: dto.toJson(),
      );
      return Right(
        UserViewModel.fromJson(
          result.data,
        ),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }



}
