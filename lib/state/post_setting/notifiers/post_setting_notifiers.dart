import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post_setting/model/post_setting.dart';

class PostSettingNotifiers extends StateNotifier<Map<PostSetting, bool>> {
  PostSettingNotifiers()
      : super(
          UnmodifiableMapView(
            {for (final setting in PostSetting.values) setting: true},
          ),
        );

  void setSetting(
    PostSetting setting,
    bool value,
  ) {
    final existingValue = state[setting];
    if (existingValue == null || value == existingValue) {
      return;
    } else {
      state = Map.unmodifiable(
        Map.from(state)..[setting] = value,
      );
    }
  }
}
