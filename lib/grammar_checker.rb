require "tempfile"
class GrammarChecker
  def parse_method_names(file)
    method_names = File.read(file).scan(/(def)\s{1}([^\s|\(]+)/).map { |_, name| name.gsub(/_/, "\n") }.join("\n.\n")
    Tempfile.open do |t|
      t.write(method_names)
      t.open
      system("treetagger-wrapper/bin/tree-tagger -token treetagger-wrapper/english-par-linux-3.2-utf8.bin #{t.path}")
    end
  end
end