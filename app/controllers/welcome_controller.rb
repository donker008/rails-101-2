class WelcomeController < ApplicationController

  def  index
    flash[:alert] = "早安！你好！ 1"
    # flash[:notice] = "早安！你好！2 "
    # flash[:warning] = "早安！你好！3"
  end
end
