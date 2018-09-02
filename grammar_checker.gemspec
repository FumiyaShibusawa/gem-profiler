Gem::Specification.new do |s|
  s.name        = 'grammar_checker'
  s.version     = '0.0.0'
  s.date        = '2018-08-16'
  s.summary     = "grammar_checker!"
  s.description = "A simple method name parser for grammar check"
  s.bindir      = 'bin'
  s.executables << "analyze"
  s.authors     = ["Fumiya Shibusawa"]
  s.email       = ["shizai.asdfghjkl@gmail.com"]
  s.files       = Dir['lib/*'] + Dir['bin/*']
  s.homepage    =
    'http://rubygems.org/gems/grammar_checker'
  s.license       = 'MIT'
end