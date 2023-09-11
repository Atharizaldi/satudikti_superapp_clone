String removeHtmlTags(String htmlString) {
  RegExp exp = RegExp(r'<[^>]*>|&nbsp;|&ldquo;');
  String plainText = htmlString.replaceAllMapped(exp, (match) {
    if (match.group(0) == '<p>' || match.group(0) == '</p>') {
      return '\n';
    } else if (match.group(0) == '&nbsp;' || match.group(0) == '&ldquo;') {
      return ' ';
    } else if (match.group(0) == '<li>') {
      return '\n• ';
    } else if (match.group(0) == '<br>') {
      return '\n';
    }
    return '';
  });

  // Replace consecutive newline characters with a single newline character
  plainText = plainText.replaceAll(RegExp(r'\n+'), '\n');

  // Trim leading and trailing whitespace
  plainText = plainText.trim();

  return plainText;
}

