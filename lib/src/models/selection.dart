import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:equatable/equatable.dart';

class Selection extends Equatable {
  Selection(Iterable<String> imageCollection) :
    images = ISet<String>(imageCollection);

  const Selection.fromSet(this.images);

  final ISet<String> images;

  Selection addImage(String image) {
    return Selection.fromSet(images.add(image));
  }

  Selection removeImage(String image) {
    return Selection.fromSet(images.remove(image));
  }

  bool hasImage(String image) {
    return images.contains(image);
  }

  bool get isEmpty => images.isEmpty;

  int get size => images.length;

  List<String> get list => images.toList();

  @override
  List<Object> get props => <Object>[images];
}