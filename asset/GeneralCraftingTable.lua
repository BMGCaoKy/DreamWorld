function self:onOpen(packet)

  local data_ghep=require "script_common.Item"
  self.BG.Close.onMouseClick=function()
    UI:closeWindow(self)
  end
  for i=1,self.BG.ScrollableView.itemList:getChildCount() do
    if i>#data_ghep then
      self.BG.ScrollableView.itemList:child("item"..i):setVisible(false)
    else
      self.BG.ScrollableView.itemList:child("item"..i):setNormalImage(data_ghep[i].image)
      self.BG.ScrollableView.itemList:child("item"..i).Text:setText(data_ghep[i].name)
    end
    self.BG.ScrollableView.itemList:child("item"..i).onMouseClick = function()
      for j=1,#data_ghep do
        if data_ghep[j].id==i then
          UI:openWindow("DetailedCraftingTable","DetailedCraftingTable","layouts",{id=i})
        end
      end
    end
  end
end