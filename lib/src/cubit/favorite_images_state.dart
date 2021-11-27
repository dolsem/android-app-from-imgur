part of 'favorite_images_cubit.dart';

@immutable
abstract class FavoriteImagesState extends Equatable {
  const FavoriteImagesState();
}

class FavoriteImagesInitial extends FavoriteImagesState {
  const FavoriteImagesInitial();

  @override
  List<Object> get props => <Object>[];
}

class FavoriteImagesFetched extends FavoriteImagesState {
  const FavoriteImagesFetched(this.gallery);

  final ImgurGallery gallery;

  @override
  List<Object> get props => <Object>[gallery];
}