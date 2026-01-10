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
    state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Doom'] = buffactive['doom'] or false
	state.Buff['Bane'] = buffactive['bane'] or false
    state.Buff['Terror'] = buffactive['terror'] or false
    state.Buff['Stun'] = buffactive['stun'] or false
    state.Buff['Petrification'] = buffactive['petrification'] or false
	--state.Kiting = M(true)
	state.ElementalResist = M(false, 'EleResist')
    state.Crepuscular = M(false, 'Crepuscular')

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
      "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
	paList = S{'Shining One'}
	cList = S{'Mafic Cudgel'}
	gkList = S{'Dojikiri Yasutsuna'}
	dagList = S{'Mercurial Kris','Malevolence','Ternion Dagger'}
	weakList = S{'Soboro Sukehiro','Quint Spear'}
	dwSubs = S{'NIN','THF','DNC'}
	dwList =S{'Utu Grip'}
	
    include('Mote-TreasureHunter')
	get_combat_weapon()	
--	state.TreasureMode = M{['description']='Treasure Mode'}
--  state.TreasureMode:options('None','Tag')
--	state.TreasureMode:set('Tag')

	send_command('get "Storage Slip 16" sack') --AF +1
	send_command('get "Storage Slip 18" sack') --relic +1
	send_command('get "Storage Slip 29" sack') --empy +2

	end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'SomeAccuracy','MaxAccuracy','SubtleBlow')
    state.WeaponskillMode:options('Normal', 'NotAttackCapped', 'Accuracy','WeakMode')
    state.HybridMode:options('Normal', 'DT')
	state.CursnaGear = M(true, 'CursnaGear')
--    state.PhysicalDefenseMode:options('PDT', 'HP')
--	state.PhysicalDefenseMode = 'None'
	
	send_command('bind ^= gs c cycle TreasureMode')
	send_command('bind ^- gs c cycle Kiting')
	send_command('bind ^backspace gs c cycle CursnaGear')
    send_command('bind F11 gs c cycle Crepuscular')
    send_command('bind numpad. gs c cycle HybridMode')
    send_command('bind numpad2 gs c cycle ElementalResist')
    send_command('bind numpad3 gs c cycle OffenseMode')
    send_command('bind numpad6 gs c cycle WeaponskillMode')

    update_combat_form()
    update_melee_groups()
	
	PhalanxAbility = S{"Phalanx II"}
	
end

function user_unload()
    --send_command('unbind ^`')
    --send_command('unbind !-')
	send_command('unbind numpad.')
	send_command('unbind ^=')
	send_command('unbind ^-')
	send_command('unbind ^backspace')
	send_command('unbind F11')
	send_command('unbind numpad2')
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind numpad5')
	send_command('unbind numpad6')	
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    	
	ValorousHead = {}
	ValorousBody = {}
	ValorousHands = {}
	ValorousLegs = {}
	ValorousFeet = {}
	
	ValorousHead.Phalanx = { name="Valorous Mask", augments={'Pet: Mag. Acc.+2 Pet: "Mag.Atk.Bns."+2','Pet: AGI+8','Phalanx +5',}}
	ValorousHead.TH = { name="Valorous Mask", augments={'Attack+23','INT+3','"Treasure Hunter"+2',}}
	ValorousHead.WSD = { name="Valorous Mask", augments={'Mag. Acc.+5','Pet: Haste+1','Weapon skill damage +8%','Accuracy+20 Attack+20','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
	
	ValorousBody.Phalanx = { name="Valorous Mail", augments={'STR+7','DEX+5','Phalanx +5','Accuracy+5 Attack+5','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	ValorousBody.Waltz = { name="Valorous Mail", augments={'"Waltz" potency +10%','Pet: STR+2','"Store TP"+2','Accuracy+14 Attack+14',}}
	
	ValorousHands.Phalanx = { name="Valorous Mitts", augments={'Mag. Acc.+17','"Mag.Atk.Bns."+17','Phalanx +4',}}
	
	ValorousLegs.TH ={ name="Valorous Hose", augments={'Pet: STR+2','Pet: Attack+12 Pet: Rng.Atk.+12','"Treasure Hunter"+2',}}
	ValorousLegs.Phalanx = { name="Valorous Hose", augments={'Mag. Acc.+1','Pet: "Store TP"+2','Phalanx +4','Accuracy+7 Attack+7',}}

	ValorousFeet.Phalanx = { name="Valorous Greaves", augments={'Enmity-1','Crit. hit damage +1%','Phalanx +4','Accuracy+20 Attack+20','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
		
	Nyame = {head="Nyame Helm",body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	
	Smertrios = {}
	Smertrios.DexDA = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Smertrios.StrWS = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	Smertrios.DexWS = Smertrios.StrWS
	
	sets.Crepuscular = {head="Crepuscular Helm",body="Crepuscular Mail"}
	
    -- Precast Sets
	
	sets.precast.Enmity = {ammo={ name="Sapience Orb", priority=1},
        head="Loess Barbuta +1",neck={name="Warder's Charm +1", priority=1},ear1={name="Cryptic Earring", priority=40},ear2={name="Odnowa earring +1", priority=110},
        ring1={ name="Petrov Ring", priority=1},ring2={ name="Pernicious Ring",priority=1},
        back="Phalangite Mantle",legs={ name="Zoar Subligar +1", priority=47}}
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Seigan'] = {head="Kasuga Kabuto +3"}
    sets.precast.JA['Hasso'] = {hands="Wakido Kote +3",legs="Kasuga Haidate +3",feet="Wakido Sune-Ate +3"}
    sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +3"}
    sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +3"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Meditate'] = {head="Wakido Kabuto +3",hands="Sakonji Kote +3",back=Smertrios.DexDA}
    sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate +3"}
    sets.precast.JA['Provoke'] = sets.precast.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {body=ValorousBody.Waltz,legs="Dashing Subligar"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

	-- optionally apply some TH with these abilities
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}


    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Sapience Orb",
		neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Etiolation Earring",
		body="Sacro Breastplate",hands="Leyline Gloves",ring1="Naji's Loop",ring2="Rahab Ring",
		legs="Founder's Hose"}
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
		head="Nyame Helm",neck="Samurai's Nodowa +2",ear1="Moonshade Earring",ear2="Schere Earring",
		body="Nyame Mail",hands="Kasuga Kote +3",ring1="Cornelia's Ring",ring2="Niqmaddu Ring",
		back=Smertrios.StrWS,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.precast.WS.NotAttackCapped = sets.precast.WS
	sets.precast.WS.Accuracy = set_combine(sets.precast.WS,{neck="Vim Torque +1"})
	sets.precast.WS.EleResist = set_combine(sets.precast.WS, {neck="Warder's Charm +1",waist="Carrier's Sash"})
    --sets.precast.WSAcc = {} --{ammo="Honed Tathlum",body="Manibozho Jerkin",back="Letalis Mantle",feet="Qaaxo Leggings"}
    sets.precast.MaxTP = {ear1="Lugra Earring +1"}
    --sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
    --sets.precast.WS.Mod = set_combine(sets.precast.WS, sets.precast.WSMod)

    -- Specific weaponskill sets.
	sets.precast.WS["Tachi: Ageha"] =  set_combine(sets.precast.WS,{
		neck="Fotia Gorget",ear1="Schere Earring",ear2="Kasuga Earring +2"})
	sets.precast.WS["Tachi: Enpi"] = set_combine(sets.precast.WS,{ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		hands="Nyame Gauntlets"})
	sets.precast.WS["Tachi: Fudo"] = set_combine(sets.precast.WS,{
		head="Mpaca's Cap",ear2="Kasuga Earring +2",
		ring2="Epaminondas's Ring"})
	sets.precast.WS["Tachi: Gekko"] = set_combine(sets.precast.WS,{
		head="Mpaca's Cap",ear2="Kasuga Earring +2",
		hands="Nyame Gauntlets",ring2="Sroda Ring",
		feet="Kasuga Sune-Ate +3"})
	sets.precast.WS["Tachi: Jinpu"] = set_combine(sets.precast.WS,{
		neck="Fotia Gorget",
		hands="Nyame Gauntlets",
		waist="Orpheus's Sash"})
	sets.precast.WS["Tachi: Kaiten"] = set_combine(sets.precast.WS,{
		ear1="Schere Earring",ear2="Kasuga Earring +2"})
	sets.precast.WS["Tachi: Goten"] = set_combine(sets.precast.WS,{
		neck="Fotia Gorget",ear2="Kasuga Earring +2",
		hands="Nyame Gauntlets",
		waist="Orpheus's Sash"})
	sets.precast.WS["Tachi: Kasha"] = set_combine(sets.precast.WS,{
		head="Mpaca's Cap",ear2="Kasuga Earring +2",
		hands="Nyame Gauntlets",ring2="Sroda Ring",
		feet="Kasuga Sune-Ate +3"})
	sets.precast.WS["Tachi: Kagero"] = set_combine(sets.precast.WS,{
		neck="Fotia Gorget",ear2="Kasuga Earring +2",
		hands="Nyame Gauntlets",
		waist="Orpheus's Sash"})
	sets.precast.WS["Tachi: Koki"] = set_combine(sets.precast.WS,{
		neck="Fotia Gorget",ear2="Kasuga Earring +2",
		hands="Nyame Gauntlets",
		waist="Orpheus's Sash"})
	sets.precast.WS["Tachi: Rana"] = set_combine(sets.precast.WS,{ammo="Coiste Bodhar",
		head="Mpaca's Cap",ear1="Schere Earring",ear2="Kasuga Earring +2",
		hands="Nyame Gauntlets",ring1="Regal Ring",
		back=Smertrios.DexDA})
	sets.precast.WS["Tachi: Shoha"] = set_combine(sets.precast.WS,{ammo="Crepuscular Pebble",
		head="Mpaca's Cap",ear2="Kasuga Earring +2",
		hands="Nyame Gauntlets",ring2="Sroda Ring",
		feet="Kasuga Sune-Ate +3"})
	sets.precast.WS["Tachi: Yukikaze"] = set_combine(sets.precast.WS,{
		head="Mpaca's Cap",ear2="Kasuga Earring +2",
		ring2="Sroda Ring"})
		
    sets.precast.WS["Sonic Thrust"] = set_combine(sets.precast.WS,{
		head="Mpaca's Cap",ear2="Kasuga Earring +2"})
    sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS["Sonic Thrust"],{})
						
	sets.precast.WS["Judgment"] = set_combine(sets.precast.WS,{
		head="Mpaca's Cap",ear2="Kasuga Earring +2",
		ring2="Regal Ring",
		waist="Kentarch Belt +1"})
	
    
    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC
            
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {ammo="Staunch Tathlum +1",
		head="Crepuscular Helm",neck="Elite Royal Collar",ear1="Sanare Earring",ear2="Kasuga Earring +2",
		body="Sacro Breastplate",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Chirich Ring +1",
		back=Smertrios.DexDA,waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    

    -- Idle sets
    sets.idle = sets.resting
	sets.idle.EleResist = set_combine(sets.resting,{neck="Warder's Charm +1",waist="Carrier's Sash"})
	sets.idle.PDT = set_combine(sets.idle,{neck="Warder's Charm +1"})
    
    -- Defense sets
    --sets.defense.PDT = sets.resting
    --sets.defense.HP = sets.resting

    sets.Kiting = {ring2="Shneddick Ring +1"}
	sets.Doom = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Blenmot's Ring +1",waist="Gishdubar Sash"}
	sets.TreasureHunter = {ammo="Staunch Tathlum +1",
		head=ValorousHead.TH,neck="Elite Royal Collar",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",
		back=Smertrios.DexDA,legs=ValorousLegs.TH,feet="Nyame Sollerets"}
	sets.Phalanx = {head=ValorousHead.Phalanx,body=ValorousBody.Phalanx,hands=ValorousHands.Phalanx,ring1="Defending Ring",legs=ValorousLegs.Phalanx,feet=ValorousFeet.Phalanx}
	
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {ammo="Coiste Bodhar",
		head="Kasuga Kabuto +3",neck="Samurai's Nodowa +2",ear1="Schere Earring",ear2="Kasuga Earring +2",
		body="Kasuga Domaru +3",hands="Tatenashi Gote +1",ring1="Defending Ring",ring2="Niqmaddu Ring",
		back=Smertrios.DexDA,waist="Ioskeha Belt +1",legs="Ryuo Hakama +1",feet="Tatenashi Sune-Ate +1"}
    sets.engagedDT = {ammo="Antitail +1",
		head="Kasuga Kabuto +3",neck="Samurai's Nodowa +2",ear1="Schere Earring",ear2="Kasuga Earring +2",
		body="Kasuga Domaru +3",hands="Nyame Gauntlets",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=Smertrios.DexDA,waist="Ioskeha Belt +1",legs="Kasuga Haidate +3",feet="Nyame Sollerets"}
				
	-- Subtle Blow 1/2: each can add up to 50, combined they can't go over 75
	-- at 119, /mnk or /nin would get you 15, /dnc would get you 10. Auspice counts towards the cap of +50 Subtle Blow I.

     sets.engaged.Polearm = set_combine(sets.engaged, {ammo="Crepuscular Pebble",
		head="Flamma Zucchetto +2",ear1="Dedition Earring",
		waist="Sailfi Belt +1"})
     sets.engaged.Polearm.SomeAccuracy = set_combine(sets.engaged.Polearm, {})
     sets.engaged.Polearm.MaxAccuracy = set_combine(sets.engaged.Polearm.SomeAccuracy, {ammo="Seeth. Bomblet +1",
		ear1="Dominance Earring +1",
		ring1="Cacoethic Ring +1",ring2="Moonlight Ring",
		waist="Kentarch Belt +1",legs="Tatenashi Haidate +1"})
	 sets.engaged.Polearm.SubtleBlow = set_combine(sets.engaged.Polearm,{head="Ken. Jinpachi +1",neck="Bathy Choker +1",body="Dagon Breast.",ring1="Chirich Ring +1",feet="Ken. Sune-Ate +1"})
	 	 
     sets.engaged.DWDagger = set_combine(sets.engaged, {ammo="Crepuscular Pebble",
		head="Kasuga Kabuto +3",ear1="Cessance Earring",
		body="Crepuscular Mail",hands="Tatenashi Gote +1",
		waist="Ioskeha Belt +1",legs="Kasuga Haidate +3"})
     sets.engaged.DWDagger.SomeAccuracy = set_combine(sets.engaged.DWDagger, {})
     sets.engaged.DWDagger.MaxAccuracy = set_combine(sets.engaged.DWDagger.SomeAccuracy, {})
     sets.engaged.DWDagger.SubtleBlow = set_combine(sets.engaged.DWDagger, {head="Ken. Jinpachi +1",neck="Bathy Choker +1",body="Dagon Breast.",ring1="Chirich Ring +1",feet="Ken. Sune-Ate +1"})
     sets.engaged.Dagger = set_combine(sets.engaged, {
		head="Kasuga Kabuto +3",ear1="Schere Earring",
		hands="Tatenashi Gote +1",ring1="Chirich Ring +1",
		waist="Ioskeha Belt +1",legs="Kasuga Haidate +3"})
     sets.engaged.Dagger.SomeAccuracy = set_combine(sets.engaged.Dagger, {})
     sets.engaged.Dagger.MaxAccuracy = set_combine(sets.engaged.Dagger.SomeAccuracy, {ammo="Seeth. Bomblet +1",
		ear1="Dominance Earring +1",
		ring1="Cacoethic Ring +1",ring2="Moonlight Ring",
		waist="Kentarch Belt +1",legs="Tatenashi Haidate +1"})
     sets.engaged.Dagger.SubtleBlow = set_combine(sets.engaged.Dagger,{head="Ken. Jinpachi +1",neck="Bathy Choker +1",body="Dagon Breast.",ring1="Chirich Ring +1",feet="Ken. Sune-Ate +1"}) 
	 
     sets.engaged.DWClub = set_combine(sets.engaged, {ammo="Crepuscular Pebble",
		head="Kasuga Kabuto +3",ear1="Cessance Earring",
		body="Crepuscular Mail",hands="Tatenashi Gote +1",
		waist="Ioskeha Belt +1",legs="Kasuga Haidate +3"})
     sets.engaged.DWClub.SomeAccuracy = set_combine(sets.engaged.DWClub, {})
     sets.engaged.DWClub.MaxAccuracy = set_combine(sets.engaged.DWClub.SomeAccuracy, {ammo="Seeth. Bomblet +1",
		ear1="Dominance Earring +1",
		ring1="Cacoethic Ring +1",ring2="Moonlight Ring",
		waist="Kentarch Belt +1",legs="Tatenashi Haidate +1"})
     sets.engaged.DWClub.SubtleBlow = set_combine(sets.engaged.DWClub, {head="Ken. Jinpachi +1",neck="Bathy Choker +1",body="Dagon Breast.",ring1="Chirich Ring +1",feet="Ken. Sune-Ate +1"})
     sets.engaged.Club = set_combine(sets.engaged, {
		head="Kasuga Kabuto +3",ear1="Schere Earring",
		hands="Tatenashi Gote +1",ring1="Chirich Ring +1",
		waist="Ioskeha Belt +1",legs="Kasuga Haidate +3"})
     sets.engaged.Club.SomeAccuracy = set_combine(sets.engaged.Club, {})
     sets.engaged.Club.MaxAccuracy = set_combine(sets.engaged.Club.SomeAccuracy, {ammo="Seeth. Bomblet +1",
		ear1="Dominance Earring +1",
		ring1="Cacoethic Ring +1",ring2="Moonlight Ring",
		waist="Kentarch Belt +1",legs="Tatenashi Haidate +1"})
     sets.engaged.Club.SubtleBlow = set_combine(sets.engaged.Club,{head="Ken. Jinpachi +1",neck="Bathy Choker +1",body="Dagon Breast.",ring1="Chirich Ring +1",feet="Ken. Sune-Ate +1"}) 
	 sets.engaged.WeakMode = {ammo="Ginsen",
		head="Blistering Sallet +1",neck="Sam. Nodowa +2",ear1="Schere Earring",ear2="Kasuga Earring +2",
		body="Crepuscular Mail",hands="Tatenashi Gote +1",ring1="Chirich Ring +1",ring2="Niqmaddu Ring",
		back=Smertrios.DexDA,waist="Sailfi Belt +1",legs="Ryuo Hakama +1",feet="Tatenashi Sune-Ate +1"}

	sets.engaged.EleResist = {neck="Warder's Charm +1",waist="Carrier's Sash"}
	sets.engagedDT.EleResist = set_combine(sets.engagedDT,{neck="Warder's Charm +1",waist="Carrier's Sash"})
		
-- base Subtle Blow set:
--    sets.engaged = {ammo="Coiste Bodhar",
--        head="Bhikku Crown +2",neck="Mnk. Nodowa +2",ear1="Sherida Earring",ear2="Schere Earring",
--		body="Mpaca's Doublet",hands="Hes. Gloves +3",ring1="Gere Ring",ring2="Chirich Ring +1",
--        back=Segomo.Normal,waist="Moonbow Belt +1",legs="Bhikku Hose +2",feet="Malignance Boots"}
		
		
    sets.engaged.SomeAccuracy= sets.engaged
    sets.engaged.MaxAccuracy = sets.engaged
	sets.engaged.SubtleBlow = set_combine(sets.engaged,{})

    -- Defensive melee hybrid sets
    --sets.defense.DT = set_combine(sets.engaged, {head="Bhikku Crown +2",neck="Warder's Charm +1",body="Malignance Tabard"})
	
	sets.engaged.SomeAccuracy.DT = sets.engaged
    sets.engaged.MaxAccuracy.DT = sets.engaged
        
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill'  then
		if state.DefenseMode.current ~= 'None' then
			eventArgs.handled = true
		elseif player.equipment.main == 'Soboro Sukehiro' then
			eventArgs.handled = true
		end
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

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)        
	-- Replace Moonshade Earring if we're at cap TP	
	if player.tp == 3000 then
		equip(sets.precast.MaxTP)
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

	get_combat_weapon()
    
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 70 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    if state.HybridMode.value == 'DT' then
		idleSet = sets.idle.PDT
	end
	if state.ElementalResist.value == true then
		idleSet = set_combine(idleSet,sets.idle.EleResist)
	end
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		idleSet = set_combine(idleSet,sets.buff.Curse)
	end
    if state.Kiting.value then
        if sets.Kiting then
            idleSet = set_combine(idleSet, sets.Kiting)
        end
    end
	if player.hpp < 30 or (state.Crepuscular.value) then
		idleSet = set_combine(idleSet,sets.Crepuscular)
		equip(sets.Crepuscular)
		disable("head")
		disable("body")
	else
		enable("head")
		enable("body")
	end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
	get_combat_weapon()
end

-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end

--function th_action_check(category, param)
--    if category == 2 or -- any ranged attack
--        --category == 4 or -- any magic action
--        (category == 3 and param == 30) or -- Aeolian Edge
--        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
--        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
--        then return true
--    end
--end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_weapon()
	if paList:contains(player.equipment.main) then
        state.CombatWeapon:set("Polearm")
	elseif cList:contains(player.equipment.main) then
		if dwSubs:contains(player.sub_job) then
			if not dwList:contains(player.equipment.sub) then
				state.CombatWeapon:set("DWClub")
			else
				state.CombatWeapon:set("Club")
			end
		end
	elseif dagList:contains(player.equipment.main) then
		if dwSubs:contains(player.sub_job) then
			if not dwList:contains(player.equipment.sub) then
				state.CombatWeapon:set("DWDagger")
			else
				state.CombatWeapon:set("Dagger")
			end
		end
	elseif weakList:contains(player.equipment.main) then
		state.CombatWeapon:set("WeakMode")
    else -- use regular set
        state.CombatWeapon:reset()
    end
end

function update_combat_form()

end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    	
--	if state.ElementalResist.value == 'EleResist' then
	if state.ElementalResist.value == true then
		classes.CustomMeleeGroups:append('EleResist')
	--	add_to_chat(8,'EleResist is now true')
	end
	
end

function customize_melee_set(meleeSet)
-- beware of using ELSE here which could overwrite the default constructor

--    if state.TreasureMode.value ~= 'None' then
--        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
--    end
--	if state.HybridMode.value == 'DT' then
--		meleeSet = set_combine(meleeSet,sets.engagedDT)
--	end

	if state.HybridMode.value == 'DT' and state.ElementalResist.value == true then
		meleeSet = set_combine(meleeSet,sets.engagedDT.EleResist)
	elseif state.HybridMode.value == 'DT' then
        meleeSet = set_combine(meleeSet,sets.engagedDT)
	elseif state.ElementalResist.value == true then
		meleeSet = set_combine(meleeSet,sets.engaged.EleResist)
    end
		
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		meleeSet = set_combine(meleeSet,sets.buff.Curse)
	end
	if player.hpp < 30 or (state.Crepuscular.value) then
		meleeSet = set_combine(meleeSet,sets.Crepuscular)
		equip(sets.Crepuscular)
		disable("head")
		disable("body")
	else
		enable("head")
		enable("body")
	end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

--function eleresist()
--	if state.ElementalResist.value == 'EleResist' then
--		classes.CustomMeleeGroups:append('EleResist')
--		classes.CustomClass = nil
--	end
--end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    if state.OffenseMode.has_value then
        om_msg = state.OffenseMode.value
    end
    if state.WeaponskillMode.has_value then
        wm_msg = state.WeaponskillMode.value
	else
        wm_msg = 'Normal'
    end
    if state.HybridMode.has_value then
        hm_msg = state.HybridMode.value
    end
    if state.TreasureMode.has_value then
        tm_msg = state.TreasureMode.value
	else
        tm_msg = 'Off'
    end
    if state.ElementalResist.value then
        er_msg = 'On'
	else
        er_msg = 'Off'
    end
	
    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On'
	else 
        msg = msg .. ' Kiting: Off'
    end

    add_to_chat(string.char(31,210).. 'OffenseMode: ' ..string.char(31,001)..om_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' WeaponskillMode: ' ..string.char(31,001)..wm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' PDT: ' ..string.char(31,001)..hm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' ElementalResist: ' ..string.char(31,001)..er_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' TreasureMode: ' ..string.char(31,001)..tm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
	
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
--if player.sub_job == 'BLU' then
--	set_macros(5,2)
--else 
	set_macros(5,12)
--end


function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(34) 