print("startup ui")
function self:onOpen(packet)
  local slot=self.BG.ScrollableView.GridView
  local closeBtn=self.BG.Close
  local status=true
  World.Timer(10, function()
    
    PackageHandlers.sendClientHandler("sendBagToUIBalo")
    closeBtn.onMouseClick=function()
      UI:closeWindow(self)
      status=false
    end
    print("-----------"..tostring(status))
    return status
  end)
  
  PackageHandlers.registerClientHandler("getBaloFromServerToBalo", function(player, packet)
      local balo=packet.balo
      for i=1, balo.maxSlot do
        slot:child("Slot"..i):setVisible(true)
        if balo.bag[i]==nil or balo.bag[i].count==nil then
          slot:child("Slot"..i).Count:setVisible(false)
        else
          slot:child("Slot"..i).Count:setText(balo.bag[i].count)
           slot:child("Slot"..i):setNormalImage(balo.bag[i].image)
        end
      end
      for j=1,#balo.bag do
        slot:child("Slot"..j).onMouseClick = function()
      UI:openWindow("ItemInform","ItemInform","layouts",{data=balo.bag[j]})
        end
      end
  end)
  
end