dynamic switchSemester(String smtAwal) {
  switch (smtAwal.substring(4)) {
    case '1':
      return 'Ganjil ' + smtAwal.substring(0, 4);
    case '2':
      return 'Genap ' + smtAwal.substring(0, 4);
    case '3':
      return 'Pendek ' + smtAwal.substring(0, 4);
    default:
  }
}

dynamic switchSemesterWithoutYear(String smtAwal) {
  switch (smtAwal.substring(4)) {
    case '1':
      return 'Ganjil';
    case '2':
      return 'Genap';
    case '3':
      return 'Pendek';
    default:
  }
}
