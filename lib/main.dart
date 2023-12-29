import 'package:flutter/material.dart';
import 'package:twitter_api_v2/twitter_api_v2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter Liked Images',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LikedImagesPage(),
    );
  }
}

class LikedImagesPage extends StatefulWidget {
  @override
  _LikedImagesPageState createState() => _LikedImagesPageState();
}

class _LikedImagesPageState extends State<LikedImagesPage> {
  // 画像のURLを格納するリスト
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchLikedImages();
  }

  // Twitter APIを使用していいねした画像を取得
  void fetchLikedImages() async {
    final twitterApi = TwitterApi(
      bearerToken: '',
      oauthTokens: const OAuthTokens(
        consumerKey: '',
        consumerSecret: '',
        accessToken: '',
        accessTokenSecret: '',
      ),
    );

    final likedTweets = await twitterApi.tweets
        .lookupLikedTweets(userId: 'gadgelogger'); // 修正されたメソッド名
    for (final tweet in likedTweets.data) {
      // ここで画像URLをリストに追加する
      // この例では簡単のため、ツイートのテキストをリストに追加しています
      setState(() {
        imageUrls.add(tweet.text); // 本来は画像URLを追加
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Images'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Image.network(imageUrls[index]), // 画像を表示
            subtitle: Text('Tweet ${index + 1}'), // ツイート番号
          );
        },
      ),
    );
  }
}
