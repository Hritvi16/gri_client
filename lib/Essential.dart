import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Essential {

  call(String number) async {
    print("hello");
    print("hello");
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    await launchUrl(launchUri);

  }

  link(String link) {
    launchUrlString(link);
  }

  email(String email) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!'
      }),
    );

    launchUrl(emailLaunchUri);
  }
}