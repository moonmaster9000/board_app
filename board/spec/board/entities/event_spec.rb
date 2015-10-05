require "support/common_assertions"
require "board/use_cases/events/entities/event"

describe Board::Entities::Event do
  include CommonAssertions

  it_requires Board::Entities::Event, :title
  it_requires Board::Entities::Event, :date
  it_validates_inclusion_of Board::Entities::Event, :private, values: [true, false]

  it "defaults the 'private' field to true" do
    expect(Board::Entities::Event.new.private).to be(true)
  end
end
