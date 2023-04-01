import 'package:instagram_clone/state/image_upload/models/file_type.dart';

extension GetCollectionNameFromFileType on FileType {
  String get collectionName {
    switch (this) {
      case FileType.image:
        return 'images';
      case FileType.video:
        return 'videos';
    }
  }

  String get thumbnailName {
    return 'thumbnails';
  }
}
