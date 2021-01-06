class MatchingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_matching, only: [:show, :edit, :update]
  before_action :search_matching, only: [:index, :search]

  def index
    @matchings = Matching.all
  end

  def new
    @matching = Matching.new
  end

  def create
    @matching = Matching.new(matching_params)
    if @matching.save
      redirect_to matchings_path
    else
      render :new
    end
  end

  def show
    @need = Need.find_by_id @matching.need_id
  end

  def edit
  end

  def update
    if @matching.update(matching_params)
      redirect_to matching_path(@matching.id)
    else
      render :edit
    end
  end

  def search
    @results = @p.result(distinct: true).page(params[:page]).per(8).order('created_at DESC')
  end

  private

  def matching_params
    params.require(:matching).permit(:title, :need_id, :detail, :end_date, :contact_information, :url).merge(user_id: current_user.id)
  end

  def set_matching
    @matching = Matching.find(params[:id])
  end

  def search_matching
    @p = Matching.ransack(params[:q])
  end
end
