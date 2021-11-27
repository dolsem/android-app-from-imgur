import 'package:flutter/services.dart';

const MethodChannel platform = MethodChannel('app.channel.shared.data');

void selectImages(List<String> images) {
  platform.invokeMethod<void>('selectImages', <String, List<String>>{ 'images': images });
}