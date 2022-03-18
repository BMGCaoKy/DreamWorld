function self:onOpen(packet)
  self.BG.Text:setText(packet.text)
  local i=0
  World.Timer(20,function()
    i=i+1
    if i>=packet.time then
      UI:closeWindow(self)
      return false
    else
      return true
    end
  end)
end