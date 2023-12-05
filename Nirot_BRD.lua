-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
 
 --[[
      MY NOTES
	  
      gs equip sets.precast.JA[\"Trick Attack\"]
	  gs equip sets.precast.WS[\"Rudra's Storm\"]
	  gs equip sets.precast.WS
	  gs equip sets.precast.JA.Jump
	  gs equip sets.engaged
	  gs enable/disable back
	  gs debugmode
	  gs showswaps
	  gs validate





--]]

 
 
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
     
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
--  state.CombatForm = get_combat_form()

    include('Mote-TreasureHunter')
     
    state.Buff = {}
	
	state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Curse'] = buffactive['doom'] or false
	state.Buff['Curse'] = buffactive['bane'] or false
	state.Buff['Terror'] = buffactive['terror'] or false
    state.Buff['Stun'] = buffactive['stun'] or false
    state.Buff['Petrification'] = buffactive['petrification'] or false
	state.DualWielding = M{true, false}
	
	state.Buff['Pianissimo'] = buffactive['pianissimo'] or false
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
      "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
      "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Liv. Bul. Pouch"}	
	
	magic_maps = {}
	
	magic_maps.curespells = S{
		'Cura','Cura II','Cura III','Curaga','Curaga II','Curaga III','Curaga IV','Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI'
	}
	
	magic_maps.mndpot = S{
		'Paralyze','Paralyze II','Slow','Slow II','Addle',
		'Addle II'
	}
	
	magic_maps.skillmndpot = S{
		'Distract','Distract II','Distract III','Frazzle III'
	}
	
	magic_maps.macc = S{
		'Sleep','Sleep II','Sleepga','Silence','Inundation',
		'Dispel','Dispelga','Break','Bind','Frazzle','Frazzle II'
	}
	
	magic_maps.intpot = S{
		'Blind','Blind II'
	}
	
	magic_maps.skillpot = S{
		'Poison','Poison II','Poisonga','Poisonga II'
	}
	
	magic_maps.BarSpells = S{
	'Barfire','Barblizzard','Baraero','Barstone','Barthunder','Barwater','Barsleep','Barpoison','Barparalyze','Barblind','Barsilence','Barpetrify','Barvirus','Baramnesia','Barfira','Barblizzara','Baraera','Barstonra','Barthundra','Barwatera','Barsleepra','Barpoisonra','Barparalyzra','Barblindra','Barsilencera','Barpetra','Barvira','Baramnesra'	
	}

	magic_maps.EnhancingSkill = S{
		'Aquaveil','Blaze Spikes','Enaero','Enaero II','Enblizzard','Enblizzard II','Enfire','Enfire II','Enstone','Enstone II','Enthunder','Enthunder II','Enwater','Enwater II','Ice Spikes','Phalanx','Phalanx II','Shock Spikes','Temper','Temper II'
	}	
	
	magic_maps.NoEnhancingSkill = S{
		'Blink','Deodorize','Erase','Escape','Flurry','Flurry II','Haste','Haste II','Invisible','Protect','Protect II','Protect III','Protect IV','Protect V','Protectra','Protectra II','Protectra III','Protectra IV','Protectra V','Retrace','Shell','Shell II','Shell III','Shell IV','Shell V','Shellra','Shellra II','Shellra III','Shellra IV','Shellra V','Sneak','Warp','Warp II'
	}
	magic_maps.RegenSpells = S{
		'Regen','Regen II'
	}	
			
	magic_maps.ImmunobreakSpells = S{
		'Slow','Slow II','Paralyze','Paralyze II','Silence','Addle','Addle II','Blind','Blind II','Gravity','Gravity II','Bind','Poison','Break','Sleep','Sleep II'
	}
	
	magic_maps.ballad = S{
		"Mage's Ballad","Mage's Ballad II","Mage's Ballad III"
	}
	
	magic_maps.carol = S{
		'Fire Carol','Fire Carol II','Ice Carol','Ice Carol II','Wind Carol','Wind Carol II','Earth Carol','Earth Carol II','Lightning Carol','Lightning Carol II','Water Carol','Water Carol II','Light Carol','Light Carol II','Dark Carol','Dark Carol II'
	}
	
	magic_maps.elegy = S{
		'Battlefield Elegy','Carnage Elegy'
	}
	
	magic_maps.etude = S{
		'Sinewy Etude','Dextrous Etude','Vivacious Etude','Quick Etude','Learned Etude','Spirited Etude','Enchanting Etude','Herculean Etude','Uncanny Etude','Vital Etude','Swift Etude','Sage Etude','Logical Etude','Bewitching Etude'
	}
	
	magic_maps.finale = S{
		'Magic Finale'
	}
	
	magic_maps.hymnus = S{
		"Goddess's Hymnus"
	}
	
	magic_maps.lullaby_aoe = S{
		'Horde Lullaby','Horde Lullaby II'
	}
	
	magic_maps.lullaby_single = S{
		'Foe Lullaby','Foe Lullaby II'
	}
	
	magic_maps.madrigal = S{
		'Sword Madrigal','Blade Madrigal'
	}
	
	magic_maps.mambo = S{
		'Sheepfoe Mambo','Dragonfoe Mambo'
	}
	
	magic_maps.march = S{
		'Advancing March','Victory March','Honor March'
	}
	
	magic_maps.mazurka = S{
		'Raptor Mazurka','Chocobo Mazurka'
	}
	
	magic_maps.minne = S{
		"Knight's Minne","Knight's Minne II","Knight's Minne III","Knight's Minne IV","Knight's Minne V"
	}
	
	magic_maps.minuet = S{
		'Valor Minuet','Valor Minuet II','Valor Minuet III','Valor Minuet IV','Valor Minuet V'
	}
	
	magic_maps.paeon = S{
		"Army's Paeon","Army's Paeon II","Army's Paeon III","Army's Paeon IV","Army's Paeon V","Army's Paeon VI"
	}
	
	magic_maps.prelude = S{
		"Hunter's Prelude","Archer's Prelude"
	}
	
	magic_maps.requiem = S{
		'Foe Requiem','Foe Requiem II','Foe Requiem III','Foe Requiem IV','Foe Requiem V','Foe Requiem VI','Foe Requiem VII'
	}
	
	magic_maps.scherzo = S{
		"Sentinel's Scherzo"
	}
	
	magic_maps.threnody = S{
		'Fire Threnody','Fire Threnody II','Ice Threnody','Ice Threnody II','Wind Threnody','Wind Threnody II','Earth Threnody','Earth Threnody II','Lightning Threnody','Lightning Threnody II','Water Threnody','Water Threnody II','Light Threnody','Light Threnody II','Dark Threnody','Dark Threnody II'
	}
	
	magic_maps.virelai = S{
		"Maiden's Virelai"
	}
	
	
	send_command('get "Storage Slip 18" sack') -- relic +1
	send_command('get "Storage Slip 23" sack') --Ambu +2
	send_command('get "Storage Slip 24" sack') --AF +2
	send_command('get "Storage Slip 25" sack') --AF +3
	send_command('get "Storage Slip 29" sack') -- Empy +2
	
  end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    --options.OffenseModes = {'Normal', 'SomeAccuracy','MaxAccuracy'}
    --options.WeaponskillModes = {'Normal', 'NotAttackCapped', 'Accuracy'}
    state.HybridMode:options('Normal')
	state.OffenseMode:options('Normal', 'SomeAccuracy','MaxAccuracy')
    state.WeaponskillMode:options('Normal', 'NotAttackCapped', 'Accuracy')
	state.CastingMode:options('Normal','DW')
	state.Kiting              = M(true, 'Kiting')
	state.ExtraRefresh = M(false, 'ExtraRefresh')
	state.WeaponLock = M(false, 'WeaponLocked')
	state.ExtraResist = M('Normal','Charm','Death')
	state.DummyMode = M('Normal','Dummy')
    options.PhysicalDefenseModes = {'Reraise'}
	state.CursnaGear = M(true, 'CursnaGear')
    send_command('bind numpad. gs c cycle DummyMode')
	send_command('bind ^- gs c cycle TreasureMode')
	send_command('bind ^= gs c cycle Kiting')
	send_command('bind ^backspace gs c cycle CursnaGear')
	send_command('bind numpad2 gs c cycle ExtraResist')
	send_command('bind numpad4  input /ja "Pianissimo" <me>')
    send_command('bind numpad6 gs c cycle WeaponskillMode')
    send_command('bind numpad3 gs c cycle OffenseMode')
	send_command('bind F10 gs c cycle WeaponLock')
	
	enable('range', 'ammo')
	my_classes()
	
    -- Additional local binds
    --send_command('bind ^` input /ja "Hasso" <me>')
    --send_command('bind !` input /ja "Seigan" <me>')
 
    --select_default_macro_book(1, 17)
end
 
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end
 
    send_command('unbind ^`')
    send_command('unbind ^-')
    send_command('unbind !-')
	send_command('unbind ^=')
	send_command('unbind ^-')
	send_command('unbind ^backspace')	
	send_command('unbind numpad2')
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind numpad6')	
	send_command('unbind F10')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	ChironicHead = {}
	ChironicHands = {}
	ChironicLegs = {}
	ChironicFeet = {}
	
	ChironicHead.Refresh = { name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
	ChironicHands.Refresh = { name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}}
	ChironicLegs.Refresh = { name="Chironic Hose", augments={'DEX+5','INT+4','"Refresh"+2','Accuracy+2 Attack+2',}}
	ChironicFeet.Refresh = { name="Chironic Slippers", augments={'"Fast Cast"+2','Mag. Acc.+18','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	
	Intarabus = {}
	Intarabus.FC = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}
	Intarabus.DexStoreTP = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}
	Intarabus.WSDStr = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
		 
	Linos = {}
	Linos.QAStp = { name="Linos", augments={'Accuracy+15 Attack+15','"Store TP"+4','Quadruple Attack +3',}}
	Linos.WSDStr = { name="Linos", augments={'Accuracy+13 Attack+13','Weapon skill damage +3%','STR+8',}}
	
    -- Precast Sets
    Nyame = {head="Nyame Helm",body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    sets.Kiting = {feet="Fili Cothurnes +2"}
	sets.Curse = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar Sash"}
	sets.TreasureHunter = {waist="Chaac Belt"}
	sets.Prime = {range="Prime Horn"}
			  
			  
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Nightingale'] = {feet="Bihu Slippers +1"}
    sets.precast.JA['Troubadour'] = {body="Bihu Justaucorps +1"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}
			  
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		ear1="Fili Earring +1",
		waist="Flume Belt +1",Legs="Dashing Subligar"}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
    sets.precast.FC = { --set has 80 FC
		--ammo="Impatiens",
		head="Cath Palug Crown", --8
		neck="Orunmila's Torque", --5
		ear1="Etiolation Earring", --1
		ear2="Loquacious Earring", --2
		body="Inyanga Jubbah +2", --14
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','"Cure" potency +6%',}}, --7
		ring1="Rahab Ring",
		ring2="Kishar Ring", --4
		back=Intarabus.FC, --10
		waist="Embla Sash", --5
		legs="Volte Brais", --8
		feet="Fili Cothurnes +2" --10
	}
	
	-- since songs don't need SIRD this set will be different from the above FC set
	sets.precast.FC.songs = { --45PDT/46MDT, 59 FC, 15 -song casting time
		main="Carnwenhan",
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Fili Calot +3",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Fili Earring +1",
		body="Inyanga Jubbah +2",
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','"Cure" potency +6%',}},
		ring1="Defending Ring",
		ring2="Kishar Ring",
		back=Intarabus.FC,
		waist="Embla Sash",
		legs="Volte Brais",
		feet="Fili Cothurnes +2"
	}
	sets.precast.FC.dummy = set_combine(sets.precast.FC.songs,{range="Daurdabla"})
	sets.precast.FC.DW = {sub="Kali"}
	sets.precast.FC.dummy.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW,{range="Daurdabla"})
	
	sets.precast.FC.ballad = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.ballad.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.carol = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.carol.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.elegy = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.elegy.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.etude = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.etude.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.finale = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.finale.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.hymnus = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.hymnus.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.lullaby_aoe = set_combine(sets.precast.FC.songs,{range="Daurdabla"})
	sets.precast.FC.lullaby_aoe.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW,{range="Daurdabla"})
	sets.precast.FC.lullaby_single = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.lullaby_single.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.madrigal = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.madrigal.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.mambo = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.mambo.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.march = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.march.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.mazurka = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.mazurka.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.minne = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.minne.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.minuet = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.minuet.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.paeon = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.paeon.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.prelude = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.prelude.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.requiem = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.requiem.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.scherzo = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.scherzo.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.threnody = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.threnody.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC.virelai = set_combine(sets.precast.FC.songs,{})
	sets.precast.FC.virelai.DW = set_combine(sets.precast.FC.songs,sets.precast.FC.DW)
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.march,{range="Marsyas"})
	sets.precast.FC['Honor March'].DW = set_combine(sets.precast.FC.march,sets.precast.FC.DW,{range="Marsyas"})
    --sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
     
    sets.precast.WS = {
		range=Linos.WSDStr,
		head="Nyame Helm",
		neck="Bard's Charm +2",
		ear1="Telos Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Petrov Ring",
		ring2="Chirich Ring +1",
		back=Intarabus.WSDStr,
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}
    sets.precast.WS.NotAttackCapped = set_combine(sets.precast.WS,{})
    sets.precast.WS.Accuracy = set_combine(sets.precast.WS,{})
	
	 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	-- Mordant Rime: 70% CHR ; 30% DEX
    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Mordant Rime'].NotAttackCapped = set_combine(sets.precast.WS.NotAttackCapped,sets.precast.WS['Mordant Rime'])
	sets.precast.WS['Mordant Rime'].Accuracy = set_combine(sets.precast.WS.Accuracy,sets.precast.WS['Mordant Rime'].NotAttackCapped)
	
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head="Fili Calot +3",neck="Rep. Plat. Medal",ear1="Domin. Earring +1",
		hands="Fili Manchettes +3",ring1="Ephramad's Ring",ring2="Epaminondas's Ring",
		waist="Prosilio Belt +1"})
	
    -- Midcast Sets
	sets.midcast.curespells = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Fili Calot +3",neck="Loricate Torque +1",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Ros. Jaseran +1",hands="Chironic Gloves",ring1="Defending Ring",ring2="Kishar Ring",
		back="Fi Follet Cape +1",waist="Emphatikos Rope",legs="Querkening Brais",feet="Nyame Sollerets"}
	sets.midcast['Cursna'] = sets.Curse --mainly in case of casting cursna on myself. improve this later
	sets.midcast.songs = {
		head="Fili Calot +3",
		neck="Mnbw. Whistle +1",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		back=Intarabus.FC,
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	}
	sets.midcast.ballad = set_combine(sets.midcast.songs,{legs="Fili Rhingrave +3"})
	sets.midcast.carol = set_combine(sets.midcast.songs,{})
	sets.midcast.elegy = set_combine(sets.midcast.songs,{})
	sets.midcast.etude = set_combine(sets.midcast.songs,{})
	sets.midcast.finale = set_combine(sets.midcast.songs,{})
	sets.midcast.hymnus = set_combine(sets.midcast.songs,{})
	
	sets.midcast.lullaby_aoe = set_combine(sets.midcast.songs,{  --need string skill of 567 to get 7 yalm radius on horde lullaby 2. if it were possible to get 648 string skill it could be 8 yalms
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Daurdabla",
		head="Brioso Roundlet +3",
		neck="Incanter's Torque",
		ear1="Etiolation Earring",
		ear2="Darkside Earring",
		body="Brioso Justau. +3",
		hands="Inyanga Dastanas +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		waist="Harfner's Sash",
		legs="Inyanga Shalwar +2",
		feet="Bihu Slippers +1"	
	})
	sets.midcast.lullaby_aoe.DW = set_combine(sets.midcast.lullaby_aoe,sets.precast.FC.DW)
	
	sets.midcast.lullaby_single = set_combine(sets.midcast.songs,{  --macc focus, use GHorn or Marsyas
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Brioso Roundlet +3",
		neck="Moonbow Whistle +1",
		ear1="Dignitary's Earring",
		ear2="Fili Earring +1",
		body="Fili Hongreline +3",
		hands="Brioso Cuffs +3",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		waist="Acuity Belt +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"	
	})
	sets.midcast.lullaby_single.DW = set_combine(sets.midcast.lullaby_single,sets.precast.FC.DW)
	sets.midcast['Horde Lullaby'] = set_combine(sets.midcast.lullaby_single,{range="Daurdabla"})  -- focus on macc because you already hit max aoe range at 154 string skill. so base it on lullaby_single set but use Daurdabla
	sets.midcast['Horde Lullaby'].DW = set_combine(sets.midcast['Horde Lullaby'],sets.precast.FC.DW)
	sets.midcast.madrigal = set_combine(sets.midcast.songs,{back=Intarabus.FC})
	sets.midcast.mambo = set_combine(sets.midcast.songs,{})
	sets.midcast.march = set_combine(sets.midcast.songs,{})
	sets.midcast.mazurka = set_combine(sets.midcast.songs,{})
	sets.midcast.minne = set_combine(sets.midcast.songs,{})
	sets.midcast.minuet = set_combine(sets.midcast.songs,{})
	sets.midcast.paeon = set_combine(sets.midcast.songs,{head="Brioso Roundlet +3"})
	sets.midcast.prelude = set_combine(sets.midcast.songs,{back=Intarabus.FC})
	sets.midcast.requiem = set_combine(sets.midcast.songs,{})
	sets.midcast.scherzo = set_combine(sets.midcast.songs,{feet="Fili Cothurnes +2"})
	sets.midcast.threnody = set_combine(sets.midcast.lullaby_single,{range="Gjallarhorn"})
	sets.midcast.virelai = set_combine(sets.midcast.songs,{})
	sets.midcast['Honor March'] = set_combine(sets.midcast.march,{range="Marsyas"})
	 
	 
	------Dummy sets (just stay in FC gear because you'll be applying full strength songs after)
	sets.midcast.dummy = sets.precast.FC.dummy
	sets.midcast.dummy.DW = sets.precast.FC.dummy.DW
	sets.midcast.ballad.dummy = set_combine(sets.precast.FC.ballad,{range="Daurdabla"})
	sets.midcast.ballad.dummy.DW = set_combine(sets.precast.FC.ballad.DW,{range="Daurdabla"})
	sets.midcast.carol.dummy = set_combine(sets.precast.FC.carol,{range="Daurdabla"})
	sets.midcast.carol.dummy.DW = set_combine(sets.precast.FC.carol.DW,{range="Daurdabla"})
	sets.midcast.etude.dummy = set_combine(sets.precast.FC.etude,{range="Daurdabla"})
	sets.midcast.etude.dummy.DW = set_combine(sets.precast.FC.etude.DW,{range="Daurdabla"})
	sets.midcast.hymnus.dummy = set_combine(sets.precast.FC.hymnus,{range="Daurdabla"})
	sets.midcast.hymnus.dummy.DW = set_combine(sets.precast.FC.hymnus.DW,{range="Daurdabla"})
	sets.midcast.madrigal.dummy = set_combine(sets.precast.FC.madrigal,{range="Daurdabla"})
	sets.midcast.madrigal.dummy.DW = set_combine(sets.precast.FC.madrigal.DW,{range="Daurdabla"})
	sets.midcast.mambo.dummy = set_combine(sets.precast.FC.mambo,{range="Daurdabla"})
	sets.midcast.mambo.dummy.DW = set_combine(sets.precast.FC.mambo.DW,{range="Daurdabla"})
	sets.midcast.march.dummy = set_combine(sets.precast.FC.march,{range="Daurdabla"})
	sets.midcast.march.dummy.DW = set_combine(sets.precast.FC.march.DW,{range="Daurdabla"})
	sets.midcast.mazurka.dummy = set_combine(sets.precast.FC.mazurka,{range="Daurdabla"})
	sets.midcast.mazurka.dummy.DW = set_combine(sets.precast.FC.mazurka.DW,{range="Daurdabla"})
	sets.midcast.minne.dummy = set_combine(sets.precast.FC.minne,{range="Daurdabla"})
	sets.midcast.minne.dummy.DW = set_combine(sets.precast.FC.minne.DW,{range="Daurdabla"})
	sets.midcast.minuet.dummy = set_combine(sets.precast.FC.minuet,{range="Daurdabla"})
	sets.midcast.minuet.dummy.DW = set_combine(sets.precast.FC.minuet.DW,{range="Daurdabla"})
	sets.midcast.paeon.dummy = set_combine(sets.precast.FC.paeon,{range="Daurdabla"})
	sets.midcast.paeon.dummy.DW = set_combine(sets.precast.FC.paeon.DW,{range="Daurdabla"})
	sets.midcast.prelude.dummy = set_combine(sets.precast.FC.prelude,{range="Daurdabla"})
	sets.midcast.prelude.dummy.DW = set_combine(sets.precast.FC.prelude.DW,{range="Daurdabla"})
	sets.midcast.scherzo.dummy = set_combine(sets.precast.FC.scherzo,{range="Daurdabla"})
	sets.midcast.scherzo.dummy.DW = set_combine(sets.precast.FC.scherzo.DW,{range="Daurdabla"})
	sets.midcast.threnody.dummy = set_combine(sets.midcast.threnody,{range="Gjallarhorn"})
	sets.midcast.threnody.dummy.DW = set_combine(sets.midcast.threnody.DW,{range="Gjallarhorn"})
	 
	 
    -- Sets to return to when not performing an action.
     
    -- Resting sets
    sets.resting = sets.idle
     
    -- Idle sets
    sets.idle = {
		--main="Daybreak",
		--sub="Genmei Shield",
		range="Gjallarhorn",
		head="Fili Calot +3",
		neck="Elite Royal Collar",
		ear1="Etiolation Earring",
		ear2="Arete del Luna +1",
		body="Ashera Harness",
		hands="Fili Manchettes +3",
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back="Engulfer Cape +1",
		waist="Carrier's Sash",
		legs="Fili Rhingrave +3",
		feet="Fili Cothurnes +2"
	}
  
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
    sets.engaged = {
		range=Linos.QAStp,
		head="Fili Calot +3",
		neck="Bard's Charm +2",
		ear1="Dedition Earring",
		ear2="Telos Earring",
		body="Ashera Harness",
		hands="Gazu Bracelets +1",
		ring1="Moonlight Ring",
		ring2="Chirich Ring +1",
		back=Intarabus.DexStoreTP,
		waist="Windbuffet Belt +1",
		legs="Fili Rhingrave +3",
		feet="Volte Spats"
	}
	
	sets.engaged.DW = set_combine(sets.engaged,{})

	-- Accuracy sets	
    sets.engaged.SomeAccuracy = set_combine(sets.engaged, {})
    sets.engaged.MaxAccuracy = set_combine(sets.engaged.SomeAccuracy,{})
 
	sets.Charm = {neck="Unmoving Collar +1"}
	sets.Death = {neck="Warder's Charm +1",ring1="Warden's Ring",ring2="Shadow Ring"}
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
 
 -- function to interpet the spell maps
function job_get_spell_map(spell, default_spell_map)
	for category,spell_list in pairs(magic_maps) do
		if spell_list:contains(spell.english) then
			return category
		end
	end
end

function my_classes()
	classes.CustomMeleeGroups:clear()
	if (player.sub_job == 'DNC' or player.sub_job == 'NIN' or player.sub_job == 'THF') then
		state.DualWielding = true
		classes.CustomMeleeGroups:append('DW')
		state.CastingMode.current = 'DW'
	else
		state.CastingMode.current = 'Normal'
		state.DualWielding = false
	end
end
 
function dummy_sets()
	if state.DummyMode.value == 'Dummy' then
		classes.CustomClass = "dummy"
	else
		classes.CustomClass = nil
	end
end
 
-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
 
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	check_weaponlock()
	dummy_sets()
    if spell.action_type == 'Magic' and not spell.type == 'BardSong' then
		equip(sets.precast.FC)
    end
    if spell.type == 'BardSong' then
        --[[ Auto-Pianissimo ]]--
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and not state.Buff['Pianissimo'] then
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
	end
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
 
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
--	if spell.type ~= 'JobAbility' then
--		handle_equipping_gear(player.status)
--		eventArgs.handled = true	
--	end
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	check_weaponlock()
--  if state.DefenseMode == 'Reraise' or
--      (state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
--      equip(sets.Reraise)
--  end
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end

end

function determine_sleep_state()
	if (buffactive[2]) or (buffactive[19]) then
			equip(sets.Prime)
		disable("main")
		if buffactive["Stoneskin"] then
			windower.send_command('cancel 37;')
		end
	end
	if name=="sleep" and not gain then
		enable("main")
	end
end


function customize_idle_set(idleSet)
	check_weaponlock()
		
	if state.ExtraRefresh.value then
		idleSet = set_combine(idleSet,{ring1="Stikini Ring +1",ring2="Stikini Ring +1"})
	end
	if state.ExtraResist.value == 'Charm' then
		idleSet = set_combine(idleSet,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		idleSet = set_combine(idleSet,sets.Death)
	end
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
	    --if state.Buff['Curse'] or state.Buff['Doom'] or state.Buff['Bane'] then
		idleSet = set_combine(idleSet,sets.buff.Curse)
	end
    return idleSet
end
 
function check_weaponlock()
	if state.WeaponLock.value then
		disable("main")
		disable("sub")
	else
		enable("main")
		enable("sub")
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
--function job_aftercast(spell, action, spellMap, eventArgs)
--if state.DefenseMode == 'Reraise' or
        --(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
    --end
--end
 
-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)
 
end
   
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
 
-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)
 
end
  
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)

	if state.DualWielding then
		meleeSet = set_combine(meleeSet,sets.engaged.DW)
	else
		meleeSet = set_combine(meleeSet, sets.engaged)
	end
	
	if state.ExtraResist.value == 'Charm' then
		meleeSet = set_combine(meleeSet,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		meleeSet = set_combine(meleeSet,sets.Death)
	end
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		meleeSet = set_combine(meleeSet,sets.buff.Curse)
	end
    return meleeSet
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
 
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
 
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if S{'sleep'}:contains(buff:lower()) then
        determine_sleep_state()
    end	
end
 
function job_update(cmdParams, eventArgs)
	determine_sleep_state()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
 
end
 
--function get_combat_form()
--  if areas.Adoulin:contains(world.area) and buffactive.ionis then
--      return 'Adoulin'
--  end
--end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomMeleeGroups:clear()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        classes.CustomMeleeGroups:append('Adoulin')
    end
end
 
-- Job-specific toggles.
function job_toggle(field)
 
end
 
-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_mode_list(field)
 
end
 
-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)
 
end
 
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
 
end
 
-- Handle notifications of user state values being changed.
function job_state_change(stateField, newValue)
 
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

--    local m_msg = state.OffenseMode.value
--    if state.HybridMode.value ~= 'Normal' then
--        m_msg = m_msg .. '/' ..state.HybridMode.value
        m_msg = state.HybridMode.value
--    end


	if state.ExtraResist.value then
		er_msg = state.ExtraResist.value
	else 
		er_msg = 'None'
	end
	
	if state.DummyMode.value then
		dummy_msg = state.DummyMode.value
	else
		dummy_msg = 'Off'
	end
	if state.WeaponLock.value then
		wl_msg = "Locked"
	else
		wl_msg = "Off"
	end
	
    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On'
	else 
        msg = msg .. ' Kiting: Off'
    end
	
    add_to_chat(string.char(31,210).. 'DummyMode: ' ..string.char(31,001)..dummy_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' ExtraResist: ' ..string.char(31,001)..er_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' WeaponLock: ' ..string.char(31,001)..wl_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end

--Page, Book--
set_macros(5,10)

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(33) 