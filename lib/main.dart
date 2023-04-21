import 'package:cusipco/service/prowider/blood_sugar_test_service.dart';
import 'package:cusipco/service/prowider/checkup_category_provider.dart';
import 'package:cusipco/service/prowider/covid_test_service.dart';
import 'package:cusipco/service/prowider/pregnancy_test_service.dart';
import 'package:cusipco/service/prowider/vaccination_category_provider.dart';
import 'package:cusipco/service/prowider/women_health_category_provider.dart';
import 'package:cusipco/service/video_services/video_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// my
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:cusipco/routes.dart';
import 'package:cusipco/screens/main_screen/cart/cart_prowider_service.dart';
import 'package:cusipco/screens/main_screen/checkout/checkout_prowider_service.dart';
import 'package:cusipco/screens/main_screen/coupon/coupon_service.dart';
import 'package:cusipco/screens/main_screen/main_screen.dart';
import 'package:cusipco/screens/main_screen/my_account/family_members/service/family_prowider_service.dart';
import 'package:cusipco/screens/main_screen/my_account/my_appointment/appointment_detail_screen.dart';
import 'package:cusipco/screens/main_screen/my_account/my_subscription/my_subscription_sevice.dart';
import 'package:cusipco/screens/main_screen/my_account/order_detail_screen.dart';
import 'package:cusipco/screens/main_screen/my_account/referrals/referrals_service.dart';
import 'package:cusipco/service/navigation_service.dart';
import 'package:cusipco/service/prowider/doctor_category_provider.dart';
import 'package:cusipco/service/prowider/doctor_details_provider.dart';
import 'package:cusipco/service/prowider/doctor_list_provider.dart';
import 'package:cusipco/service/prowider/general_information_service.dart';
import 'package:cusipco/service/prowider/get_address_provider.dart';
import 'package:cusipco/service/prowider/get_appo_list_provider.dart';
import 'package:cusipco/service/prowider/initial_data_prowider.dart';
import 'package:cusipco/service/prowider/location_prowider_service.dart';
import 'package:cusipco/service/prowider/main_navigaton_prowider_service.dart';
import 'package:cusipco/service/prowider/order_details_provider.dart';
import 'package:cusipco/service/prowider/order_history_provider.dart';
import 'package:cusipco/service/prowider/payment_method_service.dart';
import 'package:cusipco/service/prowider/skincare_details_provider.dart';
import 'package:cusipco/service/prowider/skincare_list_provider.dart';
import 'package:cusipco/service/shared_pref_service/user_pref_service.dart';
import 'package:cusipco/service/skin_categories_service.dart';
import 'package:cusipco/service/time_slot_service/time_slot_service.dart';
import 'package:cusipco/themedata.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await Firebase.initializeApp();

  runApp(const MyApp());
  configLoading();

  FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
    print("message recieved----------- for ground");
    print(event.notification!.body);
    print(event);

    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: false,
      // Android only - API >= 28
      volume: 0.1,
      // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
    showSimpleNotification(
        Text(
          event.notification!.title.toString(),
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        subtitle: Text(
          event.notification!.body.toString(),
          style: TextStyle(fontSize: 10, color: ThemeClass.greyColor),
        ),
        trailing: InkWell(
          onTap: () {
            _NavigateToPage(event);
          },
          child: Container(
            child: Text("View"),
          ),
        ),
        background: ThemeClass.blackColor,
        duration: Duration(seconds: 3));
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message clicked!');
    _NavigateToPage(message);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

_NavigateToPage(RemoteMessage message) {
  if (message.data != null) {
    if (message.data['type'] != null && message.data['type'] == "Order") {
      Navigator.push(
        navigationService.navigationKey.currentContext!,
        MaterialPageRoute(
            builder: (context) => OrderDetailScreen(
                  id: message.data['type_id'],
                )),
      );
    } else if (message.data['type'] != null &&
        message.data['type'] == "Appoinment") {
      Navigator.push(
        navigationService.navigationKey.currentContext!,
        MaterialPageRoute(
            builder: (context) => AppointmentDetailsScreen(
                  id: message.data['type_id'],
                )),
      );
    } else {
      Navigator.push(
        navigationService.navigationKey.currentContext!,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..maskType = EasyLoadingMaskType.custom
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 50
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.white
    ..textColor = Colors.yellow
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<PaymentMethodSerivce>(
            create: (_) => PaymentMethodSerivce(),
          ),
          ChangeNotifierProvider<MainNavigationProwider>(
            create: (_) => MainNavigationProwider(),
          ),
          ChangeNotifierProvider<TimeSlotService>(
            create: (_) => TimeSlotService(),
          ),
          ChangeNotifierProvider<InitialDataService>(
            create: (_) => InitialDataService(),
          ),
          ChangeNotifierProvider<UserPrefService>(
            create: (_) => UserPrefService(),
          ),
          ChangeNotifierProvider<CardProviderService>(
            create: (_) => CardProviderService(),
          ),
          ChangeNotifierProvider<CheckOutProwider>(
            create: (_) => CheckOutProwider(),
          ),
          ChangeNotifierProvider<GetAddressService>(
            create: (_) => GetAddressService(),
          ),
          ChangeNotifierProvider<OrderHistoryServices>(
            create: (_) => OrderHistoryServices(),
          ),
          ChangeNotifierProvider<GetOrderDetailsService>(
            create: (_) => GetOrderDetailsService(),
          ),
          ChangeNotifierProvider<DoctorsCategoryService>(
            create: (_) => DoctorsCategoryService(),
          ),
          ChangeNotifierProvider<DoctorListServices>(
            create: (_) => DoctorListServices(),
          ),
          ChangeNotifierProvider<DoctorsDetailsServices>(
            create: (_) => DoctorsDetailsServices(),
          ),
          ChangeNotifierProvider<GetAppoServices>(
            create: (_) => GetAppoServices(),
          ),
          ChangeNotifierProvider<MySubscriptionService>(
            create: (_) => MySubscriptionService(),
          ),
          ChangeNotifierProvider<GeneralInfoService>(
            create: (_) => GeneralInfoService(),
          ),
          ChangeNotifierProvider<FamilyMemberService>(
            create: (_) => FamilyMemberService(),
          ),
          ChangeNotifierProvider<SkinCategoryService>(
            create: (_) => SkinCategoryService(),
          ),
          ChangeNotifierProvider<SkincareListService>(
            create: (_) => SkincareListService(),
          ),
          ChangeNotifierProvider<SkincareDetailsService>(
            create: (_) => SkincareDetailsService(),
          ),
          ChangeNotifierProvider<SkincareDetailsService>(
            create: (_) => SkincareDetailsService(),
          ),
          ChangeNotifierProvider<LocationProwiderService>(
            create: (_) => LocationProwiderService(),
          ),
          ChangeNotifierProvider<ReferralsService>(
            create: (_) => ReferralsService(),
          ),
          ChangeNotifierProvider<CouponService>(
            create: (_) => CouponService(),
          ),
          ChangeNotifierProvider<CheckupCategoryService>(
            create: (_) => CheckupCategoryService(),
          ),
          ChangeNotifierProvider<WomenHealthCategoryProvider>(
            create: (_) => WomenHealthCategoryProvider(),
          ),
          ChangeNotifierProvider<CovidTestService>(
            create: (_) => CovidTestService(),
          ),
          ChangeNotifierProvider<PregnancyTestService>(
            create: (_) => PregnancyTestService(),
          ),
          ChangeNotifierProvider<BloodSugarTestService>(
            create: (_) => BloodSugarTestService(),
          ),
          ChangeNotifierProvider<VaccinationCategoryService>(
            create: (_) => VaccinationCategoryService(),
          ),
          ChangeNotifierProvider<VideoService>(
            create: (_) => VideoService(),
          )
        ],
        child: MaterialApp(
            title: 'Cusipco',
            debugShowCheckedModeBanner: false,
            theme: ThemeClass.themeData,
            initialRoute: Routes.splashRoute,
            routes: Routes.globalRoutes,
            builder: EasyLoading.init(),
            navigatorKey: navigationService.navigationKey),
      ),
    );
  }
}
