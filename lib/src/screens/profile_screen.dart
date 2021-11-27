import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/account_images_cubit.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/imgur_gallery_grid.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthState state = context.read<AuthCubit>().state;
    if (state is! AuthLoaded) {
      return Container();
    }

    final AccountImagesCubit cubit = context.read<AccountImagesCubit>();
    return BlocBuilder<AccountImagesCubit, AccountImagesState>(
        bloc: cubit..fetchAccountImagesIfNotPresent(),
        builder: (BuildContext context, AccountImagesState state) {
          return buildGallery(state, cubit.fetchAccountImages);
        }
    );
  }

  Widget buildGallery(AccountImagesState state, Future<void> Function() onRefresh) {
    if (state is AccountImagesFetched) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ImgurGalleryGrid(gallery: state.gallery, shrinkWrap: false),
      );
    }

    return const CircularProgressIndicator();
  }
}
