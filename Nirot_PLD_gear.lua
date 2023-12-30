-- Define sets and vars used by this job file.
function init_gear_sets()

	UseSIRDWithPhalanx = true

	ValorousHead = {}
	ValorousBody = {}
	ValorousHead.Phalanx = { name="Valorous Mask", augments={'Pet: Mag. Acc.+2 Pet: "Mag.Atk.Bns."+2','Pet: AGI+8','Phalanx +5',},priority=38}
	ValorousBody.Phalanx = { name="Valorous Mail", augments={'Pet: DEX+1','"Mag.Atk.Bns."+11','Phalanx +4','Mag. Acc.+18 "Mag.Atk.Bns."+18',},priority=61}
	
	Rudianos = {}
	Rudianos.SIRD = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}, priority=80}
	Rudianos.WSD = { name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Phys. dmg. taken-10%',}, priority=80}
	Rudianos.DT = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}, priority=80}
	Rudianos.FC = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}, priority=80}

	EschiteLegs = {}
	EschiteLegs.FC = { name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}, priority=52}
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Invincible'] = set_combine(sets.midcast.Enmity,{legs={ name="Caballarius Breeches +3", priority=72}})
	sets.precast.JA['Holy Circle'] = set_combine(sets.midcast.Enmity,{feet={name="Reverence Leggings +3", priority=82}})
	sets.precast.JA['Shield Bash'] = set_combine(sets.midcast.Enmity,{hands={ name="Caballarius Gauntlets +3", priority=124},ear1={ name="Knightly Earring", priority=1}})
	sets.precast.JA['Sentinel'] = set_combine(sets.midcast.Enmity,{feet={ name="Caballarius Leggings +3", priority=63}})
	sets.precast.JA['Rampart'] = set_combine(sets.midcast.Enmity,{head={ name="Caballarius Coronet +3", priority=116}})
	sets.precast.JA['Fealty'] = set_combine(sets.midcast.Enmity,{body={ name="Caballarius Surcoat +3", priority=138}})
	sets.precast.JA['Divine Emblem'] = set_combine(sets.midcast.Enmity,{feet={ name="Chev. Sabatons +3", priority=52}})
	sets.precast.JA['Cover'] = set_combine(sets.midcast.Enmity,{head={ name="Reverence Coronet +3", priority=71}})

	-- /drk abilities
	sets.precast.JA['Arcane Circle'] = sets.midcast.Enmity
	sets.precast.JA['Souleater'] = sets.midcast.Enmity
	sets.precast.JA['Last Resort'] = sets.midcast.Enmity

	-- add mnd for Chivalry
	sets.precast.JA['Chivalry'] = set_combine(sets.midcast.Enmity,{
		head={ name="Reverence Coronet +3", priority=71},ear1={ name="Nourishing Earring +1", priority=1},
		hands={ name="Reverence Gauntlets +3", priority=113}})
   
	-- Waltz set (chr and vit)
	sets.precast.Waltz = set_combine(sets.midcast.Enmity,{
		head={name="Chev. Armet +3", priority=145},
		body={name="Sakpata's Plate", priority=136},hands={ name="Chev. Gauntlets +3", priority=64},
		waist={ name="Flume Belt +1", priority=1},legs={ name="Chev. Cuisses +3", priority=127},feet={name="Sakpata's Leggings", priority=68}})
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = sets.midcast.Enmity
	
	sets.precast.Step = {} --{waist="Chaac Belt"}
	sets.precast.Flourish1 = {} --{waist="Chaac Belt"}
		
	sets.Refresh = {waist={ name="Gishdubar Sash", priority=1}}
	sets.Srivatsa = {sub="Srivatsa"}
	
	sets.EnhancingDuration = {body="Shab. Cuirass +1"}
	sets.EnhancingDurationShield = {sub="Ajax +1"}
	sets.EnhancingDurationMain = {}  --put enhancing colada here if you ever make one
	sets.EnhancingDurationFull = {sub="Ajax +1"} --and add the colada here too
	
	-- Fast cast sets for spells
	
	--sets.precast['Divine Magic'] = {
	--	head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=280}, priority=280},ear1={ name="Loquacious Earring", priority=1},
	--	body={ name="Yorium Cuirass", augments={'Spell interruption rate down -9%',}},hands={ name="Yorium Gauntlets", augments={'Spell interruption rate down -10%',}},
	--	legs={name="Carmine Cuisses +1", priority=50}}--{ammo="Incantor Stone",
	 --   --head="Cizin Helm",ring2="Kishar Ring",legs="Enif Cosciales"}
		
	-- FC best options:
	-- Sapience Orb: 2
	-- Chev Armet +2: 8
	-- Orunmila Torque: 5
	-- Etiolation: 1
	-- Loquacious: 2
	-- Leyline: 6
	-- Weatherspoon ring +1: 6
	-- Kishar: 4
	-- Chev. Sabatons +3: 13	
	-- 
	-- Total: 44
	-- Keeping SIRD gear in the precast set as well so not all of these pieces will be used
		
	-- SIRD options:
	-- Staunch Tath +1: 11
	-- Souv Schal +1: 20
	-- Loricate Torque +1: 5
	-- Knightly Earring: 9
	-- Nourishing Earring +1: 5
	-- Yorium Cuirass: 9 / Chev. Cuirass +2: 15
	-- Yorium Gauntlets: 10
	-- Audumbla Sash: 10
	-- Founder's Hose: 30
	-- Odyssean Greaves: 30
	--
	-- Total: 139/145
	
	-- Due to how Spell Interruption Rate is calculated, user must have a total of -102% Spell Interruption Rate Down
		
	sets.precast.FC = {ammo={ name="Sapience Orb", priority=1},
		head={name="Chev. Armet +3", priority=145},neck={ name="Orunmila's Torque", priority=1},ear1={ name="Loquacious Earring", priority=1},ear2={name="Odnowa earring +1", priority=110},
		body={ name="Rev. Surcoat +3",priority=254},hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',},priority=25},ring1={ name="Defending Ring",priority=1},ring2="Kishar Ring",
		back=Rudianos.FC,waist={name="Plat. Mog. Belt", priority=300},legs=EschiteLegs.FC,feet={ name="Chev. Sabatons +3", priority=52}}
		
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {neck={ name="Incanter's Torque", priority=1},
		ear2={ name="Andoaa Earring", priority=1}})
		
	--sets.precast.FC.Cure = set_combine(sets.precast.FC, {neck="Diemer Gorget",hands="Yorium Gauntlets"})
		
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo={name="Aurgelmir Orb +1", priority=1},
		head={ name="Cab. Coronet +3", priority=116},neck={name="Kgt. Beads +2", priority=60},ear1={name="Tuisto Earring", priority=150},ear2="Moonshade Earring",
		body={name="Sakpata's Plate", priority=136},hands={name="Sakpata's Gauntlets", priority=91},ring1={ name="Epaminondas's Ring", priority=1},ring2={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=135},
		back=Rudianos.WSD,waist={ name="Fotia Belt", priority=1},legs={name="Sakpata's Cuisses", priority=114},feet={name="Sakpata's Leggings", priority=68}}
		
	sets.precast.WS.PDT = {ammo={name="Aurgelmir Orb +1", priority=1},
		head={ name="Cab. Coronet +3", priority=116},neck={name="Kgt. Beads +2", priority=60},ear1={name="Tuisto Earring", priority=150},ear2="Moonshade Earring",
		body={name="Sakpata's Plate", priority=136},hands={name="Sakpata's Gauntlets", priority=91},ring1={ name="Epaminondas's Ring", priority=1},ring2={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=135},
		back=Rudianos.WSD,waist={ name="Fotia Belt", priority=1},legs={name="Sakpata's Cuisses", priority=114},feet={name="Sakpata's Leggings", priority=68}}
		
	sets.precast.WS.MDT = set_combine(sets.precast.WS.PDT,{ neck={ name="Warder's Charm +1", priority=1 }} )

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo={ name="Ginsen", priority=1},
		head={ name="Cab. Coronet +3", priority=116},neck={name="Kgt. Beads +2", priority=60},ear1={name="Tuisto Earring", priority=150},ear2="Moonshade Earring",
		body={name="Sakpata's Plate", priority=136},hands={name="Sakpata's Gauntlets", priority=91},ring1={ name="Epaminondas's Ring", priority=1},ring2={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=135},
		back=Rudianos.WSD,waist={name="Sailfi belt +1", priority=1},legs={name="Sakpata's Cuisses", priority=114},feet={name="Sakpata's Leggings", priority=68}})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	-- Requiescat: MND:73~85%, depending on merit points ugrades. 
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].PDT = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].MDT = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {waist=gear.ElementalBelt})

	-- CDC: DEX:80% 
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {head={ name="Hjarrandi Helm", priority=114},neck="Fotia Gorget",body={ name="Hjarrandi Breast.", priority=228},waist="Fotia Belt"}) --{hands="Buremte Gloves",waist="Zoran's Belt"})
	sets.precast.WS['Chant du Cygne'].PDT = set_combine(sets.precast.WS['Chant du Cygne'], {})
	sets.precast.WS['Chant du Cygne'].MDT = set_combine(sets.precast.WS['Chant du Cygne'], {})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {})

	-- Sanguine Blade: STR:30% ; MND:50% 
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS,{}) 
	sets.precast.WS['Sanguine Blade'].PDT = set_combine(sets.precast.WS['Sanguine Blade'],{}) 
	sets.precast.WS['Sanguine Blade'].MDT = set_combine(sets.precast.WS['Sanguine Blade'],{}) 
	
	-- Atonement: Based on accumulated enmity, caps at 1190
	sets.precast.WS['Atonement'] = set_combine(sets.precast.WS,{
		legs={ name="Caballarius Breeches +3", priority=72},feet={ name="Caballarius Leggings +3", priority=63}})
	sets.precast.WS['Atonement'].PDT = set_combine(sets.precast.WS['Atonement'], {})
	sets.precast.WS['Atonement'].MDT = set_combine(sets.precast.WS['Atonement'], {})
		
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

	sets.midcast.FastRecast = {
		head={name="Chev. Armet +3", priority=145},ear1={ name="Loquacious Earring", priority=1},
		body={name="Sakpata's Plate", priority=136},hands={ name="Chev. Gauntlets +3", priority=64},
		waist={name="Dynamic Belt +1", priority=1},legs={ name="Chev. Cuisses +3", priority=127},feet={name="Sakpata's Leggings", priority=68}}
		
	sets.midcast.Enmity = {ammo={ name="Sapience Orb", priority=1},
		head={ name="Loess Barbuta +1", augments={'Path: A',}, priority=105},neck={name="Moonlight Necklace", priority=1},ear1={name="Cryptic Earring", priority=40},ear2={name="Odnowa earring +1", priority=110},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=171},hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=239},ring1={ name="Defending Ring",priority=1},ring2={ name="Apeile Ring +1", priority=1},
		back=Rudianos.SIRD,waist={ name="Creed Baudrier", priority=40},legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=162},feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=227}}

	-- you need a total of 102 to cap SIRD. Full merits in the category mean you only need 92% from gear. Probably best to use +enmity or -DT in the rest of the slots
	-- ear1={ name="Loquacious Earring", priority=1},body={ name="Yorium Cuirass", augments={'Spell interruption rate down -9%',}},hands={ name="Yorium Gauntlets", augments={'Spell interruption rate down -10%',}}
	
	--ammo={name="Staunch Tathlum +1", priority=1} = 11
	--head="Souv. Schaller +1" = 20
	--ear2={ name="Knightly Earring", priority=1} = 9
	--waist="Audumbla Sash" = 10
	--legs="Founder's Hose" = 30
	--feet="Odyssean Greaves" = 30

	sets.midcast.SIRD = {ammo={name="Staunch Tathlum +1", priority=1},
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=280},neck={name="Moonlight Necklace", priority=1},ear1={ name="Knightly Earring", priority=1},ear2={name="Odnowa earring +1", priority=110},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=171},hands={name="Chev. Gauntlets +3", priority=64},ring1={ name="Defending Ring",priority=1},ring2={ name="Apeile Ring +1", priority=1},
		back=Rudianos.SIRD,waist={name="Plat. Mog. Belt", priority=300},legs={name="Founder's Hose", priority=54},feet={ name="Odyssean Greaves", augments={'INT+5','Spell interruption rate down -10%','"Store TP"+2','Accuracy+18 Attack+18','Mag. Acc.+16 "Mag.Atk.Bns."+16',}, priority=20}}
	
	sets.Phalanx = {
		head=ValorousHead.Phalanx, priority=38,
		body=ValorousBody.Phalanx, priority=61,hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=239},
		back={ name="Weard Mantle", augments={'VIT+4','Enmity+2','Phalanx +5',}, priority=40},legs={name="Sakpata's Cuisses", priority=114},feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=227}}
	sets.PhalanxMain = {main="Sakpata's Sword"}
	sets.PhalanxSub = {sub="Priwen"}
	sets.PhalanxFull = set_combine(sets.Phalanx,{main="Sakpata's Sword",sub="Priwen"})
	sets.PhalanxSIRD = set_combine(sets.Phalanx, sets.midcast.SIRD)  --if you want to use SIRD with phalanx when SIRDMode is enabled. Make sure UseSIRDWithPhalanx = true is set. Otherwise, you get full-strength phalanx in both SIRD and Enmity modes
	
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
	sets.midcast['Crusade'] = sets.midcast.Enmity
	sets.midcast.SIRD['Crusade'] = sets.midcast.SIRD
	sets.midcast['Reprisal'] = sets.midcast.Enmity
	sets.midcast.SIRD['Reprisal'] = sets.midcast.SIRD
	sets.midcast['Enlight'] = sets.midcast.Enmity
	sets.midcast.SIRD['Enlight'] = sets.midcast.SIRD
	sets.midcast['Enlight II'] = sets.midcast.Enmity
	sets.midcast.SIRD['Enlight II'] = sets.midcast.SIRD
	sets.midcast.Protect = set_combine(sets.midcast.SIRD,{sets.EnhancingDuration}) --{ring1="Sheltered Ring"}
	sets.midcast.Shell = set_combine(sets.midcast.SIRD,{sets.EnhancingDuration}) --{ring1="Sheltered Ring"}

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

	sets.Reraise = {} --{head="Twilight Helm", body="Twilight Mail"}
	
	sets.resting = {} --{neck="Creed Collar",
		-- ring1="Sheltered Ring",ring2="Paguroidea Ring",
		-- waist="Austerity Belt"}
 
	sets.Charm = {neck={ name="Unmoving Collar +1", augments={'Path: A',}, priority=200},ear1={ name="Arete Del Luna +1", priority=1},legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=162}}
	sets.Death = {neck={ name="Warder's Charm +1", priority=1},ring1={ name="Shadow Ring", priority=1},ring2={ name="Warden's Ring", priority=1}}
 
	sets.MaxHP = {
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=280},neck={ name="Unmoving Collar +1", augments={'Path: A',}, priority=200},ear1={ name="Sanare Earring", priority=1},ear2={name="Odnowa earring +1", priority=110},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=171},hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=239},ring1={name="Moonlight Ring", priority=110},ring2={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=135},
		back="Moonbeam Cape",waist={name="Plat. Mog. Belt", priority=300},legs={ name="Chev. Cuisses +3", priority=127},feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=227}}

	-- Idle sets
	sets.idle = {ammo={name="Staunch Tathlum +1", priority=1},
		head={name="Chev. Armet +3", priority=145},neck={name="Kgt. Beads +2", priority=60},ear1={ name="Sanare Earring", priority=1},ear2={name="Odnowa earring +1", priority=110},
		body={ name="Sacro Breastplate",priority=178},hands={ name="Chev. Gauntlets +3", priority=64},ring1={ name="Defending Ring",priority=1},ring2={ name="Apeile Ring +1", priority=1},
		back=Rudianos.DT,waist={name="Plat. Mog. Belt", priority=300},legs={ name="Chev. Cuisses +3", priority=127},feet={name="Reverence Leggings +3", priority=82}}

	sets.idle.PDT = set_combine(sets.idle,{})
	sets.idle.MDT = set_combine(sets.idle,{neck={ name="Warder's Charm +1", priority=1 }})	
	sets.idle.Town = sets.idle
	sets.idle.Weak = sets.idle
	
	sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
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
		
	sets.defense.PDT = {ammo={name="Staunch Tathlum +1", priority=1},
		head={name="Chev. Armet +3", priority=145},neck={name="Kgt. Beads +2", priority=60},
		body={name="Sakpata's Plate", priority=136},hands={ name="Chev. Gauntlets +3", priority=64},ring1={ name="Defending Ring",priority=1},ring2={ name="Apeile Ring +1", priority=1},
		back=Rudianos.DT,waist={ name="Flume Belt +1", priority=1},legs={ name="Chev. Cuisses +3", priority=127},feet={name="Sakpata's Leggings", priority=68}}
	sets.defense.HP = {}
	sets.defense.Reraise = {}
	sets.defense.Charm = {}
	-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
	-- Shellra V can provide 75/256, which would need another 53/256 in gear.
	
	sets.defense.MDT = set_combine(sets.defense.PDT, {neck={ name="Warder's Charm +1", priority=1 }})
	sets.defense.Normal = {} --empty set so you keep your melee/tp gear on



	--------------------------------------
	-- Engaged sets
	--------------------------------------
	
	sets.engaged = {ammo={name="Aurgelmir Orb +1", priority=1},
		head={name="Chev. Armet +3", priority=145},neck={ name="Warder's Charm +1", priority=1},ear1={name="Telos Earring", priority=1},ear2={name="Odnowa earring +1", priority=110},
		body={name="Sakpata's Plate", priority=136},hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=239},ring1={name="Chirich Ring +1", priority=1},ring2={name="Moonlight Ring", priority=110},
		back=Rudianos.DT,waist={name="Sailfi belt +1", priority=1},legs={ name="Chev. Cuisses +3", priority=127},feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=227}}

	sets.engaged.Acc = {ammo={ name="Ginsen", priority=1},
		head={name="Chev. Armet +3", priority=145},neck={ name="Warder's Charm +1", priority=1},ear1={name="Telos Earring", priority=1},ear2={name="Dignitary's Earring", priority=1},
		body={name="Sakpata's Plate", priority=136},hands={name="Sakpata's Gauntlets", priority=91},ring1={name="Chirich Ring +1", priority=1},ring2={name="Moonlight Ring", priority=110},
		back=Rudianos.DT,waist={name="Dynamic Belt +1", priority=1},legs={name="Sakpata's Cuisses", priority=114},feet={name="Sakpata's Leggings", priority=68}}

	sets.engaged.PDT = {ammo={name="Staunch Tathlum +1", priority=1},
		head={name="Chev. Armet +3", priority=145},neck={ name="Warder's Charm +1", priority=1},ear1={name="Telos Earring", priority=1},ear2={ name="Ethereal Earring", priority=1},
		body={name="Sakpata's Plate", priority=136},hands={ name="Chev. Gauntlets +3", priority=64},ring1={ name="Defending Ring",priority=1},ring2={ name="Pernicious Ring", priority=1},
		back=Rudianos.DT,waist={ name="Flume Belt +1", priority=1},legs={ name="Chev. Cuisses +3", priority=127}}
		
	sets.engaged.MDT = set_combine(sets.engaged.PDT, {ear1={ name="Sanare Earring", priority=1},ring2={ name="Purity Ring", priority=1},waist={ name="Creed Baudrier", priority=40}})
				
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
	
   -- sets.engaged.PDT = set_combine(sets.engaged, {body={ name="Caballarius Surcoat +3", priority=138},neck={name="Kgt. Beads +2", priority=60},ring1={ name="Defending Ring",priority=1},back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {neck={name="Kgt. Beads +2", priority=60},ring1={ name="Defending Ring",priority=1},back=Rudianos.DT})
	sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
	sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

	-- sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {body="Reverence Surcoat +1",neck="Loricate Torque +1",ring1={ name="Defending Ring",priority=1},back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}})
	-- sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {body="Reverence Surcoat +1",neck="Loricate Torque +1",ring1={ name="Defending Ring",priority=1},back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}})
	-- sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
	-- sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Doom = {neck={ name="Nicander's Necklace", priority=1},ring1={ name="Eshmun's Ring", priority=1},ring2={ name="Eshmun's Ring", priority=1},waist={ name="Gishdubar Sash", priority=1},legs={ name="Shabti Cuisses +1",priority=41}}
	sets.buff.Curse = sets.buff.Doom
	sets.buff.Cover = {head={ name="Reverence Coronet +3", priority=71}, body={ name="Caballarius Surcoat +3", priority=138}}
end

