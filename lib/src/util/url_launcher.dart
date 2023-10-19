import 'package:url_launcher/url_launcher.dart';

Future<bool> tryLaunchUrl(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    return launchUrl(uri);
  }
  return false;
}
