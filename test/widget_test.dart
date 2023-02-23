// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liberate/app.dart';
import 'package:liberate/services/data_validator.dart';


void main() {

  group("Test de las funciones de datavalidator", () => {

      test('Validación de correo correcto', () {
        String email = "vargas@fundacionliberate.org.co";
        String password = "12345678";
        try{
          DataValidator.validateEmailPassword(email, password);
          expect(true, true);
        }catch(e){
          fail("Fallo prueba, error: $e");
        }
      }),

      test('Validación de correo inválido', () {
        String email = "vargas@gmail.com";
        String password = "12345678";
        try{
          DataValidator.validateEmailPassword(email, password);
          fail("Fallo prueba");
        }catch(e){
          expect(true, true);
        }
      }),

      test('Validación de contraseña inválida', () {
        String email = "vargas@fundacionliberate.org.co";
        String password = "1234567";
        try{
          DataValidator.validateEmailPassword(email, password);
          fail("Fallo prueba");
        }catch(e){
          expect(true, true);
        }
      })


  });
}
