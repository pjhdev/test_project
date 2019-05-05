class UadController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    members = Member.find(params[:seq])

    render json: members, status: :ok
  end
end
