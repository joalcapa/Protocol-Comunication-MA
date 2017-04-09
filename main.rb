load 'app/controllers/HomeController.rb'
load 'app/models/HomeModel.rb'
load 'app/views/HomeView.rb'

homeModel = HomeModel.new()
homeView = HomeView.new()
homeController = HomeController.new(homeModel, homeView)