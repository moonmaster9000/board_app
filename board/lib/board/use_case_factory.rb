module Board
  class UseCaseFactory
  end
end

Dir[File.join(__dir__, "use_cases", "**", "*_use_case.rb")].each do |use_case|
  require use_case
end
