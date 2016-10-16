class VacanciesHandlingJob
  @queue = :simple

  require 'open-uri'

  def self.perform
    response = open("https://api.hh.ru/vacancies?text=ruby").read
    vacancies_json = JSON.parse(response)

    vacancies_json['items'].each do |elements|
      vacancy = Vacancy.new(vacancy_id: elements['id'])
      vacancy.save
    end
  end
end