class HomesController < ApplicationController
  def index
    use_case_factory.present_whiteboards(
      observer: self,
      whiteboard_repo: whiteboard_repo,
    ).execute
  end

  def whiteboards_presented(whiteboards)
    @whiteboards = whiteboards
  end
end
