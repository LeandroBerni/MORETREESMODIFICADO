-- More trees!  2013-04-07
--
-- This mod adds more types of trees to the game
--
-- Some of the node definitions and textures came from cisoun's conifers mod
-- and bas080's jungle trees mod.
--
-- Brought together into one mod and made L-systems compatible by Vanessa
-- Ezekowitz.
--
-- Firs and Jungle tree axioms/rules by Vanessa Dannenberg, with the
-- latter having been tweaked by RealBadAngel, most other axioms/rules written
-- by RealBadAngel.
--

moretrees = {}

local S = core.get_translator("moretrees")

if core.get_modpath("default") then
	core.override_item("default:sapling", {
		description = S("Sapling"),
	})

	core.override_item("default:tree", {
		description = S("Tree"),
	})

	core.override_item("default:wood", {
		description = S("Wooden Planks"),
	})

	core.override_item("default:leaves", {
		description = S("Leaves"),
	})

	core.override_item("default:fence_wood", {
		description = S("Wooden Fence"),
	})

	core.override_item("default:fence_rail_wood", {
		description = S("Wooden Fence Rail"),
	})
end

if core.get_modpath("doors") then
	core.override_item("doors:gate_wood_closed", {
		description = S("Wooden Fence Gate"),
	})

	core.override_item("doors:gate_wood_open", {
		description = S("Wooden Fence Gate"),
	})
end

-- Read the default config file (and if necessary, copy it to the world folder).

local worldpath = core.get_worldpath()
local modpath = core.get_modpath("moretrees")

dofile(modpath .. "/settings.lua")

if io.open(worldpath .. "/moretrees_settings.txt", "r") then
	io.close()
	dofile(worldpath .. "/moretrees_settings.txt")
end

-- Validate that if ethereal exists, that it's version is greater than 20220424.
-- Lower versions of ethereal clear registered biomes and decorations during
-- initialization which results in lost content from this mod (and others)
-- depending on where they are in the mod load order.
core.register_on_mods_loaded(function()
	if core.global_exists("ethereal") then
		local ethereal_ver = tonumber(ethereal.version)
		if ethereal_ver and ethereal_ver < 20220424 then
			error(
				"[moretrees] The version of ethereal detected can result "
					.. "in parts of this mod and others disappearing due to mod "
					.. "load order. Please update ethereal."
			)
		end
	end
end)

-- infinite stacks checking

if core.get_modpath("unified_inventory") or not core.settings:get_bool("creative_mode") then
	moretrees.expect_infinite_stacks = false
else
	moretrees.expect_infinite_stacks = true
end

-- tables, load other files

moretrees.cutting_tools = {
	"default:axe_mese",
	xcompat.materials.axe_steel,
	xcompat.materials.axe_diamond,
	xcompat.materials.axe_bronze,
	"glooptest:axe_alatro",
	"glooptest:axe_arol",
	"moreores:axe_mithril",
	"moreores:axe_silver",
	"titanium:axe",
}

dofile(modpath .. "/tree_models.lua")
dofile(modpath .. "/node_defs.lua")
dofile(modpath .. "/date_palm.lua")
dofile(modpath .. "/cocos_palm.lua")
dofile(modpath .. "/biome_defs.lua")
dofile(modpath .. "/saplings.lua")
dofile(modpath .. "/crafts.lua")

-- tree spawning setup
moretrees.spawn_beech_object = moretrees.beech_model
moretrees.spawn_apple_tree_object = moretrees.apple_tree_model
moretrees.spawn_oak_object = moretrees.oak_model
moretrees.spawn_sequoia_object = moretrees.sequoia_model
moretrees.spawn_palm_object = moretrees.palm_model
moretrees.spawn_date_palm_object = moretrees.date_palm_model
moretrees.spawn_cedar_object = moretrees.cedar_model
moretrees.spawn_rubber_tree_object = moretrees.rubber_tree_model
moretrees.spawn_willow_object = moretrees.willow_model
moretrees.spawn_birch_object = "moretrees.grow_birch"
moretrees.spawn_spruce_object = "moretrees.grow_spruce"
moretrees.spawn_jungletree_object = "moretrees.grow_jungletree"
moretrees.spawn_fir_object = "moretrees.grow_fir"
moretrees.spawn_fir_snow_object = "moretrees.grow_fir_snow"
moretrees.spawn_poplar_object = moretrees.poplar_model
moretrees.spawn_poplar_small_object = moretrees.poplar_small_model

local deco_ids = {}

local function translate_biome_defs()
	if not moretrees.treelist then
		return
	end

	for _, tree in ipairs(moretrees.treelist) do
		local treename = tree[1]
		local def = moretrees.biome_defs and moretrees.biome_defs[treename]
		
		if def then
			if def.surface then
				for i, node in ipairs(def.surface) do
					if xcompat and xcompat.materials then
						def.surface[i] = xcompat.materials[node] or node
					end
				end
			end
			if def.avoid_nodes then
				for i, node in ipairs(def.avoid_nodes) do
					if xcompat and xcompat.materials then
						def.avoid_nodes[i] = xcompat.materials[node] or node
					end
				end
			end
		end
	end
end

-- Ejecución segura de la traducción y registro
translate_biome_defs()

-- Preparación de superficies y biomas con salvaguardas
if type(moretrees.treelist) == "table" then
	for _, tree in ipairs(moretrees.treelist) do
		local treename = type(tree) == "table" and tree[1] or nil
		if treename and moretrees.biome_defs and moretrees.biome_defs[treename] then
			local def = moretrees.biome_defs[treename]
			if type(def) == "table" and def.surface then
				for i, node in ipairs(def.surface) do
					if xcompat and xcompat.materials then
						def.surface[i] = xcompat.materials[node] or node
					end
				end
			end
		end
	end
end

-- Ejecución del registro de decoraciones en Luanti con aislamiento de tipos
if type(moretrees.treelist) == "table" then
	for _, tree in ipairs(moretrees.treelist) do
		local treename = type(tree) == "table" and tree[1] or nil
		if treename and type(treename) == "string" then
			moretrees.register_tree_decoration(treename)
		end
	end
end

core.register_decoration(translate_biome_defs(moretrees.beech_biome, "beech"))
core.register_decoration(translate_biome_defs(moretrees.apple_tree_biome, "apple_tree"))
core.register_decoration(translate_biome_defs(moretrees.oak_biome, "oak"))
core.register_decoration(translate_biome_defs(moretrees.sequoia_biome, "sequoia"))
core.register_decoration(translate_biome_defs(moretrees.palm_biome, "palm"))
core.register_decoration(translate_biome_defs(moretrees.date_palm_biome, "date_palm", 1))
core.register_decoration(translate_biome_defs(moretrees.date_palm_biome_2, "date_palm", 2))
core.register_decoration(translate_biome_defs(moretrees.cedar_biome, "cedar"))
core.register_decoration(translate_biome_defs(moretrees.rubber_tree_biome, "rubber_tree"))
core.register_decoration(translate_biome_defs(moretrees.willow_biome, "willow"))
core.register_decoration(translate_biome_defs(moretrees.birch_biome, "birch"))
core.register_decoration(translate_biome_defs(moretrees.spruce_biome, "spruce"))
if core.get_modpath("default") then
	core.register_decoration(translate_biome_defs(moretrees.jungletree_biome, "jungletree"))
end
core.register_decoration(translate_biome_defs(moretrees.fir_biome, "fir", 1))
if core.get_modpath("snow") then
	core.register_decoration(translate_biome_defs(moretrees.fir_biome_snow, "fir", 2))
end
core.register_decoration(translate_biome_defs(moretrees.poplar_biome, "poplar", 1))
core.register_decoration(translate_biome_defs(moretrees.poplar_biome_2, "poplar", 2))
core.register_decoration(translate_biome_defs(moretrees.poplar_biome_3, "poplar", 3))
core.register_decoration(translate_biome_defs(moretrees.poplar_small_biome, "poplar_small", 4))
core.register_decoration(translate_biome_defs(moretrees.poplar_small_biome_2, "poplar_small", 5))

--[[
	this is purposefully wrapped in a on mods loaded callback to that it gets the proper ids
	if other mods clear the registered decorations
]]
core.register_on_mods_loaded(function()
	for k, v in pairs(deco_ids) do
		deco_ids[k] = core.get_decoration_id(v)
	end
	core.set_gen_notify("decoration", deco_ids)
end)

core.register_on_generated(function(minp, maxp, blockseed)
	local g = core.get_mapgen_object("gennotify")
	local locations = {}
	for _, id in pairs(deco_ids) do
		local deco_locations = g["decoration#" .. id] or {}
		for _, pos in pairs(deco_locations) do
			locations[#locations + 1] = pos
		end
	end

	if #locations == 0 then
		return
	end
	for _, pos in ipairs(locations) do
		local timer = core.get_node_timer(vector.offset(pos, 0, 1, 0))
		timer:start(math.random(2, 10))
	end
end)

-- Code to spawn a birch tree

function moretrees.grow_birch(pos)
	core.swap_node(pos, { name = "air" })
	if math.random(1, 2) == 1 then
		core.spawn_tree(pos, moretrees.birch_model1)
	else
		core.spawn_tree(pos, moretrees.birch_model2)
	end
end

-- Code to spawn a spruce tree

function moretrees.grow_spruce(pos)
	core.swap_node(pos, { name = "air" })
	if math.random(1, 2) == 1 then
		core.spawn_tree(pos, moretrees.spruce_model1)
	else
		core.spawn_tree(pos, moretrees.spruce_model2)
	end
end

-- Code to spawn jungle trees

moretrees.jt_axiom1 = "FFFA"
moretrees.jt_rules_a1 = "FFF[&&-FBf[&&&Ff]^^^Ff][&&+FBFf[&&&FFf]^^^Ff][&&---FBFf[&&&Ff]^^^Ff][&&+++FBFf[&&&Ff]^^^Ff]F/A"
moretrees.jt_rules_b1 = "[-Ff&f][+Ff&f]B"

moretrees.jt_axiom2 = "FFFFFA"
-- luacheck: no max line length
moretrees.jt_rules_a2 =
	"FFFFF[&&-FFFBF[&&&FFff]^^^FFf][&&+FFFBFF[&&&FFff]^^^FFf][&&---FFFBFF[&&&FFff]^^^FFf][&&+++FFFBFF[&&&FFff]^^^FFf]FF/A"
moretrees.jt_rules_b2 = "[-FFf&ff][+FFf&ff]B"

moretrees.ct_rules_a1 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
moretrees.ct_rules_b1 = "[-FBf][+FBf]"

moretrees.ct_rules_a2 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
moretrees.ct_rules_b2 = "[-fB][+fB]"

function moretrees.grow_jungletree(pos)
	local r1 = math.random(2)
	local r2 = math.random(3)
	if r1 == 1 then
		moretrees.jungletree_model.leaves2 = "moretrees:jungletree_leaves_red"
	else
		moretrees.jungletree_model.leaves2 = "moretrees:jungletree_leaves_yellow"
	end
	moretrees.jungletree_model.leaves2_chance = math.random(25, 75)

	if r2 == 1 then
		moretrees.jungletree_model.trunk_type = "single"
		moretrees.jungletree_model.iterations = 2
		moretrees.jungletree_model.axiom = moretrees.jt_axiom1
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a1
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b1
	elseif r2 == 2 then
		moretrees.jungletree_model.trunk_type = "double"
		moretrees.jungletree_model.iterations = 4
		moretrees.jungletree_model.axiom = moretrees.jt_axiom2
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a2
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b2
	elseif r2 == 3 then
		moretrees.jungletree_model.trunk_type = "crossed"
		moretrees.jungletree_model.iterations = 4
		moretrees.jungletree_model.axiom = moretrees.jt_axiom2
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a2
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b2
	end

	core.swap_node(pos, { name = "air" })
	local leaves = core.find_nodes_in_area(
		vector.offset(pos, -1, 0, -1),
		vector.offset(pos, 1, 10, 1),
		xcompat.materials.apple_leaves
	)
	for leaf in ipairs(leaves) do
		core.swap_node(leaves[leaf], { name = "air" })
	end
	core.spawn_tree(pos, moretrees.jungletree_model)
end

-- code to spawn fir trees

function moretrees.grow_fir(pos)
	if math.random(2) == 1 then
		moretrees.fir_model.leaves = "moretrees:fir_leaves"
	else
		moretrees.fir_model.leaves = "moretrees:fir_leaves_bright"
	end
	if math.random(2) == 1 then
		moretrees.fir_model.rules_a = moretrees.ct_rules_a1
		moretrees.fir_model.rules_b = moretrees.ct_rules_b1
	else
		moretrees.fir_model.rules_a = moretrees.ct_rules_a2
		moretrees.fir_model.rules_b = moretrees.ct_rules_b2
	end

	moretrees.fir_model.iterations = 7
	moretrees.fir_model.random_level = 5

	core.swap_node(pos, { name = "air" })
	local leaves = core.find_nodes_in_area(
		vector.offset(pos, 0, 0, 0),
		vector.offset(pos, 0, 5, 0),
		xcompat.materials.apple_leaves
	)
	for leaf in ipairs(leaves) do
		core.swap_node(leaves[leaf], { name = "air" })
	end
	core.spawn_tree(pos, moretrees.fir_model)
end

-- same thing, but a smaller version that grows only in snow biomes

function moretrees.grow_fir_snow(pos)
	if math.random(2) == 1 then
		moretrees.fir_model.leaves = "moretrees:fir_leaves"
	else
		moretrees.fir_model.leaves = "moretrees:fir_leaves_bright"
	end
	if math.random(2) == 1 then
		moretrees.fir_model.rules_a = moretrees.ct_rules_a1
		moretrees.fir_model.rules_b = moretrees.ct_rules_b1
	else
		moretrees.fir_model.rules_a = moretrees.ct_rules_a2
		moretrees.fir_model.rules_b = moretrees.ct_rules_b2
	end

	moretrees.fir_model.iterations = 2
	moretrees.fir_model.random_level = 2

	core.swap_node(pos, { name = "air" })
	local leaves = core.find_nodes_in_area(
		vector.offset(pos, 0, 0, 0),
		vector.offset(pos, 0, 5, 0),
		xcompat.materials.apple_leaves
	)
	for leaf in ipairs(leaves) do
		core.swap_node(leaves[leaf], { name = "air" })
	end
	core.spawn_tree(pos, moretrees.fir_model)
end

if moretrees.grow_legacy_saplings then
	core.register_lbm({
		name = "moretrees:grow_ongen_saplings",
		label = "Grow legacy ongen saplings",
		nodenames = { "group:moretrees_ongen" },
		run_at_every_load = true,
		action = function(pos)
			core.log(
				"info",
				"[moretrees] Starting growth timer for legacy ongen sapling at " .. core.pos_to_string(pos, 0)
			)
			core.get_node_timer(pos):start(math.random(2, 10))
		end,
	})
end

core.log("info", "[moretrees] Loading done")
