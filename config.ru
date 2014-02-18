require './app'

controllers = 
  [
   ExpenseTracker::MainController,
   ExpenseTracker::ProfileController,
   ExpenseTracker::CategoryController,
   ExpenseTracker::StatisticsController,
   ExpenseTracker::AdvancedStatisticsController
  ]

controllers.each do |controller|
  map (controller::NAMESPACE) { run controller }
end