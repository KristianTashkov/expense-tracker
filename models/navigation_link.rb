module ExpenseTracker
  class NavigationLink
    attr_reader :href
    attr_reader :title
    attr_accessor :active
    attr_reader :require_logged
    attr_reader :priority

    def initialize(href, title, require_logged, priority)
      @href = href
      @title = title
      @require_logged = require_logged
      @priority = priority
      @active = false
    end
  end
end