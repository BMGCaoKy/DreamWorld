print("startup ui")
local i=0
local data={}
local status=true
local bg=self.BG
local id
local cost=0
function self:onOpen(packet)
  World.Timer(10, function()
    PackageHandlers.sendClientHandler("sendBagToShop")
    bg.closeBtn.onMouseClick=function()
      UI:closeWindow(self)
      status=false
    end
    return status
  end)
  PackageHandlers.registerClientHandler("getBaloFromServerToShop", function(player, packet)
      self.BG.ItemData.Money:setText(packet.inform.money)
    for k,v in pairs(data) do
      local isFind=false
      for kk,vv in pairs(packet.balo.bag) do
        if v.id==vv.id then
          isFind=true
          break
        end
      end
      if isFind==false then
        table.remove(data,k)
        self.BG.ItemList.ScrollableView.GridView:child("Item"..k):setVisible(false)
      end
    end
    for k,v in pairs(packet.balo.bag) do
      local isFind=false
      for kk,vv in pairs(data) do
        if v.id==vv.id then
          isFind=true
          data[kk]=v
          if v.count==0 then
            self.BG.ItemList.ScrollableView.GridView:child("Item"..kk):setVisible(false)
          else
            self.BG.ItemList.ScrollableView.GridView:child("Item"..kk).Text:setText(v.count)
          end
          break
        end
      end
      if isFind==false then
        if v.src=="Miner" then
          i=#data+1
          data[i]=v
          self.BG.ItemList.ScrollableView.GridView:child("Item"..i):setVisible(true)
          self.BG.ItemList.ScrollableView.GridView:child("Item"..i):setNormalImage(v.image)
          self.BG.ItemList.ScrollableView.GridView:child("Item"..i).Text:setText(v.count)
        end
      end
    end
  
    for j=1,#data do
      self.BG.ItemList.ScrollableView.GridView:child("Item"..j).onMouseClick=function()
        id=data[j].id
        --UI:openWindow("ItemInform","ItemInform","layouts",{data=data[j]})
        cost=0
        self.BG.ItemData.Image:setVisible(true)
        self.BG.ItemData.VerticalLayout:setVisible(true)
        self.BG.ItemData.Image:setImage(data[j].image)
        self.BG.ItemData.VerticalLayout.Text:setText(cost)
        self.BG.ItemData.VerticalLayout.Slider:setMaxValue(data[j].count)
        self.BG.ItemData.VerticalLayout.Slider:setClickStep(1)
        self.BG.ItemData.VerticalLayout.Slider.onSliderValueChanged = function(p)
          cost=math.ceil(p:getCurrentValue())
          self.BG.ItemData.VerticalLayout.Text:setText(cost)
        end
      end
    end
    self.BG.ItemData.VerticalLayout.Button.onMouseClick=function()
      local count=self.BG.ItemData.VerticalLayout.Slider:getCurrentValue()
      print("Dung "..id.." sl: "..cost)
      PackageHandlers.sendClientHandler("costShop",{cost={{id=id,count=cost}}})
    end
  end)
  
end

  