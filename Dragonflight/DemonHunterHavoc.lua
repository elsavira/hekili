-- DemonHunterHavoc.lua
-- October 2022

if UnitClassBase( "player" ) ~= "DEMONHUNTER" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local spec = Hekili:NewSpecialization( 577 )

spec:RegisterResource( Enum.PowerType.Fury, {
    -- Immolation Aura now grants 20 up front, 60 over 12 seconds (5 fps).
    immolation_aura = {
        talent  = "burning_hatred",
        aura    = "immolation_aura",

        last = function ()
            local app = state.buff.immolation_aura.applied
            local t = state.query_time

            return app + floor( t - app )
        end,

        interval = 1,
        value = 5
    },

    eye_beam = {
        talent = "blind_fury",
        aura   = "eye_beam",

        last = function ()
            local app = state.buff.eye_beam.applied
            local t = state.query_time

            return app + floor( ( t - app ) / state.haste ) * state.haste
        end,

        interval = function () return state.haste end,
        value = 40,
    },
} )

-- Talents
spec:RegisterTalents( {
    accelerating_blade       = { 91011, 391275, 1 }, -- Throw Glaive deals 25% increased damage for each enemy hit.
    aldrachi_design          = { 90999, 391409, 1 }, -- Increases your chance to parry by 3%.
    any_means_necessary      = { 90919, 388114, 1 }, -- Mastery: Demonic Presence now also causes your Arcane, Fire, Frost, Nature, and Shadow damage to be dealt as Chaos instead, and increases that damage by 14.4%.
    aura_of_pain             = { 90932, 207347, 1 }, -- Increases the critical strike chance of Immolation Aura by 6%.
    blazing_path             = { 91008, 320416, 1 }, -- Fel Rush gains an additional charge.
    blind_fury               = { 91026, 203550, 2 }, -- Eye Beam generates 20 Fury every sec. and its duration is increased by 25%.
    bouncing_glaives         = { 90931, 320386, 1 }, -- Throw Glaive ricochets to 1 additional target.
    burning_hatred           = { 90923, 320374, 1 }, -- Immolation Aura generates an additional 50 Fury over 10 sec.
    burning_wound            = { 90917, 391189, 1 }, -- Demon's Bite and Throw Glaive leave open wounds on your enemies, dealing 337 Chaos damage over 15 sec and increasing damage taken from your Immolation Aura by 50%. May be applied to up to 3 targets.
    chaos_fragments          = { 90992, 320412, 1 }, -- Each enemy stunned by Chaos Nova has a 30% chance to generate a Lesser Soul Fragment.
    chaos_nova               = { 90993, 179057, 1 }, -- Unleash an eruption of fel energy, dealing 126 Chaos damage and stunning all nearby enemies for 2 sec.
    chaos_theory             = { 91035, 389687, 1 }, -- Blade Dance causes your next Chaos Strike within 8 sec to have a 14-30% increased critical strike chance and will always refund Fury.
    chaotic_transformation   = { 90922, 388112, 1 }, -- When you activate Metamorphosis, the cooldowns of Blade Dance and Eye Beam are immediately reset.
    charred_warblades        = { 90948, 213010, 1 }, -- You heal for 5% of all Fire damage you deal.
    collective_anguish       = { 90995, 390152, 1 }, -- Eye Beam summons an allied Vengeance Demon Hunter who casts Fel Devastation, dealing 763 Fire damage over 2 sec. Dealing damage heals you for up to 72 health.
    concentrated_sigils      = { 90944, 207666, 1 }, -- All Sigils are now placed at your location, and the duration of their effects is increased by 2 sec.
    consume_magic            = { 91006, 278326, 1 }, -- Consume 1 beneficial Magic effect removing it from the target.
    critical_chaos           = { 91028, 320413, 2 }, -- The chance that Chaos Strike will refund 20 Fury is increased by 25% of your critical strike chance.
    cycle_of_hatred          = { 91032, 258887, 2 }, -- Blade Dance, Chaos Strike, and Glaive Tempest reduce the cooldown of Eye Beam by 0.5 sec.
    dancing_with_fate        = { 91015, 389978, 2 }, -- The final slash of Blade Dance deals an additional 20% damage.
    darkness                 = { 91002, 196718, 1 }, -- Summons darkness around you in an 8 yd radius, granting friendly targets a 20% chance to avoid all damage from an attack. Lasts 8 sec.
    demon_blades             = { 91019, 203555, 1 }, -- Your auto attacks deal an additional 49 Shadow damage and generate 7-12 Fury.
    demon_muzzle             = { 90928, 388111, 1 }, -- Enemies deal 8% reduced magic damage to you for 8 sec after being afflicted by one of your Sigils.
    demonic                  = { 91003, 213410, 1 }, -- Eye Beam causes you to enter demon form for 6 sec after it finishes dealing damage.
    demonic_appetite         = { 90914, 206478, 1 }, -- Chaos Strike has a chance to spawn a Lesser Soul Fragment. Consuming any Soul Fragment grants 30 Fury.
    desperate_instincts      = { 90913, 205411, 1 }, -- Blur now reduces damage taken by an additional 10%. Additionally, you automatically trigger Blur with 50% reduced cooldown and duration when you fall below 35% health. This effect can only occur when Blur is not on cooldown.
    disrupting_fury          = { 90937, 183782, 1 }, -- Disrupt generates 30 Fury on a successful interrupt.
    elysian_decree           = { 91010, 390163, 1 }, -- Place a Kyrian Sigil at the target location that activates after 2 sec. Detonates to deal 1,544 Arcane damage and shatter up to 3 Lesser Soul Fragments from enemies affected by the sigil. Deals reduced damage beyond 5 targets.
    erratic_felheart         = { 90996, 391397, 2 }, -- The cooldown of Fel Rush is reduced by 10%.
    essence_break            = { 91033, 258860, 1 }, -- Slash all enemies in front of you for 1,413 Chaos damage, and increase the damage your Chaos Strike and Blade Dance deal to them by 80% for 4 sec. Deals reduced damage beyond 8 targets.
    extended_sigils          = { 90998, 389697, 2 }, -- Increases the duration of Sigil effects by 1 sec.
    eye_beam                 = { 91018, 198013, 1 }, -- Blasts all enemies in front of you, for up to 1,462 Chaos damage over 2 sec. Deals reduced damage beyond 5 targets.
    fel_barrage              = { 91023, 258925, 1 }, -- Unleash a torrent of Fel energy over 3 sec, inflicting 1,764 Chaos damage to all enemies within 8 yds. Deals reduced damage beyond 8 targets.
    fel_eruption             = { 91014, 211881, 1 }, -- Impales the target for 170 Chaos damage and stuns them for 4 sec.
    felblade                 = { 90932, 232893, 1 }, -- Charge to your target and deal 327 Fire damage. Demon's Bite has a chance to reset the cooldown of Felblade. Generates 40 Fury.
    felfire_haste            = { 90939, 389846, 1 }, -- Fel Rush increases your movement speed by 10% for 8 sec.
    felfire_heart            = { 91017, 388109, 1 }, -- Increases duration of Immolation Aura and Sigil of Flame by 2 sec.
    first_blood              = { 90925, 206416, 1 }, -- Blade Dance deals 808 Chaos damage to the first target struck.
    first_of_the_illidari    = { 91003, 235893, 1 }, -- Metamorphosis grants 10% Versatility and its cooldown is reduced by 60 sec.
    flames_of_fury           = { 90949, 389694, 1 }, -- Sigil of Flame generates 2 additional Fury per target hit.
    fodder_to_the_flame      = { 91010, 391429, 1 }, -- Your damaging abilities have a chance to call forth a condemned demon for 25 sec. Throw Glaive deals lethal damage to the demon, which explodes on death, dealing 873 Shadow damage to nearby enemies and healing you for 25% of your maximum health. The explosion deals reduced damage beyond 5 targets.
    furious_gaze             = { 91025, 343311, 1 }, -- When Eye Beam finishes fully channeling, your Haste is increased by an additional 10% for 10 sec.
    furious_throws           = { 91016, 393029, 1 }, -- Throw Glaive now costs 25 Fury and throws a second glaive at the target.
    glaive_tempest           = { 91023, 342817, 1 }, -- Launch two demonic glaives in a whirlwind of energy, causing 1,201 Chaos damage over 3 sec to all nearby enemies. Deals reduced damage beyond 5 targets.
    growing_inferno          = { 90916, 390158, 2 }, -- Immolation Aura's damage increases by 5% each time it deals damage.
    illidari_knowledge       = { 90935, 389696, 2 }, -- Reduces magic damage taken by 2%.
    imprison                 = { 91007, 217832, 1 }, -- Imprisons a demon, beast, or humanoid, incapacitating them for 1 min. Damage will cancel the effect. Limit 1.
    improved_chaos_strike    = { 91030, 343206, 1 }, -- Chaos Strike damage increased by 10%.
    improved_disrupt         = { 90938, 320361, 1 }, -- Increases the range of Disrupt to 10 yards.
    improved_fel_rush        = { 91029, 343017, 1 }, -- Fel Rush damage increased by 20%.
    improved_sigil_of_misery = { 90945, 320418, 1 }, -- Reduces the cooldown of Sigil of Misery by 30 sec.
    infernal_armor           = { 91004, 320331, 2 }, -- Immolation Aura increases your armor by 10% and causes melee attackers to suffer 23 Fire damage.
    initiative               = { 91027, 388108, 1 }, -- Damaging an enemy before they damage you increases your critical strike chance by 12% for 5 sec. Using Vengeful Retreat refreshes your potential to activate this effect on any enemies you are in combat with.
    inner_demon              = { 91009, 389693, 1 }, -- Entering demon form causes your next Chaos Strike to unleash your inner demon, causing it to crash into your target and deal 526 Chaos damage to all nearby enemies.
    insatiable_hunger        = { 91019, 258876, 1 }, -- Demon's Bite deals 50% more damage and generates 5 to 10 additional Fury.
    internal_struggle        = { 90934, 393822, 1 }, -- Increases your Mastery by 3.6%.
    isolated_prey            = { 91036, 388113, 1 }, -- Chaos Nova, Eye Beam, and Fel Rush gain bonuses when striking 1 target.  Chaos Nova: Stun duration increased by 2 sec.  Eye Beam: Deals 25% increased damage.  Fel Rush: Generates 25-35 Fury.
    know_your_enemy          = { 91034, 388118, 2 }, -- Gain critical strike damage equal to 50% of your critical strike chance.
    long_night               = { 91001, 389781, 1 }, -- Increases the duration of Darkness by 3 sec.
    looks_can_kill           = { 90921, 320415, 1 }, -- Eye Beam deals guaranteed critical strikes.
    lost_in_darkness         = { 90947, 389849, 1 }, -- Spectral Sight lasts an additional 6 sec if disrupted by attacking or taking damage.
    master_of_the_glaive     = { 90994, 389763, 1 }, -- Throw Glaive has 2 charges, and snares all enemies hit by 50% for 6 sec.
    misery_in_defeat         = { 90945, 388110, 1 }, -- You deal 20% increased damage to enemies for 5 sec after Sigil of Misery's effect on them ends.
    momentum                 = { 91021, 206476, 1 }, -- Fel Rush, The Hunt, and Vengeful Retreat increase your damage done by 8% for 5 sec.
    mortal_dance             = { 90924, 328725, 1 }, -- Blade Dance now reduces targets' healing received by 50% for 6 sec.
    netherwalk               = { 90913, 196555, 1 }, -- Slip into the nether, increasing movement speed by 100% and becoming immune to damage, but unable to attack. Lasts 6 sec.
    pitch_black              = { 91001, 389783, 1 }, -- Reduces the cooldown of Darkness by 120 sec.
    precise_sigils           = { 90944, 389799, 1 }, -- All Sigils are now placed at your target's location, and the duration of their effects is increased by 2 sec.
    pursuit                  = { 90940, 320654, 1 }, -- Mastery increases your movement speed.
    quickened_sigils         = { 90997, 209281, 1 }, -- All Sigils activate 1 second faster, and their cooldowns are reduced by 20%.
    ragefire                 = { 90918, 388107, 1 }, -- Each time Immolation Aura deals damage, 35% of the damage dealt by up to 3 critical strikes is gathered as Ragefire. When Immolation Aura expires you explode, dealing all stored Ragefire damage to nearby enemies.
    relentless_onslaught     = { 91012, 389977, 1 }, -- Chaos Strike has a 10%vengeful_retreat chance to trigger a second Chaos Strike.
    relentless_pursuit       = { 90926, 389819, 1 }, -- The cooldown of The Hunt is reduced by 12 sec whenever an enemy is killed while afflicted by its damage over time effect.
    restless_hunter          = { 91024, 390142, 1 }, -- Leaving demon form grants a charge of Fel Rush and increases the damage of your next Blade Dance by 50%.
    rush_of_chaos            = { 90933, 320421, 1 }, -- Reduces the cooldown of Metamorphosis by 60 sec.
    serrated_glaive          = { 91013, 390154, 2 }, -- Enemies hit by Throw Glaive take 10% increased damage from Eye Beam.
    shattered_destiny        = { 91031, 388116, 1 }, -- The duration of your active demon form is extended by 0.1 sec per 8 Fury spent.
    shattered_restoration    = { 90950, 389824, 2 }, -- The healing of Shattered Souls is increased by 5%.
    sigil_of_flame           = { 90943, 204596, 1 }, -- Place a Sigil of Flame at the target location that activates after 2 sec. Deals 67 Fire damage, and an additional 187 Fire damage over 6 sec, to all enemies affected by the sigil. Generates 30 Fury.
    sigil_of_misery          = { 90946, 207684, 1 }, -- Place a Sigil of Misery at the target location that activates after 2 sec. Causes all enemies affected by the sigil to cower in fear, disorienting them for 20 sec.
    soul_rending             = { 90936, 204909, 2 }, -- Leech increased by 5%. Gain an additional 5% Leech while Metamorphosis is active.
    soul_sigils              = { 90929, 395446, 1 }, -- Afflicting an enemy with a Sigil generates 1 Lesser Soul Fragment.
    soulrend                 = { 90920, 388106, 2 }, -- Throw Glaive causes targets to take an additional 60% of damage dealt as Chaos over 6 sec.
    swallowed_anger          = { 91005, 320313, 1 }, -- Consume Magic generates 20 Fury when a beneficial Magic effect is successfully removed from the target.
    tactical_retreat         = { 91022, 389688, 1 }, -- Vengeful Retreat has a 5 sec reduced cooldown and generates 80 Fury over 10 sec.
    the_hunt                 = { 90927, 370965, 1 }, -- Charge to your target, striking them for 1,859 Nature damage, rooting them in place for 1.5 sec and inflicting 1,240 Nature damage over 6 sec to up to 5 enemies in your path. The pursuit invigorates your soul, healing you for 25% of the damage you deal to your Hunt target for 30 sec.
    trail_of_ruin            = { 90915, 258881, 1 }, -- The final slash of Blade Dance inflicts an additional 330 Chaos damage over 4 sec.
    unbound_chaos            = { 91020, 347461, 2 }, -- Activating Immolation Aura increases the damage of your next Fel Rush by 250%. Lasts 12 sec.
    unleashed_power          = { 90992, 206477, 1 }, -- Reduces the Fury cost of Chaos Nova by 50% and its cooldown by 20%.
    unnatural_malice         = { 90926, 389811, 1 }, -- Increase the damage over time effect of The Hunt by 30%.
    unrestrained_fury        = { 90941, 320770, 2 }, -- Increases maximum Fury by 10.
    vengeful_bonds           = { 90930, 320635, 1 }, -- Vengeful Retreat reduces the movement speed of all nearby enemies by 70% for 3 sec.
    vengeful_retreat         = { 90942, 198793, 1 }, -- Remove all snares and vault away. Nearby enemies take 64 Physical damage.
    will_of_the_illidari     = { 91000, 389695, 2 }, -- Increases maximum health by 2%.
} )


-- PvP Talents
spec:RegisterPvpTalents( {
    blood_moon            = 5433, -- (355995) Consume Magic now affects all enemies within 8 yards of the target, and grants 5% Leech for 5 sec.
    chaotic_imprint       = 809 , -- (356510) Throw Glaive now deals damage from a random school of magic, and increases the target's damage taken from the school by 10% for 20 sec.
    cleansed_by_flame     = 805 , -- (205625) Immolation Aura dispels all magical effects on you when cast.
    cover_of_darkness     = 1206, -- (357419) The radius of Darkness is increased by 4 yds, and its duration by 2 sec.
    detainment            = 812 , -- (205596) Imprison's PvP duration is increased by 1 sec, and targets become immune to damage and healing while imprisoned.
    first_of_the_illidari = 810 , -- (235893) Metamorphosis grants 10% Versatility and its cooldown is reduced by 60 sec.
    glimpse               = 813 , -- (354489) Vengeful Retreat provides immunity to loss of control effects, and reduces damage taken by 75% until you land.
    mortal_dance          = 1204, -- (328725) Blade Dance now reduces targets' healing received by 50% for 6 sec.
    rain_from_above       = 811 , -- (206803) You fly into the air out of harm's way. While floating, you gain access to Fel Lance allowing you to deal damage to enemies below.
    reverse_magic         = 806 , -- (205604) Removes all harmful magical effects from yourself and all nearby allies within 10 yards, and sends them back to their original caster if possible.
    sigil_mastery         = 5523, -- (211489) Reduces the cooldown of your Sigils by an additional 25%.
    unending_hatred       = 1218, -- (213480) Taking damage causes you to gain Fury based on the damage dealt.
} )


-- Auras
spec:RegisterAuras( {
    -- Dodge chance increased by $s2%.
    -- https://wowhead.com/beta/spell=188499
    blade_dance = {
        id = 188499,
        duration = 1,
        max_stack = 1
    },
    blazing_slaughter = {
        id = 355892,
        duration = 12,
        max_stack = 20,
    },
    -- Versatility increased by $w1%.
    -- https://wowhead.com/beta/spell=355894
    blind_faith = {
        id = 355894,
        duration = 20,
        max_stack = 1
    },
    -- Dodge increased by $s2%. Damage taken reduced by $s3%.
    -- https://wowhead.com/beta/spell=212800
    blur = {
        id = 212800,
        duration = 10,
        max_stack = 1
    },
    -- Talent: Taking $w1 Chaos damage every $t1 seconds.  Damage taken from $@auracaster's Immolation Aura increased by $s2%.
    -- https://wowhead.com/beta/spell=391191
    burning_wound = {
        id = 391191,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        copy = 346278
    },
    -- Talent: Stunned.
    -- https://wowhead.com/beta/spell=179057
    chaos_nova = {
        id = 179057,
        duration = function () return talent.isolated_prey.enabled and active_enemies == 1 and 3 or 2 end,
        type = "Magic",
        max_stack = 1
    },
    chaotic_blades = {
        id = 337567,
        duration = 8,
        max_stack = 1,
        copy = "chaos_theory" -- simc.
    },
    darkness = {
        id = 196718,
        duration = function () return pvptalent.cover_of_darkness.enabled and 10 or 8 end,
        max_stack = 1,
    },
    death_sweep = {
        id = 210152,
        duration = 1,
        max_stack = 1,
    },
    demon_soul = {
        id = 208195,
        duration = 20,
        max_stack = 1,
    },
    elysian_decree = { -- TODO: This aura determines sigil pop time.
        id = 390163,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1
    },
    essence_break = {
        id = 320338,
        duration = 8,
        max_stack = 1,
        copy = "dark_slash" -- Just in case.
    },
    -- https://wowhead.com/beta/spell=198013
    eye_beam = {
        id = 198013,
        duration = function () return ( talent.blind_fury.enabled and 3 or 2 ) * haste end,
        generate = function( t )
            if buff.casting.up and buff.casting.v1 == 198013 then
                t.applied  = buff.casting.applied
                t.duration = buff.casting.duration
                t.expires  = buff.casting.expires
                t.stack    = 1
                t.caster   = "player"
                forecastResources( "fury" )
                return
            end

            t.applied  = 0
            t.duration = class.auras.eye_beam.duration
            t.expires  = 0
            t.stack    = 0
            t.caster   = "nobody"
        end,
        tick_time = 0.2,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Unleashing Fel.
    -- https://wowhead.com/beta/spell=258925
    fel_barrage = {
        id = 258925,
        duration = 3,
        tick_time = 0.25,
        max_stack = 1
    },
    -- Legendary.
    fel_bombardment = {
        id = 337849,
        duration = 40,
        max_stack = 5,
    },
    -- Legendary
    fel_devastation = {
        id = 333105,
        duration = 2,
        max_stack = 1,
    },
    furious_gaze = {
        id = 343312,
        duration = 12,
        max_stack = 1,
    },
    -- Talent: Stunned.
    -- https://wowhead.com/beta/spell=211881
    fel_eruption = {
        id = 211881,
        duration = 4,
        max_stack = 1
    },
    -- Talent: Movement speed increased by $w1%.
    -- https://wowhead.com/beta/spell=389847
    felfire_haste = {
        id = 389847,
        duration = 8,
        max_stack = 1
    },
    -- Branded, dealing $204021s1% less damage to $@auracaster$?s389220[ and taking $w2% more Fire damage from them][].
    -- https://wowhead.com/beta/spell=207744
    fiery_brand = {
        id = 207744,
        duration = 10,
        max_stack = 1
    },
    -- Talent: Battling a demon from the Theater of Pain...
    -- https://wowhead.com/beta/spell=391430
    fodder_to_the_flame = {
        id = 391430,
        duration = 25,
        max_stack = 1
    },
    -- The buff from standing in the pool.
    fodder_to_the_flame = {
        id = 330910,
        duration = function () return 30 + ( conduit.brooding_pool.mod * 0.001 ) end,
        max_stack = 1,
        copy = 391430
    },
    -- The demon is linked to you.
    fodder_to_the_flame_chase = {
        id = 328605,
        duration = 3600,
        max_stack = 1,
    },
    -- This is essentially the countdown before the demon despawns (you can Imprison it for a long time).
    fodder_to_the_flame_cooldown = {
        id = 342357,
        duration = 120,
        max_stack = 1,
    },
    -- Falling speed reduced.
    -- https://wowhead.com/beta/spell=131347
    glide = {
        id = 131347,
        duration = 3600,
        max_stack = 1
    },
    -- Burning nearby enemies for $258922s1 $@spelldesc395020 damage every $t1 sec.$?a207548[    Movement speed increased by $w4%.][]$?a320331[    Armor increased by $w5%. Attackers suffer $@spelldesc395020 damage.][]
    -- https://wowhead.com/beta/spell=258920
    immolation_aura = {
        id = 258920,
        duration = 6,
        tick_time = 1,
        max_stack = 1
    },
    -- Talent: Incapacitated.
    -- https://wowhead.com/beta/spell=217832
    imprison = {
        id = 217832,
        duration = 60,
        mechanic = "sap",
        type = "Magic",
        max_stack = 1
    },
    inner_demon = {
        id = 337313,
        duration = 3600,
        max_stack = 1,
    },
    -- Talent: Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=213405
    master_of_the_glaive = {
        id = 213405,
        duration = 6,
        mechanic = "snare",
        max_stack = 1
    },
    -- Chaos Strike and Blade Dance upgraded to $@spellname201427 and $@spellname210152.  Haste increased by $w4%.$?s235893[  Versatility increased by $w5%.][]$?s204909[  Leech increased by $w3%.][]
    -- https://wowhead.com/beta/spell=162264
    metamorphosis = {
        id = 162264,
        duration = function () return 24 + ( pvptalent.demonic_origins.enabled and -15 or 0 ) end,
        max_stack = 1,
        meta = {
            extended_by_demonic = function ()
                return false -- disabled in 8.0:  talent.demonic.enabled and ( buff.metamorphosis.up and buff.metamorphosis.duration % 15 > 0 and buff.metamorphosis.duration > ( action.eye_beam.cast + 8 ) )
            end,
        },
    },
    momentum = {
        id = 208628,
        duration = 5,
        max_stack = 1,
    },
    -- Stunned.
    -- https://wowhead.com/beta/spell=200166
    metamorphosis_stun = {
        id = 200166,
        duration = 3,
        type = "Magic",
        max_stack = 1
    },
    -- Dazed.
    -- https://wowhead.com/beta/spell=247121
    metamorphosis_daze = {
        id = 247121,
        duration = 3,
        type = "Magic",
        max_stack = 1
    },
    misery_in_defeat = {
        id = 391369,
        duration = 5,
        max_stack = 1,
    },
    -- Talent: Healing effects received reduced by $w1%.
    -- https://wowhead.com/beta/spell=356608
    mortal_dance = {
        id = 356608,
        duration = 6,
        max_stack = 1
    },
    -- Talent: Immune to damage and unable to attack.  Movement speed increased by $s3%.
    -- https://wowhead.com/beta/spell=196555
    netherwalk = {
        id = 196555,
        duration = 6,
        max_stack = 1
    },
    rain_from_above_immune = {
        id = 206803,
        duration = 1,
        tick_time = 1,
        max_stack = 1,
        copy = "rain_from_above_launch"
    },
    rain_from_above = { -- Gliding/floating.
        id = 206804,
        duration = 10,
        max_stack = 1
    },
    serrated_glaive = {
        id = 390155,
        duration = 10,
        max_stack = 1
    },
    -- Movement slowed by $s1%.
    -- https://wowhead.com/beta/spell=204843
    sigil_of_chains = {
        id = 204843,
        duration = 6,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Suffering $w2 $@spelldesc395020 damage every $t2 sec.
    -- https://wowhead.com/beta/spell=204598
    sigil_of_flame_dot = {
        id = 204598,
        duration = 6,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Sigil of Flame is active.
    -- https://wowhead.com/beta/spell=389810
    sigil_of_flame = {
        id = 389810,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1,
        copy = 204596
    },
    -- Talent: Disoriented.
    -- https://wowhead.com/beta/spell=207685
    sigil_of_misery_debuff = {
        id = 207685,
        duration = 20,
        mechanic = "flee",
        type = "Magic",
        max_stack = 1
    },
    sigil_of_misery = { -- TODO: Model placement pop.
        id = 207684,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1
    },
    -- Silenced.
    -- https://wowhead.com/beta/spell=204490
    sigil_of_silence_debuff = {
        id = 204490,
        duration = 6,
        type = "Magic",
        max_stack = 1
    },
    sigil_of_silence = { -- TODO: Model placement pop.
        id = 202137,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1
    },
    -- Consume to heal for $210042s1% of your maximum health.
    -- https://wowhead.com/beta/spell=203795
    soul_fragment = {
        id = 203795,
        duration = 20,
        max_stack = 1
    },
    -- Talent: Suffering $w1 Chaos damage every $t1 sec.
    -- https://wowhead.com/beta/spell=390181
    soulrend = {
        id = 390181,
        duration = 6,
        tick_time = 2,
        max_stack = 1
    },
    -- Can see invisible and stealthed enemies.  Can see enemies and treasures through physical barriers.
    -- https://wowhead.com/beta/spell=188501
    spectral_sight = {
        id = 188501,
        duration = 10,
        max_stack = 1
    },
    -- Talent: Suffering $w1 $@spelldesc395042 damage every $t1 sec.
    -- https://wowhead.com/beta/spell=345335
    the_hunt_dot = {
        id = 370969,
        duration = 6,
        tick_time = 2,
        type = "Magic",
        max_stack = 1,
        copy = 345335
    },
    -- Talent: Marked by the Demon Hunter, converting $?c1[$345422s1%][$345422s2%] of the damage done to healing.
    -- https://wowhead.com/beta/spell=370966
    the_hunt = {
        id = 370966,
        duration = 30,
        max_stack = 1,
        copy = 323802
    },
    the_hunt_root = {
        id = 370970,
        duration = 1.5,
        max_stack = 1,
        copy = 323996
    },
    -- Taunted.
    -- https://wowhead.com/beta/spell=185245
    torment = {
        id = 185245,
        duration = 3,
        max_stack = 1
    },
    -- Talent: Suffering $w1 Chaos damage every $t1 sec.
    -- https://wowhead.com/beta/spell=258883
    trail_of_ruin = {
        id = 258883,
        duration = 4,
        tick_time = 1,
        type = "Magic",
        max_stack = 1
    },
    unbound_chaos = {
        id = 347462,
        duration = 20,
        max_stack = 1
    },
    -- Talent:
    -- https://wowhead.com/beta/spell=198793
    vengeful_retreat = {
        id = 198793,
        duration = 1,
        max_stack = 1
    },
    -- Talent: Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=198813
    vengeful_retreat_snare = {
        id = 198813,
        duration = 3,
        max_stack = 1
    },

    -- Conduit
    exposed_wound = {
        id = 339229,
        duration = 10,
        max_stack = 1,
    },
    -- Conduit
    felfire_haste = {
        id = 338804,
        duration = 8,
        max_stack = 1
    },

    -- PvP Talents
    chaotic_imprint_shadow = {
        id = 356656,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_nature = {
        id = 356660,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_arcane = {
        id = 356658,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_fire = {
        id = 356661,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_frost = {
        id = 356659,
        duration = 20,
        max_stack = 1,
    },
    -- Conduit
    demonic_parole = {
        id = 339051,
        duration = 12,
        max_stack = 1
    },
    glimpse = {
        id = 354610,
        duration = 8,
        max_stack = 1,
    },
    isolated_prey = {
        id = 357305,
        duration = 6,
        max_stack = 1,
    },
} )


local sigils = setmetatable( {}, {
    __index = function( t, k )
        t[ k ] = 0
        return t[ k ]
    end
} )

spec:RegisterStateFunction( "create_sigil", function( sigil )
    sigils[ sigil ] = query_time + ( talent.quickened_sigils.enabled and 1 or 2 )
end )

spec:RegisterStateExpr( "soul_fragments", function ()
    return buff.soul_fragments.stack
end )

spec:RegisterStateTable( "fragments", {
    real = 0,
    realTime = 0,
} )

spec:RegisterStateFunction( "queue_fragments", function( num, extraTime )
    fragments.real = fragments.real + num
    fragments.realTime = GetTime() + 1.25 + ( extraTime or 0 )
end )

spec:RegisterStateFunction( "purge_fragments", function()
    fragments.real = 0
    fragments.realTime = 0
end )

local last_darkness = 0
local last_metamorphosis = 0
local last_eye_beam = 0

spec:RegisterStateExpr( "darkness_applied", function ()
    return max( class.abilities.darkness.lastCast, last_darkness )
end )

spec:RegisterStateExpr( "metamorphosis_applied", function ()
    return max( class.abilities.darkness.lastCast, last_metamorphosis )
end )

spec:RegisterStateExpr( "eye_beam_applied", function ()
    return max( class.abilities.eye_beam.lastCast, last_eye_beam )
end )

spec:RegisterStateExpr( "extended_by_demonic", function ()
    return buff.metamorphosis.up and buff.metamorphosis.extended_by_demonic
end )

local activation_time = function ()
    return talent.quickened_sigils.enabled and 1 or 2
end

spec:RegisterStateExpr( "activation_time", activation_time )

local sigil_placed = function ()
    return sigils.flame > query_time
end

spec:RegisterStateExpr( "sigil_placed", sigil_placed )

spec:RegisterStateExpr( "meta_cd_multiplier", function ()
    return 1
end )



local queued_frag_modifier = 0

spec:RegisterHook( "COMBAT_LOG_EVENT_UNFILTERED", function( _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName )
    if sourceGUID == GUID then
        if subtype == "SPELL_CAST_SUCCESS" then
            -- Fracture:  Generate 2 frags.
            if spellID == 263642 then
                queue_fragments( 2 ) end

            -- Shear:  Generate 1 frag.
            if spellID == 203782 then
                queue_fragments( 1 ) end

            --[[ Spirit Bomb:  Up to 5 frags.
            if spellID == 247454 then
                local name, _, count = FindUnitBuffByID( "player", 203981 )
                if name then queue_fragments( -1 * count ) end
            end

            -- Soul Cleave:  Up to 2 frags.
            if spellID == 228477 then
                local name, _, count = FindUnitBuffByID( "player", 203981 )
                if name then queue_fragments( -1 * min( 2, count ) ) end
            end ]]

        -- We consumed or generated a fragment for real, so let's purge the real queue.
        elseif spellID == 203981 and fragments.real > 0 and ( subtype == "SPELL_AURA_APPLIED" or subtype == "SPELL_AURA_APPLIED_DOSE" ) then
            fragments.real = fragments.real - 1

        end
    end
end, false )


local furySpent = 0

local FURY = Enum.PowerType.Fury
local lastFury = -1

spec:RegisterUnitEvent( "UNIT_POWER_FREQUENT", "player", nil, function( event, unit, powerType )
    if powerType == "FURY" then
        local current = UnitPower( "player", FURY )

        if current < lastFury then
            furySpent = ( furySpent + lastFury - current ) % 60
        end

        lastFury = current
    end
end )

spec:RegisterStateExpr( "fury_spent", function ()
    return furySpent
end )

spec:RegisterHook( "spend", function( amt, resource )
    if set_bonus.tier28_4pc > 0 and resource == "fury" then
        fury_spent = fury_spent + amt
        if fury_spent > 60 then
            cooldown.metamorphosis.expires = cooldown.metamorphosis.expires - floor( fury_spent / 60 )
            fury_spent = fury_spent % 60
        end
    end
end )


spec:RegisterHook( "reset_precast", function ()
    last_darkness = 0
    last_metamorphosis = 0
    last_eye_beam = 0

    local rps = 0

    if equipped.convergence_of_fates then
        rps = rps + ( 3 / ( 60 / 4.35 ) )
    end

    if equipped.delusions_of_grandeur then
        -- From SimC model, 1/13/2018.
        local fps = 10.2 + ( talent.demonic.enabled and 1.2 or 0 )

        -- SimC uses base haste, we'll use current since we recalc each time.
        fps = fps / haste

        -- Chaos Strike accounts for most Fury expenditure.
        fps = fps + ( ( fps * 0.9 ) * 0.5 * ( 40 / 100 ) )

        rps = rps + ( fps / 30 ) * ( 1 )
    end

    meta_cd_multiplier = 1 / ( 1 + rps )

    fury_spent = nil
end )


spec:RegisterCycle( function ()
    if active_enemies == 1 then return end

    -- For Nemesis, we want to cast it on the lowest health enemy.
    if this_action == "nemesis" and Hekili:GetNumTTDsWithin( target.time_to_die ) > 1 then return "cycle" end
end )


-- Tier 28
spec:RegisterGear( "tier28", 188898, 188896, 188894, 188893, 188892 )
spec:RegisterSetBonuses( "tier28_2pc", 364438, "tier28_4pc", 363736 )
-- 2-Set - Deadly Dance - Increases Death Sweep and Annihilation / Blade Dance and Chaos Strike damage by 20%.
-- 4-Set - Deadly Dance - Metamorphosis duration is increased by 6 sec. Every 60 Fury you consume reduces the cooldown of Metamorphosis by 1 sec.


-- Gear Sets
spec:RegisterGear( "tier19", 138375, 138376, 138377, 138378, 138379, 138380 )
spec:RegisterGear( "tier20", 147130, 147132, 147128, 147127, 147129, 147131 )
spec:RegisterGear( "tier21", 152121, 152123, 152119, 152118, 152120, 152122 )
    spec:RegisterAura( "havoc_t21_4pc", {
        id = 252165,
        duration = 8
    } )

spec:RegisterGear( "class", 139715, 139716, 139717, 139718, 139719, 139720, 139721, 139722 )

spec:RegisterGear( "convergence_of_fates", 140806 )

spec:RegisterGear( "achor_the_eternal_hunger", 137014 )
spec:RegisterGear( "anger_of_the_halfgiants", 137038 )
spec:RegisterGear( "cinidaria_the_symbiote", 133976 )
spec:RegisterGear( "delusions_of_grandeur", 144279 )
spec:RegisterGear( "kiljaedens_burning_wish", 144259 )
spec:RegisterGear( "loramus_thalipedes_sacrifice", 137022 )
spec:RegisterGear( "moarg_bionic_stabilizers", 137090 )
spec:RegisterGear( "prydaz_xavarics_magnum_opus", 132444 )
spec:RegisterGear( "raddons_cascading_eyes", 137061 )
spec:RegisterGear( "sephuzs_secret", 132452 )
spec:RegisterGear( "the_sentinels_eternal_refuge", 146669 )

spec:RegisterGear( "soul_of_the_slayer", 151639 )
spec:RegisterGear( "chaos_theory", 151798 )
spec:RegisterGear( "oblivions_embrace", 151799 )


do
    local wasWarned = false

    spec:RegisterEvent( "PLAYER_REGEN_DISABLED", function ()
        if state.talent.demon_blades.enabled and not state.settings.demon_blades_acknowledged and not wasWarned then
            Hekili:Notify( "|cFFFF0000WARNING!|r  Demon Blades cannot be forecasted.\nSee /hekili > Havoc for more information." )
            wasWarned = true
        end
    end )
end

-- SimC documentation reflects that there are still the following expressions, which appear unused:
-- greater_soul_fragments, lesser_soul_fragments, blade_dance_worth_using, death_sweep_worth_using
-- They are not implemented becuase that documentation is from mid-2016.


-- Abilities
spec:RegisterAbilities( {
    annihilation = {
        id = 201427,
        known = 162794,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function () return 40 - buff.thirsting_blades.stack end,
        spendType = "fury",

        startsCombat = true,
        texture = 1303275,

        bind = "chaos_strike",
        buff = "metamorphosis",

        handler = function ()
            removeBuff( "thirsting_blades" )
            if azerite.thirsting_blades.enabled then applyBuff( "thirsting_blades", nil, 0 ) end

            if buff.chaotic_blades.up then gain( 20, "fury" ) end -- legendary
        end,
    },

    -- Strike $?a206416[your primary target for $<firstbloodDmg> Chaos damage and ][]all nearby enemies for $<baseDmg> Physical damage$?s320398[, and increase your chance to dodge by $193311s1% for $193311d.][. Deals reduced damage beyond $199552s1 targets.]
    blade_dance = {
        id = 188499,
        cast = 0,
        cooldown = 10,
        hasteCD = true,
        gcd = "spell",
        school = "physical",

        spend = function () return 35 - ( talent.first_blood.enabled and 20 or 0 ) end,
        spendType = "fury",

        startsCombat = true,

        bind = "death_sweep",
        nobuff = "metamorphosis",

        handler = function ()
            applyBuff( "blade_dance" )
            setCooldown( "death_sweep", 9 * haste )

            if pvptalent.mortal_dance.enabled then
                applyDebuff( "target", "mortal_dance" )
            end
        end,

        copy = "blade_dance1"
    },

    -- Increases your chance to dodge by $212800s2% and reduces all damage taken by $212800s3% for $212800d.
    blur = {
        id = 198589,
        cast = 0,
        cooldown = function () return 60 + ( conduit.fel_defender.mod * 0.001 ) end,
        gcd = "off",
        school = "physical",

        startsCombat = false,

        toggle = "defensives",

        handler = function ()
            applyBuff( "blur" )
        end,
    },

    -- Talent: Unleash an eruption of fel energy, dealing $s2 Chaos damage and stunning all nearby enemies for $d.$?s320412[    Each enemy stunned by Chaos Nova has a $s3% chance to generate a Lesser Soul Fragment.][]
    chaos_nova = {
        id = 179057,
        cast = 0,
        cooldown = function () return talent.unleashed_power.enabled and 40 or 60 end,
        gcd = "spell",
        school = "chromatic",

        spend = function () return talent.unleashed_power.enabled and 0 or 30 end,
        spendType = "fury",

        talent = "chaos_nova",
        startsCombat = true,

        toggle = "cooldowns",

        handler = function ()
            applyDebuff( "target", "chaos_nova" )
        end,
    },

    -- Slice your target for ${$222031s1+$199547s1} Chaos damage. Chaos Strike has a ${$min($197125h,100)}% chance to refund $193840s1 Fury.
    chaos_strike = {
        id = 162794,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "chaos",

        spend = function () return 40 - buff.thirsting_blades.stack end,
        spendType = "fury",

        startsCombat = true,

        bind = "annihilation",
        nobuff = "metamorphosis",

        cycle = function () return ( talent.burning_wound.enabled or legendary.burning_wound.enabled ) and "burning_wound" or nil end,

        handler = function ()
            removeBuff( "thirsting_blades" )
            if azerite.thirsting_blades.enabled then applyBuff( "thirsting_blades", nil, 0 ) end
            if legendary.burning_wound.enabled then applyDebuff( "target", "burning_wound" ) end
            if buff.chaotic_blades.up then gain( 20, "fury" ) end -- legendary
        end,
    },

    -- Talent: Consume $m1 beneficial Magic effect removing it from the target$?s320313[ and granting you $s2 Fury][].
    consume_magic = {
        id = 278326,
        cast = 0,
        cooldown = 10,
        gcd = "spell",
        school = "chromatic",

        talent = "consume_magic",
        startsCombat = false,

        toggle = "interrupts",

        usable = function () return buff.dispellable_magic.up end,
        handler = function ()
            removeBuff( "dispellable_magic" )
            gain( buff.solitude.up and 22 or 20, "fury" )
        end,
    },

    -- Talent: Summons darkness around you in a$?a357419[ 12 yd][n 8 yd] radius, granting friendly targets a $209426s2% chance to avoid all damage from an attack. Lasts $d.
    darkness = {
        id = 196718,
        cast = 0,
        cooldown = 300,
        gcd = "spell",
        school = "physical",

        talent = "darkness",
        startsCombat = false,

        toggle = "defensives",

        handler = function ()
            last_darkness = query_time
            applyBuff( "darkness" )
        end,
    },


    death_sweep = {
        id = 210152,
        known = 188499,
        cast = 0,
        cooldown = 9,
        hasteCD = true,
        gcd = "spell",

        spend = function () return talent.first_blood.enabled and 15 or 35 end,
        spendType = "fury",

        startsCombat = true,
        texture = 1309099,

        bind = "blade_dance",
        buff = "metamorphosis",

        handler = function ()
            applyBuff( "death_sweep" )
            setCooldown( "blade_dance", 9 * haste )

            if pvptalent.mortal_dance.enabled or talent.mortal_dance.enabled then
                applyDebuff( "target", "mortal_dance" )
            end
        end,
    },

    -- Quickly attack for $s2 Physical damage.    |cFFFFFFFFGenerates $?a258876[${$m3+$258876s3} to ${$M3+$258876s4}][$m3 to $M3] Fury.|r
    demons_bite = {
        id = 162243,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "physical",

        spend = function () return talent.insatiable_hunger.enabled and -25 or -20 end,
        spendType = "fury",

        startsCombat = true,

        notalent = "demon_blades",

        handler = function ()
        end,
    },

    -- Interrupts the enemy's spellcasting and locks them from that school of magic for $d.|cFFFFFFFF$?s183782[    Generates $218903s1 Fury on a successful interrupt.][]|r
    disrupt = {
        id = 183752,
        cast = 0,
        cooldown = 15,
        gcd = "off",
        school = "chromatic",

        startsCombat = true,

        toggle = "interrupts",

        debuff = "casting",
        readyTime = state.timeToInterrupt,

        handler = function ()
            interrupt()
            gain( buff.solitude.up and 33 or 30, "fury" )
        end,
    },

    -- Talent / Covenant (Kyrian): Place a Kyrian Sigil at the target location that activates after $d.    Detonates to deal $307046s1 $@spelldesc395039 damage and shatter up to $s3 Lesser Soul Fragments from enemies affected by the sigil. Deals reduced damage beyond $s1 targets.
    elysian_decree = {
        id = function() return covenant.kyrian and 306830 or 390163 end,
        cast = 0,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",

        talent = function()
            if covenant.kyrian then return end
            return "elysian_decree"
        end,
        startsCombat = false,

        handler = function ()
            create_sigil( "elysian_decree" )

            if legendary.blind_faith.enabled then applyBuff( "blind_faith" ) end
        end,

        copy = { 390163, 306830 }
    },

    -- Talent: Slash all enemies in front of you for $s1 Chaos damage, and increase the damage your Chaos Strike and Blade Dance deal to them by $320338s1% for $320338d. Deals reduced damage beyond $s2 targets.
    essence_break = {
        id = 258860,
        cast = 0,
        cooldown = 40,
        gcd = "spell",
        school = "chromatic",

        talent = "essence_break",
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "essence_break" )
            active_dot.essence_break = max( 1, active_enemies )
        end,

        copy = "dark_slash"
    },

    -- Talent: Blasts all enemies in front of you, $?s320415[dealing guaranteed critical strikes][] for up to $<dmg> Chaos damage over $d. Deals reduced damage beyond $s5 targets.$?s343311[    When Eye Beam finishes fully channeling, your Haste is increased by an additional $343312s1% for $343312d.][]
    eye_beam = {
        id = 198013,
        cast = function () return ( talent.blind_fury.enabled and 3 or 2 ) * haste end,
        channeled = true,
        cooldown = 40,
        gcd = "spell",
        school = "chromatic",

        spend = 30,
        spendType = "fury",

        talent = "eye_beam",
        startsCombat = true,

        start = function ()
            last_eye_beam = query_time

            applyBuff( "eye_beam" )

            if talent.demonic.enabled then
                if buff.metamorphosis.up then
                    buff.metamorphosis.duration = buff.metamorphosis.remains + 8
                    buff.metamorphosis.expires = buff.metamorphosis.expires + 8
                else
                    applyBuff( "metamorphosis", action.eye_beam.cast + 8 )
                    buff.metamorphosis.duration = action.eye_beam.cast + 8
                    stat.haste = stat.haste + 25
                end
            end

            if pvptalent.isolated_prey.enabled and active_enemies == 1 then
                applyDebuff( "target", "isolated_prey" )
            end

            -- This is likely repeated per tick but it's not worth the CPU overhead to model each tick.
            if legendary.agony_gaze.enabled and debuff.sinful_brand.up then
                debuff.sinful_brand.expires = debuff.sinful_brand.expires + 0.75
            end
        end,

        finish = function ()
            if talent.furious_gaze.enabled then applyBuff( "furious_gaze" ) end
        end,
    },

    -- Talent: Unleash a torrent of Fel energy over $d, inflicting ${(($d/$t1)+1)*$258926s1} Chaos damage to all enemies within $258926A1 yds. Deals reduced damage beyond $258926s2 targets.
    fel_barrage = {
        id = 258925,
        cast = 2,
        channeled = true,
        cooldown = 60,
        gcd = "spell",
        school = "chromatic",

        talent = "fel_barrage",
        startsCombat = false,

        toggle = "cooldowns",

        start = function ()
            applyBuff( "fel_barrage", 2 )
        end,
    },

    -- Talent: Impales the target for $s1 Chaos damage and stuns them for $d.
    fel_eruption = {
        id = 211881,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "chromatic",

        spend = 10,
        spendType = "fury",

        talent = "fel_eruption",
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "fel_eruption" )
        end,
    },

    -- Rush forward, incinerating anything in your path for $192611s1 Chaos damage.
    fel_rush = {
        id = 195072,
        cast = 0,
        charges = 1,
        cooldown = function () return legendary.erratic_fel_core.enabled and 7 or 10 end,
        recharge = function () return legendary.erratic_fel_core.enabled and 7 or 10 end,
        gcd = "off",
        school = "physical",

        startsCombat = true,

        readyTime = function ()
            if prev_gcd[1].fel_rush then
                return 3600
            end
            if settings.recommend_movement then return 0 end
            if buff.unbound_chaos.up and settings.unbound_movement then return 0 end
            return 3600
        end,
        handler = function ()
            removeBuff( "unbound_chaos" )
            if talent.momentum.enabled then applyBuff( "momentum" ) end
            if cooldown.vengeful_retreat.remains < 1 then setCooldown( "vengeful_retreat", 1 ) end
            setDistance( 5 )
            setCooldown( "global_cooldown", 0.25 )
            if conduit.felfire_haste.enabled then applyBuff( "felfire_haste" ) end
            if pvptalent.isolated_prey.enabled and active_enemies == 1 then
                gain( 35, "fury" )
            end
        end,
    },

    -- Rush forward, incinerating anything in your path for $192611s1 Chaos damage.
    fel_rush = {
        id = 344865,
        cast = 0,
        charges = 1,
        cooldown = 1,
        recharge = 10,
        gcd = "off",
        school = "physical",

        startsCombat = false,

        handler = function ()
            -- trigger fel_rush [195072]
        end,
    },


    fel_lance = {
        id = 206966,
        cast = 1,
        cooldown = 0,
        gcd = "spell",

        pvptalent = "rain_from_above",
        buff = "rain_from_above",

        startsCombat = true,
    },

    -- Talent: Charge to your target and deal $213243sw2 $@spelldesc395020 damage.    $?s203513[Shear has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r]?a203555[Demon Blades has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r][Demon's Bite has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r]
    felblade = {
        id = 232893,
        cast = 0,
        cooldown = 15,
        hasteCD = true,
        gcd = "spell",
        school = "physical",

        spend = -40,
        spendType = "fury",

        talent = "felblade",
        startsCombat = true,

        -- usable = function () return target.within15 end,
        handler = function ()
            setDistance( 5 )
        end,
    },

    -- Talent: Launch two demonic glaives in a whirlwind of energy, causing ${14*$342857s1} Chaos damage over $d to all nearby enemies. Deals reduced damage beyond $s2 targets.
    glaive_tempest = {
        id = 342817,
        cast = 0,
        cooldown = 20,
        gcd = "spell",
        school = "magic",

        spend = 30,
        spendType = "fury",

        talent = "glaive_tempest",
        startsCombat = true,

        handler = function ()
        end,
    },

    -- Engulf yourself in flames, $?a320364 [instantly causing $258921s1 $@spelldesc395020 damage to enemies within $258921A1 yards and ][]radiating ${$258922s1*$d} $@spelldesc395020 damage over $d.$?s320374[    |cFFFFFFFFGenerates $<havocTalentFury> Fury over $d.|r][]$?(s212612 & !s320374)[    |cFFFFFFFFGenerates $<havocFury> Fury.|r][]$?s212613[    |cFFFFFFFFGenerates $<vengeFury> Fury over $d.|r][]
    immolation_aura = {
        id = 258920,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "fire",

        spend = -20,
        spendType = "fury",

        startsCombat = true,

        handler = function ()
            applyBuff( "immolation_aura" )
            if talent.unbound_chaos.enabled then applyBuff( "unbound_chaos" ) end
        end,
    },

    -- Talent: Imprisons a demon, beast, or humanoid, incapacitating them for $d. Damage will cancel the effect. Limit 1.
    imprison = {
        id = 217832,
        cast = 0,
        gcd = "spell",
        school = "shadow",

        talent = "imprison",
        startsCombat = false,

        handler = function ()
            applyDebuff( "target", "imprison" )
        end,
    },

    -- Leap into the air and land with explosive force, dealing $200166s2 Chaos damage to enemies within 8 yds, and stunning them for $200166d. Players are Dazed for $247121d instead.    Upon landing, you are transformed into a hellish demon for $162264d, $?s320645[immediately resetting the cooldown of your Eye Beam and Blade Dance abilities, ][]greatly empowering your Chaos Strike and Blade Dance abilities and gaining $162264s4% Haste$?(s235893&s204909)[, $162264s5% Versatility, and $162264s3% Leech]?(s235893&!s204909[ and $162264s5% Versatility]?(s204909&!s235893)[ and $162264s3% Leech][].
    metamorphosis = {
        id = 191427,
        cast = 0,
        cooldown = function () return ( level > 47 and 240 or 300 ) * ( essence.vision_of_perfection.enabled and 0.87 or 1 ) - ( pvptalent.demonic_origins.up and 120 or 0 ) end,
        gcd = "spell",
        school = "physical",

        startsCombat = false,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "metamorphosis" )
            last_metamorphosis = query_time

            setDistance( 5 )

            if IsSpellKnownOrOverridesKnown( 317009 ) then
                applyDebuff( "target", "sinful_brand" )
                active_dot.sinful_brand = active_enemies
            end

            if level > 19 then stat.haste = stat.haste + 25 end

            if level > 53 or azerite.chaotic_transformation.enabled then
                setCooldown( "eye_beam", 0 )
                setCooldown( "blade_dance", 0 )
                setCooldown( "death_sweep", 0 )
            end
        end,

        meta = {
            adjusted_remains = function ()
                --[[ if level < 116 and ( equipped.delusions_of_grandeur or equipped.convergeance_of_fates ) then
                    return cooldown.metamorphosis.remains * meta_cd_multiplier
                end ]]

                return cooldown.metamorphosis.remains
            end
        }
    },

    -- Talent: Slip into the nether, increasing movement speed by $s3% and becoming immune to damage, but unable to attack. Lasts $d.
    netherwalk = {
        id = 196555,
        cast = 0,
        cooldown = 180,
        gcd = "spell",
        school = "physical",

        talent = "netherwalk",
        startsCombat = false,

        toggle = "interrupts",

        handler = function ()
            applyBuff( "netherwalk" )
            setCooldown( "global_cooldown", buff.netherwalk.remains )
        end,
    },


    rain_from_above = {
        id = 206803,
        cast = 0,
        cooldown = 60,
        gcd = "spell",

        pvptalent = "rain_from_above",

        startsCombat = false,
        texture = 1380371,

        handler = function ()
            applyBuff( "rain_from_above" )
        end,
    },


    reverse_magic = {
        id = 205604,
        cast = 0,
        cooldown = 60,
        gcd = "spell",

        -- toggle = "cooldowns",
        pvptalent = "reverse_magic",

        startsCombat = false,
        texture = 1380372,

        debuff = "reversible_magic",

        handler = function ()
            if debuff.reversible_magic.up then removeDebuff( "player", "reversible_magic" ) end
        end,
    },


    -- Talent: Place a Sigil of Flame at your location that activates after $d.    Deals $204598s1 Fire damage, and an additional $204598o3 Fire damage over $204598d, to all enemies affected by the sigil.    |CFFffffffGenerates $389787s1 Fury.|R
    sigil_of_flame = {
        id = function () return talent.concentrated_sigils.enabled and 204513 or 204596 end,
        known = 204596,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "physical",

        spend = -30,
        spendType = "fury",

        talent = "sigil_of_flame",
        startsCombat = false,

        readyTime = function ()
            return sigils.flame - query_time
        end,

        sigil_placed = function() return sigil_placed end,

        handler = function ()
            create_sigil( "flame" )
        end,

        copy = { 204596, 204513 }
    },

    -- Talent: Place a Sigil of Misery at your location that activates after $d.    Causes all enemies affected by the sigil to cower in fear. Targets are disoriented for $207685d.
    sigil_of_misery = {
        id = function () return talent.concentrated_sigils.enabled and 207684 or 202140 end,
        cast = 0,
        cooldown = function () return ( pvptalent.sigil_mastery.enabled and 0.75 or 1 ) * 120 - ( talent.improved_sigil_of_misery.enabled and 30 or 0 ) end,
        gcd = "spell",
        school = "physical",

        talent = "sigil_of_misery",
        startsCombat = false,

        toggle = "interrupts",

        handler = function ()
            create_sigil( "misery" )
        end,

        copy = { 207684, 202140 }
    },

    -- Allows you to see enemies and treasures through physical barriers, as well as enemies that are stealthed and invisible. Lasts $d.    Attacking or taking damage disrupts the sight.
    spectral_sight = {
        id = 188501,
        cast = 0,
        cooldown = 60,
        gcd = "spell",
        school = "physical",

        startsCombat = false,

        handler = function ()
            applyBuff( "spectral_sight" )
        end,
    },

    -- Talent / Covenant (Night Fae): Charge to your target, striking them for $370966s1 $@spelldesc395042 damage, rooting them in place for $370970d and inflicting $370969o1 $@spelldesc395042 damage over $370969d to up to $370967s2 enemies in your path.     The pursuit invigorates your soul, healing you for $?c1[$370968s1%][$370968s2%] of the damage you deal to your Hunt target for $370966d.
    the_hunt = {
        id = function() return talent.the_hunt.enabled and 370965 or 323639 end,
        cast = 1,
        cooldown = function() return talent.the_hunt.enabled and 90 or 180 end,
        gcd = "spell",
        school = "nature",

        talent = "the_hunt",
        startsCombat = false,

        toggle = function() return talent.the_hunt.enabled and "cooldowns" or "essences" end,

        handler = function ()
            applyDebuff( "target", "the_hunt" )
            applyDebuff( "target", "the_hunt_dot" )
            setDistance( 5 )

            if talent.momentum.enabled then applyBuff( "momentum" ) end

            if legendary.blazing_slaughter.enabled then
                applyBuff( "immolation_aura" )
                applyBuff( "blazing_slaughter" )
            end
        end,
    },

    -- Throw a demonic glaive at the target, dealing $337819s1 Physical damage. The glaive can ricochet to $?$s320386[${$337819x1-1} additional enemies][an additional enemy] within 10 yards.
    throw_glaive = {
        id = 185123,
        cast = 0,
        charges = function () return talent.master_of_the_glaive.enabled and 2 or nil end,
        cooldown = 9,
        recharge = function () return talent.master_of_the_glaive.enabled and 9 or nil end,
        gcd = "spell",
        school = "physical",

        spend = 25,
        spendType = "fury, 393029",

        startsCombat = true,

        toggle = "interrupts",

        debuff = "casting",
        readyTime = state.timeToInterrupt,

        handler = function ()
            if talent.mastery_of_the_glaive.enabled then applyDebuff( "target", "master_of_the_glaive" ) end
        end,
    },

    -- Taunts the target to attack you.
    torment = {
        id = 185245,
        cast = 0,
        cooldown = 8,
        gcd = "off",
        school = "shadow",

        startsCombat = false,

        handler = function ()
            applyBuff( "torment" )
        end,
    },

    -- Talent: Remove all snares and vault away. Nearby enemies take $198813s2 Physical damage$?s320635[ and have their movement speed reduced by $198813s1% for $198813d][].$?a203551[    |cFFFFFFFFGenerates ${($203650s1/5)*$203650d} Fury over $203650d if you damage an enemy.|r][]
    vengeful_retreat = {
        id = 198793,
        cast = 0,
        cooldown = function () return talent.momentum.enabled and 20 or 25 end,
        gcd = "spell",

        startsCombat = true,

        readyTime = function ()
            if settings.recommend_movement then return 0 end
            return 3600
        end,

        handler = function ()
            if target.within8 then
                applyDebuff( "target", "vengeful_retreat" )
                if talent.momentum.enabled then applyBuff( "momentum" ) end
            end

            if pvptalent.glimpse.enabled then applyBuff( "glimpse" ) end
        end,
    }
} )


spec:RegisterOptions( {
    enabled = true,

    aoe = 2,

    nameplates = true,
    nameplateRange = 7,

    damage = true,
    damageExpiration = 8,

    potion = "phantom_fire",

    package = "Havoc",
} )


spec:RegisterSetting( "recommend_movement", true, {
    name = "Recommend Movement",
    desc = "If checked, the addon will recommend |T1247261:0|t Fel Rush / |T1348401:0|t Vengeful Retreat when it is a potential DPS gain.\n\n" ..
        "These abilities are critical for DPS when using the Momentum or Unbound Chaos talents.\n\n" ..
        "If not using Momentum or Unbound Chaos, you may want to disable this to avoid unnecessary movement in combat.",
    type = "toggle",
    width = "full"
} )

spec:RegisterSetting( "unbound_movement", false, {
    name = "Recommend Movement for Unbound Chaos",
    desc = "When Recommend Movement is disabled, you can enable this option to override it and allow |T1247261:0|t Fel Rush to be recommended when Unbound Chaos is active.",
    type = "toggle",
    width = "full",
    disabled = function() return state.settings.recommend_movement end,
} )


spec:RegisterSetting( "demon_blades_head", nil, {
    name = "Demon Blades",
    type = "header",
} )

spec:RegisterSetting( "demon_blades_text", nil, {
    name = "|cFFFF0000WARNING!|r  If using the |T237507:0|t Demon Blades talent, the addon will not be able to predict Fury gains from your auto-attacks.  This will result " ..
        "in recommendations that jump forward in your display(s).",
    type = "description",
    width = "full"
} )

spec:RegisterSetting( "demon_blades_acknowledged", false, {
    name = "I understand that Demon Blades is unpredictable; don't warn me.",
    desc = "If checked, the addon will not provide a warning about Demon Blades when entering combat.",
    type = "toggle",
    width = "full",
    arg = function() return false end,
} )


spec:RegisterPack( "Havoc", 20220821, [[Hekili:v31)ZTTTs()w8RZtrk1vvI2YjTJLFttAETntVC38CVj3pjkirilEHIuh)ID8nE0F73UaGGaqaGuY2j5MoJRnbXI974ZUGKz24z)1SRJiL0zFiyuqWOxhmE44xF2pD(RMDD59BPZUElz5Ni3a)skzd8ZFNCB2s8Q3NKrIWzxKvLVeg564nvjKY4S03Mtwvo76fvXjL)r6Sf2xHjWu3sxo7dtEfSyRJJIO87LwalWVs3KLUB(VxLwsZH)pUS7E)VuDtvr5U5bJpf(bqUDVF37F7As6n0IFE37)HDZ)3OLKnz5BxNvexSBojnA38)JmKR2nVQaeKDZ)BlORYYHFzv8nRbIrtJk(B7MNKDt8sygr)3WsqHPvMb)12Tj3VBEwk(t8clYkkeZSyiBf)ZSScks9T7MxCF6Y40BGjSApwP)M4u(aI1nNUHeNcJClqP5L5XPFIcx(T)kmePCnk2LGOTB(gYNhme055zRItan939D7MBx)GJyvhHd0ONW)6lVUsSQFH0xOutwIctXWT50LzBwqkNUiRSmHgfUkHCpn6oyTdlZ(mSq7FVF)0F8wsEmzrc9u03FQyfdrMoSijR80Bjjv0PJpnEv9GdhpCnPiSQGgUOA1QE9pPEGaTbE4HMjSmlljk7U0Hrv5S4NRM2mP9gCWJHvduz1axS6yhSQfU5kpIbWPGf))Sa8EE39WpEdLSb8skr3N72n)FwLd(j3fxUggkjgD(4xIKKHUe8rOXCl7VsY)0nje0vmlx6()MecKUa8LstOOVwvbZB6xUjlfi0Vr(FPDrBHsk9EqAbgmCfWdHlZsJIXPj0BLKeAA5WfiBYUJH0uC(r96NxLIHi3qhgvZIHBOrKKey6GUJpZiKFdxWyx5CpPzUeKJdVbyyh23vGaUEjMyfnHqo3KfaVmCle)vLaSFE12s2ckh62mmBmmwrwYTapyNUK8LKukeeKNZUhEy67(mDzflWMElfTjLXBOy4f8dGkOfGLX4wsCckldLeFAuCbYlYlaRbOnlQ2aQfcM1GTaFeiuuw6lkX)hsyKCLeqvaxP4oivcZqQKw5nv5PSR9XSkWxHrLMLiNYNCiPQmlKuwc7ADkyTOHlJGauXGGMdsQ8Zru0VE4cofdVdj4qr2fu72yw0ULEESLmx9pc(QzvLSmTzG88xRPzOYlt1)9uHxlEP0L0A)8)zCoM0(njzzr8zGbkN99qEWGVV(M(RCqFZZj(VQIHamHkRqvBR7BZyZWiCPqrtXLBjYKHLmEu1v0IBSEuWkKvb5h40AXhC72stscfSZqLvD8vt7F2piMAjkaHzRcZb2VEYdKkpdn3(QQ14ghmVq0cYDcXCoNAxnIQqu71FShviQR5J9UcyJjCDEtoL8j(0phN(zpHwa7gaHgM5xQE9HO0jZIyrZ3ZRIpWVI)Hhorm(Y7xczkGXxtkZPDK6N3zZQBVFuhNMLVHK0e)VeI2kRT2OkbteTa3zaYnqXCZemSIcdSS8ur0sYDK7le2S)cSxRWRMML(dSTkW8ohSb64Ie6ZmIBubZmSAR0gAvx9WdICsuUly4c0deM2a)wGwcSASVrCLqNSRNRSVTrernAqDBymgjwASLGapzggMwdnOB2GSTtZPfu2gDc2xxTuleseh6dd)i6EfNpv0aCM6TO3opk(3z(7NImEwCKebHJ8oOSZ2PctbTfG3gViojUuG3L(5sksEed6VK9UDZVooDvvcQ9WLTtcVMdydQGE2JtfUJ1Kt1q2dxTBH)iRCybJpa1dWgxg4Mr2ckuC7oy1drhyb5D5ej1)6o7IDsV8IEmKsr0vXlJlV6SrDBHv1gEeV(iXV8vt(b3XIVmy0GUTM1O)0dVnL3tCddSXvuqjPwO)nlJgcvK8YGb66JGr29rrFXYs6gadfZRcXWRJGg9XKHu1vQXY3bRdufoCp1yWpTbBmdpbKz0Pc5oca5vOqA88C5rw7By6FnSmE5NaY0Os0gTwTuRvohQ7WHFeM0u4ettPBIPfthBMpSwDF50Z6MGTjBdycRmS01xTXuZtIxFzOwvv8SWEbH8)mmjUOKVknj50HMUf0hHvBdxLtUbj3PyFvMY8TqDlhnjIAxEhfxnQvISjlIonLcBovWsu2x3NneqntlJlPsjsZ3B6ztE4bfyUChAqnTUhhACZfyBcPyJuCWH0Sp8alm8m9aTY15z3fcBDc2oK5y0Cff8bWYoYJqjyybIrF6KE89lJ3SjJ39iacFoHz8pX6oPAReid7Bje6GtlGItxwkQp3AiDRKsan59Sq13sqSLgTPa387ogm(eitpd)catbC4t0cAZPRat1AoyfCoSTqGDTYeDWHT5zYMmCjYGIUAkxRw1pvttWqZ7irvFNPJGSoGjd7NsyDKyWKb7VwG(yVv7ywmWZXw27hEqojLRkNNi5WGUYQBznTs6PzD7ORcaxESJu90P5fJSssSNaq4ZgrgKCY2cCBxAca5mhmsGR6YqyDbnsm6G0kjYXmqafwMLKaeJLpQQScCkK8nlPplgqa7xNtpRlC6sYY1macKL)pvXaeHqaNaPqBDKdr(mfcO61VVrAwOWw(u5zz7bGlJcPytegsIIkggNE1fJmtoFLXSGSg63WLNPy23BFsyVAR2hMnN1WZvKQKsC)oeegiW1TH0Msr0wkwOV0bCVUInDCpxO177k2IXI(r(CvFDr4F4Pjz)9Gb2L7PmfsFpmFqVtS0zowAze5V7z6tJf0Igl4lRgZslhFeASX9oXIPOtASVdBkbMJUynSvDKWnKGG2Y4DOKcbvB3Yl9POe0ra2limhRFyrgIXt2XAKIy2ESAcscVCfyVE(wbrmOCd9gQxyDuvCwSDhCcnRV1opc6o3HNtHCYmmea2HrdgCGO2S7XbjQwdISVDYASj2aXPmSzPlGhcd0rvECwvbt(urXPYh0K7lIjPHr0L5ugEL((ZSbqN2pHOkeivQ7OXTMDNvG408YGcAdjfQmfy(tJrKcyZvdb0s0Oysj7WhKx9MKSfKeTl5BjvpHeHEFQSqix1HEmQMazrAgLV(YXJg0ZPx6EdO6lUhRJQAaHzEvXAfWkvPlWw3gY6PwtgjuvRpeUni8BGqumnaIeueJnaCmgIvqugpY2MHGymWgdfrjLRdlUJs3QLwvbZJTPXbohIWbeO7pcL(4r2iTjYCSzAvXGEg8xa3PiXqDOU2l6zhEEVtQBL1N3MvauK3ED1yVg2r1D7iKrFowQip9CapgDU(QXIkAEf4zAp5ttWGnjYOxowBDHRuNSDc8HNEIUJzTAOEcwCnr4twDnnQ3ILd2rHy2MojnnEDm)(yZ1AI4w8ZH4v2DGeqV80ZT68Q1MpB3aVZ5yzFFI2jUYXgi1k(oMKX(H75OI5NL0mWVveUaGgCkpqq4nZl911Xz57yWU882K9t8j8gXupVYCxYZXK0SQswlYXhdch(1QsOK5IIH69aVLRgpraROducKIBO4Ex5uScSsxuSlCV3dESHa8Mv88Sh(4jp(DQ58NdDJRoXX03BZPBj45sXsZHhg9vJTqxvRxFRBY)Wd(buklIXkWbOgbzuTzEsEvedEYC11eQfey75BOh52KQnoqs2dcBICwh12gYzVpWMwW3FuEQJSPf)Ma4JKBudrFoubt(cG(XMwUdOFS7H3bCankp7WaKJBInPVN0NQv9Bt9Z1h1m0LNnsSbG9t8AYahak8l)MWwEszyxSekbhf3Q676(aX8btTnplRzREwH4yBDAz)LtCTHLJC(ITfWkt8UDU3OJJbsIvU3oH6BJs9CjP2saC4OECMH2JwA213sZlGPx)mfp6NMD9DeMrUy21F8x(xF4p(WV9Z7MZEsI2npEZ2S8sXzK(c(k(c8mz49bF38Im8XBdF2X2qyTGBj)zLD4U3)NXPWqJbI92Suyzzd)IghU)RxWpMw1lvZNVaF0JyplQcQCXJKm7EFlYweVl5hMWD2JKREKubpy639V)NgK78NwYn5PLCVYGCcNvjTQ)7dMqDMV0DSoA)ttUQvpm5dp6H5JfyQWK9HVrNjUuj)A9dueqxtpWY0d2F6M(Mh4Q7A6DC1pAxznQy6bl7RRKinxXLFYrsJd2jPER(dZhXiw464nVL94Vus(8U5)Dod(NvKDZJIVngt)VBE2wkaFhxZ()4G2IrB3O3LP7XORo9x)0kmV(XjmUMEhfMXJoAxynYygi1r)VU62j6GYH51zM6SdPY1fQNevJjYGdMlo(Km1k3)GPlXjpP(rpA3C8rHb1vZUguHRZYzVNxVD21SRJV(xC0uWV9b27swncT3m76L5akAaO)SRT1fkjI359aEGVGnL5UB(vqKHEPU7M)Wd4R6JzHfS7fGuoFaJwU6sL9bLVurxoD38Bwcql5soijI6CMvcOmDkAoWgZwS9BDf7Y83LcKNBwmtCZ4IEMZfTVG2MD3IRH8wFyT6(eGp80PloLoP55m0E)Uy68b10uuIZU5GQmGtH(AgmL6H4kGrSP6YKoIt(gTuDfmO25CNANhPN0zJ0xqrV3W1CIZ10wNoAiJsV2qYCHtYCIWWUF30AiMXyibFLpc2j3HhPoJzQAyr9(8HC4RDYHT0iogd6SzCqylK6KDp1QoZ2YvpOJMZ1W0Q1FIS8p9vxPorjyTlDZJtnTo6XjeFGvS3UoqH9Qr1bTUKeLEXOAxvtjoE0rgmOErKoU32qTtwGGazvoxp2KrkgryjOLSPAdcvPnENEZQ6RZm1zeBX0xRPBy8lXCk8bC37q2TnXMDXrN5Aex1(DYer3PgFMfr)mpk3hU0P2CuM05ojSZUr6Bxg(6ewNIPJHfoIjmZS3SbGSTI2XfP3Hsv22xlmzk(ZbkQ2rueigYlVsnKqJb0diCNAUbJGv4nE2yxIe4LYn592opBBWp2Dc496OOmFPmiZOjM2tBe4ohM)LOV9vP25XPwZbwMa35aDXh(Hog0kGv)2bJ9clrhiwJfL48Low8x3xdNkT0XAV(Vg3Oz24mWsvqlvKorCi73c5Fdk0YtO5U2eqP9suQ61QDxwEd)Aug4hII84TC(4R372lk5jvuPLZYl6KLn(1EN(4BEcoTNX(cmiiK13zq0h1c66hJDXVrXIE()h)AalnwS0d79M8Ynu(mK96KDmOl2r5252Fg5o0188USM2Qs6PX35Wcv)M4voUZrU9Dw7II7IdvoEhoE5HRbK1bJBNsmy6qjA32b5iDUTcGrpe2R87r5Ji4gRVJWgLpU)7jSHVZZXB9STk0FAIjC0nn)X7wJw(g5DKwgXy9jhbLnrn1M9XJHeoWwNg8QPzRLFhA)V4kknGWOAvEJKAmMMvczRfdTZRo1l9vRVFIA0S1SoVe)0qXWJANdnls3eOC7CQhvAJc3rPA(73tFwJAXxqqUCuNMBpdqGtdGwrBMGV7uSPRYc7wyABXGpZVd4QU(EBxU0q4ON56wIZv6xLZ3oi(MiMTgBkRlv22Us(SyZ6q)znD7PRwmvVrR1Xk7CyZB7TllD9TyTtsY6DmE9W5hwIGAQBk4PrnmgY6Bmntxj7mORN9Y6DQDaRyG72E2E)vmcPbvFj(EwJfgkPAU(ltTMkqmFVnmX38fN4KOSuoT(AF8tbAPCDI0(LYt1O3xPdQYXP90Z5jk17l)r74UfT(7SSXXS8SDcrJv6c9(h1H74NVzpQd3hi1JutDyHf9(AFyh2JPCF6AorJ5EdqXXMkIQCBSVILKF)4S2ADTTB9sUHqpGZaHN3UaFmNjz3o(SwB))EhUH7w2EahxKwlm9ECrUtO2bXyp3oRyqBaoyEuhUte69uCmCa1F)Z(QKrFpKonPS)YFWiUtqFslhpMj406eoFn0OxO1fE3hVJ7Sx(pNK9Wf6odXJ84yEmN4JcKFBhdI7Kfh5XGiHVBbWz9S0s4BuP3x0pHqECTnQiV19IcehGT2xCJMDw6e0ZJEH3hxGwowKVKerzen6iRtDGFbXHv0lQuFNQVaeelqG95WUNT1(cLnQ4FmJSbGvupAlFlIAOuR3Pf0QYcWWCQw)CfTNKB8zlYL(fBhgxc8qBlGrL7o6(lB0ESKXx4OAxil15n1cGw35KVyK92xydw8axLwEjRD7AETwb7hms6T6X1r42k6UGhDKfKSY8CIVwsgjRC(jxYkg49)O5i6QtV2oGJ(TDOcsXVTMXEfVrOgkP)XU5kpB0sAu3FSDZ)X6Ui2M6EQMvPVsgj7sFqnymLhUA5638eukAwJBI5hHENyIVDmbw(Mo9mAcgVNjW8t)uhnbMrlb2QYrl(5l6hmQg(t(vIQL6LAR5V9nEyjS18mHnWxImE7Q42swr5yLzINwSbkl0X1X4gXwvoAkYRl483)4jS2NaThVtxv1XFi3K4En((tPcTK)XVQLImF8DM8m9hnx9p2vTuLPZpDuw7FUVVDvZUw9BsLhkRDJ1FLRMDTsRLB(GAPEV8V9v4nYWPlFl1Mz(al56FbqmQB6WpIHXAqEBs2O(VLgkU7kPd1Vd0w6F7kmaYF2uTZ1Z6Ujh0dEft(cSkFMC)(YNPgqt(SY9x1McODX7GE(LupHihNiz)o(uJjeV27oJ)0QdS(yj8v7Fevuv3EAjRT6jSKmX8FZs01DTMZXAMG66gQhs)Fwt0JTR)Vz)F]] )