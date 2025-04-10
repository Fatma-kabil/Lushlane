import 'package:dartz/dartz.dart';
import 'package:lushlane_app/core/errors/failures.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';

abstract class HomeRepo {
Future<Either<Failure,List<PotsModel>>>  fetchpots();
}
