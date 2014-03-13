class User < ActiveRecord::Base

  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omnikauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true,
            uniqueness: true,
            format: {with: /\A[a-zA-Z\-_]+\Z/, message: 'Cannot Include Spaces'}


  def full_name
    first_name+' '+last_name
  end

end
