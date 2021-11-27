import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../api/imgur.dart' as imgur;
import '../models/imgur_gallery.dart';

part 'account_images_state.dart';

class AccountImagesCubit extends Cubit<AccountImagesState> {
  AccountImagesCubit() : super(const AccountImagesInitial());

  Future<void> fetchAccountImages() async {
    try {
      final ImgurGallery? gallery = await imgur.getAccountImages();
      emit(AccountImagesFetched(gallery!));
    } catch (err, stacktrace) {
      print('Error fetching account images: $err');
      print(stacktrace);
    }
  }

  Future<void> fetchAccountImagesIfNotPresent() async {
    if (state is AccountImagesInitial) {
      await fetchAccountImages();
    }
  }
}
