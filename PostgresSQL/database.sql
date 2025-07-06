--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18
-- Dumped by pg_dump version 14.18

-- Started on 2025-07-06 09:10:59 UTC

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 82008)
-- Name: device_scan_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.device_scan_log (
    id integer NOT NULL,
    device_id integer NOT NULL,
    scan_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status boolean NOT NULL,
    rtt_ms numeric,
    mac_address macaddr,
    ip_address inet
);


ALTER TABLE public.device_scan_log OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 82007)
-- Name: device_scan_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.device_scan_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_scan_log_id_seq OWNER TO postgres;

--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 211
-- Name: device_scan_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.device_scan_log_id_seq OWNED BY public.device_scan_log.id;


--
-- TOC entry 214 (class 1259 OID 82023)
-- Name: dns_query_summary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dns_query_summary (
    id integer NOT NULL,
    device_id integer NOT NULL,
    domains text[],
    total_queries integer NOT NULL,
    blocked_queries integer NOT NULL,
    avg_latency_ms numeric,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.dns_query_summary OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 82022)
-- Name: dns_query_summary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dns_query_summary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dns_query_summary_id_seq OWNER TO postgres;

--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 213
-- Name: dns_query_summary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dns_query_summary_id_seq OWNED BY public.dns_query_summary.id;


--
-- TOC entry 219 (class 1259 OID 82199)
-- Name: ip_geo_cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ip_geo_cache (
    ip inet NOT NULL,
    country text,
    region text,
    city text,
    lat double precision,
    lon double precision,
    org text,
    last_lookup timestamp with time zone DEFAULT now()
);


ALTER TABLE public.ip_geo_cache OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 81996)
-- Name: network_device; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.network_device (
    id integer NOT NULL,
    mac_address macaddr NOT NULL,
    ip_address inet,
    hostname text,
    name text,
    display_name text,
    comment text,
    is_dhcp boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    vendor text
);


ALTER TABLE public.network_device OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 81995)
-- Name: network_device_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.network_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.network_device_id_seq OWNER TO postgres;

--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 209
-- Name: network_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.network_device_id_seq OWNED BY public.network_device.id;


--
-- TOC entry 221 (class 1259 OID 82208)
-- Name: network_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.network_session (
    id bigint NOT NULL,
    device_id integer,
    protocol text,
    src_ip inet,
    src_port integer,
    dst_ip inet,
    dst_port integer,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone,
    bytes_sent bigint DEFAULT 0,
    bytes_received bigint DEFAULT 0,
    assured boolean,
    last_refresh timestamp with time zone NOT NULL
);


ALTER TABLE public.network_session OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 82207)
-- Name: network_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.network_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.network_session_id_seq OWNER TO postgres;

--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 220
-- Name: network_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.network_session_id_seq OWNED BY public.network_session.id;


--
-- TOC entry 216 (class 1259 OID 82037)
-- Name: network_usage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.network_usage (
    id integer NOT NULL,
    device_id integer,
    app_protocol text,
    download_bytes bigint,
    upload_bytes bigint,
    "timestamp" timestamp with time zone DEFAULT now() NOT NULL,
    download_packets bigint,
    upload_packets bigint
);


ALTER TABLE public.network_usage OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 82036)
-- Name: network_usage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.network_usage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.network_usage_id_seq OWNER TO postgres;

--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 215
-- Name: network_usage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.network_usage_id_seq OWNED BY public.network_usage.id;


--
-- TOC entry 218 (class 1259 OID 82052)
-- Name: scan_subnet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scan_subnet (
    id integer NOT NULL,
    cidr cidr NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    label text
);


ALTER TABLE public.scan_subnet OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 82051)
-- Name: scan_subnet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scan_subnet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scan_subnet_id_seq OWNER TO postgres;

--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 217
-- Name: scan_subnet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scan_subnet_id_seq OWNED BY public.scan_subnet.id;


--
-- TOC entry 3264 (class 2604 OID 82011)
-- Name: device_scan_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_scan_log ALTER COLUMN id SET DEFAULT nextval('public.device_scan_log_id_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 82026)
-- Name: dns_query_summary id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dns_query_summary ALTER COLUMN id SET DEFAULT nextval('public.dns_query_summary_id_seq'::regclass);


--
-- TOC entry 3262 (class 2604 OID 81999)
-- Name: network_device id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_device ALTER COLUMN id SET DEFAULT nextval('public.network_device_id_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 82211)
-- Name: network_session id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_session ALTER COLUMN id SET DEFAULT nextval('public.network_session_id_seq'::regclass);


--
-- TOC entry 3267 (class 2604 OID 82040)
-- Name: network_usage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_usage ALTER COLUMN id SET DEFAULT nextval('public.network_usage_id_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 82055)
-- Name: scan_subnet id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scan_subnet ALTER COLUMN id SET DEFAULT nextval('public.scan_subnet_id_seq'::regclass);


--
-- TOC entry 3280 (class 2606 OID 82016)
-- Name: device_scan_log device_scan_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_scan_log
    ADD CONSTRAINT device_scan_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 82030)
-- Name: dns_query_summary dns_query_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dns_query_summary
    ADD CONSTRAINT dns_query_summary_pkey PRIMARY KEY (id);


--
-- TOC entry 3288 (class 2606 OID 82206)
-- Name: ip_geo_cache ip_geo_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ip_geo_cache
    ADD CONSTRAINT ip_geo_cache_pkey PRIMARY KEY (ip);


--
-- TOC entry 3276 (class 2606 OID 82006)
-- Name: network_device network_device_mac_address_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_device
    ADD CONSTRAINT network_device_mac_address_key UNIQUE (mac_address);


--
-- TOC entry 3278 (class 2606 OID 82004)
-- Name: network_device network_device_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_device
    ADD CONSTRAINT network_device_pkey PRIMARY KEY (id);


--
-- TOC entry 3291 (class 2606 OID 82217)
-- Name: network_session network_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_session
    ADD CONSTRAINT network_session_pkey PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 82045)
-- Name: network_usage network_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_usage
    ADD CONSTRAINT network_usage_pkey PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 82061)
-- Name: scan_subnet scan_subnet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scan_subnet
    ADD CONSTRAINT scan_subnet_pkey PRIMARY KEY (id);


--
-- TOC entry 3289 (class 1259 OID 82225)
-- Name: idx_network_session_unique_open; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_network_session_unique_open ON public.network_session USING btree (protocol, src_ip, dst_ip, src_port, dst_port) WHERE (end_time IS NULL);


--
-- TOC entry 3292 (class 1259 OID 82223)
-- Name: ns_active_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ns_active_idx ON public.network_session USING btree (end_time);


--
-- TOC entry 3293 (class 1259 OID 82224)
-- Name: ns_lookup_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ns_lookup_idx ON public.network_session USING btree (src_ip, protocol, dst_ip, src_port, dst_port, end_time);


--
-- TOC entry 3294 (class 2606 OID 82017)
-- Name: device_scan_log device_scan_log_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_scan_log
    ADD CONSTRAINT device_scan_log_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.network_device(id) ON DELETE CASCADE;


--
-- TOC entry 3295 (class 2606 OID 82031)
-- Name: dns_query_summary dns_query_summary_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dns_query_summary
    ADD CONSTRAINT dns_query_summary_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.network_device(id) ON DELETE CASCADE;


--
-- TOC entry 3297 (class 2606 OID 82218)
-- Name: network_session network_session_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_session
    ADD CONSTRAINT network_session_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.network_device(id) ON DELETE SET NULL;


--
-- TOC entry 3296 (class 2606 OID 82046)
-- Name: network_usage network_usage_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_usage
    ADD CONSTRAINT network_usage_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.network_device(id) ON DELETE SET NULL;


-- Completed on 2025-07-06 09:10:59 UTC

--
-- PostgreSQL database dump complete
--

