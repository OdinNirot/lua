-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
	res = require('resources')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
	state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
	state.Buff.Convergence = buffactive.Convergence or false
	state.Buff.Diffusion = buffactive.Diffusion or false
	state.Buff.Efflux = buffactive.Efflux or false

	state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

	state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Doom'] = buffactive['doom'] or false
	state.Buff['Bane'] = buffactive['bane'] or false
	state.Buff['Terror'] = buffactive['terror'] or false
	state.Buff['Stun'] = buffactive['stun'] or false
	state.Buff['Petrification'] = buffactive['petrification'] or false

	include('Mote-TreasureHunter')
	send_command('unbind ^-') --unbind this key which is set in Mote-Globals.lua so we can use it


	blue_magic_maps = {}

	-- Mappings for gear sets to use for various blue magic spells.
	-- While Str isn't listed for each, it's generally assumed as being at least
	-- moderately signficant, even for spells with other mods.

	-- PHYSICAL SPELLS -- ------------------------------------------------------------------------------------------------------------

	-- Physical spells with no particular (or known) stat mods
	blue_magic_maps.Physical = S{
		'Bilgestorm'
	}
	-- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
	blue_magic_maps.PhysicalAcc = S{
		'Heavy Strike',
	}
	-- Physical spells with Str stat mod
	blue_magic_maps.PhysicalStr = S{
		'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
		'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
		'Uppercut','Vertical Cleave'
	}
	-- Physical spells with Dex stat mod
	blue_magic_maps.PhysicalDex = S{
		'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
		'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
		'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
		'Vanity Dive'
	}
	-- Physical spells with Vit stat mod
	blue_magic_maps.PhysicalVit = S{
		'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
		'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
	}
	-- Physical spells with Agi stat mod
	blue_magic_maps.PhysicalAgi = S{
		'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
		'Pinecone Bomb','Spiral Spin','Wild Oats'
	}
	-- Physical spells with Int stat mod
	blue_magic_maps.PhysicalInt = S{
		'Mandibular Bite','Queasyshroom'
	}
	-- Physical spells with Mnd stat mod
	blue_magic_maps.PhysicalMnd = S{
		'Ram Charge','Screwdriver','Tourbillion'
	}
	-- Physical spells with Chr stat mod
	blue_magic_maps.PhysicalChr = S{
		'Bludgeon'
	}
	-- Physical spells with HP stat mod
	blue_magic_maps.PhysicalHP = S{
		'Final Sting'
	}
	-- MAGICAL SPELLS -- ------------------------------------------------------------------------------------------------------------

	-- Magical spells with the typical Int mod
	blue_magic_maps.Magical = S{
		'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
		'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
		'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
		'Retinal Glare','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'
	}
	-- Magical spells with a primary Mnd mod
	blue_magic_maps.MagicalMnd = S{
		'Acrid Stream','Magic Hammer','Mind Blast'
	}
	-- Magical spells with a primary Chr mod
	blue_magic_maps.MagicalChr = S{
		'Mysterious Light'
	}
	-- Magical spells with a Vit stat mod (on top of Int)
	blue_magic_maps.MagicalVit = S{
		'Thermal Pulse','Entomb'
	}
	-- Magical spells with a Dex stat mod (on top of Int)
	blue_magic_maps.MagicalDex = S{
		'Charged Whisker','Gates of Hades'
	}

	blue_magic_maps.Dark = S{
		'Blood Saber', 'Dark Orb', 'Death Ray', 'Eyes On Me',
		'Evryone. Grudge', 'Palling Salvo', 'Tenebral Crush'
	}

	-- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
	-- Add Int for damage where available, though.
	blue_magic_maps.MagicAccuracy = S{
		'1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
		'Blank Gaze','Blistering Roar','Blood Drain','Chaotic Eye',
		'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
		'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
		'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
		'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
		'Sandspin','Sandspray','Sheep Song','Silent Storm','Soporific','Sound Blast','Stinking Gas',
		'Sub-zero Smash','Tourbillion','Venom Shell','Voracious Trunk','Yawn'
	}
	-- Breath-based spells
	blue_magic_maps.Breath = S{
		'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
		'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
		'Thunder Breath','Vapor Spray','Wind Breath'
	}
	-- Stun spells
	blue_magic_maps.Stun = S{
		'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
		'Thunderbolt','Whirl of Rage'
	}
	-- Healing spells
	blue_magic_maps.Healing = S{
		'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
		'Wild Carrot'
	}

	-- Buffs that depend on blue magic skill
	blue_magic_maps.SkillBasedBuff = S{
		'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
		'Pyric Bulwark','Reactor Cool',
	}
	-- Other general buffs
	blue_magic_maps.Buff = S{
		'Amplification','Animating Wail','Carcharian Verve','Cocoon',
		'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
		'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
		'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
		'Zephyr Mantle'
	}

	blue_magic_maps.Refresh = S{
		'Battery Charge'
	}

	-- Spells that require Unbridled Learning to cast.
	unbridled_spells = S{
		'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
		'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
		'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot'
	}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc', 'Refresh')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT')
	state.HybridMode:options('Normal','PDT') --"engaged" sets
	state.CursnaGear = M(true, 'CursnaGear')

	state.Kiting              = M(true, 'Kiting')
	state.ExtraResist = M('Normal','Charm','Death')

	--gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind !` input /ja "Efflux" <me>')
	send_command('bind @` input /ja "Burst Affinity" <me>')
	send_command('bind numpad. gs c cycle HybridMode')
	send_command('bind numpad3 gs c cycle OffenseMode')
	send_command('bind numpad4 gs c cycle ExtraResist')
	send_command('bind ^backspace gs c cycle CursnaGear')

	send_command('bind ^- gs c cycle Kiting')
	send_command('bind ^= gs c cycle TreasureMode')


	update_combat_form()
	select_default_macro_book()

	PhalanxAbility = S{"Phalanx","Phalanx II"}
	RefreshAbility = S{"Refresh","Refresh II","Refresh III","Battery Charge"}

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind @`')
	send_command('unbind numpad.')
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind ^-')
	send_command('unbind ^=')
	send_command('unbind ^backspace')
end


-- Set up gear sets.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {feet="Hashishin Basmak +3"}
	sets.buff['Chain Affinity'] = {head="Hashishin Kavuk +3"} --feet="Assim. Charuqs +2"
	sets.buff.Convergence = {head="Luhlaza Keffiyeh +3"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +3"}
	sets.buff.Enchainment = {body="Luhlaza Jubbah +3"}
	sets.buff.Efflux = {legs="Hashishin Tayt +3"}

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

	Nyame = {head="Nyame Helm",body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	HercHead = {}
	HercBody = {}
	HercHands = {}
	HercLegs = {}
	HercFeet = {}
	HercHead.Refresh = { name="Herculean Helm", augments={'"Dbl.Atk."+2','Pet: Accuracy+13 Pet: Rng. Acc.+13','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',} }
	HercHead.Phalanx = { name="Herculean Helm", augments={'Pet: INT+6','Weapon skill damage +1%','Phalanx +4',}}
	HercHead.TH = { name="Herculean Helm", augments={'"Store TP"+1','"Avatar perpetuation cost" -1','"Treasure Hunter"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',} }
	HercHead.FC = { name="Herculean Helm", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Accuracy+3','"Fast Cast"+7',}}
	HercBody.Phalanx = { name="Herculean Vest", augments={'Mag. Acc.+19','Magic dmg. taken -1%','Phalanx +5',}}
	HercHands.Refresh = { name="Herculean Gloves", augments={'DEX+5','VIT+13','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
	HercHands.FC = { name="Herculean Gloves", augments={'Pet: "Mag.Atk.Bns."+20','STR+7','"Fast Cast"+8','Accuracy+15 Attack+15',}}
	HercHands.TH = { name="Herculean Gloves", augments={'Accuracy+1 Attack+1','Weapon skill damage +2%','"Treasure Hunter"+2',}}
	HercHands.Phalanx = { name="Herculean Gloves", augments={'Pet: "Dbl. Atk."+2','Potency of "Cure" effect received+6%','Phalanx +4','Accuracy+5 Attack+5','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	HercLegs.Refresh = { name="Herculean Trousers", augments={'AGI+7','"Mag.Atk.Bns."+13','"Refresh"+2','Accuracy+8 Attack+8',}}
	HercLegs.Healing = { name="Herculean Trousers", augments={'"Triple Atk."+2','"Cure" potency +10%','Damage taken-2%','Accuracy+20 Attack+20','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	HercLegs.Phalanx = { name="Herculean Trousers", augments={'Mag. Acc.+15','Phalanx +4','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
	HercLegs.FC = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+18','"Fast Cast"+6','INT+10','Mag. Acc.+12',}}
	HercFeet.Refresh = { name="Herculean Boots", augments={'DEX+10','STR+2','"Refresh"+2','Accuracy+11 Attack+11',}}
	HercFeet.Waltz = { name="Herculean Boots", augments={'"Waltz" potency +10%','STR+12','Damage taken-1%','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}

	AdhemarHead = {}
	AdhemarBody = {}
	AdhemarHands = {}
	AdhemarHead.StrDexAtk = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemarBody.FC = { name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}}
	AdhemarHands.StrDexAtk = { name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}

	TaeonHead = {}
	TaeonHead.SIRD = { name="Taeon Chapeau", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Spell interruption rate down -10%','STR+6 VIT+6',}}

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

	Rosmerta = {}
	Rosmerta.MAB = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Damage taken-5%',}}
	Rosmerta.WS = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	Rosmerta.TP = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luhlaza Bazubands +3"}
	sets.precast.JA['Burst Affinity'] = {legs="Assim. Shalwar +3",feet="Hashishin Basmak +3"}
	sets.precast.JA['Chain Affinity'] = {head="Hashishin Kavuk +3",feet="Assim. Charuqs +2"}
	sets.precast.JA['Diffusion'] = {feet="Luhlaza Charuqs +3"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		body="Passion Jacket",
		legs="Dashing Subligar",feet=HercFeet.Waltz}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
		head=HercHead.FC,neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Etiolation Earring",
		body={ name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}},hands=HercHands.FC,ring1="Kishar Ring",ring2="Rahab Ring",
		back="Fi Follet Cape +1",waist="Witful Belt",legs=HercLegs.FC,feet="Amalric Nails +1"}

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {}) --{body="Mavi Mintan +2"}
	sets.TreasureHunter = {head=HercHead.TH,hands=HercHands.TH}
	sets.buff.Doom = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar Sash"} --{ring2="Saida Ring"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Oshasha's Treatise",
		head="Hashishin Kavuk +3",neck="Mirage Stole +2",ear1="Moonshade Earring",ear2="Odr Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Cornelia's Ring",
		back=Rosmerta.WS,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.precast.WS.PDT = set_combine(sets.precast.WS,Nyame)
	sets.precast.WS.acc = set_combine(sets.precast.WS, {}) --{hands="Buremte Gloves"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ammo="Coiste Bodhar",
		neck="Fotia Gorget",ear2="Regal Earring",
		ring1="Epona's Ring",ring2="Metamorph Ring +1",
		waist="Fotia Belt"}) 
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS,{ammo="Ghastly Tathlum +1",
		head="Hashishin Kavuk +3",neck="Sibyl Scarf",ear1="Regal Earring",ear2="Friomisi Earring",
		hands="Hashishin Bazubands +3",ring1="Archon Ring",
		back=Rosmerta.MAB,waist="Orpheus's Sash",legs="Luhlaza Shalwar +3"})
	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS,{ammo="Coiste Bodhar",
		ear1="Odr Earring",ear2="Hashishin Earring +1",
		ring1="Beithir Ring"})
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,{ammo="Coiste Bodhar",
		ear1="Regal Earring",ear2="Odnowa Earring +1"})

	sets.precast.WS['Seraph Strike'] = set_combine(sets.precast.WS,{ammo="Crepuscular Pebble",
		neck="Baetyl Pendant",ear1="Odnowa Earring +1",ear2="Regal Earring",
		hands="Hashishin Bazubands +3",
		waist="Orpheus's Sash",legs="Luhlaza Shalwar +3"})
	sets.precast.WS['True Strike'] = set_combine(sets.precast.WS,{ammo="Coiste Bodhar",
		head=AdhemarHead.StrDexAtk,ear1="Brutal Earring",ear2="Hashi. Earring +1",
		body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Sroda Ring",ring2="Epona's Ring",
		legs="Gleti's Breeches"})
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS,{ammo="Coiste Bodhar",
		ear1="Odnowa Earring +1",ear2="Regal Earring"})
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS,{ammo="Coiste Bodhar",
		ear1="Telos Earring",ear2="Regal Earring",
		ring1="Beithir Ring"})
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS,{ammo="Coiste Bodhar",
		neck="Fotia Gorget",ear1="Regal Earring",ear2="Telos Earring",
		hands="Hashishin Bazubands +3",ring1="Metamorph Ring +1",ring2="Sroda Ring",
		waist="Fotia Belt"})

	-- Midcast Sets
	--sets.midcast.FastRecast = {
		--head="Haruspex Hat",ear2="Loquacious Earring",
		--body="Luhlaza Jubbah +1",hands="Mavi Bazubands +2",ring1="Prolix Ring",
		--back="Swith Cape +1",waist="Hurch'lan Sash",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}

	sets.SIRD = {ammo="Staunch Tathlum +1",
		head=TaeonHead.SIRD,neck="Loricate Torque +1",ear1="Halasz Earring",ear2="Etiolation Earring",
		body="Hashishin Mintan +3",hands="Amalric Gages +1",ring1="Evanescence Ring",ring2="Defending Ring",
		back="Fi Follet Cape +1",waist="Emphatikos Rope",legs="Assim. Shalwar +3",feet="Amalric Nails +1"}

	sets.midcast['Blue Magic'] = {}

	-- Normal melee group
	sets.engaged = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Mirage Stole +2",ear1="Suppanomimi",ear2="Dedition Earring",
		body="Adhemar Jacket +1",hands="Malignance Gloves",ring1="Defending Ring",ring2="Epona's Ring",
		back=Rosmerta.TP,waist="Windbuffet Belt +1",legs="Malignance Tights",feet={ name="Herculean Boots", augments={'Accuracy+18','"Triple Atk."+4','DEX+7',}}}

	sets.engaged.PDT = set_combine(sets.engaged,{
		head="Malignance Chapeau",ear2="Telos Earring",
		hands="Malignance Gloves",ring1="Defending Ring"})

	sets.engaged.Acc = set_combine(sets.engaged,{ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",ear1="Telos Earring",ear2="Hashi. Earring +1",
		hands="Gazu Bracelets +1",ring1="Moonlight Ring",
		waist="Reiki Yotai",legs="Hashishin Tayt +3"})
	sets.engaged.Refresh = set_combine(sets.engaged,{})
	sets.engaged.DW = set_combine(sets.engaged,{})
	sets.engaged.DW.Acc = set_combine(sets.engaged.Acc,{})
	sets.engaged.DW.PDT = set_combine(sets.engaged.PDT,{})
	sets.engaged.DW.Refresh = set_combine(sets.engaged,{})

	-- Physical Spells --

	sets.midcast['Blue Magic'].Physical = {ammo="Aurgelmir Orb +1",
		head="Luh. Keffiyeh +3",neck="Mirage Stole +2",ear1="Telos Earring",ear2="Hashi. Earring +1",
		body="Luhlaza Jubbah +3",hands="Luh. Bazubands +3",ring1="Stikini Ring +1",ring2="Ilabrat Ring",
		back=Rosmerta.WS,waist="Sailfi Belt +1",legs="Hashishin Tayt +3",feet="Luhlaza Charuqs +3"}
	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.engaged.Acc,{})
	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,{}) --{body="Iuitl Vest",hands="Assimilator's Bazubands +1"}
	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,{}) --{ammo="Jukukik Feather",body="Iuitl Vest",hands="Assimilator's Bazubands +1",waist="Chaac Belt",legs="Manibozho Brais"}
	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,{}) --{body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Iximulew Cape"}
	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,{}) --{body="Vanir Cotehardie",hands="Iuitl Wristbands",ring2="Stormsoul Ring",waist="Chaac Belt",feet="Iuitl Gaiters +1"}
	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,{}) --{ear1="Psystorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring2="Icesoul Ring",back="Toro Cape",feet="Hagondes Sabots"}
	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,{}) --{ear1="Lifestorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring2="Aquasoul Ring",back="Refraction Cape"}
	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,{}) --{body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Refraction Cape",waist="Chaac Belt"}
	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical,{})

	-- Magical Spells --

	sets.midcast['Blue Magic'].Magical = {ammo="Ghastly Tathlum +1",
		head="Hashishin Kavuk +3",neck="Sibyl Scarf",ear1="Friomisi Earring",ear2="Hashi. Earring +1",
		body="Hashishin Mintan +3",hands="Hashishin Bazubands +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=Rosmerta.MAB,waist="Orpheus's Sash",legs="Luhlaza Shalwar +3",feet="Hashishin Basmak +3"}
	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,{}) --{body="Vanir Cotehardie",ring1="Sangoma Ring",legs="Iuitl Tights",feet="Hashishin Basmak +3"}
	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,{}) --{ring1="Aquasoul Ring"}
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical,{})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,{}) --{ring1="Spiral Ring"}
	sets.midcast['Blue Magic'].Entomb = set_combine(sets.midcast['Blue Magic'].MagicalVit,{neck="Quanpur Necklace",back="Aurist's Cape +1"})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical,{})
	sets.midcast['Blue Magic'].Dark = set_combine(sets.midcast['Blue Magic'].Magical,{head="Pixie Hairpin +1"})
	sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Ghastly Tathlum +1",
		head="Hashishin Kavuk +3",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Hashi. Earring +1",
		body="Hashishin Mintan +3",hands="Hashishin Bazubands +3",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=Rosmerta.MAB,waist="Acuity Belt +1",legs="Hashishin Tayt +3",feet="Hashishin Basmak +3"}

	-- Breath Spells --

	sets.midcast['Blue Magic'].Breath = sets.midcast['Blue Magic'].Magical 

	-- Other Types --

	sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,{}) --{waist="Chaac Belt"}
	sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,{legs=HercLegs.Healing})
	sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic'].MagicAccuracy

	sets.midcast['Blue Magic'].Buff = {}
	sets.midcast['Blue Magic'].Refresh = set_combine(sets.midcast['Blue Magic'].Buff,{head="Amalric Coif +1",waist="Gishdubar Sash"})
	sets.midcast['Elemental Magic'] = sets.midcast['Blue Magic'].Magical
	sets.ElementalMagicMAB = {}
	--	Earth={neck={name="Quanpur Necklace", mp=10}},
	--	Dark={
	--	head={ name="Pixie Hairpin +1", hp=-35,mp=120},
	--	rring="Archon Ring",
	--	}
	--	}

	sets.midcast.EnhancingDuration = {
		head=TelHead.Duration,neck="Incanter's Torque",ear1="Mimir Earring",
		body=TelBody.Duration,hands=TelHands.Duration,
		legs=TelLegs.Duration,feet=TelFeet.Duration}

	sets.midcast.Protect = {ring1="Sheltered Ring"}
	sets.midcast.Protectra = {ring1="Sheltered Ring"}
	sets.midcast.Shell = {ring1="Sheltered Ring"}
	sets.midcast.Shellra = {ring1="Sheltered Ring"}
	sets.midcast.Phalanx = set_combine(sets.midcast.EnhancingDuration, {head=HercHead.Phalanx,body=HercBody.Phalanx,hands=HercHands.Phalanx,legs=HercLegs.Phalanx})

	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- Resting sets
	sets.resting = sets.idle
	sets.resting.PDT = sets.idle.PDT

	-- Idle sets
	sets.idle = {ammo="Staunch Tathlum +1",
		head=HercHead.Refresh,neck="Elite Royal Collar",ear1="Ethereal Earring",ear2="Etiolation Earring",
		body="Hashishin Mintan +3",hands=HercHands.Refresh,ring1="Chirich Ring +1",ring2="Defending Ring",
		back="Engulfer Cape +1",waist="Flume Belt +1",legs="Hashishin Tayt +3",feet=HercFeet.Refresh}

	sets.idle.PDT = set_combine(sets.idle,{})	
	sets.idle.Town = sets.idle

	-- Defense sets
	--sets.defense.PDT = {ammo="Ginsen",
		--head="Malignance Chapeau",neck="Elite Royal Collar",ear1="Ethereal Earring",ear2="Hearty Earring",
		--body="Mekosu. Harness",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
		--back="Atheling Mantle",waist="Carrier's Sash",legs="Malignance Tights",feet="Malignance Boots"}

	--sets.defense.MDT = {ammo="Ginsen",
		--head="Malignance Chapeau",neck="Elite Royal Collar",ear1="Ethereal Earring",ear2="Hearty Earring",
		--body="Mekosu. Harness",hands="Malignance Gloves",ring1={ name="Dark Ring", augments={'Magic dmg. taken -5%','Spell interruption rate down -4%','Phys. dmg. taken -3%',}},ring2="Defending Ring",
		--back="Atheling Mantle",waist="Carrier's Sash",legs="Malignance Tights",feet="Malignance Boots"}

	sets.Kiting = {ring1="Shneddick Ring +1"}
	sets.Charm = {neck="Unmoving Collar +1",ear1="Arete Del Luna +1"}
	sets.Death = {neck="Warder's Charm +1",body="Samnuha Coat",ring1="Shadow Ring",ring2="Warden's Ring"}
	sets.Refresh = {waist="Gishdubar Sash"}
	
	-- don't forget to add these pieces to your midcast as well
	sets.Phalanx = {head=HercHead.Phalanx,body=HercBody.Phalanx,hands=HercHands.Phalanx,legs=HercLegs.Phalanx}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
		eventArgs.cancel = true
		windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
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
		if RefreshAbility:contains(act_info.name) then
			do_equip('sets.Refresh')
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

function weathercheck(spell_element,mob_dist,mob_size,set)
	if not set then return end
	if spell_element == world.weather_element and (get_weather_intensity() == 2 and spell_element ~= elements.weak_to[world.day_element]) then
		equip(set,{waist="Hachirin-no-Obi"})
	-- Target distance under 1.7 yalms.
	elseif mob_dist < (1.7 + mob_size) then
		equip(set,{waist="Orpheus's Sash"})
	-- Matching day and weather.
	elseif spell_element == world.day_element and spell_element == world.weather_element then
		equip(set,{waist="Hachirin-no-Obi"})
	-- Target distance under 8 yalms.
	elseif mob_dist < (8 + mob_size) then
		equip(set,{waist="Orpheus's Sash"})
	-- Match day or weather.
	elseif spell_element == world.day_element or spell_element == world.weather_element then
		equip(set,{waist="Hachirin-no-Obi"})
	else
		equip(set)
	end
	if set[spell_element] then equip(set[spell_element]) end
end

function zodiaccheck(spell)
	if spell.element == world.day_element and spell.element ~= 'Dark' and spell.element ~= 'Light' then
		equip(sets.Zodiac)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Add enhancement gear for Chain Affinity, etc.
	if state.HybridMode.value ~= 'PDT' then
		if spell.skill == 'Blue Magic' then
			for buff,active in pairs(state.Buff) do
				if active and sets.buff[buff] then
					equip(sets.buff[buff])
				end
			end
			if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
				equip(sets.self_healing)
			end
			if spellMap == 'Physical' and sets.midcast['Blue Magic'].Physical then
				equip(sets.midcast['Blue Magic'].Physical)
			end
			if spellMap == 'PhysicalAcc' and sets.midcast['Blue Magic'].PhysicalAcc then
				equip(sets.midcast['Blue Magic'].PhysicalAcc)
			end
			if spellMap == 'PhysicalStr' and sets.midcast['Blue Magic'].PhysicalStr then
				equip(sets.midcast['Blue Magic'].PhysicalStr)
			end
			if spellMap == 'PhysicalDex' and sets.midcast['Blue Magic'].PhysicalDex then
				equip(sets.midcast['Blue Magic'].PhysicalDex)
			end
			if spellMap == 'PhysicalVit' and sets.midcast['Blue Magic'].PhysicalVit then
				equip(sets.midcast['Blue Magic'].PhysicalVit)
			end
			if spellMap == 'PhysicalAgi' and sets.midcast['Blue Magic'].PhysicalAgi then
				equip(sets.midcast['Blue Magic'].PhysicalAgi)
			end
			if spellMap == 'PhysicalInt' and sets.midcast['Blue Magic'].PhysicalInt then
				equip(sets.midcast['Blue Magic'].PhysicalInt)
			end
			if spellMap == 'PhysicalMnd' and sets.midcast['Blue Magic'].PhysicalMnd then
				equip(sets.midcast['Blue Magic'].PhysicalMnd)
			end
			if spellMap == 'PhysicalChr' and sets.midcast['Blue Magic'].PhysicalChr then
				equip(sets.midcast['Blue Magic'].PhysicalChr)
			end
			if spellMap == 'PhysicalHP' and sets.midcast['Blue Magic'].PhysicalHP then
				equip(sets.midcast['Blue Magic'].PhysicalHP)
			end
			if spellMap == 'Magical' and sets.midcast['Blue Magic'].Magical then
				weathercheck(spell.element,spell.target.distance,spell.target.model_size,sets.midcast['Blue Magic'].Magical)
			end
			if spellMap == 'MagicalMnd' and sets.midcast['Blue Magic'].MagicalMnd then
				weathercheck(spell.element,spell.target.distance,spell.target.model_size,sets.midcast['Blue Magic'].MagicalMnd)
			end
			if spellMap == 'MagicalChr' and sets.midcast['Blue Magic'].MagicalChr then
				weathercheck(spell.element,spell.target.distance,spell.target.model_size,sets.midcast['Blue Magic'].MagicalChr)
			end
			if spellMap == 'MagicalVit' and sets.midcast['Blue Magic'].MagicalVit then
				if sets.midcast['Blue Magic'].Entomb then
					equip(sets.midcast['Blue Magic'].Entomb)
				else
					weathercheck(spell.element,spell.target.distance,spell.target.model_size,sets.midcast['Blue Magic'].MagicalVit)
				end
			end
			if spellMap == 'MagicalDex' and sets.midcast['Blue Magic'].MagicalDex then
				weathercheck(spell.element,spell.target.distance,spell.target.model_size,sets.midcast['Blue Magic'].MagicalDex)
			end
			if spellMap == 'Dark' and sets.midcast['Blue Magic'].Dark then
				weathercheck(spell.element,spell.target.distance,spell.target.model_size,sets.midcast['Blue Magic'].Dark)
			end
			if spellMap == 'MagicAccuracy' and sets.midcast['Blue Magic'].MagicAccuracy then
				equip(sets.midcast['Blue Magic'].MagicAccuracy)
			end
			if spellMap == 'Breath' and sets.midcast['Blue Magic'].Breath then
				equip(sets.midcast['Blue Magic'].Breath)
			end
			if spellMap == 'Stun' and sets.midcast['Blue Magic'].Stun then
				equip(sets.midcast['Blue Magic'].Stun)
			end
			if spellMap == 'SkillBasedBuff' and sets.midcast['Blue Magic'].SkillBasedBuff then
				equip(sets.midcast['Blue Magic'].SkillBasedBuff)
			end
		end

	--	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then --if TH mode is on, the assumption is you're farming anyway, just do it for all blue magic
		if state.TreasureMode.current == 'Tag' and spell.skill == 'Blue Magic' then
			equip(sets.TreasureHunter)
		end
		
		if string.find(spell.english,'Cur') and spell.english ~='Cursna' then 
			weathercheck(spell.element,sets.midcast.Cure)
		elseif spell.english == 'Impact' then
			weathercheck(spell.element,set_combine(sets.midcast['Elemental Magic'],sets.Impact))
		elseif spell.english == 'Death' then
			equip(sets.midcast.Death)
		elseif sets.midcast[spell.name] then
			weathercheck(spell.element,sets.midcast[spell.name])
		elseif spell.skill == 'Elemental Magic' then
			weathercheck(spell.element,sets.midcast['Elemental Magic'])
			zodiaccheck(spell)
			if sets.ElementalMagicMAB[spell.element] then
				equip(sets.ElementalMagicMAB[spell.element])
			end
		elseif spell.skill == "Enhancing Magic" and not S{'Warp','Warp II','Retrace','Teleport-Holla','Teleport-Mea','Teleport-Dem','Teleport-Altep','Teleport-Vahzl','Teleport-Yhoat','Phalanx'}:contains(spell.english) then
			equip(sets.midcast.EnhancingDuration)
		elseif spell.skill then
			--equip(sets.aftercast.Idle,sets.aftercast[tp_level])
			weathercheck(spell.element,sets.midcast[spell.skill])
		end
	else
		equip(sets.SIRD)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
	if spell.skill == 'Blue Magic' then
		for category,spell_list in pairs(blue_magic_maps) do
			if spell_list:contains(spell.english) then
				return category
			end
		end
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.mpp < 51 then
		set_combine(idleSet, sets.latent_refresh)
	end
	if state.HybridMode.value == 'PDT' then
		idleSet = sets.idle.PDT
	end
	if state.ExtraResist.value == 'Charm' then
		idleSet = set_combine(idleset,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		idleSet = set_combine(idleset,sets.Death)
	end
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		--if state.Buff['Curse'] or state.Buff['Doom'] or state.Buff['Bane'] then
		idleSet = set_combine(idleSet,sets.buff.Doom)
	end
	return idleSet
end

function customize_resting_set(restingSet)
	if buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane'] then
		restingSet = set_combine(restingSet,sets.buff.Doom)
	else
		restingSet = set.resting
	end
	return restingSet
end

function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
	if state.ExtraResist.value == 'Charm' then
		meleeSet = set_combine(meleeSet,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		meleeSet = set_combine(meleeSet,sets.Death)
	end
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
		meleeSet = set_combine(meleeSet,sets.engaged.PDT)
	end
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		meleeSet = set_combine(meleeSet,sets.buff.Doom)
	end
	
	return meleeSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	local cf_msg = ''
	if state.CombatForm.has_value then
		cf_msg = ' (' ..state.CombatForm.value.. ')'
	end

	o_msg = state.OffenseMode.value
	
	--	if state.HybridMode.value ~= 'Normal' then
	--		m_msg = m_msg .. '/' ..state.HybridMode.value
	m_msg = state.HybridMode.value
	--	end


	if state.ExtraResist.value then
		er_msg = state.ExtraResist.value
	else 
		er_msg = 'None'
	end

	if state.TreasureMode.value then
		t_msg = state.TreasureMode.value
	else
		t_msg = 'None'
	end

	local k_msg = ''
	if state.Kiting.value then
		k_msg = k_msg .. 'Enabled'
	else 
		k_msg = k_msg .. ' Off'
	end

	add_to_chat(string.char(31,210).. 'HybridMode: ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' Offense: ' ..string.char(31,001)..o_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' ExtraResist: ' ..string.char(31,001)..er_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' TreasureMode: ' ..string.char(31,001)..t_msg.. string.char(31,002)..  ' |'
		..string.char(31,008).. ' Kiting: ' ..string.char(31,001)..k_msg.. string.char(31,002)
		)

	eventArgs.handled = true

end



-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
	-- Check for H2H or single-wielding
	if player.equipment.sub == "Genmei Shield" or player.equipment.sub == 'empty' then
		state.CombatForm:reset()
	else
		state.CombatForm:set('DW')
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(6, 16)
	else
		set_macro_page(6, 16)
	end
end

function set_style(sheet)
	send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(4)
