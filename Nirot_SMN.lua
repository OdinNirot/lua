-- Summoner Gearswap Lua by Pergatory - http://pastebin.com/u/pergatory
-- IdleMode determines the set used after casting. You change it with "/console gs c <IdleMode>"
-- The modes are:
-- Refresh: Uses the most refresh available.
-- DT: A mix of refresh, PDT, and MDT to help when you can't avoid AOE.
-- PetDT: Sacrifice refresh to reduce avatar's damage taken. WARNING: Selenian Cap drops you below 119, use with caution!
-- DD: When melee mode is on and you're engaged, uses TP gear. Otherwise, avatar melee gear.
-- Favor: Uses Beckoner's Horn and max smn skill to boost the favor effect.
-- Zendik: Favor build with the Zendik Robe added in, for Shiva's Favor in manaburn parties. (Shut up, it sounded like a good idea at the time)

-- Additional Bindings:
-- F9 - Toggles between a subset of IdleModes (Refresh > DT > PetDT)
-- F10 - Toggles MeleeMode (When enabled, equips Nirvana and Elan+1, then disables those 2 slots from swapping)
--       NOTE: If you don't already have the Nirvana & Elan+1 equipped, YOU WILL LOSE TP

-- Additional Commands:
-- /console gs c AccMode - Toggles high-accuracy sets to be used where appropriate.
-- /console gs c ImpactMode - Toggles between using normal magic BP set for Fenrir's Impact or a custom high-skill set for debuffs.
-- /console gs c ForceIlvl - I have this set up to override a few specific slots where I normally use non-ilvl pieces.
-- /console gs c TH - Treasure Hunter toggle. By default, this is only used for Dia, Dia II, and Diaga.
-- /console gs c LagMode - Used to help BPs land in the right gear in high-lag situations.
--							Sets a timer to swap gear 0.5s after the BP is used rather than waiting for server response.

function file_unload()
	send_command('unbind bind numpad.')
	send_command('unbind ^f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
end

function get_sets()

	send_command('bind numpad. gs c ToggleIdle') -- F9 = Cycle through commonly used idle modes
	send_command('bind ^f9 gs c ForceIlvl') -- Ctrl+F9 = Toggle ForceIlvl
	send_command('bind f10 gs c MeleeMode') -- F10 = Toggle Melee Mode
	send_command('bind ^f10 gs c TH') -- Ctrl+F10 = Treasure Hunter toggle

	-- Set your merits here. This is used in deciding between Enticer's Pants or Apogee Slacks +1.
	-- To change in-game, "/console gs c MeteorStrike3" will change Meteor Strike to 3/5 merits.
	-- The damage difference is very minor unless you're over 2400 TP.
	-- It's ok to just always use Enticer's Pants and ignore this section.
	MeteorStrike = 0
	HeavenlyStrike = 0
	WindBlade = 5
	Geocrush = 0
	Thunderstorm = 5
	GrandFall = 0

	StartLockStyle = '26'
	IdleMode = 'Refresh'
	AccMode = false
	ImpactDebuff = false
	MeleeMode = false
	TreasureHunter = false
	THSpells = S{"Dia","Dia II","Diaga"} -- If you want Treasure Hunter gear to swap for a spell/ability, add it here.
	ForceIlvl = false
	LagMode = false -- Default LagMode. If you have a lot of lag issues, change to "true".
		-- Warning: LagMode can cause problems if you spam BPs during Conduit because it doesn't trust server packets to say whether the BP is readying or not.
	SacTorque = true -- If you have Sacrifice Torque, this will auto-equip it when slept in order to wake up.
	AutoRemedy = false -- Auto Remedy when using an ability while Paralyzed.
	AutoEcho = false -- Auto Echo Drop when using an ability while Silenced.

	-- ===================================================================================================================
	--		Sets
	-- ===================================================================================================================

	MerlinicHead = {}
	MerlinicHands = {}
	MerlinicLegs = {}
	MerlinicFeet = {}
	TelHead = {}
	TelBody = {}
	TelHands = {}
	TelLegs = {}
	TelFeet = {}
	HeliosHead = {}
	HeliosHands = {}
	HeliosFeet = {}
	ApogeeHead = {}
	ApogeeBody = {}
	ApogeeLegs = {}
	ApogeeFeet = {}
	VanyaHead = {}
	VanyaLegs = {}
	VanyaFeet = {}
	Grio = {}
	Campestres = {}

	MerlinicHands.Refresh = { name="Merlinic Dastanas", augments={'Pet: STR+3','STR+8','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}
	MerlinicHands.TH = { name="Merlinic Dastanas", augments={'MND+5','Weapon Skill Acc.+2','"Treasure Hunter"+2',}}
	MerlinicHead.TH = { name="Merlinic Hood", augments={'Mag. Acc.+22','"Dbl.Atk."+3','"Treasure Hunter"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}
	MerlinicLegs.Refresh = { name="Merlinic Shalwar", augments={'Pet: Mag. Acc.+1','Accuracy+4 Attack+4','"Refresh"+2','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}
	MerlinicFeet.Refresh = { name="Merlinic Crackows", augments={'"Dual Wield"+1','Enmity-2','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}

	TelHead.Duration = { name="Telchine Cap", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelBody.Duration = { name="Telchine Chas.", augments={'Mag. Evasion+21','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelHands.Duration = { name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelLegs.Duration = { name="Telchine Braconi", augments={'Mag. Evasion+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelFeet.Duration = { name="Telchine Pigaches", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}

	HeliosHead.PhysBP = { name="Helios Band", augments={'Pet: Attack+29 Pet: Rng.Atk.+29','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}}
	HeliosHands.PetMelee = { name="Helios Gloves", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','Pet: "Dbl. Atk."+8','Pet: Haste+6',}}
	HeliosFeet.PhysBP = { name="Helios Boots", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}}
	HeliosFeet.PetMelee = { name="Helios Boots", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Dbl. Atk."+8','Pet: Haste+6',}}

	ApogeeHead.PetDT = { name="Apogee Crown +1", augments={'Pet: Accuracy+25','"Avatar perpetuation cost"+7','Pet: Damage taken -4%',}}
	ApogeeBody.MagBP = { name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	ApogeeLegs.PhysBP = { name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}}
	ApogeeLegs.MagBP = { name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	ApogeeFeet.PhysBP = { name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}}
	ApogeeFeet.MagBP = { name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}

	VanyaHead.HealSkill = { name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	VanyaLegs.HealSkill = { name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	VanyaFeet.HealSkill = { name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}

	Grio.PetMAB = { name="Grioavolr", augments={'Blood Pact Dmg.+10','Pet: INT+15','Pet: Mag. Acc.+20','Pet: "Mag.Atk.Bns."+21','DMG:+7',}}
	Campestres.CapeA = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+5 Pet: Rng.Atk.+5','Pet: "Regen"+10','Pet: Damage taken -5%',}}

	-- Base Damage Taken Set - Mainly used when IdleMode is "DT"
	sets.PDT_Base = {
		main="Nirvana",
		sub="Khonsu",
		head="Beckoner's Horn +3",
		neck="Smn. Collar +2",
		ear1="Cath Palug Earring",
		ear2="Beck. Earring +1",
		body="Bunzi's Robe",
		hands=MerlinicHands.Refresh,
		ring1="Gelatinous Ring +1",
		ring2="Defending Ring",
		back=Campestres.CapeA,
		waist="Regal Belt",
		legs="Assiduity Pants +1",
		feet=MerlinicFeet.Refresh
	}

	-- Treasure Hunter set. Don't put anything in here except TH+ gear.
	-- It overwrites slots in other sets when TH toggle is on (Ctrl+F10).
	sets.TH = {head=MerlinicHead.TH,hands=MerlinicHands.TH}
	sets.SacTorque = {neck="Sacrifice Torque"}

	sets.precast = {}

	-- Fast Cast
	sets.precast.FC = {main="Oranyan",sub="Clerisy Strap +1",
		head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},neck="Orunmila's Torque",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands=TelHands.Duration,ring1="Rahab Ring",ring2="Kishar Ring",
		back="Perimede Cape",waist="Witful Belt",legs=TelLegs.Duration,feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}}}

	sets.precast["Dispelga"] = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi Shield"})

	sets.midcast = {}

	-- BP Timer Gear
	-- Use BP Recast Reduction here, along with Avatar's Favor gear.
	-- Avatar's Favor skill tiers are 512 / 575 / 670.
	sets.midcast.BP = {main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},sub="Vox Grip",ammo="Epitaph",
		head="Beckoner's Horn +3",neck="Incanter's Torque",ear1="Cath Palug Earring",ear2="Lodurr Earring",
		body="Baayami Robe +1",hands="Baayami Cuffs +1",ring1="Stikini Ring +1",ring2="Evoker's Ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +2','Pet: Enmity+12','Blood Pact Dmg.+5','Blood Pact ab. del. II -1',}},waist="Kobo Obi",legs="Baayami Slops +1",feet="Baayami Sabots +1"}

	-- Elemental Siphon sets. Zodiac Ring is affected by day, Chatoyant Staff by weather, and Twilight Cape by both.
	sets.midcast.Siphon = {
		main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
		sub="Vox Grip",
		ammo="Esper Stone +1",
		head="Baayami Hat +1",
		neck="Incanter's Torque",
		ear1="Cath Palug Earring",
		ear2="Lodurr Earring",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +2','Pet: Enmity+12','Blood Pact Dmg.+5','Blood Pact ab. del. II -1',}},
		waist="Kobo Obi",
		legs="Baayami Slops +1",
		feet="Beck. Pigaches +1"
	}

	sets.midcast.SiphonZodiac = set_combine(sets.midcast.Siphon, { ring1="Zodiac Ring" })
	sets.midcast.SiphonWeather = set_combine(sets.midcast.Siphon, { main="Chatoyant Staff" })
	sets.midcast.SiphonWeatherZodiac = set_combine(sets.midcast.SiphonZodiac, { main="Chatoyant Staff" })

	-- Summoning Midcast, cap spell interruption if possible (Baayami Robe gives 100, need 2 more)
	-- PDT isn't a bad idea either, so don't overwrite a lot from the DT set it inherits from.
	sets.midcast.Summon = set_combine(sets.PDT_Base, {
		body="Baayami Robe +1"
	})

	-- If you ever lock your weapon, keep that in mind when building cure potency set.
	sets.midcast.Cure = {
		head=VanyaHead.HealSkill,neck="Yngvi Choker",ear1="Mendi. Earring",ear2="Novia Earring",
		body="Bunzi's Robe",hands=TelHands.Duration,ring1="Stikini Ring +1",ring2="Lebeche Ring",
		back="Oretan. Cape +1",waist="Bishop's Sash",legs=VanyaLegs.HealSkill,feet=VanyaFeet.HealSkill}

	sets.midcast.Cursna = set_combine(sets.precast.FC, {head=VanyaHead.HealSkill,neck="Debilis Medallion",ear1="Meili Earring",ear2="Beatific Earring",hands="Hieros Mittens",ring1="Menelaus's Ring",ring2="Haoma's Ring",back="Oretan. Cape +1",waist="Bishop's Sash",legs=VanyaLegs.HealSkill,feet=VanyaFeet.HealSkill})
	
	-- Just a standard set for spells that have no set
	sets.midcast.EnmityRecast = set_combine(sets.precast.FC, {
		main="Nirvana",
		ear1="Novia Earring",
		body={ name="Apo. Dalmatica +1", augments={'Summoning magic skill +20','Enmity-6','Pet: Damage taken -4%',}}
	})

	-- Strong alternatives: Daybreak and Ammurapi Shield, Cath Crown, Gwati Earring
	sets.midcast.Enfeeble = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head=empty,
		neck="Incanter's Torque",
		ear1="Malignance Earring",
		ear2="Dignitary's Earring",
		body="Cohort Cloak +1",
		hands="Regal Cuffs",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Aurist's Cape +1",
		waist="Luminary Sash",
		legs="Nyame Flanchard",
		feet="Skaoi Boots"
	}
	sets.midcast.Enfeeble.INT = set_combine(sets.midcast.Enfeeble, {waist="Acuity Belt +1"})

	sets.midcast.Enhancing = {main="Gada",sub="Ammurapi Shield",
		head=TelHead.Duration,neck="Incanter's Torque",ear2="Andoaa Earring",
		body=TelBody.Duration,hands=TelHands.Duration,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Perimede Cape",waist="Embla Sash",legs=TelLegs.Duration,feet=TelFeet.Duration}

	sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {head="Umuthi Hat",neck="Nodens Gorget",ear1="Earthcry Earring",legs="Shedir Seraweels"})

	sets.midcast.Nuke = {
		main="Mpaca's Staff",
		sub="Elan Strap +1",
		head="Cath Palug Crown",
		neck="Baetyl Pendant",
		ear1="Malignance Earring",
		ear2="Friomisi Earring",
		body="Nyame Mail",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		ring1="Mephitas's Ring +1",
		ring2={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Oretan. Cape +1",
		waist="Orpheus's Sash",
		legs="Nyame Flanchard",
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}}
	}

	sets.midcast["Refresh"] = set_combine(sets.midcast.Enhancing, {
		head="Amalric Coif +1",
		waist="Gishdubar Sash"
	})

	sets.midcast["Aquaveil"] = set_combine(sets.midcast.Enhancing, {
		main="Vadose Rod",
		head="Amalric Coif +1"
	})

	sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeeble, {main="Daybreak",sub="Ammurapi Shield"})
	sets.midcast["Mana Cede"] = { hands="Beckoner's Bracers +1" }
	sets.midcast["Astral Flow"] = { head="Glyphic Horn +3" }

	-- ===================================================================================================================
	--	Weaponskills
	-- ===================================================================================================================

	-- Magic accuracy can be nice here to land the defense down effect. Also keep in mind big damage Garland can make it
	-- harder for multiple people to get AM3 on trash mobs before popping an NM.
	sets.midcast["Garland of Bliss"] = {
		head="Nyame Helm",
		neck="Baetyl Pendant",
		ear1="Malignance Earring",
		ear2="Friomisi Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Mephitas's Ring +1",
		ring2={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Oretan. Cape +1",
		waist="Orpheus's Sash",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	-- My set focuses on accuracy here to make skillchains with Ifrit
	-- Just like Garland, it's not hard to improve on the damage from this set if that's what you're after.
	sets.midcast["Shattersoul"] = sets.midcast["Garland of Bliss"]

	sets.midcast["Cataclysm"] = sets.midcast.Nuke

	sets.midcast["Shell Crusher"] = sets.midcast["Garland of Bliss"]

	sets.pet_midcast = {}

	-- Main physical pact set (Volt Strike, Pred Claws, etc.)
	-- Prioritize BP Damage & Pet: Double Attack
	-- Strong Alternatives:
	-- Gridarvor, Apogee Crown, Apogee Pumps, Convoker's Doublet, Apogee Dalmatica, Shulmanu Collar (equal to ~R15 Collar), Gelos Earring, Regal Belt
	sets.pet_midcast.Physical_BP = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Epitaph",
		head=HeliosHead.PhysBP,
		neck="Smn. Collar +2",
		ear1="Lugalbanda Earring",
		ear2="Kyrene's Earring",
		body="Glyphic Doublet +3",
		hands=MerlinicHands.Refresh,
		ring1="Cath Palug Ring",
		ring2="Varar Ring +1",
		back=Campestres.CapeA,
		waist="Incarnation Sash",
		legs=ApogeeLegs.PhysBP,
		feet=HeliosFeet.PhysBP
	}

	-- Physical Pact AM3 set, less emphasis on Pet:DA
	sets.pet_midcast.Physical_BP_AM3 = set_combine(sets.pet_midcast.Physical_BP, {
		ear2="Gelos Earring",
		body="Convoker's Doublet +3",
		ring1="Varar Ring +1",
		feet=ApogeeFeet.PhysBP
	})

	-- Physical pacts which benefit more from TP than Pet:DA (like Spinning Dive and other pacts you never use except that one time)
	sets.pet_midcast.Physical_BP_TP = set_combine(sets.pet_midcast.Physical_BP, {
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
		ear2="Beck. Earring +1",
		body="Convoker's Doublet +3",
		ring1="Varar Ring +1",
		waist="Regal Belt",
		legs="Enticer's Pants",
		feet=ApogeeFeet.PhysBP
	})

	-- Used for all physical pacts when AccMode is true
	sets.pet_midcast.Physical_BP_Acc = set_combine(sets.pet_midcast.Physical_BP, {
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
		ear2="Beck. Earring +1",
		body="Convoker's Doublet +3",
		hands=MerlinicHands.Refresh,
		feet="Convoker's Pigaches +3"
	})

	-- Base magic pact set
	-- Prioritize BP Damage & Pet:MAB
	-- Strong Alternatives:
	-- Espiritus, Apogee Crown, Smn. Collar +2 (equal to ~R12 Collar)
	sets.pet_midcast.Magic_BP_Base = {
		main=Grio.PetMAB,  
		sub="Elan Strap +1",
		ammo="Epitaph",
		head="Cath Palug Crown",
		neck="Smn. Collar +2",
		ear1="Lugalbanda Earring",
		ear2="Gelos Earring",
		body=ApogeeBody.MagBP,
		hands=MerlinicHands.Refresh,
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
		back=Campestres.CapeA,
		waist="Regal Belt",
		feet=ApogeeFeet.MagBP
	}

	-- Some magic pacts benefit more from TP than others.
	-- Note: This set will only be used on merit pacts if you have less than 4 merits.
	--       Make sure to update your merit values at the top of this Lua.
	sets.pet_midcast.Magic_BP_TP = set_combine(sets.pet_midcast.Magic_BP_Base, {
		legs="Enticer's Pants"
	})

	-- NoTP set used when you don't need Enticer's
	sets.pet_midcast.Magic_BP_NoTP = set_combine(sets.pet_midcast.Magic_BP_Base, {
		legs=ApogeeLegs.MagBP
	})

	sets.pet_midcast.Magic_BP_TP_Acc = set_combine(sets.pet_midcast.Magic_BP_TP, {
		head="Beckoner's Horn +3",
		body="Convoker's Doublet +3",
		hands=MerlinicHands.Refresh
	})

	sets.pet_midcast.Magic_BP_NoTP_Acc = set_combine(sets.pet_midcast.Magic_BP_NoTP, {
		head="Beckoner's Horn +3",
		body="Convoker's Doublet +3",
		hands=MerlinicHands.Refresh
	})

	-- Favor BP Damage above all. Pet:MAB also very strong.
	-- Pet: Accuracy, Attack, Magic Accuracy moderately important.
	-- Strong Alternatives:
	-- Keraunos, Grioavolr, Espiritus, Was, Apogee Crown, Apogee Dalmatica, Smn. Collar +2
	sets.pet_midcast.FlamingCrush = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Epitaph",
		head="Cath Palug Crown",
		neck="Smn. Collar +2",
		ear1="Lugalbanda Earring",
		ear2="Gelos Earring",
		body="Convoker's Doublet +3",
		hands=MerlinicHands.Refresh,
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
		back=Campestres.CapeA,
		waist="Regal Belt",
		legs=ApogeeLegs.MagBP,
		feet=ApogeeFeet.MagBP
	}

	sets.pet_midcast.FlamingCrush_Acc = set_combine(sets.pet_midcast.FlamingCrush, {
		ear2="Kyrene's Earring",
		body="Convoker's Doublet +3",
		hands=MerlinicHands.Refresh,
		--feet="Convoker's Pigaches +3"
	})

	-- Pet: Magic Acc set - Mainly used for debuff pacts like Shock Squall
	sets.pet_midcast.MagicAcc_BP = {
		main="Nirvana",
		sub="Vox Grip",
		ammo="Epitaph",
		head="Convoker's Horn +3",
		neck="Smn. Collar +2",
		ear1="Lugalbanda Earring",
		ear2="Enmerkar Earring",
		body="Convoker's Doublet +3",
		hands="Lamassu Mitts +1",
		ring1="Cath Palug Ring",
		ring2="Evoker's Ring",
		back=Campestres.CapeA,
		waist="Regal Belt",
		legs="Convoker's Spats +3",
		feet="Bunzi's Sabots"
	}

	sets.pet_midcast.Debuff_Rage = sets.pet_midcast.MagicAcc_BP

	-- Pure summoning magic set, mainly used for buffs like Hastega II.
	-- Strong Alternatives:
	-- Andoaa Earring, Summoning Earring, Lamassu Mitts +1, Caller's Pendant
	sets.pet_midcast.SummoningMagic = {
		main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
		sub="Vox Grip",
		ammo="Epitaph",
		head="Baayami Hat +1",
		neck="Incanter's Torque",
		ear1="Cath Palug Earring",
		ear2="Lodurr Earring",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +2','Pet: Enmity+12','Blood Pact Dmg.+5','Blood Pact ab. del. II -1',}},
		waist="Kobo Obi",
		legs="Baayami Slops +1",
		feet="Baayami Sabots +1"
	}

	sets.pet_midcast.Buff = sets.pet_midcast.SummoningMagic

	-- Wind's Blessing set. Pet:MND increases potency.
	sets.pet_midcast.Buff_MND = set_combine(sets.pet_midcast.Buff, {
		main="Nirvana",
		neck="Smn. Collar +2",
		hands="Lamassu Mitts +1",
		back=Campestres.CapeA,
		legs="Assiduity Pants +1",
		feet="Bunzi's Sabots"
	})

	-- Don't drop Avatar level in this set if you can help it.
	-- You can use Avatar:HP+ gear to increase the HP recovered, but most of it will decrease your own max HP.
	sets.pet_midcast.Buff_Healing = set_combine(sets.pet_midcast.Buff, {
		main="Nirvana",
		back=Campestres.CapeA,
		--body={ name="Apo. Dalmatica +1", augments={'Summoning magic skill +20','Enmity-6','Pet: Damage taken -4%',}},
		--feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	})

	-- This set is used for certain blood pacts when ImpactDebuff mode is turned ON. (/console gs c ImpactDebuff)
	-- These pacts are normally used with magic damage gear, but they're also strong debuffs when enhanced by summoning skill.
	-- This set is safe to ignore.
	sets.pet_midcast.Impact = set_combine(sets.pet_midcast.SummoningMagic, {
		main="Nirvana",
		head="Convoker's Horn +3",
		ear1="Lugalbanda Earring",
		ear2="Enmerkar Earring",
		hands="Lamassu Mitts +1"
	})

	-- ===================================================================================================================
	-- Aftercast Sets
	-- ===================================================================================================================
	-- Syntax: sets.aftercast.{PetName|Spirit|Avatar}.{IdleMode}.{PlayerStatus}.{LowMP}.{ForceIlvl}

	-- You can add sets with the above naming convention and they'll be used automatically.
	-- Example: sets.aftercast["Cait Sith"]["DT"] or sets.aftercast["Cait Sith"].DT will be a set used when IdleMode is "DT" and you have Cait Sith summoned.
	-- If you want to add your own idle modes, do a find for "IdleModeCommands" and add it there.

	-- This is your main idle set with no avatar out. Focus on refresh and defensive stats.
	sets.aftercast = {main="Mpaca's Staff",sub="Khonsu",ammo="Epitaph",
		head="Beckoner's Horn +3",neck="Smn. Collar +2",ear1="Cath Palug Earring",ear2="Beck. Earring +1",
		body="Bunzi's Robe",hands=MerlinicHands.Refresh,ring1="Defending Ring",ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back=Campestres.CapeA,waist="Regal Belt",legs=MerlinicLegs.Refresh,feet=MerlinicFeet.Refresh}  -- i used to have loricate torque in this set, seems like just using Smn collar is fine?

	sets.aftercast.ForceIlvl = set_combine(sets.aftercast, {
		feet="Baayami Sabots +1"
	})
	sets.aftercast.LowMP = set_combine(sets.aftercast, {
		waist="Fucho-no-obi"
	})
	sets.aftercast.LowMP.ForceIlvl = set_combine(sets.aftercast.LowMP, {
		feet="Baayami Sabots +1"
	})

	sets.aftercast.DT = set_combine(sets.PDT_Base, {
	})

	-- This determines set used when in DD mode but not engaged and no avatar
	-- Note: Similar to "sets.aftercast.Avatar.DD". If you change one don't forget to change the other accordingly.
	sets.aftercast.DD = set_combine(sets.aftercast, {
	})

	-- Main melee set
	-- If you want specific things equipped only when an avatar is out, modify "sets.aftercast.Avatar.DD.Engaged" below.
	sets.aftercast.DD.Engaged = set_combine(sets.aftercast.DD, {
		head="Beckoner's Horn +3",
		neck="Shulmanu Collar",
		ear1="Telos Earring",
		ear2="Cessance Earring",
		body="Tali'ah Manteel +2",
		hands="Bunzi's Gloves",
		ring1={ name="Chirich Ring +1", bag="wardrobe2" },
		ring2={ name="Chirich Ring +1", bag="wardrobe4" },
		back=Campestres.CapeA,
		waist="Grunfeld Rope",
		legs="Convoker's Spats +3",
		feet="Convoker's Pigaches +3"
	})

	-- You aren't likely to be in PetDT mode without an avatar for long, but I default to the DT set in that scenario.
	sets.aftercast.PetDT = set_combine(sets.aftercast.DT, {
	})

	sets.aftercast.Zendik = set_combine(sets.aftercast, {
		body="Zendik Robe"
	})
	sets.aftercast.Zendik.ForceIlvl = set_combine(sets.aftercast.Zendik, {
		feet="Baayami Sabots +1"
	})
	sets.aftercast.Zendik.LowMP = set_combine(sets.aftercast.Zendik, {
		waist="Fucho-no-obi"
	})
	sets.aftercast.Zendik.LowMP.ForceIlvl = set_combine(sets.aftercast.Zendik.LowMP, {
		feet="Baayami Sabots +1"
	})


	-- Main perpetuation set - Many idle sets inherit from this set.
	-- Put common items here so you don't have to repeat them over and over.
	-- Strong Alternatives:
	-- Gridarvor, Asteria Mitts, Shomonjijoe, Convoker's Horn, Evans Earring, Isa Belt
	sets.aftercast.Avatar = {
		main="Nirvana",
		sub="Oneiros Grip",
		ammo="Epitaph",
		head="Beckoner's Horn +3",
		neck="Caller's Pendant",
		ear1="Cath Palug Earring",
		ear2="Beck. Earring +1",
		body={ name="Apo. Dalmatica +1", augments={'Summoning magic skill +20','Enmity-6','Pet: Damage taken -4%',}},
		hands=MerlinicHands.Refresh,
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back=Campestres.CapeA,
		waist="Lucidity Sash",
		legs="Assiduity Pants +1",
		feet="Baayami Sabots +1"
	}
	-- If you have Fucho and don't need Lucidity Sash for perp down, you can uncomment the belt here to enable using it.
	sets.aftercast.Avatar.LowMP = set_combine(sets.aftercast.Avatar, {
		--waist="Fucho-no-obi"
	})

	sets.aftercast.Avatar.DT = set_combine(sets.aftercast.DT, {
		ear2="Evans Earring",
		waist="Lucidity Sash"
	})

	sets.aftercast.Avatar.DD = set_combine(sets.aftercast.Avatar, {
	})

	-- Main melee set when engaged with an avatar out.
	sets.aftercast.Avatar.DD.Engaged = set_combine(sets.aftercast.DD.Engaged, {
	})

	-- Pet:DT build. Equipped when IdleMode is "PetDT".
	-- Strong alternatives:
	-- Selenian Cap, Enmerkar Earring, Handler's Earring, Rimeice Earring, Thurandaut Ring, Tali'ah Seraweels
	sets.aftercast.Avatar.PetDT = {
		main="Nirvana",
		sub="Khonsu",
		ammo="Epitaph",
		head={ name="Apogee Crown +1", augments={'Pet: Accuracy+25','"Avatar perpetuation cost"+7','Pet: Damage taken -4%',}},
		neck="Smn. Collar +2",
		ear1="Cath Palug Earring",
		ear2="Enmerkar Earring",
		body={ name="Apo. Dalmatica +1", augments={'Summoning magic skill +20','Enmity-6','Pet: Damage taken -4%',}},
		hands=TelHands.Duration,
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back=Campestres.CapeA,
		waist="Isa Belt",
		legs="Enticer's Pants",
		feet={ name="Telchine Pigaches", augments={'Pet: DEF+14','Pet: "Regen"+3','Pet: Damage taken -4%',}}
	}

	-- Avatar Melee set. You really don't need this set. It's only here because I can't bring myself to throw it away.
	sets.aftercast.Avatar.PetDD = set_combine(sets.aftercast.Avatar, {
		ear2="Rimeice Earring",
		body="Glyphic Doublet +3",
		hands=HeliosHands.PetMelee,
		waist="Klouskap Sash +1",
		feet=HeliosFeet.PetMelee
	})

	-- Used when IdleMode is "Favor" to maximize avatar's favor effect.
	-- Skill tiers are 512 / 575 / 670
	sets.aftercast.Avatar.Favor = set_combine(sets.aftercast.Avatar, {
		head="Beckoner's Horn +3",
		ear2="Lodurr Earring",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		feet="Baayami Sabots +1"
	})

	sets.aftercast.Avatar.Zendik = set_combine(sets.aftercast.Avatar.Favor, {
		body="Zendik Robe"
	})

	-- Idle set used when you have a spirit summoned. Glyphic Spats will make them cast more frequently.
	sets.aftercast.Spirit = {
		main="Nirvana",
		sub="Vox Grip",
		ammo="Epitaph",
		head="Convoker's Horn +3",
		neck="Incanter's Torque",
		ear1="Cath Palug Earring",
		ear2="Evans Earring",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +2','Pet: Enmity+12','Blood Pact Dmg.+5','Blood Pact ab. del. II -1',}},
		waist="Lucidity Sash",
		legs="Glyphic Spats +3",
		feet="Baayami Sabots +1"
	}

	-- ===================================================================================================================
	--		End of Sets
	-- ===================================================================================================================

	Buff_BPs_Duration = S{'Shining Ruby','Aerial Armor','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Glittering Ruby','Earthen Ward','Hastega','Noctoshield','Ecliptic Howl','Dream Shroud','Earthen Armor','Fleet Wind','Inferno Howl','Heavenward Howl','Hastega II','Soothing Current','Crystal Blessing','Katabatic Blades'}
	Buff_BPs_Healing = S{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'}
	Buff_BPs_MND = S{"Wind's Blessing"}
	Debuff_BPs = S{'Mewing Lullaby','Eerie Eye','Lunar Cry','Lunar Roar','Nightmare','Pavor Nocturnus','Ultimate Terror','Somnolence','Slowga','Tidal Roar','Diamond Storm','Sleepga','Shock Squall','Bitter Elegy','Lunatic Voice'}
	Debuff_Rage_BPs = S{'Moonlit Charge','Tail Whip'}

	Magic_BPs_NoTP = S{'Holy Mist','Nether Blast','Aerial Blast','Searing Light','Diamond Dust','Earthen Fury','Zantetsuken','Tidal Wave','Judgment Bolt','Inferno','Howling Moon','Ruinous Omen','Night Terror','Thunderspark','Tornado II','Sonic Buffet'}
	Magic_BPs_TP = S{'Impact','Conflag Strike','Level ? Holy','Lunar Bay'}
	Merit_BPs = S{'Meteor Strike','Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Thunderstorm'}
	Physical_BPs_TP = S{'Rock Buster','Mountain Buster','Crescent Fang','Spinning Dive','Roundhouse'}

	ZodiacElements = S{'Fire','Earth','Water','Wind','Ice','Lightning'}

	--TownIdle = S{"windurst woods","windurst waters","windurst walls","port windurst","bastok markets","bastok mines","port bastok","southern san d'oria","northern san d'oria","port san d'oria","upper jeuno","lower jeuno","port jeuno","ru'lude gardens","norg","kazham","tavnazian safehold","rabao","selbina","mhaura","aht urhgan whitegate","al zahbi","nashmau","western adoulin","eastern adoulin"}
	--Salvage = S{"Bhaflau Remnants","Zhayolm Remnants","Arrapago Remnants","Silver Sea Remnants"}

	-- Select initial macro set and set lockstyle
	-- This section likely requires changes or removal if you aren't Pergatory
	-- Note: This doesn't change your macro set for you during play, your macros have to do that. This is just for when the Lua is loaded.

	if pet.isvalid then
		if pet.name=='Fenrir' then
			send_command('input /macro book 15;wait .1;input /macro set 5;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Ifrit' then
			send_command('input /macro book 15;wait .1;input /macro set 4;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Titan' then
			send_command('input /macro book 15;wait .1;input /macro set 6;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Leviathan' then
			send_command('input /macro book 15;wait .1;input /macro set 9;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Garuda' then
			send_command('input /macro book 15;wait .1;input /macro set 2;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Shiva' then
			send_command('input /macro book 15;wait .1;input /macro set 3;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Ramuh' then
			send_command('input /macro book 15;wait .1;input /macro set 8;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Diabolos' then
			send_command('input /macro book 15;wait .1;input /macro set 10;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Cait Sith' then
			send_command('input /macro book 15;wait .1;input /macro set 1;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Siren' then
			send_command('input /macro book 21;wait .1;input /macro set 6;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Carbuncle' then
			send_command('input /macro book 21;wait .1;input /macro set 5;wait 3;input /lockstyleset '..StartLockStyle)
		end
	else
		send_command('input /macro book 21;wait .1;input /macro set 3;wait 3;input /lockstyleset '..StartLockStyle)
	end
	-- End macro set / lockstyle section
end

-- ===================================================================================================================
--		Gearswap rules below this point - Modify at your own peril
-- ===================================================================================================================

function pretarget(spell,action)
	if not buffactive['Muddle'] then
		-- Auto Remedy --
		if AutoRemedy and (spell.action_type == 'Magic' or spell.type == 'JobAbility') then
			if buffactive['Paralysis'] or (buffactive['Silence'] and not AutoEcho) then
				cancel_spell()
				send_command('input /item "Remedy" <me>')
			end
		end
		-- Auto Echo Drop --
		if AutoEcho and spell.action_type == 'Magic' and buffactive['Silence'] then
			cancel_spell()
			send_command('input /item "Echo Drops" <me>')
		end
	end
end

function precast(spell)
	if (pet.isvalid and pet_midaction() and not spell.type=="SummonerPact") or spell.type=="Item" then
		-- Do not swap if pet is mid-action. I added the type=SummonerPact check because sometimes when the avatar
		-- dies mid-BP, pet.isvalid and pet_midaction() continue to return true for a brief time.
		return
	end
	-- Spell fast cast
	if sets.precast[spell.english] then
		equip(sets.precast[spell.english])
	elseif spell.action_type=="Magic" then
		if spell.name=="Stoneskin" then
			equip(sets.precast.FC,{waist="Siegel Sash"})
		else
			equip(sets.precast.FC)
		end
	end
end

function midcast(spell)
	if (pet.isvalid and pet_midaction()) or spell.type=="Item" then
		return
	end
	-- BP Timer gear needs to swap here
	if (spell.type=="BloodPactWard" or spell.type=="BloodPactRage") then
		if not buffactive["Astral Conduit"] then
			equip(sets.midcast.BP)
		end
		-- If lag compensation mode is on, set up a timer to equip the BP gear.
		if LagMode then
			send_command('wait 0.5;gs c EquipBP '..spell.name)
		end
	-- Spell Midcast & Potency Stuff
	elseif sets.midcast[spell.english] then
		equip(sets.midcast[spell.english])
	elseif spell.name=="Elemental Siphon" then
		if pet.element==world.day_element and ZodiacElements:contains(pet.element) then
			if pet.element==world.weather_element then
				equip(sets.midcast.SiphonWeatherZodiac)
			else
				equip(sets.midcast.SiphonZodiac)
			end
		else
			if pet.element==world.weather_element then
				equip(sets.midcast.SiphonWeather)
			else
				equip(sets.midcast.Siphon)
			end
		end
	elseif spell.type=="SummonerPact" then
		equip(sets.midcast.Summon)
	elseif string.find(spell.name,"Cure") or string.find(spell.name,"Curaga") then
		equip(sets.midcast.Cure)
	elseif string.find(spell.name,"Protect") or string.find(spell.name,"Shell") then
		equip(sets.midcast.Enhancing,{ring2="Sheltered Ring"})
	elseif spell.skill=="Enfeebling Magic" then
		equip(sets.midcast.Enfeeble)
	elseif spell.skill=="Enhancing Magic" then
		equip(sets.midcast.Enhancing)
	elseif spell.skill=="Elemental Magic" then
		equip(sets.midcast.Nuke)
	elseif spell.action_type=="Magic" then
		equip(sets.midcast.EnmityRecast)
	else
		idle()
	end
	-- Treasure Hunter
	if THSpells:contains(spell.name) then
		equip(sets.TH)
	end
	-- Auto-cancel existing buffs
	if spell.name=="Stoneskin" and buffactive["Stoneskin"] then
		windower.send_command('cancel 37;')
	elseif spell.name=="Sneak" and buffactive["Sneak"] and spell.target.type=="SELF" then
		windower.send_command('cancel 71;')
	elseif spell.name=="Utsusemi: Ichi" and buffactive["Copy Image"] then
		windower.send_command('wait 1;cancel 66;')
	end
end

function aftercast(spell)
	if pet_midaction() or spell.type=="Item" then
		return
	end
	if not string.find(spell.type,"BloodPact") then
		idle()
	end
end

function pet_change(pet,gain)
	if (not (gain and pet_midaction())) then
		idle()
	end
end

function status_change(new,old)
	if not midaction() and not pet_midaction() then
		idle()
	end
end

function buff_change(name,gain)
	if name=="quickening" and not pet_midaction() then
		idle()
	end
	if SacTorque and name=="sleep" and gain and pet.isvalid then
		equip({neck="Sacrifice Torque"})
		disable("neck")
		if buffactive["Stoneskin"] then
			windower.send_command('cancel 37;')
		end
	end
	if SacTorque and name=="sleep" and not gain then
		enable("neck")
	end
end

function pet_midcast(spell)
	if not LagMode then
		equipBPGear(spell.name)
	end
end

function pet_aftercast(spell)
	idle()
end

function equipBPGear(spell)
	if spell=="Perfect Defense" then
		equip(sets.pet_midcast.SummoningMagic)
	elseif Debuff_BPs:contains(spell) then
		equip(sets.pet_midcast.MagicAcc_BP)
	elseif Buff_BPs_Healing:contains(spell) then
		equip(sets.pet_midcast.Buff_Healing)
	elseif Buff_BPs_Duration:contains(spell) then
		equip(sets.pet_midcast.Buff)
	elseif Buff_BPs_MND:contains(spell) then
		equip(sets.pet_midcast.Buff_MND)
	elseif spell=="Flaming Crush" then
		if AccMode then
			equip(sets.pet_midcast.FlamingCrush_Acc)
		else
			equip(sets.pet_midcast.FlamingCrush)
		end
	elseif ImpactDebuff and (spell=="Impact" or spell=="Conflag Strike") then
		equip(sets.pet_midcast.Impact)
	elseif Magic_BPs_NoTP:contains(spell) then
		if AccMode then
			equip(sets.pet_midcast.Magic_BP_NoTP_Acc)
		else
			equip(sets.pet_midcast.Magic_BP_NoTP)
		end
	elseif Magic_BPs_TP:contains(spell) or string.find(spell," II") or string.find(spell," IV") then
		if AccMode then
			equip(sets.pet_midcast.Magic_BP_TP_Acc)
		else
			equip(sets.pet_midcast.Magic_BP_TP)
		end
	elseif Merit_BPs:contains(spell) then
		if AccMode then
			equip(sets.pet_midcast.Magic_BP_TP_Acc)
		elseif spell=="Meteor Strike" and MeteorStrike>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Geocrush" and Geocrush>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Grand Fall" and GrandFall>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Wind Blade" and WindBlade>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Heavenly Strike" and HeavenlyStrike>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Thunderstorm" and Thunderstorm>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		else
			equip(sets.pet_midcast.Magic_BP_TP)
		end
	elseif Debuff_Rage_BPs:contains(spell) then
		equip(sets.pet_midcast.Debuff_Rage)
	else
		if AccMode then
			equip(sets.pet_midcast.Physical_BP_Acc)
		elseif Physical_BPs_TP:contains(spell) then
			equip(sets.pet_midcast.Physical_BP_TP)
		elseif buffactive["Aftermath: Lv.3"] then
			equip(sets.pet_midcast.Physical_BP_AM3)
		else
			equip(sets.pet_midcast.Physical_BP)
		end
	end
end

-- This command is called whenever you input "gs c <command>"
function self_command(command)
	IdleModeCommands = {'Refresh','PDT','DD','PetDT','PetDD','Favor','Zendik'}
	is_valid = command:lower()=="idle"
	
	for _, v in ipairs(IdleModeCommands) do
		if command:lower()==v:lower() then
			IdleMode = v
			add_to_chat(122, 'Idle Mode: '..IdleMode..'')
			idle()
			return
		end
	end
	if string.sub(command,1,7)=="EquipBP" then
		equipBPGear(string.sub(command,9,string.len(command)))
		return
	elseif command:lower()=="accmode" then
		AccMode = AccMode==false
		is_valid = true
		add_to_chat(122, 'AccMode: '..tostring(AccMode)..'')
	elseif command:lower()=="impactmode" then
		ImpactDebuff = ImpactDebuff==false
		is_valid = true
		add_to_chat(122, 'Impact Debuff: '..tostring(ImpactDebuff)..'')
	elseif command:lower()=="forceilvl" then
		ForceIlvl = ForceIlvl==false
		is_valid = true
		add_to_chat(122, 'Force iLVL: '..tostring(ForceIlvl)..'')
	elseif command:lower()=="lagmode" then
		LagMode = LagMode==false
		is_valid = true
		add_to_chat(122, 'Lag Compensation Mode: '..tostring(LagMode)..'')
	elseif command:lower()=="th" then
		TreasureHunter = TreasureHunter==false
		is_valid = true
		add_to_chat(122, 'Treasure Hunter Mode: '..tostring(TreasureHunter)..'')
	elseif command:lower()=="meleemode" then
		if MeleeMode then
			MeleeMode = false
			enable("main","sub")
			add_to_chat(122, 'Melee Mode: false')
		else
			MeleeMode = true
			equip({main="Nirvana",sub="Elan Strap +1"})
			disable("main","sub")
			add_to_chat(122, 'Melee Mode: true')
		end
		is_valid = true
	elseif command=="ToggleIdle" then
		is_valid = true
		-- If you want to change the sets cycled with F9, this is where you do it
		if IdleMode=="Refresh" then
			IdleMode = "PDT"
		elseif IdleMode=="PDT" then
			IdleMode = "PetDT"
		elseif IdleMode=="PetDT" then
			IdleMode = "DD"
		else
			IdleMode = "Refresh"
		end
		add_to_chat(122, 'Idle Mode: '..IdleMode..'')
	elseif command:lower()=="lowhp" then
		-- Use for "Cure 500 HP" objectives in Omen
		equip({head="Apogee Crown +1",body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},legs="Apogee Slacks +1",feet="Apogee Pumps +1",back="Campestres's Cape"})
		return
	elseif string.sub(command:lower(),1,12)=="meteorstrike" then
		MeteorStrike = string.sub(command,13,13)
		add_to_chat(122, 'Meteor Strike: '..MeteorStrike..'/5')
		is_valid = true
	elseif string.sub(command:lower(),1,8)=="geocrush" then
		Geocrush = string.sub(command,9,9)
		add_to_chat(122, 'Geocrush: '..Geocrush..'/5')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="grandfall" then
		GrandFall = string.sub(command,10,10)
		add_to_chat(122, 'Grand Fall: '..GrandFall..'/5')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="windblade" then
		WindBlade = +string.sub(command,10,10)
		add_to_chat(122, 'Wind Blade: '..WindBlade..'/5')
		is_valid = true
	elseif string.sub(command:lower(),1,14)=="heavenlystrike" then
		HeavenlyStrike = string.sub(command,15,15)
		add_to_chat(122, 'Heavenly Strike: '..HeavenlyStrike..'/5')
		is_valid = true
	elseif string.sub(command:lower(),1,12)=="thunderstorm" then
		Thunderstorm = string.sub(command,13,13)
		add_to_chat(122, 'Thunderstorm: '..Thunderstorm..'/5')
		is_valid = true
	end

	if is_valid then
		if not midaction() and not pet_midaction() then
			idle()
		end
	else
		sanitized = command:gsub("\"", "")
		add_to_chat(122, 'Invalid self_command: '..sanitized..'') -- Note: If you use Gearinfo, comment out this line
	end
end

-- This function is for returning to aftercast gear after an action/event.
function idle()
	--if TownIdle:contains(world.area:lower()) then
	--	return
	--end
	equipSet = sets.aftercast
	if pet.isvalid then
		if equipSet[pet.name] then
			equipSet = equipSet[pet.name]
		elseif string.find(pet.name,'Spirit') and equipSet["Spirit"] then
			equipSet = equipSet["Spirit"]
		elseif equipSet["Avatar"] then
			equipSet = equipSet["Avatar"]
		end
	end
	if equipSet[IdleMode] then
		equipSet = equipSet[IdleMode]
	end
	if equipSet[player.status] then
		equipSet = equipSet[player.status]
	end
	if player.mpp < 50 and equipSet["LowMP"] then
		equipSet = equipSet["LowMP"]
	end
	if ForceIlvl and equipSet["ForceIlvl"] then
		equipSet = equipSet["ForceIlvl"]
	end
	equip(equipSet)

	if buffactive['Quickening'] and IdleMode~='PDT' and not ForceIlvl then
		equip({feet="Herald's Gaiters"})
	end
	-- Balrahn's Ring
	--if Salvage:contains(world.area) then
	--	equip({ring2="Balrahn's Ring"})
	--end
	-- Maquette Ring
	--if world.area=='Maquette Abdhaljs-Legion' and not IdleMode=='DT' then
	--	equip({ring2="Maquette Ring"})
	--end
end