import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/platform.dart' as platform;
import 'cubit/auth_cubit.dart';
import 'cubit/selection_cubit.dart';
import 'screens/discover_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/with_selection_snack_bar.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  int selectedIndex = 0;
  List<String> pageNames = <String>['Profile', 'Favorites', 'Discover'];
  List<Widget> widgetOptions = <Widget>[
    const ProfileScreen(),
    const FavoritesScreen(),
    const DiscoverScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() => selectedIndex = index);
  }

  PreferredSize appBar(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(pageNames[selectedIndex]),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout_rounded, color: Colors.white),
              onPressed: () => authCubit.signOut()
          )
        ],
      ),
    );
  }

  BottomNavigationBar navigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Discover',
        )
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.lightBlueAccent,
      unselectedItemColor: Colors.grey.shade700,
      onTap: _onTabTapped,
    );
  }

  Widget? floatingActionButton(BuildContext context) {
    return BlocBuilder<SelectionCubit, SelectionState>(
      bloc: context.read<SelectionCubit>(),
      builder: (BuildContext context, SelectionState state) {
        if (state is SelectionPresent) {
          return FloatingActionButton(
            onPressed: () {
              platform.selectImages(state.selection.list);
            },
            child: const Icon(Icons.assignment_turned_in),
            backgroundColor: Colors.green,
          );
        }
        return Container();
      }
    );
  }

  Widget page() {
    return Center(
      child: widgetOptions.elementAt(selectedIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: context.read<AuthCubit>(),
      builder: (BuildContext context, AuthState state) {
        if (state is AuthInitial) {
          return LoginScreen();
        }
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          resizeToAvoidBottomInset: false,
          appBar: appBar(context),
          body: WithSelectionSnackBar(child: page()),
          bottomNavigationBar: navigationBar(),
          floatingActionButton: floatingActionButton(context),
        );
      }
    );
  }
}
