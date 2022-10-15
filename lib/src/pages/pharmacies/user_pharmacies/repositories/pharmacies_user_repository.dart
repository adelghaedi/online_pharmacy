import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../infrastructure/utils/utils.dart' as utils;
import '../../../shared/models/pharmacy_view_model.dart';

class PharmaciesUserRepository {
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

  Future<Either<String, List<PharmacyViewModel>>> searchPharmacies({
    final String pharmacyName = '',
    final String doctorName = '',
    final String fromDate = '',
    final String untilDate = '',
  }) async {
    try {
      final Response result;

      if (fromDate.isNotEmpty && untilDate.isNotEmpty) {
        result = await _dio.get(
            '${utils.endPointUrlApiPharmacies}?${utils.nameLikeSearchQuery}=$pharmacyName&${utils.doctorNameLikeSearchQuery}=$doctorName&${utils.dateOfEstablishmentGteSearchQuery}=$fromDate&${utils.dateOfEstablishmentLteSearchQuery}=$untilDate');
      } else if (untilDate.isNotEmpty) {
        result = await _dio.get(
            '${utils.endPointUrlApiPharmacies}?${utils.nameLikeSearchQuery}=$pharmacyName&${utils.doctorNameLikeSearchQuery}=$doctorName&${utils.dateOfEstablishmentLteSearchQuery}=$untilDate');
      } else if (fromDate.isNotEmpty) {
        result = await _dio.get(
            '${utils.endPointUrlApiPharmacies}?${utils.nameLikeSearchQuery}=$pharmacyName&${utils.doctorNameLikeSearchQuery}=$doctorName&${utils.dateOfEstablishmentGteSearchQuery}=$fromDate');
      } else {
        result = await _dio.get(
            '${utils.endPointUrlApiPharmacies}?${utils.nameLikeSearchQuery}=$pharmacyName&${utils.doctorNameLikeSearchQuery}=$doctorName');
      }

      return Right(
        (result.data as List<dynamic>)
            .map(
              (json) => PharmacyViewModel.fromJson(
                json,
              ),
            )
            .toList(),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }
}
