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

  /// No description provided for @viewProduct.
  ///
  /// In en, this message translates to:
  /// **'View Product'**
  String get viewProduct;

  /// No description provided for @rec_1.
  ///
  /// In en, this message translates to:
  /// **'Many reviews say it is effective for soothing the skin and replenishing moisture after washing.'**
  String get rec_1;

  /// No description provided for @rec_2.
  ///
  /// In en, this message translates to:
  /// **'Helps soothe and moisturize the skin, preferred as a nourishing serum.'**
  String get rec_2;

  /// No description provided for @rec_3.
  ///
  /// In en, this message translates to:
  /// **'100-hour moisturizing effect, many reviews say it is good for soothing the skin and relieving redness.'**
  String get rec_3;

  /// No description provided for @rec_4.
  ///
  /// In en, this message translates to:
  /// **'Less irritation to sensitive skin and helps form a protective barrier on the skin.'**
  String get rec_4;

  /// No description provided for @rec_5.
  ///
  /// In en, this message translates to:
  /// **'Effective for skin soothing and regeneration, suitable for sensitive skin.'**
  String get rec_5;

  /// No description provided for @rec_6.
  ///
  /// In en, this message translates to:
  /// **'Light yet deeply moisturizing, recommended for daily moisturizing.'**
  String get rec_6;

  /// No description provided for @rec_7.
  ///
  /// In en, this message translates to:
  /// **'Lightweight and provides good hydration to the skin.'**
  String get rec_7;

  /// No description provided for @rec_8.
  ///
  /// In en, this message translates to:
  /// **'Known as a highly moisturizing cream.'**
  String get rec_8;

  /// No description provided for @rec_9.
  ///
  /// In en, this message translates to:
  /// **'Water gel type, popular for dry skin due to its refreshing feel.'**
  String get rec_9;

  /// No description provided for @rec_10.
  ///
  /// In en, this message translates to:
  /// **'Hypoallergenic, suitable for sensitive skin.'**
  String get rec_10;

  /// No description provided for @rec_11.
  ///
  /// In en, this message translates to:
  /// **'Effective for strengthening the skin barrier and moisturizing.'**
  String get rec_11;

  /// No description provided for @rec_12.
  ///
  /// In en, this message translates to:
  /// **'Hypoallergenic, widely used for calming troubled skin.'**
  String get rec_12;

  /// No description provided for @rec_13.
  ///
  /// In en, this message translates to:
  /// **'An ampoule for trouble relief and soothing.'**
  String get rec_13;

  /// No description provided for @rec_14.
  ///
  /// In en, this message translates to:
  /// **'Excellent soothing effect with tea tree ingredients.'**
  String get rec_14;

  /// No description provided for @rec_15.
  ///
  /// In en, this message translates to:
  /// **'A toner for troubled skin.'**
  String get rec_15;

  /// No description provided for @rec_16.
  ///
  /// In en, this message translates to:
  /// **'Popular as a cleanser for acne-prone skin.'**
  String get rec_16;

  /// No description provided for @rec_17.
  ///
  /// In en, this message translates to:
  /// **'A treatment patch to apply on troubled areas.'**
  String get rec_17;

  /// No description provided for @rec_18.
  ///
  /// In en, this message translates to:
  /// **'Helps with exfoliation and pore care.'**
  String get rec_18;

  /// No description provided for @rec_19.
  ///
  /// In en, this message translates to:
  /// **'Well-known as an acne patch.'**
  String get rec_19;

  /// No description provided for @rec_20.
  ///
  /// In en, this message translates to:
  /// **'A gentle, hypoallergenic cleanser for acne.'**
  String get rec_20;

  /// No description provided for @rec_21.
  ///
  /// In en, this message translates to:
  /// **'For sensitive skin, with less irritation.'**
  String get rec_21;

  /// No description provided for @rec_22.
  ///
  /// In en, this message translates to:
  /// **'A cleanser suitable for sensitive skin.'**
  String get rec_22;

  /// No description provided for @rec_23.
  ///
  /// In en, this message translates to:
  /// **'Soothing and moisturizing effects.'**
  String get rec_23;

  /// No description provided for @rec_24.
  ///
  /// In en, this message translates to:
  /// **'Hypoallergenic, helps maintain skin moisture.'**
  String get rec_24;

  /// No description provided for @rec_25.
  ///
  /// In en, this message translates to:
  /// **'A balm for soothing the skin.'**
  String get rec_25;

  /// No description provided for @rec_26.
  ///
  /// In en, this message translates to:
  /// **'A gentle, hypoallergenic moisturizing cream.'**
  String get rec_26;

  /// No description provided for @rec_27.
  ///
  /// In en, this message translates to:
  /// **'Effective for skin regeneration and soothing.'**
  String get rec_27;

  /// No description provided for @rec_28.
  ///
  /// In en, this message translates to:
  /// **'A gentle, hypoallergenic cleanser.'**
  String get rec_28;

  /// No description provided for @rec_29.
  ///
  /// In en, this message translates to:
  /// **'A highly moisturizing cream for sensitive skin.'**
  String get rec_29;

  /// No description provided for @rec_30.
  ///
  /// In en, this message translates to:
  /// **'Famous as a cleansing water.'**
  String get rec_30;

  /// No description provided for @rec_31.
  ///
  /// In en, this message translates to:
  /// **'Helps with pore management and trouble relief.'**
  String get rec_31;

  /// No description provided for @rec_32.
  ///
  /// In en, this message translates to:
  /// **'Popular for exfoliating and improving wrinkles.'**
  String get rec_32;

  /// No description provided for @rec_33.
  ///
  /// In en, this message translates to:
  /// **'For gentle exfoliation.'**
  String get rec_33;

  /// No description provided for @rec_34.
  ///
  /// In en, this message translates to:
  /// **'Provides moisture and pore care.'**
  String get rec_34;

  /// No description provided for @rec_35.
  ///
  /// In en, this message translates to:
  /// **'Pore cleansing effect.'**
  String get rec_35;

  /// No description provided for @rec_36.
  ///
  /// In en, this message translates to:
  /// **'A set for elasticity and pore management.'**
  String get rec_36;

  /// No description provided for @rec_37.
  ///
  /// In en, this message translates to:
  /// **'Globally popular for exfoliation and pore care.'**
  String get rec_37;

  /// No description provided for @rec_38.
  ///
  /// In en, this message translates to:
  /// **'Exfoliates and improves skin radiance.'**
  String get rec_38;

  /// No description provided for @rec_39.
  ///
  /// In en, this message translates to:
  /// **'Exfoliation and soothing.'**
  String get rec_39;

  /// No description provided for @rec_40.
  ///
  /// In en, this message translates to:
  /// **'Whitening and wrinkle improvement effects.'**
  String get rec_40;

  /// No description provided for @rec_41.
  ///
  /// In en, this message translates to:
  /// **'A variety of anti-aging products.'**
  String get rec_41;

  /// No description provided for @rec_42.
  ///
  /// In en, this message translates to:
  /// **'Improves elasticity and provides vitality to the skin.'**
  String get rec_42;

  /// No description provided for @rec_43.
  ///
  /// In en, this message translates to:
  /// **'A cream for wrinkle improvement.'**
  String get rec_43;

  /// No description provided for @rec_44.
  ///
  /// In en, this message translates to:
  /// **'A popular anti-aging ampoule.'**
  String get rec_44;

  /// No description provided for @rec_45.
  ///
  /// In en, this message translates to:
  /// **'Contains retinol alternative ingredients to boost elasticity.'**
  String get rec_45;

  /// No description provided for @rec_46.
  ///
  /// In en, this message translates to:
  /// **'A cream for wrinkle improvement.'**
  String get rec_46;

  /// No description provided for @rec_47.
  ///
  /// In en, this message translates to:
  /// **'Supports skin elasticity with peptide ingredients.'**
  String get rec_47;

  /// No description provided for @rec_48.
  ///
  /// In en, this message translates to:
  /// **'A powerful, intensive serum for wrinkle improvement.'**
  String get rec_48;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, there are no recommended products that match your criteria. Please try the quiz again.'**
  String get noProductsFound;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;
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
