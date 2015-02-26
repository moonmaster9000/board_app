def assert_works_like_an_entity_repo(entity_repo_factory:, entity_factory:)
  describe "Entity Repo" do
    context "When I tell the repo to save some entities" do
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

    let(:entity_repo) { entity_repo_factory.call }
    let(:entity_factory) { entity_factory }

    def create_new_entity
      entity = entity_factory.call
      entity_repo.save(entity)
      entity
    end
  end
end
