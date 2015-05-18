require "persistence/repos/new_face_repo"
require "persistence/repos/team_repo"
require "persistence/repos/help_repo"
require "persistence/repos/event_repo"

module Persistence
  module Repos
    class RepoFactory
      def new_face_repo
        NewFaceRepo.new
      end

      def team_repo
        TeamRepo.new
      end

      def help_repo
        HelpRepo.new
      end

      def event_repo
        EventRepo.new
      end
    end
  end
end
