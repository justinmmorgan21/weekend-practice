class NflExamplesController < ApplicationController

  def example
    render json: { json_response: "test" }
  end

end
