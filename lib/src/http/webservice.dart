import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:staff_pos_app/src/common/const.dart';
import 'package:staff_pos_app/src/common/dialogs.dart';
import 'package:staff_pos_app/src/common/global_service.dart';
import 'package:staff_pos_app/src/common/messages.dart';

class Webservice {
  Future<Map> loadHttp(context, String url, Map<String, dynamic> param) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(httpClient);
    bool conf = false;
    if (constIsTestApi == 1) {
      print('Request Url: $url \n \t\tReq: $param');
    }
    do {
      try {
        final response = await ioClient.post(Uri.parse(url),
            headers: {
              "Accept": "application/json; charset=UTF-8",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: param);
        if (constIsTestApi == 1) {
          print('\t\tRes: ${response.body}');
        }
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          if (constIsTestApi == 1) {
            print('\t\tRes: $errServerString');
          }
          conf = await Dialogs().retryOrExit(context, errServerString);
        }
      } catch (e) {
        if (constIsTestApi == 1) {
          print('\t\tRes: $errNetworkString');
        }
        conf = await Dialogs().retryOrExit(context, errNetworkString);
      }
    } while (conf);

    //exit(0);
    return {};
  }

  Future<Map> requestPost(String url, Map<String, dynamic> param) async {
    BuildContext? currentContext = GlobalService.navigatorKey.currentContext;
    bool conf = false;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(httpClient);
    do {
      try {
        final response = await ioClient.post(Uri.parse(url),
            headers: {
              "Accept": "application/json; charset=UTF-8",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: param);
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          conf = await Dialogs().retryOrExit(currentContext!, errServerString);
        }
      } catch (e) {
        if (constIsTestApi == 1) {
          print('\t\tRes: $errNetworkString');
        }
        conf = await Dialogs().retryOrExit(currentContext!, errNetworkString);
      }
    } while (conf);

    //exit(0);
    return {};
  }

  Future<void> callHttpMultiPart(
    String type,
    String url,
    String filename,
    String uploadUrl,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(http.MultipartFile(type,
        File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
        filename: uploadUrl));

    var res = await request.send();
  }
}
