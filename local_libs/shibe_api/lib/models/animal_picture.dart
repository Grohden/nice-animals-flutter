enum AnimalType { shibes, cats, birds }

class AnimalPicture {
  String url;
  AnimalType type;

  AnimalPicture(String url, AnimalType type) {
    this.url = url;
    this.type = type;
  }
}
