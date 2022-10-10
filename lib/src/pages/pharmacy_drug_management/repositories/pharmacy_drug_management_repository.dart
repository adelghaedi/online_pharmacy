import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructure/utils/utils.dart' as utils;
import '../../shared/models/pharmacy_view_model.dart';
import '../../shared/models/drug_view_model.dart';
import '../models/pharmacy_drugs_update_dto.dart';

class PharmacyDrugManagementRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: utils.baseUrlApi,
      connectTimeout: utils.timeOut,
      receiveTimeout: utils.timeOut,
      sendTimeout: utils.timeOut,
    ),
  );

  Future<Either<String, List<DrugViewModel>>> getDrugsInfo() async {
    try {
      final Response result = await _dio.get(
        utils.endPointUrlApiDrugs,
      );

      return Right((result.data as List<dynamic>)
          .map(
            (json) => DrugViewModel.fromJson(json),
          )
          .toList());
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  Future<Either<String, PharmacyViewModel>> pharmacyDrugsUpdate(
      final int pharmacyId, final PharmacyDrugsUpdateDto dto) async {
    try {
      final Response result = await _dio.patch(
        '${utils.endPointUrlApiPharmacies}/$pharmacyId',
        data: dto.toJson(),
      );

      return Right(
        PharmacyViewModel.fromJson(
          result.data,
        ),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, PharmacyViewModel>> getPharmacyWithId(
      final int pharmacyId) async {
    try {
      final Response result = await _dio.get(
        '${utils.endPointUrlApiPharmacies}/$pharmacyId',
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
