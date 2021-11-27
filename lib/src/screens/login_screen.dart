import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../api/imgur.dart' as imgur;
import '../cubit/auth_cubit.dart';
import '../models/auth.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const String responseType = 'token';

  final String webviewUrl = '${imgur.IMGUR_AUTH_URL}?client_id=${imgur.IMGUR_APP_ID}&response_type=$responseType';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('Sign In'),
        ),
      ),
      body: WebView(
        initialUrl: webviewUrl,
        onPageStarted: (String url) {
          final Uri uri = Uri.parse(url.replaceFirst('#', '?'));

          if (uri.query.contains('access_token')) {
            final AuthCubit authCubit = context.read<AuthCubit>();
            authCubit.setData(Auth(
              username: uri.queryParameters['account_username']!,
              accessToken: uri.queryParameters['access_token']!,
              refreshToken: uri.queryParameters['refresh_token']!,
            ));
          }
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
      ),
    );
  }
}
