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

	state.Buff.Migawari = buffactive.migawari or false
	state.Buff.Sange = buffactive.sange or false
	state.Buff.Innin = buffactive.innin or false
	state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Doom'] = buffactive['doom'] or false
	state.Buff['Bane'] = buffactive['bane'] or false
	state.Buff['Terror'] = buffactive['terror'] or false
	state.Buff['Stun'] = buffactive['stun'] or false
	state.Buff['Petrification'] = buffactive['petrification'] or false

	include('Mote-TreasureHunter')
	state.TreasureMode:set('Tag')

	state.HasteMode = M{['description']='Haste Mode', 'Hi', 'Normal'}
	state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
	state.UseRune = M(false, 'Use Rune')
	--state.UseWarp = M(false, 'Use Warp')
	state.Adoulin = M(false, 'Adoulin')
	--state.Moving  = M(false, "moving")

	run_sj = player.sub_job == 'RUN' or false

	select_ammo()
	LugraWSList = S{'Blade: Ku', 'Blade: Jin'}
	SrodaWS1List = S{'Blade: Hi','Blade: Ten','Savage Blade'}
	SrodaWS2List = S{'Blade: Kamu','Blade: Ku'}
	state.CapacityMode = M(false, 'Capacity Point Mantle')
	--state.Proc = M(false, 'Proc')
	--state.unProc = M(false, 'unProc')

	--gear.RegularAmmo = 'Seki Shuriken'
	--gear.SangeAmmo = 'Happo Shuriken'

	wsList = S{'Blade: Hi', 'Blade: Kamu', 'Blade: Ten'}
	nukeList = S{'Katon: San', 'Katon: Ni','Doton: San', 'Doton: Ni', 'Suiton: San', 'Suiton: Ni', 'Raiton: San', 'Raiton: Ni', 'Hyoton: San', 'Hyoton: Ni', 'Huton: San', 'Huton: Ni'}
	no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
		"Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

	update_combat_form()

	state.warned = M(false)
	options.ammo_warning_limit = 25
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
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'MaxAcc','PDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.BurstMode = M(true, 'BurstMode')
	state.Sroda = M(true, 'Sroda')

	--select_default_macro_book()

	send_command('bind ^= gs c cycle treasuremode')
	--send_command('bind ^[ gs c toggle UseWarp')
	--send_command('bind ![ input /lockstyle off')
	--send_command('bind != gs c toggle CapacityMode')
	send_command('bind @f9 gs c cycle HasteMode')
	send_command('bind numpad. gs c cycle HybridMode')
	send_command('bind numpad6 gs c cycle WeaponskillMode')
	send_command('bind numpad3 gs c cycle OffenseMode')
	send_command('bind numpad7 gs c cycle BurstMode')
	send_command('bind numpad9 gs c cycle Sroda')

	--send_command('unbind ^-')
	send_command('bind ^- gs c cycle Kiting')

	send_command('gs enable ammo')

	PhalanxAbility = S{"Phalanx II"}

end


function file_unload()
	--send_command('unbind ^[')
	--send_command('unbind ![')
	send_command('unbind ^=')
	--send_command('unbind !=')
	send_command('unbind @f9')
	send_command('unbind numpad.')
	--send_command('unbind @[')
	send_command('unbind ^-')
	send_command('unbind ^0')	
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind numpad5')
	send_command('unbind numpad6')	
	send_command('unbind numpad7')	
	send_command('unbind numpad9')	

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
	--Andartia = {}
	--Andartia.DEX = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%'}}
	--Andartia.AGI = {name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%',}}
	--Andartia.STR = {name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

	--AdhemarLegs = {}
	--AdhemarLegs.Snap = { name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}}
	--AdhemarLegs.TP = { name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}}

	HercFeet = {}
	HercHead = {}
	HercLegs = {}
	HercBody = {}
	HercHands = {}

	--HercHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+19','Magic burst dmg.+15%','Accuracy+13 Attack+13','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
	HercHands.TH = {name="Herculean Gloves", augments={'Accuracy+1 Attack+1','Weapon skill damage +2%','"Treasure Hunter"+2',}}
	HercHands.Waltz = { name="Herculean Gloves", augments={'Chance of successful block +1','"Waltz" potency +10%','"Store TP"+1','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	HercHands.FC = { name="Herculean Gloves", augments={'Pet: "Mag.Atk.Bns."+20','STR+7','"Fast Cast"+8','Accuracy+15 Attack+15',}}
	HercHands.Phalanx = { name="Herculean Gloves", augments={'Pet: "Dbl. Atk."+2','Potency of "Cure" effect received+6%','Phalanx +4','Accuracy+5 Attack+5','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}

	HercBody.Phalanx = { name="Herculean Vest", augments={'Mag. Acc.+19','Magic dmg. taken -1%','Phalanx +5',}}

	HercFeet.FC = {name="Herculean Boots", augments={'"Fast Cast"+6','INT+4','Mag. Acc.+1','"Mag.Atk.Bns."+10',}}
	HercFeet.Waltz = { name="Herculean Boots", augments={'"Waltz" potency +10%','STR+12','Damage taken-1%','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}

	HercHead.TH = {name="Herculean Helm", augments={'"Store TP"+1','"Avatar perpetuation cost" -1','"Treasure Hunter"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	HercHead.FC = { name="Herculean Helm", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Accuracy+3','"Fast Cast"+7',}}
	HercHead.Phalanx = { name="Herculean Helm", augments={'Pet: INT+6','Weapon skill damage +1%','Phalanx +4',}}

	HercLegs.WSD = { name="Herculean Trousers", augments={'Spell interruption rate down -7%','MND+13','Weapon skill damage +9%','Mag. Acc.+3 "Mag.Atk.Bns."+3'}}
	HercLegs.FC = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+18','"Fast Cast"+6','INT+10','Mag. Acc.+12',}}
	HercLegs.Phalanx = { name="Herculean Trousers", augments={'Mag. Acc.+15','Phalanx +4','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}

	TaeonHands = {} 
	TaeonHead = {}

	Andartia = {}
	Andartia.DA = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
	Andartia.FC = { name="Andartia's Mantle", augments={'"Fast Cast"+10','Damage taken-5%',}}

	AdhemarHead = {}
	AdhemarHead.B = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}

	Nyame = {head="Nyame Helm",body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	InninHead = "Hattori Zukin +2"
	YoninLegs = "Hattori Hakama +2"

	sets.Phalanx = {head=HercHead.Phalanx,body=HercBody.Phalanx,hands=HercHands.Phalanx,legs=HercLegs.Phalanx}
	--------------------------------------
	-- Job Abilties
	--------------------------------------
	sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama +3"}
	sets.precast.JA['Futae'] = {} --{ hands="Hattori Tekko +1" }
	sets.precast.JA['Provoke'] = set_combine(sets.engaged.PDT,sets.precast.Enmity)
	sets.precast.JA.Sange = {} --{ ammo=gear.SangeAmmo, body="Mochizuki Chainmail +3" }

	sets.precast.Enmity = {ammo="Date Shuriken",neck="Warder's Charm +1",ear1="Friomisi Earring",body="Passion Jacket",ring1="Pernicious Ring",ring2="Supershear Ring",back="Phalangite Mantle",feet="Mochizuki Kyahan +3"}
	
	-- Waltz (chr and vit)
	sets.precast.Waltz = {ammo="Yamarang",
		body="Passion Jacket",hands=HercHands.Waltz,waist="Flume Belt +1",Legs="Dashing Subligar",Feet=HercFeet.Waltz}	
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {}
	--sets.MadrigalBonus = {hands="Composer's Mitts"}
	
	-- sets.midcast.Trust =  {
	--     head="Hattori Zukin +1",
	--     hands="Ryuo Tekko",
	--     feet="Hachiya Kyahan +1"
	-- }
	--sets.Warp = { ring1="Warp Ring" }

	--------------------------------------
	-- Utility Sets for rules below
	--------------------------------------
	sets.TreasureHunter = {head=HercHead.TH,hands=HercHands.TH}
	--sets.CapacityMantle = { back="Mecistopins Mantle" }
	sets.WSDayBonus     = {} --{ head="Gavialis Helm" }

	sets.buff.Doom = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar Sash"} --{ring2="Saida Ring"}
	sets.buff.Curse = sets.buff.Doom

	
	sets.RegularAmmo    = { ammo=gear.RegularAmmo }
	sets.SangeAmmo      = { ammo=gear.SangeAmmo }
	sets.Lugra = {ear2="Lugra Earring +1"}
	sets.SrodaWS1 = {ring1="Sroda Ring",ring2="Epaminondas's Ring"}
	sets.SrodaWS2 = {ring1="Sroda Ring",ring2="Gere Ring"}

	-- sets.NightAccAmmo   = { ammo="Ginsen" }
	-- sets.DayAccAmmo     = { ammo="Seething Bomblet +1" }

	--------------------------------------
	-- Ranged
	--------------------------------------

	sets.precast.RA = {}
	sets.midcast.RA = {}
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})
	sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)

	--FC pieces (cap is 80 for cast time reduction, recast time reduction is that /2):
	-- HercHead: 13
	-- Orunmila Torque: 5
	-- Etiolation: 1
	-- Loquacious: 2
	-- Adhemar body: 10
	-- Leyline: 6
	-- Weatherspoon ring +1: 6
	-- Kishar: 4
	-- HercLegs: 6
	-- HercFeet: 6

	-- Total: 59


	-- Fast cast sets for spells
	sets.precast.FC = {ammo="Sapience Orb",
		head=HercHead.FC,neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Adhemar Jacket +1",hands=HercHands.FC,ring1="Kishar Ring",ring2="Rahab Ring",
		back=Andartia.FC,legs=HercLegs.FC,feet=HercFeet.FC}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Mochizuki Chainmail +3"})

	-- Midcast Sets
	sets.midcast.FastRecast = {}

	-- skill ++ 
	-- giving up some recast reduction from Fast Cast in favor of DT. 
		-- Hattori Zukin +2: 9
		-- Loricate Torque +1: 6
		-- Hattori Ningi +2: 12
		-- D.Ring: 10
		-- Hattori Hakama +2: 11
		-- Andartia: 5
	sets.midcast.Ninjutsu = {head="Hattori Zukin +2",neck="Loricate Torque +1",body="Hattori Ningi +2",ring1="Defending Ring",legs="Hattori Hakama +2"}

	-- any ninjutsu cast on self
	sets.midcast.SelfNinjutsu = sets.midcast.Ninjutsu
	sets.midcast.Utsusemi = set_combine(sets.midcast.Ninjutsu, {back=Andartia.FC,feet="Hattori Kyahan +2"})
	sets.midcast.Migawari = set_combine(sets.midcast.Ninjutsu, {back=Andartia.FC})

	-- Nuking Ninjutsu (skill & magic attack)
	sets.midcast.ElementalNinjutsu = {ammo="Ghastly Tathlum +1",
		head="Mochizuki Hatsuburi +3",neck="Sibyl Scarf",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Nyame Mail",hands="Hattori Tekko +2",ring1="Dingir Ring",ring2="Metamor. Ring +1",
		waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Mochi. Kyahan +3"}
	sets.Burst = set_combine(sets.midcast.ElementalNinjutsu, {ring2="Mujin Band"}) --{ hands="Hattori Tekko +1", feet=HercFeet.MAB})

	-- Effusions
	sets.precast.Effusion = {}
	sets.precast.Effusion.Lunge = sets.midcast.ElementalNinjutsu
	sets.precast.Effusion.Swipe = sets.midcast.ElementalNinjutsu

	sets.idle = {ammo="Staunch Tathlum +1",
	head="Malignance Chapeau",neck="Elite Royal Collar",ear1="Sanare Earring",ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
		body="Hizamaru Haramaki +2",hands="Malignance Gloves",ring1="Defending Ring",ring2="Chirich Ring +1",
		back=Andartia.DA,waist="Audumbla Sash",legs="Malignance Tights",feet="Malignance Boots"}
	sets.idle.PDT = set_combine(sets.idle, {head="Malignance Chapeau",neck="Loricate Torque +1",body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},waist="Flume Belt +1",feet="Malignance Boots"})
	sets.idle.Normal = sets.idle

	sets.idle.Regen = set_combine(sets.idle, {})

	sets.Adoulin = {body="Councilor's Garb"}
	sets.idle.Town = sets.idle
	sets.idle.Town = set_combine(sets.idle, {})
	sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {body="Councilor's Garb"})

	sets.idle.Weak = sets.idle

	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle, {})
	--sets.defense.MDT = set_combine(sets.idle, {})

	sets.DayMovement = {ring2="Shneddick Ring +1"}
	sets.NightMovement = {feet="Hachiya Kyahan +3"}

	-- Normal melee group without buffs
	sets.engaged = {ammo="Happo Shuriken +1",
		head="Ryuo Somen +1",neck="Ninja Nodowa +2",ear1="Dedition Earring",ear2="Eabani Earring",
		body="Ashera Harness",hands="Malignance Gloves",ring1="Epona's Ring",ring2="Gere Ring",
		back=Andartia.DA,waist="Reiki Yotai",legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},feet="Tatena. Sune. +1"}
		
	-- assumptions made about targe
	sets.engaged.MidAcc = set_combine(sets.engaged, {ammo="Happo Shuriken +1",
		head="Ryuo Somen +1",neck="Ninja Nodowa +2",ear1="Telos Earring",ear2="Suppanomimi",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Regal Ring",ring2="Patricius Ring",
		legs="Malignance Tights",feet="Malignance Boots"})
	sets.engaged.MaxAcc = set_combine(sets.engaged.MidAcc, {})
	sets.engaged.Innin = set_combine(sets.engaged, {})
	sets.engaged.Innin.MidAcc = set_combine(sets.engaged.MidAcc, {})
	sets.engaged.Innin.MaxAcc = set_combine(sets.engaged.MaxAcc, {})

	-- Defensive sets
	sets.NormalPDT = {ammo="Happo Shuriken +1",
		head="Malignance Chapeau",neck="Ninja Nodowa +2",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Gere Ring",ring2="Defending Ring",
		back=Andartia.DA,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

	--sets.MaxAcc.PDT = set_combine(sets.engaged.MaxAcc, sets.NormalPDT)
	--sets.engaged.Haste.PDT = set_combine(sets.engaged, sets.NormalPDT)
	sets.engaged.PDT = set_combine(sets.NormalPDT, {ear1="Dedition Earring",ear2="Eabani Earring"})
	sets.engaged.MidAcc.PDT = set_combine(sets.engaged.PDT, {ear1="Suppanomimi",ear2="Telos Earring"})
	sets.engaged.MaxAcc.PDT = set_combine(sets.engaged.MidAcc.PDT, {})
	sets.engaged.Innin.PDT = set_combine(sets.engaged.PDT, {})
	sets.engaged.Innin.MidAcc.PDT = set_combine(sets.engaged.MidAcc.PDT, {})
	sets.engaged.Innin.MaxAcc.PDT = set_combine(sets.engaged.MaxAcc.PDT, {})

	-- 15% Haste (normal haste spell)
	sets.engaged.Haste_15 = set_combine(sets.engaged, {ear2="Telos Earring",hands="Adhemar Wristbands +1"})
	sets.engaged.MidAcc.Haste_15 = set_combine(sets.engaged.MidAcc, {})
	sets.engaged.MaxAcc.Haste_15 = set_combine(sets.engaged.MaxAcc, {})
	sets.engaged.Innin.Haste_15 = set_combine(sets.engaged.Innin, { })
	sets.engaged.Innin.MidAcc.Haste_15 = set_combine(sets.engaged.Innin.MidAcc, {})
	sets.engaged.Innin.MaxAcc.Haste_15 = set_combine(sets.engaged.Innin.MaxAcc, {})
	sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.PDT, {})
	sets.engaged.MidAcc.PDT.Haste_15 = set_combine(sets.engaged.MidAcc.PDT, {})
	sets.engaged.MaxAcc.PDT.Haste_15 = set_combine(sets.engaged.MaxAcc.PDT, {})
	sets.engaged.Innin.PDT.Haste_15 = set_combine(sets.engaged.Innin.PDT, {})
	sets.engaged.Innin.MidAcc.PDT.Haste_15 = set_combine(sets.engaged.Innin.MidAcc.PDT, {})
	sets.engaged.Innin.MaxAcc.PDT.Haste_15 = set_combine(sets.engaged.Innin.MaxAcc.PDT, {})

	-- 30% Haste 
	sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_15, {hands="Malignance Gloves"})
	sets.engaged.MidAcc.Haste_30 = set_combine(sets.engaged.MidAcc.Haste_15, {ear1="Cessance Earring",})
	sets.engaged.MaxAcc.Haste_30 = set_combine(sets.engaged.MaxAcc.Haste_15, {})
	sets.engaged.Innin.Haste_30 = set_combine(sets.engaged.Innin.Haste_15, { })
	sets.engaged.Innin.MidAcc.Haste_30 = set_combine(sets.engaged.Innin.MidAcc.Haste_15,{})
	sets.engaged.Innin.MaxAcc.Haste_30 = set_combine(sets.engaged.Innin.MaxAcc.Haste_15, {})
	sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.PDT.Haste_15, {})
	sets.engaged.MidAcc.PDT.Haste_30 = set_combine(sets.engaged.MidAcc.PDT.Haste_15, {})
	sets.engaged.MaxAcc.PDT.Haste_30 = set_combine(sets.engaged.MaxAcc.PDT.Haste_15, {})
	sets.engaged.Innin.PDT.Haste_30 = set_combine(sets.engaged.Innin.PDT.Haste_15, {})
	sets.engaged.Innin.MidAcc.PDT.Haste_30 = set_combine(sets.engaged.Innin.MidAcc.PDT.Haste_15, {})
	sets.engaged.Innin.MaxAcc.PDT.Haste_30 = set_combine(sets.engaged.Innin.MaxAcc.PDT.Haste_15, {})

	-- 35% Haste 
	sets.engaged.Haste_35 = set_combine(sets.engaged.Haste_30, {head="Malignance Chapeau",hands="Adhemar Wristbands +1",waist="Sailfi Belt +1"})
	sets.engaged.MidAcc.Haste_35 = set_combine(sets.engaged.MidAcc.Haste_30, {head="Malignance Chapeau",waist="Sailfi Belt +1"})
	sets.engaged.MaxAcc.Haste_35 = set_combine(sets.engaged.MaxAcc.Haste_30, {head="Malignance Chapeau",waist="Sailfi Belt +1"})
	sets.engaged.Innin.Haste_35 = set_combine(sets.engaged.Innin.Haste_30, {head="Malignance Chapeau",waist="Sailfi Belt +1"})
	sets.engaged.Innin.MidAcc.Haste_35 = set_combine(sets.engaged.Innin.MidAcc.Haste_30,{})
	sets.engaged.Innin.MaxAcc.Haste_35 = set_combine(sets.engaged.Innin.MaxAcc.Haste_30,{})
	sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.PDT.Haste_30, {head="Malignance Chapeau",waist="Sailfi Belt +1"})
	sets.engaged.MidAcc.PDT.Haste_35 = set_combine(sets.engaged.MidAcc.PDT.Haste_30, {head="Malignance Chapeau",waist="Sailfi Belt +1"})
	sets.engaged.MaxAcc.PDT.Haste_35 = set_combine(sets.engaged.MaxAcc.PDT.Haste_30, {head="Malignance Chapeau",waist="Sailfi Belt +1"})
	sets.engaged.Innin.PDT.Haste_35 = set_combine(sets.engaged.Innin.PDT.Haste_30, {head="Malignance Chapeau",waist="Sailfi Belt +1"})
	sets.engaged.Innin.MidAcc.PDT.Haste_35 = set_combine(sets.engaged.Innin.MidAcc.PDT.Haste_30,{})
	sets.engaged.Innin.MaxAcc.PDT.Haste_35 = set_combine(sets.engaged.Innin.MaxAcc.PDT.Haste_30,{})

	-- Delay Cap from spell + songs alone
	sets.engaged.MaxHaste = set_combine(sets.engaged.Haste_35, {head="Malignance Chapeau",waist="Sailfi Belt +1"})
	sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MidAcc.Haste_35, {head="Malignance Chapeau",ear1="Dedition Earring",hands="Adhemar Wristbands +1",waist="Sailfi Belt +1",legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}})
	sets.engaged.MaxAcc.MaxHaste = set_combine(sets.engaged.MaxAcc.Haste_35, {head="Malignance Chapeau",ear1="Dedition Earring",hands="Adhemar Wristbands +1",waist="Sailfi Belt +1",legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}})
	sets.engaged.Innin.MaxHaste     = set_combine(sets.engaged.Innin.Haste_35, {})
	sets.engaged.Innin.MidAcc.MaxHaste = set_combine(sets.engaged.Innin.MidAcc.Haste_35, {})
	sets.engaged.Innin.MaxAcc.MaxHaste = set_combine(sets.engaged.Innin.MaxAcc.Haste_35, {})
	sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.PDT.Haste_35, {})
	sets.engaged.MidAcc.PDT.MaxHaste = set_combine(sets.engaged.MidAcc.PDT.Haste_35, {})
	sets.engaged.MaxAcc.PDT.MaxHaste = set_combine(sets.engaged.MaxAcc.PDT.Haste_35, {})
	sets.engaged.Innin.PDT.MaxHaste = set_combine(sets.engaged.Innin.PDT.Haste_35, {})
	sets.engaged.Innin.MidAcc.PDT.MaxHaste = set_combine(sets.engaged.Innin.MidAcc.PDT.Haste_35, {})
	sets.engaged.Innin.MaxAcc.PDT.MaxHaste = set_combine(sets.engaged.Innin.MaxAcc.PDT.Haste_35, {})

	sets.buff.Migawari = {} --{body="Hattori Ningi +1"}

	-- Weaponskills 
	sets.precast.WS = {ammo="Aurgelmir Orb +1",
		head="Mpaca's Cap",neck="Ninja Nodowa +2",ear1="Moonshade Earring",ear2="Odr Earring",
		body="Mpaca's Doublet",hands="Mpaca's Gloves",ring1="Regal Ring",ring2="Ephramad's Ring",
		back=Andartia.DA,waist="Sailfi Belt +1",legs="Mochi. Hakama +3",feet="Hattori Kyahan +2"}

	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, { })
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS.MidAcc, {})
	sets.precast.WS.PDT = set_combine(sets.precast.WS,{body="Hattori Ningi +2",hands="Nyame Gauntlets",ring2="Defending Ring",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- BLADE: KAMU- STR:60% INT:60%
	sets.Kamu = set_combine(sets.precast.WS, {head="Hachiya Hatsuburi +3",ear1="Lugra Earring +1",ear2="Hattori Earring +1",hands="Adhemar Wrist. +1",ring1="Sroda Ring",ring2="Gere Ring",legs="Mpaca's Hose",legs="Nyame Flanchard",feet="Nyame Sollerets"})
	sets.precast.WS['Blade: Kamu'] = sets.Kamu
	sets.precast.WS['Blade: Kamu'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.Kamu)
	sets.precast.WS['Blade: Kamu'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.Kamu, {})
	sets.precast.WS['Blade: Kamu'].PDT = set_combine(sets.precast.WS['Blade: Kamu'].MidAcc, {body="Hattori Ningi +2",hands="Nyame Gauntlets",ring2="Defending Ring",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- BLADE: METSU- DEX 80%
	sets.Metsu = set_combine(sets.precast.WS, {head="Hachiya Hatsuburi +3",neck="Rep. Plat. Medal",ear1="Lugra Earring +1",ear2="Hattori Earring +1",hands="Adhemar Wrist. +1",ring2="Gere Ring",legs="Mochizuki Hakama +3"})
	sets.precast.WS['Blade: Metsu'] = sets.Metsu
	sets.precast.WS['Blade: Metsu'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.Metsu)
	sets.precast.WS['Blade: Metsu'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.Metsu, {})
	sets.precast.WS['Blade: Metsu'].PDT = set_combine(sets.precast.WS['Blade: Metsu'].MidAcc, {body="Hattori Ningi +2",hands="Nyame Gauntlets",ring2="Defending Ring",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- BLADE: SHUN- Dex 85%
	sets.Shun = set_combine(sets.precast.WS, {ammo="Crepuscular Pebble",neck="Fotia Gorget",ear2="Hattori Earring +1",body="Malignance Tabard",hands="Malignance Gloves",ring2="Gere Ring",waist="Fotia Belt",legs="Jokushu Haidate"})
	sets.precast.WS['Blade: Shun'] = sets.Shun
	sets.precast.WS['Blade: Shun'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.Shun)
	sets.precast.WS['Blade: Shun'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.Shun, {})
	sets.precast.WS['Blade: Shun'].PDT = set_combine(sets.precast.WS['Blade: Shun'].MidAcc, {body="Hattori Ningi +2",hands="Nyame Gauntlets",ring2="Defending Ring",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- BLADE: JIN- STR:30% DEX:30%
	sets.Jin = set_combine(sets.precast.WS, {head=AdhemarHead.B,neck="Fotia Gorget",hands="Ryuo Tekko +1",ring1="Epona's Ring",ring2="Gere Ring",waist="Fotia Belt",legs="Mpaca's Hose"})
	sets.precast.WS['Blade: Jin'] = sets.Jin
	sets.precast.WS['Blade: Jin'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.Jin)
	sets.precast.WS['Blade: Jin'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.Jin, {})
	sets.precast.WS['Blade: Jin'].PDT = set_combine(sets.precast.WS['Blade: Jin'].MidAcc, {body="Hattori Ningi +2",hands="Nyame Gauntlets",ring2="Defending Ring",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- BLADE: HI- AGI:80% 
	sets.Hi = set_combine(sets.precast.WS, {head="Hachiya Hatsuburi +3",body="Nyame Mail",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Gere Ring"})
	sets.precast.WS['Blade: Hi'] = sets.Hi
	sets.precast.WS['Blade: Hi'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.Hi)
	sets.precast.WS['Blade: Hi'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.Hi, {})
	sets.precast.WS['Blade: Hi'].PDT = set_combine(sets.precast.WS['Blade: Hi'].MidAcc, {body="Hattori Ningi +2",hands="Nyame Gauntlets",ring2="Defending Ring",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- BLADE: RIN- STR:60% DEX:60%
	sets.Rin = set_combine(sets.precast.WS, { })
	sets.precast.WS['Blade: Rin'] = sets.Rin
	sets.precast.WS['Blade: Rin'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.Rin)
	sets.precast.WS['Blade: Rin'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.Rin, {})
	sets.precast.WS['Blade: Rin'].PDT = set_combine(sets.precast.WS['Blade: Rin'].MidAcc, {body="Hattori Ningi +2",hands="Nyame Gauntlets",ring2="Defending Ring",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- BLADE: KU- STR:30% DEX:30%
	sets.Ku = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",body="Mpaca's Doublet",hands="Mochizuki Tekko +3",ring1="Regal Ring",ring2="Gere Ring",waist="Fotia Belt",legs="Mpaca's Hose"})
	sets.precast.WS['Blade: Ku'] = sets.Ku
	sets.precast.WS['Blade: Ku'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.Ku)
	sets.precast.WS['Blade: Ku'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.Ku, {})
	sets.precast.WS['Blade: Ku'].PDT = set_combine(sets.precast.WS['Blade: Ku'].MidAcc, {body="Hattori Ningi +2",hands="Nyame Gauntlets",ring2="Defending Ring",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- BLADE: TEN- STR:30% DEX:30%
	sets.Ten = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",head="Hachiya Hatsuburi +3",neck="Rep. Plat. Medal",ear2="Lugra Earring +1",body="Nyame Mail",hands="Mochizuki Tekko +3",ring1="Regal Ring",ring2="Epaminondas's Ring",waist="Sailfi Belt +1",legs="Mochizuki Hakama +3"})
	sets.precast.WS['Blade: Ten'] = sets.Ten
	sets.precast.WS['Blade: Ten'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.Ten)
	sets.precast.WS['Blade: Ten'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.Ten, {})
	sets.precast.WS['Blade: Ten'].PDT = set_combine(sets.precast.WS['Blade: Ten'].MidAcc, {body="Hattori Ningi +2",hands="Nyame Gauntlets",ring2="Defending Ring",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- BLADE: CHI- STR:30% INT:30% 
	sets.Chi = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
		head="Mochi. Hatsuburi +3",neck="Fotia Gorget",ear2="Lugra Earring +1",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gere Ring",ring2="Epaminondas's Ring",
		waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"})
	sets.precast.WS['Blade: Chi'] = sets.Chi
	sets.precast.WS['Blade: Chi'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.Chi)
	sets.precast.WS['Blade: Chi'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.Chi, {})
	sets.precast.WS['Blade: Chi'].PDT = set_combine(sets.precast.WS['Blade: Chi'].MidAcc, {})

	-- BLADE: To- STR:40% INT:40% 
	sets.To = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
		head="Mochi. Hatsuburi +3",neck="Fotia Gorget",ear2="Lugra Earring +1",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gere Ring",
		waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"})
	sets.precast.WS['Blade: To'] = sets.To
	sets.precast.WS['Blade: To'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.To)
	sets.precast.WS['Blade: To'].MaxAcc = set_combine(sets.precast.WS.Acc, sets.To, {})
	sets.precast.WS['Blade: To'].PDT = set_combine(sets.precast.WS['Blade: To'].MidAcc, {})

	sets.precast.WS['Blade: Teki'] = sets.precast.WS['Blade: Chi']  -- STR:30% INT:30%
	sets.precast.WS['Blade: Teki'].PDT = set_combine(sets.precast.WS['Blade: Teki'], {body="Hattori Ningi +2",hands="Nyame Gauntlets",legs="Hattori Hakama +2",feet="Hattori Kyahan +2"})

	-- SAVAGE BLADE- STR 50%; MND 50% 
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",head="Hattori Zukin +2",neck="Rep. Plat. Medal",ear2="Lugra Earring +1",body="Hattori Ningi +2",hands="Nyame Gauntlets",waist="Prosilio Belt +1",legs="Nyame Flanchard"}) 
	sets.precast.WS['Savage Blade'].PDT = set_combine(sets.precast.WS['Savage Blade'], {})

	-- AEOLIAN EDGE- DEX:40%; INT:40% 
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {head="Mochi. Hatsuburi +3"})
	sets.precast.WS['Aeolian Edge'].PDT = set_combine(sets.precast.WS['Aeolian Edge'], {hands="Nyame Gauntlets",ring2="Defending Ring"})

	-- EVISCERATION: DEX:50% 
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {head="Blistering Sallet +1",body="Mpaca's Doublet",hands="Ryuo Tekko +1",waist="Fotia Belt",legs="Mpaca's Hose"})
	sets.precast.WS['Evisceration'].PDT = set_combine(sets.precast.WS['Evisceration'], {hands="Nyame Gauntlets",ring2="Defending Ring"})

end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = true
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if (spell.type == 'WeaponSkill' or spell.skill == "Ninjutsu") and (buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] or buffactive['Sleep']) then
		cancel_spell()
		eventArgs.cancel = true
	end
	if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
		eventArgs.cancel = true
	end
	if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' and spellMap ~= "Utsusemi" then
		if spell.english == "Migawari" then
			classes.CustomClass = "Migawari"
		else
			classes.CustomClass = "SelfNinjutsu"
		end
	end
--	if spell.name == 'Spectral Jig' and buffactive.sneak then
--	If sneak is active when using, cancel before completion
--		send_command('cancel 71')
--	end
--	if string.find(spell.english, 'Utsusemi') then
--		if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
--			--cancel_spell()
--			eventArgs.cancel = true
--			return
--		end
--	end
	if spell.name == 'Provoke' or spell.name == 'Yonin' then
		equip(sets.precast.Enmity)
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
	-- Ranged Attacks 
	if spell.action_type == 'Ranged Attack' and state.OffenseMode ~= 'MaxAcc' then
		equip( sets.SangeAmmo )
	end
	-- protection for lag
	if spell.name == 'Sange' and player.equipment.ammo == gear.RegularAmmo then
		state.Buff.Sange = false
		eventArgs.cancel = true
	end
	if spell.type == 'WeaponSkill' then
		if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
			equip(sets.TreasureHunter)
		end
		-- Mecistopins Mantle rule (if you kill with ws)
		if state.CapacityMode.value then
			equip(sets.CapacityMantle)
		end
		-- Gavialis Helm rule
		--if is_sc_element_today(spell) then
		--   if wsList:contains(spell.english) then
				-- do nothing
		--	else
		--		equip(sets.WSDayBonus)
		--	end
		--end
		-- Lugra Earring for some WS
		if LugraWSList:contains(spell.english) then
			if world.time >= (17*60) or world.time <= (7*60) then
				equip(sets.Lugra)
			end
		end
		if player.tp >= 2500 then
			equip(sets.Lugra)
		end
		if SrodaWS1List:contains(spell.english) then
			equip(sets.SrodaWS1)
		end
		if SrodaWS2List:contains(spell.english) then
			equip(sets.SrodaWS2)
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
--	if nukeList:contains(spell.english) then
--		if spell.english == "Monomi: Ichi" then
--			if buffactive['Sneak'] then
--				send_command('@wait 2.7;cancel sneak')
--			end
--		end
--	end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	--if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
	--	equip(sets.TreasureHunter)
	--end
	if nukeList:contains(spell.english) and state.BurstMode.value then
		equip(sets.Burst)
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if midaction() then
		return
	end
	-- Aftermath timer creation
	aw_custom_aftermath_timers_aftercast(spell)
	--if spell.type == 'WeaponSkill' then
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
	check_gear()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.hpp < 80 then
		idleSet = set_combine(idleSet, sets.idle.Regen)
	end
	--	if state.CraftingMode then
	--		idleSet = set_combine(idleSet, sets.crafting)
	--	end
	if state.HybridMode.value == 'PDT' then
		if state.Buff.Migawari then
			idleSet = set_combine(idleSet, sets.buff.Migawari)
		else
			idleSet = set_combine(idleSet, sets.idle.PDT)
		end
	--elseif state.HybridMode.value == 'MDT' then
	--	if state.Buff.Migawari then
	--		idleSet = set_combine(idleSet, sets.buff.Migawari)
	--	else 
	--		idleSet = set_combine(idleSet, sets.idle.MDT)
	--	end
	else
		idleSet = set_combine(idleSet, select_movement())
	end
	--local res = require('resources')
	--local info = windower.ffxi.get_info()
	--local zone = res.zones[info.zone].name
	--	if zone:match('Adoulin') then
	--	idleSet = set_combine(idleSet, sets.Adoulin)
	--	end
	if buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane'] then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)	
	if state.CapacityMode.value then
		meleeSet = set_combine(meleeSet, sets.CapacityMantle)
	end
	if state.Buff.Migawari and state.HybridMode.value == 'PDT' then
		meleeSet = set_combine(meleeSet, sets.buff.Migawari)
	end
	if buffactive['Innin'] then
		meleeSet = set_combine(meleeSet, {head=InninHead})
	end
	if buffactive['Yonin'] then
		meleeSet = set_combine(meleeSet, {legs=YoninLegs})
	end

	--	if state.HybridMode.value == 'Proc' then
	--		meleeSet = set_combine(meleeSet, sets.NoDW)
	--	end
	meleeSet = set_combine(meleeSet, select_ammo())
	if buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane'] then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

	if state.Buff[buff] ~= nil then
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end

	if S{'madrigal'}:contains(buff:lower()) then
		if buffactive.madrigal and state.OffenseMode.value == 'MaxAcc' then
			equip(sets.MadrigalBonus)
		end
	end
	if (buff == 'Innin' and gain or buffactive['Innin']) then
		state.CombatForm:set('Innin')
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	else
		state.CombatForm:reset()
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end

	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
		determine_haste_group()
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end

end

function job_status_change(newStatus, oldStatus, eventArgs)
	if newStatus == 'Engaged' then
		update_combat_form()
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


--mov = {counter=0}
--if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
--	mov.x = windower.ffxi.get_mob_by_index(player.index).x
--	mov.y = windower.ffxi.get_mob_by_index(player.index).y
--	mov.z = windower.ffxi.get_mob_by_index(player.index).z
--end
--moving = false
--windower.raw_register_event('prerender',function()
--	mov.counter = mov.counter + 1;
--	if mov.counter>15 then
--		local pl = windower.ffxi.get_mob_by_index(player.index)
--		if pl and pl.x and mov.x then
--			dist = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 )
--			if dist > 1 and not moving then
--				state.Moving.value = true
--				send_command('gs c update')
--				moving = true
--			elseif dist < 1 and moving then
--				state.Moving.value = false
--				--send_command('gs c update')
--				moving = false
--			end
--		end
--		if pl and pl.x then
--			mov.x = pl.x
--			mov.y = pl.y
--			mov.z = pl.z
--		end
--		mov.counter = 0
--	end
--end)

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	-- local res = require('resources')
	-- local info = windower.ffxi.get_info()
	-- local zone = res.zones[info.zone].name
	--	if state.Moving.value == true then
	--		if zone:match('Adoulin') then
	--			equip(sets.Adoulin)
	--		end
	--		equip(select_movement())
	--	end
	select_ammo()
	--determine_haste_group()
	update_combat_form()
	run_sj = player.sub_job == 'RUN' or false
	--select_movement()
	th_update(cmdParams, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
		eventArgs.handled = true
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
		then
			return true
	end
end

function select_movement()
	-- world.time is given in minutes into each day
	-- 7:00 AM would be 420 minutes
	-- 17:00 PM would be 1020 minutes
	if state.Kiting.value then
		if world.time >= (17*60) or world.time <= (7*60) then
			return sets.NightMovement
		else
			return sets.DayMovement
		end
	end
end

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

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if stateField == 'Capacity Point Mantle' then
		gear.Back = newValue
	--elseif stateField == 'Proc' then
		--send_command('@input /console gs enable all')
	--    equip(sets.Proc)
		--send_command('@input /console gs disable all')
	elseif stateField == 'unProc' then
		send_command('@input /console gs enable all')
		equip(sets.unProc)
	elseif stateField == 'Runes' then
	local msg = ''
		if newValue == 'Ignis' then
			msg = msg .. 'Increasing resistence against ICE and deals FIRE damage.'
		elseif newValue == 'Gelus' then
			msg = msg .. 'Increasing resistence against WIND and deals ICE damage.'
		elseif newValue == 'Flabra' then
			msg = msg .. 'Increasing resistence against EARTH and deals WIND damage.'
		elseif newValue == 'Tellus' then
			msg = msg .. 'Increasing resistence against LIGHTNING and deals EARTH damage.'
		elseif newValue == 'Sulpor' then
			msg = msg .. 'Increasing resistence against WATER and deals LIGHTNING damage.'
		elseif newValue == 'Unda' then
			msg = msg .. 'Increasing resistence against FIRE and deals WATER damage.'
		elseif newValue == 'Lux' then
			msg = msg .. 'Increasing resistence against DARK and deals LIGHT damage.'
		elseif newValue == 'Tenebrae' then
			msg = msg .. 'Increasing resistence against LIGHT and deals DARK damage.'
		end
		add_to_chat(123, msg)
	--	elseif stateField == 'moving' then
	--		if state.Moving.value then
	--			local res = require('resources')
	--			local info = windower.ffxi.get_info()
	--			local zone = res.zones[info.zone].name
	--			if zone:match('Adoulin') then
	--				equip(sets.Adoulin)
	--			end
	--		equip(select_movement())
	--	end

	elseif stateField == 'Use Rune' then
		send_command('@input /ja '..state.Runes.value..' <me>')
	elseif stateField == 'Use Warp' then
		add_to_chat(8, '------------WARPING-----------')
		--equip({ring1="Warp Ring"})
		send_command('input //gs equip sets.Warp;@wait 10.0;input /item "Warp Ring" <me>;')
	end
end

--- Custom spell mapping.
--function job_get_spell_map(spell, default_spell_map)
--	if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
--		return 'HighTierNuke'
--	end
--end
-- Creating a custom spellMap, since Mote capitalized absorbs incorrectly
function job_get_spell_map(spell, default_spell_map)
	if spell.type == 'Trust' then
		return 'Trust'
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	if state.HybridMode.has_value then
		hm_msg = state.HybridMode.value
	else
		hm_msg = 'Normal'
	end
	if state.OffenseMode.has_value then
		om_msg = state.OffenseMode.value
	else
		om_msg = 'Normal'
	end
	if state.WeaponskillMode.has_value then
		wm_msg = state.WeaponskillMode.value
	else
		wm_msg = 'Normal'
	end
	if state.BurstMode.value then
		bm_msg = 'On'
	else
		bm_msg = 'Off'
	end
	if state.HasteMode.has_value then
		haste_msg = state.HasteMode.value
	else
		haste_msg = 'Normal'
	end

--	if state.HybridMode.has_value then
--		hm_msg = state.HybridMode.value
--	end
	if state.TreasureMode.has_value then
		tm_msg = state.TreasureMode.value
	else
		tm_msg = 'Off'
	end
--	if state.ElementalResist.value then
--		er_msg = 'On'
--	else
--		er_msg = 'Off'
--	end

	local msg = ''
	if state.Kiting.value then
		msg = msg .. ' Kiting: On'
	else 
		msg = msg .. ' Kiting: Off'
	end

	add_to_chat(string.char(31,210).. 'HybridMode: ' ..string.char(31,001)..hm_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' OffenseMode: ' ..string.char(31,001)..om_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' WeaponskillMode: ' ..string.char(31,001)..wm_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' BurstMode: ' ..string.char(31,001)..bm_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' HasteMode: ' ..string.char(31,001)..haste_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' TreasureMode: ' ..string.char(31,001)..tm_msg.. string.char(31,002)..  ' |'
		..string.char(31,002)..msg)

	eventArgs.handled = true
	
end




-- Call from job_precast() to setup aftermath information for custom timers.
function aw_custom_aftermath_timers_precast(spell)
	if spell.type == 'WeaponSkill' then
		info.aftermath = {}

		local empy_ws = "Blade: Hi"

		info.aftermath.weaponskill = empy_ws
		info.aftermath.duration = 0

		info.aftermath.level = math.floor(player.tp / 1000)
		if info.aftermath.level == 0 then
			info.aftermath.level = 1
		end

		if spell.english == empy_ws and player.equipment.main == 'Kannagi' then
			-- nothing can overwrite lvl 3
			if buffactive['Aftermath: Lv.3'] then
				return
			end
			-- only lvl 3 can overwrite lvl 2
			if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
				return
			end

			-- duration is based on aftermath level
			info.aftermath.duration = 30 * info.aftermath.level
		end
	end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
	-- prevent gear being locked when it's currently impossible to cast 
	if not spell.interrupted and spell.type == 'WeaponSkill' and
		info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

		local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
		send_command('timers d "Aftermath: Lv.1"')
		send_command('timers d "Aftermath: Lv.2"')
		send_command('timers d "Aftermath: Lv.3"')
		send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

		info.aftermath = {}
	end
end

function select_ammo()
	if state.Buff.Sange then
		return sets.SangeAmmo
	else
		return sets.RegularAmmo
	end
end

-- function select_ws_ammo()
--	if world.time >= (18*60) or world.time <= (6*60) then
--		return sets.NightAccAmmo
--	else
--		return sets.DayAccAmmo
--	end
--	end

function update_combat_form()
	if state.Buff.Innin then
		state.CombatForm:set('Innin')
	else
		state.CombatForm:reset()
	end
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
set_macros(5,13)

function set_style(sheet)
	send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(9)
