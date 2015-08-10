require "board/values/standup"

describe "Standup value object" do
  it "filters out empty items" do
    standup = Board::Values::Standup.new({present_items: [1,2,3], unavailable_items: []})

    expect(standup.available_items).to include(present_items: [1,2,3])
    expect(standup.available_items).not_to include(unavailable_items: [])
  end
end
