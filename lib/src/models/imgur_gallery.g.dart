// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imgur_gallery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImgurGallery _$ImgurGalleryFromJson(Map<String, dynamic> json) {
  return ImgurGallery(
    (json['data'] as List<dynamic>)
        .map((e) => ImgurImage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ImgurGalleryToJson(ImgurGallery instance) =>
    <String, dynamic>{
      'data': instance.images,
    };
