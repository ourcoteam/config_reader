bool stringNotNullOrEmpty(String? s) => s != null && s.isNotEmpty;

String tryString(String s, String s2) => stringNotNullOrEmpty(s) ? s : s2;
