class Api::V1::OperationsController < ApplicationController
  before_action :set_table
  before_action :set_categories
  before_action :set_operation, only: %i[show update destroy]
  
  def index
    @operations = @table.operations.joins(:user).select('operations.*, users.name, users.lastname, users.avatar_url')
    render :index
  end

  def show
    render json: @operation
  end

  def create
    operation_data = {**operation_params, :table => @table}
    @operation = current_user.operations.new(operation_data)

    if @operation.save
      render json: {status: 200}
    else
      render json: { errors: @operation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @operation.update(operation_params) && @operation.user == current_user
      render json: {status: 200}
    else
      # render json: { errors: @operation.errors.full_messages }, status: :unprocessable_entity
      respond_unauthorized("Can't update operations of other users")
    end
  end

  def destroy
    if @operation.user == current_user
      @operation.destroy
    else
      respond_unauthorized("Can't delete operations of other users")
    end
  end

  private
  def set_table
    @tables = Table.all.where("#{current_user.id} = ANY(users_access) OR user_id = #{current_user.id}")
    @table = @tables.find(params[:table_id]) if params[:table_id]
  end

  def set_operation
    @operation = @table.operations.find(params[:id])
  end

  def set_categories
    @categories = @table.operation_categories.all
  end
  
  def operation_params
    params.require(:operation).permit(:import, :operation_type, :description, :attached_url, :operation_date, :operation_category_id,)
  end
end