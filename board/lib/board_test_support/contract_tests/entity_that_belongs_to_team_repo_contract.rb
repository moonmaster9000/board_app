def assert_works_like_an_entity_repo_that_belongs_to_team(entity_class:, generate_repo_lambda:)
  describe "Repo For Entities That Belong To Teams" do
    context "Given entities for different teams" do
      before do
        entity_repo.save(team_1_entity)
        entity_repo.save(team_2_entity)
      end

      it "should fetch those entities by team" do
        entitys_for_team_1 = entity_repo.all_by_team_id(1)

        expect(entitys_for_team_1).to include team_1_entity
        expect(entitys_for_team_1).not_to include team_2_entity
      end
    end

    let(:team_1_entity) { entity_class.new(team_id: 1) }
    let(:team_2_entity) { entity_class.new(team_id: 2) }
    let(:entity_repo) { generate_repo_lambda.call }
  end
end
