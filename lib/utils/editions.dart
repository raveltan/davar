class BibleEditions {
  final String url;
  final String name;

  const BibleEditions(this.name, this.url);
}

const List<BibleEditions> bibleEditions = [
  BibleEditions('English - Study Bible',
      'https://www.jw.org/en/library/bible/study-bible/books/genesis/1/'),
  BibleEditions('Indonesia - Alkitab Edisi Pelajaran',
      'https://www.jw.org/id/perpustakaan/alkitab/alkitab-pelajaran/buku-buku/kejadian/1/'),
  BibleEditions(
    '中文（简体）- 2019 修订版',
    'https://www.jw.org/cmn-hans/%E5%A4%9A%E5%AA%92%E4%BD%93%E5%9B%BE%E4%B9%A6%E9%A6%86/%E5%9C%A3%E7%BB%8F/nwt/%E5%9C%A3%E7%BB%8F%E5%8D%B7%E7%9B%AE/%E5%88%9B%E4%B8%96%E8%AE%B0/1/',
  )
];
