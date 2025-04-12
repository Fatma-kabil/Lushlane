import 'package:bloc/bloc.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/home/data/repos/home_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_pots_state.dart';

class FetchPotsCubit extends Cubit<FetchPotsState> {
  FetchPotsCubit(this.homerepo) : super(FetchPotsInitial());
  final HomeRepo homerepo;
  Future<void> fetchpots() async {
    emit(FetchPotsLoading());
    var result = await homerepo.fetchpots();

    result.fold(
      (failure) {
        emit(FetchPotsFailure(errMessage: failure.errorMessage));
      },
      (pots) {
        emit(FetchPotsSucsses(pots: pots));
      },
    );
  }
}
