print("startup ui")
function self:onOpen(packet)

  self.BG.Image:setImage(packet.data.image)
  self.BG.Close.onMouseClick = function()
    UI:closeWindow(self)
  end
  self.BG.Name:setText(packet.data.name)
  self.BG.Inform:setText(packet.data.describe)
  self.BG.Image:setImage(packet.data.image)
end