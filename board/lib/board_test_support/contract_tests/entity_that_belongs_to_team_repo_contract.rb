def assert_works_like_an_entity_repo_that_belongs_to_team(entity_class:, generate_repo_lambda:)
  describe "Repo For Entities That Belong To Teams" do
    context "Given entities for different teams on varying dates" do
      before do
        entity_repo.save(team_1_today_entity)
        entity_repo.save(team_1_tomorrow_entity)
        entity_repo.save(team_2_today_entity)
        entity_repo.save(team_2_tomorrow_entity)
      end

      it "should fetch those entities by team and date" do
        team_1_today_entities = entity_repo.all_by_team_id_and_date(team_1_id, today)

        expect(team_1_today_entities).to include team_1_today_entity
        expect(team_1_today_entities).not_to include team_2_today_entity
        expect(team_1_today_entities).not_to include team_1_tomorrow_entity
        expect(team_1_today_entities).not_to include team_2_tomorrow_entity
      end
    end

    let(:team_1_today_entity)     { entity_class.new(team_id: team_1_id, date: today)     }
    let(:team_1_tomorrow_entity)  { entity_class.new(team_id: team_1_id, date: tomorrow)  }
    let(:team_2_today_entity)     { entity_class.new(team_id: team_2_id, date: today)     }
    let(:team_2_tomorrow_entity)  { entity_class.new(team_id: team_2_id, date: tomorrow)  }

    let(:entity_repo) { generate_repo_lambda.call }
    let(:today) { Date.today }
    let(:tomorrow) { today.next_day}
    let(:team_1_id) { 1 }
    let(:team_2_id) { 2 }
  end
end
