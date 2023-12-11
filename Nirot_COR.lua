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

    state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Light Shot','Dark Shot'}
    state.MainWS = M{['description']='Main WS', 'Leaden Salute','Savage Blade'}
    --state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(false, 'Select Quick Draw Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')
	
	state.Kiting = M(true, 'Kiting')
    state.HasteMode = M{['description']='Haste Mode', 'Hi', 'Normal'}
    state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Doom'] = buffactive['doom'] or false
	state.Buff['Bane'] = buffactive['bane'] or false
    state.Buff['Terror'] = buffactive['terror'] or false
    state.Buff['Stun'] = buffactive['stun'] or false
    state.Buff['Petrification'] = buffactive['petrification'] or false
	state.CursnaGear = M(true, 'CursnaGear')
	
	-- /run sj
    state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
    state.UseRune = M(false, 'Use Rune')
    run_sj = player.sub_job == 'RUN' or false

    state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Damage'}
    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
      "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
      "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Liv. Bul. Pouch"}
    elemental_ws = S{"Aeolian Edge", "Leaden Salute", "Wildfire"}
    no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}
	oneHList = S{'empty','Nusku Shield'}

    define_roll_values()

    -- Whether a warning has been given for low ammo
    state.warned = M(false)
    options.ammo_warning_limit = 25
	
    include('Mote-TreasureHunter')
    --state.TreasureMode:set('None')	
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
--    state.IdleMode:options('Normal', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'MidAcc', 'MaxAcc','PDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.BurstMode = M(false, 'BurstMode')
	
    Haste = 0
    DW_needed = 0
    DW = true
    moving = false
    update_combat_form()
    --determine_haste_group()
	--MainQD = 'Fire Shot'

    gear.RAbullet = "Chrono Bullet"
    gear.RAccbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Living Bullet"
    options.ammo_warning_limit = 10

    send_command('bind ^= gs c cycle treasuremode')
    --send_command('bind ^[ gs c toggle UseWarp')
    --send_command('bind ![ input /lockstyle off')
    --send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c cycle HasteMode')
	send_command('bind ^backspace gs c cycle CursnaGear')
    send_command('bind numpad. gs c cycle HybridMode')
    send_command('bind numpad0 gs c cycle QDMode')
	send_command('bind numpad1 gs c qdmain')  -- if you bind state.Mainqd.value here it never updates when you cycle it. So instead we bind to a function 
	send_command('bind numpad2 gs c qdalt')
    send_command('bind numpad3 gs c cycle OffenseMode')
	send_command('bind numpad4 gs c wsmain')
    send_command('bind numpad5 gs c cycle MainWS')
    send_command('bind numpad6 gs c cycle WeaponskillMode')
    send_command('bind numpad7 gs c toggle LuzafRing')
    send_command('bind numpad8 gs c cycle Mainqd')
    send_command('bind numpad9 gs c cycle Altqd')
	
	
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
	send_command('unbind ^backspace')
	send_command('unbind numpad0')
	send_command('unbind numpad1')
	send_command('unbind numpad2')
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind numpad5')
	send_command('unbind numpad6')	
	send_command('unbind numpad7')	
	send_command('unbind numpad8')	
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
    
    HercFeet = {}
    HercHead = {}
    HercLegs = {}
    HercBody = {}
    HercHands = {}

    HercHands.WSD = { name="Herculean Gloves", augments={'MND+14','STR+10','Weapon skill damage +7%','Mag. Acc.+17 "Mag.Atk.Bns."+17',} }
	HercHands.Waltz = { name="Herculean Gloves", augments={'Chance of successful block +1','"Waltz" potency +10%','"Store TP"+1','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	HercHands.FC = { name="Herculean Gloves", augments={'Pet: "Mag.Atk.Bns."+20','STR+7','"Fast Cast"+8','Accuracy+15 Attack+15',}}

    HercFeet.TP = {} --{ name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','DEX+8',}}
	HercFeet.FC = { name="Herculean Boots", augments={'"Fast Cast"+6','INT+4','Mag. Acc.+1','"Mag.Atk.Bns."+10',}}

    HercBody.WSD = { name="Herculean Vest", augments={'MND+15','"Store TP"+2','Weapon skill damage +8%',} } 
	HercBody.Phalanx = { name="Herculean Vest", augments={'Mag. Acc.+19','Magic dmg. taken -1%','Phalanx +5',}}
    
	HercHead.TH = { name="Herculean Helm", augments={'"Store TP"+1','"Avatar perpetuation cost" -1','"Treasure Hunter"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	HercHead.Phalanx = { name="Herculean Helm", augments={'Pet: INT+6','Weapon skill damage +1%','Phalanx +4',}}
	HercHead.FC = { name="Herculean Helm", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Accuracy+3','"Fast Cast"+7',}}
	
	HercLegs.WSD = { name="Herculean Trousers", augments={'Spell interruption rate down -7%','MND+13','Weapon skill damage +9%','Mag. Acc.+3 "Mag.Atk.Bns."+3',} }
	HercLegs.Phalanx = { name="Herculean Trousers", augments={'Mag. Acc.+15','Phalanx +4','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
	HercLegs.FC = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+18','"Fast Cast"+6','INT+10','Mag. Acc.+12',}}

    TaeonHands = {}
    TaeonHands.Snap = {} --{name="Taeon Gloves", augments={'"Snapshot"+5', 'Attack+22','"Snapshot"+5'}}
    
    TaeonHead = {}
    TaeonHead.Snap = {} --{ name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Snapshot"+5','"Snapshot"+4',}}
	Nyame = {head="Nyame Helm",body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	
	Camulus = {}
	Camulus.DW = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Damage taken-5%',}}
	Camulus.WSDMagi = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	
	sets.idle = {
        head="Nyame Helm",neck="Warder's Charm +1",ear1="Sanare Earring",ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
	    body="Chasseur's Frac +3",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Chirich Ring +1",
	    back=Camulus.DW,waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.idle.PDT = set_combine(sets.idle, {})
	sets.idle.Normal = sets.idle
    sets.idle.Regen = {}
	sets.resting = sets.idle

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +3"} -- Chasseur's Frac +3 increases proc rate by 12% 
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"} -- Lanun Trews +3 gives Snake Eye a 4% chance of having no recast per merit level, for a maximum of a 20% chance. 
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"} -- There is an equal 1/6 possibility of each of the six results. This probability is skewed upwards by utilizing Commodore Bottes +2 or any of the versions of Lanun Bottes 1/2/3
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"} -- Occasionally allows Random Deal to restore two used Job Abilities. (~50% of the time) 
	
	sets.precast.CorsairRoll = set_combine(sets.idle.PDT,{head="Lanun Tricorne +3",neck="Regal Necklace",hands="Chasseur's Gants +3",ring2="Gelatinous Ring +1",back=Camulus.DW,legs="Desultor Tassets"})
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +2"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})

    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}
	
	sets.precast.Waltz = {
	    body="Passion Jacket",hands=HercHands.Waltz,waist="Flume Belt +1",Legs="Dashing Subligar",Feet="Rawhide Boots"}	
    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Step = {}
	
	sets.buff.Doom = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar Sash"} --{ring2="Saida Ring"}
	sets.buff.Curse = sets.buff.Doom
	sets.Phalanx = {head=HercHead.Phalanx,body=HercBody.Phalanx,legs=HercLegs.Phalanx}
    sets.TreasureHunter = {head=HercHead.TH}

    sets.precast.FC = {
        head=HercHead.FC,neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Etiolation Earring",
        body={ name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}},hands=HercHands.FC,ring1="Kishar Ring",ring2="Rahab Ring",
        legs=HercLegs.FC,feet=HercFeet.FC}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})
	
	sets.precast.RA = {ammo=gear.RAbullet,
		head="Chass. Tricorne +3",neck="Comm. Charm +2",
		body="Laksa. Frac +3",hands="Lanun Gants +3",waist="Yemaya Belt",legs="Adhemar Kecks +1"}
	sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {})
	
	
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo=gear.RAbullet ,
        head="Malignance Chapeau",neck="Combatant's Torque",ear1="Odr Earring",ear2="Moonshade Earring",
	    body="Laksa. Frac +3",hands="Meghanada Gloves +2",ring1="Epaminondas's Ring",ring2="Ephramad's Ring",
	    back=Camulus.WSDMagi,waist="K. Kachina Belt +1",legs=HercLegs.WSD,feet="Lanun Bottes +3"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS,{
		neck="Fotia Gorget",
		body="Laksa. Frac +3",ring1="Regal Ring",
		waist="Fotia Belt",legs=HercLegs.WSD})
    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})
	
	sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
        head="Nyame Helm",neck="Comm. Charm +2",ear1="Friomisi Earring",ear2="Crematio Earring",
	    body="Lanun Frac +3",hands="Chasseur's Gants +3",ring1="Dingir Ring",ring2="Epaminondas's Ring",
	    back=Camulus.WSDMagi,waist="Orpheus's Sash",legs=HercLegs.WSD,feet="Lanun Bottes +3"}
    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {head="Pixie Hairpin +1",ear2="Moonshade Earring",hands="Nyame Gauntlets",ring2="Archon Ring",waist="Orpheus's Sash",legs="Nyame Flanchard"})
	sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
	
	sets.precast.WS['Evisceration'] = {}
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {head="Nyame Helm",neck="Rep. Plat. Medal",body="Nyame Mail",ring1="Regal Ring",waist="Sailfi Belt +1",legs="Nyame Flanchard"})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Swift Blade'].Acc = set_combine(sets.precast.WS['Swift Blade'], {})
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Swift Blade'], {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {})
	
    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.SpellInterrupt = {}
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
    sets.midcast.Cure = {}
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
    sets.midcast.CorsairShot = {ammo=gear.MAbullet,
        head="Nyame Helm",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
	    body="Mirke Wardecors",hands="Carmine Fin. Ga. +1",ring1="Dingir Ring",ring2="Ilabrat Ring",
	    back=Camulus.WSDMagi,waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    sets.midcast.CorsairShot.STP = set_combine(sets.midcast.CorsairShot, {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Telos Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Crepuscular Ring",ring2="Chirich Ring +1",
		waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"})
    sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot, {})
    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Dingir Ring",ring2="Ilabrat Ring",
		back=Camulus.DW,waist="Yemaya Belt",legs="Chasseur's Culottes +3",feet="Malignance Boots"}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})
    sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {})
    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {})
    sets.midcast.RA.STP = set_combine(sets.midcast.RA, {})
    sets.TripleShot = {body="Chasseur's Frac +3"} --27
    sets.TripleShotCritical = {body="Chasseur's Frac +3"}
    sets.TrueShot = {}

    sets.idle.Refresh = set_combine(sets.idle, {})
    sets.Kiting = {ring2="Shneddick Ring +1"}


    sets.engaged = {
        head="Chass. Tricorne +3",neck="Combatant's Torque",ear1="Telos Earring",ear2="Mache Earring +1",
	    body="Malignance Tabard",hands="Gazu Bracelets +1",ring1="Ephramad's Ring",ring2="Chirich Ring +1",
	    waist="Kentarch Belt +1",legs="Chasseur's Culottes +3",feet="Malignance Boots"}
    sets.engaged.LowAcc = set_combine(sets.engaged, {})
    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {ring2="Cacoethic Ring +1"})
    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {ear1="Dominance Earring +1"})
    sets.engaged.STP = set_combine(sets.engaged, {})

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = set_combine(sets.engaged,{ear1="Eabani Earring",waist="Reiki Yotai",legs="Carmine Cuisses +1"}) -- 48%
    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {})
    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {})
    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {ring2="Cacoethic Ring +1"})
    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {})

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.Haste_15 = set_combine(sets.engaged,{ear1="Eabani Earring",waist="Reiki Yotai",legs="Carmine Cuisses +1"}) -- 42%
    sets.engaged.DW.LowAcc.Haste_15 = set_combine(sets.engaged.DW.Haste_15, {})
    sets.engaged.DW.MidAcc.Haste_15 = set_combine(sets.engaged.DW.LowAcc.Haste_15, {})
    sets.engaged.DW.HighAcc.Haste_15 = set_combine(sets.engaged.DW.MidAcc.Haste_15, {ring2="Cacoethic Ring +1"})
    sets.engaged.DW.STP.Haste_15 = set_combine(sets.engaged.DW.Haste_15, {})

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.Haste_30 = set_combine(sets.engaged,{ear1="Eabani Earring",waist="Reiki Yotai",legs="Carmine Cuisses +1"}) -- 31%
    sets.engaged.DW.LowAcc.Haste_30 = set_combine(sets.engaged.DW.Haste_30, {})
    sets.engaged.DW.MidAcc.Haste_30 = set_combine(sets.engaged.DW.LowAcc.Haste_30, {})
    sets.engaged.DW.HighAcc.Haste_30 = set_combine(sets.engaged.DW.MidAcc.Haste_30, {ring2="Cacoethic Ring +1"})
    sets.engaged.DW.STP.Haste_30 = set_combine(sets.engaged.DW.Haste_30, {})

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.Haste_35 = set_combine(sets.engaged,{ear1="Eabani Earring",waist="Reiki Yotai",legs="Carmine Cuisses +1"}) -- 27%
    sets.engaged.DW.LowAcc.Haste_35 = set_combine(sets.engaged.DW.Haste_35, {})
    sets.engaged.DW.MidAcc.Haste_35 = set_combine(sets.engaged.DW.LowAcc.Haste_35, {})
    sets.engaged.DW.HighAcc.Haste_35 = set_combine(sets.engaged.DW.MidAcc.Haste_35, {ring2="Cacoethic Ring +1"})
    sets.engaged.DW.STP.Haste_35 = set_combine(sets.engaged.DW.Haste_35, {})

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = set_combine(sets.engaged,{ear1="Eabani Earring",waist="Reiki Yotai",legs="Carmine Cuisses +1"}) -- 11%
    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {})
    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {})
    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {ring2="Cacoethic Ring +1"})
    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {})

    sets.DefaultShield = {sub="Nusku Shield"}

end


function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
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

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
--        if player.status ~= 'Engaged' and state.WeaponLock.value == false then
--            equip(sets.precast.CorsairRoll.Duration)
--        end
        if state.LuzafRing.value then
            equip(sets.precast.LuzafRing)
        end
    end
    if spell.action_type == 'Ranged Attack' then
        special_ammo_check()
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
    elseif spell.type == 'WeaponSkill' then
        if spell.skill == 'Marksmanship' then
            special_ammo_check()
        end
        -- Replace TP-bonus gear if not needed.
        if spell.english == 'Leaden Salute' or spell.english == 'Aeolian Edge' and player.tp > 2900 then
            equip(sets.FullTP)
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
    if spell.type == 'CorsairShot' then
        if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
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
            if state.QDMode.value == 'Damage' then
                equip(sets.midcast.CorsairShot)
            elseif state.QDMode.value == 'STP' then
                equip(sets.midcast.CorsairShot.STP)
            end
        end
    elseif spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
                if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                    equip(sets.TrueShot)
                end
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
            if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                equip(sets.TrueShot)
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and not spell.interrupted then
        display_roll_info(spell)
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
    --if player.status ~= 'Engaged' and state.WeaponLock.value == false then
    --    check_weaponset()
    --end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            --add_to_chat(122, "Flurry status cleared.")
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

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end
end

-- Handle notifications of general user state change.
--function job_state_change(stateField, newValue, oldValue)
--    if state.WeaponLock.value == true then
--        disable('ranged')
--    else
--        enable('ranged')
--    end
--
--    check_weaponset()
--end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
--    determine_haste_group()
--    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if oneHList:contains(player.equipment.sub) then
		DW = false
		state.CombatForm:reset()
	else
		DW = true
		state.CombatForm:set('DW')
	end
end
	
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
--    check_weaponset()
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		meleeSet = set_combine(meleeSet,sets.buff.Doom)
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
--    if player.hpp < 80 then
--        idleSet = set_combine(idleSet, sets.idle.Regen)
--    end
    -- if state.CraftingMode then
    --     idleSet = set_combine(idleSet, sets.crafting)
    -- end
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
    --    idleSet = set_combine(idleSet, sets.Adoulin)
    --end
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		idleSet = set_combine(idleSet,sets.buff.Doom)
	end
    return idleSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
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

    local wsm_msg = state.WeaponskillMode.value
    local ws_msg = state.MainWS.value
	

    --local mainqd_msg = '(' ..string.sub(state.QDMode.value,1,1).. ')'
    local mainqd_msg = state.Mainqd.value
    local altqd_msg = state.Altqd.value
    local qdmode_msg = state.QDMode.value

    local e_msg = state.Mainqd.current
--    if state.UseAltqd.value == true then
--        e_msg = e_msg .. '/'..state.Altqd.current
--    end

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On'
    end

    add_to_chat(string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WSMode: ' ..string.char(31,001)..wsm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' QD: ' ..string.char(31,001)..mainqd_msg.. '/'  ..string.char(31,001)..altqd_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' QDMode: ' ..string.char(31,001)..qdmode_msg.. string.char(31,002)..  ' |'
     --   ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
     --   ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
     --   ..string.char(31,060).. ' AltQD' ..altqd_msg.. ': '  ..string.char(31,001)..e_msg.. string.char(31,002)..  ' |'
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
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
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
    if cmdParams[1] == 'qdmain' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local myqdmain = ''
--        if state.UseAltqd.value == true then
--            doqd = state[state.Currentqd.current..'qd'].current
--            state.Currentqd:cycle()
--        else
            myqdmain = state.Mainqd.current
 --       end

        send_command('@input /ja "'..myqdmain..'" <t>')
--    end
	elseif cmdParams[1] == 'qdalt' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local myqdalt = ''
            myqdalt = state.Altqd.current
        send_command('@input /ja "'..myqdalt..'" <t>')
	elseif cmdParams[1] == 'wsmain' then
        local mywsmain = ''
            mywsmain = state.MainWS.current
        send_command('@input /ws "'..mywsmain..'" <t>')
	end
	
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

function define_roll_values()
    rolls = {
        ["Corsair's Roll"] =    {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"] =        {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"] =     {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"] =        {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"] =      {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"] =     {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"] =      {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"] =       {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"] =       {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"] =        {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"] =      {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"] =     {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"] =      {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"] =    {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"] =       {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"] =    {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"] =     {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"] =     {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"] =    {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"] =     {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"] =     {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"] =    {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"] =    {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] =  {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"] =      {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"] =      {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] =  {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"] =    {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and string.char(129,157)) or ''

    if rollinfo then
        add_to_chat(001, string.char(129,115).. '  ' ..string.char(31,210)..spell.english..string.char(31,001)..
            ' : '..rollinfo.bonus.. ' ' ..string.char(129,116).. ' ' ..string.char(129,195)..
            '  Lucky: ' ..string.char(31,204).. tostring(rollinfo.lucky)..string.char(31,001).. ' /' ..
            ' Unlucky: ' ..string.char(31,167).. tostring(rollinfo.unlucky)..string.char(31,002)..
            '  ' ..rollsize)
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name] or player.wardrobe2[bullet_name] or player.wardrobe3[bullet_name] or player.wardrobe4[bullet_name] or player.wardrobe5[bullet_name] or player.wardrobe6[bullet_name] or player.wardrobe7[bullet_name] or player.wardrobe8[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
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

--function check_moving()
--    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
--        if state.Auto_Kite.value == false and moving then
--            state.Auto_Kite:set(true)
--        elseif state.Auto_Kite.value == true and moving == false then
--            state.Auto_Kite:set(false)
--        end
--    end
--end

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
--    if state.OffenseMode.value == 'LowAcc' or state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
--        equip(sets[state.WeaponSet.current].Acc)
--    else
--        equip(sets[state.WeaponSet.current])
--    end
--    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
--        equip(sets.DefaultShield)
--    end
--end

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
-- Select default macro book on initial load or subjob change.
function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end

--Page, Book--
set_macros(5,8)

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(21) 
