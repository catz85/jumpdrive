local MP = minetest.get_modpath("jumpdrive")

local has_travelnet_mod = minetest.get_modpath("travelnet")
local has_locator_mod = minetest.get_modpath("locator")
local has_elevator_mod = minetest.get_modpath("elevator")
local has_display_mod = minetest.get_modpath("display_api")
local has_itemframes_mod = minetest.get_modpath("itemframes")
local has_telemosaic_mod = minetest.get_modpath("telemosaic")

dofile(MP.."/compat/travelnet.lua")
dofile(MP.."/compat/locator.lua")
dofile(MP.."/compat/elevator.lua")
dofile(MP.."/compat/signs.lua")
dofile(MP.."/compat/itemframes.lua")
--dofile(MP.."/compat/telemosaic.lua")


jumpdrive.node_compat = function(name, source_pos, target_pos)
	if (name == "locator:beacon_1" or name == "locator:beacon_2" or name == "locator:beacon_3") and has_locator_mod then
		jumpdrive.locator_compat(source_pos, target_pos)

	--elseif name == "telemosaic:beacon" then
	--	jumpdrive.telemosaic_compat(source_pos, target_pos)
	end
end

jumpdrive.target_region_compat = function(pos1, pos2)
	if has_travelnet_mod then
		local pos_list = minetest.find_nodes_in_area(pos1, pos2, {"travelnet:travelnet"})
		if pos_list then
			for _,pos in pairs(pos_list) do
				jumpdrive.travelnet_compat(pos)
			end
		end
	end

	if has_elevator_mod then
		jumpdrive.elevator_compat(pos1, pos2)
	end

	if has_display_mod then
		jumpdrive.signs_compat(pos1, pos2)
	end

	if has_itemframes_mod then
		--jumpdrive.itemframes_compat(pos1, pos2)
		-- does not work: enclosed tmp variable in on_activate :(
		--https://gitlab.com/VanessaE/homedecor_modpack/blob/master/itemframes/init.lua#L15
	end

end
