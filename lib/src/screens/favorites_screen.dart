import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/favorite_images_cubit.dart';
import '../widgets/imgur_gallery_grid.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthState state = context.read<AuthCubit>().state;
    if (state is! AuthLoaded) {
      return Container();
    }

    final FavoriteImagesCubit cubit = context.read<FavoriteImagesCubit>();
    return BlocBuilder<FavoriteImagesCubit, FavoriteImagesState>(
        bloc: cubit..fetchFavoriteImagesIfNotPresent(),
        builder: (BuildContext context, FavoriteImagesState state) {
          return buildGallery(state, cubit.fetchFavoriteImages);
        }
    );
  }

  Widget buildGallery(FavoriteImagesState state, Future<void> Function() onRefresh) {
    if (state is FavoriteImagesFetched) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ImgurGalleryGrid(gallery: state.gallery, shrinkWrap: false),
      );
    }

    return const CircularProgressIndicator();
  }
}
