class VisitorsController < ApplicationController
  def index

  end

  def configure

  end

  def dashboard
    @data = [
      {
        name: "Fantasy & Sci Fi",
        data: [["2010", 10], ["2020", 16], ["2030", 28]]
      },
      {
        name: "Romance",
        data: [["2010", 24], ["2020", 22], ["2030", 19]]
      },
      {
        name: "Mystery/Crime",
        data: [["2010", 20], ["2020", 23], ["2030", 29]]
      }
    ]
  end

  def details

  end

  def demo

  end
end
