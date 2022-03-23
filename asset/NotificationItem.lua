print("startup ui")
function self:onOpen(packet)
  local time=3
  local i=0
  World.Timer(20,function()
      i=i+1
      if i>=time then
        UI:closeWindow(self)
        return false
      else
        return true
      end
      
  end)
  self.BG.Text:setText(packet.name.." x"..packet.count)
end