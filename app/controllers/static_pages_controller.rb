class StaticPagesController < ApplicationController
  require 'flickr'

  def index
    begin
      flickr = Flickr.new ENV["FLICKR_KEY"], ENV["FLICKR_SECRET"]
      unless params[:user_id].blank? || params[:user_id].nil?
        @images = flickr.photos.search(user_id: params[:user_id])
      else
      @images = flickr.photos.getRecent
      end
    rescue Flickr::FailedResponse => e
      flash[:alert] = "#{e.class}: #{e.message}. User ID doesn't exist"
      redirect_to root_path
    end
  end
end
