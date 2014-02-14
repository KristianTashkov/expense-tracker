module ExpenseTracker
  class GoogleChart
    def add_scripts
      '<script src="//www.google.com/jsapi"></script>
      <script src="/js/googlecharts.js"></script>'
    end

    def draw_pie_chart(id, data)
      chart_div(id, "drawPieChart(#{prepare_data data}, '#{id}');")
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

    def prepare_data(data)
      data.insert(0, ["Label", "Ammount"])
    end
  end
end