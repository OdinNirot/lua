-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	include(player.name..'_'..player.main_job..'_gear.lua')
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    state.Buff.Chainspell = buffactive.Chainspell or false
    state.BuffComposure = buffactive.Composure or false
	state.Kalasiris = M(false, 'Kalasiris')
	state.DualWielding = M{false, true}
	state.Immunobreak = M(false, 'Immunobreak')

    state.Buff['Curse'] = buffactive['curse'] or false
	state.Buff['Doom'] = buffactive['doom'] or false
	state.Buff['Bane'] = buffactive['bane'] or false
    state.Buff['Terror'] = buffactive['terror'] or false
    state.Buff['Stun'] = buffactive['stun'] or false
    state.Buff['Petrification'] = buffactive['petrification'] or false
    state.Buff['Composure'] = buffactive['composure'] or false
	
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
	state.TreasureMode:set('Tag')
	
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
--    state.AccMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
    state.HybridMode:options('Normal','PDT') --"engaged" sets
	--state.ExtraResist:options('Normal','Charm','Death')
	state.ExtraResist = M('Normal','Charm','Death')
	state.Kiting              = M(true, 'Kiting')
	state.ExtraRefresh = M(false, 'ExtraRefresh')
	state.BurstMode = M(true, 'BurstMode')
	state.AccMode = M(false, 'OdinSoloMode')
	state.WeaponLock = M(false, 'WeaponLocked')
	state.CursnaGear = M(false, 'CursnaGear')

    -- Additional local binds
    send_command('bind numpad. gs c cycle HybridMode')
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
	
	-- Gain spells seem to need vitiation hands equipped prior to beginning the cast
	if spellMap == 'GainSpells' then
		equip({hands="Viti. Gloves +3"})
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
			if buffactive['Composure'] then
				equip(sets.midcast['Enhancing Magic'].composure,sets.midcast['Enhancing Magic'].RefreshSpells,{waist="Gishdubar Sash"})
			else
				equip(sets.midcast['Enhancing Magic'].nocomposure,sets.midcast['Enhancing Magic'].RefreshSpells,{waist="Gishdubar Sash"})
			end
		else
			equip(sets.midcast['Enhancing Magic'].nocomposure,sets.midcast['Enhancing Magic'].RefreshSpells)
		end
	end
	
	if spellMap == 'EnhancingSkill' then
		if spell.target.type == 'SELF' then
			if buffactive['Composure'] then
				equip(sets.midcast['Enhancing Magic'].composure,sets.midcast.EnhancingSkill)
			else
				equip(sets.midcast['Enhancing Magic'].nocomposure,sets.midcast.EnhancingSkill)
			end
		else
			equip(sets.midcast['Enhancing Magic'].nocomposure,sets.midcast.EnhancingSkill)
		end
	end
	
	if spellMap == 'NoEnhancingSkill' then
		if spell.target.type == 'SELF' then
			if buffactive['Composure'] then
				equip(sets.midcast['Enhancing Magic'].composure)
			else
				equip(sets.midcast['Enhancing Magic'].nocomposure)
			end
		else
			equip(sets.midcast['Enhancing Magic'].nocomposure)
		end
	end
	
	if spellMap == 'RegenSpells' then
		if spell.target.type == 'SELF' then
			if buffactive['Composure'] then
				equip(sets.midcast['Enhancing Magic'].composure,sets.midcast.RegenSpells)
			else
				equip(sets.midcast['Enhancing Magic'].nocomposure,sets.midcast.RegenSpells)
			end
		else
			equip(sets.midcast['Enhancing Magic'].nocomposure,sets.midcast.RegenSpells)
		end
	end
	
	if spellMap == 'BarSpells' then
		if spell.target.type == 'SELF' then
			if buffactive['Composure'] then
				equip(sets.midcast['Enhancing Magic'].composure,sets.midcast.BarSpells)
			else
				equip(sets.midcast['Enhancing Magic'].nocomposure,sets.midcast.BarSpells)
			end
		else
			equip(sets.midcast['Enhancing Magic'].nocomposure,sets.midcast.BarSpells)
		end
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
		if spell.target.type == 'SELF' then
			if buffactive['Composure'] then
				equip(sets.midcast['Enhancing Magic'].composure,{main="Sakpata's Sword",head=MerlinicHead.Phalanx,hands=MerlinicHands.Phalanx,legs=MerlinicLegs.Phalanx,feet=MerlinicFeet.Phalanx})
			else
				equip(sets.midcast['Enhancing Magic'].nocomposure,{main="Sakpata's Sword",head=MerlinicHead.Phalanx,hands=MerlinicHands.Phalanx,legs=MerlinicLegs.Phalanx,feet=MerlinicFeet.Phalanx})
			end
		else
			equip(sets.midcast['Enhancing Magic'].nocomposure)
		end
	end
	
	if spell.english == 'Dia' or  spell.english == 'Dia II' or spell.english == 'Dia III' then
		equip({ring1="Weather. Ring +1"})
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

-- function to interpet the spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Enhancing Magic' or spell.skill == 'Enfeebling Magic' or spell.skill == 'Elemental Magic' then
        for category,spell_list in pairs(magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end	
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
--    if state.Buff[buff] ~= nil then
--        state.Buff[buff] = gain
--    end
	
	if S{'sleep'}:contains(buff:lower()) then
        determine_sleep_state()
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
    if state.HybridMode.value == 'PDT' then
		idleSet = sets.idle.PDT
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
--    if state.WeaponskillMode.has_value then
--        wm_msg = state.WeaponskillMode.value
--	else
--        wm_msg = 'Normal'
--    end
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
	
    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On'
	else 
        msg = msg .. ' Kiting: Off'
    end

    add_to_chat(string.char(31,210).. 'OffenseMode: ' ..string.char(31,001)..om_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' DTMode: ' ..string.char(31,001)..dt_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' TreasureMode: ' ..string.char(31,001)..tm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' BurstMode: ' ..string.char(31,001)..bm_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' ExtraRefresh: ' ..string.char(31,001)..er_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' ExtraResist: ' ..string.char(31,001)..extraresist_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' AccMode: ' ..string.char(31,001)..am_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' ImmunobreakMode: ' ..string.char(31,001)..immunobreak_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' CursnaGear: ' ..string.char(31,001)..cursnagear_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
	
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 5)
    else
        set_macro_page(5, 5)
    end
end

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
set_style(20) 
