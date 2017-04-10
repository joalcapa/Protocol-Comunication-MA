require 'tk'
require 'tkextlib/tile'

class HomeView
    
    STR_MODE_CLIENT = 'MODE CLIENT'
    STR_MODE_SERVER = 'MODE SERVER' 
    STR_LOOKING_SERVER = 'Looking server ...'
    
    LOOKING_SERVER = 1
    
    def initialize
        @statusServer = false
        @statusOperationClient = LOOKING_SERVER
        initContext()
        changeMode()
        @thread = Thread.new{ run() }
    end
    
    def initContext
        root = TkRoot.new {title "Feet to Meters"}
        content = Tk::Tile::Frame.new(root) {
            padding "3 3 12 12"
            }.grid( :sticky => 'nsew')
        
        TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1
        
        $feet = TkVariable.new; $meters = TkVariable.new
        f = Tk::Tile::Entry.new(content) {
            width 7;
            textvariable $feet
            }.grid( :column => 2, :row => 1, :sticky => 'we')
        Tk::Tile::Label.new(content) {
            textvariable $meters
            }.grid( :column => 2, :row => 2, :sticky => 'we')
        
        @modeBtn = TkButton.new(
            content,
            :text => '',
            :command => proc {changeMode}
                ).pack.grid( :column => 1, :row => 3, :sticky => 'w')
        
        @modeTxt = Tk::Tile::Label.new(content) {
            text ''
            }.grid( :column => 1, :row => 1, :sticky => 'w')
            
        @messageTxt = Tk::Tile::Label.new(content) {
            text ''
            }.grid( :column => 3, :row => 3, :sticky => 'w')
        
        TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 5, :pady => 5}
        f.focus
        root.bind("Return") {changeMode}
    end
        
    def changeMode
        if (@statusServer) then
            @modeBtn.text = STR_MODE_CLIENT
            @modeTxt.text = STR_MODE_SERVER
            @statusServer = false
        else
            @modeBtn.text = STR_MODE_SERVER
            @modeTxt.text = STR_MODE_CLIENT
            @statusServer = true
        end
        changeMessage()
    end
        
    def changeMessage
        case @statusOperationClient
            when LOOKING_SERVER
                @messageTxt.text = STR_LOOKING_SERVER
            else
                @messageTxt.text = STR_LOOKING_SERVER
        end
    end
        
    def run
        Tk.mainloop
    end
    
    def threadPresent
        return @thread
    end
    
    def statusServer
        return @statusServer
    end
    
end