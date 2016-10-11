class VacanciesController < ApplicationController

  def index
    @vacancies = Vacancy.all
  end

  def show
    @vacancy = Vacancy.find(params[:id])
  end

  def create

  end

  def delete

  end
end
