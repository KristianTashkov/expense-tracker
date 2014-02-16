module ExpenseTracker
  class ChartkickCharts
    include ::Chartkick::Helper

    def initialize_charts
      '<script src="/js/highcharts.js"></script>
      <script src="/js/chartkick.js"></script>'
    end

    def draw_pie_chart(id, data)
      pie_chart data
    end

    def draw_line_chart(id, data)
      line_chart data
    end

    def draw_bar_chart(id, data)
      bar_chart data
    end
  end
end