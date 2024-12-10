-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	state.Kalasiris = M(false, 'Kalasiris')
	state.DualWielding = M{false, true}
	state.Immunobreak = M(false, 'Immunobreak')
	
	geo_timer = ''
	indi_timer = ''
	indi_duration = 308
	entrust_timer = ''
	entrust_duration = 344
	entrust = 0
	newLuopan = 0
	
	state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Doom'] = buffactive['doom'] or false
	state.Buff['Bane'] = buffactive['bane'] or false
	state.Buff['Terror'] = buffactive['terror'] or false
	state.Buff['Stun'] = buffactive['stun'] or false
	state.Buff['Petrification'] = buffactive['petrification'] or false
	
	include('Mote-TreasureHunter')

	magic_maps = {}
	
	magic_maps.curespells = S{
		'Cura','Cura II','Cura III','Curaga','Curaga II','Curaga III','Curaga IV','Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI'
	}
	
	magic_maps.potency = S{
		'Dia','Dia II','Dia III','Bio','Bio II','Bio III',
		'Gravity','Gravity II'
	}
	
	magic_maps.mndpot = S{
		'Paralyze','Paralyze II','Slow','Slow II','Addle',
		'Addle II'
	}
	
-- We leave Fazzle and FrazzleII as pure macc to help land it in cases its a high resist.
-- This lets us follow up with a high potency Frazzle3

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
	
	magic_maps.Impact = S{
		'Impact'
	}
	
	magic_maps.Nuke = S{
		'Aero','Aero II','Aero III','Aero IV','Aero V','Aero VI','Aeroga','Aeroga II','Aeroga III','Aeroja','Aerora','Aerora II','Aerora III','Anemohelix','Anemohelix II','Blizzaga','Blizzaga II','Blizzaga III','Blizzaja','Blizzara','Blizzara II','Blizzara III','Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V','Blizzard VI','Burn','Burst','Burst II','Comet','Cryohelix','Cryohelix II','Drown','Fira','Fira II','Fira III','Firaga','Firaga II','Firaga III','Firaja','Fire','Fire II','Fire III','Fire IV','Fire V','Fire VI','Flare','Flare II','Flood','Flood II','Freeze','Freeze II','Frost','Geohelix','Geohelix II','Hydrohelix','Hydrohelix II','Ionohelix','Ionohelix II','Luminohelix','Luminohelix II','Meteor','Noctohelix','Noctohelix II','Pyrohelix','Pyrohelix II','Quake','Quake II','Rasp','Shock','Stone','Stone II','Stone III','Stone IV','Stone V','Stone VI','Stonega','Stonega II','Stonega III','Stoneja','Stonera','Stonera II','Stonera III','Thundaga','Thundaga II','Thundaga III','Thundaja','Thundara','Thundara II','Thundara III','Thunder','Thunder II','Thunder III','Thunder IV','Thunder V','Thunder VI','Tornado','Tornado II','Water','Water II','Water III','Water IV','Water V','Water VI','Watera','Watera II','Watera III','Waterga','Waterga II','Waterga III','Waterja'
	}
	
	-- defining these here instead of depending on the includes file to do it
	magic_maps.RefreshSpells = S{
		'Refresh','Refresh II','Refresh III'
	}
	
	magic_maps.BarSpells = S{
	'Barfire','Barblizzard','Baraero','Barstone','Barthunder','Barwater','Barsleep','Barpoison','Barparalyze','Barblind','Barsilence','Barpetrify','Barvirus','Baramnesia','Barfira','Barblizzara','Baraera','Barstonra','Barthundra','Barwatera','Barsleepra','Barpoisonra','Barparalyzra','Barblindra','Barsilencera','Barpetra','Barvira','Baramnesra'	
	}
	
	magic_maps.GainSpells = S{
	'Gain-STR','Gain-STR','Gain-DEX','Gain-VIT','Gain-AGI','Gain-INT','Gain-MND','Gain-CHR'
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
	
	magic_maps.GeoSpells = S{
		"Indi-Acumen","Geo-Acumen","Indi-Attunement","Geo-Attunement","Indi-Barrier","Geo-Barrier","Indi-STR","Geo-STR","Indi-VIT","Geo-VIT","Indi-AGI","Geo-AGI","Indi-DEX","Geo-DEX","Indi-CHR","Geo-CHR","Indi-MND","Geo-MND","Indi-INT","Geo-INT","Indi-Fade","Geo-Fade","Indi-Fend","Geo-Fend","Indi-Focus","Geo-Focus","Indi-Frailty","Geo-Frailty","Indi-Fury","Geo-Fury","Indi-Gravity","Geo-Gravity","Indi-Haste","Geo-Haste","Indi-Languor","Geo-Languor","Indi-Malaise","Geo-Malaise","Indi-Paralysis","Geo-Paralysis","Indi-Poison","Geo-Poison","Indi-Precision","Geo-Precision","Indi-Refresh","Geo-Refresh","Indi-Regen","Geo-Regen","Indi-Slip","Geo-Slip","Indi-Slow","Geo-Slow","Indi-Torpor","Geo-Torpor","Indi-Vex","Geo-Vex","Indi-Voidance","Geo-Voidance","Indi-Wilt","Geo-Wilt"
	}
	
	magic_maps.dark = S{
		'Aspir','Aspir II','Aspir III','Drain','Drain II','Drain III'
	}
	
	--state.TreasureMode:set('Tag')
	
	--spell element reference:
	-- Silence: wind
	-- Slow: earth
	-- Paralyze: ice
	-- Frazzle: dark
	-- Distract: ice
	
	send_command('get "Storage Slip 25" sack') --AF +3
	send_command('get "Storage Slip 27" sack') --relic +3
	send_command('get "Storage Slip 29" sack') --empy +2
	send_command('get "Storage Slip 30" sack') --empy +3
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
--	state.AccMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'SIRD')
	state.IdleMode:options('Normal', 'PDT')
	state.HybridMode:options('Normal','PDT') --"engaged" sets
	--state.ExtraResist:options('Normal','Charm','Death')
	state.IdleMode:options('Normal', 'PDT')
	state.ExtraResist = M('Normal','Charm','Death')
	state.Kiting              = M(true, 'Kiting')
	state.ExtraRefresh = M(false, 'ExtraRefresh')
	state.BurstMode = M(false, 'BurstMode')
	state.AccMode = M(false, 'OdinSoloMode')
	state.WeaponLock = M(false, 'WeaponLocked')
	state.CursnaGear = M(false, 'CursnaGear')
	
	-- Additional local binds
	send_command('bind numpad. gs c cycle IdleMode')
	send_command('bind ^= gs c cycle TreasureMode')
	--send_command('unbind ^-') --unbind this key which is set in Mote-Globals.lua so we can use it
	send_command('bind ^- gs c cycle Kiting')
	send_command('bind ^= gs c cycle TreasureMode')
	send_command('bind ^backspace gs c cycle CursnaGear')
	send_command('bind numpad3 gs c cycle AccMode')
	send_command('bind numpad4 gs c cycle ExtraResist')
	send_command('bind numpad6 gs c cycle Immunobreak')
	send_command('bind numpad9 gs c cycle ExtraRefresh')
	send_command('bind numpad7 gs c cycle BurstMode')
	send_command('bind numpad8 gs c cycle Kalasiris')
	send_command('bind F10 gs c cycle WeaponLock')

--	send command('bind numpad4 gs info_to_console()')
	
	sird_sets()
	update_combat_form()
	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^0')
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind @`')
	send_command('unbind numpad.')
	send_command('unbind ^=')
	send_command('unbind ^backspace')
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind numpad8')
	send_command('unbind numpad7')
	send_command('unbind numpad9')
	send_command('unbind F10')
end

-- Set up gear sets.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	sets.Obis = {}
	sets.Obis.Fire = {waist='Hachirin-no-Obi'}
	sets.Obis.Earth = {waist='Hachirin-no-Obi'}
	sets.Obis.Water = {waist='Hachirin-no-Obi'}
	sets.Obis.Wind = {waist='Hachirin-no-Obi'}
	sets.Obis.Ice = {waist='Hachirin-no-Obi'}
	sets.Obis.Lightning = {waist='Hachirin-no-Obi'}
	sets.Obis.Light = {waist='Hachirin-no-Obi'}
	sets.Obis.Dark = {waist='Hachirin-no-Obi'}
	sets.Zodiac = {lring={name="Zodiac Ring",mp=25}}
	sets.Orpheus = {waist="Orpheus's Sash"}
	sets.Immunobreak = {legs="Chironic Hose"}
	
	MerlinicHead = {}
	MerlinicHands = {}
	MerlinicLegs = {}
	MerlinicFeet = {}
	MerlinicHead.Phalanx = {name="Merlinic Hood", augments={'Pet: Phys. dmg. taken -2%','"Resist Silence"+1','Phalanx +5','Accuracy+10 Attack+10','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	MerlinicHead.TH = { name="Merlinic Hood", augments={'Mag. Acc.+22','"Dbl.Atk."+3','"Treasure Hunter"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}
	MerlinicHands.TH = { name="Merlinic Dastanas", augments={'MND+5','Weapon Skill Acc.+2','"Treasure Hunter"+2',}}
	MerlinicHands.Phalanx = { name="Merlinic Dastanas", augments={'Crit. hit damage +1%','Attack+12','Phalanx +5','Accuracy+14 Attack+14',}}
	MerlinicLegs.Refresh = { name="Merlinic Shalwar", augments={'Pet: Mag. Acc.+1','Accuracy+4 Attack+4','"Refresh"+2','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}
	MerlinicLegs.Phalanx = { name="Merlinic Shalwar", augments={'AGI+4','Mag. Acc.+6','Phalanx +4','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
	MerlinicFeet.Phalanx = { name="Merlinic Crackows", augments={'CHR+7','Magic Damage +1','Phalanx +4','Accuracy+6 Attack+6',}}
		
	TelHead = {}
	TelBody = {}
	TelHands = {}
	TelLegs = {}
	TelFeet = {}
	
	TelHead.Duration = { name="Telchine Cap", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelBody.Duration = { name="Telchine Chas.", augments={'Mag. Evasion+21','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelBody.PetDT = { name="Telchine Chas.", augments={'Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}}
	TelHands.Duration = { name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelLegs.Duration = { name="Telchine Braconi", augments={'Mag. Evasion+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelLegs.PetDT = { name="Telchine Braconi", augments={'Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}}
	TelFeet.Duration = { name="Telchine Pigaches", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
		
	sets.Prime = {main="Lorg Mor"}
	
	Lifestream = {}
	Lifestream.IndiDuration = { name="Lifestream Cape", augments={'Geomancy Skill +4','Indi. eff. dur. +20','Pet: Damage taken -1%',}}
	
	Gada = {}
	Gada.Indi = { name="Gada", augments={'Indi. eff. dur. +11','Mag. Acc.+5','"Mag.Atk.Bns."+6','DMG:+2',}}
	Gada.Enh = { name="Gada", augments={'Enh. Mag. eff. dur. +6','DMG:+4',}}
	
	Nantosuelta = {}
	Nantosuelta.PetRegen = { name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Pet: "Regen"+5',}}
	Nantosuelta.DexDA = Nantosuelta.PetRegen
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +3"}
	sets.precast.JA['Life Cycle'] = {head="Bagua Galero +3", body="Geomancy Tunic +3", back=Nantosuelta.PetRegen,}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
	
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {main="Mpaca's Staff",sub="Clerisy Strap +1",ranged="Dunna",
		head="Amalric Coif +1",neck="Orunmila's Torque",ear1="Loquac. Earring",
		body="Agwu's Robe",hands="Agwu's Gages",ring1="Rahab Ring",ring2="Kishar Ring",
		back="Fi Follet Cape +1",waist="Shinjutsu-no-Obi +1",legs="Volte Brais",feet="Amalric Nails +1"}
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{waist="Siegel Sash"})
	sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC,{})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC,{head="Umuthi Hat",neck="Nodens Gorget",ear1="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	sets.precast.FC['Impact'] = set_combine(sets.precast.FC,{head=empty,body="Crepuscular Cloak"})
	sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC,{main="Daybreak",sub="Ammurapi Shield"})
	
	sets.midcast.SIRD = {ammo="Staunch Tathlum +1",
		head="Azimuth Hood +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Halasz Earring",
		body="Ros. Jaseran +1",hands="Azimuth Gloves +2",ring1="Evanescence Ring",ring2="Freke Ring",
		back="Fi Follet Cape +1",waist="Emphatikos Rope",legs="Geomancy Pants +3",feet="Azimuth Gaiters +3"}
	
	sets.TreasureHunter = {head=MerlinicHead.TH,hands=MerlinicHands.TH}
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Ginsen",
		head="Nyame Helm",neck="Rep. Plat. Medal",ear1="Telos Earring",ear2="Sherida Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Ilabrat Ring",
		back="Phalangite Mantle",waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.precast.WS.PDT = set_combine(sets.precast.WS,{})
	
	sets.precast.WS['Exudation'] = set_combine(sets.precast.WS,{ammo="Crepuscular Pebble",
		neck="Fotia Gorget",ear1="Malignance Earring",ear2="Regal Earring",
		ring1="Metamorph Ring +1",ring2="Cornelia's Ring"})
	
	sets.precast.WS.acc = set_combine(sets.precast.WS, {}) 
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.		
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})
		
	sets.midcast.Geomancy = {}
	sets.midcast.Geomancy.base = {main="Idris",sub="Genmei Shield",ranged="Dunna",
		head="Bagua Galero +3",neck="Bagua Charm +2",ear1="Calamitous Earring",ear2="Azimuth Earring +1",
		body="Vedic Coat",hands="Shrieker's Cuffs",ring1="Freke Ring",ring2="Mephitas's Ring +1",
		back="Fi Follet Cape +1",waist="Shinjutsu-no-Obi +1",legs="Vanya Slops",feet="Amalric Nails +1"}
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy.base, {
		head="Vanya Hood",
		back=Lifestream.IndiDuration,legs="Bagua Pants +3",feet="Azimuth Gaiters +3"})
	
	sets.midcast['Dark Magic'] = {}
	sets.midcast['Dark Magic'].base = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Geo. Galero +2",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
		body="Geomancy Tunic +3",hands="Geo. Mitaines +3",ring1={name="Stikini Ring +1"},ring2={name="Stikini Ring +1"},
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Azimuth Tights +2",feet="Azimuth Gaiters +3"}
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'].base, {
		head="Bagua Galero +3",--ear1="Hirudinea Earring",
		ring1="Evanescence Ring",ring2="Archon Ring",
		waist="Fucho-no-Obi",feet="Agwu's Pigaches"})
	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Stun = sets.midcast['Dark Magic'].base
	
	sets.midcast['Enfeebling Magic'] = {}
	sets.midcast['Enfeebling Magic'].base = {main="Idris",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Geo. Galero +2",neck="Bagua Charm +2",ear1="Malignance Earring",ear2="Regal Earring",
		body="Geomancy Tunic +3",hands="Azimuth Gloves +2",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Geomancy Pants +3",feet="Geo. Sandals +2"}
	sets.midcast['Enfeebling Magic'].potency = set_combine(sets.midcast['Enfeebling Magic'].base,{})
	sets.midcast['Enfeebling Magic'].mndpot = set_combine(sets.midcast['Enfeebling Magic'].base,{ring1="Metamor. Ring +1"})
	sets.midcast['Enfeebling Magic'].skillmndpot = set_combine(sets.midcast['Enfeebling Magic'].base,{waist="Luminary Sash"})
	sets.midcast['Enfeebling Magic'].macc = set_combine(sets.midcast['Enfeebling Magic'].base,{})
	sets.midcast['Enfeebling Magic'].intpot = set_combine(sets.midcast['Enfeebling Magic'].base,{ring1="Metamor. Ring +1"})
	sets.midcast['Enfeebling Magic'].skillpot = set_combine(sets.midcast['Enfeebling Magic'].base,{})
	sets.midcast.LockedEnfeebles = {body="Geomancy Tunic +3"}
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'].macc,{head=empty,body="Crepuscular Cloak",ring1="Metamor. Ring +1",back="Aurist's Cape +1"})
	sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'].macc,{main="Daybreak"})
	sets.midcast['Enfeebling Magic'].SIRD = sets.midcast.SIRD
	
	sets.midcast['Enhancing Magic'] = {}
	sets.midcast['Enhancing Magic'].base = {main=Gada.Enh,sub="Ammurapi Shield",
		head=TelHead.Duration,neck="Incanter's Torque",ear1="Etiolation Earring",
		body=TelBody.Duration,hands=TelHands.Duration,
		waist="Embla Sash",legs=TelLegs.Duration,}
	sets.midcast['Enhancing Magic'].EnhancingSkill = set_combine(sets.midcast['Enhancing Magic'].base,{})
	sets.midcast['Enhancing Magic'].NoEnhancingSkill = {}
	sets.midcast.Stoneskin = {neck="Nodens Gorget",ear1="Earthcry Earring",hands="Stone Mufflers",waist="Siegel Sash",legs="Shedir Seraweels"}
	sets.midcast.Aquaveil = {
		main="Vadose Rod",sub="Ammurapi Shield",
		head="Amalric Coif +1",
		hands="Regal Cuffs",
		waist="Emphatikos Rope",legs="Shedir Seraweels"}
	sets.midcast['Enhancing Magic'].RefreshSpells = {head="Amalric Coif +1"}
	sets.midcast.BarSpells = {}
	sets.midcast.RegenSpells = {main="Bolelabunga"}
	sets.midcast.GainSpells = sets.midcast['Enhancing Magic'].EnhancingSkill
	sets.midcast.Cursna = {head="Vanya Hood",neck="Debilis Medallion",ear1="Meili Earring",ear2="Beatific Earring",hands="Hieros Mittens",ring1="Menelaus's Ring",ring2="Haoma's Ring",back="Oretan. Cape +1",waist="Bishop's Sash",legs="Vanya Slops",feet="Vanya Clogs"}
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'].base,{head=MerlinicHead.Phalanx,hands=MerlinicHands.Phalanx,legs=MerlinicLegs.Phalanx,feet=MerlinicFeet.Phalanx})
	
	sets.midcast.Protect = {ring1="Sheltered Ring"}
	sets.midcast.Protectra = {ring1="Sheltered Ring"}
	sets.midcast.Shell = {ring1="Sheltered Ring"}
	sets.midcast.Shellra = {ring1="Sheltered Ring"}
	sets.midcast.Sneak = {back="Skulker's Cape"}
	sets.midcast.Invisible = {back="Skulker's Cape"}
	
	sets.midcast['Elemental Magic'] = {}
	sets.midcast["Elemental Magic"].base = {main="Idris",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="Azimuth Hood +3",neck="Sibyl Scarf",ear1="Malignance Earring",ear2="Azimuth Earring +1",
		body="Azimuth Coat +3",hands="Azimuth Gloves +2",ring1="Freke Ring",ring2="Stikini Ring +1",
		back=gear.GEO_MAB_Cape,waist="Acuity Belt +1",legs="Azimuth Tights +2",feet="Azimuth Gaiters +3"}
	sets.midcast.Death = sets.midcast['Elemental Magic'].base
	sets.Burst = set_combine(sets.midcast["Elemental Magic"].base,{head="Ea Hat +1",body="Ea Houppe. +1",hands="Amalric Gages +1"}) --{ hands="Hattori Tekko +1", feet=HercFeet.MAB})
	
	sets.midcast.Cure = {main="Daybreak",Sub="Sacro Bulwark",
		head="Kaykaus Mitra +1",neck="Incanter's Torque",ear1="Mendicant's Earring",ear2="Novia Earring",
		body="Bunzi's Robe",hands="Kaykaus Cuffs +1",ring1="Kishar Ring",ring2="Naji's Loop",
		back="Ghostfyre Cape",waist="Bishop's Sash",legs="Kaykaus Tights +1",feet="Kaykaus Boots +1"}
	sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure,sets.midcast.SIRD)
	
	
	-- Sets to return to when not performing an action.
	sets.latent_refresh = {waist="Fucho-no-obi"}
	
	-- Idle sets
	sets.idle = {main="Daybreak",sub="Genmei Shield",ranged="Dunna",
		head="Azimuth Hood +3",neck="Elite Royal Collar",ear1="Odnowa Earring +1",ear2="Lugalbanda Earring",
		body="Azimuth Coat +3",hands="Bagua Mitaines +3",ring1="Defending Ring",ring2={name="Stikini Ring +1"},
		back=Nantosuelta.PetRegen,waist="Plat. Mog. Belt",legs="Volte Brais",feet="Azimuth Gaiters +3"}
	
	sets.idle.Pet = set_combine(sets.idle, {
		-- Pet: -DT (37.5% to cap)
		main="Idris",sub="Genmei Shield",
		head="Azimuth Hood +3",neck="Bagua Charm +2",ear1="Odnowa Earring +1",ear2="Azimuth Earring +1",
		body="Shamash Robe",hands="Geo. Mitaines +3",
		back=Nantosuelta.PetRegen,waist="Isa Belt",legs="Volte Brais",feet="Bagua Sandals +3"})
	sets.PetHP = {head="Bagua Galero +3"}
	sets.idle.PDT = set_combine(sets.idle.Pet,{})
	sets.idle.Town = sets.idle
	sets.resting = sets.idle 
	sets.Kiting = {ring2="Shneddick Ring +1"}
	sets.ElementalMagicMAB = {}
	
	-- Engaged sets
	
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ranged="Dunna",
		head="Azimuth Hood +3",neck="Combatant's Torque",ear1="Telos Earring",ear2="Crepuscular Earring",
		body="Nyame Mail",hands="Gazu Bracelets +1",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back=Nantosuelta.DexDA,waist="Windbuffet Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.engaged.PDT = set_combine(sets.engaged,{neck="Loricate Torque +1",ring1="Defending Ring"})
	sets.engaged.DW = set_combine(sets.engaged,{ear1="Suppanomimi",ear2="Eabani Earring"})
	sets.engaged.DW.PDT = set_combine(sets.engaged.DW,sets.engaged.PDT)
	
	
--	sets.engaged.Acc = set_combine(sets.engaged,{})
--	sets.engaged.Refresh = set_combine(sets.engaged,{})
--	sets.engaged.DW.Acc = set_combine(sets.engaged,{})
--	sets.engaged.DW.Refresh = set_combine(sets.engaged,{})
	
	sets.buff.Curse = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar Sash"}
	sets.Charm = {neck="Unmoving Collar +1",ear1="Arete Del Luna +1"}
	sets.Death = {neck="Warder's Charm +1",ring1="Shadow Ring",ring2="Warden's Ring"}
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
	if spell.english == 'Phalanx II' and spell.target.type == 'SELF' then
		cancel_spell()
		windower.send_command('input /ma "Phalanx" <me>')
	end	
end

function sird_sets()
	if state.IdleMode.value == 'PDT' then
		state.CastingMode:set('SIRD')
	else
		state.CastingMode:reset()
	end
end

function weathercheck(spell_element,set)
	if not set then return end
	if spell_element == world.weather_element or spell_element == world.day_element then
		equip(set,sets.Obis[spell_element])
	else
		equip(set)
	end
	if set[spell_element] then equip(set[spell_element]) end
end

function zodiaccheck(spell_element)
	if spell_element == world.day_element and spell_element ~= 'Dark' and spell_element ~= 'Light' then
		equip(sets.Zodiac)
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

function do_equip(setname)
	send_command('gs equip '..setname..'')
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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	check_weaponlock()
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
	end

	if spellMap == 'curespells' then
		weathercheck(spell.element,sets.midcast.Cure)
	end

	if spellMap == 'RefreshSpells' then
		if spell.target.type == 'SELF' then
			equip(sets.midcast['Enhancing Magic'].base,sets.midcast['Enhancing Magic'].RefreshSpells,{waist="Gishdubar Sash"})
		else
			equip(sets.midcast['Enhancing Magic'].base,sets.midcast['Enhancing Magic'].RefreshSpells)
		end
	end

	if spellMap == 'EnhancingSkill' then
		equip(sets.midcast.EnhancingSkill)
	end

	if spellMap == 'NoEnhancingSkill' then
		equip(sets.midcast['Enhancing Magic'].base)
	end

	if spellMap == 'RegenSpells' then
		equip(sets.midcast.RegenSpells)
	end

	if spellMap == 'BarSpells' then
		equip(sets.midcast.BarSpells)
	end

	if spellMap == 'Nuke' then
		weathercheck(spell.element,sets.midcast['Elemental Magic'].base)
		zodiaccheck(spell.element)
		if state.BurstMode.value then
			equip(sets.Burst)
		end
		--if sets.ElementalMagicMAB[spell.element] then
		--    equip(sets.ElementalMagicMAB[spell.element])
		--end
		--equip(sets.midcast["Elemental Magic"].base)
	end

	if spellMap == 'GainSpells' then
		equip(sets.midcast['Enhancing Magic'].GainSpells)
	end

	if spellMap == 'Impact' then
		weathercheck(spell.element,sets.midcast.Impact)
	end

	if spell.english == 'Death' then
		equip(sets.midcast.Death)
	end

	if spell.english == 'Phalanx' or spell.english == 'Phalanx II' then
		equip(sets.midcast['Enhancing Magic'].base)
	end

	if spell.skill == 'Enfeebling Magic' and newLuopan == 1 then
		-- prevent Cohort Cloak from unequipping head when relic head is locked
		equip(sets.midcast.LockedEnfeebles)
	end

	if spellMap == 'GeoSpells' then
		if buffactive.Entrust and spell.english:startswith('Indi-') then
			equip(sets.midcast.Geomancy.Indi,{main=Gada.Indi})
		elseif spell.english:startswith('Indi-') then
			equip(sets.midcast.Geomancy.Indi)
		else
			equip(sets.midcast.Geomancy.base)
		end
	end

	if spell.english == 'Dia' or  spell.english == 'Dia II' or spell.english == 'Dia III' then
		--equip({ring1="Weather. Ring +1"})
	end

	if sets.midcast[spell.name] then
		weathercheck(spell.element,sets.midcast[spell.name])
	end

	if spell.skill then
		--equip(sets.aftercast.Idle,sets.aftercast[tp_level])
		weathercheck(spell.element,sets.midcast[spell.skill])
	end

	if spellMap == 'ImmunobreakSpells' and state.Immunobreak.value then
		equip(sets.Immunobreak)
	end


end

function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.english == "Sleep II" then
			send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
		elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
			send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
		elseif spell.english:startswith('Geo-') or spell.english == "Life Cycle" then
			newLuopan = 1
		end
	end
end

-- function to interpet the spell maps
function job_get_spell_map(spell, default_spell_map)
	if spell.skill == 'Enhancing Magic' or spell.skill == 'Enfeebling Magic' or spell.skill == 'Elemental Magic' or spell.skill == 'Geomancy' then
		for category,spell_list in pairs(magic_maps) do
			if spell_list:contains(spell.english) then
				return category
			end
		end
	end	
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
			do_equip('sets.midcast.Phalanx')
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

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
--	if state.Buff[buff] ~= nil then
--		state.Buff[buff] = gain
--	end
	
	if S{'sleep'}:contains(buff:lower()) then
		determine_sleep_state()
	end	
		
end

function job_pet_change(petparam, gain)
	if gain == false then
		send_command('@timers d "'..geo_timer..'"')
		enable('head')
		newLuopan = 0
	end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	check_weaponlock()
	if player.mpp < 51 then
		set_combine(idleSet, sets.latent_refresh)
	end
	if state.ExtraRefresh.value then
		idleSet = set_combine(idleSet,{ring1="Stikini Ring +1",ring2="Stikini Ring +1"})
	end
	if state.IdleMode.value == 'PDT' then
		idleSet = sets.idle.PDT
	end
	if pet.isvalid then
		if pet.hpp > 73 then
			if newLuopan == 1 then
				equip(sets.PetHP)
				disable('head')
				idleSet = set_combine(idleSet,{legs="Nyame Flanchard"})
			end
		elseif pet.hpp <= 73 then
			enable('head')
			idleSet = set_combine(idleSet,{neck="Bagua Charm +2"})
			newLuopan = 0
		end
	end
	if state.CursnaGear.value and (buffactive['Doom'] or buffactive['Bane']) then
	    --if state.Buff['Curse'] or state.Buff['Doom'] or state.Buff['Bane'] then
		idleSet = set_combine(idleSet,sets.buff.Curse)
	end
	if  state.ExtraResist.value == 'Charm' then
		idleSet = set_combine(idleSet,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		idleSet = set_combine(idleSet,sets.Death)
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
	end
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		restingSet = set_combine(restingSet,sets.buff.Curse)
	else
		restingSet = set.resting
	end
	if state.Kalasiris.value then
		restingSet = set_combine(restingSet,{body="Annoint. Kalasiris"})
	end
	return restingSet
end

function customize_melee_set(meleeSet)

	if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
		state.DualWielding = true
	else
		state.DualWielding = false
	end

	if state.HybridMode.value == 'PDT' and not (buffactive['Enfire'] or buffactive['Enblizzard'] or buffactive['Enaero'] or buffactive['Enstone'] or buffactive['Enthunder'] or buffactive['Enwater']) then
		if state.DualWielding then
			meleeSet = set_combine(meleeSet,sets.engaged.DW.PDT)
		else
			meleeSet = set_combine(meleeSet, sets.engaged.PDT)
		end
	end

	if buffactive['Enfire'] or buffactive['Enblizzard'] or buffactive['Enaero'] or buffactive['Enstone'] or buffactive['Enthunder'] or buffactive['Enwater'] then
		if state.DualWielding then
			meleeSet = set_combine(meleeSet,sets.engaged.enspell.DW)  --uses Orpheus in set
			if state.HybridMode.value == 'PDT' then
				meleeSet = set_combine(meleeSet,sets.engaged.DW.enspell.PDT)
			end
		else
			meleeSet = set_combine(meleeSet,sets.engaged.enspell)  --uses Orpheus in set
			if state.HybridMode.value == 'PDT' then
				meleeSet = set_combine(meleeSet, sets.engaged.enspell.PDT)
			end
		end	
		-- Matching double weather (w/o day conflict).
		if (buffactive['Enfire'] and world.weather_element == 'Fire' and (get_weather_intensity() == 2 and 'Fire' ~= elements.weak_to[world.day_element])) or
			(buffactive['Enblizzard'] and world.weather_element == 'Ice' and (get_weather_intensity() == 2 and 'Ice' ~= elements.weak_to[world.day_element])) or
			(buffactive['Enaero'] and world.weather_element == 'Wind' and (get_weather_intensity() == 'Wind' and 'Wind' ~= elements.weak_to[world.day_element])) or
			(buffactive['Enstone'] and world.weather_element == 'Earth' and (get_weather_intensity() == 'Earth' and 'Earth' ~= elements.weak_to[world.day_element])) or
			(buffactive['Enthunder'] and world.weather_element == 'Lightning' and (get_weather_intensity() == 2 and 'Lightning' ~= elements.weak_to[world.day_element])) or
			(buffactive['Enwater'] and world.weather_element == 'Water' and (get_weather_intensity() == 2 and 'Water' ~= elements.weak_to[world.day_element])) or
		-- Matching day and weather.
			(buffactive['Enfire'] and world.day_element == 'Fire' and world.weather_element == 'Fire')  or
			(buffactive['Enblizzard'] and world.day_element == 'Ice' and world.weather_element == 'Ice')  or
			(buffactive['Enaero'] and world.day_element == 'Wind' and world.weather_element == 'Wind')  or
			(buffactive['Enstone'] and world.day_element == 'Earth' and world.weather_element == 'Earth')  or
			(buffactive['Enthunder'] and world.day_element == 'Lightning' and world.weather_element == 'Lightning')  or
			(buffactive['Enwater'] and world.day_element == 'Water' and world.weather_element == 'Water')  or
		-- Match day or weather.
			(buffactive['Enfire'] and (world.day_element == 'Fire' or world.weather_element  == 'Fire')) or
			(buffactive['Enblizzard'] and (world.day_element == 'Ice' or world.weather_element  == 'Ice')) or
			(buffactive['Enaero'] and (world.day_element == 'Wind' or world.weather_element  == 'Wind')) or
			(buffactive['Enstone'] and (world.day_element == 'Earth' or world.weather_element  == 'Earth')) or
			(buffactive['Enthunder'] and (world.day_element == 'Lightning' or world.weather_element  == 'Lightning')) or
			(buffactive['Enwater'] and (world.day_element == 'Water' or world.weather_element  == 'Water')) then
				meleeSet = set_combine(meleeSet,{waist="Hachirin-no-Obi"})
		else
			meleeSet = set_combine(meleeSet,{waist="Orpheus's Sash"})
		end
	end

	if state.CursnaGear.value and (buffactive['Doom'] or buffactive['Bane']) then
		meleeSet = set_combine(meleeSet,sets.buff.Curse)
	end
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
		meleeSet = set_combine(meleeSet,sets.engaged.PDT)
	end
	if  state.ExtraResist.value == 'Charm' then
		meleeSet = set_combine(meleeSet,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		meleeSet = set_combine(meleeSet,sets.Death)
	end
	if state.Kalasiris.value then
		meleeSet = set_combine(meleeSet,{body="Annoint. Kalasiris"})
	end	
	
--	add_to_chat(8,world.weather_element)
--	add_to_chat(8,world.day_element)
	
	
	-- this section added for Odin soloing. Try to refactor it later...
	if state.AccMode.value then
		meleeSet = set_combine(meleeSet,sets.engaged.enspell.DW.Acc)
	end
	
	return meleeSet
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_combat_form()
	determine_sleep_state()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
	-- Check for H2H or single-wielding
	classes.CustomMeleeGroups:clear()
	if player.equipment.sub == "Beatific Shield +1" or player.equipment.sub == "Sacro Bulwark"  or player.equipment.sub == 'empty' then
		if buffactive['Enfire'] or buffactive['Enblizzard'] or buffactive['Enaero'] or buffactive['Enstone'] or buffactive['Enthunder'] or buffactive['Enwater'] then
			state.CombatForm:set('enspell')
		else
			state.CombatForm:reset()
		end
	else
		if buffactive['Enfire'] or buffactive['Enblizzard'] or buffactive['Enaero'] or buffactive['Enstone'] or buffactive['Enthunder'] or buffactive['Enwater'] then
			state.CombatForm:set('DW')
			classes.CustomMeleeGroups:append('enspell')
		else
			state.CombatForm:set('DW')
		end
	end
end

function display_current_job_state(eventArgs)
	if state.CombatForm.has_value then
		om_msg = state.CombatForm.value
	else
		om_msg = 'Normal'
	end
	if state.HybridMode.has_value then
		dt_msg = state.HybridMode.value
	else 
		dt_msg = 'Normal'
	end
--	if state.WeaponskillMode.has_value then
--		wm_msg = state.WeaponskillMode.value
--	else
--		wm_msg = 'Normal'
--	end
	if state.TreasureMode.has_value then
		tm_msg = state.TreasureMode.value
	else
		tm_msg = 'Off'
	end
	if state.AccMode.value then
		am_msg = 'On'
	else
		am_msg = 'Off'
	end
	if state.ExtraRefresh.value then
		er_msg = 'On'
	else
		er_msg = 'Off'
	end
	if state.BurstMode.value then
		bm_msg = 'On'
	else
		bm_msg = 'Off'
	end
	if state.IdleMode.has_value then
		dt_msg = state.IdleMode.value
	else 
		dt_msg = 'Normal'
	end
	if state.ExtraResist.value then
		extraresist_msg = state.ExtraResist.value
	else
		extraresist_msg = 'Off'
	end
	if state.Immunobreak.value then
		immunobreak_msg = 'On'
	else
		immunobreak_msg = 'Off'
	end
	if state.CursnaGear.value then
		cursnagear_msg = 'On'
	else
		cursnagear_msg = 'Off'
	end
	if state.WeaponLock.value == true then
		wl_msg = 'On'
	else
		wl_msg = 'Off'
	end
	if state.CastingMode.has_value then
		cm_msg = state.CastingMode.value
	else 
		cm_msg = 'Normal'
	end
	
	local msg = ''
	if state.Kiting.value then
		msg = msg .. ' Kiting: On'
	else 
		msg = msg .. ' Kiting: Off'
	end

	add_to_chat(string.char(31,210).. 'OffenseMode: ' ..string.char(31,001)..om_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' DTMode: ' ..string.char(31,001)..dt_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' CastingMode: ' ..string.char(31,001)..cm_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' TreasureMode: ' ..string.char(31,001)..tm_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' BurstMode: ' ..string.char(31,001)..bm_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' ExtraRefresh: ' ..string.char(31,001)..er_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' ExtraResist: ' ..string.char(31,001)..extraresist_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' AccMode: ' ..string.char(31,001)..am_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' ImmunobreakMode: ' ..string.char(31,001)..immunobreak_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' CursnaGear: ' ..string.char(31,001)..cursnagear_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' WeaponLock: ' ..string.char(31,001)..wl_msg.. string.char(31,002)..  ' |'
		..string.char(31,002)..msg)

	eventArgs.handled = true
	
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(5, 11)
	else
		set_macro_page(5, 11)
	end
end

function set_style(sheet)
	send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(40) 
