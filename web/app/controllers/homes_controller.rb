class HomesController < ApplicationController
  def index
    Board.present_whiteboards(
      observer: self,
      whiteboard_repo: whiteboard_repo,
    ).execute
  end

  def whiteboards_presented(whiteboards)
    @whiteboards = whiteboards
  end
end
