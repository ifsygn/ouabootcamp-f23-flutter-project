import 'dart:math';

class RandomUtil {
  static String generateRandomString(int length) {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String result = '';

    for (int i = 0; i < length; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

  static int generateRandomNumber(int length) {
    final random = Random();
    return random.nextInt(length) + 1;
  }
}