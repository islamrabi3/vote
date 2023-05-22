import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/controller/cubit/app_cubit/app_cubit.dart';

import 'package:voting_app/core/global.dart';
import 'package:voting_app/screens/register_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appCubit = context.read<AppCubit>();
        emailController.text = appCubit.profileUserModel!.email;
        phoneController.text = appCubit.profileUserModel!.phoneNumber;
        nameController.text = appCubit.profileUserModel!.name;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  dTextFormField(
                    enabled: false,
                    controller: emailController,
                    label: 'Email',
                    hintText: 'Email Address',
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  dTextFormField(
                    enabled: false,
                    controller: nameController,
                    label: 'User Name',
                    hintText: 'UserName ',
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  dTextFormField(
                    enabled: false,
                    controller: phoneController,
                    label: 'Email',
                    hintText: 'Email Address',
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('token');
                        // ignore: use_build_context_synchronously
                        navigateAndRemove(context, RegisterScreen());
                      },
                      child: const Text('LOG OUT'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
