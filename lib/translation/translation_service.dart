import 'package:get/get.dart';
import 'package:tl_customer/translation/en.dart';
import 'package:tl_customer/translation/sw.dart';

class TranslationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': englishLanguage(),
        'sw': swahiliLanguage(),
      };
}
