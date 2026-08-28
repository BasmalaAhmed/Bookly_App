import 'package:bookly_app/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomUrl(BuildContext context, String? url) async {
  if (url == null || url.isEmpty) {
    showSnackBar(context, 'Link is not available');
    return;
  }
  Uri? uri;

  try {
    uri = Uri.parse(url);
  } catch (_) {
    if(context.mounted){
      showSnackBar(context, 'Invalid link');
    }
    return;
  }

  try {
    final canLaunch = await canLaunchUrl(uri);
    if(!context.mounted) return;

    if(canLaunch){
      await launchUrl(uri, mode: LaunchMode.externalApplication,);
    } else {
      showSnackBar(context, 'Unable to open this link');
    }
  } catch (_) {
    if(context.mounted) {
      showSnackBar(context, 'Unable to open this link');
    }
  }
}
