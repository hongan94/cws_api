class Admin < ApplicationRecord
  has_secure_password
  enum gender: { male: 0, female: 1, other: 2 }
end
