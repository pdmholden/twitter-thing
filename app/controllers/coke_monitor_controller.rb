class CokeMonitorController < ApplicationController
  def index
    cs = CokeService.new
    cs.get_latest

    if cs.any_error?
      @error = true
      @error_message = cs.error_message
    else
      @error = false
    end
  end
end
