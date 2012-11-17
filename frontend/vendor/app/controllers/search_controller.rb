class SearchController < ApplicationController
  def index
    if params[:search] && params[:search] != ""
      puts "IN SearchController::index -- search=\"#{params[:search]}\""
      if params[:search].include? '#'
        puts "tagmode"
        @taglist = params[:search].split.delete_if {|word| word !~ /^#\w+$/}
        @taglist.collect! {|tag| /^#(?<tag>\w+)/.match(tag)[:tag] }
        puts "Taglist =#{@taglist} "
        @result = Tag.where(tag: @taglist).collect {|tag| tag.capsuls }
        @result.flatten!
        @result.uniq! {|capsul| capsul.id} unless @result.nil?
      else
        puts "descmode"
        @result = Capsul.where("description LIKE ?", "%#{params[:search]}%")
      end
    else
      redirect_to '/'
    end
  end
end
