class Api::V1::OperationCategoriesController < ApplicationController
  before_action :set_table
  before_action :set_category, only: %i[show update destroy]
  
  def index
    @categories = @table.operation_categories.all
    render :index
  end

  def show
    render json: @category
  end

  def create
    @category = @table.operation_categories.new(category_params)

    if @category.save
      render json: {status: 200}
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: {status: 200}
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
      if @category.destroy
        render json: {status: 204}
      else
        render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
      end
  end

  private
  def set_table
    @tables = Table.all.where("#{current_user.id} = ANY(users_access) OR user_id = #{current_user.id}")
    @table = @tables.find(params[:table_id]) if params[:table_id]
  end

  def set_category
    @category = @table.operation_categories.find(params[:id])
  end

  def category_params
    params.require(:operation_category).permit(:name, :description, :operation_type)
  end
end
