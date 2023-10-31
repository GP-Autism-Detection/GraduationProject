import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;

class LocalizationChecker {
  static changeLanguage(BuildContext context) {
    Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;

    if (currentLocal == const Locale('en', 'US')) {
      final LocalAr = Locale('ar', 'AE');
      EasyLocalization.of(context)!.setLocale(const Locale('ar', 'AE'));
      Get.updateLocale(LocalAr);
    } else {
      final LocaleEn = Locale('en', 'US');
      EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
      Get.updateLocale(LocaleEn);
    }
  }
}
