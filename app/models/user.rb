class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super
  end

  has_many :todos, dependent: :destroy

  validates :fullname, presence: true
  validates :email, presence: true, uniqueness: true, length: { miximum: 5, maximum: 255 },
                    format: { with: /\A[\w+_.]+@[a-z\d]+\.[a-z]+\z/i }
  validates :is_admin, inclusion: [true, false]
end
