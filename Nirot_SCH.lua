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
	res = require('resources')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Light Arts'] = buffactive['Light Arts'] or false
    state.Buff['Dark Arts'] = buffactive['Dark Arts'] or false
	state.Buff["Sublimation: Activated"] = buffactive["Sublimation: Activated"] or false
	state.Buff["Sublimation: Complete"] = buffactive["Sublimation: Complete"] or false
	--Light Arts stratagems:
	state.Buff["Penury"] = buffactive["Penury"] or false
	state.Buff["Addendum: White"] = buffactive["Addendum: White"] or false
	state.Buff["Celerity"] = buffactive["Celerity"] or false
	state.Buff["Accession"] = buffactive["Accession"] or false
	state.Buff["Rapture"] = buffactive["Rapture"] or false
	state.Buff["Altruism"] = buffactive["Altruism"] or false
	state.Buff["Tranquility"] = buffactive["Tranquility"] or false
	state.Buff["Perpetuance"] = buffactive["Perpetuance"] or false
	--Dark Arts stratagems:
	state.Buff["Parsimony"] = buffactive["Parsimony"] or false
	state.Buff["Alacrity"] = buffactive["Alacrity"] or false
	state.Buff["Addendum: Black"] = buffactive["Addendum: Black"] or false
	state.Buff["Manifestation"] = buffactive["Manifestation"] or false
	state.Buff["Ebullience"] = buffactive["Ebullience"] or false
	state.Buff["Focalization"] = buffactive["Focalization"] or false
	state.Buff["Equanamity"] = buffactive["Equanamity"] or false
	state.Buff["Immanence"] = buffactive["Immanence"] or false
	
	no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)","Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

	
    magic_maps = {}
		
	magic_maps.curespells = S{
		'Cura','Cura II','Cura III','Curaga','Curaga II','Curaga III','Curaga IV','Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI'
	}
	
	magic_maps.potency = S{
		'Dia','Dia II','Dia III','Bio','Bio II','Bio III',
		'Gravity','Gravity II'
	}
	
	magic_maps.mndpot = S{
		'Paralyze','Paralyze II','Slow','Slow II','Addle','Addle II'
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
		'Aquaveil','Blaze Spikes','Enaero','Enaero II','Enblizzard','Enblizzard II','Enfire','Enfire II','Enstone','Enstone II','Enthunder','Enthunder II','Enwater','Enwater II','Ice Spikes','Phalanx','Phalanx II','Shock Spikes','Stoneskin','Temper','Temper II'
	}	
	
	magic_maps.NoEnhancingSkill = S{
		'Adloquium','Animus Minuo','Blink','Deodorize','Erase','Escape','Flurry','Flurry II','Haste','Haste II','Invisible','Protect','Protect II','Protect III','Protect IV','Protect V','Protectra','Protectra II','Protectra III','Protectra IV','Protectra V','Retrace','Shell','Shell II','Shell III','Shell IV','Shell V','Shellra','Shellra II','Shellra III','Shellra IV','Shellra V','Sneak','Warp','Warp II','Sandstorm','Rainstorm','Windstorm','Firestorm','Hailstorm','Thunderstorm','Voidstorm','Aurorastorm'
	}
	magic_maps.RegenSpells = S{
		'Regen','Regen II','Regen III','Regen IV','Regen V'
	}	
			
	magic_maps.ImmunobreakSpells = S{
		'Slow','Slow II','Paralyze','Paralyze II','Silence','Addle','Addle II','Blind','Blind II','Gravity','Gravity II','Bind','Poison','Break','Sleep','Sleep II'
	}

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
	state.ExtraResist = M('Normal','Charm','Death')
	state.Kalasiris = M(true, 'Kalasiris')
	state.BurstMode = M(true, 'BurstMode')
	state.WeaponLock = M(false, 'WeaponLocked')
	state.Immunobreak = M(false, 'Immunobreak')
	state.CursnaGear = M(false, 'CursnaGear')
	state.Kiting = M(true, 'Kiting')
	
    send_command('bind numpad. gs c cycle IdleMode')
	send_command('bind ^= gs c cycle Kiting')
	send_command('bind ^- gs c cycle CursnaGear')
    send_command('bind numpad7 gs c cycle BurstMode')
	send_command('bind numpad8 gs c cycle Kalasiris')
	send_command('bind numpad9 gs c cycle ExtraRefresh')
	send_command('bind F10 gs c cycle WeaponLock')

    select_default_macro_book()
	sird_sets()
	
	send_command('get "Storage Slip 23" sack') --ambu +2
	send_command('get "Storage Slip 29" sack') --empy +2
	
	PhalanxAbility = S{"Phalanx","Phalanx II"}
	RefreshAbility = S{"Refresh","Refresh II","Refresh III"}
	
	end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
	send_command('unbind numpad.')
	send_command('unbind ^=')
	send_command('unbind ^-')
	send_command('unbind numpad8')
	send_command('unbind numpad9')
	send_command('unbind F10')
end

-- Define sets and vars used by this job file.
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
	
    TelHead = {}
    TelBody = {}
    TelHands = {}
    TelLegs = {}
    TelFeet = {}
	
	VanyaHead = {}
	VanyaLegs = {}
	VanyaFeet = {}

	ChironicHead = {}
	ChironicHands = {}
	ChironicLegs = {}
	ChironicFeet = {}
	ChironicHead.Refresh = { name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
	ChironicHands.Refresh = { name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}}
	ChironicLegs.Refresh = { name="Chironic Hose", augments={'DEX+5','INT+4','"Refresh"+2','Accuracy+2 Attack+2',}}
	ChironicFeet.Refresh = { name="Chironic Slippers", augments={'"Fast Cast"+2','Mag. Acc.+18','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	
	MerlinicHead = {}
	MerlinicHands = {}
	MerlinicLegs = {}
	MerlinicFeet = {}
	MerlinicHead.Phalanx = {name="Merlinic Hood", augments={'Pet: Phys. dmg. taken -2%','"Resist Silence"+1','Phalanx +5','Accuracy+10 Attack+10','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	MerlinicHead.SIRD = { name="Merlinic Hood", augments={'Spell interruption rate down -9%','Pet: STR+1','"Refresh"+2','Accuracy+16 Attack+16',}}
	MerlinicHands.Phalanx = { name="Merlinic Dastanas", augments={'Crit. hit damage +1%','Attack+12','Phalanx +5','Accuracy+14 Attack+14',}}
	MerlinicFeet.FC = { name="Merlinic Crackows", augments={'"Conserve MP"+2','Pet: "Mag.Atk.Bns."+28','"Fast Cast"+8','Accuracy+4 Attack+4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
	MerlinicLegs.Phalanx = { name="Merlinic Shalwar", augments={'AGI+4','Mag. Acc.+6','Phalanx +4','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
	MerlinicFeet.Phalanx = { name="Merlinic Crackows", augments={'CHR+7','Magic Damage +1','Phalanx +4','Accuracy+6 Attack+6',}}
	
	TelHead.Duration = { name="Telchine Cap", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelBody.Duration = { name="Telchine Chas.", augments={'Mag. Evasion+21','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelHands.Duration = { name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelLegs.Duration = { name="Telchine Braconi", augments={'Mag. Evasion+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelFeet.Duration = { name="Telchine Pigaches", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	
	VanyaHead.HealSkill = { name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	VanyaLegs.HealSkill = { name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	VanyaFeet.HealSkill = { name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
		
	Empyrean = {}
	Empyrean.Hands = {name="Arbatel Bracers +3"}
	
	LughsCape = {}
	LughsCape.MAB = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}
	
	sets.Phalanx = {head=MerlinicHead.Phalanx,hands=MerlinicHands.Phalanx,legs=MerlinicLegs.Phalanx,feet=MerlinicFeet.Phalanx}
		
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main="Musa",Sub="Clerisy Strap +1",ammo="Sapience Orb",
		head="Acad. Mortar. +3",neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Acad. Bracers +3",ring1="Rahab Ring",ring2="Kishar Ring",
		back="Fi Follet Cape +1",waist="Embla Sash",legs="Volte Brais",feet="Acad. Loafers +3"}
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{waist="Siegel Sash"})
	sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC,{})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC,{head="Umuthi Hat",neck="Nodens Gorget",ear1="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	sets.precast.FC['Impact'] = set_combine(sets.precast.FC,{head=empty,body="Crepuscular Cloak",waist="Shinjutsu-no-Obi +1"})
	sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC,{main="Daybreak"})
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{waist="Siegel Sash"})

    sets.precast.FC.Aquaveil = set_combine(sets.precast.FC['Enhancing Magic'], {head={ name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC['Enhancing Magic'], {main="Daybreak",sub="Genmei Shield"})
	sets.precast.FC.Grimoire = {head="Peda. M.Board +3", feet="Acad. Loafers +3"}
	
    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
	sets.precast.JA.Sublimation = {head="Acad. Mortar. +3",body="Peda. Gown +3",waist="Embla Sash"}
    sets.precast.JA["Tabula Rasa"] = {body="Peda. Pants +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't 	any more specifically defined
    gear.default.weaponskill_neck = "" --"Asperity Necklace"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {ammo="Sroda Tathlum",
		head="Pixie Hairpin +1",neck="Combatant's Torque",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Arbatel Gown +3",hands="Jhakri Cuffs +2",ring1="Archon Ring",ring2="Epaminondas's Ring",
        back=LughsCape.MAB,waist="Hachirin-no-obi",legs="Arbatel Pants +3",feet="Arbatel Loafers +2"}
	sets.precast.WS.PDT = sets.precast.WS
    
    --sets.precast.WS['Flash Nova'] = {
    --    head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
    --    body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
    --    back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    

    -- Midcast Sets
	
    sets.midcast.FastRecast = set_combine(sets.precast.FC,{})
	sets.midcast.SIRD = {ammo="Staunch Tathlum +1",
		head="Arbatel Bonnet +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Halasz Earring",
		body="Ros. Jaseran +1",hands=ChironicHands.Refresh,ring1="Freke Ring",ring2="Defending Ring",
		back="Fi Follet Cape +1",waist="Emphatikos Rope",legs="Arbatel Pants +3",feet="Amalric Nails +1"}
	
    -- Cure sets
    --gear.default.obi_waist = "Goading Belt"
    --gear.default.obi_back = "Mending Cape"
	
    sets.midcast.Cure = {main="Musa",Sub="Khonsu",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Mendicant's Earring",
        body="Arbatel Gown +3",hands="Kaykaus Cuffs +1",ring1="Naji's Loop",ring2="Defending Ring",
        back="Fi Follet Cape +1",waist="Shinjutsu-no-Obi +1",legs="Acad. Pants +3",feet="Kaykaus Boots +1"} 
	sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure,sets.midcast.SIRD)

    sets.midcast.Curaga = set_combine(sets.midcast.Cure,{})
	sets.midcast.Curaga.SIRD = set_combine(sets.midcast.Curaga,sets.midcast.SIRD)

    sets.midcast.CureMelee = {ammo="Staunch Tathlum +1",
		head="Arbatel Bonnet +3",neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Mendicant's Earring",
        body="Arbatel Gown +3",hands="Kaykaus Cuffs +1",ring1="Naji's Loop",ring2="Mephitas's Ring +1",
        back=LughsCape.MAB,waist="Shinjutsu-no-Obi +1",legs="Arbatel Pants +3",feet="Kaykaus Boots +1"}
	sets.midcast.CureMelee.SIRD = set_combine(sets.midcast.CureMelee,sets.midcast.SIRD)

    sets.midcast.Cursna = {main="Gada",Sub="Ammurapi Shield",
		head=VanyaHead.HealSkill,neck="Debilis Medallion",ear1="Meili Earring",ear2="Beatific Earring",
		body="Peda. Gown +3",hands="Hieros Mittens",ring1="Menelaus's Ring",ring2="Haoma's Ring",
        back="Oretania's Cape +1",waist="Bishop's Sash",legs="Acad. Pants +3",feet=VanyaFeet.HealSkill}
	sets.midcast.Cursna.SIRD = set_combine(sets.midcast.Cursna,sets.midcast.SIRD)
		
    sets.midcast.StatusRemoval = {}
	sets.midcast.StatusRemoval.SIRD = set_combine(sets.midcast.StatusRemoval,sets.midcast.SIRD)
	sets.midcast.Raise = sets.precast.FC
	sets.midcast.Raise.SIRD = set_combine(sets.midcast.Raise,sets.midcast.SIRD)
						
	sets.midcast.Erase = sets.midcast.StatusRemoval
	sets.midcast.Erase.SIRD = set_combine(sets.midcast.StatusRemoval,sets.midcast.SIRD)
    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	
	sets.midcast['Enhancing Magic'] = {}
    sets.midcast['Enhancing Magic'].base = set_combine(sets.precast.FC,{main="Musa",Sub="Khonsu",ammo="Pemphredo Tathlum",
		head=TelHead.Duration,neck="Incanter's Torque",ear1="Etiolation Earring",
		body=TelBody.Duration,hands=TelHands.Duration,
		waist="Embla Sash",legs=TelLegs.Duration,feet=TelFeet.Duration})
	sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast['Enhancing Magic'].base,sets.midcast.SIRD)
	sets.midcast['Haste'] = sets.midcast['Enhancing Magic'].base
	sets.midcast['Haste'].SIRD = set_combine(sets.midcast['Haste'],sets.midcast.SIRD)

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'].base,{
		head="Cath Palug Crown",neck="Nodens Gorget",ear1="Earthcry Earring",
		waist="Siegel Sash",legs="Shedir Seraweels"})
	sets.midcast.Stoneskin.SIRD = set_combine(sets.midcast.Stoneskin,sets.midcast.SIRD)
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'].base,{main="Vadose Rod",sub="Ammurapi Shield",
		head="Amalric Coif +1",hands="Regal Cuffs",
		waist="Emphatikos Rope",legs="Shedir Seraweels"})
	sets.midcast.Aquaveil.SIRD = set_combine(sets.midcast.Aquaveil,sets.midcast.SIRD)
    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'].base,{
		head=TelHead.Duration,neck="Incanter's Torque",ear2="Mendicant's Earring",
		body="Peda. Gown +3",hands=TelHands.Duration,ring1="Stikini Ring +1",ring2="Mephitas's Ring +1",
		back="Fi Follet Cape +1",waist="Embla Sash",legs=TelLegs.Duration,feet=TelFeet.Duration})
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'].base,{main="Musa",Sub="Khonsu",
		head="Arbatel Bonnet +3",
		body=TelBody.Duration,
		hands=TelHands.Duration,
		back="Bookworm's Cape",waist="Embla Sash",legs=TelLegs.Duration,feet=TelFeet.Duration})
	sets.midcast.RegenPerpetuance = set_combine(sets.midcast.Regen,{hands=Empyrean.Hands})
	sets.midcast.Regen.SIRD = set_combine(sets.midcast.Regen,sets.midcast.SIRD)
	sets.midcast['Enhancing Magic'].RefreshSpells = set_combine(sets.midcast['Enhancing Magic'].base,{head="Amalric Coif +1"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'].base,{waist="Embla Sash"})--{ring1="Sheltered Ring"}
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'].base,{waist="Embla Sash"})--{ring1="Sheltered Ring"}
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'].base,{ring1="Sheltered Ring"})
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'].base,{ring1="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'].base,{ring1="Sheltered Ring"})
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'].base,{ring1="Sheltered Ring"})
	sets.midcast.Sneak = set_combine(sets.midcast['Enhancing Magic'].base,{back="Skulker's Cape"})
	sets.midcast.Invisible = set_combine(sets.midcast['Enhancing Magic'].base,{back="Skulker's Cape"})
	
	sets.midcast['Elemental Magic'] = {}
	sets.midcast['Elemental Magic'].base = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",  --this is the "high tier free nuke" set from sch guide
		head="Agwu's Cap",neck="Argute Stole +2",ear1="Malignance Earring",ear2="Regal Earring",
		body="Arbatel Gown +3",hands=Empyrean.Hands,ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=LughsCape.MAB,waist="Skrymir Cord +1",legs="Agwu's Slops",feet="Arbatel Loafers +2"}
    sets.Burst = set_combine(sets.midcast['Elemental Magic'].base,{
		head="Agwu's Cap",
		hands="Agwu's Gages"})
    sets.BurstEbullience = set_combine(sets.midcast['Elemental Magic'].base,{
		head="Arbatel Bonnet +3",
		body="Agwu's Robe",hands="Agwu's Gages",ring1="Mujin Band",
		back=LughsCape.MAB}) 
	sets.Helix =set_combine(sets.midcast['Elemental Magic'].base,{
		body="Agwu's Robe",hands="Amalric Gages +1",ring2="Mallquis Ring",
		feet="Amalric Nails +1"})
	sets.BurstHelix = set_combine(sets.Helix,{
		head="Peda. M.Board +3",ear2="Arbatel Earring +1",
		hands="Agwu's Gages",ring2="Mujin Band",
		back=LughsCape.MAB,waist="Skrymir Cord +1",legs="Agwu's Slops",feet="Arbatel Loafers +2"})
	sets.midcast.Death = sets.midcast['Elemental Magic'].base
	sets.midcast.Kaustra = set_combine(sets.midcast['Elemental Magic'].base,{ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Agwu's Robe",hands="Amalric Gages +1",ring2="Archon Ring",
		back=LughsCape.MAB,legs="Amalric Slops +1",feet="Agwu's Pigaches"})
	
    sets.midcast['Divine Magic'] = set_combine(sets.precast.FC,{})
	sets.midcast.Banish = set_combine(sets.midcast['Elemental Magic'].base,{})
	sets.midcast.Banish.SIRD = set_combine(sets.midcast.Banish,sets.midcast.SIRD)

    sets.midcast['Dark Magic'] = {}
	sets.midcast['Dark Magic'].SIRD = set_combine(sets.midcast['Dark Magic'],sets.midcast.SIRD)

    -- Custom spell classes
	sets.midcast['Enfeebling Magic'] = {}
    sets.midcast['Enfeebling Magic'].base = {main="Contemplator +1",sub="Khonsu",
		head="Arbatel Bonnet +3",neck="Argute Stole +2",ear1="Snotra Earring",ear2="Arbatel Earring +1",
		body="Arbatel Gown +3",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Arbatel Pants +3",feet="Acad. Loafers +3"}
    sets.midcast['Enfeebling Magic'].potency = set_combine(sets.midcast['Enfeebling Magic'].base,{})
    sets.midcast['Enfeebling Magic'].mndpot = set_combine(sets.midcast['Enfeebling Magic'].base,{ring1="Metamor. Ring +1"})
    sets.midcast['Enfeebling Magic'].skillmndpot = set_combine(sets.midcast['Enfeebling Magic'].base,{waist="Luminary Sash"})
    sets.midcast['Enfeebling Magic'].macc = set_combine(sets.midcast['Enfeebling Magic'].base,{})
    sets.midcast['Enfeebling Magic'].intpot = set_combine(sets.midcast['Enfeebling Magic'].base,{ring1="Metamor. Ring +1"})
    sets.midcast['Enfeebling Magic'].skillpot = set_combine(sets.midcast['Enfeebling Magic'].base,{})
	sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'].macc,{main="Daybreak"})
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'].macc,{ammo="Pemphredo Tathlum",
		head=empty,body="Crepuscular Cloak",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1"})
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Daybreak",Sub="Genmei Shield",ammo="Homiliary",
		head={ name="Chironic Hat", augments={'"Dbl.Atk."+2','Accuracy+9 Attack+9','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},neck="Clr. Torque +2",ear1="Telos Earring",ear2="Ethereal Earring",
        body="Arbatel Gown +3",hands={ name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}},ring1="Chirich Ring +1",ring2="Defending Ring",
        back=LughsCape.MAB,waist="Hachirin-no-obi",legs={ name="Chironic Hose", augments={'DEX+5','INT+4','"Refresh"+2','Accuracy+2 Attack+2',}},feet={ name="Chironic Slippers", augments={'"Fast Cast"+2','Mag. Acc.+18','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Mpaca's Staff",Sub="Khonsu",ammo="Homiliary",
		head=ChironicHead.Refresh,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Arbatel Gown +3",hands=ChironicHands.Refresh,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=LughsCape.MAB,waist="Embla Sash",legs="Arbatel Pants +3",feet=ChironicFeet.Refresh}
    sets.idle.Town = set_combine(sets.idle,{})
    sets.idle.Weak = sets.idle
    sets.idle.PDT = {main="Malignance Pole",Sub="Mensch Strap +1",ammo="Homiliary",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Eabani Earring",
        body="Arbatel Gown +3",hands={ name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}},ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=LughsCape.MAB,waist="Carrier's Sash",feet="Nyame Sollerets"}
    
    -- Defense sets

    sets.defense.PDT = sets.idle.PDT

    sets.Kiting = {ring1="Shneddick Ring +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}
	
	sets.ExtraRegen = {ring2="Chirich Ring +1"}
	sets.SublimationCharging = {head="Acad. Mortar. +3",body="Peda. Gown +3",waist="Embla Sash"}
	sets.SublimationFull = {head="Arbatel Bonnet +3",waist="Carrier's Sash"}
	sets.SublimationOff = {head="Arbatel Bonnet +3",waist="Carrier's Sash"}
	sets.Immanence = {head="Nyame Helm",neck="Warder's Charm +1",body="Nyame Mail",hands="Arbatel Bracers +3",back=LughsCape.MAB}
	sets.EbullienceMB = {head="Arbatel Bonnet +3",ring1="Mujin Band"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {ammo="Staunch Tathlum +1",
		head="Arbatel Bonnet +3",neck="Combatant's Torque",ear1="Dominance Earring +1",ear2="Telos Earring",
        body="Arbatel Gown +3",hands="Gazu Bracelets +1",ring1="Ephramad's Ring",ring2="Chirich Ring +1",
        back=LughsCape.MAB,waist="Windbuffet Belt +1",legs="Arbatel Pants +3",feet="Arbatel Loafers +2"}
	sets.engaged.PDT = set_combine(sets.engaged,{neck="Loricate Torque +1"})

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
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then
        equip(sets.precast.FC.Grimoire)
    elseif spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
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

function check_reaction(act)

	--Gather Info
    local curact = T(act)
    local actor = T{}
	local otherTarget = T{}

    actor.id = curact.actor_id
	
	if not ((curact.category == 8) or curact.category == 4) then return end  --8 is begin casting, 4 is completed casting
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
	
	if curact.targets[1].id == player.id then
		otherTarget.in_party = false
		otherTarget.in_alliance = false
		targetsMe = true
		targetsSelf = false
		targetsDistance = 0
	else
		targetsSelf = false
		targetsMe = false
	end
		
	-- Make sure it's not US from this point on!
	if actor.id == player.id then return end
    -- Make sure it's a WS or MA precast before reacting to it.		
    if not (curact.category == 7 or curact.category == 8) then return end  -- 7 is begin JA, 8 is begin casting
	
    -- Get the name of the action.
    if curact.category == 8 then act_info = res.spells[curact.targets[1].actions[1].param] end
	if act_info == nil then return end

	if targetsMe then
		if PhalanxAbility:contains(act_info.name) then
			do_equip('sets.Phalanx')
			windower.send_command('wait 2.5;gs c update user')
		end
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

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spellMap == 'curespells' then
        weathercheck(spell.element,sets.midcast.Cure)
	end
	
	if spellMap == 'RefreshSpells' then
		if buffactive['Perpetuance'] then
			equip(sets.midcast['Enhancing Magic'].RefreshSpells,{hands=Empyrean.Hands,waist="Gishdubar Sash"})
		else
			equip(sets.midcast['Enhancing Magic'].RefreshSpells,{waist="Gishdubar Sash"})
		end
	end
	
	if spellMap == 'EnhancingSkill' then
		if buffactive['Perpetuance'] then
			equip(sets.midcast['Enhancing Magic'].base,sets.midcast.EnhancingSkill,{hands=Empyrean.Hands})
		else
			equip(sets.midcast['Enhancing Magic'].base,sets.midcast.EnhancingSkill)
		end
	end
	
	if spellMap == 'NoEnhancingSkill' then
		if buffactive['Perpetuance'] then
			equip(sets.midcast['Enhancing Magic'].base,{hands=Empyrean.Hands})
		else
			equip(sets.midcast['Enhancing Magic'].base)
		end
	end
	
	if spellMap == 'RegenSpells' then
		if buffactive['Perpetuance'] then
			equip(sets.midcast.RegenPerpetuance)
		else
			equip(sets.midcast.Regen)
		end
	end
	
	if spellMap == 'BarSpells' then
		if buffactive['Perpetuance'] then
			equip(sets.midcast['Enhancing Magic'].base,sets.midcast.BarSpells,{hands=Empyrean.Hands})
		else
			equip(sets.midcast['Enhancing Magic'].base,sets.midcast.BarSpells)
		end
	end
	
	if spellMap == 'Nuke' then
        weathercheck(spell.element,sets.midcast['Elemental Magic'].base)
        zodiaccheck(spell.element)
		if buffactive['Immanence'] then
			equip(sets.Immanence)
		end
		if state.BurstMode.value then
			equip(sets.Burst)
			if string.find(spell.english,'helix') then
				equip(sets.BurstHelix)
			end
			
			if buffactive['Ebullience'] then
				equip(sets.EbullienceMB)
			end
		elseif string.find(spell.english,'helix') then
			equip(sets.Helix)
		end
        --if sets.ElementalMagicMAB[spell.element] then
        --    equip(sets.ElementalMagicMAB[spell.element])
        --end
		--equip(sets.midcast["Elemental Magic"].base)
	end
	
	if spellMap == 'GainSpells' then
		if buffactive['Perpetuance'] then
			equip(sets.midcast['Enhancing Magic'].GainSpells,{hands=Empyrean.Hands})
		else
			equip(sets.midcast['Enhancing Magic'].GainSpells)
		end
	end
	
    if spellMap == 'Impact' then
        weathercheck(spell.element,sets.midcast.Impact)
	end
	
    if spell.english == 'Death' then
        equip(sets.midcast.Death)
	end
	
	if spell.english == 'Phalanx' or spell.english == 'Phalanx II' then
		if buffactive['Perpetuance'] then
			equip(sets.midcast['Enhancing Magic'].base,sets.Phalanx,{hands=Empyrean.Hands})
		else
			equip(sets.midcast['Enhancing Magic'].base,sets.Phalanx)
		end
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
		
	--add_to_chat(8,spellMap)
	
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
	if spell.skill then
		equip(idleSet)
	end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Enhancing Magic' or spell.skill == 'Enfeebling Magic' or spell.skill == 'Elemental Magic' then
        for category,spell_list in pairs(magic_maps) do
            if spell_list:contains(spell.english) then
                return category
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
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
	    --if state.Buff['Curse'] or state.Buff['Doom'] or state.Buff['Bane'] then
		idleSet = set_combine(idleSet,sets.buff.Curse)
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
	if buffactive["Sublimation: Activated"] then
		idleSet = set_combine(idleSet,sets.SublimationCharging)
	elseif buffactive["Sublimation: Complete"] then
		idleSet = set_combine(idleSet,sets.SublimationFull)
	else
		idleSet = set_combine(idleSet,sets.SublimationOff)
	end
	if state.Kiting.value then
		idleSet = set_combine(idleSet,sets.Kiting)
	end
	sird_sets()
    return idleSet
end

function customize_resting_set(restingSet)
	check_weaponlock()
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		restingSet = set_combine(restingSet,sets.buff.Curse)
	else
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
end

function customize_melee_set(meleeSet)

	if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
		state.DualWielding = true
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

	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
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
	
    return meleeSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
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
        msg = msg .. ' | Kiting'
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
    if state.CursnaGear.value then
        cursnagear_msg = 'On'
	else
        cursnagear_msg = 'Off'
    end
	
    add_to_chat(string.char(31,210).. 'DTMode: ' ..string.char(31,001)..dt_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' SIRD: ' ..string.char(31,001)..cm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' ExtraRefresh: ' ..string.char(31,001)..er_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' CursnaGear: ' ..string.char(31,001)..cursnagear_msg.. string.char(31,002)..  ' |'
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
    set_macro_page(5, 25)
end

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(39) 