import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../forgot_password/models/edit_password_dto.dart';
import '../../shared/user_view_model.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class ResetPasswordRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: utils.baseUrlApi,
    ),
  );

  Future<Either<String, UserViewModel>> changeUserPassword(
      final int id, final EditPasswordDto dto) async {
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
