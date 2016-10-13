class Vacancy < ActiveRecord::Base

    # Если ссылка не уникальна, то объект не сохранится в базу
  validates :link, uniqueness: true
end
