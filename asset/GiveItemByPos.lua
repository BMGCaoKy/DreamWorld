print("startup ui")
function self:onOpen(packet)
  local value=0
  local step=1/packet.time
  World.Timer(20,function()
    value=value+step
    self.ProgressBar:setProgress(value)
    if value>=1 then
     --[=[ local lucky=0
      local idItem=2
      lucky=math.random(1,100)
      if lucky<=1 then
        id=7
      elseif lucky<=26 then
        id=6
      elseif lucky<=31 then
        id=5
      else
        id=2
      end]=]--
      PackageHandlers.sendClientHandler("addMaterial",{id=packet.id,count=packet.count})
      UI:closeSceneWindow("GiveItemByPos")
      PackageHandlers.sendClientHandler("showItem",{id=packet.id,count=packet.count})
      return false
    else
      return true
    end
  end)
end