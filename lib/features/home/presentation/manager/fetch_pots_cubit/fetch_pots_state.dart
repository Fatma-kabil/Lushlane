part of 'fetch_pots_cubit.dart';

@immutable
sealed class FetchPotsState {}

final class FetchPotsInitial extends FetchPotsState {}

final class FetchPotsLoading extends FetchPotsState {}

final class FetchPotsSucsses extends FetchPotsState {
  final List<PotsModel> pots;
  FetchPotsSucsses({required this.pots});
}

final class FetchPotsFailure extends FetchPotsState {
  final String errMessage;

  FetchPotsFailure({required this.errMessage});
}
