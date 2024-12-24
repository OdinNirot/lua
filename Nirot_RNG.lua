-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- Haste II has the same buff ID [33], so we have to use a toggle. 
-- gs c toggle hastemode -- Toggles whether or not you're getting Haste II
-- for Rune Fencer sub, you need to create two macros. One cycles runes, and gives you descrptive text in the log.
-- The other macro will use the actual rune you cycled to. 
-- Macro #1 //console gs c cycle Runes
-- Macro #2 //console gs c toggle UseRune


--[[
	Custom commands:

	gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.

	Treasure hunter modes:
		None - Will never equip TH gear
		Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
		SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
		Fulltime - Will keep TH gear equipped fulltime

--]]


--[[
		MY NOTES

		gs equip sets.precast.JA[\"Trick Attack\"]
		gs equip sets.precast.WS[\"Rudra's Storm\"]
		gs equip sets.engaged
		gs enable/disable back
		gs debugmode
		gs showswaps
		gs validate
		gs c cycle treasuremode
		gs c cycle hybridmode





--]]

function get_sets()
	mote_include_version = 2
	include('Mote-Include.lua')
	include('organizer-lib')
	res = require('resources')
end

-- Setup vars that are user-independent.
function job_setup()

	state.IgnoreTargetting = M(false, 'Ignore Targetting')
	
	state.Kiting = M(true, 'Kiting')
	state.HasteMode = M{['description']='Haste Mode', 'Hi', 'Normal'}
	state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Doom'] = buffactive['doom'] or false
	state.Buff['Bane'] = buffactive['bane'] or false
	state.Buff['Terror'] = buffactive['terror'] or false
	state.Buff['Stun'] = buffactive['stun'] or false
	state.Buff['Petrification'] = buffactive['petrification'] or false
	
	state.Buff["Barrage"] = buffactive["Barrage"] or false
	state.Buff["Decoy Shot"] = buffactive["Decoy Shot"] or false
	state.Buff["Double Shot"] = buffactive["Double Shot"] or false
	state.Buff["Eagle Eye Shot"] = buffactive["Eagle Eye Shot"] or false
	state.Buff["Flashy Shot"] = buffactive["Flashy Shot"] or false
	state.Buff["Hover Shot"] = buffactive["Hover Shot"] or false
	state.Buff["Sharpshot"] = buffactive["Sharpshot"] or false
	state.Buff["Stealth Shot"] = buffactive["Stealth Shot"] or false
	state.Buff["Unlimited Shot"] = buffactive["Unlimited Shot"] or false
	state.Buff["Velocity Shot"] = buffactive["Velocity Shot"] or false
	
	-- /run sj
	state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
	state.UseRune = M(false, 'Use Rune')
	run_sj = player.sub_job == 'RUN' or false

	no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
		"Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
		"Dev. Bul. Pouch", "Chr. Bul. Pouch", "Liv. Bul. Pouch","Era. Bul. Pouch", "Quelling B. Quiver"}
	crossbowList = S{'Gastraphetes'}
	gunList = S{'Fomalhaut','Ataktos','Armageddon','Annihilator'}
	bowList = S{'Ullr','Yoichinoyumi'}
	elemental_ws = S{"Aeolian Edge", "Wildfire","Trueflight", "Hot Shot"}
	no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet", "Hauksbok Arrow"}

	-- Whether a warning has been given for low ammo
	state.warned = M(false)
	options.ammo_warning_limit = 25
	
	include('Mote-TreasureHunter')
	-- For th_action_check():
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}

end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'MidAcc', 'MaxAcc')
	state.HybridMode:options('Normal', 'PDT')
	--state.IdleMode:options('Normal', 'PDT')
	
	
	--state.RangeMode:options('Gun','Crossbow','Bow')
	--state.RangeMode = M{['description'] = 'Ranged Mode','Gun','Crossbow','Bow'}
	state.RangedMode:options('Normal','Critical')
	state.WeaponskillMode:options('Normal','MidAcc','MaxAcc','PDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	
	Haste = 0
	DW_needed = 0
	DW = false
	moving = false
	update_combat_form()
	--determine_haste_group()

	gear.RAbullet = "Chrono Bullet"
	gear.RAccbullet = "Devastating Bullet"
	gear.WSbullet = "Eradicating Bullet"
	gear.MAbullet = "Devastating Bullet"
	gear.Arrow = "Chrono Arrow"
	gear.Bolt = "Quelling Bolt"
	options.ammo_warning_limit = 10

	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind ^- gs c cycle Kiting')
	--send_command('bind ^[ gs c toggle UseWarp')
	--send_command('bind ![ input /lockstyle off')
	--send_command('bind != gs c toggle CapacityMode')
	send_command('bind @f9 gs c cycle HasteMode')
	send_command('bind numpad. gs c cycle HybridMode')
	send_command('bind numpad6 gs c cycle RangedMode')
	send_command('bind numpad3 gs c cycle OffenseMode')

	send_command('gs enable ammo')
	
	PhalanxAbility = S{"Phalanx II"}
	
end


function file_unload()
	--send_command('unbind ^[')
	--send_command('unbind ![')
	send_command('unbind ^=')
	send_command('unbind ^-')
	--send_command('unbind !=')
	send_command('unbind @f9')
	send_command('unbind numpad.')
	--send_command('unbind @[')
	send_command('unbind ^0')	
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind numpad5')
	send_command('unbind numpad6')	
	send_command('unbind numpad7')	
	
end


-- Define sets and vars used by this job file.
-- visualized at http://www.ffxiah.com/node/194 (not currently up to date 10/29/2015)
-- Happo
-- Hachiya
-- sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.HybridMode][classes.CustomMeleeGroups (any number)

-- Ninjutsu tips
-- To stick Slow (Hojo) lower earth resist with Raiton: Ni
-- To stick poison (Dokumori) or Attack down (Aisha) lower resist with Katon: Ni
-- To stick paralyze (Jubaku) lower resistence with Huton: Ni

function init_gear_sets()
	--------------------------------------
	-- Augments
	--------------------------------------

	AdhemarHead = {}
	HercFeet = {}
	HercHead = {}
	HercLegs = {}
	HercBody = {}
	HercHands = {}

	AdhemarHead.DexAgiAtk = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}

	HercHead.TH = { name="Herculean Helm", augments={'"Store TP"+1','"Avatar perpetuation cost" -1','"Treasure Hunter"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	HercHead.Phalanx = { name="Herculean Helm", augments={'Pet: INT+6','Weapon skill damage +1%','Phalanx +4',}}
	HercHead.FC = { name="Herculean Helm", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Accuracy+3','"Fast Cast"+7',}}
	HercBody.Phalanx = { name="Herculean Vest", augments={'Mag. Acc.+19','Magic dmg. taken -1%','Phalanx +5',}}
	HercHands.Waltz = { name="Herculean Gloves", augments={'Chance of successful block +1','"Waltz" potency +10%','"Store TP"+1','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	HercHands.Phalanx = { name="Herculean Gloves", augments={'Pet: "Dbl. Atk."+2','Potency of "Cure" effect received+6%','Phalanx +4','Accuracy+5 Attack+5','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	HercHands.TH = { name="Herculean Gloves", augments={'Accuracy+1 Attack+1','Weapon skill damage +2%','"Treasure Hunter"+2',}}
	HercHands.FC = { name="Herculean Gloves", augments={'Pet: "Mag.Atk.Bns."+20','STR+7','"Fast Cast"+8','Accuracy+15 Attack+15',}}
	HercLegs.Phalanx = { name="Herculean Trousers", augments={'Mag. Acc.+15','Phalanx +4','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
	HercLegs.FC = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+18','"Fast Cast"+6','INT+10','Mag. Acc.+12',}}
	HercFeet.FC = {name="Herculean Boots", augments={'"Fast Cast"+6','INT+4','Mag. Acc.+1','"Mag.Atk.Bns."+10',}}
	HercFeet.Waltz = { name="Herculean Boots", augments={'"Waltz" potency +10%','STR+12','Damage taken-1%','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}
	HercFeet.Phalanx = { name="Herculean Boots", augments={'Weapon skill damage +3%','"Fast Cast"+1','Phalanx +4','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
	HercFeet.TripleAtk = { name="Herculean Boots", augments={'Accuracy+18','"Triple Atk."+4','DEX+7',}}

	TaeonHead = {}
	TaeonHead.SIRD = { name="Taeon Chapeau", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Spell interruption rate down -10%','STR+6 VIT+6',}}
	Nyame = {head="Nyame Helm",body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	Ikenga =  {head="Ikenga's Hat",body="Ikenga's Vest",hands="Ikenga's Gloves",legs="Ikenga's Trousers",feet="Ikenga's Clogs"}

	Belenus = {}
	Belenus.WSD_AGI = { name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	Belenus.DexCrit = Belenus.WSD_AGI

	-- Precast sets to enhance JAs
	sets.precast.JA['Barrage'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Bounty Shot'] = {hands="Amini Glovelettes +3"}
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Double Shot'] = {head="Amini Gapette +3",body="Arcadian Jerkin +1",hands="Oshosi Gloves +1",legs="Oshosi Trousers +1",feet="Oshosi Leggings +1"}
	sets.precast.JA['Eagle Eye Shot'] = {legs="Arcadian Braccae +1"}
	sets.precast.JA['Flashy Shot'] = {hands="Arcadian Bracers +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}  --dont think these have to stay equipped
	sets.precast.JA['Stealth Shot'] = {feet="Arcadian Socks +1"}  --dont think these have to stay equipped
	sets.precast.JA['Unlimited Shot'] = {feet="Amini Bottillons +3"}
	sets.precast.JA['Velocity Shot'] = {body="Amini Caban +3",back="Belenus's Cape"}
	

	sets.idle = {
		head="Amini Gapette +3",neck="Elite Royal Collar",ear1="Sanare Earring",ear2="Odnowa Earring +1",
		body="Nyame Mail",hands="Amini Glovelettes +3",ring1="Chirich Ring +1",ring2="Defending Ring",
		back="Moonbeam Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.idle.PDT = set_combine(sets.idle, {neck="Loricate Torque +1",ring1="Gelatinous Ring +1"})
	sets.idle.Normal = sets.idle
	sets.idle.Regen = set_combine(sets.idle, {})
	sets.resting = sets.idle
	sets.Phalanx = {head=HercHead.Phalanx,body=HercBody.Phalanx,hands=HercHands.Phalanx,legs=HercLegs.Phalanx,feet=HercFeet.Phalanx,ear2="Odnowa Earring +1",ring1="Gelatinous Ring +1",ring2="Defending Ring"}

	-- Precast sets to enhance JAs

	sets.precast.Waltz = {
		body="Passion Jacket",hands=HercHands.Waltz,ring2="Defending Ring",
		waist="Flume Belt +1",legs="Dashing Subligar",Feet=HercFeet.Waltz}
	sets.precast.Waltz['Healing Waltz'] = {}
	sets.precast.Step = {}

	sets.buff.Doom = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar Sash"}
	sets.buff.Curse = sets.buff.Doom

	sets.TreasureHunter = {head=HercHead.TH,hands=HercHands.TH}

	sets.precast.FC = {
		head=HercHead.FC,neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Etiolation Earring",
		body={ name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}},hands=HercHands.FC,ring1="Rahab Ring",ring2="Defending Ring",
		legs=HercLegs.FC,feet=HercFeet.FC}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,{neck="Magoraga Beads",body="Passion Jacket"})

	sets.precast.RA = {--ammo=gear.RAbullet,
		head="Amini Gapette +3",neck="Scout's Gorget +2",
		body="Amini Caban +3",hands="Carmine Fin. Ga. +1",ring1="Chirich Ring +1",ring2="Crepuscular Ring",
		waist="Yemaya Belt",legs="Orion Braccae +1",feet="Meghanada Jambeaux +2"}
	sets.precast.RA.Flurry1 = set_combine(sets.precast.RA,{head="Orion Beret +1",legs="Adhemar Kecks +1"})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1,{feet="Arcadian Socks +1"})

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {--ammo=gear.RAbullet,
		head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Amini Earring +1",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Cornelia's Ring",ring2="Epaminondas's Ring",
		back=Belenus.WSD_AGI,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	--Dagger--
	----avg dmg 21545
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head=AdhemarHead.DexAgiAtk,ear1="Odr Earring",
		body="Meghanada Cuirie +2",hands="Mummu Wrists +2",ring1="Mummu Ring",ring2="Defending Ring",
		back=Belenus.DexCrit,legs="Amini Bragues +3",feet="Oshosi Leggings +1"})
	sets.precast.WS['Evisceration'].PDT = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].UncappedAtk = set_combine(sets.precast.WS['Evisceration'].Mod, {})

	----avg dmg 17762
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		head=empty,neck="Sibyl Scarf",ear1="Crematio Earring",ear2="Friomisi Earring",
		body="Cohort Cloak +1",ring2="Defending Ring",
		back=Belenus.WSD_AGI,waist="Orpheus's Sash"})
	sets.precast.WS['Aeolian Edge'].PDT = set_combine(sets.precast.WS['Aeolian Edge'], {})
	sets.precast.WS['Aeolian Edge'].Acc = set_combine(sets.precast.WS['Aeolian Edge'], {})
	sets.precast.WS['Aeolian Edge'].Mod = set_combine(sets.precast.WS['Aeolian Edge'], {})
	sets.precast.WS['Aeolian Edge'].UncappedAtk = set_combine(sets.precast.WS['Aeolian Edge'], {})
	
	--Sword--
	----avg dmg 53134 (Naegling, Gleti's Knife)
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		neck="Republican Platinum Medal",ear1="Ishvara Earring",ear2="Sherida Earring",
		ring2="Sroda Ring",
		waist="Sailfi Belt +1",feet="Amini Bottillons +3"})
	sets.precast.WS['Savage Blade'].PDT = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].Mod = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].UncappedAtk = set_combine(sets.precast.WS['Savage Blade'].Mod, {})

	--Marksmanship--
	----avg dmg 59566 (Perfervid Sword/Malevolence, Fomalhaut, Hauksbok)
	sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Bullet,
		ear2="Friomisi Earring"})
	sets.precast.WS['Hot Shot'].PDT = set_combine(sets.precast.WS['Hot Shot'], {})
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Hot Shot'], {})
	sets.precast.WS['Hot Shot'].Mod = set_combine(sets.precast.WS['Hot Shot'], {})
	sets.precast.WS['Hot Shot'].UncappedAtk = set_combine(sets.precast.WS['Hot Shot'].Mod, {})

	----avg dmg 6470 (Ternion/Crepuscular, Armageddon, Chrono)
	sets.precast.WS['Split Shot'] = set_combine(sets.precast.WS, {ammo="Chrono Bullet",
		head="Orion Beret +1",neck="Scout's Gorget +2",ear1="Ishvara Earring",
		hands="Meghanada Gloves +2",ring2="Defending Ring",
		back=Belenus.WSD_AGI,feet="Amini Bottillons +3"})
	sets.precast.WS['Split Shot'].PDT = set_combine(sets.precast.WS['Split Shot'], {})
	sets.precast.WS['Split Shot'].Acc = set_combine(sets.precast.WS['Split Shot'], {})
	sets.precast.WS['Split Shot'].Mod = set_combine(sets.precast.WS['Split Shot'], {})
	sets.precast.WS['Split Shot'].UncappedAtk = set_combine(sets.precast.WS['Split Shot'].Mod, {})
	
	----avg dmg 5101 (Oneiros/Ternion, Armageddon, Hauksbok)
	sets.precast.WS['Sniper Shot'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Bullet,
		head="Orion Beret +1",ear1="Odr Earring",ear2="Odnowa Earring +1",
		ring2="Regal Ring",
		back=Belenus.WSD_AGI,legs="Amini Bragues +3",feet="Amini Bottillons +3"})
	sets.precast.WS['Sniper Shot'].PDT = set_combine(sets.precast.WS['Sniper Shot'], {})
	sets.precast.WS['Sniper Shot'].Acc = set_combine(sets.precast.WS['Sniper Shot'], {})
	sets.precast.WS['Sniper Shot'].Mod = set_combine(sets.precast.WS['Sniper Shot'], {})
	sets.precast.WS['Sniper Shot'].UncappedAtk = set_combine(sets.precast.WS['Sniper Shot'].Mod, {})

	----avg dmg 19727 (Ternion/Perun, Armageddon, Hauksbok)
	sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Bullet,
		head="Orion Beret +1",neck="Republican Platinum Medal",ear1="Ishvara Earring",ear2="Sherida Earring",
		hands="Meghanada Gloves +2",ring2="Defending Ring",
		back=Belenus.WSD_AGI,feet="Amini Bottillons +3"})
	sets.precast.WS['Slug Shot'].PDT = set_combine(sets.precast.WS['Slug Shot'], {})
	sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS['Slug Shot'], {})
	sets.precast.WS['Slug Shot'].Mod = set_combine(sets.precast.WS['Slug Shot'], {})
	sets.precast.WS['Slug Shot'].UncappedAtk = set_combine(sets.precast.WS['Slug Shot'].Mod, {})

	----avg dmg 8313 (Ternion/Perun, Armageddon, Hauksbok)
	sets.precast.WS['Blast Shot'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Bullet,
		ear1="Ishvara Earring",ear2="Sherida Earring",
		back=Belenus.WSD_AGI,feet="Amini Bottillons +3"})
	sets.precast.WS['Blast Shot'].PDT = set_combine(sets.precast.WS['Blast Shot'], {})
	sets.precast.WS['Blast Shot'].Acc = set_combine(sets.precast.WS['Blast Shot'], {})
	sets.precast.WS['Blast Shot'].Mod = set_combine(sets.precast.WS['Blast Shot'], {})
	sets.precast.WS['Blast Shot'].UncappedAtk = set_combine(sets.precast.WS['Blast Shot'].Mod, {})

	----avg dmg 26862 (Ternion/Crepuscular, Fomalhaut, Hauksbok)
	sets.precast.WS['Detonator'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Bullet,
		neck="Scout's Gorget +2",
		body="Ikenga's Vest",ring2="Defending Ring",
		back=Belenus.WSD_AGI,feet="Amini Bottillons +3"})
	sets.precast.WS['Detonator'].PDT = set_combine(sets.precast.WS['Detonator'], {})
	sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS['Detonator'], {})
	sets.precast.WS['Detonator'].Mod = set_combine(sets.precast.WS['Detonator'], {})
	sets.precast.WS['Detonator'].UncappedAtk = set_combine(sets.precast.WS['Detonator'].Mod, {})

	----avg dmg 19380 (Ternion/Perun, Annihilator, Chrono)
	sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, {ammo="Chrono Bullet",
		ear1="Ishvara Earring",ear2="Sherida Earring",
		ring2="Regal Ring",
		back=Belenus.WSD_AGI,feet="Amini Bottillons +3"})
	sets.precast.WS['Coronach'].PDT = set_combine(sets.precast.WS['Coronach'], {})
	sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS['Coronach'], {})
	sets.precast.WS['Coronach'].Mod = set_combine(sets.precast.WS['Coronach'], {})
	sets.precast.WS['Coronach'].UncappedAtk = set_combine(sets.precast.WS['Coronach'].Mod, {})

	----avg dmg 50929 (Malevolence x2, Gastraphetes, Quelling Bolt)
	sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS, {ammo="Quelling Bolt",
		neck="Scout's Gorget +2",ear2="Friomisi Earring",
		ring2="Dingir Ring",
		back=Belenus.WSD_AGI,waist="Orpheus's Sash"})
	sets.precast.WS['Trueflight'].PDT = set_combine(sets.precast.WS['Trueflight'], {})
	sets.precast.WS['Trueflight'].Acc = set_combine(sets.precast.WS['Trueflight'], {})
	sets.precast.WS['Trueflight'].Mod = set_combine(sets.precast.WS['Trueflight'], {})
	sets.precast.WS['Trueflight'].UncappedAtk = set_combine(sets.precast.WS['Trueflight'].Mod, {})

	----avg dmg 27786 (Malevolence x2, Armageddon, Hauksbok)
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Bullet,
		neck="Scout's Gorget +2",ear1="Crematio Earring",ear2="Friomisi Earring",
		ring2="Dingir Ring",
		back=Belenus.WSD_AGI,waist="Orpheus's Sash"})
	sets.precast.WS['Wildfire'].PDT = set_combine(sets.precast.WS['Wildfire'], {})
	sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {})
	sets.precast.WS['Wildfire'].Mod = set_combine(sets.precast.WS['Wildfire'], {})
	sets.precast.WS['Wildfire'].UncappedAtk = set_combine(sets.precast.WS['Wildfire'].Mod, {})
	
	----avg dmg 26848 (Ternion/Perun, Fomalhaut, Hauksbok)
	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Bullet,
		head="Amini Gapette +3",neck="Scout's Gorget +2",ear2="Ishvara Earring",
		body="Ikenga's Vest",hands="Amini Glovelettes +3",ring2="Regal Ring",
		back=Belenus.WSD_AGI,feet="Amini Bottillons +3"})
	sets.precast.WS['Last Stand'].PDT = set_combine(sets.precast.WS['Last Stand'], {})
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})
	sets.precast.WS['Last Stand'].Mod = set_combine(sets.precast.WS['Last Stand'], {})
	sets.precast.WS['Last Stand'].UncappedAtk = set_combine(sets.precast.WS['Last Stand'].Mod, {})

	----avg dmg 28583 (Ternion/Perun, Earp, Bayeux)
	sets.precast.WS['Terminus'] = set_combine(sets.precast.WS, {--ammo=Bayeux Bullet,
		head="Orion Beret +1",neck="Loricate Torque +1",ear2="Ishvara Earring",
		body="Ikenga's Vest",ring2="Defending Ring",
		back=Belenus.WSD_AGI,feet="Amini Bottillons +3"})
	sets.precast.WS['Terminus'].PDT = set_combine(sets.precast.WS['Terminus'], {})
	sets.precast.WS['Terminus'].Acc = set_combine(sets.precast.WS['Terminus'], {})
	sets.precast.WS['Terminus'].Mod = set_combine(sets.precast.WS['Terminus'], {})
	sets.precast.WS['Terminus'].UncappedAtk = set_combine(sets.precast.WS['Terminus'].Mod, {})

	--Archery--
	----avg dmg 63873 (Malevolence/Perfervid Sword, Fail-not, Hauksbok)
	sets.precast.WS['Flaming Arrow'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		ear2="Friomisi Earring"})
	sets.precast.WS['Flaming Arrow'].PDT = set_combine(sets.precast.WS['Flaming Arrow'], {})
	sets.precast.WS['Flaming Arrow'].Acc = set_combine(sets.precast.WS['Flaming Arrow'], {})
	sets.precast.WS['Flaming Arrow'].Mod = set_combine(sets.precast.WS['Flaming Arrow'], {})
	sets.precast.WS['Flaming Arrow'].UncappedAtk = set_combine(sets.precast.WS['Flaming Arrow'].Mod, {})

	----avg dmg 6195 (Ternon/Crepuscular, Fail-not, Hauksbok)
	sets.precast.WS['Piercing Arrow'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		neck="Scout's Gorget +2",ear1="Ishvara Earring",
		body="Amini Caban +3",hands="Meghanada Gloves +2",ring2="Defending Ring",
		legs="Ikenga's Trousers",feet="Amini Bottillons +3"})
	sets.precast.WS['Piercing Arrow'].PDT = set_combine(sets.precast.WS['Piercing Arrow'], {})
	sets.precast.WS['Piercing Arrow'].Acc = set_combine(sets.precast.WS['Piercing Arrow'], {})
	sets.precast.WS['Piercing Arrow'].Mod = set_combine(sets.precast.WS['Piercing Arrow'], {})
	sets.precast.WS['Piercing Arrow'].UncappedAtk = set_combine(sets.precast.WS['Piercing Arrow'].Mod, {})

	----avg dmg 5066 (Oneiros/Ternion, Fail-not, Hauksbok)
	sets.precast.WS['Dulling Arrow'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		head="Orion Beret +1",ear1="Odr Earring",ear2="Odnowa Earring +1",
		hands="Amini Glovelettes +3",ring2="Regal Ring",
		feet="Amini Bottillons +3"})
	sets.precast.WS['Dulling Arrow'].PDT = set_combine(sets.precast.WS['Dulling Arrow'], {})
	sets.precast.WS['Dulling Arrow'].Acc = set_combine(sets.precast.WS['Dulling Arrow'], {})
	sets.precast.WS['Dulling Arrow'].Mod = set_combine(sets.precast.WS['Dulling Arrow'], {})
	sets.precast.WS['Dulling Arrow'].UncappedAtk = set_combine(sets.precast.WS['Dulling Arrow'].Mod, {})

	----avg dmg 20303 (Ternion/Perun, Fail-not, Hauksbok)
	sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		head="Orion Beret +1",neck="Republican Platinum Medal",ear1="Ishvara Earring",ear2="Odnowa Earring +1",
		hands="Amini Glovelettes +3",ring2="Regal Ring",
		waist="Sailfi Belt +1",feet="Amini Bottillons +3"})
	sets.precast.WS['Sidewinder'].PDT = set_combine(sets.precast.WS['Sidewinder'], {})
	sets.precast.WS['Sidewinder'].Acc = set_combine(sets.precast.WS['Sidewinder'], {})
	sets.precast.WS['Sidewinder'].Mod = set_combine(sets.precast.WS['Sidewinder'], {})
	sets.precast.WS['Sidewinder'].UncappedAtk = set_combine(sets.precast.WS['Sidewinder'].Mod, {})

	----avg dmg 8493 (Ternion/Perun, Fail-not, Hauksbok)
	sets.precast.WS['Blast Arrow'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		head="Orion Beret +1",ear1="Ishvara Earring",ear2="Odnowa Earring +1",
		hands="Amini Glovelettes +3",ring2="Regal Ring",
		feet="Amini Bottillons +3"})
	sets.precast.WS['Blast Arrow'].PDT = set_combine(sets.precast.WS['Blast Arrow'], {})
	sets.precast.WS['Blast Arrow'].Acc = set_combine(sets.precast.WS['Blast Arrow'], {})
	sets.precast.WS['Blast Arrow'].Mod = set_combine(sets.precast.WS['Blast Arrow'], {})
	sets.precast.WS['Blast Arrow'].UncappedAtk = set_combine(sets.precast.WS['Blast Arrow'].Mod, {})

	----avg dmg 27010 (Mafic Cudgel/Ternion, Fail-not, Hauksbok)
	sets.precast.WS['Empyreal Arrow'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		neck="Scout's Gorget +2",
		body="Ikenga's Vest",ring2="Sroda Ring",
		feet="Amini Bottillons +3"})
	sets.precast.WS['Empyreal Arrow'].PDT = set_combine(sets.precast.WS['Empyreal Arrow'], {})
	sets.precast.WS['Empyreal Arrow'].Acc = set_combine(sets.precast.WS['Empyreal Arrow'], {})
	sets.precast.WS['Empyreal Arrow'].Mod = set_combine(sets.precast.WS['Empyreal Arrow'], {})
	sets.precast.WS['Empyreal Arrow'].UncappedAtk = set_combine(sets.precast.WS['Empyreal Arrow'].Mod, {})

	----avg dmg 24316 (Mafic Cudgel/Perfervid Sword, Fail-not, Hauksbok)
	sets.precast.WS['Refulgent Arrow'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		neck="Republican Platinum Medal",ear2="Ishvara Earring",
		body="Ikenga's Vest",ring2="Sroda Ring",
		waist="Sailfi Belt +1",feet="Amini Bottillons +3"})
	sets.precast.WS['Refulgent Arrow'].PDT = set_combine(sets.precast.WS['Refulgent Arrow'], {})
	sets.precast.WS['Refulgent Arrow'].Acc = set_combine(sets.precast.WS['Refulgent Arrow'], {})
	sets.precast.WS['Refulgent Arrow'].Mod = set_combine(sets.precast.WS['Refulgent Arrow'], {})
	sets.precast.WS['Refulgent Arrow'].UncappedAtk = set_combine(sets.precast.WS['Refulgent Arrow'].Mod, {})

	----avg dmg 19717 (Ternion/Perun, Yoichinoyumi, Hauksbok)
	sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		head="Orion Beret +1",ear1="Ishvara Earring",ear2="Odnowa Earring +1",
		hands="Amini Glovelettes +3",ring2="Regal Ring",
		feet="Amini Bottillons +3"})
	sets.precast.WS['Namas Arrow'].PDT = set_combine(sets.precast.WS['Namas Arrow'], {})
	sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'], {})
	sets.precast.WS['Namas Arrow'].Mod = set_combine(sets.precast.WS['Namas Arrow'], {})
	sets.precast.WS['Namas Arrow'].UncappedAtk = set_combine(sets.precast.WS['Namas Arrow'].Mod, {})

	----avg dmg 20483 (Oneiros/Gleti's Knife, Gandiva, Hauksbok)
	sets.precast.WS["Jishnu's Radiance"] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		head="Blistering Sallet +1",ear1="Odr Earring",
		body="Meghanada Cuirie +2",hands="Amini Glovelettes +3",ring2="Regal Ring",
		legs="Amini Bragues +3",feet="Amini Bottillons +3"})
	sets.precast.WS["Jishnu's Radiance"].PDT = set_combine(sets.precast.WS["Jishnu's Radiance"], {})
	sets.precast.WS["Jishnu's Radiance"].Acc = set_combine(sets.precast.WS["Jishnu's Radiance"], {})
	sets.precast.WS["Jishnu's Radiance"].Mod = set_combine(sets.precast.WS["Jishnu's Radiance"], {})
	sets.precast.WS["Jishnu's Radiance"].UncappedAtk = set_combine(sets.precast.WS["Jishnu's Radiance"].Mod, {})

	----avg dmg 21261 (Ternion/Crepuscular Knife, Fail-not, Hauksbok)
	sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		head="Orion Beret +1",neck="Scout's Gorget +2",ear1="Ishvara Earring",
		hands="Amini Glovelettes +3",ring2="Sroda Ring",
		legs="Ikenga's Trousers",feet="Amini Bottillons +3"})
	sets.precast.WS['Apex Arrow'].PDT = set_combine(sets.precast.WS['Apex Arrow'], {})
	sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
	sets.precast.WS['Apex Arrow'].Mod = set_combine(sets.precast.WS['Apex Arrow'], {})
	sets.precast.WS['Apex Arrow'].UncappedAtk = set_combine(sets.precast.WS['Apex Arrow'].Mod, {})

	----avg dmg 33966 (Ternion/Perun, Pinaka, Hauksbok)
	sets.precast.WS['Sarv'] = set_combine(sets.precast.WS, {--ammo=Hauksbok Arrow,
		head="Orion Beret +1",neck="Republican Platinum Medal",ear2="Odnowa Earring +1",
		body="Ikenga's Vest",hands="Amini Glovelettes +3",ring2="Defending Ring",
		waist="Sailfi Belt +1",feet="Amini Bottillons +3"})
	sets.precast.WS['Sarv'].PDT = set_combine(sets.precast.WS['Sarv'], {})
	sets.precast.WS['Sarv'].Acc = set_combine(sets.precast.WS['Sarv'], {})
	sets.precast.WS['Sarv'].Mod = set_combine(sets.precast.WS['Sarv'], {})
	sets.precast.WS['Sarv'].UncappedAtk = set_combine(sets.precast.WS['Sarv'].Mod, {})
	
	sets.midcast = {}
	sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.SpellInterrupt = {
		head=TaeonHead.SIRD,neck="Loricate Torque +1",ear2="Halasz Earring",
		ring1="Evanescence Ring",
		waist="Rumination Sash",legs="Carmine Cuisses +1"}
	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
	sets.midcast.Cure = set_combine(sets.midcast.SpellInterrupt,{ear1="Mendi. Earring"})
	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

	-- Ranged gear
	sets.midcast.RA = {
		head="Arcadian Beret +3",neck="Scout's Gorget +2",ear1="Dedition Earring",ear2="Telos Earring",
		body="Ikenga's Vest",hands="Amini Glovelettes +3",ring1="Ilabrat Ring",ring2="Regal Ring",
		back=Belenus.WSD_AGI,waist="Yemaya Belt",legs="Amini Bragues +3",feet="Ikenga's Clogs"}

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,{ear1="Crepuscular Earring"})
	sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {ring1="Crepuscular Ring",ring2="Cacoethic Ring +1",waist="Kwahu Kachina Belt +1"})
	sets.midcast.RA.Critical = set_combine(sets.midcast.RA,{
		head="Meghanada Visor +2",neck="Scout's Gorget +2",ear1="Odr Earring",ear2="Amini Earring +1",
		body="Nisroch Jerkin",hands="Mummu Wrists +2",ring1="Begrudging Ring",ring2="Mummu Ring",
		waist="Kwahu Kachina Belt +1",legs="Amini Bragues +3",feet="Oshosi Leggings +1"})
	sets.midcast.RA.STP = set_combine(sets.midcast.RA, {})
	sets.DoubleShot = set_combine(sets.midcast.RA,{
		body="Arcadian Jerkin +1",hands="Oshosi Gloves +1",
		legs="Oshosi Trousers +1",feet="Oshosi Leggings +1"})
	sets.DoubleShotCritical = set_combine(sets.midcast.RA.Critical,{
		body="Arcadian Jerkin +1",hands="Oshosi Gloves +1",
		legs="Oshosi Trousers +1"})
	sets.TrueShot = set_combine(sets.midcast.RA,{
		body="Nisroch Jerkin",
		waist="Tellen Belt"})

	sets.idle.Refresh = set_combine(sets.idle,{})
	sets.Kiting = {ring1="Shneddick Ring +1"}

	sets.engaged = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Sherida Earring",
		body="Tatenashi Haramaki +1",hands="Amini Glovelettes +3",ring1="Chirich Ring +1",ring2="Epona's Ring",
		back=Belenus.WSD_AGI,waist="Sailfi Belt +1",legs="Amini Bragues +3",feet="Malignance Boots"}
	sets.engaged.LowAcc = set_combine(sets.engaged, {})
	sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {})
	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {})
	sets.engaged.STP = set_combine(sets.engaged, {})

	-- * DNC Subjob DW Trait: +15%
	-- * NIN Subjob DW Trait: +25%

	-- No Magic Haste (74% DW to cap)
	sets.engaged.DW = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Chirich Ring +1",
		back=Belenus.WSD_AGI,waist="Sailfi Belt +1",legs="Amini Bragues +3",feet=HercFeet.TripleAtk}
	sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {})
	sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {})
	sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {})
	sets.engaged.DW.STP = set_combine(sets.engaged.DW, {})

	-- 15% Magic Haste (67% DW to cap)
	sets.engaged.DW.Haste_15 = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Chirich Ring +1",
		back=Belenus.WSD_AGI,waist="Sailfi Belt +1",legs="Amini Bragues +3",feet=HercFeet.TripleAtk}
	sets.engaged.DW.LowAcc.Haste_15 = set_combine(sets.engaged.DW.Haste_15, {})
	sets.engaged.DW.MidAcc.Haste_15 = set_combine(sets.engaged.DW.LowAcc.Haste_15, {})
	sets.engaged.DW.HighAcc.Haste_15 = set_combine(sets.engaged.DW.MidAcc.Haste_15, {})
	sets.engaged.DW.STP.Haste_15 = set_combine(sets.engaged.DW.Haste_15, {})

	-- 30% Magic Haste (56% DW to cap)
	sets.engaged.DW.Haste_30 = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Tatenashi Haramaki +1",hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Defending Ring",
		back=Belenus.WSD_AGI,waist="Sailfi Belt +1",legs="Amini Bragues +3",feet=HercFeet.TripleAtk}
	sets.engaged.DW.LowAcc.Haste_30 = set_combine(sets.engaged.DW.Haste_30, {})
	sets.engaged.DW.MidAcc.Haste_30 = set_combine(sets.engaged.DW.LowAcc.Haste_30, {})
	sets.engaged.DW.HighAcc.Haste_30 = set_combine(sets.engaged.DW.MidAcc.Haste_30, {})
	sets.engaged.DW.STP.Haste_30 = set_combine(sets.engaged.DW.Haste_30, {})

	-- 35% Magic Haste (51% DW to cap)
	sets.engaged.DW.Haste_35 = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Tatenashi Haramaki +1",hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Defending Ring",
		back=Belenus.WSD_AGI,waist="Sailfi Belt +1",legs="Amini Bragues +3",feet="Malignance Boots"}
	sets.engaged.DW.LowAcc.Haste_35 = set_combine(sets.engaged.DW.Haste_35, {})
	sets.engaged.DW.MidAcc.Haste_35 = set_combine(sets.engaged.DW.LowAcc.Haste_35, { })
	sets.engaged.DW.HighAcc.Haste_35 = set_combine(sets.engaged.DW.MidAcc.Haste_35, {})
	sets.engaged.DW.STP.Haste_35 = set_combine(sets.engaged.DW.Haste_35, {})

	-- 45% Magic Haste (36% DW to cap)
	sets.engaged.DW.MaxHaste = {
		head="Dampening Tam",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Sherida Earring",
		body="Tatenashi Haramaki +1",hands="Amini Glovelettes +3",ring1="Epona's Ring",ring2="Defending Ring",
		back=Belenus.WSD_AGI,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
	sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {})
	sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {})
	sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {})
	sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {})

	sets.DefaultShield = {sub="Nusku Shield"}

end

function job_precast(spell, action, spellMap, eventArgs)
	-- Check that proper ammo is available if we're using ranged attacks or similar.
	if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' then
		do_bullet_checks(spell, spellMap, eventArgs)
	end

	if spellMap == 'Utsusemi' then
		if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
			cancel_spell()
			add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
			eventArgs.handled = true
			return
		elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
			send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
		end
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
		
	--elseif actor.in_party and otherTarget.in_party and targetsDistance < 10 then
--
		--if CuragaAbility:contains(act_info.name) and player.hpp < 75 then
			--if sets.Cure_Received then
			--do_equip('sets.Cure_Received')
			--elseif sets.Self_Healing then
				--do_equip('sets.Self_Healing') 
			--end
			--return
		--elseif ProshellraAbility:contains(act_info.name) and sets.Sheltered then
			--do_equip('sets.Sheltered') return
		--end
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

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
	
		local my_ammo
		local rangedpreSet
		
		if gunList:contains(player.equipment.range) then
			my_ammo = gear.RAbullet
		elseif crossbowList:contains(player.equipment.range) then
			my_ammo = gear.Bolt
		elseif bowList:contains(player.equipment.range) then
			my_ammo = gear.Arrow
		end

		special_ammo_check()
		--add_to_chat(8,"flurry state is "..flurry)
		if flurry == 2 then
			rangedpreSet = set_combine(sets.precast.RA.Flurry2,{ammo=my_ammo})
		elseif flurry == 1 then
			rangedpreSet = set_combine(sets.precast.RA.Flurry1,{ammo=my_ammo})
		else
			rangedpreSet = set_combine(sets.precast.RA,{ammo=my_ammo})
		end
		
		--equip JA-enhancing gear
		if buffactive["Double Shot"] then
			rangedpreSet = set_combine(rangedpreSet,sets.precast.JA['Double Shot'])
		end
		if buffactive['Barrage'] then
			rangedpreSet = set_combine(rangedpreSet,sets.precast.JA['Barrage'])
		elseif buffactive["Unlimited Shot"] then
			rangedpreSet = set_combine(rangedpreSet,sets.precast.JA['Unlimited Shot'])
		end
		if buffactive["Flashy Shot"] then
			rangedpreSet = set_combine(rangedpreSet,sets.precast.JA['Flashy Shot'])
		end

		equip(rangedpreSet)

	elseif spell.type == 'WeaponSkill' then
		if spell.skill == 'Marksmanship' then
			special_ammo_check()
		end
		if gunList:contains(player.equipment.range) then
			if (spell.english == 'Wildfire' or spell.english == 'Hot Shot') then
				my_ammo = gear.MAbullet
				equip({ammo=my_ammo})
			else
				my_ammo = gear.WSbullet
				equip({ammo=my_ammo})
			end
		elseif crossbowList:contains(player.equipment.range) then
			my_ammo = gear.Bolt
		elseif bowList:contains(player.equipment.range) then
			my_ammo = gear.Arrow
		end
		
		if elemental_ws:contains(spell.name) then
			-- Matching double weather (w/o day conflict).
			if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
				equip({waist="Hachirin-no-Obi"})
			-- Target distance under 1.7 yalms.
			elseif spell.target.distance < (1.7 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
			-- Matching day and weather.
			elseif spell.element == world.day_element and spell.element == world.weather_element then
				equip({waist="Hachirin-no-Obi"})
			-- Target distance under 8 yalms.
			elseif spell.target.distance < (8 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
			-- Match day or weather.
			elseif spell.element == world.day_element or spell.element == world.weather_element then
				equip({waist="Hachirin-no-Obi"})
			end
		end
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)

	local rangedmidSet
	--Normal or crit-focused
	if spell.action_type == 'Ranged Attack' then
		if state.RangedMode.value == 'Critical' and buffactive["Double Shot"] then
			rangedmidSet = sets.DoubleShotCritical
		elseif buffactive["Double Shot"] then
			rangedmidSet = sets.DoubleShot
		elseif state.RangedMode.value == 'Critical' then
			rangedmidSet = sets.midcast.RA.Critical
		else
			rangedmidSet = sets.midcast.RA
		end
	equip(rangedmidSet)
	end


end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	--if player.status ~= 'Engaged' and state.WeaponLock.value == false then
	--	check_weaponset()
	--end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
	if S{'flurry','flurry ii'}:contains(buff:lower()) then
		if not gain then
			flurry = nil
			add_to_chat(122, "Flurry off.")
		end
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
	
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
		determine_haste_group()
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end

--	if buffactive['Reive Mark'] then
--		if gain then
--			equip(sets.Reive)
--			disable('neck')
--		else
--			enable('neck')
--		end
--	end
end

-- Handle notifications of general user state change.
--function job_state_change(stateField, newValue, oldValue)
--	if state.WeaponLock.value == true then
--		disable('ranged')
--	else
--		enable('ranged')
--	end
--
--	check_weaponset()
--end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
	check_gear()
	update_combat_form()
end

function job_update(cmdParams, eventArgs)
	handle_equipping_gear(player.status)
end

function update_combat_form()
	if DW == true then
		state.CombatForm:set('DW')
	elseif DW == false then
		state.CombatForm:reset()
	end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
--check_weaponset()
	if buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane'] then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
	local wsmode
	if spell.skill == 'Marksmanship' then
		if state.RangedMode.value == 'Acc' or state.RangedMode.value == 'HighAcc' then
			wsmode = 'Acc'
		end
	else
		if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
			wsmode = 'Acc'
		end
	end

	return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.hpp < 80 then
		idleSet = set_combine(idleSet, sets.idle.Regen)
	end
	if state.HybridMode.value == 'PDT' then
	    if state.Kiting.value then
			idleSet = set_combine(sets.idle.PDT,sets.Kiting)
		else
			idleSet = set_combine(idleSet, sets.idle.PDT)
		end
	end
	--local res = require('resources')
	--local info = windower.ffxi.get_info()
	--local zone = res.zones[info.zone].name
	--if zone:match('Adoulin') then
	--	idleSet = set_combine(idleSet, sets.Adoulin)
	--end
	if buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane'] then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	local cf_msg = ''
	if state.CombatForm.has_value then
		cf_msg = ' (' ..state.CombatForm.value.. ')'
	end

	local m_msg = state.OffenseMode.value
	if state.HybridMode.value ~= 'Normal' then
		m_msg = m_msg .. '/' ..state.HybridMode.value
	end

	local ws_msg = state.WeaponskillMode.value

	local d_msg = 'None'
	if state.DefenseMode.value ~= 'None' then
		d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
	end

	local i_msg = state.IdleMode.value

	local msg = ''
	if state.Kiting.value then
		msg = msg .. ' Kiting: On '
	end

	add_to_chat(string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
		..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
		..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
		..string.char(31,002)..msg)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
	function(act)
		--check if you are a target of spell
		local actionTargets = act.targets
		playerId = windower.ffxi.get_player().id
		isTarget = false
		for _, target in ipairs(actionTargets) do
			if playerId == target.id then
				isTarget = true
			end
		end
		if isTarget == true then
			if act.category == 4 then
				local param = act.param
				if param == 845 and flurry ~= 2 then
					add_to_chat(122, 'Flurry On: Flurry I')
					flurry = 1
				elseif param == 846 then
					add_to_chat(122, 'Flurry On: Flurry II')
					flurry = 2
				elseif param == 478 then
					add_to_chat(122, 'Embrava On: Using Flurry II')
					flurry = 2
				end
			end
		end
	end)

function determine_haste_group()

	classes.CustomMeleeGroups:clear()
	-- assuming +4 for marches (ghorn has +5)
	-- Haste (white magic) 15%
	-- Haste Samba (Sub) 5%
	-- Haste (Merited DNC) 10% (never account for this)
	-- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
	-- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
	-- Embrava 30% with 500 enhancing skill
	-- Mighty Guard - 15%
	-- buffactive[580] = geo haste
	-- buffactive[33] = regular haste
	-- buffactive[604] = mighty guard
	-- state.HasteMode = toggle for when you know Haste II is being cast on you
	-- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
	if state.HasteMode.value == 'Hi' then
		if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
			( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
			( buffactive.march == 2 and buffactive[604] ) ) then
			add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
			add_to_chat(8, '-------------Haste 35%-------------')
			classes.CustomMeleeGroups:append('Haste_35')
		elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
				( buffactive.march == 1 and buffactive[604] ) ) then
			add_to_chat(8, '-------------Haste 30%-------------')
			classes.CustomMeleeGroups:append('Haste_30')
		elseif ( buffactive.march == 1 or buffactive[604] ) then
			add_to_chat(8, '-------------Haste 15%-------------')
			classes.CustomMeleeGroups:append('Haste_15')
		end
	else
		if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
			( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
			( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
			( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
			add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
			( buffactive.march == 2 and buffactive['haste samba'] ) or
			( buffactive[580] and buffactive['haste samba'] ) then 
			add_to_chat(8, '-------------Haste 35%-------------')
			classes.CustomMeleeGroups:append('Haste_35')
		elseif ( buffactive.march == 2 ) or -- two marches from ghorn
			( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
			( buffactive[580] ) or  -- geo haste
			( buffactive[33] and buffactive[604] ) then  -- haste with MG
			add_to_chat(8, '-------------Haste 30%-------------')
			classes.CustomMeleeGroups:append('Haste_30')
		elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
			add_to_chat(8, '-------------Haste 15%-------------')
			classes.CustomMeleeGroups:append('Haste_15')
		end
	end

end

--[[
function determine_haste_group()
	classes.CustomMeleeGroups:clear()
	if DW == true then
		if DW_needed <= 21 then
			add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif DW_needed > 21 and DW_needed <= 27 then
			add_to_chat(8, '-------------Haste 35%-------------')
			classes.CustomMeleeGroups:append('Haste_35')
		elseif DW_needed > 27 and DW_needed <= 31 then
			add_to_chat(8, '-------------Haste 30%-------------')
			classes.CustomMeleeGroups:append('Haste_30')
		elseif DW_needed > 31 and DW_needed <= 42 then
			add_to_chat(8, '-------------Haste 15%-------------')
			classes.CustomMeleeGroups:append('Haste_15')
		elseif DW_needed > 42 then
			classes.CustomMeleeGroups:append('')
		end
	end
end
--]]

function job_self_command(cmdParams, eventArgs)
	gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
	if cmdParams[1] == 'gearinfo' then
		if type(tonumber(cmdParams[2])) == 'number' then
			if tonumber(cmdParams[2]) ~= DW_needed then
			DW_needed = tonumber(cmdParams[2])
			DW = true
			end
		elseif type(cmdParams[2]) == 'string' then
			if cmdParams[2] == 'false' then
				DW_needed = 0
				DW = false
			end
		end
		if type(tonumber(cmdParams[3])) == 'number' then
			if tonumber(cmdParams[3]) ~= Haste then
				Haste = tonumber(cmdParams[3])
			end
		end
		if type(cmdParams[4]) == 'string' then
			if cmdParams[4] == 'true' then
				moving = true
			elseif cmdParams[4] == 'false' then
				moving = false
			end
		end
		if not midaction() then
			job_update()
		end
	end
end

-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
	local bullet_name
	local bullet_min_count = 1

	if spell.type == 'WeaponSkill' then
		if spell.skill == "Marksmanship" then
			if gunList:contains(player.equipment.range) then
				if spell.english == 'Wildfire' or spell.english == 'Hot Shot' then
					-- magical weaponskills
					bullet_name = gear.MAbullet
				else
					-- physical weaponskills
					bullet_name = gear.WSbullet
				end
			elseif crossbowList:contains(player.equipment.range) then
				bullet_name = gear.Bolt
			end
		elseif spell.skill == 'Archery' then
			bullet_name = gear.Arrow

		else
			-- Ignore non-ranged weaponskills
		return
	end
	elseif spell.action_type == 'Ranged Attack' then
		if gunList:contains(player.equipment.range) then
			bullet_name = gear.RAbullet
		elseif crossbowList:contains(player.equipment.range) then
			bullet_name = gear.Bolt
		elseif bowList:contains(player.equipment.range) then
			bullet_name = gear.Arrow
		end
			
		if buffactive['Double Shot'] then
			bullet_min_count = 2
		end
	end

	local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name] or player.wardrobe2[bullet_name] or player.wardrobe3[bullet_name] or player.wardrobe4[bullet_name] or player.wardrobe5[bullet_name] or player.wardrobe6[bullet_name] or player.wardrobe7[bullet_name] or player.wardrobe8[bullet_name]

	-- If no ammo is available, give appropriate warning and end.
	if not available_bullets then
		if spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
			add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
			return
		else
			add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
			eventArgs.cancel = true
			return
		end
	end

	-- Low ammo warning.
	if state.warned.value == false
		and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
		local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
		--local border = string.repeat("*", #msg)
		local border = ""
		for i = 1, #msg do
			border = border .. "*"
		end

		add_to_chat(104, border)
		add_to_chat(104, msg)
		add_to_chat(104, border)

		state.warned:set()
	elseif available_bullets.count > options.ammo_warning_limit and state.warned then
		state.warned:reset()
	end
end

function special_ammo_check()
	-- Stop if Animikii/Hauksbok equipped
	if no_shoot_ammo:contains(player.equipment.ammo) then
		cancel_spell()
		add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
		return
	end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
	if category == 2 or -- any ranged attack
		--category == 4 or -- any magic action
		(category == 3 and param == 30) or -- Aeolian Edge
		(category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
		(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		then return true
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

--[[
function display_current_job_state(eventArgs)
	local msg = ''
	msg = msg .. 'Offense: '..state.OffenseMode.current
	msg = msg .. ', Hybrid: '..state.HybridMode.current

	if state.DefenseMode.value ~= 'None' then
		local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
		msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
	end
	if state.HasteMode.value ~= 'Normal' then
		msg = msg .. ', Haste: '..state.HasteMode.current
	end
	if state.RangedMode.value ~= 'Normal' then
		msg = msg .. ', Rng: '..state.RangedMode.current
	end
	if state.Kiting.value then
		msg = msg .. ', Kiting'
	end
	if state.PCTargetMode.value ~= 'default' then
		msg = msg .. ', Target PC: '..state.PCTargetMode.value
	end
	if state.SelectNPCTargets.value then
		msg = msg .. ', Target NPCs'
	end

	add_to_chat(123, msg)
	eventArgs.handled = true
end
--]]

--function check_weaponset()
--	if state.OffenseMode.value == 'LowAcc' or state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
--		equip(sets[state.WeaponSet.current].Acc)
--	else
--		equip(sets[state.WeaponSet.current])
--	end
--	if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
--		equip(sets.DefaultShield)
--	end
--end

-- Select default macro book on initial load or subjob change.
function set_macros(sheet,book)
	if book then 
		send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
		return
	end
	send_command('@input /macro set '..tostring(sheet))
end

--Page, Book--
set_macros(5,22)

function set_style(sheet)
		send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(52) 
