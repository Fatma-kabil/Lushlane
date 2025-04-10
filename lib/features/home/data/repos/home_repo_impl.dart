import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lushlane_app/core/errors/failures.dart';
import 'package:lushlane_app/core/utils/api_service.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/home/data/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final ApiService apiService;

  HomeRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<PotsModel>>> fetchpots() async {
    try {
      var data = await apiService.getPots(
        endpoint: 'https://67f64d3542d6c71cca616a82.mockapi.io/pots',
      );

      List<PotsModel> pots =
          (data).map((item) => PotsModel.fromJson(item)).toList();

      return right(pots);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
