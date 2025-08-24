import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FCM {
  var accessToken = "";

  Future<String> getAccessTokens() async {
    final jsonString = await rootBundle.loadString(
      'assets/simm-a4fbf-firebase-adminsdk-fbsvc-abe30318cc.json',
    );

    final serviceAccountJson = jsonDecode(jsonString);

    // Fix the \n issue in private_key
    final fixedJsonString = jsonString.replaceAll(r'\\n', '\n');

    final accountCredentials = ServiceAccountCredentials.fromJson(
      fixedJsonString,
    );

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await clientViaServiceAccount(accountCredentials, scopes);
    final token = client.credentials.accessToken.data;

    accessToken = token;
    client.close();
    return token;
  }

  Future<void> sendPushNotification({
    required String fcmToken,
    required String title,
    required String body,
  }) async {
    await getAccessTokens();
    final url = Uri.parse(
      "https://fcm.googleapis.com/v1/projects/simm-a4fbf/messages:send",
    );

    final message = {
      "message": {
        "token": fcmToken,
        "notification": {"title": title, "body": body},
        "android": {"priority": "HIGH"},
      },
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode(message),
    );

    print("Response: ${response.statusCode}, ${response.body}");
  }
}
