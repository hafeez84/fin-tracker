class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :user_stocks
   has_many :stocks, through: :user_stocks
   has_many :friendships
   has_many :friends, through: :friendships

   def full_name
     return "#{first_name} #{last_name}".strip if (first_name || last_name)
     "Anonymous"
   end

   def stock_already_added?(ts)
   		st = Stock.find_by_ticker(ts)
   		return false unless st
   		user_stocks.where(stock_id: st.id).exists?
   end

   def under_stock_limit?
   		(user_stocks.count < 10)
   end

   def can_add_stock?(ts)
   		under_stock_limit? && !stock_already_added?(ts)
   end

   def self.search(p)
    p.strip!
    p.downcase!
    to_send_back = (first_name_matches(p) + last_name_matches(p) + email_matches(p)).uniq
    return nil unless to_send_back  
    to_send_back 
   end

   def self.first_name_matches(p)
     matches('first_name', p)
   end

   def self.last_name_matches(p)
     matches('last_name', p)
   end

   def self.email_matches(p)
     matches('email', p)
   end

   def self.matches(field_name, p)
     where("#{field_name} like ?", "%#{p}%")
   end

   def except_current_user(users)
     users.reject { |u| u.id == self.id}
   end

   def not_friends_with?(f_id)
     friendships.where(friend_id: f_id).count < 1
   end
end
