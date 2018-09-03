# frozen_string_literal: true

require 'tempfile'
require 'corresponding_tag_lists'

class GrammarChecker
  def parse_method_names(file)
    method_names = File.read(file).scan(/(def)\s{1}([^\s|\(]+)/)
                       .map { |_, name| name.tr('_', "\n") }.join("\n.\n")
    output = Tempfile.open do |t|
      t.write(method_names)
      t.open
      `treetagger-wrapper/bin/tree-tagger -token treetagger-wrapper/english-par-linux-3.2-utf8.bin #{t.path}`
    end
    output += "\n.\tSENT"
    output
  end

  def pretty_print(output)
    # ex: output_in_arrays => [["foo", "NN"], ["bar", "VV"], [".", "SENT"]]
    output_in_arrays = output.scan(/(.+)\t(.+)/)
    output_with_converted_tags = output_in_arrays.each do |output_in_array|
      CORRESPONDING_TAG_LISTS.each do |list|
        output_in_array[1] = list[1] if output_in_array[1] == list[0]
      end
    end
    name_line = '|'
    tag_line = '|'
    result = ''
    output_with_converted_tags.each do |name, tag|
      if name == '.'
        result += "#{name_line}\n#{tag_line}\n\n"
        name_line = '|'
        (tag_line = '|') && next
      else
        name_line += " #{name} |"
        tag_line += " #{tag} |"
      end
    end
    result
  end
end
