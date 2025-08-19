class QuoteModel {
  String author;
  String quote;
  QuoteModel({
    required this.author,
    required this.quote,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> jsonData) {
    return QuoteModel(
      author: jsonData['author']??'',
      quote: jsonData['quote']??'',
    );
  }
}
