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
-- TODO
-- Use biomes in the decoration definition depending on their heat_point humidity_point
-- instead of spawning it with a rather low fill_ratio everywhere
local ratio_abundant = 0.001
local ratio_common = 0.0005
local ratio_normal = 0.0003
local ratio_uncommon = 0.0002
local ratio_rare = 0.0001
local ratio_very_rare = 0.00003

local coniferous_place_on = {
	xcompat.materials.dirt_with_grass,
	"default:dirt_with_coniferous_litter",
}

moretrees.beech_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	fill_ratio = ratio_normal,
}

moretrees.palm_biome = {
	place_on = xcompat.materials.sand,
	min_elevation = -1,
	max_elevation = 1,
	fill_ratio = ratio_abundant,
}

moretrees.date_palm_biome = {
	place_on = xcompat.materials.desert_sand,
	min_elevation = -1,
	max_elevation = 8,
	fill_ratio = ratio_common,
}

moretrees.date_palm_biome_2 = {
	place_on = xcompat.materials.desert_sand,
	min_elevation = 9,
	max_elevation = 30,
	spawn_by = { xcompat.materials.water_source },
	num_spawn_by = 1,
	fill_ratio = ratio_abundant,
}

moretrees.apple_tree_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 1,
	max_elevation = 10,
	biomes = { "deciduous_forest" },
	fill_ratio = ratio_rare,
}

moretrees.oak_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 10,
	fill_ratio = ratio_normal,
}

moretrees.sequoia_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 10,
	fill_ratio = ratio_rare,
}

moretrees.birch_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 10,
	max_elevation = 15,
	fill_ratio = ratio_common,
}

moretrees.willow_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = -5,
	max_elevation = 5,
	fill_ratio = ratio_uncommon,
}

moretrees.rubber_tree_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = -5,
	max_elevation = 8,
	fill_ratio = ratio_normal,
}

moretrees.jungletree_biome = {
	place_on = {
		xcompat.materials.dirt,
		xcompat.materials.dirt_with_grass,
		"woodsoils:dirt_with_leaves_1",
		"woodsoils:grass_with_leaves_1",
		"woodsoils:grass_with_leaves_2",
		"default:dirt_with_rainforest_litter",
	},
	min_elevation = 1,
	spawn_by = core.get_modpath("default") and { "default:jungletree" } or nil,
	num_spawn_by = core.get_modpath("default") and 1 or nil,
	biomes = { "rainforest", "rainforest_swamp" },
}

moretrees.spruce_biome = {
	place_on = coniferous_place_on,
	min_elevation = 20,
	fill_ratio = ratio_uncommon,
}

moretrees.cedar_biome = {
	place_on = coniferous_place_on,
	min_elevation = 0, --Added to solve an issue where cedar trees would sometimes spawn deep underground
	fill_ratio = ratio_rare,
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
-- Poplar requires a lot of water.
moretrees.poplar_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = { xcompat.materials.water_source },
	num_spawn_by = 3,
	fill_ratio = ratio_abundant,
}

-- Spawn an occasional poplar elsewhere.
moretrees.poplar_biome_2 = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	fill_ratio = ratio_very_rare,
}

-- Subterranean lakes provide enough water for poplars to grow
moretrees.poplar_biome_3 = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = -50,
	max_elevation = 0,
	spawn_by = { xcompat.materials.water_source },
	num_spawn_by = 3,
	fill_ratio = ratio_abundant,
}

moretrees.poplar_small_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = { xcompat.materials.water_source },
	num_spawn_by = 1,
	fill_ratio = ratio_normal,
}

moretrees.poplar_small_biome_2 = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = { xcompat.materials.water_source },
	num_spawn_by = 5,
	fill_ratio = ratio_abundant,
}

moretrees.fir_biome = {
	place_on = coniferous_place_on,
	min_elevation = 25,
	fill_ratio = ratio_normal,
}

moretrees.fir_biome_snow = {
	place_on = { "snow:dirt_with_snow", "snow:snow" },
	below_nodes = { xcompat.materials.dirt, xcompat.materials.dirt_with_grass, "snow:dirt_with_snow" },
	fill_ratio = ratio_normal,
}