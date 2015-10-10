require "support/common_assertions"
require "board/use_cases/interestings/entities/interesting"

describe Board::Entities::Interesting do
  include CommonAssertions

  it_requires Board::Entities::Interesting, :date
  it_requires Board::Entities::Interesting, :title
  it_requires Board::Entities::Interesting, :whiteboard_id
  assert_private_attribute Board::Entities::Interesting
end
