def assert_works_like_an_entity_repo(generate_repo_lambda:, entity_class:)
  describe "Entity Repo" do
    context "When I tell the repo to save some new entities" do
      before do
        @entity_1 = create_new_entity
        @entity_2 = create_new_entity
      end

      specify "Then the repo should give them unique ids" do
        expect(@entity_2.id).not_to eq(@entity_1.id)
      end

      specify "And the repo should allow me to fetch the entities by their ID" do
        expect(entity_repo.find(@entity_1.id)).to eq(@entity_1)
      end

      specify "And it should return the entity when you ask for all entities" do
        expect(entity_repo.all).to include(@entity_1)
      end
    end

    context "Given an existing saved entity" do
      before do
        @entity = create_new_entity
      end

      specify "Then I should be able to successfully save it again" do
        expect {
          entity_repo.save(@entity)
        }.not_to raise_exception
      end
    end

    let(:entity_repo) { generate_repo_lambda.call }
    let(:entity_klass) { entity_class }

    def create_new_entity
      entity = entity_klass.new
      entity_repo.save(entity)
      entity
    end
  end
end
