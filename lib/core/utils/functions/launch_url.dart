import 'package:bookly_app/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomUrl(BuildContext context, String? url) async {
  if (url == null || url.isEmpty) {
    showSnackBar(context, 'Link is not available');
    return;
  }
  final uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication,);
  } else {
    showSnackBar(context, 'Unable to open this link');
  }
}
