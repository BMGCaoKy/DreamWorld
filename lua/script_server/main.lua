print('script_server:hello world')
require "script_server.PlayerVariable"


local function lenTb(table)
    local rs=0
    for k,v in pairs(table) do
        rs=rs+1
    end
    return rs
end
local function copyTable(table)
  local rs={}
  for k,v in pairs(table) do
    if k~="stack" then
      rs[k]=v
    end
  end
  return rs
end
local function printtable(node)
    local cache, stack, output = {},{},{}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k,v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k,v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str,"}",output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str,"\n",output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output,output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "["..tostring(k).."]"
                else
                    key = "['"..tostring(k).."']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = "..tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = {\n"
                    table.insert(stack,node)
                    table.insert(stack,v)
                    cache[node] = cur_index+1
                    break
                else
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = '"..tostring(v).."'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output,output_str)
    output_str = table.concat(output)

    print(output_str)
end

local function formatBalo(player)
  local balo=player:getValue("Bag")
  local material=require "script_common.Material"
  for kk,vv in pairs(material) do
      local add=0
      local data={}
      for k,v in pairs(balo.bag) do
        if vv.id==v.id then
          data=copyTable(v)
          if vv.stack<v.count then
            add=v.count-vv.stack
            v.count=vv.stack
          elseif v.count+add>vv.stack and vv.stack>v.count then
            add=v.count+add-vv.stack
            v.count=vv.stack
          elseif v.count+add<vv.stack and vv.stack>v.count then
            v.count=v.count+add
          elseif v.count==vv.stack then
            add=v.count
          end
        end
      end
      while add>0 and vv.stack<add do
        local newData=copyTable(data)
        newData.count=vv.stack
        balo.bag[lenTb(balo.bag)+1]=newData
        add=add-vv.stack
      end
      if add>0 and vv.stack>=add then
        local newData=copyTable(data)
        newData.count=add
        balo.bag[lenTb(balo.bag)+1]=newData
      end
  end
  if lenTb(balo.bag)>balo.maxSlot then
    return -99
  else
    player:setValue("Bag",balo)
    return 1
  end
end




local function checkSlotBaloMaterial(balo, id,count)
  local material=require "script_common.Material"
  local isFind=false
  for k,v in pairs(balo.bag) do
    if v.id==id then 
      v.count=v.count+count 
      isFind=true
    end
  end
  if isFind==false then
    local updateData={}
    for k,v in pairs(material) do
      if v.id==id then
        updateData=copyTable(v)
        updateData.count=count
      end
    end
    balo.bag[lenTb(balo.bag)+1]=updateData
  end
  
  local newData={}
  for kk,vv in pairs(material) do
      local add=0
      local data={}
      for k,v in pairs(balo.bag) do
        if vv.id==v.id then
          data=copyTable(v)
          if vv.stack<v.count then
            add=v.count-vv.stack
            v.count=vv.stack
            print(vv.name.." count:"..v.count.." add:"..add)
          elseif v.count+add>vv.stack and vv.stack>v.count then
            add=v.count+add-vv.stack
            v.count=vv.stack
            print(vv.name.." count:"..v.count.." add:"..add)
          elseif v.count+add<vv.stack and vv.stack>v.count then
            v.count=v.count+add
            print(vv.name.." count:"..v.count.." add:"..add)
          elseif v.count==vv.stack then
            --
          end
        end
      end
      while add>0 and vv.stack<add do
        local newData=copyTable(data)
        newData.count=vv.stack
        balo.bag[lenTb(balo.bag)+1]=newData
        add=add-vv.stack
      end
      if add>0 and vv.stack>=add then
        local newData=copyTable(data)
        newData.count=add
        balo.bag[lenTb(balo.bag)+1]=newData
      end
  end
  
  print(lenTb(balo.bag))
  printtable(balo)
  if lenTb(balo.bag)>balo.maxSlot then
    return false
  else
    return true
  end
end

local function getAllMaterial(player)
  local balo=player:getValue("Bag")
  local material=require "script_common.Material"
  local data={}
  for k,v in pairs(material) do
    for kk,vv in pairs(balo.bag) do
      if v.id==vv.id then
        data[lenTb(data)+1]=copyTable(vv)
        break
      end
    end
  end
  for k,v in pairs(data) do
    local count=0
    for kk,vv in pairs(balo.bag) do
      if v.id==vv.id then
        count=count+vv.count
      end
    end
    v.count=count
  end
  return data
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
  --[=[local mineRegion = map:addRegion(Lib.v3(-29.68, 53, 62.38), Lib.v3(-29.68, 53, 62.38), "myplugin/bab4bc03-1f80-47c5-a25f-4d625395493b")
  Trigger.RegisterHandler(mineRegion.cfg, "REGION_ENTER", function(context)
    PackageHandlers.sendServerHandler(context.obj1,"showUIMiner",{pos=Lib.v3(-29.68, 53+1.5, 62.38)})
  end)
  Trigger.RegisterHandler(mineRegion.cfg, "REGION_LEAVE", function(context)
    PackageHandlers.sendServerHandler(context.obj1,"closeUIMiner")
  end)]=]--
end)
PackageHandlers.registerServerHandler("costCraft",function(player,packet)
  local bag=player:getValue("Bag")
  bag.bag=getAllMaterial(player)
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
  formatBalo(player)
end)
PackageHandlers.registerServerHandler("sendBagToUIBalo",function(player,packet)
      PackageHandlers.sendServerHandler(player,"getBaloFromServerToBalo",{balo=player:getValue("Bag")})
  end)
PackageHandlers.registerServerHandler("sendBagToUICraft",function(player,packet)
      local balo=player:getValue("Bag")
      balo.bag=getAllMaterial(player)
      PackageHandlers.sendServerHandler(player,"getBaloFromServerToCraft",{balo=balo})
  end)
PackageHandlers.registerServerHandler("sendBagToUIFurnace",function(player,packet)
      local balo=player:getValue("Bag")
      balo.bag=getAllMaterial(player)
      PackageHandlers.sendServerHandler(player,"getBaloFromServerToFurnace",{balo=balo})
  end)
PackageHandlers.registerServerHandler("addMaterial",function(player,packet)
    print("them vp id:"..packet.id.." so luong "..packet.count)
  local balo=player:getValue("Bag")
  balo.bag=getAllMaterial(player)
  player:setValue("Bag",balo)
  balo=player:getValue("Bag")
  
  local isHave=checkSlotBaloMaterial(balo, packet.id,packet.count)
  
  if isHave then
    local isFind=false
    balo=player:getValue("Bag")
    for k,v in pairs(balo.bag) do
      if v.id==packet.id then
        v.count=v.count+packet.count
        player:setValue("Bag",balo)
        formatBalo(player)
        isFind=true
        break
      end
    end
    if isFind==false then
      local material=require "script_common.Material"
      local data={}
      for kk,vv in pairs(material) do
        if vv.id==packet.id then
          data=copyTable(vv)
          data.count=packet.count
          break
        end
      end
      balo.bag[lenTb(balo.bag)+1]=data
      player:setValue("Bag",balo)
      formatBalo(player)
    end
  else
    formatBalo(player)
    PackageHandlers.sendServerHandler(player,"showNotification",{text=1,time=1})
  end
end)
PackageHandlers.registerServerHandler("changeActionByBuff",function(player,packet)
  player:addBuff("myplugin/digAction",20)
end)