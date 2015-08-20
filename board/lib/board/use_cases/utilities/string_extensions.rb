module StringExtensions
  def self.turn_camelcase_into_snakecase(camelcase_class_name)
    demodulized_class_name = camelcase_class_name.split("::").last
    each_camel_case_word_in_name = demodulized_class_name.scan(/[A-Z][^A-Z]*/)
    each_camel_case_word_in_name.map(&:downcase).join("_")
  end
end
