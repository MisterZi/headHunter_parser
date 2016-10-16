class AddVacancyidToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :vacancy_id, :integer
  end
end
