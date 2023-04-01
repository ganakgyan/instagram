import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comment/notifiers/delete_comment_notifier.dart';
import 'package:instagram_clone/state/image_upload/typedef/is_loading.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentStateNotifier, IsLoading>(
  (_) => DeleteCommentStateNotifier(),
);
