class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :user_stocks
   has_many :stocks, through: :user_stocks

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
end
