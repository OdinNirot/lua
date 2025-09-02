-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
	res = require('resources')

	classes.CustomDTGroups = L{}
	classes.CustomOffGroups = L{}
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Footwork = buffactive.Footwork or false
	state.Buff.Impetus = buffactive.Impetus or false
	state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Doom'] = buffactive['doom'] or false
	state.Buff['Bane'] = buffactive['bane'] or false
	state.Buff['Terror'] = buffactive['terror'] or false
	state.Buff['Stun'] = buffactive['stun'] or false
	state.Buff['Petrification'] = buffactive['petrification'] or false
	state.CursnaGear = M(false, 'CursnaGear')
	--state.Kiting = M(true)
	state.ElementalResist = M(false, 'EleResist')
	state.FootworkWS = M(true, 'Footwork on WS')

	info.impetus_hit_count = 0
	windower.raw_register_event('action', on_action_for_impetus)
	no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
	"Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

	include('Mote-TreasureHunter')
--	state.TreasureMode = M{['description']='Treasure Mode'}
--	state.TreasureMode:options('None','Tag')
--	state.TreasureMode:set('Tag')

end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.WeaponskillMode:options('Normal', 'NotAttackCapped', 'Accuracy')
	--state.HybridMode:options('Normal', 'DT')
	state.OffMode = M{['description'] = 'OffMode', 'None','SomeAccuracy','MaxAccuracy','SubtleBlow'}
	state.DTMode = M{['description'] = 'DTMode', 'None', 'DT'}

	send_command('bind ^= gs c cycle TreasureMode')
	send_command('bind ^- gs c cycle Kiting')
	send_command('bind ^backspace gs c cycle CursnaGear')
	send_command('bind numpad. gs c cycle DTMode')
	send_command('bind numpad3 gs c cycle OffMode')
	send_command('bind numpad2 gs c cycle ElementalResist')
	send_command('bind numpad6 gs c cycle WeaponskillMode')

	update_combat_form()
	update_melee_groups()

	PhalanxAbility = S{"Phalanx II"}

end

function user_unload()
	--send_command('unbind ^`')
	--send_command('unbind !-')
	send_command('unbind numpad.')
	send_command('unbind ^=')
	send_command('unbind ^-')
	send_command('unbind numpad2')
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind numpad5')
	send_command('unbind numpad6')	
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	HercHead = {}
	HercBody = {}
	HercHands = {}
	HercLegs = {}
	HercFeet = {}

	HercHead.FC = { name="Herculean Helm", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Accuracy+3','"Fast Cast"+7',}}
	HercHead.TH = { name="Herculean Helm", augments={'"Store TP"+1','"Avatar perpetuation cost" -1','"Treasure Hunter"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	HercHead.Phalanx = { name="Herculean Helm", augments={'Pet: INT+6','Weapon skill damage +1%','Phalanx +4',}}

	HercHands.TH = { name="Herculean Gloves", augments={'Accuracy+1 Attack+1','Weapon skill damage +2%','"Treasure Hunter"+2',}}
	HercHands.Waltz = { name="Herculean Gloves", augments={'Chance of successful block +1','"Waltz" potency +10%','"Store TP"+1','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	HercHands.FC = { name="Herculean Gloves", augments={'Pet: "Mag.Atk.Bns."+20','STR+7','"Fast Cast"+8','Accuracy+15 Attack+15',}}
	HercHands.WSD = { name="Herculean Gloves", augments={'MND+14','STR+10','Weapon skill damage +7%','Mag. Acc.+17 "Mag.Atk.Bns."+17',} }
	HercHands.Phalanx = { name="Herculean Gloves", augments={'Pet: "Dbl. Atk."+2','Potency of "Cure" effect received+6%','Phalanx +4','Accuracy+5 Attack+5','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}

	HercBody.Phalanx = { name="Herculean Vest", augments={'Mag. Acc.+19','Magic dmg. taken -1%','Phalanx +5',}}

	HercLegs.FC = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+18','"Fast Cast"+6','INT+10','Mag. Acc.+12',}}
	HercLegs.Phalanx = { name="Herculean Trousers", augments={'Potency of "Cure" effect received+6%','Mag. Acc.+8 "Mag.Atk.Bns."+8','Phalanx +5',}}

	HercFeet.TripleAtk = { name="Herculean Boots", augments={'Accuracy+18','"Triple Atk."+4','DEX+7',}}
	HercFeet.Waltz = { name="Herculean Boots", augments={'"Waltz" potency +10%','STR+12','Damage taken-1%','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}
	HercFeet.Phalanx = { name="Herculean Boots", augments={'Sklchn.dmg.+2%','Pet: STR+9','Phalanx +5','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}

	AdhemarHands = {}
	AdhemarHands.StrDexAtk = { name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}

	Segomo = {}
	Segomo.Normal = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

	Nyame = {head="Nyame Helm",body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	EleResist = {neck="Warder's Charm +1",waist="Engraved Belt"}
	
	-- Precast Sets

	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
	sets.precast.JA['Boost'] = {hands="Anchor. Gloves +3"}
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +3"}
	sets.precast.JA['Focus'] = {head="Anch. Crown +2"}
	sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +3"}
	sets.precast.JA['Footwork'] = {feet="Bhikku Gaiters +3"}
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas +3"}
	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +3"}

	sets.precast.JA['Chi Blast'] = {head="Hes. Crown +3"}

	sets.precast.JA['Chakra'] = {
		neck="Unmoving Collar +1",
		body="Anchorite's Cyclas +3",hands="Hesychast's Gloves +3"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		body="Passion Jacket",hands=HercHands.Waltz,Legs="Dashing Subligar",feet=HercFeet.Waltz}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- optionally apply some TH with these abilities
	sets.precast.Step = {}
	sets.precast.Flourish1 = {}


	-- Fast cast sets for spells
	sets.precast.FC = {ammo="Sapience Orb",
		head=HercHead.FC,neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Etiolation Earring",
		body="Adhemar Jacket +1",hands=HercHands.FC,ring1="Kishar Ring",ring2="Rahab Ring",
		legs=HercLegs.FC}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Coiste Bodhar",
		head="Mpaca's Cap",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Bhikku Cyclas +3",hands="Ryuo Tekko +1",ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=Segomo.Normal,waist="Moonbow Belt +1",legs="Mpaca's Hose",feet="Mpaca's Boots"}
	sets.precast.WS.NotAttackCapped = sets.precast.WS
	sets.precast.WS.Accuracy = set_combine(sets.precast.WS,{})
	--sets.precast.WSAcc = {} --{ammo="Honed Tathlum",body="Manibozho Jerkin",back="Letalis Mantle",feet="Qaaxo Leggings"}
	--sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	--sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	--sets.precast.WS.Mod = set_combine(sets.precast.WS, sets.precast.WSMod)

	-- Specific weaponskill sets.

	-- legs={name="Quiahuiz Trousers", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%','STR+8'}}}

	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
		neck="Republican Platinum Medal",ear1="Schere Earring",
		body="Nyame Mail",hands="Bhikku Gloves +3",
		legs="Nyame Flanchard",feet="Nyame Sollerets"})
	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {ammo="Crepuscular Pebble",
		neck="Monk's Nodowa +2",ear1="Moonshade Earring",ear2="Schere Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",
		legs="Nyame Flanchard",feet="Nyame Sollerets"})
	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {ammo="Coiste Bodhar",
		head="Hesychast's Crown +3",ear1="Schere Earring",ear2="Odnowa Earring +1",
		body="Nyame Mail",hands="Bhikku Gloves +3",ring1="Regal Ring",ring2="Gere Ring",
		waist="Fotia Belt",legs="Nyame Flanchard",feet="Bhikku Gaiters +3"})
	sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS,{
		head="Adhemar Bonnet +1",ear1="Odr Earring",ear2="Schere Earring",
		body="Mpaca's Doublet"})
	sets.precast.WS['Shijin Spiral']  = set_combine(sets.precast.WS, {
		ear2="Schere Earring",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",feet="Nyame Sollerets"})
	sets.precast.WS['Shijin Spiral'].NotAttackCapped = sets.precast.WS['Shijin Spiral']
	sets.precast.WS['Shijin Spiral'].Accuracy = set_combine(sets.precast.WS['Shijin Spiral'],{})
	sets.precast.WS["Spinning Attack"] = set_combine(sets.precast.WS,{ammo="Voluspa Tathlum",
		ear2="Schere Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",
		legs="Nyame Flanchard",feet="Nyame Sollerets"})
	sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS,{ammo="Crepuscular Pebble",
		ear2="Schere Earring",
		body="Nyame Mail",hands="Bhikku Gloves +3",
		waist="Fotia Belt",feet="Nyame Sollerets"})
	sets.precast.WS["Combo"] = set_combine(sets.precast.WS,{
		ear1="Moonshade Earring",ear2="Schere Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",
		legs="Nyame Flanchard",feet="Nyame Sollerets"})

	sets.precast.WS['Final Heaven'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
		head="Nyame Helm",neck="Fotia Gorget",ear1="Schere Earring",ear2="Bhikku Earring +1",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Cornelia's Ring",
		legs="Nyame Flanchard",feet="Nyame Sollerets"})

	--sets.precast.WS['Dragon Kick']     = {}
	--sets.precast.WS['Tornado Kick']    = {}
	--sets.precast.WS['Spinning Attack'] = {}
	--sets.precast.WS["Raging Fists"].Acc = {}
	--sets.precast.WS["Howling Fist"].Acc = {}
	--sets.precast.WS["Asuran Fists"].Acc = {}
	--sets.precast.WS["Ascetic's Fury"].Acc = {}
	--sets.precast.WS["Victory Smite"].Acc = {}
	--sets.precast.WS["Shijin Spiral"].Acc = {}
	--sets.precast.WS["Dragon Kick"].Acc = {}
	--sets.precast.WS["Tornado Kick"].Acc = {}

	--sets.precast.WS["Raging Fists"].Mod = {}
	--sets.precast.WS["Howling Fist"].Mod = {}
	--sets.precast.WS["Asuran Fists"].Mod = {}
	--sets.precast.WS["Ascetic's Fury"].Mod = {}
	--sets.precast.WS["Victory Smite"].Mod = {}
	--sets.precast.WS["Shijin Spiral"].Mod = {}
	--sets.precast.WS["Dragon Kick"].Mod = {}
	--sets.precast.WS["Tornado Kick"].Mod = {}


	--sets.precast.WS['Cataclysm'] = {}


	-- Midcast Sets
	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast["Absorb-TP"] = {
		head={ name="Herculean Helm", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Accuracy+3','"Fast Cast"+7',}},neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Loquac. Earring",
		body={ name="Samnuha Coat", augments={'Mag. Acc.+11','"Mag.Atk.Bns."+10','"Fast Cast"+3',}},hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},ring1="Rahab Ring",ring2="Archon Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},waist={ name="Acuity Belt +1", augments={'Path: A',}},legs="Bhikku Hose +3",feet={ name="Herculean Boots", augments={'"Fast Cast"+6','INT+4','Mag. Acc.+1','"Mag.Atk.Bns."+10',}}}

	-- Specific spells
	sets.midcast.Utsusemi = sets.precast.FC.Utsusemi


	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Odnowa Earring +1",   --neck="Elite Royal Collar"
		body="Hiza. Haramaki +2",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Chirich Ring +1",
		back=Segomo.Normal,waist="Engraved Belt",legs="Bhikku Hose +3",feet="Nyame Sollerets"}


	-- Idle sets
	sets.idle = sets.resting
	sets.idle.Town = sets.idle
	sets.idle.Weak = sets.idle
	sets.idle.DT = set_combine(sets.idle,{neck="Warder's Charm +1"})

	-- Defense sets
	--sets.defense.DT = sets.resting
	--sets.defense.HP = sets.resting

	sets.Kiting = {ring2="Shneddick Ring +1"}
	sets.Doom = {neck="Nicander's Necklace",ring1="Blenmot's Ring +1",ring2="Blenmot's Ring +1",waist="Gishdubar Sash"}
	sets.ExtraRegen = {} --{head="Ocelomeh Headpiece +1"}
	sets.TreasureHunter = {head=HercHead.TH,hands=HercHands.TH}
	sets.Phalanx = {head=HercHead.Phalanx,body=HercBody.Phalanx,hands=HercHands.Phalanx,legs=HercLegs.Phalanx,feet=HercFeet.Phalanx}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Mnk. Nodowa +2",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Mpaca's Doublet",hands=AdhemarHands.StrDexAtk,ring1="Gere Ring",ring2="Epona's Ring",
		back=Segomo.Normal,waist="Moonbow Belt +1",legs="Bhikku Hose +3",feet="Malignance Boots"}  --11 SB1 + 35 from job =46, 25 SB2 = 71 SB total

	sets.engaged.SomeAccuracy = set_combine(sets.engaged,{
		ear2="Telos Earring",
		body="Malignance Tabard",ring2="Niqmaddu Ring"})
	sets.engaged.MaxAccuracy = set_combine(sets.engaged.SomeAccuracy,{ammo="Ginsen",
		head="Bhikku Crown +3",ear1="Telos Earring",ear1="Dominance Earring +1",ear2="Bhikku Earring +1",
		hands="Ryuo Tekko +1",ring1="Cacoethic Ring +1",ring2="Moonlight Ring"})
	-- Subtle Blow and Subtle Blow II individually cap at 50% each, and cap at 75% combined.
	sets.engaged.SubtleBlow = set_combine(sets.engaged,{head="Ken. Jinpachi +1",hands="Malignance Gloves",body="Malignance Tabard",ring2="Niqmaddu Ring",feet="Ken. Sune-Ate +1"})


	sets.engaged.DT = set_combine(sets.engaged,{
		body="Malignance Tabard",hands="Malignance Gloves"})
	sets.engaged.SomeAccuracy.DT = set_combine(sets.engaged.DT,{})
	sets.engaged.MaxAccuracy.DT = set_combine(sets.engaged.SomeAccuracy.DT,{ammo="Ginsen",
		head="Bhikku Crown +3",ear1="Dominance Earring +1",ear2="Bhikku Earring +1",
		ring1="Cacoethic Ring +1",ring2="Moonlight Ring",
		feet="Tatenashi Sune-Ate +1"})
	sets.engaged.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow,{ring1="Defending Ring"})
		
	sets.engaged.Impetus = set_combine(sets.engaged,{body="Bhikku Cyclas +3"})
	sets.engaged.Impetus.DT = set_combine(sets.engaged.DT,{body="Bhikku Cyclas +3"})
	sets.engaged.Impetus.SomeAccuracy = set_combine(sets.engaged.Impetus,{ear2="Telos Earring",ring2="Niqmaddu Ring"})
	sets.engaged.Impetus.MaxAccuracy = set_combine(sets.engaged.Impetus.SomeAccuracy,{ammo="Ginsen",
		head="Bhikku Crown +3",ear1="Telos Earring",ear1="Dominance Earring +1",ear2="Bhikku Earring +1",
		hands="Ryuo Tekko +1",ring1="Cacoethic Ring +1",ring2="Moonlight Ring"})
	sets.engaged.Impetus.SubtleBlow = set_combine(sets.engaged.SubtleBlow,{body="Bhikku Cyclas +3"})
	sets.engaged.Impetus.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow,{ring1="Defending Ring"})
	sets.engaged.Impetus.SomeAccuracy.DT = set_combine(sets.engaged.Impetus.SomeAccuracy,{feet="Bhikku Gaiters +3"})
	sets.engaged.Impetus.MaxAccuracy.DT = set_combine(sets.engaged.Impetus.SomeAccuracy.DT,{ammo="Ginsen",head="Bhikku Crown +3",ear1="Telos Earring"})

-- base Subtle Blow set:
--	sets.engaged = {ammo="Coiste Bodhar",
--		head="Bhikku Crown +3",neck="Mnk. Nodowa +2",ear1="Sherida Earring",ear2="Schere Earring",
--		body="Mpaca's Doublet",hands="Hes. Gloves +3",ring1="Gere Ring",ring2="Chirich Ring +1",
--		back=Segomo.Normal,waist="Moonbow Belt +1",legs="Bhikku Hose +3",feet="Malignance Boots"}


	-- Hundred Fists/Impetus melee set mods
	sets.engaged.HF = set_combine(sets.engaged,{})
	sets.engaged.HF.SomeAccuracy = set_combine(sets.engaged.SomeAccuracy,{})
	sets.engaged.HF.MaxAccuracy = set_combine(sets.engaged.HF.SomeAccuracy,{ammo="Ginsen",head="Bhikku Crown +3",ear1="Telos Earring",body="Malignance Tabard",hands="Ryuo Tekko +1",waist="Grunfeld Rope"})
	sets.engaged.HF.SubtleBlow = set_combine(sets.engaged.HF,{head="Bhikku Crown +3"})
	sets.engaged.HF.DT = set_combine(sets.engaged.DT,{})

	sets.engaged.HF.Impetus = set_combine(sets.engaged.HF,{body="Bhikku Cyclas +3"})
	sets.engaged.HF.Impetus.SomeAccuracy = set_combine(sets.engaged.HF.SomeAccuracy, {body="Bhikku Cyclas +3"})
	sets.engaged.HF.Impetus.MaxAccuracy = set_combine(sets.engaged.HF.Impetus.SomeAccuracy, {ammo="Ginsen",head="Bhikku Crown +3",ear1="Telos Earring"})
	sets.engaged.HF.Impetus.SubtleBlow = set_combine(sets.engaged.HF.Impetus,{head="Bhikku Crown +3"})
	sets.engaged.HF.Impetus.DT = set_combine(sets.engaged.Impetus.DT,{})


	-- Footwork combat form
	sets.engaged.Footwork = set_combine(sets.engaged,{feet="Anch. Gaiters +3"})
	sets.engaged.Footwork.Acc = sets.engaged.Footwork

	-- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
	sets.impetus_body = {body="Bhikku Cyclas +3"}
	sets.footwork_kick_feet = {feet="Anch. Gaiters +3"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Don't gearswap for weaponskills when Defense or SubtleBlow is on.
	if spell.type == 'WeaponSkill' and (state.DTMode.current ~= 'None' or state.OffMode.value == 'SubtleBlow') then
		eventArgs.handled = true
	end
end

function do_equip(setname)
	send_command('gs equip '..setname..'')
end

function check_reaction(act)

	--Gather Info
	local curact = T(act)
	local actor = T{}
	local otherTarget = T{}

	actor.id = curact.actor_id

	if not ((curact.category == 8) or curact.category == 4) then return end
	-- Make sure it's a mob that's doing something.
	if windower.ffxi.get_mob_by_id(actor.id) then
		actor = windower.ffxi.get_mob_by_id(actor.id)
	else
		return
	end

	-- Check if we're targeting it.
	if player and player.target and player.target.id and actor.id == player.target.id then
		isTarget = true
	else
		isTarget = false
	end

	if curact.targets[1].id == nil then
		targetsMe = false
		targetsSelf = false
		otherTarget.in_party = false
		otherTarget.in_alliance = false
		targetsDistance = 50
	elseif curact.targets[1].id == player.id then
		otherTarget.in_party = false
		otherTarget.in_alliance = false
		targetsMe = true
		targetsSelf = false
		targetsDistance = 0
	elseif curact.targets[1].id == actor.id	then
		if windower.ffxi.get_mob_by_id(curact.targets[1].id) then
			otherTarget = windower.ffxi.get_mob_by_id(curact.targets[1].id)
		else
			otherTarget.in_party = false
			otherTarget.in_alliance = false
			otherTarget.distance = 10000
		end
		targetsMe = false
		targetsSelf = true
		targetsDistance = math.sqrt(otherTarget.distance)
	else
		if windower.ffxi.get_mob_by_id(curact.targets[1].id) then
			otherTarget = windower.ffxi.get_mob_by_id(curact.targets[1].id)
		else
			otherTarget.in_party = false
			otherTarget.in_alliance = false
			otherTarget.distance = 10000
		end
		targetsSelf = false
		targetsMe = false
		targetsDistance = math.sqrt(otherTarget.distance)
	end

	-- Make sure it's not US from this point on!
	if actor.id == player.id then return end
	-- Make sure it's a WS or MA precast before reacting to it.		
	if not (curact.category == 7 or curact.category == 8) then return end

	-- Get the name of the action.
	if curact.category == 8 then act_info = res.spells[curact.targets[1].actions[1].param] end
	if act_info == nil then return end

	if targetsMe then
		if PhalanxAbility:contains(act_info.name) then
			do_equip('sets.Phalanx')
			windower.send_command('wait 2.5;gs c update user')
		end
		
--	elseif actor.in_party and otherTarget.in_party and targetsDistance < 10 then
--
--		if CuragaAbility:contains(act_info.name) and player.hpp < 75 then
--			if sets.Cure_Received then
--				do_equip('sets.Cure_Received')
--			elseif sets.Self_Healing then
--				do_equip('sets.Self_Healing') 
--			end
--			return
--		elseif ProshellraAbility:contains(act_info.name) and sets.Sheltered then
--			do_equip('sets.Sheltered') return
--		end
	end
end

function check_gear()
	if no_swap_gear:contains(player.equipment.ring1) then
		disable("ring1")
	else
		enable("ring1")
	end
	if no_swap_gear:contains(player.equipment.ring2) then
		disable("ring2")
	else
		enable("ring2")
	end
	if no_swap_gear:contains(player.equipment.waist) then
		disable("waist")
	else
		enable("waist")
	end
end

windower.raw_register_event('action', check_reaction)

windower.register_event('zone change',
	function()
		if no_swap_gear:contains(player.equipment.ring1) then
			enable("ring1")
			equip(sets.idle)
		end
		if no_swap_gear:contains(player.equipment.ring2) then
			enable("ring2")
			equip(sets.idle)
		end
		if no_swap_gear:contains(player.equipment.waist) then
			enable("waist")
			equip(sets.idle)
		end
	end
)

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' and state.DTMode.current ~= 'None' then
		if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
			-- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
			if (info.impetus_hit_count > 5) then
				equip(sets.impetus_body)
			end
		elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
			equip(sets.footwork_kick_feet)
		end

		-- Replace Moonshade Earring if we're at cap TP
		if player.tp == 3000 then
			equip(sets.precast.MaxTP)
		end
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
	end
end


function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
		send_command('cancel Footwork')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	-- Set Footwork as combat form any time it's active and Hundred Fists is not.
	if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
		state.CombatForm:set('Footwork')
	elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
		state.CombatForm:set('Footwork')
	else
		state.CombatForm:reset()
	end

	-- Hundred Fists and Impetus modify the custom melee groups
	if buff == "Hundred Fists" or buff == "Impetus" then
		classes.CustomMeleeGroups:clear()

		if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
			classes.CustomMeleeGroups:append('HF')
		end

		if (buff == "Impetus" and gain) or buffactive.impetus then
			classes.CustomMeleeGroups:append('Impetus')
		end
	end

	-- Update gear if any of the above changed
	if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
		handle_equipping_gear(player.status)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if player.hpp < 70 then
		idleSet = set_combine(idleSet, sets.ExtraRegen)
	end
	if state.DTMode.value == 'DT' then
		idleSet = set_combine(idleSet,sets.idle.DT)
	end
	if state.ElementalResist.value == true then
		idleSet = set_combine(idleSet,EleResist)
	end
	if state.CursnaGear.value and (buffactive['Doom'] or buffactive['Bane']) then
		idleSet = set_combine(idleSet,sets.Doom)
	end
	if state.Kiting.value then
		if sets.Kiting then
			idleSet = set_combine(idleSet, sets.Kiting)
		end
	end
	return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	update_combat_form()
	update_melee_groups()
end

--function th_action_check(category, param)
--	if category == 2 or -- any ranged attack
--		--category == 4 or -- any magic action
--		(category == 3 and param == 30) or -- Aeolian Edge
--		(category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
--		(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
--		then return true
--	end
--end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
	if buffactive.footwork and not buffactive['hundred fists'] then
		state.CombatForm:set('Footwork')
	else
		state.CombatForm:reset()
	end
end

function update_melee_groups()
	classes.CustomMeleeGroups:clear()

	if buffactive['hundred fists'] then
		classes.CustomMeleeGroups:append('HF')
	end

	if buffactive.impetus then
		classes.CustomMeleeGroups:append('Impetus')
	end
	
--	if state.ElementalResist.value == true then
--		classes.CustomMeleeGroups:append('EleResist')
--	end
	
end

function customize_melee_set(meleeSet)
--	if state.TreasureMode.value ~= 'None' then
--		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
--	end

--	if state.DTMode.value == 'DT' then
--		meleeSet = set_combine(meleeSet,sets.engaged.DT)
--	end


	classes.CustomDTGroups:clear()
	classes.CustomOffGroups:clear()

	if state.OffMode.value == 'SomeAccuracy' then
		classes.CustomOffGroups:append('SomeAccuracy')
	elseif state.OffMode.value == 'MaxAccuracy' then
		classes.CustomOffGroups:append('MaxAccuracy')
	elseif state.OffMode.value == 'SubtleBlow' then
		classes.CustomOffGroups:append('SubtleBlow')
	else
		classes.CustomOffGroups:clear()
	end

	for _,group in ipairs(classes.CustomOffGroups) do
		if meleeSet[group] then
			meleeSet = meleeSet[group]
			mote_vars.set_breadcrumbs:append(group)
		end
	end

	if state.DTMode.value == 'DT' then
		classes.CustomDTGroups:append('DT')
	else
		classes.CustomDTGroups:clear()
	end

	for _,group in ipairs(classes.CustomDTGroups) do
		if meleeSet[group] then
			meleeSet = meleeSet[group]
			mote_vars.set_breadcrumbs:append(group)
		end
	end

	--useful for outputting a table array as a string
	--	local s = {"return "}
	--	for i=1,#classes.CustomDTGroups do
	--		s[#s+1] = "{"
	--		for j=1,#classes.CustomDTGroups[i] do
	--			s[#s+1] = classes.CustomDTGroups[i][j]
	--			s[#s+1] = ""
	--		end
	--		s[#s+1] = ""
	--	end
	--	s[#s+1] = "}"
	--	s = table.concat(s)	

	if state.ElementalResist.value == true and state.DTMode.value == 'DT' then
		meleeSet = set_combine(meleeSet,EleResist,{head="Bhikku Crown +3"})
	elseif state.ElementalResist.value == true then
		meleeSet = set_combine(meleeSet,EleResist)
	end

	if state.CursnaGear.value and (buffactive['Doom'] or buffactive['Bane']) then
		meleeSet = set_combine(meleeSet,sets.Doom)
	end

	--add_to_chat(8,s)
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
	if state.Buff.Impetus then
		-- count melee hits by player
		if action.actor_id == player.id then
			if action.category == 1 then
				for _,target in pairs(action.targets) do
					for _,action in pairs(target.actions) do
						-- Reactions (bitset):
						-- 1 = evade
						-- 2 = parry
						-- 4 = block/guard
						-- 8 = hit
						-- 16 = JA/weaponskill?
						-- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
						if (action.reaction % 4) > 0 then
							info.impetus_hit_count = 0
						else
							info.impetus_hit_count = info.impetus_hit_count + 1
						end
					end
				end
			elseif action.category == 3 then
				-- Missed weaponskill hits will reset the counter.  Can we tell?
				-- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
				-- Can't tell if any hits were missed, so have to assume all hit.
				-- Increment by the minimum number of weaponskill hits: 2.
				for _,target in pairs(action.targets) do
					for _,action in pairs(target.actions) do
						-- This will only be if the entire weaponskill missed or was parried.
						if (action.reaction % 4) > 0 then
							info.impetus_hit_count = 0
						else
							info.impetus_hit_count = info.impetus_hit_count + 2
						end
					end
				end
			end
		elseif action.actor_id ~= player.id and action.category == 1 then
			-- If mob hits the player, check for counters.
			for _,target in pairs(action.targets) do
				if target.id == player.id then
					for _,action in pairs(target.actions) do
						-- Spike effect animation:
						-- 63 = counter
						-- ?? = missed counter
						if action.has_spike_effect then
							-- spike_effect_message of 592 == missed counter
							if action.spike_effect_message == 592 then
								info.impetus_hit_count = 0
							elseif action.spike_effect_animation == 63 then
								info.impetus_hit_count = info.impetus_hit_count + 1
							end
						end
					end
				end
			end
		end

		--add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
	else
		info.impetus_hit_count = 0
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	if state.OffMode.has_value then
		om_msg = state.OffMode.value
	else
		om_msg = 'Normal'
	end
	if state.DTMode.has_value then
		dt_msg = state.DTMode.value
	else
		dt_msg = 'Off'
	end
	if state.WeaponskillMode.has_value then
		wm_msg = state.WeaponskillMode.value
	else
		wm_msg = 'Normal'
	end
--	if state.HybridMode.has_value then
--		hm_msg = state.HybridMode.value
--	end
	if state.TreasureMode.has_value then
		tm_msg = state.TreasureMode.value
	else
		tm_msg = 'Off'
	end
	if state.ElementalResist.value then
		er_msg = 'On'
	else
		er_msg = 'Off'
	end

	local msg = ''
	if state.Kiting.value then
		msg = msg .. ' Kiting: On'
	else 
		msg = msg .. ' Kiting: Off'
	end

	add_to_chat(string.char(31,210).. 'OffenseMode: ' ..string.char(31,001)..om_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' WeaponskillMode: ' ..string.char(31,001)..wm_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' DTMode: ' ..string.char(31,001)..dt_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' ElementalResist: ' ..string.char(31,001)..er_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' TreasureMode: ' ..string.char(31,001)..tm_msg.. string.char(31,002)..  ' |'
		..string.char(31,002)..msg)

	eventArgs.handled = true
	
end

-- Select default macro book on initial load or subjob change.
function set_macros(sheet,book)
	if book then 
		send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
		return
	end
	send_command('@input /macro set '..tostring(sheet))
end

--Page, Book--
--if player.sub_job == 'BLU' then
--	set_macros(5,2)
--else
	set_macros(5,2)
--end


function set_style(sheet)
	send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(28)