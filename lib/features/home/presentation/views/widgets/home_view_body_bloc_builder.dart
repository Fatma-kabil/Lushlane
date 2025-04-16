import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/core/utils/widgets/custom_error_widget.dart';
import 'package:lushlane_app/core/utils/widgets/loading_indecator.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/fetch_pots_cubit.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeViewBodyBlocBuilder extends StatefulWidget {
  const HomeViewBodyBlocBuilder({super.key});

  @override
  State<HomeViewBodyBlocBuilder> createState() =>
      _HomeViewBodyBlocBuilderState();
}

class _HomeViewBodyBlocBuilderState extends State<HomeViewBodyBlocBuilder> {
  void initState() {
    super.initState();
    // 🔥 Trigger the cubit
    BlocProvider.of<FetchPotsCubit>(context).fetchpots();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchPotsCubit, FetchPotsState>(
      builder: (context, state) {
        if (state is FetchPotsSucsses) {
          return HomeViewBody(pots: state.pots);
        } else if (state is FetchPotsFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return Center(child: LoadingIndecator());
        }
      },
    );
  }
}
