class ApplicationController < ActionController::Base
  default_form_builder(GOVUKDesignSystemFormBuilder::FormBuilder)

  def render_404
    render 'errors/not_found', status: :not_found
  end

  def render_403
    render 'errors/forbidden', status: :forbidden
  end

end
