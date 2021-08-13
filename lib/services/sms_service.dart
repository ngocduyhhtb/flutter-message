import 'package:chat_app/model/message.dart';
import 'package:get/get.dart';
import 'package:telephony/telephony.dart';

class SmsService extends GetxController {
  RxList inboxMessage = [].obs;
  RxList sentMessage = [].obs;
  var isLoading = true.obs;

  List<dynamic> getInboxMessage() {
    return inboxMessage;
  }

  @override
  void onInit() {
    loadAllInboxMessage();
    loadAllSentMessage();
    super.onInit();
  }

  void loadAllInboxMessage() async {
    List<SmsMessage> data = await Telephony.instance.getInboxSms();
    data.forEach((element) {
      inboxMessage.add(new Message(
          address: element.address.toString(),
          body: element.body.toString(),
          dateSent: element.dateSent.toString()));
    });
    update();
  }

  void loadAllSentMessage() async {
    List<SmsMessage> data = await Telephony.instance.getSentSms();
    data.forEach((element) {
      sentMessage.add(new Message(
          address: element.address.toString(),
          body: element.body.toString(),
          dateSent: element.dateSent.toString()));
    });
    update();
  }

  SmsSendStatusListener listener = (SendStatus status) {
    if (status == SendStatus.SENT) {
      print("Đang gửi");
      print(status);
    }
    if (status == SendStatus.DELIVERED) {
      print("Đã gửi");
      print(status);
    }
  };

  void sendOneMessage(String phoneNumber, String data) async {
    await Telephony.instance.sendSms(
      to: phoneNumber.toString(),
      message: data.toString(),
      statusListener: listener,
    );
    update();
    refresh();
    Get.back();
  }
}

enum Test { SENT, DELIVERED }
