class OptionsController < ApplicationController
  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def options
    logger.debug 'options'
    if request.method == 'OPTIONS'
      #headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
      #headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'

      respond_to do |format|
        #format.html { render action: "ok" }
        format.json { head :no_content }
      end
    end
  end


end