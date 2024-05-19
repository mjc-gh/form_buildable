class FormsController < ApplicationController
  def show
    render params[:id]
  end
end
