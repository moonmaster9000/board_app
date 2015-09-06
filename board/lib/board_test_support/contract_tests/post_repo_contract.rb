require "board_test_support/contract_tests/entity_repo_contract"

def assert_works_like_a_post_repo(repo_factory:)
  describe "post repo" do

    require "board/use_cases/standups/entities/post"
    assert_works_like_an_entity_repo(generate_repo_lambda: -> { repo_factory.post_repo }, entity_class: Board::Entities::Post)

    it "allows fetching by whiteboard id and standup date" do
      post_repo = repo_factory.post_repo
      standup_date = Date.today
      whiteboard_id = 1

      other_whiteboard_post = Board::Entities::Post.new(whiteboard_id: whiteboard_id + 1, standup_date: standup_date)
      future_post = Board::Entities::Post.new(whiteboard_id: whiteboard_id, standup_date: standup_date.next_day)
      post = Board::Entities::Post.new(whiteboard_id: whiteboard_id, standup_date: standup_date)
      past_post = Board::Entities::Post.new(whiteboard_id: whiteboard_id, standup_date: standup_date.prev_day)
      post_repo.save(other_whiteboard_post)
      post_repo.save(future_post)
      post_repo.save(post)
      post_repo.save(past_post)

      expect(post_repo.find_by_whiteboard_id_and_standup_date(whiteboard_id, standup_date)).to eq(post)
    end
  end
end
