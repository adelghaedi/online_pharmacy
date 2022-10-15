import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../infrastructure/utils/utils.dart' as utils;
import '../../../shared/models/drug_view_model.dart';
import '../models/drug_insert_dto.dart';
import '../models/drug_update_dto.dart';

class DrugsAdminRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: utils.baseUrlApi,
    connectTimeout: utils.timeOut,
    sendTimeout: utils.timeOut,
    receiveTimeout: utils.timeOut,
  ));

  Future<Either<String, List<DrugViewModel>>> getDrugsInfo() async {
    try {
      final Response result = await _dio.get(utils.endPointUrlApiDrugs);

      return Right(
        (result.data as List<dynamic>)
            .map(
              (json) => DrugViewModel.fromJson(json),
            )
            .toList(),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  Future<Either<String, dynamic>> removeDrugWithId(final int id) async {
    try {
      final Response result = await _dio.delete(
        '${utils.endPointUrlApiDrugs}/$id',
      );

      return Right(result.data);
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  Future<Either<String, DrugViewModel>> insertDrug(
    final DrugInsertDto dto,
  ) async {
    try {
      final Response result = await _dio.post(
        utils.endPointUrlApiDrugs,
        data: dto.toJson(),
      );

      return Right(
        DrugViewModel.fromJson(
          result.data,
        ),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  Future<Either<String, DrugViewModel>> updateDrugWithId(
    final int id,
    final DrugUpdateDto dto,
  ) async {
    try {
      final Response result = await _dio.put(
        '${utils.endPointUrlApiDrugs}/$id',
        data: dto.toJson(),
      );

      return Right(
        DrugViewModel.fromJson(
          result.data,
        ),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  Future<Either<String, DrugViewModel>> getDrugWithId(final int id) async {
    try {
      final Response result =
          await _dio.get('${utils.endPointUrlApiDrugs}/$id');

      return Right(
        DrugViewModel.fromJson(result.data),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }
}
