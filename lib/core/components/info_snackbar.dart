

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

@immutable
final class InfoSnackbar {


  static SnackBar infoSnackbar(String infoMessage,String message,Duration duration) {
    return SnackBar(
                  duration: duration,
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: infoMessage,
                    message: message,
       
                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.warning,
                  ),
                );
  }

  
}