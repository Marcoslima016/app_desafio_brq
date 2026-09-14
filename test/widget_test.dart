import 'package:app_desafio_brq/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppWidget renderiza a tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const AppWidget());

    expect(find.text('Portal da Seguradora'), findsOneWidget);
  });
}
