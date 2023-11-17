-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff.Chainspell = {body="Vitiation Tabard +3"}
	sets.buff.Saboteur = {hands="Lethargy Gantherots +3"}
	sets.buff.Stymie = {head="Lethargy Chappel +3",body="Lethargy Sayon +3",hands="Lethargy Gantherots +3",legs="Lethargy Fuseau +3",feet="Leth. Houseaux +3"}
	
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
	
	ChironicHands = {}
	ChironicLegs = {}
	ChironicFeet = {}
	ChironicHands.Refresh = { name="Chironic Gloves", augments={'Pet: AGI+9','"Fast Cast"+4','"Refresh"+2','Accuracy+5 Attack+5',}}
	ChironicLegs.Refresh = { name="Chironic Hose", augments={'DEX+5','INT+4','"Refresh"+2','Accuracy+2 Attack+2',}}
	ChironicFeet.Refresh = { name="Chironic Slippers", augments={'"Fast Cast"+2','Mag. Acc.+18','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	
    TelHead = {}
    TelBody = {}
    TelHands = {}
    TelLegs = {}
    TelFeet = {}
	
	TelHead.Duration = { name="Telchine Cap", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelBody.Duration = { name="Telchine Chas.", augments={'Mag. Evasion+21','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelHands.Duration = { name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelLegs.Duration = { name="Telchine Braconi", augments={'Mag. Evasion+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	TelFeet.Duration = { name="Telchine Pigaches", augments={'Mag. Evasion+20','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}
	
	Malignance = {head="Malignance Chapeau",body="Malignance Tabard",hands="Malignance Gloves",legs="Malignance Tights",feet="Malignance Boots"}
	
	Sucellos = {}
	Sucellos.Normal = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}}
	Sucellos.DW = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}}
	
	sets.Prime = {main="Caliburnus"}

	
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Chainspell = sets.buff.Chainspell
	sets.precast.JA['Convert'] = {main="Murgleis"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {legs="Dashing Subligar"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {main="Crocea Mors",sub="Ammurapi Shield",ammo="Impatiens",
        head="Atrophy Chapeau +3",neck="Loricate Torque +1",ear1="Sanare Earring",ear2="Leth. Earring +1",
		body="Vitiation Tabard +3",hands="Gendewitha Gages +1",ring1="Rahab Ring",ring2="Kishar Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Volte Brais",feet="Amalric Nails +1"}
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{waist="Siegel Sash"})
	sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC,{head="Lethargy Chappel +3"})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC,{head="Umuthi Hat",neck="Nodens Gorget",ear1="Earthcry Earring",hands="Stone Mufflers",waist="Siegel Sash",legs="Shedir Seraweels"})
	sets.precast.FC['Impact'] = set_combine(sets.precast.FC,{head=empty,body="Crepuscular Cloak"})
	sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC,{main="Daybreak"})

        
	sets.TreasureHunter = {head=MerlinicHead.TH,hands=MerlinicHands.TH}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
		head="Nyame Helm",neck="Rep. Plat. Medal",ear1="Telos Earring",ear2="Sherida Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Ilabrat Ring",
		back="Phalangite Mantle",waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.precast.WS.PDT = set_combine(sets.precast.WS,{})
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, {}) --{hands="Buremte Gloves"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].PDT = set_combine(sets.precast.WS.PDT, {})
    sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS, {ammo="Sroda Tathlum",
		head="Lethargy Chappel +3",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Malignance Earring",
		hands="Lethargy Gantherots +3",ring2="Freke Ring",
		back=Sucellos.Normal,waist="Orpheus's Sash",feet="Leth. Houseaux +3"})
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {ammo="Sroda Tathlum",
		head="Pixie Hairpin +1",neck="Sibyl Scarf",ear="Regal Earring",ear2="Malignance Earring",
		hands="Jhakri Cuffs +2",ring1="Metamor. Ring +1",ring2="Archon Ring",
		back=Sucellos.Normal,waist="Orpheus's Sash"})
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head="Lethargy Chappel +3",neck="Combatant's Torque",ear1="Moonshade Earring",ear2="Dominance Earring +1",
		body="Lethargy Sayon +3",hands="Gazu Bracelets +1",ring2="Cacoethic Ring +1",
		back=Sucellos.Normal,waist="Kentarch Belt +1",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"})
		
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {ammo="Voluspa Tathlum",
		head="Lethargy Chappel +3",neck="Combatant's Torque",ear1="Moonshade Earring",ear2="Dominance Earring +1",
		body="Lethargy Sayon +3",hands="Gazu Bracelets +1",ring1="Ephramad's Ring",ring2="Cacoethic Ring +1",
		back=Sucellos.Normal,waist="Kentarch Belt +1",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"})
		

	sets.midcast['Enfeebling Magic'] = {}
    sets.midcast['Enfeebling Magic'].base = {main="Murgleis",sub="Ammurapi Shield",
		head="Vitiation Chapeau +3",neck="Duelist's Torque +2",ear1="Snotra Earring",ear2="Regal Earring",
		body="Atrophy Tabard +3",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=Sucellos.Normal,waist="Acuity Belt +1",legs="Leth. Fuseau +3",feet="Vitiation Boots +3"}
    sets.midcast['Enfeebling Magic'].potency = set_combine(sets.midcast['Enfeebling Magic'].base,{ammo="Regal Gem",body="Lethargy Sayon +3"})
    sets.midcast['Enfeebling Magic'].mndpot = set_combine(sets.midcast['Enfeebling Magic'].base,{ammo="Regal Gem",ring1="Metamor. Ring +1"})
    sets.midcast['Enfeebling Magic'].skillmndpot = set_combine(sets.midcast['Enfeebling Magic'].base,{ammo="Regal Gem",waist="Luminary Sash"})
    sets.midcast['Enfeebling Magic'].macc = set_combine(sets.midcast['Enfeebling Magic'].base,{range="Ullr",ear2="Leth. Earring +1",body="Lethargy Sayon +3",hands="Lethargy Gantherots +3",back="Aurist's Cape +1",feet="Leth. Houseaux +3"})
    sets.midcast['Enfeebling Magic'].intpot = set_combine(sets.midcast['Enfeebling Magic'].base,{ammo="Regal Gem",ring1="Metamor. Ring +1"})
    sets.midcast['Enfeebling Magic'].skillpot = set_combine(sets.midcast['Enfeebling Magic'].base,{})
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'].macc,{head=empty,body="Crepuscular Cloak",ring1="Metamor. Ring +1",back="Aurist's Cape +1",feet="Leth. Houseaux +3"})
	sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'].macc,{main="Daybreak"})
	
	sets.midcast['Enhancing Magic'] = {}
	sets.midcast['Enhancing Magic'].nocomposure = {main="Daybreak",sub="Ammurapi Shield",
		head=TelHead.Duration,neck="Duelist's Torque +2",body="Vitiation Tabard +3",hands="Atrophy Gloves +3",ear1="Andoaa Earring",ear2="Leth. Earring +1",
		back="Ghostfyre Cape",waist="Embla Sash",legs=TelLegs.Duration,feet="Leth. Houseaux +3"}
	sets.midcast['Enhancing Magic'].composure = set_combine(sets.midcast['Enhancing Magic'].nocomposure,{head="Lethargy Chappel +3",body="Lethargy Sayon +3",legs="Lethargy Fuseau +3"})
	sets.midcast['Enhancing Magic'].EnhancingSkill = set_combine(sets.midcast['Enhancing Magic'].nocomposure,{sub="Forfend +1",
		head="Befouled Crown",body="Viti. Tabard +3",hands="Viti. Gloves +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		waist="Olympus Sash",legs="Atrophy Tights +3",feet="Leth. Houseaux +3"})
	sets.midcast['Enhancing Magic'].NoEnhancingSkill = {}
	sets.midcast.Stoneskin = {neck="Nodens Gorget",ear1="Earthcry Earring",hands="Stone Mufflers",waist="Siegel Sash",legs="Shedir Seraweels"}
	sets.midcast.Aquaveil = {head="Amalric Coif +1",hands="Regal Cuffs",legs="Shedir Seraweels"}
	sets.midcast['Enhancing Magic'].RefreshSpells = {head="Amalric Coif +1",body="Atrophy Tabard +3",hands="Atrophy Gloves +3",legs="Lethargy Fuseau +3",feet="Leth. Houseaux +3"}
	sets.midcast.BarSpells = {neck="Sroda Necklace"}
	sets.midcast.RegenSpells = {main="Bolelabunga"}
	sets.midcast.GainSpells = sets.midcast['Enhancing Magic'].EnhancingSkill
	sets.midcast.Cursna = {head="Vanya Hood",neck="Debilis Medallion",ear1="Meili Earring",ear2="Beatific Earring",hands="Hieros Mittens",ring1="Menelaus's Ring",ring2="Haoma's Ring",back="Oretan. Cape +1",waist="Bishop's Sash",legs="Vanya Slops",feet="Vanya Clogs"}
	
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
	sets.midcast.Sneak = {back="Skulker's Cape"}
	sets.midcast.Invisible = {back="Skulker's Cape"}
	
	sets.midcast['Elemental Magic'] = {}
	sets.midcast["Elemental Magic"].base = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="Lethargy Chappel +3",neck="Sibyl Scarf",ear1="Malignance Earring",ear2="Regal Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=Sucellos.Normal,waist="Acuity Belt +1",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
	sets.midcast.Death = sets.midcast['Elemental Magic'].base
    sets.Burst = set_combine(sets.midcast["Elemental Magic"].base,{head="Ea Hat +1",body="Ea Houppe. +1",hands="Amalric Gages +1"}) --{ hands="Hattori Tekko +1", feet=HercFeet.MAB})
	
	sets.midcast.Cure = {main="Daybreak",Sub="Sacro Bulwark",
        head="Kaykaus Mitra +1",neck="Incanter's Torque",ear1="Mendicant's Earring",ear2="Novia Earring",
        body="Bunzi's Robe",hands="Kaykaus Cuffs +1",ring1="Kishar Ring",ring2="Naji's Loop",
        back="Ghostfyre Cape",waist="Bishop's Sash",legs="Kaykaus Tights +1",feet="Kaykaus Boots +1"}	
    
    -- Sets to return to when not performing an action.
    sets.latent_refresh = {waist="Fucho-no-obi"}
    
    -- Idle sets
    sets.idle = {main="Colada",Sub="Sacro Bulwark",ammo="Homiliary",
		head="Vitiation Chapeau +3",neck="Yngvi Choker",ear1="Sanare Earring",ear2="Etiolation Earring",
        body="Lethargy Sayon +3",hands=ChironicHands.Refresh,ring1="Defending Ring",ring2="Stikini Ring +1",
        back=Sucellos.Normal,waist="Carrier's Sash",legs={ name="Merlinic Shalwar", augments={'Pet: Mag. Acc.+1','Accuracy+4 Attack+4','"Refresh"+2','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},feet=ChironicFeet.Refresh}

    sets.idle.PDT = set_combine(sets.idle,{hands="Lethargy Gantherots +3"})
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
    sets.engaged = {ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",neck="Combatant's Torque",ear1="Sherida Earring",ear2="Lethargy Earring +1",
		body="Malignance Tabard",hands="Gazu Bracelets +1",ring1="Ephramad's Ring",ring2="Chirich Ring +1",
		back=Sucellos.Normal,waist="Kentarch Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
	sets.engaged.PDT = set_combine(sets.engaged,{neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.DW = set_combine(sets.engaged,{ear1="Suppanomimi",ear2="Eabani Earring",waist="Reiki Yotai",legs="Carmine Cuisses +1"})
	sets.engaged.DW.PDT = set_combine(sets.engaged.DW,sets.engaged.PDT)
	
	sets.engaged.enspell = set_combine(sets.engaged,{
		ear2="Sherida Earring",
		hands="Aya. Manopolas +2",ring1="Chirich Ring +1",ring2="Ilabrat Ring",
		back="Ghostfyre Cape",waist="Orpheus's Sash",legs="Viti. Tights +3"})
	sets.engaged.enspell.PDT = set_combine(sets.engaged.enspell,{ammo="Staunch Tathlum +1",
		neck="Loricate Torque +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		legs="Malignance Tights"})
    sets.engaged.enspell.DW = set_combine(sets.engaged.enspell,{ear1="Suppanomimi",ear2="Eabani Earring",back=Sucellos.DW,legs="Carmine Cuisses +1"})
    sets.engaged.enspell.DW.Acc = set_combine(sets.engaged.enspell.DW,{ammo="Ginsen",neck="Lissome Necklace",body="Malignance Tabard",ring2="Patricius Ring",back=Sucellos.DW,legs="Carmine Cuisses +1",feet="Malignance Boots"})
		
--    sets.engaged.Acc = set_combine(sets.engaged,{})
--    sets.engaged.Refresh = set_combine(sets.engaged,{})
--    sets.engaged.DW.Acc = set_combine(sets.engaged,{})
--    sets.engaged.DW.Refresh = set_combine(sets.engaged,{})
    sets.engaged.DW.enspell = set_combine(sets.engaged.enspell,{ear1="Suppanomimi",ear2="Eabani Earring",back=Sucellos.DW,legs="Carmine Cuisses +1"})
    sets.engaged.DW.enspell.PDT = set_combine(sets.engaged.enspell.DW,{ammo="Staunch Tathlum +1",
		neck="Loricate Torque +1",body="Malignance Tabard",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=Sucellos.DW,legs="Malignance Tights"})

    sets.buff.Curse = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar Sash"}
	sets.Charm = {neck="Unmoving Collar +1",ear1="Arete Del Luna +1"}
	sets.Death = {neck="Warder's Charm +1",ring1="Shadow Ring",ring2="Warden's Ring"}
end

