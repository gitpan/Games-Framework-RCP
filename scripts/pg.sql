--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: rcp; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE rcp IS 'The makings of a system similar to what Neo-Kamek, H_Cuz, and Kafei have.';


--
-- Name: battle; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA battle;


--
-- Name: SCHEMA battle; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA battle IS 'The schema that keeps up with who is fighting what.  This schema will be updated the most.';


--
-- Name: characters; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA characters;


--
-- Name: SCHEMA characters; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA characters IS 'Listing of every creature in use.';


--
-- Name: data; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA data;


--
-- Name: SCHEMA data; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA data IS 'Classes, moves, etc.';


--
-- Name: messages; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA messages;


--
-- Name: SCHEMA messages; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA messages IS 'Various messages and categories of messages explaining various things.';


--
-- Name: utilities; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA utilities;


--
-- Name: SCHEMA utilities; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA utilities IS 'Some utility functions.';


SET search_path = battle, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: combatants; Type: TABLE; Schema: battle; Owner: -; Tablespace: 
--

CREATE TABLE combatants (
    join_time timestamp without time zone DEFAULT now() NOT NULL,
    fkey_character bigint NOT NULL,
    fkey_job integer NOT NULL,
    secondary character varying(32) DEFAULT NULL::character varying,
    aux character varying(32) DEFAULT NULL::character varying,
    ct numeric(12,4) DEFAULT ((random() * (500)::double precision))::integer NOT NULL,
    id_fighter bigint DEFAULT 1 NOT NULL,
    hp numeric(12,4) DEFAULT 50 NOT NULL,
    mp numeric(12,4) DEFAULT 50 NOT NULL,
    pp numeric(12,4) DEFAULT 50 NOT NULL,
    spd numeric(12,4) DEFAULT 50 NOT NULL,
    patk numeric(12,4) DEFAULT 50 NOT NULL,
    matk numeric(12,4) DEFAULT 50 NOT NULL,
    pdef numeric(12,4) DEFAULT 50 NOT NULL,
    mdef numeric(12,4) DEFAULT 50 NOT NULL,
    pacc numeric(12,4) DEFAULT 50 NOT NULL,
    macc numeric(12,4) DEFAULT 50 NOT NULL,
    pevd numeric(12,4) DEFAULT 50 NOT NULL,
    mevd numeric(12,4) DEFAULT 50 NOT NULL,
    max_hp numeric(12,4) DEFAULT 50 NOT NULL,
    max_mp numeric(12,4) DEFAULT 50 NOT NULL,
    max_pp numeric(12,4) DEFAULT 50 NOT NULL,
    starting_job integer DEFAULT 1 NOT NULL
);


--
-- Name: TABLE combatants; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON TABLE combatants IS 'The lineup of fighters.';


--
-- Name: COLUMN combatants.join_time; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.join_time IS 'What time did the fighter join?';


--
-- Name: COLUMN combatants.fkey_character; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.fkey_character IS 'The character that is fighting.';


--
-- Name: COLUMN combatants.fkey_job; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.fkey_job IS 'The job the character is fighting with.';


--
-- Name: COLUMN combatants.secondary; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.secondary IS 'secondary skillset';


--
-- Name: COLUMN combatants.aux; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.aux IS 'auxillary skill';


--
-- Name: COLUMN combatants.ct; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.ct IS 'CT.  randomized at the start.';


--
-- Name: COLUMN combatants.id_fighter; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.id_fighter IS 'ID of the fighter.';


--
-- Name: COLUMN combatants.hp; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.hp IS 'HP of the fighter.';


--
-- Name: COLUMN combatants.mp; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.mp IS 'MP of the fighter.';


--
-- Name: COLUMN combatants.pp; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.pp IS 'PP of the fighter.';


--
-- Name: COLUMN combatants.spd; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.spd IS 'Speed of the fighter.';


--
-- Name: COLUMN combatants.patk; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.patk IS 'Physical Attack';


--
-- Name: COLUMN combatants.matk; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.matk IS 'Magical Attack';


--
-- Name: COLUMN combatants.pdef; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.pdef IS 'Physical Defense';


--
-- Name: COLUMN combatants.mdef; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.mdef IS 'Magical Defense';


--
-- Name: COLUMN combatants.pacc; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.pacc IS 'Physical Accuracy';


--
-- Name: COLUMN combatants.macc; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.macc IS 'Magical Accuracy';


--
-- Name: COLUMN combatants.pevd; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.pevd IS 'Physical Evade';


--
-- Name: COLUMN combatants.mevd; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.mevd IS 'Magical Evade';


--
-- Name: COLUMN combatants.max_hp; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.max_hp IS 'Max HP';


--
-- Name: COLUMN combatants.max_mp; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.max_mp IS 'Max MP';


--
-- Name: COLUMN combatants.max_pp; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.max_pp IS 'Max PP';


--
-- Name: COLUMN combatants.starting_job; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN combatants.starting_job IS 'The job the fighter starts with.  Used for rewards and such.';


SET search_path = characters, pg_catalog;

--
-- Name: characters; Type: TABLE; Schema: characters; Owner: -; Tablespace: 
--

CREATE TABLE characters (
    id_character bigint NOT NULL,
    name character varying(32) NOT NULL,
    color smallint NOT NULL
);


--
-- Name: TABLE characters; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON TABLE characters IS 'Catch-all of all characters.';


--
-- Name: COLUMN characters.id_character; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN characters.id_character IS 'ID of the character.';


--
-- Name: COLUMN characters.name; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN characters.name IS 'Name of the character.';


--
-- Name: COLUMN characters.color; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN characters.color IS 'Colors of the character.';


SET search_path = utilities, pg_catalog;

--
-- Name: colors; Type: TABLE; Schema: utilities; Owner: -; Tablespace: 
--

CREATE TABLE colors (
    id_color smallint NOT NULL,
    fg smallint NOT NULL,
    bg smallint NOT NULL
);


--
-- Name: TABLE colors; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON TABLE colors IS 'IRC color values.';


--
-- Name: COLUMN colors.id_color; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN colors.id_color IS 'ID of the color.';


--
-- Name: COLUMN colors.fg; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN colors.fg IS 'FG color.';


--
-- Name: COLUMN colors.bg; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN colors.bg IS 'BG color.';


SET search_path = battle, pg_catalog;

--
-- Name: ct_desc; Type: VIEW; Schema: battle; Owner: -
--

CREATE VIEW ct_desc AS
    SELECT combatants.fkey_character, characters.name, to_char((colors.fg)::double precision, 'FM00'::text) AS fg, to_char((colors.bg)::double precision, 'FM00'::text) AS bg, rtrim(to_char(combatants.ct, 'FM99999999.9999'::text), '.'::text) AS ct, combatants.id_fighter FROM ((combatants JOIN characters.characters ON ((combatants.fkey_character = characters.id_character))) JOIN utilities.colors ON ((characters.color = colors.id_color))) ORDER BY combatants.ct DESC, combatants.join_time DESC;


--
-- Name: VIEW ct_desc; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON VIEW ct_desc IS 'View basic turn order on the current tick.';


--
-- Name: fighter_status; Type: TABLE; Schema: battle; Owner: -; Tablespace: 
--

CREATE TABLE fighter_status (
    fkey_combatant integer NOT NULL,
    fkey_status integer NOT NULL,
    length numeric(12,4) DEFAULT 21 NOT NULL
);


--
-- Name: TABLE fighter_status; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON TABLE fighter_status IS 'What status effects do the fighters have?';


--
-- Name: COLUMN fighter_status.fkey_combatant; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN fighter_status.fkey_combatant IS 'The fighter.';


--
-- Name: COLUMN fighter_status.fkey_status; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN fighter_status.fkey_status IS 'The status effect.';


--
-- Name: COLUMN fighter_status.length; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN fighter_status.length IS 'The length.  If -10K or less: indefinite. If 10K or more: permament.';


SET search_path = data, pg_catalog;

--
-- Name: classes; Type: TABLE; Schema: data; Owner: -; Tablespace: 
--

CREATE TABLE classes (
    id_job integer NOT NULL,
    name character varying(32) NOT NULL,
    "desc" character varying(256) DEFAULT 'Fill me in with something!'::character varying NOT NULL,
    kind integer DEFAULT 1 NOT NULL,
    hp numeric(12,4) DEFAULT 50 NOT NULL,
    mp numeric(12,4) DEFAULT 50 NOT NULL,
    pp numeric(12,4) DEFAULT 50 NOT NULL,
    spd numeric(12,4) DEFAULT 50 NOT NULL,
    patk numeric(12,4) DEFAULT 50 NOT NULL,
    matk numeric(12,4) DEFAULT 50 NOT NULL,
    pdef numeric(12,4) DEFAULT 50 NOT NULL,
    mdef numeric(12,4) DEFAULT 50 NOT NULL,
    pacc numeric(12,4) DEFAULT 50 NOT NULL,
    macc numeric(12,4) DEFAULT 50 NOT NULL,
    pevd numeric(12,4) DEFAULT 50 NOT NULL,
    mevd numeric(12,4) DEFAULT 50 NOT NULL
);


--
-- Name: TABLE classes; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON TABLE classes IS 'The list of the various classes.';


--
-- Name: COLUMN classes.id_job; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.id_job IS 'ID of the job.';


--
-- Name: COLUMN classes.name; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.name IS 'Name of the job.';


--
-- Name: COLUMN classes."desc"; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes."desc" IS 'Description of the job.';


--
-- Name: COLUMN classes.kind; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.kind IS 'Kind of job.  1 = normal.';


--
-- Name: COLUMN classes.hp; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.hp IS 'HP of the job.';


--
-- Name: COLUMN classes.mp; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.mp IS 'MP of the job.';


--
-- Name: COLUMN classes.pp; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.pp IS 'PP of the job.';


--
-- Name: COLUMN classes.spd; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.spd IS 'Speed of the job.';


--
-- Name: COLUMN classes.patk; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.patk IS 'Physical Attack';


--
-- Name: COLUMN classes.matk; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.matk IS 'Magical Attack';


--
-- Name: COLUMN classes.pdef; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.pdef IS 'Physical Defense';


--
-- Name: COLUMN classes.mdef; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.mdef IS 'Magical Defense';


--
-- Name: COLUMN classes.pacc; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.pacc IS 'Physical Accuracy';


--
-- Name: COLUMN classes.macc; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.macc IS 'Magical Accuracy';


--
-- Name: COLUMN classes.pevd; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.pevd IS 'Physical Evade';


--
-- Name: COLUMN classes.mevd; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN classes.mevd IS 'Magical Evade';


SET search_path = battle, pg_catalog;

--
-- Name: quick_hp_stats; Type: VIEW; Schema: battle; Owner: -
--

CREATE VIEW quick_hp_stats AS
    SELECT characters.name, to_char((colors.fg)::double precision, 'FM00'::text) AS fg, to_char((colors.bg)::double precision, 'FM00'::text) AS bg, classes.name AS "primary", combatants.secondary, combatants.aux, ((rtrim(to_char(combatants.hp, 'FM99999999.9999'::text), '.'::text) || '/'::text) || rtrim(to_char(combatants.max_hp, 'FM99999999.9999'::text), '.'::text)) AS hp, ((rtrim(to_char(combatants.mp, 'FM99999999.9999'::text), '.'::text) || '/'::text) || rtrim(to_char(combatants.max_mp, 'FM99999999.9999'::text), '.'::text)) AS mp, ((rtrim(to_char(combatants.pp, 'FM99999999.9999'::text), '.'::text) || '/'::text) || rtrim(to_char(combatants.max_pp, 'FM99999999.9999'::text), '.'::text)) AS pp, rtrim(to_char(combatants.ct, 'FM99999999.9999'::text), '.'::text) AS ct FROM (((combatants JOIN characters.characters ON ((combatants.fkey_character = characters.id_character))) JOIN data.classes ON ((combatants.fkey_job = classes.id_job))) JOIN utilities.colors ON ((characters.color = colors.id_color))) ORDER BY combatants.join_time;


--
-- Name: VIEW quick_hp_stats; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON VIEW quick_hp_stats IS 'Quick look at our fighters.

May be useful for showing stats on their turn.';


SET search_path = data, pg_catalog;

--
-- Name: status_effects; Type: TABLE; Schema: data; Owner: -; Tablespace: 
--

CREATE TABLE status_effects (
    id_status integer NOT NULL,
    name character varying(32) NOT NULL,
    "desc" character varying(100) NOT NULL,
    is_good boolean,
    is_secret boolean DEFAULT false NOT NULL
);


--
-- Name: TABLE status_effects; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON TABLE status_effects IS 'List of status effects.';


--
-- Name: COLUMN status_effects.id_status; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN status_effects.id_status IS 'ID of the status effect.';


--
-- Name: COLUMN status_effects.name; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN status_effects.name IS 'Name of the status effect.';


--
-- Name: COLUMN status_effects."desc"; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN status_effects."desc" IS 'Description of the status effect.';


--
-- Name: COLUMN status_effects.is_good; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN status_effects.is_good IS 'NULL = neutral effect.';


--
-- Name: COLUMN status_effects.is_secret; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN status_effects.is_secret IS 'Is this status effect traditionally hidden from players?';


SET search_path = battle, pg_catalog;

--
-- Name: status_inflicted; Type: VIEW; Schema: battle; Owner: -
--

CREATE VIEW status_inflicted AS
    SELECT fs.fkey_combatant AS fighter, rtrim(to_char(bc.hp, 'FM99999999.9999'::text), '.'::text) AS hp, rtrim(to_char(bc.max_hp, 'FM99999999.9999'::text), '.'::text) AS max_hp, cc.name, to_char((colors.fg)::double precision, 'FM00'::text) AS fg, to_char((colors.bg)::double precision, 'FM00'::text) AS bg, se.id_status AS status_id, se.name AS effect, CASE WHEN (fs.length <= ((-10000))::numeric) THEN '???'::text WHEN (fs.length >= (10000)::numeric) THEN '*'::text ELSE rtrim(to_char(fs.length, 'FM99999999.9999'::text), '.'::text) END AS length FROM ((((characters.characters cc JOIN combatants bc ON ((cc.id_character = bc.fkey_character))) JOIN utilities.colors ON ((cc.color = colors.id_color))) JOIN fighter_status fs ON ((bc.id_fighter = fs.fkey_combatant))) JOIN data.status_effects se ON ((fs.fkey_status = se.id_status)));


--
-- Name: VIEW status_inflicted; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON VIEW status_inflicted IS 'View status effects each fighter has.

??? is indefinite length.

* is permament (can be removed by force if required).';


--
-- Name: COLUMN status_inflicted.length; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON COLUMN status_inflicted.length IS '??? = Indefinite.  * = Permament.  GMs can ignore as required.';


--
-- Name: turn_order_min; Type: VIEW; Schema: battle; Owner: -
--

CREATE VIEW turn_order_min AS
    SELECT cc.name, to_char((colors.fg)::double precision, 'FM00'::text) AS fg, to_char((colors.bg)::double precision, 'FM00'::text) AS bg, dc.name AS job, bc.id_fighter, rtrim(to_char(bc.hp, 'FM99999999.9999'::text), '.'::text) AS hp, rtrim(to_char(bc.max_hp, 'FM99999999.9999'::text), '.'::text) AS max_hp, rtrim(to_char(bc.mp, 'FM99999999.9999'::text), '.'::text) AS mp, rtrim(to_char(bc.max_mp, 'FM99999999.9999'::text), '.'::text) AS max_mp, rtrim(to_char(bc.ct, 'FM99999999.9999'::text), '.'::text) AS ct, rtrim(to_char(bc.spd, 'FM99999999.9999'::text), '.'::text) AS spd FROM (((characters.characters cc JOIN utilities.colors ON ((cc.color = colors.id_color))) JOIN combatants bc ON ((cc.id_character = bc.fkey_character))) JOIN data.classes dc ON ((bc.fkey_job = dc.id_job))) ORDER BY bc.ct DESC, bc.spd DESC, bc.join_time;


--
-- Name: VIEW turn_order_min; Type: COMMENT; Schema: battle; Owner: -
--

COMMENT ON VIEW turn_order_min IS 'Another view of turn order.';


SET search_path = characters, pg_catalog;

--
-- Name: callscript; Type: TABLE; Schema: characters; Owner: -; Tablespace: 
--

CREATE TABLE callscript (
    id_callscript bigint NOT NULL,
    fkey_character bigint NOT NULL,
    is_male boolean DEFAULT true,
    is_good boolean DEFAULT true,
    is_lawful boolean DEFAULT true,
    "desc" character varying(300) DEFAULT 'This is what this guy is about.'::character varying NOT NULL
);


--
-- Name: TABLE callscript; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON TABLE callscript IS 'Collection of call script characters.';


--
-- Name: COLUMN callscript.id_callscript; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN callscript.id_callscript IS 'ID of the callscriptee.';


--
-- Name: COLUMN callscript.fkey_character; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN callscript.fkey_character IS 'The character ID.';


--
-- Name: COLUMN callscript.is_male; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN callscript.is_male IS 'NULL = no gender.';


--
-- Name: COLUMN callscript.is_good; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN callscript.is_good IS 'NULL = in the middle.';


--
-- Name: COLUMN callscript.is_lawful; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN callscript.is_lawful IS 'NULL = in the middle.';


--
-- Name: COLUMN callscript."desc"; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN callscript."desc" IS 'Description/flavor text.';


--
-- Name: char_exp; Type: TABLE; Schema: characters; Owner: -; Tablespace: 
--

CREATE TABLE char_exp (
    fkey_character bigint NOT NULL,
    fkey_class integer NOT NULL,
    exp numeric(12,4) DEFAULT 0 NOT NULL,
    levels numeric(12,4) DEFAULT 0 NOT NULL
);


--
-- Name: TABLE char_exp; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON TABLE char_exp IS 'How much does each fighter have in EXP and Levels in their jobs?';


--
-- Name: COLUMN char_exp.fkey_character; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN char_exp.fkey_character IS 'The character.';


--
-- Name: COLUMN char_exp.fkey_class; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN char_exp.fkey_class IS 'The job.';


--
-- Name: COLUMN char_exp.exp; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN char_exp.exp IS 'EXP gained.  Can be negative.';


--
-- Name: COLUMN char_exp.levels; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN char_exp.levels IS 'Levels.  Can be negative.';


--
-- Name: player_chars; Type: TABLE; Schema: characters; Owner: -; Tablespace: 
--

CREATE TABLE player_chars (
    id_player_char integer NOT NULL,
    fkey_character bigint NOT NULL
);


--
-- Name: TABLE player_chars; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON TABLE player_chars IS 'Quick list of who is actually a playable character (that is, who is a real life person behind the IRC client).

Useful for awarding JP to only the players and not other random people.';


--
-- Name: COLUMN player_chars.id_player_char; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN player_chars.id_player_char IS 'ID of the player characer.';


--
-- Name: COLUMN player_chars.fkey_character; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON COLUMN player_chars.fkey_character IS 'ID of the character.';


--
-- Name: pcs_in_battle; Type: VIEW; Schema: characters; Owner: -
--

CREATE VIEW pcs_in_battle AS
    SELECT bc.fkey_character AS char_id, cc.name, bc.starting_job AS job_id, dc.name AS job_title, bc.join_time FROM (((battle.combatants bc JOIN data.classes dc ON ((bc.starting_job = dc.id_job))) JOIN characters cc ON ((bc.fkey_character = cc.id_character))) JOIN player_chars pc ON ((cc.id_character = pc.fkey_character))) ORDER BY bc.join_time;


--
-- Name: VIEW pcs_in_battle; Type: COMMENT; Schema: characters; Owner: -
--

COMMENT ON VIEW pcs_in_battle IS 'Player Characters in battle.  NOT Personal Computers!

...actually, that could work too.';


SET search_path = data, pg_catalog;

--
-- Name: level_up; Type: TABLE; Schema: data; Owner: -; Tablespace: 
--

CREATE TABLE level_up (
    fkey_job integer NOT NULL,
    name character varying(4) NOT NULL,
    value numeric(12,4) NOT NULL
);


--
-- Name: TABLE level_up; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON TABLE level_up IS 'Stat boosts for leveled up jobs.';


--
-- Name: COLUMN level_up.fkey_job; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN level_up.fkey_job IS 'ID of the job.';


--
-- Name: COLUMN level_up.name; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN level_up.name IS 'Name of the stat to boost (must match column).';


--
-- Name: COLUMN level_up.value; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN level_up.value IS 'Value to boost per 1 level increase.';


--
-- Name: starting_status; Type: TABLE; Schema: data; Owner: -; Tablespace: 
--

CREATE TABLE starting_status (
    fkey_job integer NOT NULL,
    fkey_status integer NOT NULL,
    length numeric(12,4) DEFAULT 10000 NOT NULL
);


--
-- Name: TABLE starting_status; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON TABLE starting_status IS 'What status effects do certain jobs start with?';


--
-- Name: COLUMN starting_status.fkey_job; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN starting_status.fkey_job IS 'ID of the job.';


--
-- Name: COLUMN starting_status.fkey_status; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN starting_status.fkey_status IS 'ID of the status effect.';


--
-- Name: COLUMN starting_status.length; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON COLUMN starting_status.length IS 'Length of the effect.  -10K or less is indefinite: 10K or more is permament.';


SET search_path = messages, pg_catalog;

--
-- Name: categories; Type: TABLE; Schema: messages; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id_category integer NOT NULL,
    name character varying(32) NOT NULL,
    fkey_color smallint DEFAULT 1 NOT NULL,
    intro_text character varying(32) DEFAULT '\\cC02,01×\\cC08,01×\\cC04,01×'::character varying NOT NULL,
    outro_text character varying(32) DEFAULT '\\cC04,01×\\cC08,01×\\cC02,01×'::character varying NOT NULL
);


--
-- Name: TABLE categories; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON TABLE categories IS 'List of category messages available.';


--
-- Name: COLUMN categories.id_category; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON COLUMN categories.id_category IS 'ID of the category.';


--
-- Name: COLUMN categories.name; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON COLUMN categories.name IS 'Name of the category.';


--
-- Name: COLUMN categories.fkey_color; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON COLUMN categories.fkey_color IS 'color of the text.';


--
-- Name: COLUMN categories.intro_text; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON COLUMN categories.intro_text IS 'intro text/color.';


--
-- Name: COLUMN categories.outro_text; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON COLUMN categories.outro_text IS 'outtro text/color.';


--
-- Name: messages; Type: TABLE; Schema: messages; Owner: -; Tablespace: 
--

CREATE TABLE messages (
    id_message bigint NOT NULL,
    fkey_category integer NOT NULL,
    message character varying(255) NOT NULL
);


--
-- Name: TABLE messages; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON TABLE messages IS 'The various messages.';


--
-- Name: COLUMN messages.id_message; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON COLUMN messages.id_message IS 'ID of the message.';


--
-- Name: COLUMN messages.fkey_category; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON COLUMN messages.fkey_category IS 'ID of the category.';


--
-- Name: COLUMN messages.message; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON COLUMN messages.message IS 'The message itself.  Includes templating.';


--
-- Name: category_with_message; Type: VIEW; Schema: messages; Owner: -
--

CREATE VIEW category_with_message AS
    SELECT categories.id_category, categories.name AS category, categories.intro_text, to_char((colors.fg)::double precision, 'FM00'::text) AS fg, to_char((colors.bg)::double precision, 'FM00'::text) AS bg, messages.message, categories.outro_text, (((((((((categories.intro_text)::text || '\\cC'::text) || to_char((colors.fg)::double precision, 'FM00'::text)) || ','::text) || to_char((colors.bg)::double precision, 'FM00'::text)) || ' '::text) || (messages.message)::text) || ' '::text) || (categories.outro_text)::text) AS irc_message FROM ((messages JOIN categories ON ((messages.fkey_category = categories.id_category))) JOIN utilities.colors ON ((categories.fkey_color = colors.id_color))) ORDER BY categories.name, messages.message;


--
-- Name: VIEW category_with_message; Type: COMMENT; Schema: messages; Owner: -
--

COMMENT ON VIEW category_with_message IS 'Show all messages tied to a category.  Also include the IRC version of the message ready to go.';


SET search_path = utilities, pg_catalog;

--
-- Name: vars_bool; Type: TABLE; Schema: utilities; Owner: -; Tablespace: 
--

CREATE TABLE vars_bool (
    id_variable integer NOT NULL,
    name character varying(32) NOT NULL,
    value boolean DEFAULT true NOT NULL
);


--
-- Name: TABLE vars_bool; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON TABLE vars_bool IS 'Various boolean variables in use.';


--
-- Name: COLUMN vars_bool.id_variable; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN vars_bool.id_variable IS 'ID of the variable.';


--
-- Name: COLUMN vars_bool.name; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN vars_bool.name IS 'Name of the variable.';


--
-- Name: COLUMN vars_bool.value; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN vars_bool.value IS 'Value of the variable.';


--
-- Name: vars_ints; Type: TABLE; Schema: utilities; Owner: -; Tablespace: 
--

CREATE TABLE vars_ints (
    id_variable integer NOT NULL,
    name character varying(32) NOT NULL,
    value integer DEFAULT 0 NOT NULL
);


--
-- Name: TABLE vars_ints; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON TABLE vars_ints IS 'Various integer variables in use.';


--
-- Name: COLUMN vars_ints.id_variable; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN vars_ints.id_variable IS 'ID of the variable.';


--
-- Name: COLUMN vars_ints.name; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN vars_ints.name IS 'Name of the variable.';


--
-- Name: COLUMN vars_ints.value; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN vars_ints.value IS 'Value of the variable.';


--
-- Name: vars_real_id_variable_seq; Type: SEQUENCE; Schema: utilities; Owner: -
--

CREATE SEQUENCE vars_real_id_variable_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: vars_real_id_variable_seq; Type: SEQUENCE SET; Schema: utilities; Owner: -
--

SELECT pg_catalog.setval('vars_real_id_variable_seq', 12, true);


--
-- Name: vars_real; Type: TABLE; Schema: utilities; Owner: -; Tablespace: 
--

CREATE TABLE vars_real (
    id_variable integer DEFAULT nextval('vars_real_id_variable_seq'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    value real DEFAULT 0 NOT NULL
);


--
-- Name: TABLE vars_real; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON TABLE vars_real IS 'Various real number variables in use.';


--
-- Name: COLUMN vars_real.id_variable; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN vars_real.id_variable IS 'ID of the variable.';


--
-- Name: COLUMN vars_real.name; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN vars_real.name IS 'Name of the variable.';


--
-- Name: COLUMN vars_real.value; Type: COMMENT; Schema: utilities; Owner: -
--

COMMENT ON COLUMN vars_real.value IS 'Value of the variable.';


SET search_path = characters, pg_catalog;

--
-- Name: callscript_id_callscript_seq; Type: SEQUENCE; Schema: characters; Owner: -
--

CREATE SEQUENCE callscript_id_callscript_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: callscript_id_callscript_seq; Type: SEQUENCE OWNED BY; Schema: characters; Owner: -
--

ALTER SEQUENCE callscript_id_callscript_seq OWNED BY callscript.id_callscript;


--
-- Name: callscript_id_callscript_seq; Type: SEQUENCE SET; Schema: characters; Owner: -
--

SELECT pg_catalog.setval('callscript_id_callscript_seq', 1, false);


--
-- Name: characters_id_character_seq; Type: SEQUENCE; Schema: characters; Owner: -
--

CREATE SEQUENCE characters_id_character_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: characters_id_character_seq; Type: SEQUENCE OWNED BY; Schema: characters; Owner: -
--

ALTER SEQUENCE characters_id_character_seq OWNED BY characters.id_character;


--
-- Name: characters_id_character_seq; Type: SEQUENCE SET; Schema: characters; Owner: -
--

SELECT pg_catalog.setval('characters_id_character_seq', 3, true);


--
-- Name: player_chars_id_player_char_seq; Type: SEQUENCE; Schema: characters; Owner: -
--

CREATE SEQUENCE player_chars_id_player_char_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: player_chars_id_player_char_seq; Type: SEQUENCE OWNED BY; Schema: characters; Owner: -
--

ALTER SEQUENCE player_chars_id_player_char_seq OWNED BY player_chars.id_player_char;


--
-- Name: player_chars_id_player_char_seq; Type: SEQUENCE SET; Schema: characters; Owner: -
--

SELECT pg_catalog.setval('player_chars_id_player_char_seq', 1, true);


SET search_path = data, pg_catalog;

--
-- Name: classes_id_job_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE classes_id_job_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: classes_id_job_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE classes_id_job_seq OWNED BY classes.id_job;


--
-- Name: classes_id_job_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('classes_id_job_seq', 2, true);


--
-- Name: status_effects_id_status_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE status_effects_id_status_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: status_effects_id_status_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE status_effects_id_status_seq OWNED BY status_effects.id_status;


--
-- Name: status_effects_id_status_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('status_effects_id_status_seq', 14, true);


SET search_path = messages, pg_catalog;

--
-- Name: categories_id_category_seq; Type: SEQUENCE; Schema: messages; Owner: -
--

CREATE SEQUENCE categories_id_category_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: categories_id_category_seq; Type: SEQUENCE OWNED BY; Schema: messages; Owner: -
--

ALTER SEQUENCE categories_id_category_seq OWNED BY categories.id_category;


--
-- Name: categories_id_category_seq; Type: SEQUENCE SET; Schema: messages; Owner: -
--

SELECT pg_catalog.setval('categories_id_category_seq', 5, true);


--
-- Name: messages_fkey_category_seq; Type: SEQUENCE; Schema: messages; Owner: -
--

CREATE SEQUENCE messages_fkey_category_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: messages_fkey_category_seq; Type: SEQUENCE OWNED BY; Schema: messages; Owner: -
--

ALTER SEQUENCE messages_fkey_category_seq OWNED BY messages.fkey_category;


--
-- Name: messages_fkey_category_seq; Type: SEQUENCE SET; Schema: messages; Owner: -
--

SELECT pg_catalog.setval('messages_fkey_category_seq', 1, false);


--
-- Name: messages_id_message_seq; Type: SEQUENCE; Schema: messages; Owner: -
--

CREATE SEQUENCE messages_id_message_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: messages_id_message_seq; Type: SEQUENCE OWNED BY; Schema: messages; Owner: -
--

ALTER SEQUENCE messages_id_message_seq OWNED BY messages.id_message;


--
-- Name: messages_id_message_seq; Type: SEQUENCE SET; Schema: messages; Owner: -
--

SELECT pg_catalog.setval('messages_id_message_seq', 7, true);


SET search_path = utilities, pg_catalog;

--
-- Name: vars_bool_id_variable_seq; Type: SEQUENCE; Schema: utilities; Owner: -
--

CREATE SEQUENCE vars_bool_id_variable_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: vars_bool_id_variable_seq; Type: SEQUENCE OWNED BY; Schema: utilities; Owner: -
--

ALTER SEQUENCE vars_bool_id_variable_seq OWNED BY vars_bool.id_variable;


--
-- Name: vars_bool_id_variable_seq; Type: SEQUENCE SET; Schema: utilities; Owner: -
--

SELECT pg_catalog.setval('vars_bool_id_variable_seq', 17, true);


--
-- Name: vars_ints_id_variable_seq; Type: SEQUENCE; Schema: utilities; Owner: -
--

CREATE SEQUENCE vars_ints_id_variable_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: vars_ints_id_variable_seq; Type: SEQUENCE OWNED BY; Schema: utilities; Owner: -
--

ALTER SEQUENCE vars_ints_id_variable_seq OWNED BY vars_ints.id_variable;


--
-- Name: vars_ints_id_variable_seq; Type: SEQUENCE SET; Schema: utilities; Owner: -
--

SELECT pg_catalog.setval('vars_ints_id_variable_seq', 5, true);


SET search_path = characters, pg_catalog;

--
-- Name: id_callscript; Type: DEFAULT; Schema: characters; Owner: -
--

ALTER TABLE callscript ALTER COLUMN id_callscript SET DEFAULT nextval('callscript_id_callscript_seq'::regclass);


--
-- Name: id_character; Type: DEFAULT; Schema: characters; Owner: -
--

ALTER TABLE characters ALTER COLUMN id_character SET DEFAULT nextval('characters_id_character_seq'::regclass);


--
-- Name: id_player_char; Type: DEFAULT; Schema: characters; Owner: -
--

ALTER TABLE player_chars ALTER COLUMN id_player_char SET DEFAULT nextval('player_chars_id_player_char_seq'::regclass);


SET search_path = data, pg_catalog;

--
-- Name: id_job; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE classes ALTER COLUMN id_job SET DEFAULT nextval('classes_id_job_seq'::regclass);


--
-- Name: id_status; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE status_effects ALTER COLUMN id_status SET DEFAULT nextval('status_effects_id_status_seq'::regclass);


SET search_path = messages, pg_catalog;

--
-- Name: id_category; Type: DEFAULT; Schema: messages; Owner: -
--

ALTER TABLE categories ALTER COLUMN id_category SET DEFAULT nextval('categories_id_category_seq'::regclass);


--
-- Name: id_message; Type: DEFAULT; Schema: messages; Owner: -
--

ALTER TABLE messages ALTER COLUMN id_message SET DEFAULT nextval('messages_id_message_seq'::regclass);


SET search_path = utilities, pg_catalog;

--
-- Name: id_variable; Type: DEFAULT; Schema: utilities; Owner: -
--

ALTER TABLE vars_bool ALTER COLUMN id_variable SET DEFAULT nextval('vars_bool_id_variable_seq'::regclass);


--
-- Name: id_variable; Type: DEFAULT; Schema: utilities; Owner: -
--

ALTER TABLE vars_ints ALTER COLUMN id_variable SET DEFAULT nextval('vars_ints_id_variable_seq'::regclass);


SET search_path = battle, pg_catalog;

--
-- Data for Name: combatants; Type: TABLE DATA; Schema: battle; Owner: -
--



--
-- Data for Name: fighter_status; Type: TABLE DATA; Schema: battle; Owner: -
--




SET search_path = characters, pg_catalog;

--
-- Data for Name: callscript; Type: TABLE DATA; Schema: characters; Owner: -
--




--
-- Data for Name: char_exp; Type: TABLE DATA; Schema: characters; Owner: -
--

COPY char_exp (fkey_character, fkey_class, exp, levels) FROM stdin;
\.


--
-- Data for Name: characters; Type: TABLE DATA; Schema: characters; Owner: -
--


--
-- Data for Name: player_chars; Type: TABLE DATA; Schema: characters; Owner: -
--




SET search_path = data, pg_catalog;

--
-- Data for Name: classes; Type: TABLE DATA; Schema: data; Owner: -
--




--
-- Data for Name: level_up; Type: TABLE DATA; Schema: data; Owner: -
--




--
-- Data for Name: starting_status; Type: TABLE DATA; Schema: data; Owner: -
--




--
-- Data for Name: status_effects; Type: TABLE DATA; Schema: data; Owner: -
--

COPY status_effects (id_status, name, "desc", is_good, is_secret) FROM stdin;
6	Undead	Healing is bad for you: watch out for cure spells!	f	f
7	KO	You are knocked out.  Tough luck.	f	f
8	Stop	CT is frozen.  You can't move or do anything.	f	f
9	Petrify	Almost nothing can affect you.  You are considered defeated until you recover.	f	f
10	Frozen	You are stopped cold!  Fire melts you, but heavy damage KOs you!	f	f
12	Critial	You are in danger of dying!  Watch your health!	f	f
2	Haste	Every tick, you move closer to your turn than your teammates.	t	f
1	Poison	Every so often, those poisoned take a percentage of their max HP in damage.	f	f
3	Regen	Gradually recover a percentage of your health every so often.	t	f
4	Slow	Each tick, you move a fraction of your speed slower than your teammates.	f	f
11	Seizure	Lose some HP each tick.	f	f
5	Deathshield	Instant death attacks can't hurt you...most of the time.	t	f
13	Safeguard	Protection from status ailments is great...when it works.	t	f
14	Quick	Move so fast, one can take TWO actions per turn!	t	f
\.


SET search_path = messages, pg_catalog;

--
-- Data for Name: categories; Type: TABLE DATA; Schema: messages; Owner: -
--




--
-- Data for Name: messages; Type: TABLE DATA; Schema: messages; Owner: -
--




SET search_path = utilities, pg_catalog;

--
-- Data for Name: colors; Type: TABLE DATA; Schema: utilities; Owner: -
--

COPY colors (id_color, fg, bg) FROM stdin;
0	0	0
1	0	1
2	0	2
3	0	3
4	0	4
5	0	5
6	0	6
7	0	7
8	0	8
9	0	9
10	0	10
11	0	11
12	0	12
13	0	13
14	0	14
15	0	15
16	1	0
17	1	1
18	1	2
19	1	3
20	1	4
21	1	5
22	1	6
23	1	7
24	1	8
25	1	9
26	1	10
27	1	11
28	1	12
29	1	13
30	1	14
31	1	15
32	2	0
33	2	1
34	2	2
35	2	3
36	2	4
37	2	5
38	2	6
39	2	7
40	2	8
41	2	9
42	2	10
43	2	11
44	2	12
45	2	13
46	2	14
47	2	15
48	3	0
49	3	1
50	3	2
51	3	3
52	3	4
53	3	5
54	3	6
55	3	7
56	3	8
57	3	9
58	3	10
59	3	11
60	3	12
61	3	13
62	3	14
63	3	15
64	4	0
65	4	1
66	4	2
67	4	3
68	4	4
69	4	5
70	4	6
71	4	7
72	4	8
73	4	9
74	4	10
75	4	11
76	4	12
77	4	13
78	4	14
79	4	15
80	5	0
81	5	1
82	5	2
83	5	3
84	5	4
85	5	5
86	5	6
87	5	7
88	5	8
89	5	9
90	5	10
91	5	11
92	5	12
93	5	13
94	5	14
95	5	15
96	6	0
97	6	1
98	6	2
99	6	3
100	6	4
101	6	5
102	6	6
103	6	7
104	6	8
105	6	9
106	6	10
107	6	11
108	6	12
109	6	13
110	6	14
111	6	15
112	7	0
113	7	1
114	7	2
115	7	3
116	7	4
117	7	5
118	7	6
119	7	7
120	7	8
121	7	9
122	7	10
123	7	11
124	7	12
125	7	13
126	7	14
127	7	15
128	8	0
129	8	1
130	8	2
131	8	3
132	8	4
133	8	5
134	8	6
135	8	7
136	8	8
137	8	9
138	8	10
139	8	11
140	8	12
141	8	13
142	8	14
143	8	15
144	9	0
145	9	1
146	9	2
147	9	3
148	9	4
149	9	5
150	9	6
151	9	7
152	9	8
153	9	9
154	9	10
155	9	11
156	9	12
157	9	13
158	9	14
159	9	15
160	10	0
161	10	1
162	10	2
163	10	3
164	10	4
165	10	5
166	10	6
167	10	7
168	10	8
169	10	9
170	10	10
171	10	11
172	10	12
173	10	13
174	10	14
175	10	15
176	11	0
177	11	1
178	11	2
179	11	3
180	11	4
181	11	5
182	11	6
183	11	7
184	11	8
185	11	9
186	11	10
187	11	11
188	11	12
189	11	13
190	11	14
191	11	15
192	12	0
193	12	1
194	12	2
195	12	3
196	12	4
197	12	5
198	12	6
199	12	7
200	12	8
201	12	9
202	12	10
203	12	11
204	12	12
205	12	13
206	12	14
207	12	15
208	13	0
209	13	1
210	13	2
211	13	3
212	13	4
213	13	5
214	13	6
215	13	7
216	13	8
217	13	9
218	13	10
219	13	11
220	13	12
221	13	13
222	13	14
223	13	15
224	14	0
225	14	1
226	14	2
227	14	3
228	14	4
229	14	5
230	14	6
231	14	7
232	14	8
233	14	9
234	14	10
235	14	11
236	14	12
237	14	13
238	14	14
239	14	15
240	15	0
241	15	1
242	15	2
243	15	3
244	15	4
245	15	5
246	15	6
247	15	7
248	15	8
249	15	9
250	15	10
251	15	11
252	15	12
253	15	13
254	15	14
255	15	15
\.


--
-- Data for Name: vars_bool; Type: TABLE DATA; Schema: utilities; Owner: -
--

COPY vars_bool (id_variable, name, value) FROM stdin;
1	colors_on	t
2	join_time	f
3	opposite_status_allowed	t
4	poison_undead_hurts	t
5	regen_undead_heals	f
6	ct_decays_past_zero	f
7	stop_stops_status	t
8	frozen_stops_status	f
9	ko_removes_effects	t
10	seizure_undead_heals	f
11	poison_every_x_ticks	t
12	variable_haste	t
13	variable_slow	t
14	variable_regen	t
15	variable_poison	t
16	in_battle	f
17	turnorder_shows_status	t
\.


--
-- Data for Name: vars_ints; Type: TABLE DATA; Schema: utilities; Owner: -
--

COPY vars_ints (id_variable, name, value) FROM stdin;
1	fight_length	79
4	poison_tick_checkpoint	5
5	crit_rule	1
2	ct_while_dead	0
3	turn_at_ct	1000
\.


--
-- Data for Name: vars_real; Type: TABLE DATA; Schema: utilities; Owner: -
--

COPY vars_real (id_variable, name, value) FROM stdin;
1	old_crit_threshold	20
2	haste_boost_percent	20
3	slow_penalty_percent	20
4	haste_boost_flex_percent	5
5	slow_penalty_flex_percent	5
6	regen_boost_percent	10
7	poison_penalty_percent	10
8	regen_boost_flex_percent	2.5
9	poison_penalty_flex_percent	2.5
10	crit_save_hp	0.0099999998
11	safeguard_protection	80
12	adeath_protection	80
\.


SET search_path = battle, pg_catalog;

--
-- Name: combatants_fkey_character_key; Type: CONSTRAINT; Schema: battle; Owner: -; Tablespace: 
--

ALTER TABLE ONLY combatants
    ADD CONSTRAINT combatants_fkey_character_key UNIQUE (fkey_character);


--
-- Name: combatants_pkey; Type: CONSTRAINT; Schema: battle; Owner: -; Tablespace: 
--

ALTER TABLE ONLY combatants
    ADD CONSTRAINT combatants_pkey PRIMARY KEY (id_fighter);


--
-- Name: fighter_status_pkey; Type: CONSTRAINT; Schema: battle; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fighter_status
    ADD CONSTRAINT fighter_status_pkey PRIMARY KEY (fkey_combatant, fkey_status);


SET search_path = characters, pg_catalog;

--
-- Name: callscript_pkey; Type: CONSTRAINT; Schema: characters; Owner: -; Tablespace: 
--

ALTER TABLE ONLY callscript
    ADD CONSTRAINT callscript_pkey PRIMARY KEY (id_callscript);


--
-- Name: char_exp_pkey; Type: CONSTRAINT; Schema: characters; Owner: -; Tablespace: 
--

ALTER TABLE ONLY char_exp
    ADD CONSTRAINT char_exp_pkey PRIMARY KEY (fkey_character, fkey_class);


--
-- Name: characters_pkey; Type: CONSTRAINT; Schema: characters; Owner: -; Tablespace: 
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (id_character);


--
-- Name: player_chars_fkey_character_key; Type: CONSTRAINT; Schema: characters; Owner: -; Tablespace: 
--

ALTER TABLE ONLY player_chars
    ADD CONSTRAINT player_chars_fkey_character_key UNIQUE (fkey_character);


--
-- Name: player_chars_pkey; Type: CONSTRAINT; Schema: characters; Owner: -; Tablespace: 
--

ALTER TABLE ONLY player_chars
    ADD CONSTRAINT player_chars_pkey PRIMARY KEY (id_player_char);


SET search_path = data, pg_catalog;

--
-- Name: classes_name_key; Type: CONSTRAINT; Schema: data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT classes_name_key UNIQUE (name);


--
-- Name: classes_pkey; Type: CONSTRAINT; Schema: data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id_job);


--
-- Name: level_up_pkey; Type: CONSTRAINT; Schema: data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY level_up
    ADD CONSTRAINT level_up_pkey PRIMARY KEY (fkey_job, name);


--
-- Name: starting_status_pkey; Type: CONSTRAINT; Schema: data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY starting_status
    ADD CONSTRAINT starting_status_pkey PRIMARY KEY (fkey_job, fkey_status);


--
-- Name: status_effects_name_key; Type: CONSTRAINT; Schema: data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY status_effects
    ADD CONSTRAINT status_effects_name_key UNIQUE (name);


--
-- Name: status_effects_pkey; Type: CONSTRAINT; Schema: data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY status_effects
    ADD CONSTRAINT status_effects_pkey PRIMARY KEY (id_status);


SET search_path = messages, pg_catalog;

--
-- Name: categories_name_key; Type: CONSTRAINT; Schema: messages; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: messages; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id_category);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: messages; Owner: -; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id_message);


SET search_path = utilities, pg_catalog;

--
-- Name: colors_pkey; Type: CONSTRAINT; Schema: utilities; Owner: -; Tablespace: 
--

ALTER TABLE ONLY colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (id_color);


--
-- Name: vars_bool_name_key; Type: CONSTRAINT; Schema: utilities; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vars_bool
    ADD CONSTRAINT vars_bool_name_key UNIQUE (name);


--
-- Name: vars_bool_pkey; Type: CONSTRAINT; Schema: utilities; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vars_bool
    ADD CONSTRAINT vars_bool_pkey PRIMARY KEY (id_variable);


--
-- Name: vars_ints_name_key; Type: CONSTRAINT; Schema: utilities; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vars_ints
    ADD CONSTRAINT vars_ints_name_key UNIQUE (name);


--
-- Name: vars_ints_pkey; Type: CONSTRAINT; Schema: utilities; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vars_ints
    ADD CONSTRAINT vars_ints_pkey PRIMARY KEY (id_variable);


--
-- Name: vars_real_pkey; Type: CONSTRAINT; Schema: utilities; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vars_real
    ADD CONSTRAINT vars_real_pkey PRIMARY KEY (id_variable);


SET search_path = battle, pg_catalog;

--
-- Name: index_ct; Type: INDEX; Schema: battle; Owner: -; Tablespace: 
--

CREATE INDEX index_ct ON combatants USING btree (ct);


--
-- Name: index_join_time; Type: INDEX; Schema: battle; Owner: -; Tablespace: 
--

CREATE INDEX index_join_time ON combatants USING btree (join_time);


SET search_path = utilities, pg_catalog;

--
-- Name: index_bool_name; Type: INDEX; Schema: utilities; Owner: -; Tablespace: 
--

CREATE INDEX index_bool_name ON vars_bool USING btree (name);


--
-- Name: index_int_name; Type: INDEX; Schema: utilities; Owner: -; Tablespace: 
--

CREATE INDEX index_int_name ON vars_ints USING btree (name);


--
-- Name: vars_real_name_key; Type: INDEX; Schema: utilities; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX vars_real_name_key ON vars_real USING btree (name);


SET search_path = battle, pg_catalog;

--
-- Name: combatants_fkey_character_fkey; Type: FK CONSTRAINT; Schema: battle; Owner: -
--

ALTER TABLE ONLY combatants
    ADD CONSTRAINT combatants_fkey_character_fkey FOREIGN KEY (fkey_character) REFERENCES characters.characters(id_character);


--
-- Name: combatants_fkey_job_fkey; Type: FK CONSTRAINT; Schema: battle; Owner: -
--

ALTER TABLE ONLY combatants
    ADD CONSTRAINT combatants_fkey_job_fkey FOREIGN KEY (fkey_job) REFERENCES data.classes(id_job);


--
-- Name: combatants_starting_job_fkey; Type: FK CONSTRAINT; Schema: battle; Owner: -
--

ALTER TABLE ONLY combatants
    ADD CONSTRAINT combatants_starting_job_fkey FOREIGN KEY (starting_job) REFERENCES data.classes(id_job);


--
-- Name: fighter_status_fkey_combatant_fkey; Type: FK CONSTRAINT; Schema: battle; Owner: -
--

ALTER TABLE ONLY fighter_status
    ADD CONSTRAINT fighter_status_fkey_combatant_fkey FOREIGN KEY (fkey_combatant) REFERENCES combatants(id_fighter) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fighter_status_fkey_status_fkey; Type: FK CONSTRAINT; Schema: battle; Owner: -
--

ALTER TABLE ONLY fighter_status
    ADD CONSTRAINT fighter_status_fkey_status_fkey FOREIGN KEY (fkey_status) REFERENCES data.status_effects(id_status) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = characters, pg_catalog;

--
-- Name: char_exp_fkey_characters_fkey; Type: FK CONSTRAINT; Schema: characters; Owner: -
--

ALTER TABLE ONLY char_exp
    ADD CONSTRAINT char_exp_fkey_characters_fkey FOREIGN KEY (fkey_character) REFERENCES characters(id_character);


--
-- Name: char_exp_fkey_class_fkey; Type: FK CONSTRAINT; Schema: characters; Owner: -
--

ALTER TABLE ONLY char_exp
    ADD CONSTRAINT char_exp_fkey_class_fkey FOREIGN KEY (fkey_class) REFERENCES data.classes(id_job);


--
-- Name: characters_color_fkey; Type: FK CONSTRAINT; Schema: characters; Owner: -
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT characters_color_fkey FOREIGN KEY (color) REFERENCES utilities.colors(id_color);


--
-- Name: player_chars_fkey_character_fkey; Type: FK CONSTRAINT; Schema: characters; Owner: -
--

ALTER TABLE ONLY player_chars
    ADD CONSTRAINT player_chars_fkey_character_fkey FOREIGN KEY (fkey_character) REFERENCES characters(id_character);


SET search_path = data, pg_catalog;

--
-- Name: level_up_fkey_job_fkey; Type: FK CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY level_up
    ADD CONSTRAINT level_up_fkey_job_fkey FOREIGN KEY (fkey_job) REFERENCES classes(id_job) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: starting_status_fkey_job_fkey; Type: FK CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY starting_status
    ADD CONSTRAINT starting_status_fkey_job_fkey FOREIGN KEY (fkey_job) REFERENCES classes(id_job) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: starting_status_fkey_status_fkey; Type: FK CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY starting_status
    ADD CONSTRAINT starting_status_fkey_status_fkey FOREIGN KEY (fkey_status) REFERENCES status_effects(id_status) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = messages, pg_catalog;

--
-- Name: fkey_color; Type: FK CONSTRAINT; Schema: messages; Owner: -
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT fkey_color FOREIGN KEY (fkey_color) REFERENCES utilities.colors(id_color);


--
-- Name: messages_fkey_category_fkey; Type: FK CONSTRAINT; Schema: messages; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_fkey_category_fkey FOREIGN KEY (fkey_category) REFERENCES categories(id_category);


SET search_path = utilities, pg_catalog;

--
-- Name: colors; Type: ACL; Schema: utilities; Owner: -
--




--
-- PostgreSQL database dump complete
--

