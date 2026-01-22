import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'share_card_generator.dart';

class ShareService {
  static Future<void> shareScore(int score) async {
    final img = await ShareCardGenerator.generate(score);
    final data = await img.toByteData(format: ImageByteFormat.png);
    if (data == null) return;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/score.png');
    await file.writeAsBytes(Uint8List.view(data.buffer));

    await Share.shareXFiles([XFile(file.path)], text: 'Can you beat my score?');
  }
}
