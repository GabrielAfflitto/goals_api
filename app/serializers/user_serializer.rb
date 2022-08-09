class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :goals
  has_many :goals
end
