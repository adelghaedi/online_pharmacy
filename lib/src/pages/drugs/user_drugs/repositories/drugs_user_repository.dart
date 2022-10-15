import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../infrastructure/utils/utils.dart' as utils;
import '../../../shared/models/drug_view_model.dart';

class DrugsUserRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: utils.baseUrlApi,
    ),
  );

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
}
