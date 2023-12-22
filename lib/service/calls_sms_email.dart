import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CallsAndMessagesService {
  void call(String number) => launchUrlString("tel://$number");
  void sendSms(String number) => launchUrlString("sms:$number");
  void sendEmail(String email) => launchUrlString("mailto:$email");

  void launchURL(url) async {
    if (!await launchUrl(Uri.parse("$url"))) throw 'Could not launch $url';
  }
}
