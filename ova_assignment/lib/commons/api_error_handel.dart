import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ova_assignment/commons/common_widgets.dart';

void httpErrorHandel(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      //always remember to decode the json response
      showsnackbar(context, jsonDecode(response.body)['msg']);

      break;
    case 500:
      showsnackbar(context, jsonDecode(response.body)['error']);

      break;
    default:
      showsnackbar(context, response.body);
      print(response.body);
  }
}
