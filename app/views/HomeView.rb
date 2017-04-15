require 'tk'
require 'tkextlib/tile'

class HomeView
 STR_MODE_CLIENT = 'MODE CLIENT'
 STR_MODE_SERVER = 'MODE SERVER' 
    
 LOOKING_SERVER = 1
    
 def initialize(config)
  @config = config
  @event, @running = false, true
  @mutex=Mutex.new
  initContext()
  @thread = Thread.new{ run() }
 end
    
 def initContext
  root = TkRoot.new {title "Feet to Meters"}
  content = Tk::Tile::Frame.new(root) { padding "3 3 12 12" }.grid( :sticky => 'nsew')
  TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1
  $feet = TkVariable.new;
  $meters = TkVariable.new
  f = Tk::Tile::Entry.new(content) {
   width 7;
   textvariable $feet
  }.grid( :column => 2, :row => 1, :sticky => 'we')
  Tk::Tile::Label.new(content) { textvariable $meters }.grid( :column => 2, :row => 2, :sticky => 'we')
  @modeBtn = TkButton.new(
   content,
   :text => '',
   :command => proc {changeMode}
  ).pack.grid( :column => 1, :row => 3, :sticky => 'w')
  @modeTxt = Tk::Tile::Label.new(content) { text '' }.grid( :column => 1, :row => 1, :sticky => 'w')
  @messageTxt = Tk::Tile::Label.new(content) { text '' }.grid( :column => 3, :row => 3, :sticky => 'w')
      
  @labelImage = TkLabel.new(root) 
  @labelImage.grid( :column => 4, :row => 0, :sticky => 'w')
      
  TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 5, :pady => 5}
  f.focus
  root.bind("Return") {changeMode}
  changeConfigurationView()
 end
     
 def asignDataImage(dataResource)
  @image = TkPhotoImage.new(:data => dataResource)
  @labelImage.image = @image
 end
        
 def changeMode
  if @config.getTypeService == Config::TYPE_SERVICE_SERVER
   @config.setTypeService(Config::TYPE_SERVICE_CLIENT)
  else
   @config.setTypeService(Config::TYPE_SERVICE_SERVER)
  end
  changeConfigurationView()
  setEvent(true)
 end
    
 def changeConfigurationView
  if @config.getTypeService == Config::TYPE_SERVICE_SERVER
   @modeBtn.text = STR_MODE_CLIENT
   @modeTxt.text = STR_MODE_SERVER
  else
   @modeBtn.text = STR_MODE_SERVER
   @modeTxt.text = STR_MODE_CLIENT
  end
 end
        
 def run
  Tk.mainloop
  @running = false
 end
    
 def threadPresent
  return @thread
 end
        
 def getEvent
  @mutex.synchronize do
   $event = @event
  end
  return $event
 end
        
 def setEvent(event)
  @mutex.synchronize do
   @event = event
  end
 end
        
 def getRunning
  @mutex.synchronize do
   $running = @running
  end
  return $running
 end
     
 def status(status)
  @messageTxt.text = status
  puts status
 end
end