class Task < ApplicationRecord
  validates :name, presence: true, length: { maxmam: 30 }
end
