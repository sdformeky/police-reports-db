import 'package:dart_application_1/domain/models/Identity.dart';


class IncriminatedArticle implements Identity {
  @override
  final String id;
  final String articleName;

  IncriminatedArticle({required this.id, required this.articleName});

  Map<String, dynamic> toMap() => {
    "ID_incr_articles": int.tryParse(id),
    "incriminated_articles": articleName,
  };

  factory IncriminatedArticle.fromMap(Map<String, dynamic> map) {
    return IncriminatedArticle(
      id: map["ID_incr_articles"].toString(),
      articleName: map["incriminated_articles"] as String,
    );
  }
}