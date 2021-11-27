import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth extends Equatable {
    const Auth({
        required this.username,
        required this.accessToken,
        required this.refreshToken
    });

    factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

    final String accessToken;
    final String refreshToken;
    final String username;

    @override
    List<String> get props => <String>[accessToken, refreshToken, username];

    Map<String, dynamic> toJson() => _$AuthToJson(this);
}