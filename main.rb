load 'app/controllers/HomeController.rb'
load 'app/models/HomeModel.rb'
load 'app/views/HomeView.rb'

# Initialization of the application based on MVC (Model - View - Controller)
homeModel = HomeModel.new()
homeView = HomeView.new()
homeController = HomeController.new(homeModel, homeView)
