import 'package:flutter_test/flutter_test.dart';
import 'package:loop_and_lace/main.dart';

void main() {
  testWidgets('App loads Customer Home as default root', (WidgetTester tester) async {
    await tester.pumpWidget(const LoopAndLaceApp());
    expect(find.text('Hello, Arbab'), findsOneWidget);
    expect(find.text('Trending handmade'), findsOneWidget);
  });
}
