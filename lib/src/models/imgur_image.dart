import 'package:json_annotation/json_annotation.dart';
import 'image_info.dart';

part 'imgur_image.g.dart';

@JsonSerializable()
class ImgurImage {
    ImgurImage(this.username, this.title, this.id, this.comments, this.cover, this.downs,
        this.ups, this.views, this.imagesInfo, this.isFavorite);

    factory ImgurImage.fromJson(Map<String, dynamic> json) {
        try {
            return _$ImgurImageFromJson(json);
        } catch (err) {
            print('Could not parse JSON: $json');
            rethrow;
        }
    }

    String id;
    String? title;
    String? cover;
    @JsonKey(name: 'account_url')
    String username;
    int views;
    int? ups;
    int? downs;
    @JsonKey(name: 'comment_count')
    int? comments;
    @JsonKey(name: 'images')
    List<ImageInfo>? imagesInfo;
    @JsonKey(name: 'favorite')
    bool isFavorite;
    String? vote;

    String get extension => imagesInfo?.elementAt(0).type.split('/')[1] ?? 'jpg';

    String get filename => '${cover ?? id}.$extension';

    String get thumbnail => '${cover ?? id}l.$extension';

    Map<String, dynamic> toJson() => _$ImgurImageToJson(this);
}