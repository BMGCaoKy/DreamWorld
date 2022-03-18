print("startup ui")
function self:onOpen(packet)
  local value=0
  local step=1/packet.time
  World.Timer(20,function()
      value=value+step
    self.ProgressBar:setProgress(value)
    if value>=1 then
      UI:closeWindow(self)
      return false
    else
      return true
    end
  end)
end