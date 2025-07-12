BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "ai_card_actions" (
	"id"	INTEGER,
	"ai_card_id"	INTEGER NOT NULL,
	"step_number"	INTEGER NOT NULL,
	"action_type"	TEXT NOT NULL,
	"description"	TEXT,
	"parameters"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("ai_card_id") REFERENCES "ai_cards"("id")
);
CREATE TABLE IF NOT EXISTS "ai_cards" (
	"id"	INTEGER,
	"monster_id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"type"	TEXT NOT NULL,
	"subtype"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("monster_id") REFERENCES "monsters"("id")
);
CREATE TABLE IF NOT EXISTS "campaign_hunt_decks" (
	"id"	INTEGER,
	"campaign_id"	INTEGER NOT NULL,
	"hunt_event_id"	INTEGER NOT NULL,
	"quantity_available"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("campaign_id") REFERENCES "campaigns"("id"),
	FOREIGN KEY("hunt_event_id") REFERENCES "hunt_events"("id")
);
CREATE TABLE IF NOT EXISTS "campaign_terrain_deck" (
	"id"	INTEGER,
	"campaign_id"	INTEGER NOT NULL,
	"terrain_id"	INTEGER NOT NULL,
	"quantity_available"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("campaign_id") REFERENCES "campaigns"("id"),
	FOREIGN KEY("terrain_id") REFERENCES "terrain"("id")
);
CREATE TABLE IF NOT EXISTS "campaigns" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL,
	"current_year"	INTEGER DEFAULT 1,
	"created_at"	TEXT DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "disorders" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	"keywords"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "event_tables" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "fighting_arts" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"type"	TEXT NOT NULL,
	"description"	TEXT,
	"keywords"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "gear" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	"type"	TEXT,
	"location_id"	INTEGER,
	"innovation_id_req"	INTEGER,
	"max_build_count"	INTEGER,
	"activation_action"	TEXT,
	"weapon_speed"	INTEGER,
	"weapon_accuracy"	INTEGER,
	"weapon_strength"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("innovation_id_req") REFERENCES "innovations"("id"),
	FOREIGN KEY("location_id") REFERENCES "locations"("id")
);
CREATE TABLE IF NOT EXISTS "gear_affinities" (
	"id"	INTEGER,
	"gear_id"	INTEGER NOT NULL,
	"color"	TEXT NOT NULL,
	"direction"	TEXT NOT NULL,
	"is_puzzle_piece"	INTEGER DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("gear_id") REFERENCES "gear"("id")
);
CREATE TABLE IF NOT EXISTS "gear_grid_bonuses" (
	"id"	INTEGER,
	"gear_id"	INTEGER NOT NULL,
	"required_affinity_color"	TEXT NOT NULL,
	"required_affinity_count"	INTEGER NOT NULL,
	"bonus_description"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("gear_id") REFERENCES "gear"("id")
);
CREATE TABLE IF NOT EXISTS "gear_keywords" (
	"gear_id"	INTEGER NOT NULL,
	"keyword_id"	INTEGER NOT NULL,
	PRIMARY KEY("gear_id","keyword_id"),
	FOREIGN KEY("gear_id") REFERENCES "gear"("id"),
	FOREIGN KEY("keyword_id") REFERENCES "keywords"("id")
);
CREATE TABLE IF NOT EXISTS "gear_recipes" (
	"gear_id"	INTEGER NOT NULL,
	"resource_id"	INTEGER NOT NULL,
	"quantity"	INTEGER NOT NULL,
	PRIMARY KEY("gear_id","resource_id"),
	FOREIGN KEY("gear_id") REFERENCES "gear"("id"),
	FOREIGN KEY("resource_id") REFERENCES "resources"("id")
);
CREATE TABLE IF NOT EXISTS "hit_locations" (
	"id"	INTEGER,
	"monster_id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"is_trap"	INTEGER DEFAULT 0,
	"reaction_always"	TEXT,
	"reaction_on_failure"	TEXT,
	"reaction_on_success"	TEXT,
	"critical_wound_effect"	TEXT,
	"keywords"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("monster_id") REFERENCES "monsters"("id")
);
CREATE TABLE IF NOT EXISTS "hunt_board_layout" (
	"id"	INTEGER,
	"hunt_id"	INTEGER NOT NULL,
	"space_number"	INTEGER NOT NULL,
	"hunt_event_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("hunt_event_id") REFERENCES "hunt_events"("id"),
	FOREIGN KEY("hunt_id") REFERENCES "hunts"("id")
);
CREATE TABLE IF NOT EXISTS "hunt_events" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL,
	"type"	TEXT NOT NULL,
	"monster_id"	INTEGER,
	"description"	TEXT,
	"event_table_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("event_table_id") REFERENCES "event_tables"("id"),
	FOREIGN KEY("monster_id") REFERENCES "monsters"("id")
);
CREATE TABLE IF NOT EXISTS "hunt_participants" (
	"id"	INTEGER,
	"hunt_id"	INTEGER NOT NULL,
	"survivor_id"	INTEGER NOT NULL,
	"died_during_hunt"	INTEGER DEFAULT 0,
	"wounded_with_proficient_weapon"	INTEGER DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("hunt_id") REFERENCES "hunts"("id"),
	FOREIGN KEY("survivor_id") REFERENCES "survivors"("id")
);
CREATE TABLE IF NOT EXISTS "hunt_state" (
	"id"	INTEGER,
	"hunt_id"	INTEGER NOT NULL UNIQUE,
	"party_position"	INTEGER DEFAULT 0,
	"monster_position"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("hunt_id") REFERENCES "hunts"("id")
);
CREATE TABLE IF NOT EXISTS "hunts" (
	"id"	INTEGER,
	"campaign_id"	INTEGER NOT NULL,
	"monster_id"	INTEGER NOT NULL,
	"level"	INTEGER NOT NULL,
	"is_successful"	INTEGER,
	"lantern_year"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("campaign_id") REFERENCES "campaigns"("id"),
	FOREIGN KEY("monster_id") REFERENCES "monsters"("id")
);
CREATE TABLE IF NOT EXISTS "innovation_consequences" (
	"innovation_id"	INTEGER NOT NULL,
	"consequence_keyword"	TEXT NOT NULL,
	PRIMARY KEY("innovation_id","consequence_keyword"),
	FOREIGN KEY("innovation_id") REFERENCES "innovations"("id")
);
CREATE TABLE IF NOT EXISTS "innovations" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"type"	TEXT,
	"description"	TEXT,
	"benefit_description"	TEXT,
	"event_table_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("event_table_id") REFERENCES "event_tables"("id")
);
CREATE TABLE IF NOT EXISTS "keywords" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "locations" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	"event_table_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("event_table_id") REFERENCES "event_tables"("id")
);
CREATE TABLE IF NOT EXISTS "monster_levels" (
	"id"	INTEGER,
	"monster_id"	INTEGER NOT NULL,
	"level_name"	TEXT NOT NULL,
	"movement"	INTEGER,
	"toughness"	INTEGER,
	"damage_modifier"	INTEGER DEFAULT 0,
	"speed_modifier"	INTEGER DEFAULT 0,
	"ai_deck_basic_count"	INTEGER,
	"ai_deck_advanced_count"	INTEGER,
	"ai_deck_legendary_count"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("monster_id") REFERENCES "monsters"("id")
);
CREATE TABLE IF NOT EXISTS "monster_terrain_setup" (
	"monster_id"	INTEGER NOT NULL,
	"terrain_id"	INTEGER NOT NULL,
	"quantity"	INTEGER NOT NULL,
	PRIMARY KEY("monster_id","terrain_id"),
	FOREIGN KEY("monster_id") REFERENCES "monsters"("id"),
	FOREIGN KEY("terrain_id") REFERENCES "terrain"("id")
);
CREATE TABLE IF NOT EXISTS "monsters" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"is_nemesis"	INTEGER DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "resource_keywords" (
	"resource_id"	INTEGER NOT NULL,
	"keyword_id"	INTEGER NOT NULL,
	PRIMARY KEY("resource_id","keyword_id"),
	FOREIGN KEY("keyword_id") REFERENCES "keywords"("id"),
	FOREIGN KEY("resource_id") REFERENCES "resources"("id")
);
CREATE TABLE IF NOT EXISTS "resources" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"type"	TEXT,
	"monster_id"	INTEGER,
	"consumable_action"	TEXT,
	"event_table_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("event_table_id") REFERENCES "event_tables"("id"),
	FOREIGN KEY("monster_id") REFERENCES "monsters"("id")
);
CREATE TABLE IF NOT EXISTS "settlement_innovations" (
	"id"	INTEGER,
	"settlement_id"	INTEGER NOT NULL,
	"innovation_id"	INTEGER NOT NULL,
	"status"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("innovation_id") REFERENCES "innovations"("id"),
	FOREIGN KEY("settlement_id") REFERENCES "settlements"("id")
);
CREATE TABLE IF NOT EXISTS "settlement_locations" (
	"settlement_id"	INTEGER NOT NULL,
	"location_id"	INTEGER NOT NULL,
	"is_built"	INTEGER DEFAULT 0,
	PRIMARY KEY("settlement_id","location_id"),
	FOREIGN KEY("location_id") REFERENCES "locations"("id"),
	FOREIGN KEY("settlement_id") REFERENCES "settlements"("id")
);
CREATE TABLE IF NOT EXISTS "settlement_milestones" (
	"id"	INTEGER,
	"settlement_id"	INTEGER NOT NULL,
	"milestone_type"	TEXT NOT NULL,
	"is_achieved"	INTEGER DEFAULT 0,
	"principle_choice"	TEXT,
	"achieved_year"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("settlement_id") REFERENCES "settlements"("id")
);
CREATE TABLE IF NOT EXISTS "settlement_storage" (
	"id"	INTEGER,
	"settlement_id"	INTEGER NOT NULL,
	"resource_id"	INTEGER,
	"gear_id"	INTEGER,
	"quantity"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("gear_id") REFERENCES "gear"("id"),
	FOREIGN KEY("resource_id") REFERENCES "resources"("id"),
	FOREIGN KEY("settlement_id") REFERENCES "settlements"("id")
);
CREATE TABLE IF NOT EXISTS "settlement_weapon_masteries" (
	"id"	INTEGER,
	"settlement_id"	INTEGER NOT NULL,
	"weapon_type"	TEXT NOT NULL,
	"is_unlocked"	INTEGER DEFAULT 0,
	"unlocked_by_survivor_id"	INTEGER,
	"unlocked_year"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("settlement_id") REFERENCES "settlements"("id"),
	FOREIGN KEY("unlocked_by_survivor_id") REFERENCES "survivors"("id"),
	FOREIGN KEY("weapon_type") REFERENCES "weapon_masteries"("weapon_type")
);
CREATE TABLE IF NOT EXISTS "settlements" (
	"id"	INTEGER,
	"campaign_id"	INTEGER NOT NULL,
	"name"	TEXT,
	"population"	INTEGER DEFAULT 0,
	"death_count"	INTEGER DEFAULT 0,
	"survival_limit"	INTEGER DEFAULT 3,
	"endeavors"	INTEGER DEFAULT 1,
	"departure_bonus"	TEXT,
	"return_bonus"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("campaign_id") REFERENCES "campaigns"("id")
);
CREATE TABLE IF NOT EXISTS "severe_injuries" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"hit_location"	TEXT,
	"description"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "showdown_ai_deck" (
	"id"	INTEGER,
	"hunt_id"	INTEGER NOT NULL,
	"ai_card_id"	INTEGER NOT NULL,
	"deck_position"	INTEGER,
	"status"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("ai_card_id") REFERENCES "ai_cards"("id"),
	FOREIGN KEY("hunt_id") REFERENCES "hunts"("id")
);
CREATE TABLE IF NOT EXISTS "showdown_board_state" (
	"id"	INTEGER,
	"hunt_id"	INTEGER NOT NULL,
	"entity_type"	TEXT NOT NULL,
	"entity_id"	INTEGER NOT NULL,
	"x_coord"	INTEGER,
	"y_coord"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("hunt_id") REFERENCES "hunts"("id")
);
CREATE TABLE IF NOT EXISTS "showdown_hit_location_deck" (
	"id"	INTEGER,
	"hunt_id"	INTEGER NOT NULL,
	"hit_location_id"	INTEGER NOT NULL,
	"is_drawn"	INTEGER DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("hit_location_id") REFERENCES "hit_locations"("id"),
	FOREIGN KEY("hunt_id") REFERENCES "hunts"("id")
);
CREATE TABLE IF NOT EXISTS "showdown_persistent_injuries" (
	"id"	INTEGER,
	"hunt_id"	INTEGER NOT NULL,
	"injury_description"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("hunt_id") REFERENCES "hunts"("id")
);
CREATE TABLE IF NOT EXISTS "survivor_disorders" (
	"survivor_id"	INTEGER NOT NULL,
	"disorder_id"	INTEGER NOT NULL,
	PRIMARY KEY("survivor_id","disorder_id"),
	FOREIGN KEY("disorder_id") REFERENCES "disorders"("id"),
	FOREIGN KEY("survivor_id") REFERENCES "survivors"("id")
);
CREATE TABLE IF NOT EXISTS "survivor_fighting_arts" (
	"survivor_id"	INTEGER NOT NULL,
	"fighting_art_id"	INTEGER NOT NULL,
	PRIMARY KEY("survivor_id","fighting_art_id"),
	FOREIGN KEY("fighting_art_id") REFERENCES "fighting_arts"("id"),
	FOREIGN KEY("survivor_id") REFERENCES "survivors"("id")
);
CREATE TABLE IF NOT EXISTS "survivor_gear_grid" (
	"id"	INTEGER,
	"survivor_id"	INTEGER NOT NULL,
	"gear_id"	INTEGER NOT NULL,
	"grid_x"	INTEGER NOT NULL,
	"grid_y"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("gear_id") REFERENCES "gear"("id"),
	FOREIGN KEY("survivor_id") REFERENCES "survivors"("id")
);
CREATE TABLE IF NOT EXISTS "survivor_resources" (
	"id"	INTEGER,
	"survivor_id"	INTEGER NOT NULL,
	"resource_id"	INTEGER NOT NULL,
	"quantity"	INTEGER DEFAULT 1,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("resource_id") REFERENCES "resources"("id"),
	FOREIGN KEY("survivor_id") REFERENCES "survivors"("id")
);
CREATE TABLE IF NOT EXISTS "survivor_severe_injuries" (
	"survivor_id"	INTEGER NOT NULL,
	"severe_injury_id"	INTEGER NOT NULL,
	PRIMARY KEY("survivor_id","severe_injury_id"),
	FOREIGN KEY("severe_injury_id") REFERENCES "severe_injuries"("id"),
	FOREIGN KEY("survivor_id") REFERENCES "survivors"("id")
);
CREATE TABLE IF NOT EXISTS "survivors" (
	"id"	INTEGER,
	"settlement_id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"gender"	TEXT,
	"status"	TEXT DEFAULT 'Active',
	"survival"	INTEGER DEFAULT 0,
	"insanity"	INTEGER DEFAULT 0,
	"hunt_xp"	INTEGER DEFAULT 0,
	"courage"	INTEGER DEFAULT 0,
	"understanding"	INTEGER DEFAULT 0,
	"once_in_a_lifetime_reroll"	INTEGER DEFAULT 1,
	"impairments"	TEXT,
	"weapon_proficiency_type"	TEXT,
	"weapon_proficiency_level"	INTEGER DEFAULT 0,
	"movement"	INTEGER DEFAULT 5,
	"accuracy"	INTEGER DEFAULT 0,
	"strength"	INTEGER DEFAULT 0,
	"evasion"	INTEGER DEFAULT 0,
	"luck"	INTEGER DEFAULT 0,
	"speed"	INTEGER DEFAULT 0,
	"armor_head"	INTEGER DEFAULT 0,
	"armor_arms"	INTEGER DEFAULT 0,
	"armor_body"	INTEGER DEFAULT 0,
	"armor_waist"	INTEGER DEFAULT 0,
	"armor_legs"	INTEGER DEFAULT 0,
	"injury_status_brain"	TEXT DEFAULT 'Normal',
	"injury_status_head"	TEXT DEFAULT 'Normal',
	"injury_status_arms"	TEXT DEFAULT 'Normal',
	"injury_status_body"	TEXT DEFAULT 'Normal',
	"injury_status_waist"	TEXT DEFAULT 'Normal',
	"injury_status_legs"	TEXT DEFAULT 'Normal',
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("settlement_id") REFERENCES "settlements"("id")
);
CREATE TABLE IF NOT EXISTS "table_outcomes" (
	"id"	INTEGER,
	"event_table_id"	INTEGER NOT NULL,
	"min_roll"	INTEGER,
	"max_roll"	INTEGER,
	"outcome_description"	TEXT,
	"outcome_keywords"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("event_table_id") REFERENCES "event_tables"("id")
);
CREATE TABLE IF NOT EXISTS "terrain" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"placement_rules"	TEXT,
	"total_in_deck"	INTEGER,
	"event_table_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("event_table_id") REFERENCES "event_tables"("id")
);
CREATE TABLE IF NOT EXISTS "timeline" (
	"id"	INTEGER,
	"campaign_id"	INTEGER NOT NULL,
	"lantern_year"	INTEGER NOT NULL,
	"story_event"	TEXT,
	"settlement_event"	TEXT,
	"status"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("campaign_id") REFERENCES "campaigns"("id")
);
CREATE TABLE IF NOT EXISTS "weapon_masteries" (
	"weapon_type"	TEXT,
	"mastery_bonus_description"	TEXT NOT NULL,
	PRIMARY KEY("weapon_type")
);
CREATE TABLE IF NOT EXISTS "weapon_proficiency_milestones" (
	"id"	INTEGER,
	"weapon_type"	TEXT NOT NULL,
	"level"	INTEGER NOT NULL,
	"bonus_description"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "keywords" VALUES (1,'Amber','A gear keyword. This gear is substantively crafter of amber.');
INSERT INTO "keywords" VALUES (2,'Ammunition','A gear keyword. This gear is ammunition for another weapon gear. ');
INSERT INTO "keywords" VALUES (3,'Armor','Gear with this keyword is armor. Protects the survivor from injury. Each piece of armor will have the hit location symbol for the hit location it can be worn on. Each hit location may only wear one piece of armor. ');
INSERT INTO "keywords" VALUES (4,'Arrow','A gear keyword. This gear card is an arrow. Although arrows require a bow to be in your gear grid to be activated, arrows and bows are distinct weapons. Arrows do not inherit the qualities of bows they are fired from (cumbersome, cursed, etc). Wounding with an arrow does not make a survivor eligible to earn bow proficiency');
INSERT INTO "keywords" VALUES (5,'Axe','Gear with this keyword is an axe weapon. Survivors may gain levels of axe weapon proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (6,'Badge','A gear keyword. Used to describe badge items acquired by defeating "Knight" monsters like the Dung Beetle Knight, Flower Knight and Lion Knight. ');
INSERT INTO "keywords" VALUES (7,'Balm','A gear keyword. Balm items work by rubbing them on a survivor''s skin. ');
INSERT INTO "keywords" VALUES (8,'Bone','A gear keyword. Bone is one of the primary materials used to craft this gear. Can also be a resource keyword.');
INSERT INTO "keywords" VALUES (9,'Bow','Gear with this keyword is a bow weapon. Survivors may gain levels of bow weapon proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (10,'Cloth','A gear keyword. An item made predominately of cloth. ');
INSERT INTO "keywords" VALUES (11,'Club','Gear with this keyword is a club weapon. Survivors may gain levels of club weapon proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (12,'Consumable','A keyword. This may be consumed by survivors. ');
INSERT INTO "keywords" VALUES (13,'Dagger','Gear with this keyword is a dagger weapon. Survivors may gain levels of dagger weapon proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (14,'Feather','A gear keyword. This gear is substantively crafted of feathers. ');
INSERT INTO "keywords" VALUES (15,'Finesse','A gear keyword. This gear requires finesse to use.');
INSERT INTO "keywords" VALUES (16,'Fish','A resource keyword. These items are strange fish-like creatures. ');
INSERT INTO "keywords" VALUES (17,'Flammable','A gear keyword. Fire can destroy this gear. ');
INSERT INTO "keywords" VALUES (18,'Flower','A resource keyword. This resource is a flower. ');
INSERT INTO "keywords" VALUES (19,'Fragile','A gear keyword. This gear is easily broken. ');
INSERT INTO "keywords" VALUES (20,'Fur','A gear keyword. This gear is substantively crafted of thick fur. ');
INSERT INTO "keywords" VALUES (21,'Gloomy','A gear keyword. Gloomy gear contains the essence of the Dark Place. ');
INSERT INTO "keywords" VALUES (22,'Gormskin','A gear keyword. This gear is crafted at the Gormery Settlement Location. ');
INSERT INTO "keywords" VALUES (23,'Grand','Gear with this keyword is a grand weapon. Survivors may gain levels of Grand Weapon Proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (24,'Gun','A gear keyword. Items with this keyword are gun weapons. ');
INSERT INTO "keywords" VALUES (25,'Heavy','A gear keyword. This gear has substantial weight. ');
INSERT INTO "keywords" VALUES (26,'Herb','A gear keyword. An item primarily made of herbs. ');
INSERT INTO "keywords" VALUES (27,'Hide','A common resource keyword. ');
INSERT INTO "keywords" VALUES (28,'Instrument','A gear keyword. This gear can be used to play music. ');
INSERT INTO "keywords" VALUES (29,'Iron','A common resource keyword. ');
INSERT INTO "keywords" VALUES (30,'Item','A gear keyword. Gear that is neither a weapon nor armor. ');
INSERT INTO "keywords" VALUES (31,'Ivory','A gear keyword. An item made predominately out of ivory. ');
INSERT INTO "keywords" VALUES (32,'Jewelry','A gear keyword. Decorative and functional! ');
INSERT INTO "keywords" VALUES (33,'Katana','Gear with this keyword is a katana weapon. Unlike other weapons types, Katana cannot simply be nominated to gain levels of weapon proficiency. ');
INSERT INTO "keywords" VALUES (34,'Katar','Gear with this keyword is a katar weapon. Survivors may gain levels of katar weapon proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (35,'Knight','A gear keyword. This keyword is found on the various badges obtained from Knight monsters (Dung Beetle Knight. Flower Knight, Lion Knight). ');
INSERT INTO "keywords" VALUES (36,'Lantern','A gear keyword. A lantern illuminates the darkness. ');
INSERT INTO "keywords" VALUES (37,'Leather','A gear keyword. Cured hides are a crucial component of this gear. ');
INSERT INTO "keywords" VALUES (38,'Mask','A gear keyword. An item that is worn over a survivor''s face. ');
INSERT INTO "keywords" VALUES (39,'Melee','A weapon gear keyword. To attack with a melee weapon, survivors must be in a space adjacent to the monster. Melee weapons with reach can attack from further away. ');
INSERT INTO "keywords" VALUES (40,'Metal','A gear keyword. This gear is substantively crafted of metal. ');
INSERT INTO "keywords" VALUES (41,'Mineral','A gear keyword. Items with this keyword are composed of minerals. ');
INSERT INTO "keywords" VALUES (42,'Noisy','A gear keyword. This gear is hard to keep quiet. ');
INSERT INTO "keywords" VALUES (43,'Nuclear','A gear keyword. This gear is highly radioactive. ');
INSERT INTO "keywords" VALUES (44,'Order','A gear keyword. This gear originates from the order of the Twilight Knights. ');
INSERT INTO "keywords" VALUES (45,'Organ','A common resource keyword. ');
INSERT INTO "keywords" VALUES (46,'Other','A gear keyword. The effects of this gear are otherworldly. ');
INSERT INTO "keywords" VALUES (47,'Perfect','A resource keyword. ');
INSERT INTO "keywords" VALUES (48,'Pickaxe','A gear keyword. In certain situations, this can be used to mine minerals. ');
INSERT INTO "keywords" VALUES (49,'Ranged','A gear keyword. A ranged weapon, like a bow or dart, allows survivors to attack from a distance. ');
INSERT INTO "keywords" VALUES (50,'Rawhide','A gear keyword. This gear is crafted of uncured hides. ');
INSERT INTO "keywords" VALUES (51,'Scale','A gear keyword. This gear is predominantly composed of Sunstalker scales. ');
INSERT INTO "keywords" VALUES (52,'Scimitar','Gear with this keyword are scimitar weapons. Currently survivors can not gain levels of weapon proficiency with scimitars. ');
INSERT INTO "keywords" VALUES (53,'Scrap','A common resource keyword. ');
INSERT INTO "keywords" VALUES (54,'Scythe','Gear with this keyword is an scythe weapon. Survivors may gain levels of scythe weapon proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (55,'Set','A gear keyword listed on some armor cards. This means this armor is part of an armor set. ');
INSERT INTO "keywords" VALUES (56,'Shield','Gear with this keyword is a shield weapon. Survivors may gain levels of shield weapon proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (57,'Sickle','A gear keyword. In certain situations, this can be used to harvest herbs. ');
INSERT INTO "keywords" VALUES (58,'Silk','A gear keyword. Silk is one of the materials used to craft this gear. ');
INSERT INTO "keywords" VALUES (59,'Soluble','A gear keyword. Able to be dissolved in liquid. ');
INSERT INTO "keywords" VALUES (60,'Spear','Gear with this keyword is a spear weapon. Survivors may gain levels of spear weapon proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (61,'Steel','A gear keyword. An item made predominately of steel. ');
INSERT INTO "keywords" VALUES (62,'Stinky','A gear keyword. This item has a strong odor. ');
INSERT INTO "keywords" VALUES (63,'Stone','A gear keyword. An item made predominately from stone. ');
INSERT INTO "keywords" VALUES (64,'Sword','Gear with this keyword is a sword weapon. Survivors may gain levels of sword weapon proficiency with this weapon. ');
INSERT INTO "keywords" VALUES (65,'Symbol','A gear keyword. Symbolically important. ');
INSERT INTO "keywords" VALUES (66,'Tool','A gear keyword. Some tools trigger story events or grant bonuses. ');
INSERT INTO "keywords" VALUES (67,'Two-Handed','A gear keyword. This weapon requires two hands to use. Some gear and rules do not work with two-handed weapons. ');
INSERT INTO "keywords" VALUES (68,'Vegetable','A gear keyword. This item is a vegetable. ');
INSERT INTO "keywords" VALUES (69,'Weapon','A type of gear card. Weapon types in the core game include axe, bow, club, dagger, fist & tooth, grand, katar, shield, spear, sword, and whip. New weapon types included in expansion content include scimitar, and scythe. ');
INSERT INTO "keywords" VALUES (70,'Whip','Gear with this keyword is a whip weapon. Survivors may gain levels of whip weapon proficiency with this weapon. ');
COMMIT;
