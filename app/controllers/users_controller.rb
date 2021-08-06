class UsersController < ApplicationController
  before_action :set_user, only: [:archive, :unarchive]

  def index
    allowed = [:archived]
    jsonapi_filter(User.all, allowed) do |filtered|
      render jsonapi: filtered.result
    end
  end

  def archive
    if @user.update(archived: true)
      @user.create_activity action: "archived", owner: current_api_user
      render json: { message: 'User has been archived successfully' }, status: :ok
    else
      render jsonapi_errors: @user.errors, status: :unprocessable_entity
    end
  end

  def unarchive
    if @user.update(archived: false)
      @user.create_activity action: "unarchived", owner: current_api_user
      render json: { message: 'User has been unarchived successfully' }, status: :ok
    else
      render jsonapi_errors: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    if @user.present?
      if current_api_user&.id == @user&.id
        render json: { message: 'You can not perform this action' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'User not found' }, status: :unprocessable_entity
    end
  end
end
