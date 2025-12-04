// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get myBirds => 'My Birds';

  @override
  String get birdDetails => 'Bird Details';

  @override
  String get addBird => 'Add Bird';

  @override
  String get editBird => 'Edit Bird';

  @override
  String get analytics => 'Analytics';

  @override
  String get hoodGenerator => 'Hood Generator';

  @override
  String get trainingGuide => 'Training Guide';

  @override
  String get noBirdsAdded => 'No birds have been added yet.';

  @override
  String errorOccurred(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get name => 'Name';

  @override
  String get type => 'Type (e.g., Falcon/Eagle)';

  @override
  String get initialWeight => 'Initial Weight (grams)';

  @override
  String get sex => 'Sex';

  @override
  String get generalNotes => 'General Notes (Optional)';

  @override
  String get healthRecords => 'Health Records (Optional)';

  @override
  String get behavioralNotes => 'Behavioral Notes (Optional)';

  @override
  String get addBirdButton => 'Add Bird';

  @override
  String get editBirdButton => 'Save Changes';

  @override
  String get selectImage => 'Select Image';

  @override
  String get changeImage => 'Change Image';

  @override
  String get pleaseEnterName => 'Please enter a name';

  @override
  String get pleaseEnterType => 'Please enter a type';

  @override
  String get pleaseEnterWeight => 'Please enter a weight';

  @override
  String get pleaseEnterSex => 'Please enter the sex';
}
