class Sessions::ApplicationController < ApplicationController
  layout 'sessions'
  
  skip_before_action :authenticate
end