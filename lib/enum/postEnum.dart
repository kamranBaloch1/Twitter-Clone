enum PostEnum {
  text("text"),
  image("image"),
  video("video");

  const PostEnum(this.type);
  final String type;
}

extension ConvertPost on String {
  PostEnum toEnum() {
    switch (this) {
      case "image":
        return PostEnum.image;
      case "video":
        return PostEnum.video;
      case "text":
        return PostEnum.text;
      default:
        return PostEnum.image;
    }
  }
}
