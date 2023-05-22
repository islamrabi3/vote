import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:voting_app/controller/cubit/register_cubit/register_cubit.dart';
import 'package:voting_app/screens/identification_screen.dart';
import 'package:voting_app/screens/login_screen.dart';

import '../core/global.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<RegisterCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Register Now !',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('We with you great Communicate with others'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    dTextFormField(
                      controller: emailController,
                      textinput: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please Check your Email !';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.email,
                      label: 'Email Address',
                      hintText: 'Write Your Email here !',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    dTextFormField(
                      obsecure: true,
                      controller: passwordController,
                      textinput: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Password is too Weak';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.lock,
                      label: 'Password ',
                      hintText: 'Write Your Password here !',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    dTextFormField(
                      controller: phoneController,
                      textinput: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Check your Phone Number !';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.phone,
                      label: 'Phone',
                      hintText: 'Write Your Phone Number here !',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    dTextFormField(
                      controller: nameController,
                      textinput: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Check your Name Field !';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.person,
                      label: 'Name',
                      hintText: 'Write Your Username here !',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // if (state is RegisterLoadingState)
                    //   CircularProgressIndicator(),
                    state is ResgisterLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : defaultButton(
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                cubit
                                    .createNewUser(
                                        email: emailController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                        phoneNumber: phoneController.text)
                                    .then((value) {
                                  navigatetTo(
                                      context, const IdentificationScreen());
                                  Fluttertoast.showToast(
                                      msg: 'Registerd Successfully');
                                });
                              } else {
                                print('There is An Error !!');
                              }
                            },
                            text: 'REGISTER NOW !'),

                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      function: () => navigatetTo(context, LoginScreen()),
                      text: "LOGIN",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
