class Api::V1::TablesController < ApplicationController
  before_action :set_table, only: %i[update destroy]

  def index
    @tables = Table.all.where("#{current_user.id} = ANY(users_access) OR user_id = #{current_user.id}")
    render :index
  end

  def show
    @tables = Table.all.where("#{current_user.id} = ANY(users_access) OR user_id = #{current_user.id}")
    @table = @tables.find(params[:id])
    render :show
  end

  def create
    @table = current_user.tables.new(table_params)

    if @table.save
      render json: {status: 200}
    else
      render json: { errors: @table.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @table.update(table_params)
      render json: {status: 200}
    else
      render json: { errors: @table.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @table.destroy
    render :delete
  end

  private
  def set_table
    @table = current_user.tables.find(params[:id])
  end

  def table_params
    params.require(:table).permit(:name, :description, :users_access => [])
  end
end