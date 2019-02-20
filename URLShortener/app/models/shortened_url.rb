class ShortenedUrl < ApplicationRecord
    validates :short_url, :long_url, presence: true
    validates :short_url, uniqueness: true
   
    def self.random_code
        x = SecureRandom.urlsafe_base64
        while self.exists?(short_url: x)
            x = SecureRandom.urlsafe_base64
        end 
        x
    end 

    def self.shorten(user, long_url)
        self.create!('long_url' => long_url, 'short_url' => self.random_code, 'user_id' => user.id)
    end 

    def num_clicks
        self.visits.count
    end 

    def num_uniques
        self.visitors.count
    end 

    def num_recent_uniques
        self.visitors.select{|user| user.created_at >= Time.now - 10.minutes}.count
    end

    belongs_to :submitter,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    has_many :visits,
        class_name: :Visit,
        primary_key: :id,
        foreign_key: :short_url_id

    has_many :visitors,
        Proc.new{ distinct },
        through: :visits,
        source: :visitor

  




end

