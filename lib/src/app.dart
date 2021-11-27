import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/account_images_cubit.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/favorite_images_cubit.dart';
import 'cubit/search_cubit.dart';
import 'cubit/selection_cubit.dart';
import 'root_widget.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'From Imgur',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
            BlocProvider<SelectionCubit>(create: (_) => SelectionCubit()),
            BlocProvider<AccountImagesCubit>(create: (_) => AccountImagesCubit()),
            BlocProvider<FavoriteImagesCubit>(create: (_) => FavoriteImagesCubit()),
            BlocProvider<SearchCubit>(create: (_) => SearchCubit()),
          ],
          child: const RootWidget(),
        ),
    );
  }
}