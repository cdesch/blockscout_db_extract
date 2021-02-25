--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address_coin_balances; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.address_coin_balances (
    address_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    value numeric(100,0) DEFAULT NULL::numeric,
    value_fetched_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.address_coin_balances OWNER TO cj1;

--
-- Name: address_coin_balances_daily; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.address_coin_balances_daily (
    address_hash bytea NOT NULL,
    day date NOT NULL,
    value numeric(100,0) DEFAULT NULL::numeric,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.address_coin_balances_daily OWNER TO cj1;

--
-- Name: address_current_token_balances; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.address_current_token_balances (
    id bigint NOT NULL,
    address_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    value numeric,
    value_fetched_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    old_value numeric
);


ALTER TABLE public.address_current_token_balances OWNER TO cj1;

--
-- Name: address_current_token_balances_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.address_current_token_balances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_current_token_balances_id_seq OWNER TO cj1;

--
-- Name: address_current_token_balances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.address_current_token_balances_id_seq OWNED BY public.address_current_token_balances.id;


--
-- Name: address_names; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.address_names (
    address_hash bytea NOT NULL,
    name character varying(255) NOT NULL,
    "primary" boolean DEFAULT false NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    metadata jsonb
);


ALTER TABLE public.address_names OWNER TO cj1;

--
-- Name: address_token_balances; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.address_token_balances (
    id bigint NOT NULL,
    address_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    value numeric,
    value_fetched_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.address_token_balances OWNER TO cj1;

--
-- Name: address_token_balances_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.address_token_balances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_token_balances_id_seq OWNER TO cj1;

--
-- Name: address_token_balances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.address_token_balances_id_seq OWNED BY public.address_token_balances.id;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.addresses (
    fetched_coin_balance numeric(100,0),
    fetched_coin_balance_block_number bigint,
    hash bytea NOT NULL,
    contract_code bytea,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    nonce integer,
    decompiled boolean,
    verified boolean
);


ALTER TABLE public.addresses OWNER TO cj1;

--
-- Name: administrators; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.administrators (
    id bigint NOT NULL,
    role character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.administrators OWNER TO cj1;

--
-- Name: administrators_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.administrators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.administrators_id_seq OWNER TO cj1;

--
-- Name: administrators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.administrators_id_seq OWNED BY public.administrators.id;


--
-- Name: block_rewards; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.block_rewards (
    address_hash bytea NOT NULL,
    address_type character varying(255) NOT NULL,
    block_hash bytea NOT NULL,
    reward numeric(100,0),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.block_rewards OWNER TO cj1;

--
-- Name: block_second_degree_relations; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.block_second_degree_relations (
    nephew_hash bytea NOT NULL,
    uncle_hash bytea NOT NULL,
    uncle_fetched_at timestamp without time zone,
    index integer
);


ALTER TABLE public.block_second_degree_relations OWNER TO cj1;

--
-- Name: blocks; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.blocks (
    consensus boolean NOT NULL,
    difficulty numeric(50,0),
    gas_limit numeric(100,0) NOT NULL,
    gas_used numeric(100,0) NOT NULL,
    hash bytea NOT NULL,
    miner_hash bytea NOT NULL,
    nonce bytea NOT NULL,
    number bigint NOT NULL,
    parent_hash bytea NOT NULL,
    size integer,
    "timestamp" timestamp without time zone NOT NULL,
    total_difficulty numeric(50,0),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    refetch_needed boolean DEFAULT false
);


ALTER TABLE public.blocks OWNER TO cj1;

--
-- Name: bridged_tokens; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.bridged_tokens (
    foreign_chain_id numeric NOT NULL,
    foreign_token_contract_address_hash bytea NOT NULL,
    home_token_contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    custom_metadata character varying(255),
    type character varying(255)
);


ALTER TABLE public.bridged_tokens OWNER TO cj1;

--
-- Name: contract_methods; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.contract_methods (
    id bigint NOT NULL,
    identifier integer NOT NULL,
    abi jsonb NOT NULL,
    type character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.contract_methods OWNER TO cj1;

--
-- Name: contract_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.contract_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contract_methods_id_seq OWNER TO cj1;

--
-- Name: contract_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.contract_methods_id_seq OWNED BY public.contract_methods.id;


--
-- Name: decompiled_smart_contracts; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.decompiled_smart_contracts (
    id bigint NOT NULL,
    decompiler_version character varying(255) NOT NULL,
    decompiled_source_code text NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.decompiled_smart_contracts OWNER TO cj1;

--
-- Name: decompiled_smart_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.decompiled_smart_contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.decompiled_smart_contracts_id_seq OWNER TO cj1;

--
-- Name: decompiled_smart_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.decompiled_smart_contracts_id_seq OWNED BY public.decompiled_smart_contracts.id;


--
-- Name: emission_rewards; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.emission_rewards (
    block_range int8range,
    reward numeric
);


ALTER TABLE public.emission_rewards OWNER TO cj1;

--
-- Name: internal_transactions; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.internal_transactions (
    call_type character varying(255),
    created_contract_code bytea,
    error character varying(255),
    gas numeric(100,0),
    gas_used numeric(100,0),
    index integer NOT NULL,
    init bytea,
    input bytea,
    output bytea,
    trace_address integer[] NOT NULL,
    type character varying(255) NOT NULL,
    value numeric(100,0) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_contract_address_hash bytea,
    from_address_hash bytea,
    to_address_hash bytea,
    transaction_hash bytea NOT NULL,
    block_number integer,
    transaction_index integer,
    block_hash bytea NOT NULL,
    block_index integer NOT NULL,
    CONSTRAINT call_has_error_or_result CHECK ((((type)::text <> 'call'::text) OR ((gas IS NOT NULL) AND (((error IS NULL) AND (gas_used IS NOT NULL) AND (output IS NOT NULL)) OR ((error IS NOT NULL) AND (gas_used IS NULL) AND (output IS NULL)))))),
    CONSTRAINT create_has_error_or_result CHECK ((((type)::text <> 'create'::text) OR ((gas IS NOT NULL) AND (((error IS NULL) AND (created_contract_address_hash IS NOT NULL) AND (created_contract_code IS NOT NULL) AND (gas_used IS NOT NULL)) OR ((error IS NOT NULL) AND (created_contract_address_hash IS NULL) AND (created_contract_code IS NULL) AND (gas_used IS NULL))))))
);


ALTER TABLE public.internal_transactions OWNER TO cj1;

--
-- Name: last_fetched_counters; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.last_fetched_counters (
    counter_type character varying(255) NOT NULL,
    value numeric(100,0),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.last_fetched_counters OWNER TO cj1;

--
-- Name: logs; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.logs (
    data bytea NOT NULL,
    index integer NOT NULL,
    type character varying(255),
    first_topic character varying(255),
    second_topic character varying(255),
    third_topic character varying(255),
    fourth_topic character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address_hash bytea,
    transaction_hash bytea NOT NULL,
    block_hash bytea NOT NULL,
    block_number integer
);


ALTER TABLE public.logs OWNER TO cj1;

--
-- Name: market_history; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.market_history (
    id bigint NOT NULL,
    date date,
    closing_price numeric,
    opening_price numeric
);


ALTER TABLE public.market_history OWNER TO cj1;

--
-- Name: market_history_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.market_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.market_history_id_seq OWNER TO cj1;

--
-- Name: market_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.market_history_id_seq OWNED BY public.market_history.id;


--
-- Name: pending_block_operations; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.pending_block_operations (
    block_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fetch_internal_transactions boolean NOT NULL
);


ALTER TABLE public.pending_block_operations OWNER TO cj1;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO cj1;

--
-- Name: smart_contracts; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.smart_contracts (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    compiler_version character varying(255) NOT NULL,
    optimization boolean NOT NULL,
    contract_source_code text NOT NULL,
    abi jsonb NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    constructor_arguments text,
    optimization_runs integer,
    evm_version character varying(255),
    external_libraries jsonb[] DEFAULT ARRAY[]::jsonb[]
);


ALTER TABLE public.smart_contracts OWNER TO cj1;

--
-- Name: smart_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.smart_contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.smart_contracts_id_seq OWNER TO cj1;

--
-- Name: smart_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.smart_contracts_id_seq OWNED BY public.smart_contracts.id;


--
-- Name: staking_pools; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.staking_pools (
    id bigint NOT NULL,
    are_delegators_banned boolean DEFAULT false,
    banned_delegators_until bigint,
    banned_until bigint,
    ban_reason character varying(255),
    delegators_count integer,
    is_active boolean DEFAULT false NOT NULL,
    is_banned boolean DEFAULT false NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    is_unremovable boolean DEFAULT false NOT NULL,
    is_validator boolean DEFAULT false NOT NULL,
    likelihood numeric(5,2),
    mining_address_hash bytea,
    self_staked_amount numeric(100,0),
    snapshotted_self_staked_amount numeric(100,0),
    snapshotted_total_staked_amount numeric(100,0),
    snapshotted_validator_reward_ratio numeric(5,2),
    stakes_ratio numeric(5,2),
    staking_address_hash bytea,
    total_staked_amount numeric(100,0),
    validator_reward_percent numeric(5,2),
    validator_reward_ratio numeric(5,2),
    was_banned_count integer,
    was_validator_count integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.staking_pools OWNER TO cj1;

--
-- Name: staking_pools_delegators; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.staking_pools_delegators (
    id bigint NOT NULL,
    address_hash bytea,
    is_active boolean DEFAULT true,
    is_deleted boolean DEFAULT false,
    max_ordered_withdraw_allowed numeric(100,0),
    max_withdraw_allowed numeric(100,0),
    ordered_withdraw numeric(100,0),
    ordered_withdraw_epoch integer,
    reward_ratio numeric(5,2),
    snapshotted_reward_ratio numeric(5,2),
    snapshotted_stake_amount numeric(100,0),
    stake_amount numeric(100,0),
    staking_address_hash bytea,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.staking_pools_delegators OWNER TO cj1;

--
-- Name: staking_pools_delegators_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.staking_pools_delegators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staking_pools_delegators_id_seq OWNER TO cj1;

--
-- Name: staking_pools_delegators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.staking_pools_delegators_id_seq OWNED BY public.staking_pools_delegators.id;


--
-- Name: staking_pools_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.staking_pools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staking_pools_id_seq OWNER TO cj1;

--
-- Name: staking_pools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.staking_pools_id_seq OWNED BY public.staking_pools.id;


--
-- Name: token_instances; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.token_instances (
    token_id numeric(78,0) NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    metadata jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    error character varying(255)
);


ALTER TABLE public.token_instances OWNER TO cj1;

--
-- Name: token_transfers; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.token_transfers (
    transaction_hash bytea NOT NULL,
    log_index integer NOT NULL,
    from_address_hash bytea NOT NULL,
    to_address_hash bytea NOT NULL,
    amount numeric,
    token_id numeric(78,0),
    token_contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    block_number integer,
    block_hash bytea NOT NULL
);


ALTER TABLE public.token_transfers OWNER TO cj1;

--
-- Name: tokens; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.tokens (
    name character varying(255),
    symbol character varying(255),
    total_supply numeric,
    decimals numeric,
    type character varying(255) NOT NULL,
    cataloged boolean DEFAULT false,
    contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    holder_count integer,
    bridged boolean
);


ALTER TABLE public.tokens OWNER TO cj1;

--
-- Name: transaction_forks; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.transaction_forks (
    hash bytea NOT NULL,
    index integer NOT NULL,
    uncle_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.transaction_forks OWNER TO cj1;

--
-- Name: transaction_stats; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.transaction_stats (
    id bigint NOT NULL,
    date date,
    number_of_transactions integer,
    gas_used numeric(100,0)
);


ALTER TABLE public.transaction_stats OWNER TO cj1;

--
-- Name: transaction_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.transaction_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_stats_id_seq OWNER TO cj1;

--
-- Name: transaction_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.transaction_stats_id_seq OWNED BY public.transaction_stats.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.transactions (
    cumulative_gas_used numeric(100,0),
    error character varying(255),
    gas numeric(100,0) NOT NULL,
    gas_price numeric(100,0) NOT NULL,
    gas_used numeric(100,0),
    hash bytea NOT NULL,
    index integer,
    input bytea NOT NULL,
    nonce integer NOT NULL,
    r numeric(100,0) NOT NULL,
    s numeric(100,0) NOT NULL,
    status integer,
    v numeric(100,0) NOT NULL,
    value numeric(100,0) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    block_hash bytea,
    block_number integer,
    from_address_hash bytea NOT NULL,
    to_address_hash bytea,
    created_contract_address_hash bytea,
    created_contract_code_indexed_at timestamp without time zone,
    earliest_processing_start timestamp without time zone,
    old_block_hash bytea,
    revert_reason text,
    CONSTRAINT collated_block_number CHECK (((block_hash IS NULL) OR (block_number IS NOT NULL))),
    CONSTRAINT collated_cumalative_gas_used CHECK (((block_hash IS NULL) OR (cumulative_gas_used IS NOT NULL))),
    CONSTRAINT collated_gas_used CHECK (((block_hash IS NULL) OR (gas_used IS NOT NULL))),
    CONSTRAINT collated_index CHECK (((block_hash IS NULL) OR (index IS NOT NULL))),
    CONSTRAINT error CHECK (((status = 0) OR ((status <> 0) AND (error IS NULL)))),
    CONSTRAINT pending_block_number CHECK (((block_hash IS NOT NULL) OR (block_number IS NULL))),
    CONSTRAINT pending_cumalative_gas_used CHECK (((block_hash IS NOT NULL) OR (cumulative_gas_used IS NULL))),
    CONSTRAINT pending_gas_used CHECK (((block_hash IS NOT NULL) OR (gas_used IS NULL))),
    CONSTRAINT pending_index CHECK (((block_hash IS NOT NULL) OR (index IS NULL))),
    CONSTRAINT status CHECK ((((block_hash IS NULL) AND (status IS NULL)) OR (block_hash IS NOT NULL) OR ((status = 0) AND ((error)::text = 'dropped/replaced'::text))))
);


ALTER TABLE public.transactions OWNER TO cj1;

--
-- Name: user_contacts; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.user_contacts (
    id bigint NOT NULL,
    email public.citext NOT NULL,
    user_id bigint NOT NULL,
    "primary" boolean DEFAULT false,
    verified boolean DEFAULT false,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_contacts OWNER TO cj1;

--
-- Name: user_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.user_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_contacts_id_seq OWNER TO cj1;

--
-- Name: user_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.user_contacts_id_seq OWNED BY public.user_contacts.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: cj1
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username public.citext NOT NULL,
    password_hash character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO cj1;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: cj1
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO cj1;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cj1
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: address_current_token_balances id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_current_token_balances ALTER COLUMN id SET DEFAULT nextval('public.address_current_token_balances_id_seq'::regclass);


--
-- Name: address_token_balances id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_token_balances ALTER COLUMN id SET DEFAULT nextval('public.address_token_balances_id_seq'::regclass);


--
-- Name: administrators id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.administrators ALTER COLUMN id SET DEFAULT nextval('public.administrators_id_seq'::regclass);


--
-- Name: contract_methods id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.contract_methods ALTER COLUMN id SET DEFAULT nextval('public.contract_methods_id_seq'::regclass);


--
-- Name: decompiled_smart_contracts id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.decompiled_smart_contracts ALTER COLUMN id SET DEFAULT nextval('public.decompiled_smart_contracts_id_seq'::regclass);


--
-- Name: market_history id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.market_history ALTER COLUMN id SET DEFAULT nextval('public.market_history_id_seq'::regclass);


--
-- Name: smart_contracts id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.smart_contracts ALTER COLUMN id SET DEFAULT nextval('public.smart_contracts_id_seq'::regclass);


--
-- Name: staking_pools id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.staking_pools ALTER COLUMN id SET DEFAULT nextval('public.staking_pools_id_seq'::regclass);


--
-- Name: staking_pools_delegators id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.staking_pools_delegators ALTER COLUMN id SET DEFAULT nextval('public.staking_pools_delegators_id_seq'::regclass);


--
-- Name: transaction_stats id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.transaction_stats ALTER COLUMN id SET DEFAULT nextval('public.transaction_stats_id_seq'::regclass);


--
-- Name: user_contacts id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.user_contacts ALTER COLUMN id SET DEFAULT nextval('public.user_contacts_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: address_current_token_balances address_current_token_balances_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_current_token_balances
    ADD CONSTRAINT address_current_token_balances_pkey PRIMARY KEY (id);


--
-- Name: address_token_balances address_token_balances_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_token_balances
    ADD CONSTRAINT address_token_balances_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (hash);


--
-- Name: administrators administrators_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_pkey PRIMARY KEY (id);


--
-- Name: block_second_degree_relations block_second_degree_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.block_second_degree_relations
    ADD CONSTRAINT block_second_degree_relations_pkey PRIMARY KEY (nephew_hash, uncle_hash);


--
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (hash);


--
-- Name: internal_transactions call_has_call_type; Type: CHECK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE public.internal_transactions
    ADD CONSTRAINT call_has_call_type CHECK ((((type)::text <> 'call'::text) OR (call_type IS NOT NULL))) NOT VALID;


--
-- Name: internal_transactions call_has_input; Type: CHECK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE public.internal_transactions
    ADD CONSTRAINT call_has_input CHECK ((((type)::text <> 'call'::text) OR (input IS NOT NULL))) NOT VALID;


--
-- Name: contract_methods contract_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.contract_methods
    ADD CONSTRAINT contract_methods_pkey PRIMARY KEY (id);


--
-- Name: internal_transactions create_has_init; Type: CHECK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE public.internal_transactions
    ADD CONSTRAINT create_has_init CHECK ((((type)::text <> 'create'::text) OR (init IS NOT NULL))) NOT VALID;


--
-- Name: decompiled_smart_contracts decompiled_smart_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.decompiled_smart_contracts
    ADD CONSTRAINT decompiled_smart_contracts_pkey PRIMARY KEY (id);


--
-- Name: internal_transactions internal_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_pkey PRIMARY KEY (block_hash, block_index);


--
-- Name: last_fetched_counters last_fetched_counters_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.last_fetched_counters
    ADD CONSTRAINT last_fetched_counters_pkey PRIMARY KEY (counter_type);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (transaction_hash, block_hash, index);


--
-- Name: market_history market_history_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.market_history
    ADD CONSTRAINT market_history_pkey PRIMARY KEY (id);


--
-- Name: emission_rewards no_overlapping_ranges; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.emission_rewards
    ADD CONSTRAINT no_overlapping_ranges EXCLUDE USING gist (block_range WITH &&);


--
-- Name: pending_block_operations pending_block_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.pending_block_operations
    ADD CONSTRAINT pending_block_operations_pkey PRIMARY KEY (block_hash);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: internal_transactions selfdestruct_has_from_and_to_address; Type: CHECK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE public.internal_transactions
    ADD CONSTRAINT selfdestruct_has_from_and_to_address CHECK ((((type)::text <> 'selfdestruct'::text) OR ((from_address_hash IS NOT NULL) AND (gas IS NULL) AND (to_address_hash IS NOT NULL)))) NOT VALID;


--
-- Name: smart_contracts smart_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.smart_contracts
    ADD CONSTRAINT smart_contracts_pkey PRIMARY KEY (id);


--
-- Name: staking_pools_delegators staking_pools_delegators_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.staking_pools_delegators
    ADD CONSTRAINT staking_pools_delegators_pkey PRIMARY KEY (id);


--
-- Name: staking_pools staking_pools_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.staking_pools
    ADD CONSTRAINT staking_pools_pkey PRIMARY KEY (id);


--
-- Name: token_instances token_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.token_instances
    ADD CONSTRAINT token_instances_pkey PRIMARY KEY (token_id, token_contract_address_hash);


--
-- Name: token_transfers token_transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_pkey PRIMARY KEY (transaction_hash, block_hash, log_index);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (contract_address_hash);


--
-- Name: transaction_stats transaction_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.transaction_stats
    ADD CONSTRAINT transaction_stats_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (hash);


--
-- Name: user_contacts user_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.user_contacts
    ADD CONSTRAINT user_contacts_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: address_coin_balances_address_hash_block_number_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX address_coin_balances_address_hash_block_number_index ON public.address_coin_balances USING btree (address_hash, block_number);


--
-- Name: address_coin_balances_daily_address_hash_day_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX address_coin_balances_daily_address_hash_day_index ON public.address_coin_balances_daily USING btree (address_hash, day);


--
-- Name: address_coin_balances_value_fetched_at_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX address_coin_balances_value_fetched_at_index ON public.address_coin_balances USING btree (value_fetched_at);


--
-- Name: address_cur_token_balances_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX address_cur_token_balances_index ON public.address_current_token_balances USING btree (block_number);


--
-- Name: address_current_token_balances_address_hash_block_number_token_; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX address_current_token_balances_address_hash_block_number_token_ ON public.address_current_token_balances USING btree (address_hash, block_number, token_contract_address_hash);


--
-- Name: address_current_token_balances_address_hash_token_contract_addr; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX address_current_token_balances_address_hash_token_contract_addr ON public.address_current_token_balances USING btree (address_hash, token_contract_address_hash);


--
-- Name: address_current_token_balances_token_contract_address_hash_inde; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX address_current_token_balances_token_contract_address_hash_inde ON public.address_current_token_balances USING btree (token_contract_address_hash) WHERE ((address_hash <> '\x0000000000000000000000000000000000000000'::bytea) AND (value > (0)::numeric));


--
-- Name: address_current_token_balances_token_contract_address_hash_valu; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX address_current_token_balances_token_contract_address_hash_valu ON public.address_current_token_balances USING btree (token_contract_address_hash, value);


--
-- Name: address_current_token_balances_value; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX address_current_token_balances_value ON public.address_current_token_balances USING btree (value) WHERE (value IS NOT NULL);


--
-- Name: address_decompiler_version; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX address_decompiler_version ON public.decompiled_smart_contracts USING btree (address_hash, decompiler_version);


--
-- Name: address_names_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX address_names_address_hash_index ON public.address_names USING btree (address_hash) WHERE ("primary" = true);


--
-- Name: address_token_balances_address_hash_token_contract_address_hash; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX address_token_balances_address_hash_token_contract_address_hash ON public.address_token_balances USING btree (address_hash, token_contract_address_hash, block_number);


--
-- Name: address_token_balances_block_number_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX address_token_balances_block_number_address_hash_index ON public.address_token_balances USING btree (block_number, address_hash);


--
-- Name: addresses_contract_code_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX addresses_contract_code_index ON public.addresses USING btree (md5((contract_code)::text));


--
-- Name: addresses_fetched_coin_balance_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX addresses_fetched_coin_balance_hash_index ON public.addresses USING btree (fetched_coin_balance DESC, hash) WHERE (fetched_coin_balance > (0)::numeric);


--
-- Name: addresses_fetched_coin_balance_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX addresses_fetched_coin_balance_index ON public.addresses USING btree (fetched_coin_balance);


--
-- Name: addresses_inserted_at_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX addresses_inserted_at_index ON public.addresses USING btree (inserted_at);


--
-- Name: administrators_user_id_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX administrators_user_id_index ON public.administrators USING btree (user_id);


--
-- Name: block_rewards_address_hash_block_hash_address_type_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX block_rewards_address_hash_block_hash_address_type_index ON public.block_rewards USING btree (address_hash, block_hash, address_type);


--
-- Name: block_rewards_block_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX block_rewards_block_hash_index ON public.block_rewards USING btree (block_hash);


--
-- Name: block_rewards_block_hash_partial_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX block_rewards_block_hash_partial_index ON public.block_rewards USING btree (block_hash) WHERE ((address_type)::text = 'validator'::text);


--
-- Name: blocks_consensus_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX blocks_consensus_index ON public.blocks USING btree (consensus);


--
-- Name: blocks_inserted_at_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX blocks_inserted_at_index ON public.blocks USING btree (inserted_at);


--
-- Name: blocks_miner_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX blocks_miner_hash_index ON public.blocks USING btree (miner_hash);


--
-- Name: blocks_miner_hash_number_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX blocks_miner_hash_number_index ON public.blocks USING btree (miner_hash, number);


--
-- Name: blocks_number_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX blocks_number_index ON public.blocks USING btree (number);


--
-- Name: blocks_timestamp_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX blocks_timestamp_index ON public.blocks USING btree ("timestamp");


--
-- Name: bridged_tokens_home_token_contract_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX bridged_tokens_home_token_contract_address_hash_index ON public.bridged_tokens USING btree (home_token_contract_address_hash);


--
-- Name: contract_methods_identifier_abi_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX contract_methods_identifier_abi_index ON public.contract_methods USING btree (identifier, abi);


--
-- Name: email_unique_for_user; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX email_unique_for_user ON public.user_contacts USING btree (user_id, email);


--
-- Name: emission_rewards_block_range_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX emission_rewards_block_range_index ON public.emission_rewards USING btree (block_range);


--
-- Name: internal_transactions_block_number_DESC__transaction_index_DESC; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX "internal_transactions_block_number_DESC__transaction_index_DESC" ON public.internal_transactions USING btree (block_number DESC, transaction_index DESC, index DESC);


--
-- Name: internal_transactions_created_contract_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX internal_transactions_created_contract_address_hash_index ON public.internal_transactions USING btree (created_contract_address_hash);


--
-- Name: internal_transactions_created_contract_address_hash_partial_ind; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX internal_transactions_created_contract_address_hash_partial_ind ON public.internal_transactions USING btree (created_contract_address_hash, block_number DESC, transaction_index DESC, index DESC) WHERE ((((type)::text = 'call'::text) AND (index > 0)) OR ((type)::text <> 'call'::text));


--
-- Name: internal_transactions_from_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX internal_transactions_from_address_hash_index ON public.internal_transactions USING btree (from_address_hash);


--
-- Name: internal_transactions_from_address_hash_partial_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX internal_transactions_from_address_hash_partial_index ON public.internal_transactions USING btree (from_address_hash, block_number DESC, transaction_index DESC, index DESC) WHERE ((((type)::text = 'call'::text) AND (index > 0)) OR ((type)::text <> 'call'::text));


--
-- Name: internal_transactions_to_address_hash_partial_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX internal_transactions_to_address_hash_partial_index ON public.internal_transactions USING btree (to_address_hash, block_number DESC, transaction_index DESC, index DESC) WHERE ((((type)::text = 'call'::text) AND (index > 0)) OR ((type)::text <> 'call'::text));


--
-- Name: internal_transactions_transaction_hash_index_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX internal_transactions_transaction_hash_index_index ON public.internal_transactions USING btree (transaction_hash, index);


--
-- Name: logs_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX logs_address_hash_index ON public.logs USING btree (address_hash);


--
-- Name: logs_block_number_DESC__index_DESC_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX "logs_block_number_DESC__index_DESC_index" ON public.logs USING btree (block_number DESC, index DESC);


--
-- Name: logs_first_topic_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX logs_first_topic_index ON public.logs USING btree (first_topic);


--
-- Name: logs_fourth_topic_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX logs_fourth_topic_index ON public.logs USING btree (fourth_topic);


--
-- Name: logs_index_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX logs_index_index ON public.logs USING btree (index);


--
-- Name: logs_second_topic_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX logs_second_topic_index ON public.logs USING btree (second_topic);


--
-- Name: logs_third_topic_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX logs_third_topic_index ON public.logs USING btree (third_topic);


--
-- Name: logs_transaction_hash_index_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX logs_transaction_hash_index_index ON public.logs USING btree (transaction_hash, index);


--
-- Name: logs_type_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX logs_type_index ON public.logs USING btree (type);


--
-- Name: market_history_date_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX market_history_date_index ON public.market_history USING btree (date);


--
-- Name: nephew_hash_to_uncle_hash; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX nephew_hash_to_uncle_hash ON public.block_second_degree_relations USING btree (nephew_hash, uncle_hash);


--
-- Name: one_consensus_block_at_height; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX one_consensus_block_at_height ON public.blocks USING btree (number) WHERE consensus;


--
-- Name: one_consensus_child_per_parent; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX one_consensus_child_per_parent ON public.blocks USING btree (parent_hash) WHERE consensus;


--
-- Name: one_primary_per_user; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX one_primary_per_user ON public.user_contacts USING btree (user_id) WHERE "primary";


--
-- Name: owner_role_limit; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX owner_role_limit ON public.administrators USING btree (role) WHERE ((role)::text = 'owner'::text);


--
-- Name: pending_block_operations_block_hash_index_partial; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX pending_block_operations_block_hash_index_partial ON public.pending_block_operations USING btree (block_hash) WHERE (fetch_internal_transactions = true);


--
-- Name: pending_txs_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX pending_txs_index ON public.transactions USING btree (inserted_at, hash) WHERE ((block_hash IS NULL) AND ((error IS NULL) OR ((error)::text <> 'dropped/replaced'::text)));


--
-- Name: pools_delegator_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX pools_delegator_index ON public.staking_pools_delegators USING btree (address_hash, staking_address_hash);


--
-- Name: smart_contracts_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX smart_contracts_address_hash_index ON public.smart_contracts USING btree (address_hash);


--
-- Name: snapshotted_stake_amount_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX snapshotted_stake_amount_index ON public.staking_pools_delegators USING btree (staking_address_hash, snapshotted_stake_amount, is_active);


--
-- Name: staking_pools_mining_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX staking_pools_mining_address_hash_index ON public.staking_pools USING btree (mining_address_hash);


--
-- Name: staking_pools_staking_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX staking_pools_staking_address_hash_index ON public.staking_pools USING btree (staking_address_hash);


--
-- Name: token_instances_error_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX token_instances_error_index ON public.token_instances USING btree (error);


--
-- Name: token_transfers_block_number_DESC_log_index_DESC_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX "token_transfers_block_number_DESC_log_index_DESC_index" ON public.token_transfers USING btree (block_number DESC, log_index DESC);


--
-- Name: token_transfers_block_number_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX token_transfers_block_number_index ON public.token_transfers USING btree (block_number);


--
-- Name: token_transfers_from_address_hash_transaction_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX token_transfers_from_address_hash_transaction_hash_index ON public.token_transfers USING btree (from_address_hash, transaction_hash);


--
-- Name: token_transfers_to_address_hash_transaction_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX token_transfers_to_address_hash_transaction_hash_index ON public.token_transfers USING btree (to_address_hash, transaction_hash);


--
-- Name: token_transfers_token_contract_address_hash_block_number_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX token_transfers_token_contract_address_hash_block_number_index ON public.token_transfers USING btree (token_contract_address_hash, block_number);


--
-- Name: token_transfers_token_contract_address_hash_token_id_DESC_block; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX "token_transfers_token_contract_address_hash_token_id_DESC_block" ON public.token_transfers USING btree (token_contract_address_hash, token_id DESC, block_number DESC);


--
-- Name: token_transfers_token_contract_address_hash_transaction_hash_in; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX token_transfers_token_contract_address_hash_transaction_hash_in ON public.token_transfers USING btree (token_contract_address_hash, transaction_hash);


--
-- Name: token_transfers_token_id_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX token_transfers_token_id_index ON public.token_transfers USING btree (token_id);


--
-- Name: token_transfers_transaction_hash_log_index_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX token_transfers_transaction_hash_log_index_index ON public.token_transfers USING btree (transaction_hash, log_index);


--
-- Name: tokens_contract_address_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX tokens_contract_address_hash_index ON public.tokens USING btree (contract_address_hash);


--
-- Name: tokens_symbol_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX tokens_symbol_index ON public.tokens USING btree (symbol);


--
-- Name: tokens_trgm_idx; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX tokens_trgm_idx ON public.tokens USING gin (to_tsvector('english'::regconfig, (((symbol)::text || ' '::text) || (name)::text)));


--
-- Name: tokens_type_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX tokens_type_index ON public.tokens USING btree (type);


--
-- Name: transaction_forks_uncle_hash_index_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX transaction_forks_uncle_hash_index_index ON public.transaction_forks USING btree (uncle_hash, index);


--
-- Name: transaction_stats_date_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX transaction_stats_date_index ON public.transaction_stats USING btree (date);


--
-- Name: transactions_block_hash_error_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_block_hash_error_index ON public.transactions USING btree (block_hash, error);


--
-- Name: transactions_block_hash_index_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX transactions_block_hash_index_index ON public.transactions USING btree (block_hash, index);


--
-- Name: transactions_created_contract_address_hash_recent_collated_inde; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_created_contract_address_hash_recent_collated_inde ON public.transactions USING btree (created_contract_address_hash, block_number DESC, index DESC, hash);


--
-- Name: transactions_created_contract_code_indexed_at_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_created_contract_code_indexed_at_index ON public.transactions USING btree (created_contract_code_indexed_at);


--
-- Name: transactions_from_address_hash_recent_collated_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_from_address_hash_recent_collated_index ON public.transactions USING btree (from_address_hash, block_number DESC, index DESC, hash);


--
-- Name: transactions_inserted_at_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_inserted_at_index ON public.transactions USING btree (inserted_at);


--
-- Name: transactions_nonce_from_address_hash_block_hash_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_nonce_from_address_hash_block_hash_index ON public.transactions USING btree (nonce, from_address_hash, block_hash);


--
-- Name: transactions_recent_collated_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_recent_collated_index ON public.transactions USING btree (block_number DESC, index DESC);


--
-- Name: transactions_status_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_status_index ON public.transactions USING btree (status);


--
-- Name: transactions_to_address_hash_recent_collated_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_to_address_hash_recent_collated_index ON public.transactions USING btree (to_address_hash, block_number DESC, index DESC, hash);


--
-- Name: transactions_updated_at_index; Type: INDEX; Schema: public; Owner: cj1
--

CREATE INDEX transactions_updated_at_index ON public.transactions USING btree (updated_at);


--
-- Name: uncle_hash_to_nephew_hash; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX uncle_hash_to_nephew_hash ON public.block_second_degree_relations USING btree (uncle_hash, nephew_hash);


--
-- Name: unfetched_balances; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX unfetched_balances ON public.address_coin_balances USING btree (address_hash, block_number) WHERE (value_fetched_at IS NULL);


--
-- Name: unfetched_token_balances; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX unfetched_token_balances ON public.address_token_balances USING btree (address_hash, token_contract_address_hash, block_number) WHERE (value_fetched_at IS NULL);


--
-- Name: unfetched_uncles; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX unfetched_uncles ON public.block_second_degree_relations USING btree (nephew_hash, uncle_hash) WHERE (uncle_fetched_at IS NULL);


--
-- Name: unique_address_names; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX unique_address_names ON public.address_names USING btree (address_hash, name);


--
-- Name: unique_username; Type: INDEX; Schema: public; Owner: cj1
--

CREATE UNIQUE INDEX unique_username ON public.users USING btree (username);


--
-- Name: address_coin_balances address_coin_balances_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_coin_balances
    ADD CONSTRAINT address_coin_balances_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash);


--
-- Name: address_coin_balances_daily address_coin_balances_daily_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_coin_balances_daily
    ADD CONSTRAINT address_coin_balances_daily_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash);


--
-- Name: address_current_token_balances address_current_token_balances_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_current_token_balances
    ADD CONSTRAINT address_current_token_balances_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash);


--
-- Name: address_current_token_balances address_current_token_balances_token_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_current_token_balances
    ADD CONSTRAINT address_current_token_balances_token_contract_address_hash_fkey FOREIGN KEY (token_contract_address_hash) REFERENCES public.tokens(contract_address_hash);


--
-- Name: address_token_balances address_token_balances_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_token_balances
    ADD CONSTRAINT address_token_balances_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash);


--
-- Name: address_token_balances address_token_balances_token_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.address_token_balances
    ADD CONSTRAINT address_token_balances_token_contract_address_hash_fkey FOREIGN KEY (token_contract_address_hash) REFERENCES public.tokens(contract_address_hash);


--
-- Name: administrators administrators_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: block_rewards block_rewards_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.block_rewards
    ADD CONSTRAINT block_rewards_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- Name: block_rewards block_rewards_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.block_rewards
    ADD CONSTRAINT block_rewards_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash) ON DELETE CASCADE;


--
-- Name: block_second_degree_relations block_second_degree_relations_nephew_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.block_second_degree_relations
    ADD CONSTRAINT block_second_degree_relations_nephew_hash_fkey FOREIGN KEY (nephew_hash) REFERENCES public.blocks(hash);


--
-- Name: blocks blocks_miner_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_miner_hash_fkey FOREIGN KEY (miner_hash) REFERENCES public.addresses(hash);


--
-- Name: bridged_tokens bridged_tokens_home_token_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.bridged_tokens
    ADD CONSTRAINT bridged_tokens_home_token_contract_address_hash_fkey FOREIGN KEY (home_token_contract_address_hash) REFERENCES public.tokens(contract_address_hash) ON DELETE CASCADE;


--
-- Name: decompiled_smart_contracts decompiled_smart_contracts_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.decompiled_smart_contracts
    ADD CONSTRAINT decompiled_smart_contracts_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- Name: internal_transactions internal_transactions_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash);


--
-- Name: internal_transactions internal_transactions_created_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_created_contract_address_hash_fkey FOREIGN KEY (created_contract_address_hash) REFERENCES public.addresses(hash);


--
-- Name: internal_transactions internal_transactions_from_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_from_address_hash_fkey FOREIGN KEY (from_address_hash) REFERENCES public.addresses(hash);


--
-- Name: internal_transactions internal_transactions_to_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_to_address_hash_fkey FOREIGN KEY (to_address_hash) REFERENCES public.addresses(hash);


--
-- Name: internal_transactions internal_transactions_transaction_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_transaction_hash_fkey FOREIGN KEY (transaction_hash) REFERENCES public.transactions(hash) ON DELETE CASCADE;


--
-- Name: logs logs_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- Name: logs logs_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash);


--
-- Name: logs logs_transaction_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_transaction_hash_fkey FOREIGN KEY (transaction_hash) REFERENCES public.transactions(hash) ON DELETE CASCADE;


--
-- Name: pending_block_operations pending_block_operations_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.pending_block_operations
    ADD CONSTRAINT pending_block_operations_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash) ON DELETE CASCADE;


--
-- Name: smart_contracts smart_contracts_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.smart_contracts
    ADD CONSTRAINT smart_contracts_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- Name: token_instances token_instances_token_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.token_instances
    ADD CONSTRAINT token_instances_token_contract_address_hash_fkey FOREIGN KEY (token_contract_address_hash) REFERENCES public.tokens(contract_address_hash);


--
-- Name: token_transfers token_transfers_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash);


--
-- Name: token_transfers token_transfers_from_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_from_address_hash_fkey FOREIGN KEY (from_address_hash) REFERENCES public.addresses(hash);


--
-- Name: token_transfers token_transfers_to_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_to_address_hash_fkey FOREIGN KEY (to_address_hash) REFERENCES public.addresses(hash);


--
-- Name: token_transfers token_transfers_token_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_token_contract_address_hash_fkey FOREIGN KEY (token_contract_address_hash) REFERENCES public.addresses(hash);


--
-- Name: token_transfers token_transfers_transaction_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_transaction_hash_fkey FOREIGN KEY (transaction_hash) REFERENCES public.transactions(hash) ON DELETE CASCADE;


--
-- Name: tokens tokens_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_contract_address_hash_fkey FOREIGN KEY (contract_address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- Name: transaction_forks transaction_forks_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.transaction_forks
    ADD CONSTRAINT transaction_forks_hash_fkey FOREIGN KEY (hash) REFERENCES public.transactions(hash) ON DELETE CASCADE;


--
-- Name: transaction_forks transaction_forks_uncle_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.transaction_forks
    ADD CONSTRAINT transaction_forks_uncle_hash_fkey FOREIGN KEY (uncle_hash) REFERENCES public.blocks(hash) ON DELETE CASCADE;


--
-- Name: transactions transactions_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash) ON DELETE CASCADE;


--
-- Name: transactions transactions_created_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_created_contract_address_hash_fkey FOREIGN KEY (created_contract_address_hash) REFERENCES public.addresses(hash);


--
-- Name: transactions transactions_from_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_from_address_hash_fkey FOREIGN KEY (from_address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- Name: transactions transactions_to_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_to_address_hash_fkey FOREIGN KEY (to_address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- Name: user_contacts user_contacts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cj1
--

ALTER TABLE ONLY public.user_contacts
    ADD CONSTRAINT user_contacts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

