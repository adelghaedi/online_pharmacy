import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/edit_user_dto.dart';
import '../models/insert_user_dto.dart';
import '../../shared/user_view_model.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class UserRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: utils.baseUrlApi,
    ),
  );

  Future<Either<String, UserViewModel>> addUser(final InsertUserDto dto) async {
    try {
      final Response result = await _dio.post(
        utils.endPointUrlApiUsers,
        data: dto.toJson(),
      );

      return Right(UserViewModel.fromJson(result.data));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserViewModel>> editUser(
      final EditUserDto dto, final int id) async {
    try {
      final Response result = await _dio
          .patch('${utils.endPointUrlApiUsers}/$id', data: dto.toJson());

      return Right(UserViewModel.fromJson(result.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
