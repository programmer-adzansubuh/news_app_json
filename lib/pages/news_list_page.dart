import 'package:flutter/material.dart';

import 'article.dart';
import 'article_detail_page.dart';

class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder<String>(
        future:
            DefaultAssetBundle.of(context).loadString('assets/article.json'),
        builder: (context, snapshot) {
          final List<Article> articles = parseArticles(snapshot.data);
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return _buildArticleItem(context, articles[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ArticleDetailPage.routeName,
            arguments: article);
      },
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Image.network(
          article.urlToImage,
          width: 100,
        ),
        title: Text(
          article.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(article.author),
      ),
    );
  }
}
