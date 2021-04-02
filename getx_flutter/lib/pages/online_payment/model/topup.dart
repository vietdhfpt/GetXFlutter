class Topup {
  final String title;
  final String icon;
  final String value;

  const Topup({
    this.title,
    this.icon,
    this.value,
  });
}

const List<Topup> topupsStore = <Topup>[
  Topup(title: 'Mua thẻ cào', icon: 'assets/icons/thecao.jpg'),
  Topup(title: 'Nạp cước', icon: 'assets/icons/napcuoc.jpg'),
  Topup(title: 'Thẻ game', icon: 'assets/icons/thegame.jpg'),
  Topup(title: '3G/4G', icon: 'assets/icons/thecao.jpg'),
];
