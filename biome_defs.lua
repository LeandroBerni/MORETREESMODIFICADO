-- biome_defs.lua - Definición de biomas y decoraciones optimizadas para Luanti
local S = core.get_translator("moretrees")

-- Tabla de definiciones base completa y mapeada de forma estricta
moretrees.biome_defs = {
	beech = {
		surface = { "default:dirt_with_grass" },
		avoid_nodes = { "group:tree" },
		rarity = 0.002,
		biomes = { "deciduous_forest" },
		y_min = 1,
		y_max = 3000,
	},
	apple_tree = {
		surface = { "default:dirt_with_grass" },
		avoid_nodes = { "group:tree" },
		rarity = 0.002,
		biomes = { "deciduous_forest" },
		y_min = 1,
		y_max = 3000,
	},
	oak = {
		surface = { "default:dirt_with_grass" },
		avoid_nodes = { "group:tree" },
		rarity = 0.0015,
		biomes = { "deciduous_forest" },
		y_min = 1,
		y_max = 3000,
	},
	sequoia = {
		surface = { "default:dirt_with_grass", "default:dirt_with_coniferous_litter" },
		avoid_nodes = { "group:tree" },
		rarity = 0.0003,
		biomes = { "coniferous_forest" },
		y_min = 10,
		y_max = 3000,
	},
	birch = {
		surface = { "default:dirt_with_grass" },
		avoid_nodes = { "group:tree" },
		rarity = 0.002,
		biomes = { "deciduous_forest" },
		y_min = 1,
		y_max = 3000,
	},
	palm = {
		surface = { "default:sand" },
		avoid_nodes = { "group:tree" },
		rarity = 0.001,
		biomes = { "sand ocean", "desert" },
		y_min = 1,
		y_max = 10,
	},
	date_palm = {
		surface = { "default:desert_sand", "default:sand" },
		avoid_nodes = { "group:tree" },
		rarity = 0.0008,
		biomes = { "desert" },
		y_min = 1,
		y_max = 50,
	},
	spruce = {
		surface = { "default:dirt_with_coniferous_litter", "default:dirt_with_snow" },
		avoid_nodes = { "group:tree" },
		rarity = 0.002,
		biomes = { "taiga", "coniferous_forest" },
		y_min = 1,
		y_max = 3000,
	},
	cedar = {
		surface = { "default:dirt_with_coniferous_litter" },
		avoid_nodes = { "group:tree" },
		rarity = 0.0015,
		biomes = { "coniferous_forest" },
		y_min = 5,
		y_max = 3000,
	},
	poplar = {
		surface = { "default:dirt_with_grass" },
		avoid_nodes = { "group:tree" },
		rarity = 0.001,
		biomes = { "deciduous_forest" },
		y_min = 1,
		y_max = 3000,
	},
	poplar_small = {
		surface = { "default:dirt_with_grass" },
		avoid_nodes = { "group:tree" },
		rarity = 0.001,
		biomes = { "deciduous_forest" },
		y_min = 1,
		y_max = 3000,
	},
	willow = {
		surface = { "default:dirt_with_grass" },
		avoid_nodes = { "group:tree" },
		rarity = 0.001,
		biomes = { "deciduous_forest_swamp" },
		y_min = 1,
		y_max = 20,
	},
	rubber_tree = {
		surface = { "default:dirt_with_rainforest_litter", "default:dirt_with_grass" },
		avoid_nodes = { "group:tree" },
		rarity = 0.0008,
		biomes = { "rainforest" },
		y_min = 1,
		y_max = 3000,
	},
	fir = {
		surface = { "default:dirt_with_coniferous_litter", "default:dirt_with_snow" },
		avoid_nodes = { "group:tree" },
		rarity = 0.0015,
		biomes = { "taiga", "coniferous_forest" },
		y_min = 10,
		y_max = 3000,
	},
	jungletree = {
		surface = { "default:dirt_with_rainforest_litter", "default:dirt_with_grass" },
		avoid_nodes = { "group:tree" },
		rarity = 0.001,
		biomes = { "rainforest" },
		y_min = 1,
		y_max = 3000,
	},
}

-- Registro de alta seguridad contra valores nil
function moretrees.register_tree_decoration(treename, biomes, min_y, max_y)
	if not treename or type(treename) ~= "string" then
		return
	end

	local def = (moretrees.biome_defs and moretrees.biome_defs[treename]) or {
		surface = { "default:dirt_with_grass" },
		rarity = 0.0015,
		biomes = biomes or { "deciduous_forest" },
		y_min = min_y or 1,
		y_max = max_y or 3000,
	}

	local fill_val = def.rarity or 0.0015
	local modpath = core.get_modpath("moretrees") or ""

	local deco_def = {
		name = "moretrees:" .. treename .. "_tree",
		deco_type = "schematic",
		place_on = def.surface or { "default:dirt_with_grass" },
		sidelen = 16,
		fill_ratio = fill_val,
		biomes = biomes or def.biomes or { "deciduous_forest" },
		y_max = max_y or def.y_max or 31000,
		y_min = min_y or def.y_min or 1,
		schematic = modpath .. "/schematics/" .. treename .. ".mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
		spawn_by = { "default:dirt_with_grass", "default:dirt" },
		num_spawn_by = 3,
	}

	-- Verificación estricta antes de invocar el API nativo
	if deco_def and type(deco_def) == "table" and deco_def.name then
		core.register_decoration(deco_def)
	end
end