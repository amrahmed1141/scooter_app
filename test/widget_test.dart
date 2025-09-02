// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scooter_app/data/model/user_model.dart';
import 'package:scooter_app/domain/repository/auth_repository.dart';

import 'package:scooter_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final fake = FakeAuthRepository();

    await tester.pumpWidget(MyApp(authRepository: fake));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

class FakeAuthRepository implements AuthRepository {
  UserModel? _current;

  @override
  UserModel? get currentUser => _current;

  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    _current = UserModel(id: 'u1', name: 'Test User', email: email);
    return _current!;
  }

  @override
  Future<UserModel> signUp(
      {required String name,
      required String email,
      required String password}) async {
    _current = UserModel(id: 'u2', name: name, email: email);
    return _current!;
  }

  @override
  Future<UserModel> signOut() async {
    final previousUser = _current;
    _current = null;
    // Return a dummy user if previousUser is null to satisfy non-nullable return type
    return previousUser ?? UserModel(id: 'dummy', name: 'Dummy', email: 'dummy@example.com');
  }

  @override
  Stream<UserModel?> authStateChanges() {
    // في الاختبار خليه ثابت
    return Stream<UserModel?>.value(_current);
  }
}
