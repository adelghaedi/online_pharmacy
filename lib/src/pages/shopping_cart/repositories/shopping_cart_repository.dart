import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructure/utils/utils.dart' as utils;
import '../../shared/models/pharmacy_view_model.dart';
import '../../shared/models/user_drugs_update_dto.dart';
import '../../shared/models/user_view_model.dart';

class ShoppingCartRepository {
  final Dio _dio=Dio(
    BaseOptions(
      baseUrl: utils.baseUrlApi,
    )
  );


  Future<Either<String, UserViewModel>> getUserWithId(final int id) async {
    try {
      final Response result =
      await _dio.get('${utils.endPointUrlApiUsers}/$id');

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

  Future<Either<String, List<PharmacyViewModel>>> getPharmaciesInfo() async {
    try {
      final Response result = await _dio.get(utils.endPointUrlApiPharmacies);

      return Right(
        (result.data as List<dynamic>)
            .map(
              (json) => PharmacyViewModel.fromJson(json),
        )
            .toList(),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  Future<Either<String, UserViewModel>> userDrugsUpdate(
      final int userId,
      final UserDrugsUpdateDto dto,
      ) async {
    try {
      final Response result = await _dio.patch(
        '${utils.endPointUrlApiUsers}/$userId',
        data: dto.toJson(),
      );

      return Right(
        UserViewModel.fromJson(result.data),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }


}