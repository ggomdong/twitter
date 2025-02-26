class ThreadModel {
  final String thread;
  final List<String> fileUrls;
  final String creatorUid;
  final int likes;
  final int comments;
  final int createdAt;
  final String creator;

  ThreadModel({
    required this.thread,
    required this.fileUrls,
    required this.creatorUid,
    required this.likes,
    required this.comments,
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
        comments = json["comments"],
        createdAt = json["createdAt"],
        creator = json["creator"];

  Map<String, dynamic> toJson() {
    return {
      "thread": thread,
      "fileUrls": fileUrls,
      "creatorUid": creatorUid,
      "likes": likes,
      "comments": comments,
      "createdAt": createdAt,
      "creator": creator,
    };
  }
}
