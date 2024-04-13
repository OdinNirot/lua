-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	include(player.name..'_'..player.main_job..'_gear.lua')
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	res = require('resources')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	classes.CustomClass = L{}

    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
    state.Buff.Curse = (buffactive.Curse or buffactive.Bane) or false
	
	send_command('get "Storage Slip 08" sack') -- empy accessories
	send_command('get "Storage Slip 25" sack') --AF +3
	send_command('get "Storage Slip 27" sack') --relic +3
	send_command('get "Storage Slip 29" sack') -- Empy +2
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'PDT', 'MDT')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
	state.LockShield = M(true, 'LockShield')
	state.MaxHP = M(false, 'MaxHP')
    state.Kiting        = M(true, 'Kiting')
	state.ExtraResist = M('Normal','Charm','Death')
	state.NormalShield = M('Ochain', 'Aegis', 'Duban','Srivatsa')
	state.NormalWeapon = M('Burtgang','Excalibur','Naegling')
	state.WeaponLock = M(true, 'WeaponLocked')
	state.SIRDMode = M('SIRD','MaxEnmity')
	state.CursnaGear = M(false, 'CursnaGear')
    state.Crepuscular = M(false, 'Crepuscular')
	
	proSpells = S{'Protect','Protect II','Protect III','Protect IV','Protect V'}
	enhancingSpells = S{'Protect','Protect II','Protect III','Protect IV','Protect V','Shell','Shell II','Shell III','Shell IV','Shell V','Reprisal','Crusade'} --add phalanx if you want more duration at the cost of less effectiveness
	
    update_defense_mode()
	    
	send_command('bind ^= gs c cycle Kiting')
	send_command('bind F10 gs c cycle WeaponLock')
    send_command('bind F11 gs c cycle Crepuscular')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind numpad. gs c cycle HybridMode')
	send_command('bind ^- gs c cycle CursnaGear')
    send_command('bind numpad0 gs c cycle NormalWeapon')
	send_command('bind numpad2 gs c cycle ExtraResist')
    send_command('bind numpad3 gs c cycle LockShield')
    send_command('bind numpad4 gs c set HybridMode Normal')
    send_command('bind numpad5 gs c set HybridMode MDT')
    send_command('bind numpad6 gs c set HybridMode PDT')
    send_command('bind numpad7 gs c cycle NormalShield')
    send_command('bind numpad8 gs c cycle SIRDMode')
    send_command('bind numpad9 gs c cycle MaxHP')
	
	PhalanxAbility = S{"Phalanx","Phalanx II"}
	RefreshAbility = S{"Refresh","Refresh II","Refresh III"}
end

function user_unload()
    send_command('unbind ^-')
	send_command('unbind F10')
    send_command('unbind F11')
    send_command('unbind !f11')
	send_command('unbind ^=')
	send_command('unbind numpad.')
	send_command('unbind numpad0')
	send_command('unbind numpad2')
	send_command('unbind numpad3')
	send_command('unbind numpad4')
	send_command('unbind numpad5')
	send_command('unbind numpad6')	
	send_command('unbind numpad7')	
	send_command('unbind numpad8')	
	send_command('unbind numpad9')
	
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function sird_sets(spell)
	if spell.action_type == 'Magic' then
		if state.SIRDMode.value == 'SIRD' then
			classes.CustomClass = "SIRD"
			--classes.CustomClass:append('SIRD')
		else
			classes.CustomClass = nil
		end
	end
end

function job_precast(spell, action, spellMap, eventArgs)
	sird_sets(spell)
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
			if state.LockShield.value and not state.WeaponLock.value then
				do_equip('sets.PhalanxMain')
				if state.NormalWeapon.value then
					sets.NormalWeapon = {main=state.NormalWeapon.value}
					windower.send_command('wait 2.5;gs equip sets.NormalWeapon')
				end
			elseif not state.LockShield.value and state.WeaponLock.value then
				do_equip('sets.PhalanxSub')
				if state.NormalShield.value then
					sets.NormalShield = {main=state.NormalShield.value}
					windower.send_command('wait 2.5;gs equip sets.NormalShield')
				end
			else
				do_equip('sets.PhalanxFull')
			end
		end
		if RefreshAbility:contains(act_info.name) then
			do_equip('sets.Refresh')
			windower.send_command('wait 4;gs c update user')
		end		
	end
end

windower.raw_register_event('action', check_reaction)

function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that shield slot is locked, if necessary
	check_weaponlock()
    check_shield_lock()
	if state.MaxHP.value then
		equip(sets.MaxHP)
		disallow_swaps()
	else
		allow_swaps()
	end
end

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
	
	sird_sets(spell)
	
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
	
	if proSpells:contains(spell.english) then
		if state.LockShield.value then
			--do nothing
		else
			do_equip('sets.Srivatsa')
		end
	end
	
	if enhancingSpells:contains(spell.english) then
		do_equip('sets.EnhancingDuration')
		if state.LockShield.value and not state.WeaponLock.value then
			do_equip('sets.EnhancingDurationMain')
		elseif not state.LockShield.value and state.WeaponLock.value then
			if not string.find(spell.name,"Protect") then
				do_equip('sets.EnhancingDurationShield')
			end
		else
			do_equip('sets.EnhancingDurationFull')
		end
		windower.send_command('wait 3.5;gs c update user')
	end

	if PhalanxAbility:contains(spell.english) then
		if UseSIRDWithPhalanx and state.SIRDMode.value == 'SIRD' then
			do_equip('sets.PhalanxSIRD')
			windower.send_command('wait 2.5;gs c update user')
		else
			do_equip('sets.Phalanx')
			windower.send_command('wait 2.5;gs c update user')
			if state.LockShield.value and not state.WeaponLock.value then
				do_equip('sets.PhalanxMain')
				if state.NormalWeapon.value then
					sets.NormalWeapon = {main=state.NormalWeapon.value}
					windower.send_command('wait 2.5;gs equip sets.NormalWeapon')
				end
			elseif not state.LockShield.value and state.WeaponLock.value then
				do_equip('sets.PhalanxSub')
				if state.NormalShield.value then
					sets.NormalShield = {main=state.NormalShield.value}
					windower.send_command('wait 2.5;gs equip sets.NormalShield')
				end
			else
				do_equip('sets.PhalanxFull')
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    --if state.EquipShield.value == true then
    --    classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    --end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

function disallow_swaps()
	disable('head')
	disable('neck')
	disable('ear1')
	disable('ear2')
	disable('body')
	disable('hands')
	disable('ring1')
	disable('ring2')
	disable('back')
	disable('waist')
	disable('legs')
	disable('feet')
end

function allow_swaps()
	enable('head')
	enable('neck')
	enable('ear1')
	enable('ear2')
	enable('body')
	enable('hands')
	enable('ring1')
	enable('ring2')
	enable('back')
	enable('waist')
	enable('legs')
	enable('feet')
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.HybridMode.value == 'PDT' then
		if state.LockShield.value and state.MaxHP.value then
			meleeSet = sets.MaxHP
		elseif state.LockShield.value then
			meleeSet = sets.engaged.PDT
		elseif state.MaxHP.value then
			meleeSet = set_combine(sets.MaxHP,{sub="Duban"})
		else 
			meleeSet = set_combine(sets.engaged.PDT,{sub="Duban"})
		end
    elseif state.HybridMode.value == 'MDT' then
		if state.LockShield.value and state.MaxHP.value then
			meleeSet = sets.MaxHP
		elseif state.LockShield.value then
			meleeSet = sets.engaged.MDT
		elseif state.MaxHP.value then
			meleeSet = set_combine(sets.MaxHP,{sub="Aegis"})
		else 
			meleeSet = set_combine(sets.engaged.MDT,{sub="Aegis"})
		end
	else -- most frequently going into this block. improve test condition above, or stop forcing shield swap in block below
		if state.LockShield.value and state.MaxHP.value then
			meleeSet = sets.MaxHP
		elseif state.MaxHP.value then
			if state.WeaponLock.value then
				meleeSet = set_combine(sets.MaxHP,{sub=state.NormalShield.value})
			else
				meleeSet = set_combine(sets.MaxHP,{main=state.NormalWeapon.value,sub=state.NormalShield.value})
			end
		elseif state.LockShield.value and state.WeaponLock.value == nil then
			meleeSet = set_combine(meleeSet,{main=state.NormalWeapon.value})
		elseif state.LockShield.value == nil and state.WeaponLock.value then
			meleeSet = set_combine(meleeSet,{sub=state.NormalShield.value})
		else 
			meleeSet = set_combine(meleeSet,{main=state.NormalWeapon.value,sub=state.NormalShield.value})
		end			
	end
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		meleeSet = set_combine(meleeSet,sets.buff.Doom)
	end
	if  state.ExtraResist.value == 'Charm' then
		meleeSet = set_combine(meleeSet,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		meleeSet = set_combine(meleeSet,sets.Death)
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

function customize_defense_set(defenseSet)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.HybridMode.value == 'PDT' then
		if state.LockShield.value and state.MaxHP.value then
			idleSet = set_combine(idleSet,sets.MaxHP)
		elseif state.LockShield.value then
			idleSet = set_combine(idleSet,sets.idle.PDT)
		elseif state.MaxHP.value then
			idleSet = set_combine(sets.idle.PDT,{sub="Duban"})
		else 
			idleSet = set_combine(sets.idle.PDT,{sub="Duban"})
		end
    elseif state.HybridMode.value == 'MDT' then
		if state.LockShield.value and state.MaxHP.value then
			idleSet = set_combine(idleSet,sets.MaxHP)
		elseif state.LockShield.value then
			idleSet = set_combine(idleSet,sets.idle.MDT)
		elseif state.MaxHP.value then
			idleSet = set_combine(sets.idle.MDT,{sub="Aegis"})
		else 
			idleSet = set_combine(sets.idle.MDT,{sub="Aegis"})
		end
	else  -- most frequently going into this block. improve test condition above, or stop forcing shield swap in block below
		if state.LockShield.value and state.MaxHP.value then
			idleSet = set_combine(idleSet,sets.MaxHP)
		elseif state.MaxHP.value then
			if state.WeaponLock.value then
				idleSet = set_combine(sets.MaxHP,{sub=state.NormalShield.value})
			else
				idleSet = set_combine(sets.MaxHP,{main=state.NormalWeapon.value,sub=state.NormalShield.value})
			end
		elseif state.LockShield.value and state.WeaponLock.value == nil then
			idleSet = set_combine(idleSet,{main=state.NormalWeapon.value})
		elseif state.LockShield.value == nil and state.WeaponLock.value then
			idleSet = set_combine(idleSet,{sub=state.NormalShield.value})
		else
			idleSet = set_combine(idleSet,{main=state.NormalWeapon.value,sub=state.NormalShield.value})
		end		
	end
	if state.CursnaGear.value and (buffactive['Curse'] or buffactive['Doom'] or buffactive['Bane']) then
		idleSet = set_combine(idleSet,sets.buff.Doom)
	end
	if  state.ExtraResist.value == 'Charm' then
		idleSet = set_combine(idleSet,sets.Charm)
	elseif state.ExtraResist.value == 'Death' then
		idleSet = set_combine(idleSet,sets.Death)
	end
	if state.Kiting.value then
		idleSet = set_combine(idleSet,sets.Kiting)
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

	if state.LockShield.value then
		ls_msg = 'On'
	else 
		ls_msg = 'Off'
	end
	
	if state.WeaponLock.value then
		swl_msg = 'On'
	else
		swl_msg = 'Off'
	end
	
	if state.MaxHP.value == true then
		mhp_msg = 'On'
	else 
		mhp_msg = 'Off'
	end

	if state.NormalShield.value then
		ns_msg = state.NormalShield.value
	else 
		ns_msg = 'None'
	end

	if state.NormalWeapon.value then
		nw_msg = state.NormalWeapon.value
	else 
		nw_msg = 'None'
	end

	
    local ws_msg = state.WeaponskillMode.value

	if state.ExtraResist.value then
		er_msg = state.ExtraResist.value
	else 
		er_msg = 'None'
	end

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value
	
	if state.SIRDMode.value then
		sird_msg = state.SIRDMode.value
	else
		sird_msg = 'None'
	end

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On'
	else 
        msg = msg .. ' Kiting: Off'
    end

    add_to_chat(string.char(31,210).. 'Hybrid' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' LockShield: ' ..string.char(31,001)..ls_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' LockWeapon: ' ..string.char(31,001)..swl_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' NormalShield: ' ..string.char(31,001)..ns_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' NormalWeapon: ' ..string.char(31,001)..nw_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' MaxHP: ' ..string.char(31,001)..mhp_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' ExtraResist: ' ..string.char(31,001)..er_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' SIRDMode: ' ..string.char(31,001)..sird_msg.. string.char(31,002)..  ' |'
		
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Duban' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end

-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_shield_lock()
    if state.LockShield.value  then
        disable('sub')
    else
        enable('sub')
    end
end

function check_weaponlock()
	if state.WeaponLock.value then
		disable("main")
	else
		enable("main")
	end
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
if player.sub_job == 'BLU' then
	set_macros(3,7)
else 
	set_macros(5,7)
end

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(17) 