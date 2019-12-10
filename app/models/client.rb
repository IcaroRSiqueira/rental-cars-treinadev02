class Client < ApplicationRecord

  def description
    "#{name} - #{document}"
  end
end
