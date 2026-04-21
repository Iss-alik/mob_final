import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/moduels/navigation/bloc/navigationBloc.dart';
import 'package:mob_final/moduels/navigation/bloc/navigationEvent.dart';
import 'package:mob_final/moduels/navigation/bloc/navigationState.dart';
import 'package:mob_final/moduels/post/screens/createPostScreen.dart';
import 'package:mob_final/moduels/post/screens/postFeedScreen.dart';
import 'package:mob_final/moduels/profile/screens/profileScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{
  
  final pages = [PostFeedPage(), CreatPostPage(), ProfileScreen()];

  final items = const[
    BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
    BottomNavigationBarItem(icon: Icon(Icons.create), label: 'Create'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
  ];

  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state is NavigationSuccess? state.pageIndex: 0,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state is NavigationSuccess? state.pageIndex: 0,
            onTap: (index) {
              context.read<NavigationBloc>()
                  .add(ChangePageEvent(index));
            },
            items: items,
          ),
        );
      },
    );
  }
}