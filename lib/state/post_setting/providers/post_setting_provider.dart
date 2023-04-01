import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post_setting/model/post_setting.dart';
import 'package:instagram_clone/state/post_setting/notifiers/post_setting_notifiers.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifiers, Map<PostSetting, bool>>(
  (_) => PostSettingNotifiers(),
);
