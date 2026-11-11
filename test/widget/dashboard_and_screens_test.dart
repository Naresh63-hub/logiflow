import 'dart:async';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logistics_app/core/database/app_database.dart';
import 'package:logistics_app/core/database/database_provider.dart';
import 'package:logistics_app/core/localization/app_localizations.dart';
import 'package:logistics_app/core/network/connectivity_service.dart';
import 'package:logistics_app/core/sync/sync_engine.dart';
import 'package:logistics_app/core/sync/sync_operation.dart';
import 'package:logistics_app/features/shipments/presentation/create_shipment_screen.dart';
import 'package:logistics_app/features/shipments/presentation/shipment_list_screen.dart';

class FakeConnectivityService implements ConnectivityService {
  @override
  Stream<NetworkStatus> get statusStream => Stream.value(NetworkStatus.online);

  @override
  Future<bool> isConnected() async => true;

  @override
  void dispose() {}
}

class FakeSyncEngine extends StateNotifier<SyncState> implements SyncEngine {
  FakeSyncEngine() : super(const SyncState());

  @override
  Future<void> enqueueOperation(SyncOperationModel op) async {}

  @override
  Future<void> syncNow() async {}
}

Widget createTestWrapper(Widget child, AppDatabase db) {
  final fakeConnectivity = FakeConnectivityService();

  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      connectivityServiceProvider.overrideWithValue(fakeConnectivity),
      isOnlineProvider.overrideWithValue(true),
      syncEngineProvider.overrideWith((ref) => FakeSyncEngine()),
    ],
    child: MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('ShipmentListScreen renders search field and filter chips', (tester) async {
    await tester.pumpWidget(createTestWrapper(const ShipmentListScreen(), db));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('In Transit'), findsOneWidget);
    expect(find.text('Delivered'), findsOneWidget);
    expect(find.text('Create Shipment'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 100));
  });

  testWidgets('CreateShipmentScreen renders sender, receiver, and package input sections', (tester) async {
    await tester.pumpWidget(createTestWrapper(const CreateShipmentScreen(), db));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('New Consignment'), findsOneWidget);
    expect(find.text('Sender Information'), findsOneWidget);
    expect(find.text('Receiver Information'), findsOneWidget);
    expect(find.text('Package Specifications'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 100));
  });
}
