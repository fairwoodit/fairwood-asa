class WelcomeController < ApplicationController
  layout 'home'

  def index
    if request.host == 'activities.fairwoodexplorer.org'
      redirect_to 'http://apps.fairwoodexplorer.org/activities'
    elsif request.host == 'walkathon.fairwoodexplorer.org'
      redirect_to 'http://apps.fairwoodexplorer.org/walkathon'
    end
  end
end
