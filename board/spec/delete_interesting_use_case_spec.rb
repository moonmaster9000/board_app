require "support/shared_behaviors/verify_delete_entity_behavior"

describe "USE CASE: delete an interesting" do
  verify_delete_entity_behavior(entity_name: :interesting)
end
