import 'package:flutter_test/flutter_test.dart';
import 'package:campusapp/main.dart';

void main() {
  testWidgets('CampusGuide app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusGuideApp());

    expect(find.text('CampusGuide'), findsOneWidget);
    expect(find.text('Dersler'), findsOneWidget);
    expect(find.text('Ödevler'), findsOneWidget);
    expect(find.text('Etkinlikler'), findsOneWidget);
  });
}
