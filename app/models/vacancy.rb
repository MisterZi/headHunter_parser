class Vacancy < ActiveRecord::Base

  # Если vacancy_id не представлен, то объект не сохранится в базу
  validates :vacancy_id, presence: true

  # Если vacancy_id не уникален, то объект не сохранится в базу
  validates :vacancy_id, uniqueness: true
end
