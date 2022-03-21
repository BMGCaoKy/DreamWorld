print("startup ui")
function self:onOpen(packet)
  self.Miner.onMouseClick=function()
    self.Loading:setVisible(true)
    self.Miner:setVisible(false)
    local i=math.random(10,20)
    local value=0
    local codinh=i
    --Me:setActorPause(true)
    World.Timer(20,function()
        i=i-1
        value=value+1/codinh
        self.Loading:setProgress(value)
        if i<0 then 
          UI:closeSceneWindow("UIMiner")
          PackageHandlers.sendClientHandler("addMaterial",{id=1,count=5})
          --Me:setActorPause(false)
          return false
        else 
          return true
        end
    end)
  end
  
end