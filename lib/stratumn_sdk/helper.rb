module StratumnSdk
  # We would like to avoid depending on ActiveSupport
  module Helper
    def underscore(string)
      word = string.to_s.dup
      word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      word.tr!('-', '_')
      word.downcase!
      word
    end
  end
end
