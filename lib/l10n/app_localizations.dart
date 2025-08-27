import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko')
  ];

  /// No description provided for @kBeautyCompass.
  ///
  /// In en, this message translates to:
  /// **'K-Beauty Compass'**
  String get kBeautyCompass;

  /// No description provided for @stopSearchingStartDiscovering.
  ///
  /// In en, this message translates to:
  /// **'Stop searching, start discovering.'**
  String get stopSearchingStartDiscovering;

  /// No description provided for @noMoreEndlessScrolling.
  ///
  /// In en, this message translates to:
  /// **'No more endless scrolling through countless products.'**
  String get noMoreEndlessScrolling;

  /// No description provided for @personalizedForYourUniqueSkin.
  ///
  /// In en, this message translates to:
  /// **'Personalized for your unique skin.'**
  String get personalizedForYourUniqueSkin;

  /// No description provided for @recommendationsBasedOnYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Get recommendations based on your real skin profile.'**
  String get recommendationsBasedOnYourProfile;

  /// No description provided for @yourKBeautyJourneyStartsNow.
  ///
  /// In en, this message translates to:
  /// **'Your K-Beauty journey starts now.'**
  String get yourKBeautyJourneyStartsNow;

  /// No description provided for @findYourHolyGrailProducts.
  ///
  /// In en, this message translates to:
  /// **'Find your holy grail products and build the perfect routine.'**
  String get findYourHolyGrailProducts;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @findingYourBeautyCompass.
  ///
  /// In en, this message translates to:
  /// **'Finding Your Beauty Compass'**
  String get findingYourBeautyCompass;

  /// No description provided for @afterWashingYourFaceYourSkinFeels.
  ///
  /// In en, this message translates to:
  /// **'After washing your face, your skin feels...'**
  String get afterWashingYourFaceYourSkinFeels;

  /// No description provided for @tightAndDry.
  ///
  /// In en, this message translates to:
  /// **'Tight & Dry'**
  String get tightAndDry;

  /// No description provided for @smoothAndNormal.
  ///
  /// In en, this message translates to:
  /// **'Smooth & Normal'**
  String get smoothAndNormal;

  /// No description provided for @shinyAndOily.
  ///
  /// In en, this message translates to:
  /// **'Shiny & Oily'**
  String get shinyAndOily;

  /// No description provided for @whatAreYourBiggestSkinWorries.
  ///
  /// In en, this message translates to:
  /// **'What are your biggest skin worries?'**
  String get whatAreYourBiggestSkinWorries;

  /// No description provided for @acneBlemishes.
  ///
  /// In en, this message translates to:
  /// **'Acne/Blemishes'**
  String get acneBlemishes;

  /// No description provided for @pores.
  ///
  /// In en, this message translates to:
  /// **'Pores'**
  String get pores;

  /// No description provided for @wrinkles.
  ///
  /// In en, this message translates to:
  /// **'Wrinkles'**
  String get wrinkles;

  /// No description provided for @redness.
  ///
  /// In en, this message translates to:
  /// **'Redness'**
  String get redness;

  /// No description provided for @dullness.
  ///
  /// In en, this message translates to:
  /// **'Dullness'**
  String get dullness;

  /// No description provided for @whichShadeIsClosestToYourBareSkin.
  ///
  /// In en, this message translates to:
  /// **'Which shade is closest to your bare skin?'**
  String get whichShadeIsClosestToYourBareSkin;

  /// No description provided for @fair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get fair;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @tan.
  ///
  /// In en, this message translates to:
  /// **'Tan'**
  String get tan;

  /// No description provided for @deep.
  ///
  /// In en, this message translates to:
  /// **'Deep'**
  String get deep;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @findingYourPerfectMatch.
  ///
  /// In en, this message translates to:
  /// **'Finding your perfect match...'**
  String get findingYourPerfectMatch;

  /// No description provided for @todaysBeautyCompass.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Beauty Compass'**
  String get todaysBeautyCompass;

  /// No description provided for @yourPersonalizedRoutine.
  ///
  /// In en, this message translates to:
  /// **'Your Personalized Routine'**
  String get yourPersonalizedRoutine;

  /// No description provided for @legalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Legal Disclaimer'**
  String get legalDisclaimer;

  /// No description provided for @legalDisclaimerText.
  ///
  /// In en, this message translates to:
  /// **'The product recommendations provided by this app are based on a simplified algorithm and should not be considered as professional medical or dermatological advice. Affiliate links are used in this app, meaning we may earn a commission if you purchase products through our links.'**
  String get legalDisclaimerText;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @areYouSensitiveToFragrance.
  ///
  /// In en, this message translates to:
  /// **'Are you sensitive to fragrance?'**
  String get areYouSensitiveToFragrance;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @howMuchTimeForSkincare.
  ///
  /// In en, this message translates to:
  /// **'How much time do you have for your daily skincare routine?'**
  String get howMuchTimeForSkincare;

  /// No description provided for @lessThan5Minutes.
  ///
  /// In en, this message translates to:
  /// **'Less than 5 minutes'**
  String get lessThan5Minutes;

  /// No description provided for @fiveToTenMinutes.
  ///
  /// In en, this message translates to:
  /// **'5-10 minutes'**
  String get fiveToTenMinutes;

  /// No description provided for @moreThan10Minutes.
  ///
  /// In en, this message translates to:
  /// **'More than 10 minutes'**
  String get moreThan10Minutes;

  /// No description provided for @whichCountryDoYouResideIn.
  ///
  /// In en, this message translates to:
  /// **'Which country do you reside in?'**
  String get whichCountryDoYouResideIn;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @personalColor.
  ///
  /// In en, this message translates to:
  /// **'Which color palette suits you best? (Personal Color)'**
  String get personalColor;

  /// No description provided for @warmTone.
  ///
  /// In en, this message translates to:
  /// **'Warm Tone (Orange, Brown colors)'**
  String get warmTone;

  /// No description provided for @coolTone.
  ///
  /// In en, this message translates to:
  /// **'Cool Tone (Pink, Blue colors)'**
  String get coolTone;

  /// No description provided for @notSure.
  ///
  /// In en, this message translates to:
  /// **'Not Sure'**
  String get notSure;

  /// No description provided for @areYouSensitiveToSpecifics.
  ///
  /// In en, this message translates to:
  /// **'Are you sensitive to specific ingredients (e.g., fragrance, alcohol)?'**
  String get areYouSensitiveToSpecifics;

  /// No description provided for @verySensitive.
  ///
  /// In en, this message translates to:
  /// **'Yes, very sensitive'**
  String get verySensitive;

  /// No description provided for @somewhatSensitive.
  ///
  /// In en, this message translates to:
  /// **'Somewhat sensitive'**
  String get somewhatSensitive;

  /// No description provided for @notSensitive.
  ///
  /// In en, this message translates to:
  /// **'No, not at all'**
  String get notSensitive;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
