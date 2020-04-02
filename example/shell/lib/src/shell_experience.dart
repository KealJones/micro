class ShellExperience {
  const ShellExperience._(this.prefix);

  final String prefix;

  static const ShellExperience DOCS = const ShellExperience._('docs');

  static const ShellExperience SPREADSHEETS = const ShellExperience._('ss');

  static const ShellExperience REACTOR = const ShellExperience._('reactor');

  static const List<ShellExperience> experiences = const <ShellExperience>[
    DOCS,
    SPREADSHEETS,
    REACTOR,
  ];
}
