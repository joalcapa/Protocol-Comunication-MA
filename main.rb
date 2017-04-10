require 'socket'

load 'app/controllers/HomeController.rb'
load 'app/daos/HomeDao.rb'
load 'app/views/HomeView.rb'
load 'app/Config.rb'
load '.env'

# Configuration of the application
config = Config.new

# Initialization of the application based on MVC (Model - View - Controller)
homeDao = HomeDao.new(config)
homeView = HomeView.new(config)
homeController = HomeController.new(homeDao, homeView, config)

# Commissioning of concurrent threads
homeView.threadPresent().join
homeController.threadPresent().join