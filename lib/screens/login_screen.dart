import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/controller/cubit/login_cubit/login_cubit.dart';
import 'package:voting_app/screens/home_layout_screen.dart';
import 'package:voting_app/screens/register_screen.dart';
import 'package:voting_app/screens/voting_screen.dart';

import '../core/global.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.grey[100],
            elevation: 0.0,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOGIN NOW !',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),

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

                      const SizedBox(
                        height: 20.0,
                      ),
                      // if (state is RegisterLoadingState)
                      //   CircularProgressIndicator(),
                      state is LoginLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : defaultButton(
                              function: () async {
                                if (formKey.currentState!.validate()) {
                                  cubit.login(emailController.text,
                                      passwordController.text, context);
                                } else {
                                  print('There is An Error !!');
                                }
                              },
                              text: 'LOGIN NOW !'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultButton(
                          function: () {
                            navigateAndRemove(context, RegisterScreen());
                          },
                          text: 'REGISTER NOW')
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
