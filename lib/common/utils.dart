RegExp matchAfterLastSlash = RegExp(r"\/([^\/]+)\/?$");

String retrieveLastSegmentOfUrl(String url) {
  var output = matchAfterLastSlash.firstMatch(url)?.group(0);
  output = output?.substring(1, output.length);
  return output ?? "";
}
