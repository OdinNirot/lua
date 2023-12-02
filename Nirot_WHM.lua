-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
      MY NOTES
	  
      gs equip sets.precast.JA[\"Trick Attack\"]
	  gs equip sets.precast.WS[\"Rudra's Storm\"]
	  gs equip sets.engaged
	  gs equip sets.midcast.Cursna
	  gs enable/disable back
	  gs debugmode
	  gs showswaps
	  gs validate
	  gs c cycle treasuremode





--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'SIRD')
    state.IdleMode:options('Normal', 'PDT')
	state.ExtraRefresh = M(false, 'ExtraRefresh')
	state.Kalasiris = M(true, 'Kalasiris')
	state.WeaponLock = M(false, 'WeaponLocked')
	
    send_command('bind numpad. gs c cycle IdleMode')
	send_command('bind ^= gs c cycle Kiting')
	send_command('bind numpad8 gs c cycle Kalasiris')
	send_command('bind numpad9 gs c cycle ExtraRefresh')
	send_command('bind F10 gs c cycle WeaponLock')

    select_default_macro_book()
	sird_sets()
	
	send_command('get "Storage Slip 23" sack') --ambu +2
	send_command('get "Storage Slip 29" sack') --empy +2
	
	end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^0')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
	send_command('unbind numpad.')
	send_command('unbind ^=')
	send_command('unbind numpad8')
	send_command('unbind numpad9')
	send_command('unbind F10')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    TelHead = {}
    TelBody = {}
    TelHands = {}
    TelLegs = {}
    TelFeet = {}
	
	VanyaHead = {}
	VanyaLegs = {}
	VanyaFeet = {}

	
	TelHead.Duration = { name="Telchine Cap", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelBody.Duration = { name="Telchine Chas.", augments={'Mag. Evasion+21','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelHands.Duration = { name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelLegs.Duration = { name="Telchine Braconi", augments={'Mag. Evasion+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelFeet.Duration = { name="Telchine Pigaches", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	
	VanyaHead.HealSkill = { name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	VanyaLegs.HealSkill = { name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	VanyaFeet.HealSkill = { name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	
	Alaunus = {}
	Alaunus.DA = { name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Alaunus.DT = { name="Alaunus's Cape", augments={'Damage taken-5%',}}
	
	sets.Prime = {main="Lorg Mor"}
	
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main="C. Palug Hammer",Sub="Genmei Shield",ammo="Impatiens",
		head="Ebers Cap +3",neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','"Cure" potency +6%',}},ring1="Rahab Ring",ring2="Kishar Ring",
		back="Fi Follet Cape +1",waist="Witful Belt",legs="Volte Brais",feet="Kaykaus Boots +1"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat",neck="Nodens Gorget",ear1="Earthcry Earring",legs="Shedir Seraweels"})
    sets.precast.FC.Aquaveil = set_combine(sets.precast.FC['Enhancing Magic'], {head={ name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC['Enhancing Magic'], {main="Daybreak"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
		head="Ebers Cap +3",neck="Cleric's Torque +2",ear1="Mendicant's Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",ring1="Rahab Ring",ring2="Kishar Ring",
		waist="Witful Belt",legs="Ebers Pantaloons +3",feet="Kaykaus Boots +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {}) --{main="Tamaxchi",sub="Genmei Shield",ammo="Impatiens"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Bliaut +3"}
	sets.precast.JA.Sublimation = {waist="Embla Sash"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        --head="Nahtirah Hat",ear1="Roundel Earring",
        --body="Vanir Cotehardie",hands="Yaoyotl Gloves",
        --back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't 	any more specifically defined
    gear.default.weaponskill_neck = "" --"Asperity Necklace"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {ammo="Hasty Pinion +1",
		head="Nyame Helm",neck="Combatant's Torque",ear1="Moonshade Earring",ear2="Dominance Earring +1",
        body="Ayanmo Corazza +2",hands="Gazu Bracelets +1",ring1="Ephramad's Ring",ring2="Ayanmo Ring",
        back=Alaunus.DA,waist="Eschan Stone",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.precast.WS.PDT = sets.precast.WS
    
    --sets.precast.WS['Flash Nova'] = {
    --    head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
    --    body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
    --    back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    

    -- Midcast Sets
	
    sets.midcast.FastRecast = {
        head="Cath Palug Crown",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Rahab Ring",ring2="Kishar Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Kaykaus Tights +1",feet=TelFeet.Duration}
    
	sets.midcast.SIRD = {ammo="Staunch Tathlum +1",
		head="Ebers Cap +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Nourishing Earring +1",
		body="Ros. Jaseran +1",hands="Ebers Mitts +3",ring1="Freke Ring",ring2="Defending Ring",
		back="Fi Follet Cape +1",waist="Emphatikos Rope",legs="Ebers Pantaloons +3",feet="Theo. Duckbills +3"}
	
    -- Cure sets
    --gear.default.obi_waist = "Goading Belt"
    --gear.default.obi_back = "Mending Cape"
	
    sets.midcast.CureSolace = {main="Daybreak",Sub="Genmei Shield",
        head="Kaykaus Mitra +1",neck="Cleric's Torque +2",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Bunzi's Robe",hands="Theophany Mitts +3",ring1="Naji's Loop",ring2="Kishar Ring",
        back=Alaunus.DA,waist="Hachirin-no-obi",legs="Ebers Pantaloons +3",feet="Kaykaus Boots +1"}
	sets.midcast.CureSolace.SIRD = set_combine(sets.midcast.CureSolace,sets.midcast.SIRD,{main="Daybreak",Sub="Genmei Shield"})

    sets.midcast.Cure = {main="Daybreak",Sub="Genmei Shield",
        head="Kaykaus Mitra +1",neck="Cleric's Torque +2",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Bunzi's Robe",hands="Theophany Mitts +3",ring1="Naji's Loop",ring2="Kishar Ring",
        back=Alaunus.DA,waist="Hachirin-no-obi",legs="Ebers Pantaloons +3",feet="Kaykaus Boots +1"}
	sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure,sets.midcast.SIRD,{main="Daybreak",Sub="Genmei Shield"})	

    sets.midcast.Curaga = {main="Daybreak",Sub="Genmei Shield",
        head="Kaykaus Mitra +1",neck="Cleric's Torque +2",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Bunzi's Robe",hands="Theophany Mitts +3",ring1="Naji's Loop",ring2="Kishar Ring",
        back=Alaunus.DA,waist="Hachirin-no-obi",legs="Ebers Pantaloons +3",feet="Kaykaus Boots +1"}
	sets.midcast.Curaga.SIRD = set_combine(sets.midcast.Curaga,sets.midcast.SIRD,{main="Daybreak",Sub="Genmei Shield"})

    sets.midcast.CureMelee = {main="Daybreak",Sub="Genmei Shield",
        head="Kaykaus Mitra +1",neck="Cleric's Torque +2",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Bunzi's Robe",hands="Theophany Mitts +3",ring1="Naji's Loop",ring2="Kishar Ring",
        back=Alaunus.DA,waist="Hachirin-no-obi",legs="Ebers Pantaloons +3",feet="Kaykaus Boots +1"}
	sets.midcast.CureMelee.SIRD = set_combine(sets.midcast.CureMelee,sets.midcast.SIRD)

    sets.midcast.Cursna = {main="Yagrush",Sub="Thuellaic Ecu +1",
		head=VanyaHead.HealSkill,neck="Debilis Medallion",ear1="Meili Earring",ear2="Ebers Earring +1",
		body="Ebers Bliaut +2",hands="Fanatic Gloves",ring1="Menelaus's Ring",ring2="Haoma's Ring",
        back=Alaunus.DA,waist="Bishop's Sash",legs="Theophany Pantaloons +3",feet=VanyaFeet.HealSkill}
	sets.midcast.Cursna.SIRD = set_combine(sets.midcast.Cursna,sets.midcast.SIRD)
		
    sets.midcast.StatusRemoval = {main="Yagrush",Sub="Genmei Shield",neck="Cleric's Torque +2"}
	sets.midcast.StatusRemoval.SIRD = set_combine(sets.midcast.StatusRemoval,sets.midcast.SIRD)
	sets.midcast.Raise = sets.precast.FC
	sets.midcast.Raise.SIRD = set_combine(sets.midcast.Raise,sets.midcast.SIRD)
        --head="Orison Cap +2",legs="Orison Pantaloons +2"}
						
	sets.midcast.Erase = sets.midcast.StatusRemoval
	sets.midcast.Erase.SIRD = set_combine(sets.midcast.StatusRemoval,sets.midcast.SIRD,{neck="Cleric's Torque +2"})
    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",
		head=TelHead.Duration,neck="Incanter's Torque",ear1="Etiolation Earring",ear2="Ebers Earring +1",
		body=TelBody.Duration,hands=TelHands.Duration,
		waist="Embla Sash",legs=TelLegs.Duration,feet="Theophany Duckbills +3"}--{main="Beneficus",sub="Genmei Shield",
        --head="Umuthi Hat",neck="Colossus's Torque",
        --body="Manasa Chasuble",hands="Dynasty Mitts",
        --back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Orison Duckbills +2"}
	sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast['Enhancing Magic'],sets.midcast.SIRD)
	sets.midcast['Haste'] = sets.midcast['Enhancing Magic']
	sets.midcast['Haste'].SIRD = set_combine(sets.midcast['Haste'],sets.midcast.SIRD)

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{main="Gada",sub="Ammurapi Shield",
		head="Cath Palug Crown",neck="Nodens Gorget",ear1="Earthcry Earring",
		waist="Siegel Sash",legs="Shedir Seraweels",feet="Theophany Duckbills +3"})--{
        --head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
        --body="Vanir Cotehardie",hands="Dynasty Mitts",
        --back="Swith Cape +1",waist="Siegel Sash",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	sets.midcast.Stoneskin.SIRD = set_combine(sets.midcast.Stoneskin,sets.midcast.SIRD)
		
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{main="Vadose Rod",sub="Ammurapi Shield",
		head="Chironic Hat",hands="Regal Cuffs",
		waist="Emphatikos Rope",legs="Shedir Seraweels"})
	sets.midcast.Aquaveil.SIRD = set_combine(sets.midcast.Aquaveil,sets.midcast.SIRD)

    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'],{main="Gada",sub="Ammurapi Shield",waist="Embla Sash",feet="Ebers Duckbills +3"})
	sets.midcast.Auspice.SIRD = set_combine(sets.midcast.Auspice,sets.midcast.SIRD)

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],{main="Gada",sub="Ammurapi Shield",
		neck="Sroda Necklace",body="Ebers Bliaut +2",hands="Ebers Mitts +3",
		back=Alaunus.DA,waist="Embla Sash",legs="Piety Pantaloons +3",feet="Ebers Duckbills +3"})--{main="Beneficus",sub="Genmei Shield",
        --head="Orison Cap +2",neck="Colossus's Torque",
        --body="Orison Bliaud +2",hands="Orison Mitts +2",
        --back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Orison Duckbills +2"}
	sets.midcast['Baramnesra'] = set_combine(sets.midcast['Enhancing Magic'],{neck="Sroda Necklace"})
	sets.midcast['Barvira'] = set_combine(sets.midcast['Enhancing Magic'],{neck="Sroda Necklace"})
	sets.midcast['Barparalyzra'] = set_combine(sets.midcast['Enhancing Magic'],{neck="Sroda Necklace"})
	sets.midcast['Barsilencera'] = set_combine(sets.midcast['Enhancing Magic'],{neck="Sroda Necklace"})
	sets.midcast['Barpetra'] = set_combine(sets.midcast['Enhancing Magic'],{neck="Sroda Necklace"})
	sets.midcast['Barpoisonra'] = set_combine(sets.midcast['Enhancing Magic'],{neck="Sroda Necklace"})
	sets.midcast['Barblindra'] = set_combine(sets.midcast['Enhancing Magic'],{neck="Sroda Necklace"})
	sets.midcast['Barsleepra'] = set_combine(sets.midcast['Enhancing Magic'],{neck="Sroda Necklace"})
			
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{main="Bolelabunga",Sub="Ammurapi Shield",
		head="Inyanga Tiara +2",
		body="Piety Bliaut +3",
		hands="Ebers Mitts +3",
		waist="Embla Sash",legs="Theophany Pantaloons +3",feet="Theophany Duckbills +3"})
	sets.midcast.Regen.SIRD = set_combine(sets.midcast.Regen,sets.midcast.SIRD)

    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{main="Gada",sub="Ammurapi Shield",waist="Embla Sash"})--{ring1="Sheltered Ring",feet="Piety Duckbills +1"}

    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{main="Gada",sub="Ammurapi Shield",waist="Embla Sash",legs="Piety Pantaloons +3"})--{ring1="Sheltered Ring",legs="Piety Pantaloons"}


    sets.midcast['Divine Magic'] = set_combine(sets.precast.FC,{})
		
	sets.midcast.Banish = {main="Daybreak",Sub="Ammurapi Shield",
		head="Ipoca Beret",neck="Mizukage-no-Kubikazari",ear1="Friomisi Earring",ear2="Malignance Earring",
        hands="Fanatic Gloves",ring1="Metamor. Ring +1",ring2="Freke Ring",
        back=Alaunus.DA,waist="Bishop's Sash",legs="Theophany Pantaloons +3",feet={ name="Chironic Slippers", augments={'"Fast Cast"+2','Mag. Acc.+18','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}}
	sets.midcast.Banish.SIRD = set_combine(sets.midcast.Banish,sets.midcast.SIRD)

    sets.midcast['Dark Magic'] = {}
	sets.midcast['Dark Magic'].SIRD = set_combine(sets.midcast['Dark Magic'],sets.midcast.SIRD)

    -- Custom spell classes
	sets.midcast.Enfeebs = {main="Yagrush",Sub="Ammurapi Shield",
		head="C. Palug Crown",neck="Incanter's Torque",ear1="Regal Earring",ear2="Ebers Earring +1",
		body="Theophany Bliaut +3",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",legs="Th. Pant. +3",feet="Skaoi Boots"}
    sets.midcast.MndEnfeebles = set_combine(sets.midcast.Enfeebs, {
		waist="Sacro Cord"})
    sets.midcast.IntEnfeebles = set_combine(sets.midcast.Enfeebs, {
		waist="Acuity Belt +1"})
	sets.midcast.Dispelga = set_combine(sets.midcast.Enfeebs, {main="Daybreak"})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Daybreak",Sub="Genmei Shield",ammo="Homiliary",
		head={ name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},neck="Clr. Torque +2",ear1="Ethereal Earring",ear2="Telos Earring",
        body="Ebers Bliaut +2",hands={ name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}},ring1="Chirich Ring +1",ring2="Defending Ring",
        back=Alaunus.DT,waist="Hachirin-no-obi",legs={ name="Chironic Hose", augments={'DEX+5','INT+4','"Refresh"+2','Accuracy+2 Attack+2',}},feet={ name="Chironic Slippers", augments={'"Fast Cast"+2','Mag. Acc.+18','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Daybreak",Sub="Genmei Shield",ammo="Homiliary",
		head={ name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},neck="Clr. Torque +2",ear1="Ethereal Earring",ear2="Ebers Earring +1",
        body="Shamash Robe",hands={ name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}},ring1="Stikini Ring +1",ring2="Defending Ring",
        back=Alaunus.DT,waist="Carrier's Sash",legs="Ebers Pant. +3",feet={ name="Chironic Slippers", augments={'"Fast Cast"+2','Mag. Acc.+18','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}}
		--{main="Bolelabunga", sub="Genmei Shield",ammo="Incantor Stone",
        --head="Nahtirah Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        --body="Gendewitha Bliaut",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        --back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}
    sets.idle.Town = {main="Daybreak",Sub="Genmei Shield",ammo="Homiliary",
		head={ name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},neck="Clr. Torque +2",ear1="Ethereal Earring",ear2="Ebers Earring +1",
        body="Ebers Bliaut +2",hands={ name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}},ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=Alaunus.DT,waist="Carrier's Sash",legs={ name="Chironic Hose", augments={'DEX+5','INT+4','"Refresh"+2','Accuracy+2 Attack+2',}},feet={ name="Chironic Slippers", augments={'"Fast Cast"+2','Mag. Acc.+18','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}}
    sets.idle.Weak = {main="Daybreak",Sub="Genmei Shield",ammo="Homiliary",
		head={ name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},neck="Clr. Torque +2",ear1="Sanare Earring",ear2="Ebers Earring +1",
        body="Shamash Robe",hands={ name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}},ring1="Stikini Ring +1",ring2="Defending Ring",
        back=Alaunus.DT,waist="Carrier's Sash",legs={ name="Chironic Hose", augments={'DEX+5','INT+4','"Refresh"+2','Accuracy+2 Attack+2',}},feet={ name="Chironic Slippers", augments={'"Fast Cast"+2','Mag. Acc.+18','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}}
    sets.idle.PDT = {main="Malignance Pole",Sub="Mensch Strap +1",ammo="Homiliary",
		head={ name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},neck="Clr. Torque +2",ear1="Eabani Earring",ear2="Ebers Earring +1",
        body="Shamash Robe",hands={ name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}},ring1="Stikini Ring +1",ring2="Defending Ring",
        back=Alaunus.DT,waist="Carrier's Sash",legs={ name="Chironic Hose", augments={'DEX+5','INT+4','"Refresh"+2','Accuracy+2 Attack+2',}},feet="Ebers Duckbills +3"}
    
    -- Defense sets

    sets.defense.PDT = sets.idle.PDT--{main=gear.Staff.PDT,sub="Achaq Grip",
        --head="Gendewitha Caubeen",neck="Loricate Torque +1",
        --body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        --back="Umbra Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    sets.Kiting = {ring1="Shneddick Ring +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}
	
	sets.ExtraRegen = {ring2="Chirich Ring +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {ammo="Crepuscular Pebble",
		head="Ayanmo Zucchetto +2",neck="Combatant's Torque",ear1="Dominance Earring +1",ear2="Odnowa Earring +1",
        body="Ayanmo Corazza +2",hands="Gazu Bracelets +1",ring1="Ephramad's Ring",ring2="Cacoethic Ring +1",
        back=Alaunus.DA,waist="Eschan Stone",legs="Bunzi's Pants",feet="Nyame Sollerets"}
	sets.engaged.PDT = set_combine(sets.engaged,{ring2="Defending Ring"})

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	check_weaponlock()
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
--    if spell.skill == 'Healing Magic' then
--        gear.default.obi_back = "Mending Cape"
--    else
--        gear.default.obi_back = "Toro Cape"
--    end
end

function do_equip(setname)
	send_command('gs equip '..setname..'')
end

function sird_sets()
	if state.IdleMode.value == 'PDT' then
		state.CastingMode:set('SIRD')
	else
		state.CastingMode:reset()
	end
	
--	if state.CastingMode then
--		add_to_chat(210,'CastingMode: '..state.CastingMode.value)
--	else
--		add_to_chat(210,'CastingMode: '..'Normal')
--	end
--	add_to_chat(210,'IdleMode: '..state.IdleMode.value)
end


function job_post_midcast(spell, action, spellMap, eventArgs)
end

function determine_sleep_state()
	if (buffactive[2]) or (buffactive[19]) then
		do_equip('sets.Prime')
		disable("main")
		if buffactive["Stoneskin"] then
			windower.send_command('cancel 37;')
		end
	end
	if name=="sleep" and not gain then
		enable("main")
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
--function job_state_change(stateField, newValue, oldValue)
--    if stateField == 'Offense Mode' then
--        if newValue == 'Normal' then
--            disable('main','sub','range')
--        else
--            enable('main','sub','range')
--        end
--    end
--end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
--    if state.Buff[buff] ~= nil then
--        state.Buff[buff] = gain
--    end
	
	if S{'sleep'}:contains(buff:lower()) then
        determine_sleep_state()
    end	
	
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
	check_weaponlock()
    if player.hpp < 70 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	if player.tp >= 1000 then
		idleSet = set_combine(idleSet, {ring2="Defending Ring"})
	end
	if state.ExtraRefresh.value then
		idleSet = set_combine(idleSet,{ring1="Stikini Ring +1",ring2="Stikini Ring +1"})
	end
    if state.IdleMode.value == 'PDT' then
		idleSet = sets.idle.PDT
	end
	if state.Kalasiris.value then
		idleSet = set_combine(idleSet,{body="Annoint. Kalasiris"})
	end
	if state.Kiting.value then
		idleSet = set_combine(idleSet,sets.Kiting)
	end
	sird_sets()
    return idleSet
end

function customize_resting_set(restingSet)
	check_weaponlock()
	if state.ExtraRefresh.value then
		restingSet = set_combine(restingSet,{ring1="Stikini Ring +1",ring2="Stikini Ring +1"})
	else
		restingSet = sets.resting
	end
	if state.Kalasiris.value then
		restingSet = set_combine(restingSet,{body="Annoint. Kalasiris"})
	end
    return restingSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	determine_sleep_state()
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end

function check_weaponlock()
	if state.WeaponLock.value then
		disable("main")
		disable("sub")
		disable("range")
		disable("ammo")
	else
		enable("main")
		enable("sub")
		enable("range")
		enable("ammo")
	end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    local msg = ''
    if state.Kiting.value == true then
        msg = msg .. ' | Kiting: On'
    end
	
    if state.WeaponLock.value == true then
        wl_msg = 'On'
	else
        wl_msg = 'Off'
    end
    if state.IdleMode.has_value then
        dt_msg = state.IdleMode.value
	else 
		dt_msg = 'Normal'
    end
	
    if state.CastingMode.has_value then
        cm_msg = state.CastingMode.value
	else 
		cm_msg = 'Normal'
    end
--    if state.TreasureMode.has_value then
--        tm_msg = state.TreasureMode.value
--	else
--        tm_msg = 'Off'
--    end
    if state.ExtraRefresh.value then
        er_msg = state.ExtraRefresh.value
	else
        er_msg = 'Off'
    end
	
    add_to_chat(string.char(31,210).. 'DTMode: ' ..string.char(31,001)..dt_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' SIRD: ' ..string.char(31,001)..cm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' ExtraRefresh: ' ..string.char(31,001)..er_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' WeaponLock: ' ..string.char(31,001)..wl_msg.. string.char(31,002)
        ..string.char(31,002)..msg)

    eventArgs.handled = true
	
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(5, 3)
end

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(11) 