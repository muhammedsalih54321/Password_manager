import 'dart:math';

String generatepassword() {
  String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lower = 'abcdefghijklmnopqrstuvwxyz';
  String number = '12345678910';
  String symbols = '!@#\$%^&*()<>,./';
  String password = '';

  int passwordlngt = 12;

  String seed = upper + lower + number + symbols;

  List<String> list = seed.split('').toList();
  Random random = Random();

  for (int i = 0; i < passwordlngt; i++) {
    int index = random.nextInt(list.length);
    password += list[index];
  }
  return password;
}

