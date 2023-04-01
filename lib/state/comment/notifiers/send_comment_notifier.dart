import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comment/models/comment_payload.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/image_upload/typedef/is_loading.dart';
import 'package:instagram_clone/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

class SendCommentStateNotifier extends StateNotifier<IsLoading> {
  SendCommentStateNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> sendComment(
      {required UserId userId,
      required PostId postId,
      required String comment}) async {
    final payload =
        CommentPayload(fromUserId: userId, onPostId: postId, comment: comment);

    try {
      isLoading = true;
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
