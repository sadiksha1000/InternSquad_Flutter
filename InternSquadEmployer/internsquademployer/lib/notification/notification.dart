import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createInternshipAlertNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'InternSquad',
        body: 'Your internship posting was added!!!'),
  );
}
