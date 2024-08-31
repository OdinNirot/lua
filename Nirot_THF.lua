-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

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


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	res = require('resources')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Doom'] = buffactive['doom'] or false
	state.Buff['Bane'] = buffactive['bane'] or false
    state.Buff['Terror'] = buffactive['terror'] or false
    state.Buff['Stun'] = buffactive['stun'] or false
    state.Buff['Petrification'] = buffactive['petrification'] or false
	
	
	
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
	
	
	send_command('get "Storage Slip 06" sack') --af for steal+
	send_command('get "Storage Slip 21" sack') --empy +1
	send_command('get "Storage Slip 24" sack') --AF +2
	send_command('get "Storage Slip 25" sack') --AF +3
	send_command('get "Storage Slip 27" sack') --relic +3
	send_command('get "Storage Slip 29" sack') --empy +2
	
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal','PDT') --"engaged" sets
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal','UncappedAtk','PDT')  -- is your atk vs mobs capped or uncapped?
    state.PhysicalDefenseMode:options('Evasion', 'PDT')
	state.ExtraResist = M('Normal','Charm','Death')
	state.IdleMode:options('Normal','PDT')
	state.MeleeRegen = M(false, 'MeleeRegen')
	state.Kiting              = M(true, 'Kiting')

    --gear.default.weaponskill_neck = "Asperity Necklace"
    --gear.default.weaponskill_waist = "Caudata Belt"
    gear.default.weaponskill_ring2 = "Epaminondas's Ring"
    --gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}

    -- Additional local binds
    --send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^- gs c cycle offensemode')
    --send_command('bind !- gs c cycle targetmode')
	send_command('bind ^- gs c cycle Kiting')
    send_command('bind numpad. gs c cycle HybridMode')
    send_command('bind numpad3 gs c cycle OffenseMode')
	send_command('bind numpad4 gs c cycle ExtraResist')
	send_command('bind numpad6 gs c cycle WeaponskillMode')
	send_command('bind numpad9 gs c cycle MeleeRegen')
	PhalanxAbility = S{"Phalanx II"}

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    --send_command('unbind ^`')
    --send_command('unbind !-')
	send_command('unbind numpad.')
	send_command('unbind ^=')
	send_command('unbind ^-')
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind numpad6')	
	send_command('unbind numpad9')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------
	
	AdhemarHead = {}
	AdhemarBody = {}
	HercHead = {}
	HercBody = {}
	HercHands = {}
	HercLegs = {}
	HercFeet = {}
	LeylineHands = {}
	Toutatis = {}
	
	AdhemarHead.DexAgiAtk = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemarBody.FC = { name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}}
	HercHead.FC = { name="Herculean Helm", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Accuracy+3','"Fast Cast"+7',}}
	HercHead.Phalanx = { name="Herculean Helm", augments={'Pet: INT+6','Weapon skill damage +1%','Phalanx +4',}}
	HercBody.Phalanx = { name="Herculean Vest", augments={'Mag. Acc.+19','Magic dmg. taken -1%','Phalanx +5',}}
	HercHands.Waltz = { name="Herculean Gloves", augments={'Chance of successful block +1','"Waltz" potency +10%','"Store TP"+1','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	HercHands.FC = { name="Herculean Gloves", augments={'Pet: "Mag.Atk.Bns."+20','STR+7','"Fast Cast"+8','Accuracy+15 Attack+15',}}
	HercHands.Phalanx = { name="Herculean Gloves", augments={'Pet: "Dbl. Atk."+2','Potency of "Cure" effect received+6%','Phalanx +4','Accuracy+5 Attack+5','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	HercLegs.FC = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+18','"Fast Cast"+6','INT+10','Mag. Acc.+12',}}
	HercLegs.WSD = { name="Herculean Trousers", augments={'Spell interruption rate down -7%','MND+13','Weapon skill damage +9%','Mag. Acc.+3 "Mag.Atk.Bns."+3',} }
	HercLegs.Phalanx = { name="Herculean Trousers", augments={'Mag. Acc.+15','Phalanx +4','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
	
	HercFeet.FC = { name="Herculean Boots", augments={'"Fast Cast"+6','INT+4','Mag. Acc.+1','"Mag.Atk.Bns."+10',}}
	HercFeet.Waltz = { name="Herculean Boots", augments={'"Waltz" potency +10%','STR+12','Damage taken-1%','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}
	
	Toutatis.STP = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}
	Toutatis.WSD = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}

    sets.TreasureHunter = {hands="Plunderer's Armlets +3",Feet="Skulker's Poulaines +3"}
    sets.ExtraRegen = {head="Turms Cap +1",neck="Elite Royal Collar",body="Turms Harness +1",hands="Turms Mittens +1",ring1="Chirich Ring +1",legs="Turms Subligar +1",Feet="Turms Leggings +1"}
    sets.Kiting = {feet="Pillager's Poulaines +3"}
	sets.buff['Curse'] = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar Sash"}
	sets.Charm = {neck="Unmoving Collar +1",ear1="Arete Del Luna +1"}
	sets.Death = {neck="Warder's Charm +1",ring1="Shadow Ring",ring2="Warden's Ring"}
	sets.Phalanx = {head=HercHead.Phalanx,body=HercBody.Phalanx,hands=HercHands.Phalanx,legs=HercLegs.Phalanx}

    sets.buff['Sneak Attack'] = {
        head=AdhemarHead.DexAgiAtk,neck="Assassin's Gorget +2",ear1="Odr Earring",ear2="Sherida Earring",
        body="Turms Harness +1",hands="Plunderer's Armlets +3",ring1="Ilabrat Ring",ring2="Gere Ring",
        back=Toutatis.WSD,waist="Chaac Belt",legs="Plunderer's Culottes +3",Feet="Skulker's Poulaines +3"}

    sets.buff['Trick Attack'] = {
        head=AdhemarHead.DexAgiAtk,neck="Assassin's Gorget +2",ear1="Odr Earring",ear2="Sherida Earring",
        body="Turms Harness +1",hands="Plunderer's Armlets +3",ring1="Ilabrat Ring",ring2="Gere Ring",
        back=Toutatis.WSD,waist="Chaac Belt",legs="Turms Subligar +1",Feet="Skulker's Poulaines +3"}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +2"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +3"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    --sets.precast.JA['Steal'] = {ammo="Barathrum",neck="Pentalagus Charm",hands="Thief's Kote",legs="Assassin's Culottes",feet="Pillager's Poulaines +3"}
	-- trying to stick to ilvl gear
    sets.precast.JA['Steal'] = {range=empty,ammo="Barathrum",neck="Pentalagus Charm",feet="Pillager's Poulaines +3"}
    sets.precast.JA['Despoil'] = {feet="Skulker's Poulaines +3"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}
    sets.precast.JA['Feint'] = {legs="Plunderer's Culottes +3"}
    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
	-- Waltz Potency gear caps at 50%, while Waltz received potency caps at 30%
	-- Passion Jacket is 13% Rawhide Boots are 8%
    sets.precast.Waltz = {
		body="Passion Jacket",hands=HercHands.Waltz,waist="Flume Belt +1",Legs="Dashing Subligar",Feet=HercFeet.Waltz}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {head=HercHead.FC,neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body=AdhemarBody.FC,hands=HercHands.FC.FC,ring1="Naji's Loop",ring2="Rahab Ring",
		legs=HercLegs.FC,feet=HercFeet.FC}
		

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {} --{head="Aurore Beret",hands="Iuitl Wristbands",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame Helm",neck="Assassin's Gorget +2",ear1="Odr Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Ilabrat Ring",ring2="Regal Ring",
        back=Toutatis.WSD,waist="Grunfeld Rope",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.PDT = set_combine(sets.precast.WS, {head="Nyame Helm",body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets"})
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	-- Exenterator: AGI:73~85%, depending on merit points ugrades. 
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {ammo="Coiste Bodhar",
		head="Skulker's Bonnet +2",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Skulker's Earring +1",
		body="Skulker's Vest +2",hands="Skulker's Armlets +2",ring1="Gere Ring",
		back=Toutatis.WSD,waist="Fotia Belt",legs="Nyame Flanchard",feet="Skulker's Poulaines +3"})
    sets.precast.WS['Exenterator'].PDT = set_combine(sets.precast.WS['Exenterator'], {ring2="Defending Ring"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].UncappedAtk = set_combine(sets.precast.WS['Exenterator'].Mod, {})

	-- Dancing Edge: DEX:40% ; CHR:40% 
    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {ammo="Coiste Bodhar",
		head="Plunderer's Bonnet +3",neck="Assassin's Gorget +2",ear1="Sherida Earring",ear2="Dominance Earring +1",
		body="Skulker's Vest +2",hands="Skulker's Armlets +2",ring1="Regal ring",ring2="Gere Ring",
		waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Skulker's Poulaines +3"})
    sets.precast.WS['Dancing Edge'].PDT = set_combine(sets.precast.WS.PDT, {ring2="Defending Ring"})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {})
    sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
	sets.precast.WS["Dancing Edge"].UncappedAtk = set_combine(sets.precast.WS["Dancing Edge"].Mod, {})

	-- Evisceration: DEX:50% 
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila +1",
		head="Skulker's Bonnet +2",neck="Fotia Gorget",
		body="Plunderer's Vest +3",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Moonlight Ring",
		back=Toutatis.WSD,waist="Fotia Belt",legs="Skulker's Culottes +2",feet="Gleti's Boots"})
    sets.precast.WS['Evisceration'].PDT = set_combine(sets.precast.WS['Evisceration'], {ring2="Defending Ring"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
	sets.precast.WS["Evisceration"].UncappedAtk = set_combine(sets.precast.WS["Evisceration"].Mod, {})
	
	-- Rudra's Storm: 80% DEX
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ammo="Coiste Bodhar",
		head="Nyame Helm",neck="Assassin's Gorget +2",ear1="Dominance Earring +1",ear2="Odnowa Earring +1",
		body="Skulker's Vest +2",hands="Nyame Gauntlets",ring1="Cornelia's ring",
		back=Toutatis.WSD,waist="Kentarch Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"})
    sets.precast.WS["Rudra's Storm"].PDT = set_combine(sets.precast.WS["Rudra's Storm"], {ring2="Defending Ring"})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})
    sets.precast.WS["Rudra's Storm"].UncappedAtk = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})

	-- Shark Bite: DEX:40% AGI:40% 
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {ammo="Coiste Bodhar",
		head="Nyame Helm",ear1="Odnowa Earring +1",
		body="Skulker's Vest +2",hands="Nyame Gauntlets",ring1="Cornelia's Ring",
		waist="Sailfi Belt +1",legs="Nyame Flanchard"})
    sets.precast.WS["Shark Bite"].PDT = set_combine(sets.precast.WS.PDT, {ring2="Defending Ring"})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {})
    sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
	sets.precast.WS["Shark Bite"].UncappedAtk = set_combine(sets.precast.WS["Shark Bite"].Mod, {})

	-- Mandalic Stab: DEX:60% 
    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +2",ear1="Dominance Earring +1",ear2="Odr Earring",
		body="Skulker's Vest +2",hands="Gleti's Gauntlets",ring1="Cornelia's Ring",ring2="Moonlight Ring",
		waist="Kentarch Belt +1"})
    sets.precast.WS['Mandalic Stab'].PDT = set_combine(sets.precast.WS.PDT, {ring1="Defending Ring"})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
    sets.precast.WS['Mandalic Stab'].UncappedAtk = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})

	-- Aeolian Edge: DEX:40%; INT:40% 
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
		head="Nyame Helm",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Dingir Ring",ring2="Cornelia's Ring",
		back=Toutatis.WSD,waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"})
    sets.precast.WS['Aeolian Edge'].PDT = set_combine(sets.precast.WS['Aeolian Edge'], {})
    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
		head="Nyame Helm",neck="Republican Platinum Medal",ear1="Odnowa Earring +1",ear2="Sherida Earring",
		body="Skulker's Vest +2",hands="Nyame Gauntlets",ring1="Cornelia's Ring",
		waist="Sailfi Belt +1",legs="Nyame Flanchard"})
	
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}
        --head="Whirlpool Mask",ear2="Loquacious Earring",
        --body="Pillager's Vest +3",hands="Pillager's Armlets +1",
        --back="Canny Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

    -- Specific spells
    sets.midcast.Utsusemi = {}
        --head="Whirlpool Mask",neck="Ej Necklace",ear2="Loquacious Earring",
        --body="Pillager's Vest +3",hands="Pillager's Armlets +1",ring1="Beeline Ring",
        --back="Canny Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

    -- Ranged gear
    sets.midcast.RA = {}
        --head="Whirlpool Mask",neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
        --body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Hajduk Ring",
        --back="Libeccio Mantle",waist="Aquiline Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    sets.midcast.RA.Acc = {}
        --head="Pillager's Bonnet +1",neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
        --body="Iuitl Vest",hands="Buremte Gloves",ring1="Beeline Ring",ring2="Hajduk Ring",
        --back="Libeccio Mantle",waist="Aquiline Belt",legs="Thurandaut Tights +1",feet="Pillager's Poulaines +3"}

	sets.midcast['Poisonga'] = set_combine(sets.precast.FC,sets.TreasureHunter)
	sets.midcast['Aspir'] = set_combine(sets.precast.FC,sets.TreasureHunter)
		
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
        head="Turms Cap +1",neck="Elite Royal Collar",ear1="Sanare Earring",ear2="Telos Earring",
        body="Turms Harness +1",hands="Turms Mittens +1",ring1="Chirich Ring +1",ring2="Defending Ring",
        back=Toutatis.STP,waist="Flume Belt +1",legs="Turms Subligar +1",feet="Pillager's Poulaines +3"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        head="Turms Cap +1",neck="Elite Royal Collar",ear1="Sanare Earring",ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
        body="Turms Harness +1",hands="Turms Mittens +1",ring1="Chirich Ring +1",ring2="Defending Ring",
        back=Toutatis.STP,waist="Flume Belt +1",legs="Turms Subligar +1",feet="Pillager's Poulaines +3"}
    sets.idle.Town = {
        head="Turms Cap +1",neck="Elite Royal Collar",ear1="Sanare Earring",ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
        body="Turms Harness +1",hands="Turms Mittens +1",ring1="Chirich Ring +1",ring2="Defending Ring",
        back=Toutatis.STP,waist="Flume Belt +1",legs="Turms Subligar +1",feet="Pillager's Poulaines +3"}
    sets.idle.Weak = {
        head="Turms Cap +1",neck="Elite Royal Collar",ear1="Sanare Earring",ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
        body="Turms Harness +1",hands="Turms Mittens +1",ring1="Chirich Ring +1",ring2="Defending Ring",
        back=Toutatis.STP,waist="Flume Belt +1",legs="Turms Subligar +1",feet="Pillager's Poulaines +3"}
	sets.idle.PDT = set_combine(sets.idle, {head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Sanare Earring",body="Ashera Harness",hands="Malignance Gloves",ring1={ name="Gelatinous Ring +1", augments={'Path: A',}},ring2="Defending Ring",back=Toutatis.STP,waist="Flume Belt +1",legs="Malignance Tights",feet="Pillager's Poulaines +3"})
	sets.idle.Normal = sets.idle


    -- Defense sets

    sets.defense.Evasion = {neck="Loricate Torque +1",ring1="Moonlight Ring",ring2="Defending Ring",
		body="Malignance Tabard",hands="Malignance Gloves",
	    back=Toutatis.STP,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
    sets.defense.PDT = {head="Malignance Chapeau",neck="Loricate Torque +1",ring1="Gere Ring",ring2="Defending Ring",
		body="Ashera Harness",hands="Malignance Gloves",
	    back=Toutatis.STP,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}


    --------------------------------------
    -- Melee sets
    --------------------------------------

	-- https://www.ffxiah.com/forum/topic/49635/dual-wield-formulas-and-haste-values
	
	-- THF /w 550 JP has Dual Wield IV which is 30%. Below are the appropriate formulas (taken from the above link):
	
	-- No haste 30 DW
	-- (1 - (0.2 / (1 - (0.0 + .25))) -0.30 = 44 DW needed
	
	-- 10% haste 30 DW
	-- (1 - (0.2 / (1 - (0.1 + .25))) -0.3 = 40 DW needed
	
	-- 15% haste 30 DW
	-- (1 - (0.2 / (1 - (0.146484375 + .25))) -0.30 = 37 DW needed
	
	-- 30% haste 30 DW
	-- (1 - (0.2 / (1 - (0.2998046875 + .25))) -0.30 = 26 DW needed
	
	-- Haste cap with 30 DW
	-- (1 - (0.2 / (1 - (0.4375 + .25))) -0.30 = 6 DW needed
	
	
	-- DW gear THF has at its disposal:
	-- (waist) Shetal Stone 	Dual Wield +6%  OR   Patentia Sash 	Dual Wield +5% (has +5 store tp)
	-- (ring) Haverton Ring +1 	Dual Wield +6% 
	-- (ear) Suppanomimi 	Dual Wield +5% 
	-- (ear) Eabani Earring 	Dual Wield +4% 
	-- (range) Raider's Boomerang 	Dual Wield +3% 
	
	-- 24 in a best case, 17 realistically
	

    -- Normal melee group
    sets.engaged = {ammo="Aurgelmir Orb +1",
        head="Skulker's Bonnet +2",neck="Assassin's Gorget +2",ear1="Sherida Earring",ear2="Skulker's Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Moonlight Ring",ring2="Gere Ring",
        back=Toutatis.STP,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
    sets.engaged.Acc = set_combine(sets.engaged,{})
    sets.engaged.MeleeRegen = {
        head="Turms Cap +1",neck="Assassin's Gorget +2",ear1="Dedition Earring",ear2="Sherida Earring",
        body="Pillager's Vest +3",hands="Turms Mittens +1",ring1="Chirich Ring +1",ring2="Gere Ring",
        back=Toutatis.STP,waist="Reiki Yotai",legs="Turms Subligar +1",Feet="Turms Leggings +1"}
		
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.Mod = sets.engaged 

    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.Mod2 = sets.engaged 
    --sets.engaged.Evasion = sets.engaged 
    --sets.engaged.Acc.Evasion = sets.engaged 
    sets.engaged.PDT = set_combine(sets.engaged, sets.defense.PDT)
    --sets.engaged.Acc.PDT = sets.defense.Evasion

end

TargetDistance = 0
ranged_ws = S{"Flaming Arrow", "Piercing Arrow", "Dulling Arrow", "Sidewinder", "Arching Arrow",
	"Empyreal Arrow", "Refulgent Arrow", "Apex Arrow", "Namas Arrow", "Jishnu's Radiance", "Hot Shot", 
	"Split Shot", "Sniper Shot", "Slug Shot", "Heavy Shot", "Detonator", "Last Stand", "Trueflight","Wildfire"}

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	if (spell.type == 'WeaponSkill' or spell.skill == "Ninjutsu") and (buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] or buffactive['Sleep']) then
		cancel_spell()
		eventArgs.cancel = true
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

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
    check_buff('Curse', eventArgs)
    check_buff('Bane', eventArgs)
    check_buff('Doom', eventArgs)
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
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
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 70 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    if state.HybridMode.value == 'PDT' then
		idleSet = sets.idle.PDT
	end
	if  state.ExtraResist.value == 'Charm' then
		idleSet = set_combine(idleset,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		idleSet = set_combine(idleset,sets.Death)
	end
	if buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane'] then
	    --if state.Buff['Curse'] or state.Buff['Doom'] or state.Buff['Bane'] then
		idleSet = set_combine(idleSet,sets.buff.Curse)
	end
    return idleSet
end

function customize_resting_set(restingSet)
	if buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane'] then
		restingSet = set_combine(restingSet,sets.buff.Curse)
	else
		restingSet = set.resting
	end
    return restingSet
end

function customize_acc_set(accSet)
    if state.OffenseMode.value == 'Normal' then
		accSet = sets.engaged
	end
    if state.OffenseMode.value == 'Acc' then
		accSet = sets.engaged.Acc
	end
	if buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane'] then
		accSet = set_combine(accSet,sets.buff.Curse)
	end
    return accSet
end

function customize_melee_set(meleeSet)
	if state.MeleeRegen.value == 'MeleeRegen' then
		meleeSet = sets.engaged.MeleeRegen
	end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
	if  state.ExtraResist.value == 'Charm' then
		meleeSet = set_combine(meleeSet,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		meleeSet = set_combine(meleeSet,sets.Death)
	end
	if buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane'] then
		meleeSet = set_combine(meleeSet,sets.buff.Curse)
	end
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
		meleeSet = set_combine(meleeSet,sets.engaged.PDT)
	end
    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
--    if state.HybridMode.has_value then
--        hm_msg = state.HybridMode.value
--    end
    if state.TreasureMode.has_value then
        tm_msg = state.TreasureMode.value
	else
        tm_msg = 'Off'
    end
--    if state.ElementalResist.value then
--        er_msg = 'On'
--	else
--        er_msg = 'Off'
--    end
	
    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On'
	else 
        msg = msg .. ' Kiting: Off'
    end

    add_to_chat(string.char(31,210).. 'HybridMode: ' ..string.char(31,001)..hm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' OffenseMode: ' ..string.char(31,001)..om_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' WeaponskillMode: ' ..string.char(31,001)..wm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' TreasureMode: ' ..string.char(31,001)..tm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
	
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
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
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
set_macros(5,6)

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(3) 

