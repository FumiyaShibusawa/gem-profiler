module GrammarChecker
  def strip_method_names_from(file)
    File.read(file).scan(/(def)\s{1}(.+)[\s|\(]/).map { |_, name| name.gsub(/_/, "\n") }
  end

  def parse_method_names(method_names)
    File.open("sample.txt", "w") { |f| f.write(method_names) }
    system("treetagger-wrapper/bin/tree-tagger -token treetagger-wrapper/english-par-linux-3.2-utf8.bin sample.txt")
    File.delete("sample.txt")
  end
end