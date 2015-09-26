require "support/shared_behaviors/verify_delete_entity_behavior"

describe "USE CASE: delete a new face" do
  verify_delete_entity_behavior(entity_name: :new_face)
end
