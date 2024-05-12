class Track < ApplicationRecord
  def file_key
    self.path + self.name
  end
end
