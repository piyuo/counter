import 'package:universal_io/io.dart';
import 'package:url_launcher/url_launcher.dart';

/// _lookup return true if url can be lookup
/// ```dart
/// bool result = _lookup('baidu.com');
/// ```
Future<bool> _lookup(String url) async {
  try {
    final result = await InternetAddress.lookup(url);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } catch (e) {
//    print(e);
  }
  return false;
}

/// isInternetConnected return true if internet is connected
/// ```dart
/// bool result = await isInternetConnected();
/// ```
Future<bool> isInternetConnected() async {
  return _lookup('starbucks.com');
}

/// isGoogleCloudFunctionAvailable check google cloud function can be connect
/// ```dart
/// bool result = await isGoogleCloudFunctionAvailable();
/// ```
Future<bool> isGoogleCloudFunctionAvailable() async {
  return _lookup('www.cloudfunctions.net');
}

/// openUrl open external url
/// ```dart
/// bool result = await openUrl('https://www.starbucks.com');
/// ```
Future<void> openUrl(String url) async {
  await launchUrl(
    Uri.parse(url),
  );
}

/// openUrl open external url
/// ```dart
/// bool result = await openMailTo('service@piyuo.com','my subject','my');
/// ```
Future<void> openMailTo(String to, String subject, String body) async {
  to = Uri.encodeComponent(to);
  subject = Uri.encodeComponent(subject.trim());
  body = Uri.encodeComponent(body.trim());
  final url = 'mailto:$to?Subject=$subject&body=$body';
  await openUrl(url);
}

/// openSms open sms app on mobile phone
/// ```dart
/// openSms(+123456789);
/// ```
Future<void> openSms(String phoneNumber) async {
  await openUrl('sms:$phoneNumber');
}

/// makePhoneCall make phone call on mobile phone
/// ```dart
/// makePhoneCall(+123456789);
/// ```
Future<void> makePhoneCall(String phoneNumber) async {
  await openUrl('tel:$phoneNumber');
}
