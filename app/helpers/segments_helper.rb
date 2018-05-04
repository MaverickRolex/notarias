module SegmentsHelper
  def segment_bar_chart(candidacy)
    bar_chart(candidacies_loader.political_candidacy_data(candidacy), default_options)
  end

  def segment_pie_chart(candidacy)
    pie_chart(candidacies_loader.political_candidacy_data(candidacy), default_options)
  end

  def segment_line_chart(candidacy)
    line_chart(candidacies_loader.political_candidacy_data_by_time(candidacy), default_options)
  end

  private

  def candidacies_loader
    return @candidacies_loader if @candidacies_loader
    @candidacies_loader = PoliticalCandidaciesLoader.new(@segment)
  end

  def default_options
    {
      height: "200",
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }],
        xAxes: [{
          ticks: {
            autoSkip: false,
            beginAtZero: true
          }
        }]
      }
    }
    #{
    #  scales: {
    #    yAxes: [{
    #      ticks: {
    #        callback: js_inline("function(value, index, values) { return '<div>dick</div>' }")
    #      }
    #    }]
    #  }
    #}
  end
end
