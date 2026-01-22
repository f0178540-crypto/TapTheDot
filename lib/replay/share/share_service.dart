import 'dart:io';
import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> shareImages(List<File> images, String text) async {
    final xfiles = images.map((f) => XFile(f.path)).toList();
    await Share.shareXFiles(xfiles, text: text);
  }
}
