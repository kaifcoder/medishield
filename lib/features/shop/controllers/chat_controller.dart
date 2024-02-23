import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:medishield/utils/helpers/helper_functions.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  RxList<Message> msgs = <Message>[].obs;
  Rx<bool> isTyping = false.obs;
  int maxContextMessages = 10;
  List<Message> contextMessages = [];

  @override
  void onInit() {
    super.onInit();
    msgs.add(Message(false, "Hello! How can I help you today?"));
  }

  void sendMsg() async {
    String text = controller.text;
    String apiKey = "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";
    controller.clear();
    try {
      if (text.isNotEmpty) {
        msgs.insert(0, Message(true, text));

        isTyping.value = true;
        scrollController.animateTo(0.0,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);

        contextMessages.insert(0, Message(true, text));

        String contextPrompt = "";
        int startIndex = contextMessages.length -
            maxContextMessages; // Get starting index for recent 10 messages
        if (startIndex < 0) {
          startIndex = 0; // Handle cases with less than 10 messages
        }
        for (int i = startIndex; i < contextMessages.length; i++) {
          contextPrompt +=
              contextMessages[i].isSender ? "You: " : "Medishield Assistant: ";
          contextPrompt += "${contextMessages[i].msg}\n";
        }

        var response = await http.post(
            Uri.parse("https://api.openai.com/v1/chat/completions"),
            headers: {
              "Authorization": "Bearer $apiKey",
              "Content-Type": "application/json"
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {
                  "role": "system",
                  "content":
                      "Medishield Healthcare Assistant is a chatbot that can help you with your queries. Ask anything related to Medishield and we will try to help you out. You can ask for information about dental products. about us : Medishield HealthCare was founded in the year 2001. We supply new age Disposable products to Hospitals, clinics, laboratories, Dental Clinics, Dental Laboratories, Medical and Dental Institutions, & Government agencies, business groups, all over the world. At the early age of 24 years, Dr. Hasan Faraz started the MediShield initiative with just a little capital of 75k, after looking at the negligence in safety and hygiene by the doctors. Just as a Bachelor of Dental Surgery, he faced many shortcomings and problems during the initial days, but the blessings of his mother became his driving force. Even being a blood cancer patient, she helped him with his first consignment and encouraged him for this business, which now has a turnover of 10Cr+.  Contact detail of medishield : medishielhealthcare@gmail.com or +919889770559"
                },
                {
                  "role": "user",
                  "content":
                      'here is previous chat context: $contextPrompt now reply this $text'
                }
              ]
            }));

        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);

          isTyping.value = false;

          debugPrint(json["choices"][0]["message"]["content"].toString());
          msgs.insert(
            0,
            Message(
              false,
              json["choices"][0]["message"]["content"].toString().trimLeft(),
            ),
          );

          scrollController.animateTo(0.0,
              duration: const Duration(seconds: 1), curve: Curves.easeOut);
          update();
        } else {
          isTyping.value = false;
          THelperFunctions.showSnackBar('Something went wrong');
          update();
        }
      }
    } on Exception {
      isTyping.value = false;
      THelperFunctions.showSnackBar('Something went wrong');
    } finally {
      isTyping.value = false;
    }
  }
}

class Message {
  bool isSender;
  String msg;
  Message(this.isSender, this.msg);
}
