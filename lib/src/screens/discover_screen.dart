import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:from_imgur/src/models/imgur_image.dart';
import 'package:from_imgur/src/widgets/search_filters.dart';

import '../cubit/search_cubit.dart';
import '../widgets/imgur_gallery_grid.dart';

class DiscoverScreen extends StatefulWidget {
    const DiscoverScreen({Key? key}) : super(key: key);

    @override
    _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
    TextEditingController? textInputController;

    @override
    void dispose() {
        textInputController!.dispose();
        super.dispose();
    }

    @override
    void initState() {
        textInputController = TextEditingController();
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          const SearchFilters(),
          createCardGrid(context)
        ],
      );
    }

    Widget createCardGrid(BuildContext context) {
      return BlocBuilder<SearchCubit, SearchState>(
        bloc: context.read<SearchCubit>(),
        builder: (BuildContext context, SearchState state) {
          if (state is SearchResultsPresent) {
            // Sort files to keep only images
            state.searchResults.images.removeWhere((ImgurImage image) {
              return image.cover == null || image.extension == 'mp4';
            });

            return Flexible(child: ImgurGalleryGrid(
              gallery: state.searchResults,
              shrinkWrap: false
            ));
          }
          return const Expanded(
            child: Center(child: CircularProgressIndicator())
          );
        }
      );
    }
}