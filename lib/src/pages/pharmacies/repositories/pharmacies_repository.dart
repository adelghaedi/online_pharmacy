import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/pharmacy_update_dto.dart';
import '../../shared/models/pharmacy_view_model.dart';
import '../models/pharmacy_insert_dto.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class PharmaciesRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: utils.baseUrlApi,
    connectTimeout: utils.timeOut,
    sendTimeout: utils.timeOut,
    receiveTimeout: utils.timeOut,
  ));

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

  Future<Either<String, PharmacyViewModel>> insertPharmacy(
      final PharmacyInsertDto dto) async {
    try {
      final Response result = await _dio.post(
        utils.endPointUrlApiPharmacies,
        data: dto.toJson(),
      );

      return Right(
        PharmacyViewModel.fromJson(
          result.data,
        ),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  Future<Either<String, dynamic>> removePharmacyWithId(final int id) async {
    try {
      final Response result = await _dio.delete(
        '${utils.endPointUrlApiPharmacies}/$id',
      );

      return Right(
        result.data,
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  Future<Either<String, PharmacyViewModel>> updatePharmacyWithId(
    final int id,
    final PharmacyUpdateDto dto,
  ) async {
    try {
      final Response result = await _dio.put(
        '${utils.endPointUrlApiPharmacies}/$id',
        data: dto.toJson(),
      );

      return Right(
        PharmacyViewModel.fromJson(
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
