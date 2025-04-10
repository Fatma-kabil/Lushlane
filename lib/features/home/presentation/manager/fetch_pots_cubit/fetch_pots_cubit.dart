import 'package:bloc/bloc.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:meta/meta.dart';

part 'fetch_pots_state.dart';

class FetchPotsCubit extends Cubit<FetchPotsState> {
  FetchPotsCubit() : super(FetchPotsInitial());
}
