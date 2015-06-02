require "persistence/repos/new_face_repo"
require "persistence/repos/whiteboard_repo"
require "persistence/repos/help_repo"
require "persistence/repos/event_repo"
require "persistence/repos/interesting_repo"

module Persistence
  module Repos
    class RepoFactory
      def new_face_repo
        NewFaceRepo.new
      end

      def whiteboard_repo
        WhiteboardRepo.new
      end

      def help_repo
        HelpRepo.new
      end

      def event_repo
        EventRepo.new
      end

      def interesting_repo
        InterestingRepo.new
      end
    end
  end
end
