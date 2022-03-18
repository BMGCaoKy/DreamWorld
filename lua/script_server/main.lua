print('script_server:hello world')
require "script_server.PlayerVariable"
local function printTable(tb)
  for k,v in pairs(tb) do
    print(k)
    print(v)
    if type(v)=="table" then
      printTable(v)
    end
  end
end

Trigger.RegisterHandler(Entity.GetCfg("myplugin/player1"), "ENTITY_ENTER", function(context)
    local player = context.obj1
    local NewPlayer_data=player:getValue("NewPlayer")
    if NewPlayer_data.isLogin==false then
      local pos = Lib.v3(-31.51,53.01,26.04)
      PackageHandlers.sendServerHandler(player,"showGuideTarget",{pos=pos})
    end
end)

Trigger.RegisterHandler(Entity.GetCfg("myplugin/npc-job"), "ENTITY_CLICK", function(context)
    local player = context.obj1
    local player_click = context.obj2
    if player.name=="NPC Job" then
      local NewPlayer_data=player_click:getValue("NewPlayer")
      if NewPlayer_data.isLogin==false then
        PackageHandlers.sendServerHandler(player_click,"closeTutorial_1")
        NewPlayer_data.isLogin=true
        NewPlayer_data.dateJoin.day=tonumber(os.date ("%d"))
        NewPlayer_data.dateJoin.month=tonumber(os.date ("%m"))
        NewPlayer_data.dateJoin.year=tonumber(os.date ("%Y"))
        printTable(NewPlayer_data)
        player_click:setValue("NewPlayer",NewPlayer_data)
        PackageHandlers.sendServerHandler(player_click,"closeGuideTarget")
      end
      
    end
end)

Trigger.RegisterHandler(World.cfg, "GAME_START", function()
  local map = World.CurWorld.defaultMap
  local newRegion = map:addRegion(Lib.v3(-34, 53, 37), Lib.v3(-30, 52, 34), "myplugin/7c90d499-6e36-46a6-a37d-162e8449cbc6")
    Trigger.RegisterHandler(newRegion.cfg, "REGION_ENTER", function(context)
      local NewPlayer_data=context.obj1:getValue("NewPlayer")
      if NewPlayer_data.isLogin==false then
        PackageHandlers.sendServerHandler(context.obj1,"showTutorial_1")
      end
    end)
  
  Trigger.RegisterHandler(newRegion.cfg, "REGION_LEAVE", function(context)
      local NewPlayer_data=context.obj1:getValue("NewPlayer")
        if NewPlayer_data.isLogin==false then
          PackageHandlers.sendServerHandler(context.obj1,"closeTutorial_1")
        end
    end)
end)
PackageHandlers.registerServerHandler("costCraft",function(player,packet)
  local bag=player:getValue("Bag")
  for k,v in pairs(bag.bag) do
    for kk,vv in pairs(packet.cost) do
      if v.id==vv.id then
        v.count=v.count-vv.count
      end
    end
  end
  local newBag={}
  for k,v in pairs(bag.bag) do
    if v.count>0 then
      newBag[#newBag+1]=v
    end
  end
  bag.bag=newBag
  player:setValue("Bag",bag)
end)
PackageHandlers.registerServerHandler("sendBagToUIBalo",function(player,packet)
      PackageHandlers.sendServerHandler(player,"getBaloFromServerToBalo",{balo=player:getValue("Bag")})
  end)
PackageHandlers.registerServerHandler("sendBagToUICraft",function(player,packet)
    World.Timer(10, function()
      PackageHandlers.sendServerHandler(player,"getBaloFromServerToCraft",{balo=player:getValue("Bag")})
      return true
    end)
  end)