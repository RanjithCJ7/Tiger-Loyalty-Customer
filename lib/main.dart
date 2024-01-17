import 'dart:convert';
import 'package:get/get.dart';
import 'package:tl_customer/screens/newUser/component/bottomtab_newuser.dart';
import 'package:tl_customer/screens/notification/controller/notification_controller.dart';
import 'src/pages/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:tl_customer/const/urls.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tl_customer/screens/signin/component/signin.dart';
import 'package:tl_customer/translation/translation_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tl_customer/screens/bottomTab/component/bottom_tab.dart';
import 'package:tl_customer/screens/newUser/component/home_newuser.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tl_customer/screens/notification/component/notification.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "id", "name",
    description: "Description", importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  requestPermission();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notificationicon');

  DarwinInitializationSettings initializationSettingsDarwin =
      const DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  LinuxInitializationSettings initializationSettingsLinux =
      const LinuxInitializationSettings(defaultActionName: 'Open notification');

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(const MyApp());
}

void requestPermission() async {
  bool check = await Permission.notification.isGranted;

  if (check == false) {
    Permission.notification.request();
  }
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  Get.to(() => const NotificationScreen());
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {
  print("onDidReceiveLocalNotification ==> ${title}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TranslationService translationService = TranslationService();

    return GetMaterialApp(
      translations: translationService,
      home: const MyHomePage(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('sw', 'TZ'),
        Locale("en"),
      ],
      locale: const Locale('sw', 'TZ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getToken().then((value) {
      Params.fcmToken = value ?? "";
      print("fcm token ==> $value");
    });

    FirebaseMessaging.instance.subscribeToTopic('all_users');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification remoteNotification = message.notification!;

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.data["post_id"]}');
      }

      flutterLocalNotificationsPlugin.show(
        remoteNotification.hashCode,
        remoteNotification.title,
        remoteNotification.body,

        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id, '',
            channelDescription: channel.description,
            playSound: true,
            icon: 'notificationicon',

            largeIcon:
                const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
            // subText: channel.name,
            groupKey: channel.id,
            setAsGroupSummary: true,
            groupAlertBehavior: GroupAlertBehavior.children,
          ),
        ),
        // payload: action
      );
      notificationController.fetchNotification();
    });

    ///redirect when app is in foreground
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      await Get.to(() => const NotificationScreen());
    });

    SetSharedPref().getData().then((value) {
      refreshToken();
      if (Params.language == "English") {
        Get.updateLocale(const Locale('en'));
      } else {
        Get.updateLocale(const Locale('sw'));
      }
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (Params.tempToken != "null" &&
          checkTokenExpiry(Params.tokenExpiry) == false) {
        Get.offAll(() => const BottomTabNewUser(), binding: InitialBinding());
      } else {
        // SetSharedPref().clearData();
        Params.userToken != "null"
            ? Get.offAll(() => const BottomTab(), binding: InitialBinding())
            : Get.offAll(() => const Home_NewUser(), binding: InitialBinding());
      }
    });
  }

  bool checkTokenExpiry(String date) {
    DateTime inputDate = DateTime.parse(date);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(inputDate);
    bool isMoreThan7Days = difference.inDays > 7;
    print("Is more than 7 days: $isMoreThan7Days");
    return isMoreThan7Days;
  }

  refreshToken() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      if (Params.userToken != "null") {
        var request = http.Request('POST', Uri.parse(Urls.refreshToken));
        request.body = json.encode({"refreshToken": Params.refreshToken});
        request.headers.addAll({'Content-Type': 'application/json'});

        http.StreamedResponse response = await request.send();
        var decodeData = await http.Response.fromStream(response);
        final result = jsonDecode(decodeData.body);
        print("refresh token response ==> $result");

        if (response.statusCode == 200) {
          pref.setString("token", result["token"]);
          pref.setString("refreshToken", result["refreshToken"]);
          Params.userToken = result["token"];
          Params.refreshToken = result["refreshToken"];
        } else {
          SetSharedPref().clearData();
          Get.offAll(() => SignIn(), binding: InitialBinding());
        }
      }
    } catch (e) {
      SetSharedPref().clearData();
      Get.offAll(() => SignIn(), binding: InitialBinding());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Image.asset(
          Images.loadingGIF,
          height: 50,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash.png'),
            const SizedBox(height: 15.0),
            Text(
              'one_app'.tr,
              style: splashText,
            ),
          ],
        ),
      ),
    );
  }
}
