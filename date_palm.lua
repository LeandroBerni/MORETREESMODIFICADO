-- date_palm.lua - Sistema de floración y polinización optimizado
local S = core.get_translator("moretrees")

local ftrunk = table.copy(core.registered_nodes["moretrees:date_palm_trunk"] or {})
ftrunk.drop = "moretrees:date_palm_trunk"
ftrunk.after_destruct = function(pos, oldnode)
	local dates = core.find_nodes_in_area(
		vector.new(pos.x - 2, pos.y - 1, pos.z - 2),
		vector.new(pos.x + 2, pos.y + 1, pos.z + 2),
		{ "group:moretrees_dates" }
	)
	for i = 1, #dates do
		local datespos = dates[i]
		local items = core.get_node_drops(core.get_node(datespos).name)
		core.swap_node(datespos, { name = "air" })
		for j = 1, #items do
			core.add_item(datespos, items[j])
		end
	end
end

core.register_node("moretrees:date_palm_ffruit_trunk", ftrunk)
core.register_node("moretrees:date_palm_mfruit_trunk", ftrunk)

core.register_abm({
	label = "Moretrees: Date Palm Fruit Growth",
	nodenames = { "moretrees:date_palm_ffruit_trunk", "moretrees:date_palm_mfruit_trunk" },
	interval = 25,
	chance = 12,
	action = function(pos, node)
		local dates = core.find_nodes_in_area(
			vector.new(pos.x - 2, pos.y, pos.z - 2),
			vector.new(pos.x + 2, pos.y, pos.z + 2),
			{ "group:moretrees_dates" }
		)

		if #dates < 4 then
			local dx = math.random(-2, 2)
			local dz = math.random(-2, 2)
			local datepos = vector.new(pos.x + dx, pos.y, pos.z + dz)
			
			if core.get_node(datepos).name == "air" then
				local target_fruit = (node.name == "moretrees:date_palm_ffruit_trunk") and "moretrees:dates_f0" or "moretrees:dates_m0"
				core.swap_node(datepos, { name = target_fruit })
			end
		end
	end,
})