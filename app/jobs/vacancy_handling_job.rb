class VacancyHandlingJob
  @queue = :simple

  require 'open-uri'

  def self.perform(id)
    ids.each do |id|
      response = open("https://api.hh.ru/vacancies/#{VacanciesHandlingJob.ids}").read
      json = JSON.parse(response)

      vacancy_params = {
          name: json['name'],
          description: json['description'],
          link: json['alternate_url'],
          company_name: json['employer']['name'],
          company_link: json['employer']['alternate_url']
      }
      unless json['salary'].nil?
        vacancy_params[:salary_from] = json['salary']['from']
        vacancy_params[:salary_to] = json['salary']['to']
        vacancy_params[:currency] = json['salary']['currency']
      end

      @vacancy = Vacancy.new(vacancy_params)
      @vacancy.save
    end
  end
end