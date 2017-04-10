require 'socket'

load 'app/controllers/HomeController.rb'
load 'app/daos/HomeDao.rb'
load 'app/views/HomeView.rb'
load '.env'

# Initialization of the application based on MVC (Model - View - Controller)
homeDao = HomeDao.new
homeView = HomeView.new
homeController = HomeController.new(homeDao, homeView)

# Commissioning of concurrent threads
homeView.threadPresent().join
homeController.threadPresent().join