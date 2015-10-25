require "board/use_cases/whiteboards/entities/whiteboard"

describe "whiteboard" do
  specify "it equals another whiteboard entity with the same id" do
    whiteboard1         = Board::Entities::Whiteboard.new id: "1"
    another_whiteboard1 = Board::Entities::Whiteboard.new id: "1"
    whiteboard2         = Board::Entities::Whiteboard.new id: "2"

    expect(whiteboard1 == whiteboard1).to be(true)
    expect(whiteboard1 == whiteboard2).to be(false)
  end
end
