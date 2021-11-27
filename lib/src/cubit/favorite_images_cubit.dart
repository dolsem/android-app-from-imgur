import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../api/imgur.dart' as imgur;
import '../models/imgur_gallery.dart';

part 'favorite_images_state.dart';

class FavoriteImagesCubit extends Cubit<FavoriteImagesState> {
  FavoriteImagesCubit() : super(const FavoriteImagesInitial());

  Future<void> fetchFavoriteImages() async {
    try {
      final ImgurGallery? gallery = await imgur.getFavoriteImages();
      emit(FavoriteImagesFetched(gallery!));
    } catch (err, stacktrace) {
      print('Error fetching favorite images: $err');
      print(stacktrace);
    }
  }

  Future<void> fetchFavoriteImagesIfNotPresent() async {
    if (state is FavoriteImagesInitial) {
      await fetchFavoriteImages();
    }
  }
}
