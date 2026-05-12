import 'package:sqlite3/sqlite3.dart';
import 'package:dart_application_1/domain/models/IncriminatedArticles.dart';

class IncriminatedArticleRepository {
  final Database db;

  IncriminatedArticleRepository(this.db);

  void insert(IncriminatedArticle article) {
    final map = article.toMap();
    db.execute('''
      INSERT OR REPLACE INTO incriminated_articles (
        ID_incr_articles, 
        incriminated_articles
      ) VALUES (?, ?)
    ''', [
      map["ID_incr_articles"],
      map["incriminated_articles"],
    ]);
  }

  List<IncriminatedArticle> getAll() {
    final ResultSet results = db.select('SELECT * FROM incriminated_articles');
    return results.map((row) => IncriminatedArticle.fromMap(row)).toList();
  }

  void delete(String id) {
    db.execute('DELETE FROM incriminated_articles WHERE ID_incr_articles = ?', [int.parse(id)]);
  }

  IncriminatedArticle? getById(String id) {
    final result = db.select('SELECT * FROM incriminated_articles WHERE ID_incr_articles = ?', [int.parse(id)]);
    return result.isNotEmpty ? IncriminatedArticle.fromMap(result.first) : null;
  }
}