import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('hi'),
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // General
      'appName': 'LogiFlow Yuva',
      'appTagline': '3PL Shipment Tracking & Proof-of-Delivery System',
      'hubNoida': 'Noida Sector 62 Central Hub',
      'loading': 'Loading...',
      'error': 'An error occurred',
      'retry': 'Retry',
      'cancel': 'Cancel',
      'save': 'Save',
      'submit': 'Submit',
      'confirm': 'Confirm',
      'search': 'Search shipments...',
      'filter': 'Filter',
      'all': 'All',
      'refresh': 'Refresh',

      // Onboarding
      'onboardingTitle1': 'End-to-End Shipment Tracking',
      'onboardingDesc1': 'Monitor real-time shipment movements from dispatch to final delivery across our Noida distribution network.',
      'onboardingTitle2': 'Offline-First Operations',
      'onboardingDesc2': 'Record pickup, transit updates, and scans even with zero internet. Auto-sync seamlessly when connected.',
      'onboardingTitle3': 'Tamper-Proof Proof-of-Delivery',
      'onboardingDesc3': 'Capture high-res photos, digital receiver signatures, and GPS coordinates with automated conflict resolution.',
      'getStarted': 'Get Started',
      'skip': 'Skip',
      'next': 'Next',

      // Authentication
      'loginTitle': 'Welcome Back',
      'loginSubtitle': 'Log in to your 3PL logistics portal',
      'email': 'Email Address',
      'password': 'Password',
      'login': 'Log In',
      'forgotPassword': 'Forgot Password?',
      'roleShipper': 'Shipper Account',
      'roleHubManager': 'Hub Manager Account',
      'demoLoginShipper': 'Demo Shipper (Quick Fill)',
      'demoLoginHubManager': 'Demo Hub Manager (Quick Fill)',
      'invalidEmail': 'Please enter a valid email address',
      'invalidPassword': 'Password must be at least 6 characters',
      'loginFailed': 'Authentication failed. Please check credentials.',

      // Navigation
      'navDashboard': 'Dashboard',
      'navShipments': 'Shipments',
      'navScan': 'Scan QR',
      'navProfile': 'Profile',
      'navSettings': 'Settings',

      // Dashboard
      'dashboardTitle': 'Logistics Overview',
      'totalShipments': 'Total Shipments',
      'inTransit': 'In Transit',
      'delivered': 'Delivered',
      'pending': 'Pending / Pickup',
      'delayed': 'Delayed',
      'recentShipments': 'Recent Shipments',
      'quickActions': 'Quick Actions',
      'newShipment': 'Create Shipment',
      'scanShipment': 'Scan Package',
      'syncNow': 'Sync Queue',
      'statusDistribution': 'Status Distribution',

      // Statuses
      'status_created': 'Created',
      'status_pickup_scheduled': 'Pickup Scheduled',
      'status_picked_up': 'Picked Up',
      'status_arrived_at_hub': 'Arrived at Hub',
      'status_in_transit': 'In Transit',
      'status_out_for_delivery': 'Out for Delivery',
      'status_delivered': 'Delivered',
      'status_delivery_failed': 'Delivery Failed',
      'status_returned': 'Returned',
      'status_cancelled': 'Cancelled',

      // Shipment Details
      'shipmentDetails': 'Shipment Details',
      'trackingNumber': 'Tracking Number',
      'senderDetails': 'Sender Information',
      'receiverDetails': 'Receiver Information',
      'pickupAddress': 'Pickup Location',
      'deliveryAddress': 'Delivery Destination',
      'packageWeight': 'Weight (kg)',
      'packageCategory': 'Category',
      'priority': 'Priority Level',
      'timeline': 'Tracking Lifecycle Timeline',
      'viewProof': 'View Proof of Delivery',
      'recordPOD': 'Record Proof of Delivery',
      'updateStatus': 'Update Status',

      // Create Shipment
      'createShipmentTitle': 'New Consignment',
      'senderName': 'Sender Full Name',
      'receiverName': 'Receiver Full Name',
      'receiverPhone': 'Receiver Contact Number',
      'selectPriority': 'Select Delivery Priority',
      'priorityStandard': 'Standard (3-5 Days)',
      'priorityExpress': 'Express (1-2 Days)',
      'priorityOvernight': 'Overnight Urgent',
      'description': 'Package Contents Description',
      'shipmentCreatedSuccess': 'Shipment created successfully!',

      // Proof of Delivery
      'podTitle': 'Proof of Delivery (POD)',
      'takePhoto': 'Capture Delivery Photo',
      'receiverSignature': 'Receiver Signature',
      'clearSignature': 'Clear Signature',
      'gpsLocation': 'GPS Coordinates',
      'fetchingGPS': 'Acquiring GPS fix...',
      'deliveryNotes': 'Delivery Notes / Remarks (Optional)',
      'submitPOD': 'Confirm & Submit POD',
      'podSavedOffline': 'POD recorded offline. Queued for background synchronization.',

      // QR Scanner
      'scannerTitle': 'Shipment Barcode Scanner',
      'pointCamera': 'Align barcode / QR code within the frame to scan',
      'flashToggle': 'Toggle Flash',
      'scannedCode': 'Scanned Tracking ID',

      // Profile & Settings
      'profileTitle': 'My Profile',
      'role': 'Assigned Role',
      'assignedHub': 'Central Hub',
      'logout': 'Sign Out',
      'theme': 'Appearance Theme',
      'themeSystem': 'System Default',
      'themeLight': 'Light Theme',
      'themeDark': 'Dark Theme',
      'language': 'Language / भाषा',
      'syncStatus': 'Offline Synchronization Queue',
      'pendingOperations': 'Pending Offline Changes',
      'manualSync': 'Trigger Manual Sync',
      'aboutApp': 'About LogiFlow Yuva',
      'appVersion': 'Version 1.0.0 (Build 20261111)',
      'developerCredit': 'YuvaIntern Logistics Mobile Application',
      'privacyPolicy': 'Privacy & Data Security Policy',
      'offlineBanner': 'Offline Mode: Local database active. Changes will auto-sync.',
      'onlineBanner': 'Online: Real-time connection active.',
      'notifications': 'Notifications',
      'notificationPrefs': 'Notification Preferences',
      'pushAlerts': 'Shipment Status Push Alerts',
      'podAlertsOnly': 'Proof of Delivery Alerts',
      'sortNewest': 'Newest First',
      'sortOldest': 'Oldest First',
      'assignDriver': 'Assign Delivery Personnel',
      'routeOverview': 'Hub Corridor & Route Overview',
    },
    'hi': {
      // General
      'appName': 'लॉजिफ़्लो युवा',
      'appTagline': '3PL शिपमेंट ट्रैकिंग एवं डिलीवरी प्रमाण प्रणाली',
      'hubNoida': 'नोएडा सेक्टर 62 मुख्य हब',
      'loading': 'लोड हो रहा है...',
      'error': 'त्रुटि उत्पन्न हुई',
      'retry': 'पुनः प्रयास करें',
      'cancel': 'रद्द करें',
      'save': 'सुरक्षित करें',
      'submit': 'जमा करें',
      'confirm': 'पुष्टि करें',
      'search': 'शिपमेंट खोजें...',
      'filter': 'फ़िल्टर',
      'all': 'सभी',
      'refresh': 'रिफ्रेश',

      // Onboarding
      'onboardingTitle1': 'संपूर्ण शिपमेंट ट्रैकिंग',
      'onboardingDesc1': 'नोएडा वितरण नेटवर्क में प्रेषण से लेकर अंतिम डिलीवरी तक वास्तविक समय में निगरानी करें।',
      'onboardingTitle2': 'ऑफ़लाइन-प्रथम कार्यप्रणाली',
      'onboardingDesc2': 'इंटरनेट न होने पर भी पिकअप, ट्रांजिट अपडेट और स्कैन दर्ज करें। नेटवर्क आने पर स्वतः सिंक करें।',
      'onboardingTitle3': 'सुरक्षित डिलीवरी प्रमाण (POD)',
      'onboardingDesc3': 'उच्च-गुणवत्ता वाली तस्वीरें, डिजिटल हस्ताक्षर और जीपीएस निर्देशांक सुरक्षित रूप से एकत्र करें।',
      'getStarted': 'शुरू करें',
      'skip': 'छोड़ें',
      'next': 'आगे बढ़ें',

      // Authentication
      'loginTitle': 'वापसी पर स्वागत है',
      'loginSubtitle': 'अपने 3PL लॉजिस्टिक्स पोर्टल में लॉग इन करें',
      'email': 'ईमेल पता',
      'password': 'पासवर्ड',
      'login': 'लॉग इन करें',
      'forgotPassword': 'पासवर्ड भूल गए?',
      'roleShipper': 'शिपर खाता',
      'roleHubManager': 'हब प्रबंधक खाता',
      'demoLoginShipper': 'डेमो शिपर (स्वतः भरें)',
      'demoLoginHubManager': 'डेमो हब मैनेजर (स्वतः भरें)',
      'invalidEmail': 'कृपया एक मान्य ईमेल दर्ज करें',
      'invalidPassword': 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए',
      'loginFailed': 'प्रमाणीकरण विफल रहा। कृपया क्रेडेंशियल जांचें।',

      // Navigation
      'navDashboard': 'डैशबोर्ड',
      'navShipments': 'शिपमेंट्स',
      'navScan': 'QR स्कैन',
      'navProfile': 'प्रोफ़ाइल',
      'navSettings': 'सेटिंग्स',

      // Dashboard
      'dashboardTitle': 'लॉजिस्टिक्स अवलोकन',
      'totalShipments': 'कुल शिपमेंट्स',
      'inTransit': 'मार्ग में (In Transit)',
      'delivered': 'वितरित (Delivered)',
      'pending': 'लंबित / पिकअप',
      'delayed': 'विलंबित',
      'recentShipments': 'हालिया शिपमेंट्स',
      'quickActions': 'त्वरित कार्य',
      'newShipment': 'नया शिपमेंट बनाएं',
      'scanShipment': 'पैकेज स्कैन करें',
      'syncNow': 'कतार सिंक करें',
      'statusDistribution': 'स्थिति वितरण',

      // Statuses
      'status_created': 'निर्मित (Created)',
      'status_pickup_scheduled': 'पिकअप निर्धारित',
      'status_picked_up': 'उठाया गया (Picked Up)',
      'status_arrived_at_hub': 'हब पर पहुंचा',
      'status_in_transit': 'मार्ग में (In Transit)',
      'status_out_for_delivery': 'डिलीवरी के लिए निकला',
      'status_delivered': 'वितरित (Delivered)',
      'status_delivery_failed': 'डिलीवरी विफल',
      'status_returned': 'वापस किया गया',
      'status_cancelled': 'रद्द किया गया',

      // Shipment Details
      'shipmentDetails': 'शिपमेंट विवरण',
      'trackingNumber': 'ट्रैकिंग संख्या',
      'senderDetails': 'प्रेषक की जानकारी',
      'receiverDetails': 'प्राप्तकर्ता की जानकारी',
      'pickupAddress': 'पिकअप स्थान',
      'deliveryAddress': 'वितरण गंतव्य',
      'packageWeight': 'वजन (किग्रा)',
      'packageCategory': 'श्रेणी',
      'priority': 'प्राथमिकता स्तर',
      'timeline': 'ट्रैकिंग टाइमलाइन',
      'viewProof': 'डिलीवरी प्रमाण देखें',
      'recordPOD': 'डिलीवरी प्रमाण दर्ज करें',
      'updateStatus': 'स्थिति अपडेट करें',

      // Create Shipment
      'createShipmentTitle': 'नया कन्साइनमेंट',
      'senderName': 'प्रेषक का नाम',
      'receiverName': 'प्राप्तकर्ता का नाम',
      'receiverPhone': 'प्राप्तकर्ता का फोन नंबर',
      'selectPriority': 'वितरण प्राथमिकता चुनें',
      'priorityStandard': 'मानक (3-5 दिन)',
      'priorityExpress': 'एक्सप्रेस (1-2 दिन)',
      'priorityOvernight': 'रातों-रात (अति आवश्यक)',
      'description': 'सामग्री का विवरण',
      'shipmentCreatedSuccess': 'शिपमेंट सफलतापूर्वक बनाया गया!',

      // Proof of Delivery
      'podTitle': 'डिलीवरी प्रमाण (POD)',
      'takePhoto': 'डिलीवरी फोटो लें',
      'receiverSignature': 'प्राप्तकर्ता के हस्ताक्षर',
      'clearSignature': 'हस्ताक्षर साफ़ करें',
      'gpsLocation': 'जीपीएस निर्देशांक',
      'fetchingGPS': 'जीपीएस खोजा जा रहा है...',
      'deliveryNotes': 'डिलीवरी नोट / टिप्पणी (वैकल्पिक)',
      'submitPOD': 'पुष्टि करें और POD जमा करें',
      'podSavedOffline': 'POD ऑफ़लाइन सुरक्षित किया गया। सिंक कतार में जोड़ा गया।',

      // QR Scanner
      'scannerTitle': 'बारकोड स्कैनर',
      'pointCamera': 'स्कैन करने के लिए बारकोड / क्यूआर कोड फ्रेम में लाएं',
      'flashToggle': 'फ्लैश टॉगल करें',
      'scannedCode': 'स्कैन किया गया ट्रैकिंग आईडी',

      // Profile & Settings
      'profileTitle': 'मेरी प्रोफ़ाइल',
      'role': 'निर्धारित पद',
      'assignedHub': 'मुख्य हब',
      'logout': 'साइन आउट',
      'theme': 'दिखावट थीम',
      'themeSystem': 'सिस्टम डिफ़ॉल्ट',
      'themeLight': 'लाइट थीम',
      'themeDark': 'डार्क थीम',
      'language': 'भाषा / Language',
      'syncStatus': 'ऑफ़लाइन सिंक्रोनाइज़ेशन कतार',
      'pendingOperations': 'लंबित ऑफ़लाइन बदलाव',
      'manualSync': 'मैनुअल सिंक चलाएं',
      'aboutApp': 'लॉजिफ़्लो युवा के बारे में',
      'appVersion': 'संस्करण 1.0.0 (बिल्ड 20261111)',
      'developerCredit': 'युवाइन्टर्न लॉजिस्टिक्स मोबाइल एप्लीकेशन',
      'privacyPolicy': 'गोपनीयता एवं डेटा सुरक्षा नीति',
      'offlineBanner': 'ऑफ़लाइन मोड: स्थानीय डेटाबेस सक्रिय। नेटवर्क आने पर सिंक होगा।',
      'onlineBanner': 'ऑनलाइन: लाइव कनेक्शन सक्रिय।',
      'notifications': 'सूचनाएं',
      'notificationPrefs': 'सूचना प्राथमिकताएं',
      'pushAlerts': 'शिपमेंट स्थिति पुश अलर्ट',
      'podAlertsOnly': 'डिलीवरी प्रमाण (POD) अलर्ट',
      'sortNewest': 'नवीनतम पहले',
      'sortOldest': 'सबसे पुराना पहले',
      'assignDriver': 'डिलीवरी कर्मी नियुक्त करें',
      'routeOverview': 'हब कॉरिडोर एवं मार्ग विवरण',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsX on BuildContext {
  String tr(String key) => AppLocalizations.of(this).translate(key);
}
