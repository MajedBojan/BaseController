# frozen_string_literal: true

class V1::Admin::BaseController < V1::BaseController
  before_action :authenticate!

  # the default show template
  def show_serializer
    "V1::Admin::#{resource_name.classify}DetailsSerializer".constantize
  end

  # the default index template
  def index_serializer
    "V1::Admin::#{resource_name.classify}Serializer".constantize
  end
end
