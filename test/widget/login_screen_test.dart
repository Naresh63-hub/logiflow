import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logistics_app/core/database/app_database.dart';
import 'package:logistics_app/core/database/database_provider.dart';
import 'package:logistics_app/core/localization/app_localizations.dart';
import 'package:logistics_app/features/auth/presentation/login_screen.dart';

Widget createTestLoginWidget(AppDatabase db) {
  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
    ],
    child: const MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: LoginScreen(),
    ),
  );
}

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('LoginScreen renders inputs, buttons, and demo options', (tester) async {
    await tester.pumpWidget(createTestLoginWidget(db));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify title and subtitle
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Log in to your 3PL logistics portal'), findsOneWidget);

    // Verify text fields
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verify login button and demo buttons
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Demo Shipper (Quick Fill)'), findsOneWidget);
    expect(find.text('Demo Hub Manager (Quick Fill)'), findsOneWidget);
  });

  testWidgets('Tapping Demo Shipper fills demo credentials automatically', (tester) async {
    await tester.pumpWidget(createTestLoginWidget(db));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    final demoShipperButton = find.text('Demo Shipper (Quick Fill)');
    await tester.ensureVisible(demoShipperButton);
    await tester.pumpAndSettle();
    await tester.tap(demoShipperButton);
    await tester.pumpAndSettle();

    expect(find.text('shipper@logiflow.in'), findsOneWidget);
  });
}
