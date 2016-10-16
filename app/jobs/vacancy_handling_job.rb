# Обработка всех вакансий

class VacancyHandlingJob
  @queue = :simple

  require 'open-uri'

  def self.perform
    # Выбираем все вакансии из БД
    vacancies = Vacancy.all

    vacancies.each do |vacancy|
      # Обрабатываем каждую вакансию по её id
      response = open("https://api.hh.ru/vacancies/#{vacancy.vacancy_id}").read
      vacancy_json = JSON.parse(response)

      # Составляем hash-массив параметров вакансии
      vacancy_params = {
          name: vacancy_json['name'],
          description: vacancy_json['description'],
          link: vacancy_json['alternate_url'],
          company_name: vacancy_json['employer']['name'],
          company_link: vacancy_json['employer']['alternate_url']
      }
      # т.к. з/п не всегда указана, то необходимо провести проверку
      unless vacancy_json['salary'].nil?
        vacancy_params[:salary_from] = vacancy_json['salary']['from']
        vacancy_params[:salary_to] = vacancy_json['salary']['to']
        vacancy_params[:currency] = vacancy_json['salary']['currency']
      end

      # Обновляем поля вакансии
      vacancy.update(vacancy_params)
    end
  end
end