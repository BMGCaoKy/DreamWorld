
function self:onOpen(packet)
  local closeBtn=self.BG.Button
  local status=true
  World.Timer(10, function()
    PackageHandlers.sendClientHandler("sendBagToUICraft")
    
    closeBtn.onMouseClick = function()
      UI:closeWindow(self)
      status=false
    end
    return status
  end)
  
  local id=packet.id
  local data_ghep=require "script_common.Item"
  local data_material=require "script_common.Material"
  self.BG.Image:setImage(data_ghep[packet.id].image)
  local materialCost={}
  for i=1,5 do
    if i>#data_ghep[packet.id].material then
      self.BG.HorizontalLayout:child("item"..i):setVisible(false)
    else
      self.BG.HorizontalLayout:child("item"..i).btn:setNormalImage(data_material[data_ghep[packet.id].material[i].id].image)
      
      PackageHandlers.registerClientHandler("getBaloFromServerToCraft", function(player, packet)
          local isOK={}
          local arr={}
        for k,v in pairs(packet.balo.bag) do
          --for kk,vv in pairs(data_ghep[id].material[i]) do
           -- print(k)
          --  print(v)
          --end
          for l=1,#data_ghep[id].material do
            if v.id==data_ghep[id].material[l].id then
              arr[l]=true
              self.BG.HorizontalLayout:child("item"..l).Text:setText(v.count.."/"..data_ghep[id].material[l].count)
              
              if v.count>=data_ghep[id].material[l].count then
                isOK[#isOK+1]=true
              else
                isOK[#isOK+1]=false
              end
              break
           -- else
              --self.BG.HorizontalLayout:child("item"..l).Text:setText("0/"..data_ghep[id].material[l].count)
            end
          end
        end
        for j=1,#data_ghep[id].material do
          if arr[j]==nil then
            self.BG.HorizontalLayout:child("item"..j).Text:setText("0/"..data_ghep[id].material[j].count)
            isOK[#isOK+1]=false
          end
        end
        materialCost=data_ghep[id].material
        self.BG.Craft.onMouseClick=function()
          local isCraft=true
          for m=1,#isOK do
            isCraft=isCraft and isOK[m]
          end
          if isCraft then
            UI:openWindow("GiveItem","GiveItem","layouts",{time=2})
            PackageHandlers.sendClientHandler("costCraft",{cost=materialCost})
          else
            UI:openWindow("Notification","Notification","layouts",{text=2, time=2})
          end
        end
      end)
    end
  end
  for j=1,#data_ghep[packet.id].material do
    self.BG.HorizontalLayout:child("item"..j).btn.onMouseClick = function()
      UI:openWindow("ItemInform","ItemInform","layouts",{data=data_material[data_ghep[packet.id].material[j].id]})
    end
  end
  
end