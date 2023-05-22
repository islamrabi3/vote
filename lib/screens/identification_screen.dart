import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voting_app/controller/cubit/register_cubit/register_cubit.dart';
import 'package:voting_app/core/global.dart';
import 'package:voting_app/screens/home_layout_screen.dart';
import 'package:voting_app/screens/login_screen.dart';
import 'package:voting_app/screens/voting_screen.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({super.key});

  @override
  State<IdentificationScreen> createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  var addedSuccessfully = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is UploadImageSuccessState) {
          setState(() {
            addedSuccessfully = 'Uploaded Successfully';
            navigateAndRemove(context, const HomeLayout());
            Fluttertoast.showToast(
                msg: 'Congratulations ! Your account has been verified');
          });
        }
        if (state is UploadImageLoadingState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Verifying'),
                  CircularProgressIndicator()
                ],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<RegisterCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Identification Screen'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Upload Your Face ID ',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Image.asset('assets/images/face_id.png'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          cubit.pickProfileImage(ImageSource.camera, context);
                        },
                        child: const Text('Camera')),
                    TextButton(
                        onPressed: () {
                          cubit.pickProfileImage(ImageSource.gallery, context);
                        },
                        child: const Text('Gallery')),
                    Text(addedSuccessfully)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
