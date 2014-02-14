module ExpenseTracker
  class ChartkickChart
    include ::Chartkick::Helper

    def add_scripts
      '<script src="/js/highcharts.js"></script>
      <script src="/js/chartkick.js"></script>'
    end

    def draw_pie_chart(id, data)
      pie_chart data
    end
  end
end