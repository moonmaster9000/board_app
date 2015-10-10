require "support/common_assertions"
require "board/use_cases/new_faces/entities/new_face"

describe Board::Entities::NewFace do
  include CommonAssertions

  it_requires Board::Entities::NewFace, :name
  it_requires Board::Entities::NewFace, :date
  assert_private_attribute Board::Entities::NewFace
end
