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

    belongs_to( :user,
        :primary_key => :id,
        :foreign_key => :user_id,
        :class_name => :User
    )
end
