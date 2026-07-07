class BookModel {
  final String? thumbnail;
  final String title;
  final String author;
  final double? price;
  final double? averageRating;
  final int? ratingCount;
  final String? buyLink;
  final String? previewLink;

  BookModel({
    required this.thumbnail,
    required this.title,
    required this.author,
    required this.price,
    required this.averageRating,
    required this.ratingCount,
    required this.buyLink,
    required this.previewLink,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json["volumeInfo"] ?? {};
    final saleInfo = json["saleInfo"];
    return BookModel(
      thumbnail: volumeInfo["imageLinks"]?["thumbnail"],
      title: volumeInfo["title"] ?? "Unknown Title",
      author: (volumeInfo["authors"] as List?)?.join(', ') ?? 'Unknown',
      price: (saleInfo?["listPrice"]?["amount"] as num?)?.toDouble(),
      averageRating: (volumeInfo["averageRating"] as num?)?.toDouble(),
      ratingCount: volumeInfo["ratingsCount"] ?? 0,
      buyLink: saleInfo?["buyLink"],
      previewLink: volumeInfo?["previewLink"],
    );
  }
}
