part of 'account_images_cubit.dart';

@immutable
abstract class AccountImagesState extends Equatable {
  const AccountImagesState();

}

class AccountImagesInitial extends AccountImagesState {
  const AccountImagesInitial();

  @override
  List<Object> get props => <Object>[];
}

class AccountImagesFetched extends AccountImagesState {
  const AccountImagesFetched(this.gallery);

  final ImgurGallery gallery;

  @override
  List<Object> get props => <Object>[gallery];
}