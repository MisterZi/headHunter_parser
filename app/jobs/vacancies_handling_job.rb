# Обработка списка вакансий Ruby разработчика в СПб

class VacanciesHandlingJob
  @queue = :vacancies_queue

  require 'open-uri'

  def self.perform
    # Получаем от HH API список всех вакансий по тегу Ruby в регионе Санкт-Петербург
    response = open("https://api.hh.ru/vacancies?text=ruby&area=2").read
    vacancies_json = JSON.parse(response)

    # Вытаскиваем из полученного списка id и short_description вакансий и сохраняем их в БД
    vacancies_json['items'].each do |elements|
      vacancy = Vacancy.new(vacancy_id: elements['id'], short_description: elements['snippet']['responsibility'])
      vacancy.save
    end
  end
end