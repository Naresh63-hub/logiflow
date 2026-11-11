import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_app/app/app.dart';
import 'package:logistics_app/core/database/app_database.dart';
import 'package:logistics_app/core/database/database_provider.dart';

void main() {
  testWidgets('LogiFlow Yuva App boots successfully into initial route', (WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
        ],
        child: const LogisticsApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    expect(find.byType(LogisticsApp), findsOneWidget);

    await db.close();
  });
}
