class Constants {
  static String coins =
      'https://suvssdhtxjfkcexensug.supabase.co/rest/v1/GameCoinsData?select=checkChestWithNewCoins';
  static String prl =
      'https://suvssdhtxjfkcexensug.supabase.co/rest/v1/GameCoinsData?select=coinsDuration';
  static String ftp = 'vwLiqtgKwqva';
  static String inftp = 'pbbxa://qxqvnw.qw/rawv';
  static String k =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN1dnNzZGh0eGpma2NleGVuc3VnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTU2MzE2OTEsImV4cCI6MjAxMTIwNzY5MX0.iGedx909lo0UbPf_fkTPoI0meeESqriW69DYAKQvOvw';
  static const int off = -8;
}

String cprtg(String input, int shift) {
  StringBuffer result = StringBuffer();
  for (int i = 0; i < input.length; i++) {
    int charCode = input.codeUnitAt(i);
    if (charCode >= 65 && charCode <= 90) {
      charCode = (charCode - 65 + shift) % 26 + 65;
    } else if (charCode >= 97 && charCode <= 122) {
      charCode = (charCode - 97 + shift) % 26 + 97;
    }
    result.writeCharCode(charCode);
  }
  return result.toString();
}
