class ApplicationController < ActionController::Base
  before_action :set_metadata

  private

  def set_metadata
    @metadata = {
      title: 'Funny Movies'
    }
  end
end
