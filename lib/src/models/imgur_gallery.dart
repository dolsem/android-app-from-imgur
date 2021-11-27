import 'package:json_annotation/json_annotation.dart';
import 'imgur_image.dart';

part 'imgur_gallery.g.dart';

@JsonSerializable()
class ImgurGallery {
    ImgurGallery(this.images);

    factory ImgurGallery.fromJson(Map<String, dynamic> json) => _$ImgurGalleryFromJson(json);

    @JsonKey(name: 'data')
    List<ImgurImage> images;

    int get size => images.length;

    ImgurImage getImage(int index) => images[index];

    Map<String, dynamic> toJson() => _$ImgurGalleryToJson(this);
}