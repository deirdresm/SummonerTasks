#  Notes about Models and Data Sources

## Model Files

* BestiaryMonster - source: swarfarm source
* Team - swarfarm feature, not currently exported (but we could do something local)
* TeamGroup - swarfarm feature, not currently exported (but we could do something local)
* LeaderSkill - source: swarfarm source
* FusionIngredients - source: swarfarm source
* Fusion - source: swarfarm source
* Summoner - source: SW-Exporter JSON file

## SW Exporter JSON File structure

* "wizard_info" - maps into Summoner
* "homunculus_skill_list"
* "unit_list" - maps into MonsterInstance
* "runes" - maps into RuneInstance
* "artifacts" - maps into ArtifactInstance
* "guildwar_defense_unit_list" - maps into Team/TeamGroup
* "guild_member_defense_list" - maps into Team/TeamGroup -- double-check?
* "guildsiege_defense_unit_list" - maps into Team/TeamGroup
* "raid_deck" - maps into Team/TeamGroup
* "deck_list" - maps into Team/TeamGroup
* "world_arena_rune_equip_list"
* "world_arena_artifact_equip_list"

ignored top-level: 

* "command"
* "ret_code"
* "scenario_list"
* "defense_unit_list"
* "quest_active"
* "quest_rewarded"
* "event_id_list"
* "building_list" - may add this later as it affects
* "deco_list"
* "obstacle_list"
* "mob_list"
* "mob_costume_equip_list"
* "mob_costume_part_list"
* "object_storage_list"
* "object_state"
* "summon_special_info"
* "island_info"
* "inventory_info"
* "inventory_open_info"
* "emoticon_favorites"
* "wish_list"
* "rune_craft_item_list"
* "artifact_crafts"
* "shop_info"
* "period_item_list"
* "notice_info"
* "guild"
* "guildwar_status"
* "guildwar_participation_info"
* "guildwar_member_list"
* "guildwar_ranking_info"
* "guildwar_ranking_stat"
* "guildwar_reserve"
* "guildwar_match_reserve"
* "guildwar_match_info"
* "guildwar_my_dead_unit_id_list"
* "my_atkdef_list"
* "my_attack_list"
* "opp_participation_info"
* "opp_guild_info"
* "opp_guild_member_list"
* "opp_defense_list"
* "guildwar_reward_list"
* "unit_depository_slots"
* "unit_lock_list"
* "rune_lock_list"
* "arena_shutdown_info"
* "invite_account"
* "invite_buddy"
* "invite_counter_list"
* "shop_daily_bonus_list"
* "deck_recent_list"
* "rtpvp_ban_unit_master_ids"
* "rtpvp_season_info"
* "rtpvp_contest_info"
* "rtpvp_contest_shop_display"
* "rtpvp_web_link_display"
* "object_storage_slots"
* "shop_bonus_event"
* "lobby_proud_unit_id_list"
* "quiz_reward_info"
* "new_user_buff"
* "inactive_user_buff"
* "summon_choices"
* "item_cart_prev_reset_timestamp"
* "item_cart_next_reset_timestamp"
* "unit_state"
* "beginner_summon_free"
* "world_arena_rune_equip_sync"
* "world_arena_artifact_equip_sync"
* "favorite_unit_id_list"
* "friend_list"
* "helper_list"
* "helper_remained"
* "mentor_helper_list"
* "mentee_slot_list"
* "mentoring_info"
* "npc_friend_list"
* "daily_reward_inactive_status"
* "daily_reward_new_user_status"
* "daily_reward_special_status"
* "daily_reward_list"
* "daily_reward_info"
* "daily_reward_unit_upgrade_info"
* "pvp_info"
* "pvp_reward_list"
* "worldboss_status"
* "worldboss_used_unit"
* "my_worldboss_ranking"
* "my_worldboss_prev_ranking"
* "my_worldboss_best_ranking"
* "my_worldboss_daily_battle_count"
* "world_boss_best_rank_id"
* "costume_ticket_purchased_list"
* "session_key"
* "raid_info_list"
* "trans_item_list"
* "guild_attend_info"
* "dimension_hole_info"
* "new_year_reward_info"
* "country"
* "tvaluelocal_next_monday"
* "wizard_id" - redundantly in the file a billion times, also in the filename
* "ts_val"
* "tvalue"
* "tvaluelocal"
* "tzone"
