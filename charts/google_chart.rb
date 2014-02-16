module ExpenseTracker
  class GoogleCharts
    def initialize_charts
      '<script src="//www.google.com/jsapi"></script>
      <script src="/js/googlecharts.js"></script>'
    end

    def draw_pie_chart(id, data)
      chart_div(id, "drawPieChart(#{prepare_pie_data data}, '#{id}');")
    end

    def draw_bar_chart(id, data)
      chart_div(id, "drawBarChart(#{prepare_pie_data data}, '#{id}');")
    end

    def draw_line_chart(id, data)
      chart_div(id, "drawLineChart(#{prepare_line_data data}, '#{id}');")
    end

    def chart_div(id, script)
      "
        <div id='#{id}'>
          <script>
            #{script}
          </script>
        </div>
      "
    end

    def prepare_pie_data(data)
      data.insert(0, ["Category", "Ammount"])
    end

    def prepare_line_data(data)
      data = data.map { |date, ammount| [date.to_s, ammount] }
      data.insert(0, ["Date", "Expenses"])
    end
  end
end