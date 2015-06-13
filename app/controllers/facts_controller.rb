class FactsController < ApplicationController
  def index
    @facts = Fact.order(:name)
  end
end
