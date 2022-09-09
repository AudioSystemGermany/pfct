int getFirstEol (String text) {
  return text.indexOf(String.fromCharCodes([13,10]));
}

String deleteFirstRow (String text) {
  return text.substring(getFirstEol(text)+2);
}

String cutToFirstRow (String text) {
  return text.substring(0, getFirstEol(text));
}

String getCellInfofromPosition(String text, int start) {
  String result = '';
    int startingPosition = start;
    int endingPosition = start;
    int eof = getFirstEol(text);
    if (text.codeUnitAt(start) == 34) {
      startingPosition++;
    }
    result = text.substring(start, eof-1);
    if (startingPosition != start) {
      result = result.substring(0, result.indexOf('"')-1);
      endingPosition = result.indexOf('"') + 2;
    } else {
      result = result.substring(0, result.indexOf(';')-1);
      endingPosition = result.indexOf(';') + 1;
    }
    return result;

}

List<String> firstRowToList(String text) {
  List<String> resultList = [];
  text = cutToFirstRow(text);
  bool isQuoted = false;
  int s = 0;
  int e = 0;
  int position = 0;
  int eol = text.length;
  while (position < eol) {
    if (text.codeUnitAt(position) == 34) isQuoted = true; else isQuoted = false;
    s = isQuoted ? position + 1 : position;
    e = text.substring(isQuoted ? position + 1 : position).indexOf(isQuoted ? '"' : ';') + s;
    if ((e<s) & (isQuoted == false)) e = eol;
    resultList.add(text.substring(s, e));
    if (e < eol) {
      position = text.substring(isQuoted ? position + 1 : position).indexOf(isQuoted ? '"' : ';') + (isQuoted ? 2 : 1) + s;
    } else {
      position = eol;
      resultList.add('');
    }
    if (s == eol) resultList.add('');
    //print('$s - $e EOL $eol');
  }
  return resultList;
}