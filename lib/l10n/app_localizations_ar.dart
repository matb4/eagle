// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get myBirds => 'طيوري';

  @override
  String get birdDetails => 'تفاصيل الطائر';

  @override
  String get addBird => 'إضافة طائر';

  @override
  String get editBird => 'تعديل بيانات الطائر';

  @override
  String get analytics => 'تحليلات الأداء';

  @override
  String get hoodGenerator => 'مولد تصميم البرقع';

  @override
  String get trainingGuide => 'دليل التدريب';

  @override
  String get noBirdsAdded => 'لم يتم إضافة طيور بعد.';

  @override
  String errorOccurred(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get name => 'الاسم';

  @override
  String get type => 'النوع (مثال: صقر/عقاب)';

  @override
  String get initialWeight => 'الوزن الأولي (بالجرام)';

  @override
  String get sex => 'الجنس';

  @override
  String get generalNotes => 'ملاحظات عامة (اختياري)';

  @override
  String get healthRecords => 'السجل الصحي (اختياري)';

  @override
  String get behavioralNotes => 'ملاحظات سلوكية (اختياري)';

  @override
  String get addBirdButton => 'إضافة الطائر';

  @override
  String get editBirdButton => 'حفظ التعديلات';

  @override
  String get selectImage => 'اختيار صورة';

  @override
  String get changeImage => 'تغيير الصورة';

  @override
  String get pleaseEnterName => 'الرجاء إدخال الاسم';

  @override
  String get pleaseEnterType => 'الرجاء إدخال النوع';

  @override
  String get pleaseEnterWeight => 'الرجاء إدخال الوزن';

  @override
  String get pleaseEnterSex => 'الرجاء إدخال الجنس';
}
