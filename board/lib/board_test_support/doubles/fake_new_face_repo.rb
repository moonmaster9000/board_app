require 'securerandom'

class FakeNewFaceRepo
  def initialize
    @new_faces = Hash.new
  end

  def save(new_face)
    new_face.id = SecureRandom.uuid
    @new_faces[new_face.id] = new_face
  end

  def find(id)
    @new_faces[id]
  end
end
