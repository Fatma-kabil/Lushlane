import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/core/utils/widgets/build_password_info.dart';
import 'package:lushlane_app/core/utils/widgets/build_profile_info.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/profile_image_bloc_builder.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
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
          ),
          const SizedBox(height: 20),
          buildProfileInfo('Name', '_userName', Icons.person),
          SizedBox(height: 15.0),
          buildProfileInfo('Email', '_email', Icons.email),
            PasswordField(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // يمكنك هنا إضافة منطق لحفظ التغييرات
                print('Save Changes');
              },
              child: Text('Save Changes',style: TextStyle(color: kPrimaryColor),),),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
