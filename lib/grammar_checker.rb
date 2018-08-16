class GrammarChecker
  def strip_method_names_from(file)
    File.read(file).scan(/(def)\s{1}(.+)/).map { |_, name| name }
  end
end