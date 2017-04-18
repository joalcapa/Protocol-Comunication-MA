require 'tk'
require 'tkextlib/tile'

class HomeView
 STR_MODE_CLIENT = 'MODE CLIENT'
 STR_MODE_SERVER = 'MODE SERVER' 
    
 LOOKING_SERVER = 1
    
 def initialize(config)
  @config = config
  @running = true
  initContext()
  @thread = Thread.new{ run() }
 end
    
 def initContext
  root = TkRoot.new {title "Protocol MA"}
  content = Tk::Tile::Frame.new(root) { padding "3 3 12 12" }.grid( :sticky => 'nsew')
  TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1
  @modeTxt = Tk::Tile::Label.new(content) { text '' }.grid( :column => 1, :row => 1, :sticky => 'w')
  @modeTxt.text = @config.getTypeService
  @messageTxt = Tk::Tile::Label.new(content) { text '' }.grid( :column => 1, :row => 2, :sticky => 'w')
  @labelImage = TkLabel.new(root) 
  @labelImage.grid( :column => 4, :row => 0, :sticky => 'w')
  TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 5, :pady => 5}
 end
     
 def asignDataImage(dataResource)
  @image = TkPhotoImage.new(:data => dataResource)
  @labelImage.image = @image
 end
        
 def run
  Tk.mainloop
  @running = false
 end
    
 def threadPresent
  return @thread
 end
        
 def getRunning
  return @running
 end
     
 def status(statusText)
  @messageTxt.text = statusText
 end
end