import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/selection_cubit.dart';
import '../models/imgur_gallery.dart';
import '../models/imgur_image.dart';
import '../widgets/selectable_card.dart';

const int _CROSS_AXIS_COUNT = 3;

class ImgurGalleryGrid extends StatelessWidget {
  const ImgurGalleryGrid({
    Key? key,
    required this.gallery,
    this.shrinkWrap = true,
  }) : super(key: key);

  final ImgurGallery gallery;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _CROSS_AXIS_COUNT),
      itemCount: gallery.size,
      scrollDirection: Axis.vertical,
      shrinkWrap: shrinkWrap,
      itemBuilder: imageCard,
    );
  }

  Widget imageCard(BuildContext context, int index) {
    final ImgurImage imageData = gallery.getImage(index);
    final String imageUrl = 'https://i.imgur.com/${imageData.thumbnail}';

    final SelectionCubit selectionCubit = context.watch<SelectionCubit>();

    final MediaQueryData mq = MediaQuery.of(context);
    final int maxImageWidth = mq.size.width * mq.devicePixelRatio ~/ _CROSS_AXIS_COUNT;

    return BlocBuilder<SelectionCubit, SelectionState>(
      bloc: selectionCubit,
      builder: (BuildContext context, SelectionState state) {
        final bool selected = state is SelectionPresent
          && state.selection.hasImage(imageData.filename);

        return SelectableCard(
          backgroundColor: Colors.white,
          selectionColor: Colors.amber.shade900,
          selected: selected,
            onTap: () => selectionCubit.toggleImage(imageData.filename),
            child: buildImage(imageUrl, maxImageWidth),
          );
        }
    );
  }

  FutureBuilder<bool> buildImage(String imageUrl, int maxWidth) {
    final ImageProvider image = NetworkImage(imageUrl);
    return FutureBuilder<bool>(
      future: isPortrait(image),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          ResizeImage resizedImage;
          if (snapshot.data!) {
            resizedImage = ResizeImage(image, width: maxWidth);
          } else {
            resizedImage = ResizeImage(image, height: maxWidth);
          }
          return Image(image: resizedImage, fit: BoxFit.cover);
        }
        return Container();
      },
    );
  }

  Future<bool> isPortrait(ImageProvider image) {
    final Completer<bool> completer = Completer<bool>();
    image
      .resolve(ImageConfiguration.empty)
      .addListener(ImageStreamListener((ImageInfo info, bool synchronousCall) {
        completer.complete(info.image.width < info.image.height);
      }));
    return completer.future;
  }
}