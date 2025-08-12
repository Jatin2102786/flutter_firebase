import 'package:flutter/material.dart';
import 'package:flutter_firebase/Utils/firebase_messaging.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  var fcmToken =
      "e5axi_qkSIq-BbgOHyQobT:APA91bGJgTr3ynzu-V29IXA1ZxC3GeDoNQF07yLkP-ZxtwTXHvs2qnZzzGh8En2GEmMp9eqIVpDAZd0sZO27MA7KI4HBZbGeHYT2-hO7hhnPthnbf6tFfP4";

  @override
  void initState() {
    super.initState();
    print(FCM().getAccessTokens());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              FCM().sendPushNotification(
                fcmToken: fcmToken,
                title: "hello",
                body: "this is the body",
              );
            },
            child: Text("Send Message"),
          ),
        ],
      ),
    );
  }
}
