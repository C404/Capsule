class Capsul < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  acts_as_gmappable :process_geocoding => false
  attr_accessible :description, :video, :longitude, :latitude

  after_create :append_tags

  private
  def append_tags
    self.description.split.each do |word|
      self.tags << Tag.find_or_create_by_tag(/^#(?<tag>\w+)/.match(word)[:tag]) if word =~ /^#(?<tag>\w+)/
    end
  end
end
