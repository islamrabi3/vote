import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/controller/cubit/app_cubit/app_cubit.dart';
import 'package:voting_app/screens/profile_screen.dart';
import 'package:voting_app/screens/voting_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> screens = [VotingScreen(), ProfileScreen()];
  List<String> screenTitles = ['Don`t miss your vote !', 'Profile'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: currentIndex == 1
                ? Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Verified Account '),
                        SizedBox(
                          height: 30.0,
                          width: 20.0,
                          child: Image.asset(
                            'assets/images/PngItem_3024199.png',
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(screenTitles[currentIndex]),
          ),
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.how_to_vote),
                  label: 'Voting',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ]),
        );
      },
    );
  }
}
