import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_kit.dart';

class Mp4Exporter {
  static Future<File?> imagesToMp4(List<File> images) async {
    if (images.isEmpty) return null;

    final dir = await getTemporaryDirectory();
    final workDir = Directory('${dir.path}/mp4frames');

    if (await workDir.exists()) {
      await workDir.delete(recursive: true);
    }
    await workDir.create();

    // copy frames as sequence
    for (int i = 0; i < images.length; i++) {
      final target = File(
        '${workDir.path}/frame_${i.toString().padLeft(4, '0')}.png',
      );
      await images[i].copy(target.path);
    }

    final outFile = File('${dir.path}/replay_${DateTime.now().millisecondsSinceEpoch}.mp4');

    final cmd =
        '-y -framerate 30 -i ${workDir.path}/frame_%04d.png '
        '-vf scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2 '
        '-c:v libx264 -pix_fmt yuv420p ${outFile.path}';

    await FFmpegKit.execute(cmd);

    if (await outFile.exists()) {
      return outFile;
    }
    return null;
  }
}
