enum AnimalType { shibes, cats, birds }

class NicePicture {
  String url;
  AnimalType type;

  NicePicture(String url, AnimalType type) {
    this.url = url;
    this.type = type;
  }
}
