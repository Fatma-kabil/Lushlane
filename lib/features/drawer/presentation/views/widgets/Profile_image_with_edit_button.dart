
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/profile_image_bloc_builder.dart';

class ProfileImageWithEditButton extends StatelessWidget {
  const ProfileImageWithEditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ProfileImageBlocBuilder(),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              context.read<ProfileCubit>().pickImage();
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.edit,
                size: 20,
                //  color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
