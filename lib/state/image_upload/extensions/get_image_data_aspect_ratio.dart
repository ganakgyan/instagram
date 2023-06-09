import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone/state/image_upload/extensions/get_image_aspect_ratio.dart';

extension GetImageDataAspectRatio on Uint8List {
  Future<double> getAspectRatio() async {
    return Image.memory(this).getAspectRatio();
  }
}
