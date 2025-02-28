class ThreadModel {
  final String thread;
  final List<String> fileUrls;
  final String creatorUid;
  final int likes;
  final int replies;
  final int createdAt;
  final String creator;

  ThreadModel({
    required this.thread,
    required this.fileUrls,
    required this.creatorUid,
    required this.likes,
    required this.replies,
    required this.createdAt,
    required this.creator,
  });

  ThreadModel.fromJson(Map<String, dynamic> json)
      : thread = json["thread"],
        fileUrls = (json["fileUrls"] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        creatorUid = json["creatorUid"],
        likes = json["likes"],
        replies = json["replies"],
        createdAt = json["createdAt"],
        creator = json["creator"];

  Map<String, dynamic> toJson() {
    return {
      "thread": thread,
      "fileUrls": fileUrls,
      "creatorUid": creatorUid,
      "likes": likes,
      "replies": replies,
      "createdAt": createdAt,
      "creator": creator,
    };
  }
}
