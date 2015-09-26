require "support/shared_behaviors/verify_delete_entity_behavior"

describe "USE CASE: delete an help" do
  verify_delete_entity_behavior(entity_name: :help)
end
