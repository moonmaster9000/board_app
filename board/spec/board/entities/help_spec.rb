require "support/common_assertions"
require "board/use_cases/helps/entities/help"

describe Board::Entities::Help do
  include CommonAssertions

  it_requires Board::Entities::Help, :title
  it_requires Board::Entities::Help, :date
  assert_private_attribute Board::Entities::Help
end
