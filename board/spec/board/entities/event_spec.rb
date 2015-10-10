require "support/common_assertions"
require "board/use_cases/events/entities/event"

describe Board::Entities::Event do
  include CommonAssertions

  it_requires Board::Entities::Event, :title
  it_requires Board::Entities::Event, :date
  assert_private_attribute Board::Entities::Event
end
