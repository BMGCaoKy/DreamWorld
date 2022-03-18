print("startup ui")
function self:onOpen(packet)
  
  self.Balo.onMouseClick = function()
    
    UI:openWindow("Bag")
  end
  self.Craft.onMouseClick = function()
    
    UI:openWindow("GeneralCraftingTable")
  end
end