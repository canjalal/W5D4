# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, :short_url, uniqueness: true, presence: true

    belongs_to( :submitter,
        :primary_key => :id,
        :foreign_key => :user_id,
        :class_name => :User
    )



    def self.random_code
        url = SecureRandom.urlsafe_base64
        until !self.exists?(:short_url => url)
            url = SecureRandom.urlsafe_base64
        end
        url
    end

    after_initialize do |user|
        generate_short_url
        puts "You have created a shortened url!"
    end
    
    after_find do |user|
        puts "You have found a shortened url!"
    end

    private
    def generate_short_url
        ShortenedUrl.random_code
    end
end
