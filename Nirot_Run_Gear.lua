-- Define sets and vars used by this job file.
function init_gear_sets()

	UseSIRDWithPhalanx = true

	HercHead = {}
	HercBody = {}
	HercHands = {}
	HercLegs = {}
	HercFeet = {}
	HercHead.Refresh = { name="Herculean Helm", augments={'"Dbl.Atk."+2','Pet: Accuracy+13 Pet: Rng. Acc.+13','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}, priority=38}
	HercHead.Phalanx = { name="Herculean Helm", augments={'Pet: INT+6','Weapon skill damage +1%','Phalanx +4',}, priority=38}
	HercHead.TH = { name="Herculean Helm", augments={'"Store TP"+1','"Avatar perpetuation cost" -1','"Treasure Hunter"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}, priority=38}
	HercHead.FC = { name="Herculean Helm", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Accuracy+3','"Fast Cast"+7',}, priority=38}
	HercBody.Phalanx = { name="Herculean Vest", augments={'Mag. Acc.+19','Magic dmg. taken -1%','Phalanx +5',}, priority=61}
	HercHands.Refresh = { name="Herculean Gloves", augments={'DEX+5','VIT+13','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+7 "Mag.Atk.Bns."+7',}, priority=20}
	HercHands.FC = { name="Herculean Gloves", augments={'Pet: "Mag.Atk.Bns."+20','STR+7','"Fast Cast"+8','Accuracy+15 Attack+15',}, priority=20}
	HercHands.TH = { name="Herculean Gloves", augments={'Accuracy+1 Attack+1','Weapon skill damage +2%','"Treasure Hunter"+2',}, priority=20}
	HercHands.Phalanx = { name="Herculean Gloves", augments={'Pet: "Dbl. Atk."+2','Potency of "Cure" effect received+6%','Phalanx +4','Accuracy+5 Attack+5','Mag. Acc.+19 "Mag.Atk.Bns."+19',}, priority=20}
	HercLegs.Refresh = { name="Herculean Trousers", augments={'AGI+7','"Mag.Atk.Bns."+13','"Refresh"+2','Accuracy+8 Attack+8',}, priority=38}
	HercLegs.Healing = { name="Herculean Trousers", augments={'"Triple Atk."+2','"Cure" potency +10%','Damage taken-2%','Accuracy+20 Attack+20','Mag. Acc.+12 "Mag.Atk.Bns."+12',}, priority=38}
	HercLegs.Phalanx = { name="Herculean Trousers", augments={'Potency of "Cure" effect received+6%','Mag. Acc.+8 "Mag.Atk.Bns."+8','Phalanx +5',}, priority=38}
	HercLegs.FC = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+18','"Fast Cast"+6','INT+10','Mag. Acc.+12',}, priority=38}
	HercFeet.Phalanx = { name="Herculean Boots", augments={'Sklchn.dmg.+2%','Pet: STR+9','Phalanx +5','Mag. Acc.+18 "Mag.Atk.Bns."+18',}, priority=9}
	HercFeet.Refresh = { name="Herculean Boots", augments={'"Store TP"+1','Spell interruption rate down -10%','"Refresh"+2',}, priority=9}
	HercFeet.Waltz = { name="Herculean Boots", augments={'"Waltz" potency +10%','STR+12','Damage taken-1%','Mag. Acc.+3 "Mag.Atk.Bns."+3',}, priority=9}

	Ogma = {}
	Ogma.SIRD = { name="Null Shawl"}
	Ogma.WSD = { name="Null Shawl"}
	Ogma.DT = { name="Null Shawl"}
	Ogma.FC = { name="Null Shawl"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Battuta'] = set_combine(sets.midcast.Enmity,{head="Fu. Bandeau +3"})
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.midcast.Enmity,{body="Futhark Coat +3"})
	sets.precast.JA['Swordplay'] = set_combine(sets.midcast.Enmity,{hands="Futhark Mitons +3"})
	sets.precast.JA['Embolden'] = set_combine(sets.midcast.Enmity,{back="Evasionist's Cape"})
	sets.precast.JA['Gambit'] = set_combine(sets.midcast.Enmity,{hands="Runeist Mitons +3"})
	sets.precast.JA['Inspiration'] = set_combine(sets.midcast.Enmity,{legs="Futhark Trousers +3"})
	sets.precast.JA['Liement'] = set_combine(sets.midcast.Enmity,{body="Futhark Coat +3"})
	sets.precast.JA['One for All'] = set_combine(sets.midcast.Enmity,{})  -- Shares a buff slot and does not stack with, in ascending order of priority: Rampart < Shining Ruby < Wind’s Blessing < One for All
	sets.precast.JA['Odyllic Subterfuge'] = set_combine(sets.midcast.Enmity,{})
	sets.precast.JA['Pflug'] = set_combine(sets.midcast.Enmity,{feet="Runeist Bottes +3"})
	sets.precast.JA['Rayke'] = set_combine(sets.midcast.Enmity,{feet="Futhark Boots +3"})
	sets.precast.JA['Swordplay'] = set_combine(sets.midcast.Enmity,{hands="Futhark Mitons +3"})
	sets.precast.JA['Valiance'] = set_combine(sets.midcast.Enmity,{body="Runeist Coat +2"})
	sets.precast.JA['Vallation'] = set_combine(sets.midcast.Enmity,{body="Runeist Coat +2"})
	sets.precast.JA['Vivacious Pulse'] = set_combine(sets.midcast.Enmity,{head="Erilaz Galea +3"})

	-- /drk abilities
	sets.precast.JA['Arcane Circle'] = sets.midcast.Enmity
	sets.precast.JA['Souleater'] = sets.midcast.Enmity
	sets.precast.JA['Last Resort'] = sets.midcast.Enmity

	-- Waltz set (chr and vit)
	sets.precast.Waltz = set_combine(sets.midcast.Enmity,{ammo="Yamarang",body="Passion Jacket"})

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = sets.midcast.Enmity

	sets.precast.Step = {} --{waist="Chaac Belt"}
	sets.precast.Flourish1 = {} --{waist="Chaac Belt"}

	sets.Refresh = {head={ name="Erilaz Galea +3", priority=111},waist={ name="Gishdubar Sash", priority=1},legs={name="Futhark Trousers +3", priority=107}}

	sets.EnhancingDuration = {head={ name="Erilaz Galea +3", priority=111},hands={ name="Regal Gauntlets", priority=205},legs={name="Futhark Trousers +3", priority=107}}

	-- Fast cast sets for spells
	-- Due to how Spell Interruption Rate is calculated, user must have a total of -102% Spell Interruption Rate Down

	sets.precast.FC = {ammo={ name="Sapience Orb", priority=1},
		head={name="Rune. Bandeau +3", priority=109},neck={ name="Orunmila's Torque", priority=1},ear1={ name="Loquacious Earring", priority=1},ear2={name="Odnowa earring +1", priority=110},
		body={ name="Erilaz Surcoat +3",priority=143},hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',},priority=25},ring1={ name="Moonlight Ring",priority=110},ring2="Kishar Ring",
		back="Null Shawl",waist={name="Plat. Mog. Belt", priority=300},legs={ name="Agwu's Slops", priority=50},feet={ name="Agwu's Pigaches", priority=27}}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {neck={ name="Incanter's Torque", priority=1},
		ear2={ name="Mimir Earring", priority=1}})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo={name="Knobkierrie", priority=1},
		head={ name="Nyame Helm", priority=91},neck={name="Republican Platinum Medal", priority=1},ear1={name="Moonshade Earring", priority=1},ear2="Hoxne Earring",
		body={name="Nyame Mail", priority=136},hands={name="Nyame Gauntlets", priority=91},ring1={ name="Regal Ring", priority=50},ring2={ name="Niqmaddu Ring", priority=1},
		back=Ogma.WSD,waist={ name="Sailfi Belt +1", priority=1},legs={name="Nyame Flanchard", priority=114},feet={name="Nyame Sollerets", priority=68}}

	sets.precast.WS.PDT = sets.precast.WS
	sets.precast.WS.MDT = set_combine(sets.precast.WS.PDT,{ neck={ name="Warder's Charm +1", priority=1 },waist={name="Plat. Mog. Belt", priority=300}} )

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Dimidiation: DEX:80%
	sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Dimidiation'].PDT = set_combine(sets.precast.WS['Dimidiation'], {})
	sets.precast.WS['Dimidiation'].MDT = set_combine(sets.precast.WS['Dimidiation'], {})
	sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {})
	
	-- Armor Break (m.acc focus)
	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS, {
		neck={name="Fotia Gorget", priority=1},ear1={name="Sherida Earring", priority=1},
		waist={name="Fotia Belt", priority=1}})

	-- Savage Blade: STR 50%; MND 50% 
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,{ammo={name="Aurgelmir Orb +1", priority=1},
		neck={ name="Fotia Gorget", priority=1},
		waist={ name="Fotia Belt", priority=1}})
	sets.precast.WS['Savage Blade'].PDT = set_combine(sets.precast.WS['Savage Blade'], {ammo={name="Aurgelmir Orb +1", priority=1},
		neck={ name="Fotia Gorget", priority=1},
		waist={ name="Fotia Belt", priority=1}})
	sets.precast.WS['Savage Blade'].MDT = set_combine(sets.precast.WS['Savage Blade'], {ammo={name="Aurgelmir Orb +1", priority=1},
		waist={ name="Fotia Belt", priority=1}})
		
	--------------------------------------
	-- Midcast sets
	--------------------------------------
		
	sets.midcast.Enmity = {ammo={ name="Sapience Orb", priority=1},
		head={name="Halitus Helm", priority=88},neck={name="Moonlight Necklace", priority=1},ear1={name="Cryptic Earring", priority=40},ear2={name="Erilaz Earring +1", priority=1},
		body={name="Adamantite Armor", priority=182},hands={ name="Futhark Mitons +3", priority=45},ring1={ name="Supershear Ring",priority=30},ring2={ name="Pernicious Ring", priority=1},
		back={name="Phalangite Mantle", priority=1},waist={ name="Plat. Mog. Belt", priority=300},legs={ name="Eri. Leg Guards +3", priority=100},feet={ name="Erilaz Greaves +3", priority=48}}

	-- you need a total of 102 to cap SIRD. Full merits in the category mean you only need 92% from gear. Probably best to use +enmity or -DT in the rest of the slots

	sets.midcast.SIRD = {ammo={name="Staunch Tathlum +1", priority=1},
		head={ name="Erilaz Galea +3", priority=111},neck={name="Moonlight Necklace", priority=1},ear1={name="Halasz Earring", priority=1},ear2={name="Erilaz Earring +1", priority=1},
		body={name="Adamantite Armor", priority=182},hands={ name="Regal Gauntlets", priority=205},ring1={name="Murky Ring", priority=1},ring2={name="Evanescence Ring", priority=1},
		back=Ogma.SIRD,waist={name="Audumbla Sash", priority=1},legs={name="Carmine Cuisses +1", priority=50}}

	sets.Phalanx = {ammo={name="Staunch Tathlum +1", priority=1},
		head={ name="Fu. Bandeau +3", priority=56}, neck="Elite Royal Collar",ear1={name="Odnowa earring +1", priority=110},ear2="Erilaz Earring +1",
		body=HercBody.Phalanx, hands=HercHands.Phalanx,ring1="Murky Ring",ring2={ name="Defending Ring",priority=1},
		back={ name="Moonbeam Cape", priority=250},waist={name="Plat. Mog. Belt", priority=300},legs=HercLegs.Phalanx,feet=HercFeet.Phalanx}
	sets.PhalanxSIRD = set_combine(sets.Phalanx, sets.midcast.SIRD)  --if you want to use SIRD with phalanx when SIRDMode is enabled. Make sure UseSIRDWithPhalanx = true is set. Otherwise, you get full-strength phalanx in both SIRD and Enmity modes
	
	sets.Stoneskin = set_combine(sets.engaged,{neck="Stone Gorget",ear1="Earthcry Earring",hands="Stone Mufflers",waist="Siegel Sash",legs="Haven Hose"})
	sets.Regen = set_combine({head={ name="Rune. Bandeau +3", priority=109},hands={ name="Regal Gauntlets", priority=205},legs={name="Futhark Trousers +3", priority=107}})

	-- WhiteMagic
	sets.midcast['Cure'] = sets.midcast.Enmity
	sets.midcast.SIRD['Cure'] = sets.midcast.SIRD
	sets.midcast['Cure II'] = sets.midcast.Enmity
	sets.midcast.SIRD['Cure II'] = sets.midcast.SIRD
	sets.midcast['Cure III'] = sets.midcast.Enmity
	sets.midcast.SIRD['Cure III'] = sets.midcast.SIRD
	sets.midcast['Cure IV'] = sets.midcast.Enmity
	sets.midcast.SIRD['Cure IV'] = sets.midcast.SIRD
	sets.midcast['Flash'] = sets.midcast.Enmity
	sets.midcast.SIRD["Flash"] = sets.midcast.SIRD

	-- WhiteMagic (enhancing)
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.SIRD,{neck={ name="Incanter's Torque", priority=1}})
	sets.midcast.SIRD['Enhancing Magic'] = sets.midcast.SIRD
	sets.midcast['Phalanx'] = sets.Phalanx
	sets.midcast.SIRD['Phalanx'] = sets.midcast.SIRD
	sets.midcast['Crusade'] = set_combine(sets.midcast.Enmity,sets.EnhancingDuration)
	sets.midcast.SIRD['Crusade'] = sets.midcast.SIRD
	sets.midcast['Enlight'] = sets.midcast.Enmity
	sets.midcast.SIRD['Enlight'] = sets.midcast.SIRD
	sets.midcast['Foil'] = sets.midcast.Enmity
	sets.midcast.SIRD['Foil'] = sets.midcast.SIRD
	sets.midcast['Regen III'] = sets.Regen
	sets.midcast.SIRD['Regen III'] = set_combine(sets.Regen,sets.midcast.SIRD)
	sets.midcast['Regen IV'] = sets.Regen
	sets.midcast.SIRD['Regen IV'] = set_combine(sets.Regen,sets.midcast.SIRD)
	sets.midcast.Protect = set_combine(sets.midcast.SIRD,{sets.EnhancingDuration},{ring1="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast.SIRD,{sets.EnhancingDuration},{ring1="Sheltered Ring"})
	--sets.midcast['Stoneskin'] = set_combine(sets.engaged,{neck="Stone Gorget",ear1="Earthcry Earring",hands="Stone Mufflers",waist="Siegel Sash",legs="Haven Hose"})
	--sets.midcast.SIRD['Stoneskin'] = set_combine(sets.midcast.SIRD,sets.midcast['Stoneskin'])

	-- BlackMagic
	sets.midcast['Stun'] = sets.midcast.Enmity
	sets.midcast.SIRD["Stun"] = sets.midcast.SIRD
	sets.midcast['Poisonga'] = sets.midcast.Enmity
	sets.midcast.SIRD["Poisonga"] = sets.midcast.SIRD
	sets.midcast['Poison'] = sets.midcast.Enmity
	sets.midcast.SIRD["Poison"] = sets.midcast.SIRD
	sets.midcast['Absorb-TP'] = sets.midcast.Enmity
	sets.midcast.SIRD['Absorb-TP'] = sets.midcast.SIRD
	sets.midcast['Sleep'] = sets.midcast.Enmity
	sets.midcast.SIRD["Sleep"] = sets.midcast.SIRD

	-- BlueMagic
	sets.midcast['Geist Wall'] = sets.midcast.Enmity
	sets.midcast.SIRD["Geist Wall"] = sets.midcast.SIRD
	sets.midcast['Blank Gaze'] = sets.midcast.Enmity
	sets.midcast.SIRD["Blank Gaze"] = sets.midcast.SIRD
	sets.midcast['Cocoon'] = sets.midcast.Enmity
	sets.midcast.SIRD["Cocoon"] = sets.midcast.SIRD
	sets.midcast['Jettatura'] = sets.midcast.Enmity
	sets.midcast.SIRD["Jettatura"] = sets.midcast.SIRD
	sets.midcast['Refueling'] = sets.midcast.Enmity
	sets.midcast.SIRD["Refueling"] = sets.midcast.SIRD
	sets.midcast['Sheep Song'] = sets.midcast.Enmity
	sets.midcast.SIRD["Sheep Song"] = sets.midcast.SIRD

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {} --{neck="Creed Collar",
		-- ring1="Sheltered Ring",ring2="Paguroidea Ring",
		-- waist="Austerity Belt"}

	sets.Charm = {neck={ name="Unmoving Collar +1", augments={'Path: A',}, priority=200},ear1={ name="Arete Del Luna +1", priority=1}}
	sets.Death = {neck={ name="Warder's Charm +1", priority=1},ring1={ name="Warden's Ring", priority=1},ring2={ name="Shadow Ring", priority=1}}

	sets.MaxHP = {
		head={ name="Erilaz Galea +3", priority=111},neck={ name="Unmoving Collar +1", augments={'Path: A',}, priority=200},ear1={ name="Alabaster Earring", priority=100},ear2={name="Odnowa earring +1", priority=110},
		body={ name="Adamantite Armor", priority=182},hands={ name="Regal Gauntlets", priority=205},ring1={name="Moonlight Ring", priority=110},ring2={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=135},
		back={ name="Moonbeam Cape", priority=250},waist={name="Plat. Mog. Belt", priority=300},legs={ name="Eri. Leg Guards +3", priority=100},feet={ name="Erilaz Greaves +3", priority=48}}

	-- Idle sets
	sets.idle = {ammo={name="Staunch Tathlum +1", priority=1},
		head={ name="Nyame Helm", priority=91},neck={name="Elite Royal Collar", priority=1},ear1={name="Odnowa earring +1", priority=110},ear2="Erilaz Earring +1",
		body={ name="Erilaz Surcoat +3",priority=143},hands={ name="Regal Gauntlets", priority=205},ring1={name="Murky Ring", priority=1},ring2={name="Moonlight Ring", priority=110},
		back=Ogma.DT,waist={name="Engraved Belt", priority=1},legs={ name="Eri. Leg Guards +3", priority=100},feet={ name="Erilaz Greaves +3", priority=48}}

	sets.idle.PDT = set_combine(sets.idle,{hands={ name="Futhark Mitons +3", priority=45}})
	sets.idle.MDT = {ammo="Vanir Battery",
		head={ name="Nyame Helm", priority=91},neck={name="Elite Royal Collar", priority=1},ear1={name="Sanare Earring", priority=1},ear2={name="Erilaz Earring +1", priority=1},
		body={ name="Erilaz Surcoat +3",priority=143},hands={ name="Futhark Mitons +3", priority=45},ring1={name="Murky Ring", priority=1},ring2="Shadow Ring",
		back="Null Shawl",waist={name="Engraved Belt", priority=1},legs={ name="Eri. Leg Guards +3", priority=100},feet={ name="Erilaz Greaves +3", priority=48}}
	sets.idle.Town = sets.idle
	sets.idle.Weak = sets.idle

	sets.Kiting = {ring1={name="Shneddick Ring +1",priority=1}}
	sets.latent_refresh = {} --{waist="Fucho-no-obi"}


	--------------------------------------
	-- Defense sets
	--------------------------------------
	
	-- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {} --{back="Repulse Mantle"}
	sets.MP = {} --{neck="Creed Collar",waist="Flume Belt"}
	sets.MP_Knockback = {} --{neck="Creed Collar",waist="Flume Belt",back="Repulse Mantle"}

	-- Basic defense sets.

	sets.defense.PDT = sets.idle.PDT
	sets.defense.Charm = {}
	-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
	-- Shellra V can provide 75/256, which would need another 53/256 in gear.
	
	sets.defense.MDT = set_combine(sets.defense.PDT, {neck={ name="Warder's Charm +1", priority=1 }})
	sets.defense.Normal = {} --empty set so you keep your melee/tp gear on



	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {ammo={name="Staunch Tathlum +1", priority=1},
		head={ name="Nyame Helm", priority=91},neck={name="Warder's Charm +1", priority=1},ear1={name="Odnowa earring +1", priority=110},ear2="Erilaz Earring +1",
		body={ name="Erilaz Surcoat +3",priority=143},hands={ name="Erilaz Gauntlets +3", priority=59},ring1={name="Moonlight Ring", priority=110},ring2={ name="Shadow Ring", priority=1},
		back=Ogma.DT,waist={name="Plat. Mog. Belt", priority=300},legs={ name="Eri. Leg Guards +3", priority=100},feet={ name="Erilaz Greaves +3", priority=48}}
	sets.engaged.Parry = set_combine(sets.engaged,{sub={name="Refined Grip +1",priority=35},hands={name="Turms Mittens +1",priority=74},ring2={ name="Gelatinous Ring +1", priority=135}})
		
	sets.engaged.Acc = set_combine(sets.engaged, {})

	sets.engaged.PDT = sets.engaged
	sets.engaged.MDT = sets.engaged
	sets.buff.Pflug = {feet={name="Runeist Bottes +3", priority=74}}

	--[[
	sets.engaged.DW = {ammo={ name="Ginsen", priority=1},
		head={ name="Reverence Coronet +3", priority=71},ear1={name="Telos Earring", priority=1},ear2={name="Dignitary's Earring", priority=1},
		body="Sulevia's Platemail +2",hands="Sulevia's Gauntlets +2",ring1={name="Chirich Ring +1", priority=1},ring2={name="Moonlight Ring", priority=110},
		back="Atheling Mantle",waist={name="Dynamic Belt +1", priority=1},legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2"}

	sets.engaged.DW.Acc = {ammo={ name="Ginsen", priority=1},
		head={ name="Reverence Coronet +3", priority=71},ear1={name="Telos Earring", priority=1},ear2={name="Dignitary's Earring", priority=1},
		body="Sulevia's Platemail +2",hands="Sulevia's Gauntlets +2",ring1={name="Chirich Ring +1", priority=1},ring2={name="Moonlight Ring", priority=110},
		back="Atheling Mantle",waist={name="Dynamic Belt +1", priority=1},legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2"}

	--]]
	
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {ammo="Yamarang"})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Doom = {neck={ name="Nicander's Necklace", priority=1},ring1={ name="Eshmun's Ring", priority=1},ring2={ name="Eshmun's Ring", priority=1},waist={ name="Gishdubar Sash", priority=1}}
	sets.buff.Curse = sets.buff.Doom
	
end

