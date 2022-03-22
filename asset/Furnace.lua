print("startup ui")
function self:onOpen(packet)
  local closeBtn=self.BG.Close
  local status=true
  World.Timer(10, function()
    PackageHandlers.sendClientHandler("sendBagToUIFurnace")
    
    closeBtn.onMouseClick = function()
      UI:closeWindow(self)
      status=false
    end
    return status
  end)
  
  local data_ghep=require "script_common.Item"
  local data_material=require "script_common.Material"
  PackageHandlers.registerClientHandler("getBaloFromServerToFurnace", function(player, packet)
    local num=0
    local materialCost={id=4,count=2}
    for k,v in pairs(packet.balo.bag) do
      if v.id==4 then
        self.BG.Item.count:setText(v.count.."/1")
        num=v.count
      else
        self.BG.Item.count:setText("0/1")
      end
    end
    if num>0 then
      UI:openWindow("GiveItem","GiveItem","layouts",{time=2})
      PackageHandlers.sendClientHandler("costCraft",{cost=materialCost})
    else
      UI:openWindow("Notification","Notification","layouts",{text=2, time=2})
    end

      end)
    
  end

  
end