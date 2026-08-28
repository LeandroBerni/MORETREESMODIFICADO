-- saplings.lua - Lógica de crecimiento de retoños optimizada para Luanti
local dirt_surfaces = {
	["default:dirt"] = true,
	["default:dirt_with_grass"] = true,
	["default:dirt_with_dry_grass"] = true,
	["default:dirt_with_coniferous_litter"] = true,
	["default:dirt_with_rainforest_litter"] = true,
	["woodsoils:dirt_with_leaves_1"] = true,
	["woodsoils:dirt_with_leaves_2"] = true,
}

local conifer_surfaces = {
	["default:dirt"] = true,
	["default:dirt_with_grass"] = true,
	["default:dirt_with_coniferous_litter"] = true,
	["default:dirt_with_snow"] = true,
}

local sand_surfaces = {
	["default:sand"] = true,
	["default:desert_sand"] = true,
}

local function has_clearance(pos, radius, height)
	local minp = vector.new(pos.x - radius, pos.y + 1, pos.z - radius)
	local maxp = vector.new(pos.x + radius, pos.y + height, pos.z + radius)
	
	local nodes = core.find_nodes_in_area(minp, maxp, { "group:tree", "group:leaves" })
	return #nodes < 12
end

function moretrees.can_grow(pos, treename)
	local surfaces
	if treename == "spruce" or treename == "fir" or treename == "cedar" or treename == "pine" then
		surfaces = conifer_surfaces
	elseif string.find(treename, "palm") then
		surfaces = sand_surfaces
	else
		surfaces = dirt_surfaces
	end

	local node_below = core.get_node(vector.new(pos.x, pos.y - 1, pos.z))
	if not surfaces[node_below.name] then
		return false
	end

	return has_clearance(pos, 3, 6)
end