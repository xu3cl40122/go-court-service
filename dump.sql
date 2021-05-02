--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE template_postgis;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md580b96084cc0560d9a3985a5112290b28';






--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: postgres; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE postgres SET search_path TO '$user', 'public', 'tiger';


\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO postgres;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO postgres;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: court; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.court (
    court_id integer NOT NULL,
    name character varying(150) NOT NULL,
    address character varying(150) NOT NULL,
    city_code character varying(20),
    dist_code character varying(20),
    latitude numeric,
    longitude numeric,
    phone character varying(50),
    logo_url character varying,
    description character varying,
    open_status character varying NOT NULL,
    geometry public.geometry(Point,4326),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.court OWNER TO postgres;

--
-- Name: court_court_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.court_court_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.court_court_id_seq OWNER TO postgres;

--
-- Name: court_court_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.court_court_id_seq OWNED BY public.court.court_id;


--
-- Name: file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file (
    file_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    file_name character varying(150) NOT NULL,
    tag character varying(150),
    file_url character varying(300),
    created_by character varying(300) NOT NULL,
    reference_id character varying(300) NOT NULL,
    is_public boolean DEFAULT true NOT NULL,
    description text,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.file OWNER TO postgres;

--
-- Name: game; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game (
    game_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    game_name character varying(150) NOT NULL,
    host_user_id uuid NOT NULL,
    game_start_at timestamp without time zone NOT NULL,
    game_end_at timestamp without time zone NOT NULL,
    sell_start_at timestamp without time zone NOT NULL,
    sell_end_at timestamp without time zone NOT NULL,
    total_player_number integer,
    court_type character varying NOT NULL,
    game_type character varying NOT NULL,
    description character varying,
    game_status character varying DEFAULT 'PENDING'::character varying NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    is_public boolean NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    court_id integer NOT NULL
);


ALTER TABLE public.game OWNER TO postgres;

--
-- Name: game_stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_stock (
    game_stock_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    game_id uuid NOT NULL,
    spec_name character varying(100) NOT NULL,
    stock_amount integer NOT NULL,
    price integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CHK_a6bf9265d35a4f9762e5ac7d28" CHECK ((stock_amount >= 0))
);


ALTER TABLE public.game_stock OWNER TO postgres;

--
-- Name: game_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_ticket (
    game_ticket_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    game_id uuid NOT NULL,
    game_stock_id uuid NOT NULL,
    owner_user_id uuid NOT NULL,
    game_ticket_status character varying DEFAULT 'PENDING'::character varying NOT NULL,
    "isPaid" boolean DEFAULT false NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.game_ticket OWNER TO postgres;

--
-- Name: game_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_user (
    game_ticket_id uuid NOT NULL,
    game_stock_id uuid NOT NULL,
    game_id uuid,
    game_user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.game_user OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    user_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    profile_name character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    gender character varying(50),
    phone character varying(150),
    password character varying(150) NOT NULL,
    user_status character varying(50) DEFAULT 'INITIAL'::character varying NOT NULL,
    user_role character varying(50) DEFAULT 'NORMAL_USER'::character varying NOT NULL,
    description character varying,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: verification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification (
    verification_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    verification_code character varying(50) NOT NULL,
    verification_type character varying(50) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    "userIdUserId" uuid
);


ALTER TABLE public.verification OWNER TO postgres;

--
-- Name: court court_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.court ALTER COLUMN court_id SET DEFAULT nextval('public.court_court_id_seq'::regclass);


--
-- Data for Name: court; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.court (court_id, name, address, city_code, dist_code, latitude, longitude, phone, logo_url, description, open_status, geometry, created_at, updated_at) FROM stdin;
1	撏??葉????擗?	?啣?撣??????銝頝臭?畾?0??65000	65000170	25.06754853	121.3695019	02-26095829#133	https://az804957.vo.msecnd.net/photogym/20140716092641_IMG_5446 (2).JPG	????擗?,????擗?	FREE	0101000020E6100000D5134CEBA5575E402D3E47DC4A113940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
2	蝷漯??????擗?	摰蝮??皞芷?憭批???皞芾楝?挾135??10002	10002050	24.82226354	121.7684484	03-9882047	https://az804957.vo.msecnd.net/photogym/20140716143305_13.jpg	????擗?	CLOSE	0101000020E610000077AA32422E715E4042FE04DD7FD23840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
3	?啣???蝐????箏?撣?憯??啣???10銋???67000	67000050	23.36153182	120.3236432	06-6621981	https://az804957.vo.msecnd.net/photogym/20140716152239_DSC05003.JPG	蝐???擗?	FREE	0101000020E6100000A9E4F791B6145E40055D6F598D5C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
4	????瘣餃?銝剖?	?啣?撣邦??瞏剖???甇脰?59??65000	65000070	24.99772471	121.4255936	02-26812625#833	https://az804957.vo.msecnd.net/photogym/20140716195840_瘣餃?銝剖?.jpg	????擗?,????擗?	CLOSE	0101000020E6100000C358F0EC3C5B5E4070DCF7E26AFF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
5	擃??怠飛憭批飛????擗?	擃?撣?瘞??銝頝?00??64000	64000050	22.64766359	120.3095979	07-3121101#2124	https://az804957.vo.msecnd.net/photogym/20140716224619_?22.jpg	????擗?	CLOSE	0101000020E610000042DAB573D0135E4026DCF147CDA53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
6	獢?颲脣極憸券?(擗?	獢?撣?????頝臭?畾?44??68000	68000010	24.99168851	121.3199294	03-3333921#350	https://az804957.vo.msecnd.net/photogym/20140716134433_IMG_20140716_134500.jpg	????擗?	PAID	0101000020E6100000DA8129B979545E40DB44564CDFFD3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
7	????瘣餃?銝剖?	??蝮????蝳???鞈Ｚ?61??10005	10005010	24.56872674	120.8263411	037-260466	https://az804957.vo.msecnd.net/photogym/20140717094109_IMAG0010.jpg	蝮賢??湧尹	CLOSE	0101000020E6100000CDF5C7C5E2345E4023A95C1398913840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
8	?擃葉憭抒旨???箏?撣??頝?1??67000	67000320	22.98868384	120.2173322	06-2386501#221	https://az804957.vo.msecnd.net/photogym/20140716085215_隤踵憭批?DSC02883.JPG	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E610000089D750C5E80D5E403AE256621AFD3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
9	?撐??銝剜??(擗?	?箔葉撣?撅臬??旨??摨楝699??66000	66000080	24.19469636	120.6779158	04-24210380#723	https://az804957.vo.msecnd.net/photogym/20140717103736_DSC04091.JPG	????FREE	0101000020E6100000449CF3F8622B5E40A9D9E29ED7313840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
10	?啗??葉????擗?	?箏?撣???啣?頝?7??67000	67000330	22.97724391	120.1861382	06-2633171	https://az804957.vo.msecnd.net/photogym/20140717114952_DSCN0456.JPG	????擗?	FREE	0101000020E6100000536232B0E90B5E4048AA29A82CFA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
11	????擃擗??箏?撣?頠?????32??67000	67000160	23.22056586	120.1614779	06-7942031#13	https://az804957.vo.msecnd.net/photogym/20140717120324_DSCN0025.JPG	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E6100000B6E166A7550A5E406A50130177383740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
12	???亙熒蝞∠?撠?摮豢?????啣?撣摨?瘞?頝?12??65000	65000060	24.97755345	121.5362978	02-22191131#5323	https://az804957.vo.msecnd.net/photogym/20140715141800_????.JPG	摰文?蝐???????擗?	CLOSE	0101000020E6100000ACFA01B452625E408BD761F140FA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
13	鞊???瘣餃?銝剖?	?箔葉撣????啁??楝155??66000	66000090	24.25464349	120.7202625	04-25222066	https://az804957.vo.msecnd.net/photogym/20140718104731_蝳桀?1.jpg	????擗?	CLOSE	0101000020E61000004182E2C7182E5E4076B0D55030413840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
14	?⊥?摰嗅?????敶啣?蝮???銝剜迤頝?6??10007	10007100	23.95027304	120.577966	04-8320260#229	https://az804957.vo.msecnd.net/photogym/20140721105802_????.jpg	????FREE	0101000020E6100000CC0C1B65FD245E400C120D1845F33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
15	靽桀噸???????箏?撣?皜臬??望銵?18撌?6??63000	63000090	25.04481538	121.5894002	02-27880500	https://az804957.vo.msecnd.net/photogym/20140721120335_IMG_3703.JPG	????擗?	CLOSE	0101000020E610000060D09DBBB8655E4033754F05790B3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
16	憭折??葉擃擗??箔葉撣之??摮詨?頝?80??66000	66000180	24.22370482	120.6510133	04-25672171#304	https://az804957.vo.msecnd.net/photogym/20140721150852_mobile52101861-184a-4891-bdd1-870edcfabb07.jpg	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E6100000B530B033AA295E4089DB15B844393840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
17	憭折??葉?啣????箔葉撣之??摮詨?頝?80??66000	66000180	24.22448266	120.6514317	04-25672171#304	https://az804957.vo.msecnd.net/photogym/20140721154753_mobilef86b133c-64f2-4e8e-92fc-603db7691cf2.jpg	蝐???????擗?	FREE	0101000020E6100000F9C4950EB1295E40163813B277393840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
18	????蝐????箔葉撣?撅臬??祉?頝臭?畾?00??66000	66000070	24.15334214	120.6375647	04-22596907	https://az804957.vo.msecnd.net/photogym/20140722111417_22243.jpg	蝐???????FREE	0101000020E610000061E52BDCCD285E400E66346E41273840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
19	???葉瘣餃?銝剖?	?箏?撣???瘞貉??銋???67000	67000170	23.2531976	120.1283044	06-7862014#14	https://az804957.vo.msecnd.net/photogym/20140709111215_IMG_4679.JPG	瘣餃?銝剖?	CLOSE	0101000020E6100000B57BA82336085E40FA6CD38ED1403740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
20	????瘣餃?銝剖?	?箔葉撣?撅臬??祉?頝臭?畾?00??66000	66000070	24.15257855	120.6381601	04-22596907#724	https://az804957.vo.msecnd.net/photogym/20140722114958_22242.jpg	????擗?,頨脤?	CLOSE	0101000020E61000002CC7759DD7285E4034524A630F273840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
21	?亙??葉????擗?	?箔葉撣之?脣?銝剖控頝臭?畾?9-11??66000	66000110	24.37767574	120.6509328	04-26813721#532	https://az804957.vo.msecnd.net/photogym/20140722115936_33.jpg	????擗?	FREE	0101000020E610000033F90BE2A8295E40E8CA775BAF603840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
22	??憭批飛擃擗???蝮??撖折?憭批飛頝???9020	9020040	24.44728808	118.3221531	082-313802	https://az804957.vo.msecnd.net/photogym/20140718135721_IMG_3751.JPG	蝐???蝢賜???擗?,????擗?,???恕,獢???擗?,?亥澈???恍???蝺游恕),憯???憯???FREE	0101000020E6100000853309289E945D409A7DBB7881723840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
23	憭批???蝐???敶啣?蝮??暽賡?鞊黎???楝45銋???10007	10007140	23.97956295	120.4880731	04-8853760	https://az804957.vo.msecnd.net/photogym/20140722102650_CIMG3791.JPG	蝢賜???擗?,????擗?	FREE	0101000020E6100000ABA3F4963C1F5E408F9F32A3C4FA3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
24	?ㄐ???唳暑?葉敹???蝮??鋆⊿銝剖控頝?07??10005	10005020	24.44910059	120.6548354	03-7861013#25	https://az804957.vo.msecnd.net/photogym/20160909174637_1JWTMG9MOA6UAUTY4JG7.jpg	????擗?	CLOSE	0101000020E6100000D6D0BCD2E8295E4010AA9A41F8723840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
25	??葉擃擗?擃?撣?????賡?膨瘚瑁楝?挾29??64000	64000260	22.90598503	120.1812887	07-6900054#31	https://az804957.vo.msecnd.net/photogym/20140616140802_P1040421.JPG	蝢賜???擗?,頝?/擗?????擗?	CLOSE	0101000020E61000009968EB3B9A0B5E40FD838AA2EEE73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
26	撱箏??葉?啣?????蝮?隞賡撱箏?頝?19??10005	\N	24.69448759	120.9103882	037-691491	https://az804957.vo.msecnd.net/photogym/20140722100508_?湧尹-1.jpg	?啣???蝐???????蝐??????)	FREE	0101000020E6100000846ADECC433A5E4022874EF0C9B13840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
27	?啁??蝐???擃?撣樴??啁??撟唾楝130??64000	64000320	23.03244566	120.6623966	07-6791387	https://az804957.vo.msecnd.net/photogym/20140619103055_?啁??-蝐??渡??jpg	蝐???擗?,蝢賜???擗?,頨脤?	FREE	0101000020E6100000D27EB5B4642A5E40DE98D85B4E083740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
28	?姘?葉蝐????	??蝮?姘撅梢?姘???勗毽20??10008	10008040	23.66767853	120.6719935	049-2711014	https://az804957.vo.msecnd.net/photogym/20160628102531_璅黎蝞?jpg	蝐???FREE	0101000020E6100000F96706F1012B5E406397EAFAECAA3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
29	蝡寞擃葉?????啁姘蝮?姘?梢憭扳?頝???10004	10004020	24.73300441	121.0882187	03-5962024#303	https://az804957.vo.msecnd.net/photogym/20170417144810_Y4ZT3SG91M1FG5SNGPUP.jpg	????擗?	CLOSE	0101000020E610000052D90B60A5455E4016C6502DA6BB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
30	蝡寞擃葉?????啁姘蝮?姘?梢憭扳?頝???10004	10004020	24.73300441	121.0882187	03-5962024#303	https://az804957.vo.msecnd.net/photogym/20170417144417_8JH3NJ4HW4NM3JA3TZ3E.jpg	????擗?	CLOSE	0101000020E610000052D90B60A5455E4016C6502DA6BB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
31	銝?擃葉?	?啣?撣?瘣脣?銝?頝?6??65000	65000140	25.08664831	121.4737165	02-22894675#231	https://az804957.vo.msecnd.net/photogym/20170420103337_IB0JTBBDKJ8WYN5VNXYA.jpg	????擗?	FREE	0101000020E6100000D6C4025F515E5E4024B469952E163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
32	????瘣餃?銝剖?	?梯蝮??摰??梢???銵?3??10015	10015050	23.96276899	121.5965348	03-8528720#313	https://az804957.vo.msecnd.net/photogym/20140612165655_YI8JPLMKBOVUSUN8HITF.JPG	憸券?恕,蝐???CLOSE	0101000020E6100000423B4CA02D665E4028A74D0778F63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
33	暽踵葛??瘣餃?銝剖?????敶啣?蝮?嘀皜舫????瘞楝192??10007	10007020	24.05245028	120.4335076	04-7772038	https://az804957.vo.msecnd.net/photogym/20140707143703_BUDA6THZGJDX8H9V0JXT.JPG	?蝐???頨脤?,????擗?	FREE	0101000020E61000005124A996BE1B5E401B44AD616D0D3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
34	蝡孵??葉頨脤?(????梁)	敶啣?蝮?姘憛?蝡孵??姘?楝銝畾?50??10007	10007250	23.86480374	120.4257452	04-8972034#14	https://az804957.vo.msecnd.net/photogym/20140707152104_DSC06079.JPG	頨脤?	FREE	0101000020E6100000749BCB683F1B5E402CC224C763DD3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
35	蝐??湛??????箸蝮?云暻駁??之??敺瑁?頝?8??10014	10014090	22.61521915	121.00595	08-9781324#20	https://az804957.vo.msecnd.net/photogym/20140701093837_DSC_1006.JPG	????擗?	FREE	0101000020E610000051DA1B7C61405E40781F91007F9D3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
36	撟喳??葉?????梯蝮?ˊ鞊?撟喳??像?楝48??10015	10015060	23.88440544	121.5178174	03-8661221#12	https://az804957.vo.msecnd.net/photogym/20170421142155_62NS06W93FU5V8AYVY92.jpg	????擗?	CLOSE	0101000020E61000002F9397EB23615E405934196568E23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
37	皜臬???瘣餃?銝剖?	擃?撣?皜臬?撟喳??楝300??64000	64000110	22.56827906	120.3379753	07-8131506#224	https://az804957.vo.msecnd.net/photogym/20140616110528_瘣餃?銝剖??冽(?芾?).jpg	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E6100000C5162763A1155E409DB389BC7A913640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
38	璅黎??擃擗?擃?撣??桀??脫?頝?1??64000	\N	22.60807827	120.3224427	07-7225846#724	https://az804957.vo.msecnd.net/photogym/20140619120033_K:\\DCIM\\204___06\\IMG_0634.JPG	????擗?	CLOSE	0101000020E61000005FD5B4E6A2145E40EA0E7B04AB9B3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
39	擐砍擃葉擃擗?瞉?蝮?收?砍?銝剛頝?69??10016	10016010	23.57291569	119.5797658	06-9272342#331	https://az804957.vo.msecnd.net/photogym/20140603092847_NT0J1BIPTR615H4ATZ9K.jpg	蝐???????擗?,蝐???蝢賜???擗?,?啣???獢???擗?	PAID	0101000020E6100000B79503E21AE55D404FEA479AAA923740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
40	?噸擃葉????擗?	?啣?撣?撜賢?銝剜迤頝臭?畾?99??65000	65000090	24.90422639	121.3663101	02-26723302#235	https://az804957.vo.msecnd.net/photogym/20140616092139_IMG_20140616_090331.jpg	????擗?	CLOSE	0101000020E610000073ECEA9F71575E40EB3A75617BE73840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
41	?擃葉摰文?蝐??	??蝮?隞賡銝剜迤銝頝?01??10005	\N	24.68681594	120.9359765	037-663403#313	https://az804957.vo.msecnd.net/photogym/20140618112904_20111222307.jpg	蝐??	FREE	0101000020E6100000C554FA09E73B5E40E7AB602BD3AF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
42	銝郭???啣????儔撣正?銝郭頝臭?畾?87??10020	10020020	23.48846827	120.4286957	05-2338264	https://az804957.vo.msecnd.net/photogym/20140613154051_DSCN1476.JPG	?啣???蝐???????擗?,頨脤?	CLOSE	0101000020E6100000E5DB16C06F1B5E40A0C8AC410C7D3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
43	?交??蝬??	?箏?撣???頝臭?畾?73??67000	67000330	22.97234079	120.1899586	06-2912931#521	https://az804957.vo.msecnd.net/photogym/20160707092922_E3DSK419TFOIRT3JFBIX.jpg	????擗?	FREE	0101000020E610000003A61D48280C5E40E79D7553EBF83640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
44	瘞港??葉摰文?憭??賣?蝢賜????儔蝮?偌銝?瘞港??脣飛銵?5??10010	10010120	23.42529243	120.3952944	05-2682024#12	https://az804957.vo.msecnd.net/photogym/20180507104859_GU0S6OK1Q4D6ML7ZBYI6.JPG	瘞港??葉摰文?憭??賣??噬?	FREE	0101000020E6100000AF12E2804C195E401C16F6F6DF6C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
45	?暸翩擃葉瘣餃?銝剖?	?箏?撣ㄚ??蝢拐縑?敺瑁楝4畾?77??63000	63000110	25.08645398	121.5235519	02-28831568	https://az804957.vo.msecnd.net/photogym/20140529142146_?暸翩擃葉瘣餃?銝剖?.jpg	蝐???????擗?,蝢賜???擗?	PAID	0101000020E61000008E10D4DF81615E4084B518D921163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
46	?箏?鈭葉????擗?	?箏?撣????頝臭?畾?25??67000	67000340	23.00558688	120.2124774	06-2514526#401	https://az804957.vo.msecnd.net/photogym/20140611165315_mobile831d0fb2-8109-4f3b-96f4-8f77c8ec06d2.jpg	????擗?	FREE	0101000020E6100000E708CF3A990D5E40FDE24A246E013740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
47	?斤?蝘之?嗅??(???氬??????雯?)	?箔葉撣云撟喳??芣??葉撅梯楝鈭挾57??66000	66000270	24.14549459	120.730927	04-23924505#5621	https://az804957.vo.msecnd.net/photogym/20161121141407_VEU1L0WBDLIJFE85LL4D.JPG	?啣???????擗?,蝐???????擗?	FREE	0101000020E6100000DB300A82C72E5E4080CB29223F253840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
48	銝剛憭批飛瘣餃?銝剖?	?啁姘撣?撅勗??梢???蝳楝鈭挾707??10018	10018030	24.75892248	120.9542316	03-5186812	https://az804957.vo.msecnd.net/photogym/20140618110929_IMG_8656.JPG	蝢賜???擗?,???恕,蝐???????擗?	FREE	0101000020E6100000D3B36A21123D5E4099CC5FBE48C23840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
49	?踵祥憭批飛擃擗??箏?撣?撅勗???頝臭?畾?4??63000	63000080	24.98500288	121.5736556	02-29393091#62964	https://az804957.vo.msecnd.net/photogym/20140529165724_W3WV3WO2NW7IGELU06BS.jpg	蝐???????蝢賜???獢?摰????恕,蝬??恕,??摰?CLOSE	0101000020E6100000B44AFAC5B6645E40D910142629FC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
50	?臬?擃?銝剖飛????擗?	?啣?撣璈?憭扯?頝臭?畾?2??65000	65000010	25.00546353	121.4458001	02-29684131#341	https://az804957.vo.msecnd.net/photogym/20140609183344_??擗典?舐??jpg	????擗? ,?亥澈???恍???蝺游恕),憌憚?恕	PAID	0101000020E61000006D8324FD875C5E40B4ABD20E66013940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
51	??擃葉?啣???獢?撣?撅勗??芰銵?0??68000	68000070	25.02016278	121.4029866	02-82098313#501	https://az804957.vo.msecnd.net/photogym/20140604082800_IMG_0863.jpg	?啣???蝐???蝢賜???????PAID	0101000020E61000007BEE4E88CA595E404AB2506329053940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
52	?啣?瘚瑟?蝘?憭批飛?啣????箏?撣ㄚ??撱嗅像?楝銋挾212??63000	63000110	25.1087228	121.4710557	02-28102292#2246	https://az804957.vo.msecnd.net/photogym/20140613114150_憯急??啣??游?臬?蝮?JPG	蝐???????擗?,?啣???FREE	0101000020E61000000A86CEC6255E5E405D54E641D51B3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
53	???葉撠?撠頨脤?	敶啣?蝮????????楝銝畾?65??10007	10007200	23.89640788	120.4266865	04-8904600#22	https://az804957.vo.msecnd.net/photogym/20180808091608_5J8EAK0R3H0BNNBY4UBZ.JPG	蝐???????擗?,頨脤?	FREE	0101000020E610000043C9E4D44E1B5E40097AA0FC7AE53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
54	?箇撣怎?憭批飛擃擗??啣?撣????隞?頝臭?畾???65000	65000170	25.06834057	121.4032602	02-77148466	https://az804957.vo.msecnd.net/photogym/20140604142414_10411391_669670059771081_8249484465687623851_n.jpg	蝢賜???擗?,蝐???????擗?,憭折敺?摰?撠敺?摰??亥澈???恍???蝺游恕),獢???擗?	PAID	0101000020E6100000D2B1DE03CF595E40D72381C47E113940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
55	銝剛??葉?啣???獢?撣????葉頝?22??68000	68000010	24.99748891	121.2906504	03-3600145	https://az804957.vo.msecnd.net/photogym/20140611165640_20140610_161006.jpg	?啣???蝐???????擗?	FREE	0101000020E610000070A422049A525E409C92E66E5BFF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
56	憭批噸?葉?啣????怎??2摨扼??1摨?	?箔葉撣?撅臬??瑚葉銵?銋?3??66000	66000080	24.1804221	120.6694293	04-22916984	https://az804957.vo.msecnd.net/photogym/20140718115835_IMG_3300[1].JPG	蝐???????FREE	0101000020E6100000FD9EFDEDD72A5E40C4F98A24302E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
57	撖西?憭批飛H摰輸憭拍?????擃??∪?)	擃?撣??憭批飛頝?00??64000	64000350	22.90517278	120.4667274	07-6678888#3261	https://az804957.vo.msecnd.net/photogym/20140618155922_H摰輸憭拍?????JPG	????擗?,蝐???蝬脩???擗?	CLOSE	0101000020E61000006AC999DCDE1D5E4054543F67B9E73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
58	?箔葉撣蔬摮????	?啁?唬葉撣蔬摮??銝頝?22-248??撠	\N	\N	24.20895729	120.703497	04-25343542#215	https://az804957.vo.msecnd.net/photogym/20181011112316_GB0SHFOQGTLZ7BAUPM65.JPG	瘝?????CLOSE	0101000020E610000062F54718062D5E4090CF96397E353840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
59	???葉擃擗??啁姘蝮?????圈陶??4??10004	10004070	24.76188858	121.0916305	03-5922775#47	https://az804957.vo.msecnd.net/photogym/20140609170805_4UT7BBF6SHTRFV3SZ0XF.JPG	蝐???????FREE	0101000020E61000003B342C46DD455E40BF4B46210BC33840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
91	?迤?葉擃擗?撅蝮???勗?憭折?楝70??10013	10013010	22.67907935	120.4982132	08-7363078	https://az804957.vo.msecnd.net/photogym/20140620113631_DSC04174.JPG	蝐???????蝬脩???擗?,蝐???PAID	0101000020E6100000DF1B9EB9E21F5E4091A3EF24D8AD3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
60	???葉蝐?????蝮????瞍喳???蟡楝361??10008	10008010	23.91323891	120.6746918	049-2222549#220	https://az804957.vo.msecnd.net/photogym/20140606095737_DSC_0232.JPG	蝐???????擗?,頨脤?	FREE	0101000020E610000048F883262E2B5E407BE27306CAE93740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
61	????憸券?	?儔撣???銵?5??10020	10020010	23.45913057	120.4562395	05-2232280	https://az804957.vo.msecnd.net/photogym/20200424111212_MD7F4HNKPNLOCCZPMWA0.jpg	蝐???????擗?	FREE	0101000020E61000002DE92807331D5E406CBEBE9489753740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
62	?唳葛??擃葉摰文??	?儔蝮?皜舫?摰桀???擃楝1??10010	10010070	23.56038776	120.3487551	05-3747060#254	https://az804957.vo.msecnd.net/photogym/20140715094456_DSC06593.JPG	摰文?????摰文?蝬脩???蝐???FREE	0101000020E61000000C34E90052165E4059477E92758F3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
63	?????啣?????擃?撣??剖?璈???蝟楝19撌???64000	64000200	22.75083543	120.3171623	07-6113804#32	https://az804957.vo.msecnd.net/photogym/20140630135540_05W26TNJK0XY62H3TQ04.jpg	?啣???蝐???????擗?,頝喲??游	CLOSE	0101000020E61000008C811A634C145E40318730C036C03640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
64	?剔??瘣餃?銝剖?	?箏?撣?脣?銝剜迤頝?19??67000	67000090	23.22527627	120.3490528	06-6982041	https://az804957.vo.msecnd.net/photogym/20140716163514_02.jpg	????擗?	CLOSE	0101000020E6100000F1248EE156165E400137A4B4AB393740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
65	暺姘??蝐????箔葉撣云撟喳?暺姘?姘?楝41??66000	66000270	24.08383731	120.7523775	04-22715933	https://az804957.vo.msecnd.net/photogym/20140721224408_D306XT13ZIYXS08DLP6E.jpg	蝐???擗?	FREE	0101000020E6100000C22FF5F326305E4076A2A85C76153840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
66	撏????????箔葉撣之??憭扳?頝?81??66000	66000280	24.11410444	120.6844336	04-24818836#5031	https://az804957.vo.msecnd.net/photogym/20140806143549_P1050360.JPG	????擗?,?啣???FREE	0101000020E6100000261296C2CD2B5E40DE20D6F2351D3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
67	??葉?啣?????蝮?隞賡撠???00??10005	\N	24.65581259	120.8802938	03-7624260	https://az804957.vo.msecnd.net/photogym/20140703150052_DSC06362.JPG	?啣???璉????毀蝧,蝐???????擗?	FREE	0101000020E6100000C877CEBB56385E40E55A7A55E3A73840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
68	撅擃葉瘣餃?銝剖?	撅蝮???勗?敹?頝?31??10013	10013010	22.68612921	120.4877244	08-7656444#350	https://az804957.vo.msecnd.net/photogym/20140604184347_7QWNT91W0VDAZGXBG6YA.jpg	????FREE	0101000020E610000085DD66E0361F5E40C3C7F529A6AF3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
69	頛???蝐???撅蝮??皜舫?頛????楝1銋???10013	10013090	22.77835211	120.5244797	08-7752271	https://az804957.vo.msecnd.net/photogym/20140710114939_1.jpg	????擗?	FREE	0101000020E61000009EBA4D1391215E40FC38791542C73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
70	蝬??	??蝮??瘙?瘞渡冗?葉撅梯楝190??10008	10008090	23.86794112	120.9100208	049-2855145#13	https://az804957.vo.msecnd.net/photogym/20170705080306_8CDPHWPZSZG159RJSLNB.jpg	????擗?	FREE	0101000020E610000081ABE1C73D3A5E40ED40A56331DE3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
71	摰文?憭??賜???摰蝮???剖?璅嫣犖頝?7??10002	\N	24.76216519	121.7568009	03-9322519	https://az804957.vo.msecnd.net/photogym/20170929093139_JUVC8LGMUNKUX1YA1YAV.JPG	蝐???????擗?	FREE	0101000020E610000056C50A6D6F705E401B3305421DC33840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
72	樴??葉?????箏?撣?撏??啣?摮?58??67000	67000300	22.9690622	120.3601599	06-5941475#10	https://az804957.vo.msecnd.net/photogym/20140708090023_CIMG2738.JPG	????CLOSE	0101000020E610000029F51BDC0C175E4031CAD87514F83640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
73	??啣???61251?儔蝮?云靽????7?唬葉?楝銝畾?50??\N	\N	23.50037249	120.3780282	05-2373029#124	https://az804957.vo.msecnd.net/photogym/20191118105638_1RHLDCQVVUE85PHF5XTV.jpg	蝐???????蝢賜???擗?	FREE	0101000020E6100000CFFD309D31185E403B5E586918803740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
74	?郎?葉?啣????啁姘撣??儔頝臭?畾?12??10018	10018010	24.78808534	121.0129615	03-5778784	https://az804957.vo.msecnd.net/photogym/20160509094333_蝺仿??輸蝷箸???JPG	?啣????啣??湧?閮剜??,蝬脩???FREE	0101000020E6100000DBA6785CD4405E40CDC1F9F5BFC93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
75	摰?縑???啣????儔撣?摰?縑銵?66??10020	10020010	23.47026822	120.4597878	05-2223904#2921	https://az804957.vo.msecnd.net/photogym/20140606150453_DSC_1611.jpg	?啣???頨脤?,????擗?	FREE	0101000020E61000006306CF296D1D5E40863F817F63783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
76	蝐????啣?撣???瘞詨祐頝?8??65000	65000130	24.96287208	121.4295352	02-22675135#401	https://az804957.vo.msecnd.net/photogym/20170707142741_IKD57LWCWP8TDQ6DKQ2F.JPG	蝐???FREE	0101000020E6100000C61E35817D5B5E40DDD4DDC87EF63840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
77	???葉????	?啣?撣???瘞詨祐頝?8??65000	65000130	24.96186502	121.4296736	02-22675135#401	https://az804957.vo.msecnd.net/photogym/20200504111900_86UXT9CJ1U3J8NE2XBSZ.jpg	????擗?	CLOSE	0101000020E610000018FDB2C57F5B5E40FF1034C93CF63840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
78	???葉?啣????儔撣??喳?頝?11??10020	10020010	23.4691906	120.4625452	05-2224383#225	https://az804957.vo.msecnd.net/photogym/20140718155936_M7K92JMVKX616NRMZGFF.jpg	?啣???蝐???????擗?	PAID	0101000020E6100000FEBA2E579A1D5E4033970AE01C783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
79	???葉?????箏?撣?撱?銝剖控頝臭?畾?72??67000	67000290	22.96073462	120.3243095	06-5951181#202	https://az804957.vo.msecnd.net/photogym/20200505144446_8XK6R7T54B9SOHVKFARQ.jpg	????擗?	CLOSE	0101000020E61000000E12A27CC1145E40F5083DB4F2F53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
80	????憸券?	?箏?撣?????銵?畾?05撌?2??67000	67000350	23.07683979	120.1164651	06-2577631	https://az804957.vo.msecnd.net/photogym/20160505141013_DSC02394-1.jpg	????擗?	PAID	0101000020E610000006E8082A74075E40DE14C1C5AB133740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
81	瘙??葉?????箸蝮??銝??啗???摮貉楝88??10014	10014060	23.11484007	121.2049323	08-9862040	https://az804957.vo.msecnd.net/photogym/20200507151716_D5S13K82G4E9AWXKD4MJ.jpg	????FREE	0101000020E610000038995D9C1D4D5E409CEBA828661D3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
82	????????擗?	?儔撣正?????蝷曉偏頝?68??10020	10020020	23.49453932	120.4260135	05-2371330#128	https://az804957.vo.msecnd.net/photogym/20140711154615_DSCN0995.JPG	憸券?	FREE	0101000020E6100000E38920CE431B5E4070FCFD209A7E3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
83	?唬葉憟喃葉?啣????箔葉撣正??芰頝臭?畾?5??66000	66000040	24.13621905	120.6772131	04-22205108	https://az804957.vo.msecnd.net/photogym/20160504113717_DSC05599.JPG	蝐???蝬脩????????啣???CLOSE	0101000020E61000000F3B9D75572B5E409AD76C40DF223840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
84	?喟??葉摰文??????箏?撣??????楝1畾?39??63000	63000120	25.11590221	121.51297	02-28224682	https://az804957.vo.msecnd.net/photogym/20190819091909_U5G45HHQ55RAMSQW11A9.jpg	????擗?	CLOSE	0101000020E610000010751F80D4605E40F07B69C4AB1D3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
85	憯怠??????箏?撣ㄚ??敺葛?ㄚ?楝150??63000	63000110	25.09440482	121.5151425	02-28313114#306	https://az804957.vo.msecnd.net/photogym/20200512162319_TZWEWABXMYOJ1PEMEJXX.jpg	????擗?	CLOSE	0101000020E6100000E6913F18F8605E401A7C0EEA2A183940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
86	?瑕??葉蝬??	?箏?撣葉撅勗????瘙楝70撌?1??63000	63000040	25.04941617	121.5319236	02-25112382#309	https://az804957.vo.msecnd.net/photogym/20140728124342_DILLJU3XLQMNYP3T7B18.jpg	蝐???????蝢賜???FREE	0101000020E61000001E7E48090B625E40280BC289A60C3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
87	?剖?摰嗅??斗?璅?摰蝮???啗?頝?11??10002	10002040	24.85146768	121.8169749	03-9771131#123	https://az804957.vo.msecnd.net/photogym/20140530102832_P1130269.JPG	蝢賜???擗?,蝐???????擗?,蝐???蝬脩???擗?,?啣???頞喟????亥澈???恍???蝺游恕)	CLOSE	0101000020E6100000C949175149745E4074332FC9F9D93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
88	瞉?擃?瘚瑚?瘞渡?瑟平摮豢蝬?擃擗?瞉?蝮?收?砍?銝剛????楝63??10016	10016010	23.57042837	119.5640802	06-9261101#321	https://az804957.vo.msecnd.net/photogym/20140606104123_IMG_20140606_092401.jpg	蝐???獢???擗?,??摰?????擗?	CLOSE	0101000020E61000008ED4D6E319E45D404FDCF99707923740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
89	雿喳擃噙蝐???撅蝮?蔔?祇?雿喳?蔔颲脰楝67??10013	10013210	22.41239727	120.5641848	08-8662726#302	https://az804957.vo.msecnd.net/photogym/20140618145422_C:\\Documents and Settings\\Administrator\\My Documents\\My Pictures\\?祕?冽?閮剖?\\DSC03471.JPG	????擗?,蝐???????擗?	FREE	0101000020E61000009F39909A1B245E40149C13DE92693640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
90	???葉?????箏?撣縑蝢拙??曉噸頝?68撌?5??63000	63000020	25.03544	121.5721911	02-27232771#330	https://az804957.vo.msecnd.net/photogym/20160505092515_MMDA045S5UOFCCYAQJWL.JPEG	????FREE	0101000020E6100000FC636BC79E645E4062F8889812093940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
92	瘜唳郎?葉蝐???撅蝮?陸甇阡?雿喳像頝?20??10013	10013290	22.59144285	120.6331229	08-7831025#13	https://az804957.vo.msecnd.net/photogym/20140627094912_TYFNW68IC2ZBYUVMZ9CC.jpg	蝐???FREE	0101000020E61000005176E91585285E40FA3372CC68973640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
93	撖嗆??葉?????箸蝮??勗?隞?銵???10014	10014010	22.76955849	121.1448991	089-220011	https://az804957.vo.msecnd.net/photogym/20200527130014_2G8U89PYY0M5J07RBI8K.JPG	????擗?	FREE	0101000020E610000012EEDF0646495E40BEE802C901C53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
94	憭批祚?葉????擃?撣之撖桀?瘞貉?脣飛頝?50??64000	64000140	22.6026357	120.3928989	07-7837091#218	https://az804957.vo.msecnd.net/photogym/20140617140056_IMAG0263.jpg	????擗?,?啣???CLOSE	0101000020E61000009A886D4125195E40EEE64E55469A3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
95	???葉??身蝐??渲????游?蝬脩???獢?撣???銝剜迤頝?35??68000	68000010	25.00880244	121.3002816	03-3269340#313	https://az804957.vo.msecnd.net/photogym/20140617113342_DSC05692.JPG	?啣???蝐???????擗?,?蝐???FREE	0101000020E6100000CCE550D037535E40CDEC6FE040023940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
96	?舐?憟喃葉?????箏?撣?撅勗?璅??啗楝3畾?12??63000	63000080	24.98250034	121.5554237	02-29368847#339	https://az804957.vo.msecnd.net/photogym/20140822094303_?抒? 4-1.jpg	????擗?,????擗?	CLOSE	0101000020E610000018BBD80F8C635E40E09B6C2485FB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
97	?望撌亙??????箏?撣之摰?靽∠儔頝臬?畾?86撌???63000	63000030	25.03207616	121.5512037	02-27554616	https://az804957.vo.msecnd.net/photogym/20140821094353_VAMCL12YUYSOT74JXQX0.JPG	????擗?	CLOSE	0101000020E6100000CA3BE2EB46635E40672EAA2436083940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
98	瞍Ｗ?葉?啣??湧?閮剔?????	?箔葉撣正撅臬?瞍Ｗ頝臭?畾?4銋???66000	66000060	24.161756	120.657118	04-23130511#722	https://az804957.vo.msecnd.net/photogym/20200420101906_RYMTQ0WJ60BBFYIZ1TIC.jpg	?啣??湧?閮剔?????	FREE	0101000020E61000003AE7A7380E2A5E4089EE59D768293840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
99	擃?憟喃葉????擃?撣???鈭?銝楝122??64000	\N	22.62212198	120.2941078	07-2115418	https://az804957.vo.msecnd.net/photogym/20140607223617_494AB8HXEHZ52L6KL5XL.jpg	????擗?	CLOSE	0101000020E6100000E89F85A9D2125E400739D662439F3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
100	?憟喃葉?啣????啣?撣????頝臭?畾?56??65000	65000020	25.04254086	121.4675206	02-29956776#201	https://az804957.vo.msecnd.net/photogym/20140616094540_DSCN0665.jpg	蝐???????擗?,?啣???CLOSE	0101000020E610000034CD85DBEB5D5E40977132F5E30A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
101	憭扳漯擃葉擃擗?獢?撣之皞芸?摨瑁?頝?41??68000	68000030	24.86957362	121.2854522	03-3878628#512	https://az804957.vo.msecnd.net/photogym/20140605142109_P1080240.JPG	蝢賜???蝐???????CLOSE	0101000020E61000008FE44DD944525E40455D73609CDE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
102	銝剖控??瘣餃?銝剖?	獢?撣?????頝臭?畾?070??68000	68000010	24.98637894	121.2901032	03-2203012#350	https://az804957.vo.msecnd.net/photogym/20140620133548_DSCF5009.JPG	????擗?	CLOSE	0101000020E6100000C21D030D91525E405EC3885483FC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
103	?憭????	摰蝮??瞉喲?葛頝?13??10002	10002030	24.59252479	121.8434973	03-9951661#320	https://az804957.vo.msecnd.net/photogym/20200522084322_V7Y9MNAXA15IN4XUPKAO.jpg	蝐???CLOSE	0101000020E6100000EA7019DCFB755E40881E63B4AF973840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
104	?劓??摮貊?瘣餃?銝剖?	?脫?蝮??皜舫?啗????楝30??10009	10009060	23.57831557	120.3020784	05-6341255#038	https://az804957.vo.msecnd.net/photogym/20140613113018_XX04OWZPL2D19Y0G52HZ.jpg	????擗?	CLOSE	0101000020E6100000FE34A44055135E40E8EA3B7D0C943740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
105	銝剜迤??蝬??	?脫?蝮??撠暸?ㄝ頝臭?畾?4??10009	10009030	23.71914961	120.4406261	05-6322710	https://az804957.vo.msecnd.net/photogym/20140612170738_DSCN0272.JPG	蝐???????擗?	FREE	0101000020E6100000E650D037331C5E4093E157301AB83740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
106	憭扯??葉璅暑擗??啣?撣璈??葉銝銵???65000	65000010	25.01091305	121.448223	02-22725015#831	https://az804957.vo.msecnd.net/photogym/20140616164020_P1050625.JPG	????擗?,蝢賜???擗?	PAID	0101000020E6100000299485AFAF5C5E4080D99832CB023940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
107	?箏??平憭批飛摮貊?瘣餃?銝剖?	?箏?撣葉甇??瞈?頝臭?畾?21??63000	63000050	25.04230271	121.5260732	02-23226177	https://az804957.vo.msecnd.net/photogym/20140604110420_P7168495.JPG	蝐???????擗?,蝢賜???擗?	FREE	0101000020E61000005553ED2EAB615E4070FBB359D40A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
108	????憸券?(蝐???	?箔葉撣之?????葉撅勗?頝?35??66000	66000180	24.21938015	120.6460673	04-25678823	https://az804957.vo.msecnd.net/photogym/20140721184938_DSCF3899.JPG	蝐???????擗?,????擗?	FREE	0101000020E6100000F620A92A59295E403EA4294C29383840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
109	?箏??平憭批飛?????箏?撣葉甇??瞈?頝臭?畾?21??63000	63000050	25.04225411	121.5256441	02-23226177	https://az804957.vo.msecnd.net/photogym/20140604111522_P7168480.JPG	?箏??平憭批飛????FREE	0101000020E610000076B52627A4615E405392542AD10A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
110	??擃葉敹?擗??脫?蝮??皝?銝剜迤頝?09??10009	10009180	23.63233916	120.2276185	05-7872024#13	https://az804957.vo.msecnd.net/photogym/20140620135815_DSC_0091.JPG	蝐???????擗?	CLOSE	0101000020E6100000BC5D2F4D910E5E401C2EACFAE0A13740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
111	?批ㄑ擃葉擃擗?獢?撣葉憯Ｗ?????120??68000	68000020	24.97688726	121.2565809	03-4528080#233	https://az804957.vo.msecnd.net/photogym/20140604100203_??1.gif	皜豢陶瘙?擗?,蝐???獢???擗?,?餃??恕,?亥澈???恍???蝺游恕),???恕,????擗?,蝢賜???擗?	PAID	0101000020E6100000CF914BD26B505E403D94914815FA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
112	?勗撌亙振蝐????儔撣?摰?縑銵?52??10020	10020010	23.46884616	120.4605576	05-2246161#101	https://az804957.vo.msecnd.net/photogym/20140612144611_P1281707.JPG	蝐???????擗?	CLOSE	0101000020E6100000277B95C6791D5E40200E4C4D06783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
113	?批ㄑ擃葉?啣???獢?撣葉憯Ｗ?????120??68000	68000020	24.97725682	121.2570906	03-4528080#233	https://az804957.vo.msecnd.net/photogym/20140606143039_?啣??湧野??jpg	?啣????蝐???????擗?	FREE	0101000020E6100000FAC6212C74505E4066B1C1802DFA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
114	?啣????啁姘蝮?姘?????剛楝1畾?01??10004	10004010	24.81095178	121.0304278	03-5506881#266	https://az804957.vo.msecnd.net/photogym/20190521102357_JJPWCQZXU1TRBHPJ50XZ.JPG	????擗?	FREE	0101000020E6100000E9787187F2415E40A5BB2D899ACF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
115	?粹?憟喃葉擃擗??粹?撣縑蝢拙??曹縑頝?24??10017	10017070	25.12867306	121.7593496	02-24278274#320	https://az804957.vo.msecnd.net/photogym/20200417134123_E8MNIADQ6PGJZLQUGVVQ.JPG	????擗?,蝐???CLOSE	0101000020E6100000C38E102F99705E408593B8B7F0203940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
116	憭扳漯擃葉?啣???獢?撣之皞芸?摨瑁?頝?41??68000	68000030	24.86856129	121.2855381	03-3878628#512	https://az804957.vo.msecnd.net/photogym/20140605161909_P1080137.jpg	?蝐???????擗?,?啣???FREE	0101000020E6100000C450984146525E401F1F5F085ADE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
117	?散?葉?嗅?蝐????啣?撣?瘣脣?銝剜迤頝?65??65000	65000140	25.08634044	121.4665673	02-22811571#215	https://az804957.vo.msecnd.net/photogym/20170706102413_F33351P6GY3BEHTIX204.jpg	????擗?	FREE	0101000020E610000083B8173DDC5D5E404C1F36681A163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
118	?箄正??瘣餃?銝剖?	?脫?蝮?镼輸??啗正??甈楝9??10009	10009160	23.70174184	120.199177	05-6982045	https://az804957.vo.msecnd.net/photogym/20140612111315_IMG_20140612_114614.jpg	????擗?	PAID	0101000020E61000006347E350BF0C5E40ED086D5AA5B33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
119	?箏?憟喃葉擃擗??箏?撣葉镼踹?憭批?銵?7??67000	67000370	22.98724874	120.2065734	06-2131928#206	https://az804957.vo.msecnd.net/photogym/20140529120410_擃擗?gif	????擗?,蝐???CLOSE	0101000020E61000004E4EA37F380D5E4034515B55BCFC3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
120	?暸翩擃葉????擗?	?箏?撣ㄚ??蝢拐縑?敺瑁楝4畾?77??63000	63000110	25.08651714	121.5238255	02-28831568	https://az804957.vo.msecnd.net/photogym/20140529153313_IMAG2644.jpg	????擗?	FREE	0101000020E6100000E5D3635B86615E40EDD7BEFC25163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
121	頛蝘?憭批飛擃擗?擃?撣之撖桀??脣飛頝?51??64000	64000140	22.6038028	120.3889489	07-7811151#2281	https://az804957.vo.msecnd.net/photogym/20140529152243_DSC08967.JPG	蝐???????頞喟???蝢賜???擗?,獢???擗?,????擗?,皜豢陶瘙?擗?,?啣??????恕,?亥澈???恍???蝺游恕),蝬脩???擗?	CLOSE	0101000020E61000002C54ED89E4185E40B53BFFD1929A3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
122	擃?撣怎?憭批飛擃擗?擃?撣????像銝頝?16??64000	6400800	22.6252217	120.3222013	07-7172930#1553	https://az804957.vo.msecnd.net/photogym/20140529173952_摰文蝐??.JPG	蝐???????擗?,蝢賜???擗?,????擗?,獢???擗?,?亥澈???恍???蝺游恕),???恕	CLOSE	0101000020E6100000A38E33F29E145E40E13F82870EA03640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
123	撜函???蝐????啁姘蝮?釣??撜函?銵???10004	10004110	24.68912625	121.0205519	03-5800674	https://az804957.vo.msecnd.net/photogym/20140530091452_IMG_3901.jpg	蝐???頨脤?,????擗?	FREE	0101000020E6100000B997EAB850415E40AC90F2936AB03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
124	擃?撣怎?憭批飛蝐???擃?撣????像銝頝?16??64000	6400800	22.62528112	120.3227484	07-7172930#1553	https://az804957.vo.msecnd.net/photogym/20140529185945_摰文?蝐???JPG	蝐???????擗?	FREE	0101000020E610000086B5E7E8A7145E40CD34696C12A03640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
125	敶啣?擃?瘣餃?銝剖?	敶啣?撣?賡??頝臭?畾?26??\N	\N	24.07128907	120.5543733	04-7262965	https://az804957.vo.msecnd.net/photogym/20140530103052_100_7515.JPG	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E6100000A35126DA7A235E405636200040123840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
126	?擃?銝剖飛擃擗??脫?蝮???剖?瘞?頝?24??10009	10009010	23.71279246	120.5454898	05-5322039	https://az804957.vo.msecnd.net/photogym/20140530111707_??1.jpg	????擗?,皜豢陶瘙?擗?,獢???擗?	CLOSE	0101000020E61000004DD30C4EE9225E400F89109179B63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
127	?蝘?憭批飛擃擗??箏?撣撣?銝剛頝?9??67000	67000200	23.06741319	120.2977771	(06)5979566#7132	https://az804957.vo.msecnd.net/photogym/20140530110854_8-1擃擗?jpg	蝐???蝢賜???擗?,????擗?,?亥澈???恍???蝺游恕),獢???擗?,???????恕,?啣耦/?渡??Ｚ????敺??,????擗?CLOSE	0101000020E6100000DB7FAEC70E135E40795EA6FD41113740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
128	擃??怨風蝞∠?撠?摮豢蝐???擃?撣?瞈???頝?09??64000	64000310	22.88821155	120.5508238	07-6812148#227	https://az804957.vo.msecnd.net/photogym/20140530101842_DSC09734.jpg	????擗?,蝐???FREE	0101000020E6100000F1B677B240235E40F22D07D561E33640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
129	銝剖控撌亙?擃擗?擃?撣之撖桀??冗?迤瘞?楝79??64000	64000140	22.59991017	120.3918821	(07)7815311	https://az804957.vo.msecnd.net/photogym/20140530140346_DSC_8812.JPG	蝐???????擗?	CLOSE	0101000020E6100000D2D8A89814195E4014B080B693993640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
130	?踵祥憭批飛?啣控????	?箏?撣?撅勗???頝臭?畾?4??63000	63000080	24.98121015	121.5779418	02-29393091#62964	https://az804957.vo.msecnd.net/photogym/20140530120036_?剜??典???jpg	?嗅?蝐??	FREE	0101000020E6100000737F9AFFFC645E40D5C0A09630FB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
131	?踵祥憭批飛蝬???蝺渡??	?箏?撣?撅勗???頝臭?畾?4??63000	63000080	24.98458958	121.5741116	02-29393091#62964	https://az804957.vo.msecnd.net/photogym/20140530102849_蝬???蝺渡??1.jpg	?蝐???撠?頞喟????嗅?????FREE	0101000020E61000004590943EBE645E4017150E100EFC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
132	?蝘?憭批飛????擗?	?箏?撣撣?銝剛頝?9??67000	67000200	23.06728269	120.2978607	(06)5979566#7132	https://az804957.vo.msecnd.net/photogym/20140530163812_IMG_1836.JPG	????擗?	FREE	0101000020E6100000E050532610135E400C23397039113740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
133	?單擃?銝剖飛?啣??湛?蝐??湛????湛?蝬脩????箔葉撣?撅臬?頠??頝?28??66000	66000080	24.17892461	120.712629	04-24371728#723	https://az804957.vo.msecnd.net/photogym/20140530163637_IMG_1061.JPG	?啣???CLOSE	0101000020E6100000994BAAB69B2D5E404966D400CE2D3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
134	?箸撠?摮豢?????箸蝮??勗?甇?除?楝911??10014	10014010	22.75917073	121.12158	08-9226389#2250	https://az804957.vo.msecnd.net/photogym/20140603083829_????jpg	????CLOSE	0101000020E610000040F67AF7C7475E40326E510359C23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
135	曈喳控?極皜豢陶瘙?擗?	擃?撣陶撅勗??﹛頝?1??64000	64000120	22.63531265	120.3561473	07-7462602	https://az804957.vo.msecnd.net/photogym/20140603083648_100_1213.JPG	皜豢陶瘙?擗?,蝐???????擗?	CLOSE	0101000020E6100000C2830B1ECB165E402F7C8ED9A3A23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
136	鈭??葉?啣????啁姘蝮?姘?梢鈭??飛摨楝132??10004	10004020	24.7642808	121.0545194	03-5823083#851	https://az804957.vo.msecnd.net/photogym/20140530152225_DSC_3451.JPG	頝?,????蝐???FREE	0101000020E6100000D8FFEF3E7D435E40F2F510E8A7C33840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
137	暻餃???蝐????啁姘蝮?姘??暻餃????銵?36??10004	10004010	24.85168624	120.9747934	03-5563540#103	https://az804957.vo.msecnd.net/photogym/20140603084005_?∪? (1).jpg	蝐???????擗?	FREE	0101000020E6100000D356DB03633E5E40D240031C08DA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
138	??擃??啣?????蝮????銝??蔑?楝銝畾?93??10008	10008010	23.90355327	120.6840634	049-2222269#142	https://az804957.vo.msecnd.net/photogym/20140603112809_IMG_8050.JPG	?啣???蝐???????擗?	FREE	0101000020E6100000FFD8DAB1C72B5E4007D860444FE73740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
139	皝正?葉擃擗?瞉?蝮??镼輸?皝正??3銋???10016	10016020	23.58471599	119.6538591	06-9921929#303	https://az804957.vo.msecnd.net/photogym/20140603130154_IMG_2944.JPG	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E61000004AACD6D3D8E95D408E7F76F2AF953740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
140	銝剖?蝘?憭批飛?啣耦/?渡??Ｚ????敺??	?箏?撣?撅勗???頝臭?畾?6??63000	63000080	24.9972993	121.5548265	02-29313416#2149	https://az804957.vo.msecnd.net/photogym/20140603144005_IMG_0034.JPG	?啣耦/?渡??Ｚ????敺??,蝐???????FREE	0101000020E6100000111D024782635E40DED2C5014FFF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
141	?葛擃極????擗?	?箏?撣?皜臬??葛??銝剛楝29??63000	63000090	25.05549242	121.608578	02-27825432#1209	https://az804957.vo.msecnd.net/photogym/20140604084723_IMAG2491.jpg	????FREE	0101000020E61000002AC423F1F2665E406E1351C0340E3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
142	皝擃葉????擗?	?啁姘蝮?????銝剜迤頝臭?畾?63撌?1??10004	10004050	24.89049005	121.0539776	03-5690772#501	https://az804957.vo.msecnd.net/photogym/20140604103633_IMG_2076 (2).JPG	????擗?	FREE	0101000020E6100000DCAD765E74435E40D529EA27F7E33840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
143	?格絲?葉擃擗?瞉?蝮?瘝??格絲??0??10016	10016030	23.64392867	119.5966122	06-9931311#41	https://az804957.vo.msecnd.net/photogym/20140604114907_DSC02493.JPG	蝐???????PAID	0101000020E610000041D9EFE42EE65D40569B6282D8A43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
144	撖????啣耦/?渡??Ｚ????敺??	?啁姘蝮?釣??撖??云撟唾?8??10004	10004110	24.68651931	120.988488	03-5806353	https://az804957.vo.msecnd.net/photogym/20140604115531_IMG_0471.JPG	?啣耦/?渡??Ｚ????敺??,蝐???????擗?	FREE	0101000020E6100000431F2C63433F5E40C285C0BABFAF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
145	?儔擃極????擗?	?儔撣?敶?頝?74??10020	10020010	23.47094726	120.4659837	05-2754092	https://az804957.vo.msecnd.net/photogym/20140604141404_??蝛箇.JPG	????擗?	CLOSE	0101000020E610000005FE4BADD21D5E403FD7E7FF8F783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
146	靽桀像蝘?憭批飛?啣????箔葉撣之??撌交平頝?1??66000	66000280	24.09576348	120.7118283	04-24961100#6812	https://az804957.vo.msecnd.net/photogym/20140604140500_?啣???JPG	?啣????????蝐???FREE	0101000020E6100000813749988E2D5E404BC096F483183840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
147	鞊僑??蝐????箸蝮??勗?銝剛?頝臭?畾?20??10014	10014010	22.7718239	121.1116451	08-9226733	https://az804957.vo.msecnd.net/photogym/20140604152412_蝐???jpg	蝐???????擗?	FREE	0101000020E61000008E507D3125475E406CC5484096C53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
148	?啗?擃?銝剖飛?啣???獢?撣敺瑕?瘞貉?頝?63??68000	68000080	24.97398661	121.2716523	(03)3796996	https://az804957.vo.msecnd.net/photogym/20140604152704_IMG_2290-1.jpg	?啣???蝐???????CLOSE	0101000020E6100000861854C062515E4021B1BC2F57F93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
149	?箏???憭批飛蝐????箏?撣??啣?憭批???6??67000	67000100	23.19327873	120.3712535	06-6930100#2851	https://az804957.vo.msecnd.net/photogym/20140604150349_??憭??賜???jpg	蝐??	FREE	0101000020E6100000A2410A9EC2175E40C75C00B77A313740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
150	靽桀像蝘?憭批飛擃擗??箔葉撣之??撌交平頝?1??66000	66000280	24.09565024	120.7107367	04-24961100#6811	https://az804957.vo.msecnd.net/photogym/20140604154734_擃擗典??jpg	蝢賜???擗?,蝐???????擗?,獢???擗?,???恕,?亥澈???恍???蝺游恕)	PAID	0101000020E610000049A4C8B57C2D5E4091A7BC887C183840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
151	?箏??憭批飛?????箏?撣之摰??像?梯楝鈭挾134??63000	63000030	25.02318143	121.5445161	02-27321104#83412	https://az804957.vo.msecnd.net/photogym/20140604162417_??01.JPG	????FREE	0101000020E61000004F690E5AD9625E407AB9DB37EF053940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
152	?箏???憭批飛蝬脩????箏?撣??啣?憭批???6??67000	67000100	23.18839214	120.3749657	06-6930100#2851	https://az804957.vo.msecnd.net/photogym/20140604152925_蝬脩???jpg	????FREE	0101000020E6100000CBA72270FF175E409B1FA0773A303740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
153	蝘瘞湧?撌仿◢?函???敶啣?蝮??瘞湧?蝳??葉撅梯楝364??10007	10007070	24.03575267	120.4979289	04-7697021	https://az804957.vo.msecnd.net/photogym/20140604095630_DSCN0276.JPG	蝐???????CLOSE	0101000020E6100000EE4E2D11DE1F5E400A65441627093840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
154	鈭???瘣餃?銝剖?	?啁姘蝮?姘?梢鈭????楝32??10004	10004020	24.76739953	121.0580707	03-5822098#22	https://az804957.vo.msecnd.net/photogym/20140604130340_DSC_0417.jpg	蝢賣??(擗?	PAID	0101000020E6100000C6562B6EB7435E40D650AC4B74C43840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
155	靽桀像蝘?憭批飛????擗?	?箔葉撣之??撌交平頝?1??66000	66000280	24.09561963	120.7123661	04-24961100#6811	https://az804957.vo.msecnd.net/photogym/20140604170155_????jpg	????擗?	FREE	0101000020E6100000DC91FB67972D5E40A4B42F877A183840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
156	??憟喃葉蝐????箔葉撣??銝剜?頝臭?畾?06??66000	66000050	24.16805242	120.6743672	04-22921175#241	https://az804957.vo.msecnd.net/photogym/20140604164752_IMG_3649.JPG	蝐???????CLOSE	0101000020E6100000B05F0BD5282B5E40E5E9BF7B052B3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
157	?啗????啣????啁姘蝮?鞊?????敺瑕毽13??10004	10004060	24.9006258	120.9885263	03-5592081#122	https://az804957.vo.msecnd.net/photogym/20140605090254_DSC00714.JPG	?啣???蝐???????擗?	FREE	0101000020E6100000196FD003443F5E4010EF94698FE63840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
158	?芸撥?葉?啣????啁姘蝮?姘?梢?芸撥頝?69??10004	10004020	24.74635864	121.0842061	03-5103291#130	https://az804957.vo.msecnd.net/photogym/20140530153107_DSC04466.JPG	蝐???????擗?,?啣???FREE	0101000020E6100000EB67FBA163455E4015E31D5C11BF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
159	撱箏?銝剖飛????擗?	?箏?撣葉甇??樴???瘚瑁楝56??63000	63000050	25.03009343	121.5133756	02-23034381#308	https://az804957.vo.msecnd.net/photogym/20140605094027_摰文?????jpg	????擗?	CLOSE	0101000020E61000001F245525DB605E40AAACF933B4073940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
160	??憭批飛銝剜迤???箏?撣?憭批飛頝???67000	67000320	22.99671835	120.2173591	06-2757575#50385	https://az804957.vo.msecnd.net/photogym/20140605114018_銝剜迤??001.jpg	蝢賜???擗?,獢???擗?,蝐???????擗?	CLOSE	0101000020E61000003B7F2436E90D5E40B5920CEF28FF3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
161	頝舐姘擃葉蝐??游?????擃?撣楝蝡孵?銝剛頝?92??64000	64000240	22.85394425	120.2512072	07-6963008#133	https://az804957.vo.msecnd.net/photogym/20140605113547_0610.1.jpg	蝐???FREE	0101000020E610000043215DC713105E40755B22179CDA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
162	?脫?蝘?憭批飛擃擗??脫?蝮???剖?憭批飛頝臭?畾?23??10009	10009010	23.69134702	120.5368692	05-5342601#2705	https://az804957.vo.msecnd.net/photogym/20140605111351_IMG_3740.JPG	蝐??,????蝢賜???獢??恕,???恕,???恕	CLOSE	0101000020E6100000B30EA2105C225E404916491EFCB03740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
163	?葛颲脣極憸券?	?脫?蝮??皜舫憭芸像頝?0??10009	10009060	23.5796865	120.3067946	05-7832246#533	https://az804957.vo.msecnd.net/photogym/20140603141804_100_5301.JPG	蝐???????擗?	CLOSE	0101000020E6100000B965D185A2135E40C66E9F5566943740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
164	憭批?擃葉?????箏?撣葉撅勗?銝剖亢??亥楝167??63000	63000040	25.05621164	121.5346509	02-25054269#122	https://az804957.vo.msecnd.net/photogym/20140605142046_P1050256.JPG	????FREE	0101000020E6100000BA9168B837625E405C74D3E2630E3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
165	?扳?擃極蝬??	?箏?撣皝?皜臬??皝楝1畾?20??63000	63000100	25.07998243	121.5743101	02-26574874#205	https://az804957.vo.msecnd.net/photogym/20140604142835_mobile6db763e6-7966-4e68-a8e7-33e690b40aae.jpg	蝐???????摰文?)	CLOSE	0101000020E6100000CD50267FC1645E40C81A81BA79143940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
166	瘙??葉擃擗?蝢賜????熔?輻?????	?箸蝮??銝??啗???摮貉楝88??10014	10014060	23.11494367	121.2035805	089-862040	https://az804957.vo.msecnd.net/photogym/20140605153043_IMG_5804.JPG	瘙??葉擃擗?FREE	0101000020E61000009D668176074D5E403F88C7F26C1D3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
167	蝡嫣葉????銝剖?	?啁姘蝮?姘?梢?剝??姘銝剛楝104撌?4??10004	10004020	24.78004755	121.0297143	03-5823822#805	https://az804957.vo.msecnd.net/photogym/20140605153539_DSC00548.JPG	????擗?,蝐???FREE	0101000020E61000004EAECED6E6415E402E933C32B1C73840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
168	?扳?擃極????擗?	?箏?撣皝?皜臬??皝楝1畾?20??63000	63000100	25.07966176	121.5749002	02-26574874#205	https://az804957.vo.msecnd.net/photogym/20140604090314_mobile487003c8-a73c-4c31-a1b9-0acc2dffdee4.jpg	????擗?	CLOSE	0101000020E6100000B05D352ACB645E401AF18DB664143940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
169	??擃葉蝐????箏?撣???憭扳?頝?95??67000	67000190	23.12859962	120.3020525	06-5837312#309	https://az804957.vo.msecnd.net/photogym/20140606084450_DSC03765.JPG	????擗?	FREE	0101000020E6100000344B02D454135E40932D9AE7EB203740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
170	銝?摰嗅??啣???擃?撣椰??鋆?頝?102??64000	64000030	22.66678143	120.3026265	07-5525887#362	https://az804957.vo.msecnd.net/photogym/20140606094900_DSC_0082.JPG	?啣???????????蝐???頞喟???FREE	0101000020E6100000CA198A3B5E135E401C6E1330B2AA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
171	?啣??蝘?憭批飛?????箏?撣偶摨瑕?銝剜迤頝?29??67000	67000310	23.03801424	120.2346969	(06)2539639	https://az804957.vo.msecnd.net/photogym/20140606115630_G:\\DSC06947.JPG	????蝐???FREE	0101000020E61000003F7E2546050F5E4011951D4DBB093740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
172	敹??葉瘣餃?銝剖?	?啁姘蝮?鞊??∪控???剛?1??10004	10004060	24.87937529	120.9996521	03-5572555#13	https://az804957.vo.msecnd.net/photogym/20140606144612_DSC03561.JPG	蝢賜???擗?,????擗?	PAID	0101000020E61000002D38CD4CFA3F5E40E4752FBD1EE13840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
173	蝡孵?擃葉????擗?	?啁姘蝮?姘??銝剖亢頝???10004	10004010	24.83476507	121.0028172	03-5517330	https://az804957.vo.msecnd.net/photogym/20140606165222_?嗅????游??jpg	????擗?	FREE	0101000020E6100000717731282E405E403F7EE329B3D53840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
174	???葉????擗?	?啁姘蝮?姘?????怨楝99??10004	10004010	24.81874723	121.0164642	03-5505924#8304	https://az804957.vo.msecnd.net/photogym/20140606173729_4DSC04377.JPG	????擗?	FREE	0101000020E61000008223DCBF0D415E40648A206B99D13840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
175	??憭批飛?葉蝬脩???銝餉?閮剜)???(甈∟?閮剜)	?梯蝮??桀?隞?銵?76??10015	10015010	23.99970069	121.5749967	03-8572823#126	https://az804957.vo.msecnd.net/photogym/20140609085900_IMG_8183.JPG	蝬脩???擗?,蝬脩???擗?	CLOSE	0101000020E6100000B573F5BECC645E40B1566962ECFF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
176	撅擃極????擗?	撅蝮???勗?撱箏?頝?5??10013	10013010	22.66074963	120.4860252	08-7523781#243	https://az804957.vo.msecnd.net/photogym/20140609091214_DSC00401.JPG	????擗?	FREE	0101000020E61000000AC270091B1F5E40B1B143E326A93640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
177	敶啣葦?極蝐???敶啣?蝮?蔑???矽?極?∟?1??10007	10007010	24.0811433	120.5560416	04-7252541#224	https://az804957.vo.msecnd.net/photogym/20140609085921_P1050958.JPG	????擗?	FREE	0101000020E6100000CBCD812F96235E401ECAABCEC5143840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
178	蝡孵????啣???獢?撣之??蝡孵????啁姘??3??68000	68000060	25.10378019	121.2443689	03-3835079#330	https://az804957.vo.msecnd.net/photogym/20140609085759_DSC02752.JPG	?啣???蝐???頨脤?,????擗?	FREE	0101000020E6100000356A74BDA34F5E40CD05AA56911A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
179	?祐擃葉????擗?	?箏?撣???砍僑頝?67??67000	67000330	22.9367319	120.1864842	06-2622458	https://az804957.vo.msecnd.net/photogym/20140605094158_??1.jpg	????擗?	FREE	0101000020E6100000200E6D5BEF0B5E40B59E6BA9CDEF3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
180	?儔擃?摰嗡??瑟平摮豢????擗?	?儔撣?擃頝???10020	10020010	23.47149738	120.4590197	05-2259640#1340	https://az804957.vo.msecnd.net/photogym/20140609130926_10387215_833448400017414_6405329244608261108_n.jpg	????擗?	FREE	0101000020E610000010EE2994601D5E40EB3F630DB4783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
181	??蝘?憭批飛?啣?????蝮??撅舫銝剜迤頝?68??10008	10008030	23.98285115	120.6966376	049-2563489#1555	https://az804957.vo.msecnd.net/photogym/20140605094723_??1.jpg	?啣???????擗?,?蝐???FREE	0101000020E61000007E4ADFB5952C5E4003160A229CFB3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
182	????蝐???撅蝮???仿???正?頝?46??10013	10013040	22.00888992	120.7448745	08-8892141#14	https://az804957.vo.msecnd.net/photogym/20140609135612_?(1).jpg	蝐???????擗?,頨脤?	CLOSE	0101000020E6100000F5471806AC2F5E4000AA1B9C46023640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
183	?望閮剛?憭批飛????擗?	擃?撣??批??望頝?10??64000	64000250	22.8816909	120.244149	07-6939525#12	https://az804957.vo.msecnd.net/photogym/20140609144822_DSC00899.JPG	????擗?	CLOSE	0101000020E610000078962023A00F5E4049AEAC7EB6E13640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
184	?餃????啣????箸蝮??撅梢?餃??葉??3??10014	10014030	23.00618311	121.1731032	08-9951142#03	https://az804957.vo.msecnd.net/photogym/20140609143110_DSC_0242.jpg	?啣???蝐???????擗?	FREE	0101000020E61000004FB5711F144B5E40D13C5F3795013740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
185	?箏?瘚瑚?蝐????箏?撣?撟喳?銝像頝???67000	67000360	22.99346312	120.1505721	06-3910772#331	https://az804957.vo.msecnd.net/photogym/20140604133241_77DSC01255.jpg	????擗?	CLOSE	0101000020E61000002A4C29F9A2095E40A02E5A9953FE3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
186	蝡嫣葉??頞喟????啁姘蝮?姘?梢?剝??姘銝剛楝104撌?4??10004	10004020	24.77984299	121.0304815	03-5823822#805	https://az804957.vo.msecnd.net/photogym/20140605154101_DSC00552.JPG	????擗?	FREE	0101000020E61000008368AD68F3415E409A104ACAA3C73840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
187	?箏??怠飛憭批飛????擗?	?箏?撣縑蝢拙??唾?銵?50??63000	63000020	25.0260153	121.561355	(02)27361661	https://az804957.vo.msecnd.net/photogym/20140609150333_????jpg	????擗?	PAID	0101000020E61000008D9C853DED635E4015B24EF0A8063940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
188	蝡嫣葉??瘣餃?銝剖?	?啁姘蝮?姘?梢?剝??姘銝剛楝104撌?4??10004	10004020	24.7802375	121.0301703	03-5823822#805	https://az804957.vo.msecnd.net/photogym/20140603141430_DSC00547.JPG	蝢賜???擗?,????擗?	CLOSE	0101000020E6100000DFF3684FEE415E40E09C11A5BDC73840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
189	皜憭批飛(?之?∪?)擃擗??啁姘撣??之頝?21??10018	10018010	24.79443066	120.9652233	03-5213132#1602	https://az804957.vo.msecnd.net/photogym/20140609142552_擃擗?.JPG	蝢賜???擗?,????擗?,蝐??????恕	CLOSE	0101000020E610000095B5F237C63D5E40C3A3C7CE5FCB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
190	?葉???啣????儔蝮?????葉??0??10010	10010050	23.52751684	120.4201233	05-2214725	https://az804957.vo.msecnd.net/photogym/20140609153319_P1210264.JPG	?啣???????頨脤?	FREE	0101000020E61000006872D64CE31A5E40A7E3F7570B873740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
191	皜憭批飛(?之?∪?)擃?亙熒?飛憭扳?蝐????啁姘撣??之頝?21??10018	10018010	24.79441576	120.965204	03-5213132#1602	https://az804957.vo.msecnd.net/photogym/20140609155906_擃1.JPG	蝢賜???擗?,????擗?,蝐???CLOSE	0101000020E6100000FA7DFFE6C53D5E4082A0CCD45ECB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
192	?儔擃?摰嗡??瑟平摮豢?????儔撣?撣?銵?7??10020	10020010	23.47143538	120.4587386	05-2259640#1340	https://az804957.vo.msecnd.net/photogym/20140609181950_IMG_3456.JPG	????擗?	FREE	0101000020E61000006C1A25F95B1D5E40FF4633FDAF783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
193	?葉??蝐????儔蝮?????葉??0??10010	10010050	23.52751684	120.4201126	05-2214725	https://az804957.vo.msecnd.net/photogym/20140610081221_P1210271.JPG	蝐???????擗?	FREE	0101000020E6100000CD68F51FE31A5E40A7E3F7570B873740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
194	?葉???????儔蝮?????葉??0??10010	10010050	23.52751684	120.4201233	05-2214725	https://az804957.vo.msecnd.net/photogym/20140610082249_P1210267.JPG	????蝐???FREE	0101000020E61000006872D64CE31A5E40A7E3F7570B873740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
195	?臬?擃?銝剖飛擃擗??啣?撣璈?憭扯?頝臭?畾?2??65000	65000010	25.00612847	121.4460844	02-29684131#341	https://az804957.vo.msecnd.net/photogym/20140610082703_擃擗典?舐??jpg	蝐???????擗?	CLOSE	0101000020E61000005F5095A58C5C5E407A39AAA291013940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
196	憭批?葉????擗?	?脫?蝮?之?日?????甈楝80??10009	10009080	23.64088773	120.4303265	05-5912051#105	https://az804957.vo.msecnd.net/photogym/20140610090343_P1050314.JPG	????擗?	FREE	0101000020E61000008A0629788A1B5E40F7C1E03711A43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
197	瘞??葉????擗?	?儔蝮????镼踹??正摰楝147??10010	10010050	23.55642933	120.4211587	05-2262527	https://az804957.vo.msecnd.net/photogym/20140610090513_9SV6MXWCVXIY2XLXNANJ.JPG	????擗?,蝐???FREE	0101000020E610000042BB9E43F41A5E409CE20E27728E3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
198	?憭批飛擃擗??箏?撣ㄚ??銝剖控?楝鈭挾250??63000	63000110	25.0855989	121.5335083	02-28824564#2325	https://az804957.vo.msecnd.net/photogym/20140609104547_?訾???jpg	蝐???????擗?,?啣???????擗?,蝬脩???擗?,獢???擗?,蝢賜???擗?,蝐????亥澈???恍???蝺游恕)	PAID	0101000020E61000004029FFFF24625E40D6123CCFE9153940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
199	憭批???蝬??	?儔撣???15??\N	\N	23.47090297	120.4457223	05-2222114#126	https://az804957.vo.msecnd.net/photogym/20140606152309_DSCF2473.JPG	頨脤?,蝐???????擗?	CLOSE	0101000020E61000004466D3B6861C5E4041BDD7188D783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
200	?憭批飛摰文?蝐????箏?撣ㄚ??銝剖控?楝鈭挾250??63000	63000110	25.08700783	121.5276289	02-28824564#2325	https://az804957.vo.msecnd.net/photogym/20140610103319_摰文?蝐??游閮迥1.JPG	蝐???????擗?	PAID	0101000020E61000002A7B01ACC4615E408F58282546163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
201	憭批??蝐????脫?蝮?之?日????葉甇?楝23??10009	10009080	23.64306348	120.431001	05-6341132	https://az804957.vo.msecnd.net/photogym/20140610105245_mobileac1e37cf-aab6-4fba-b40b-76fc31183fbc.jpg	蝐???頨脤?,????擗?	FREE	0101000020E6100000C5E23785951B5E4019DAE7CE9FA43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
202	?憭批飛?啣????箏?撣ㄚ??銝剖控?楝鈭挾250??63000	63000110	25.08701755	121.5276504	02-28824564#2325	https://az804957.vo.msecnd.net/photogym/20140610105204_?1.JPG	?啣???頞喟???????擗?,蝬脩???擗?	PAID	0101000020E61000002AEE2E06C5615E40946D3BC846163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
203	瞏桀?擃葉????擗?	撅蝮?蔭瘣脤銝剖控頝?1??10013	\N	22.54885467	120.5463084	08-7882017#304	https://az804957.vo.msecnd.net/photogym/20140610113226_DSC01358.JPG	????擗?	PAID	0101000020E6100000EDE181B7F6225E4029E859BD818C3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
204	?扳?擃葉瘣餃?銝剖?	?箏?撣皝?蝝恍??敺瑁楝218??63000	63000100	25.07823331	121.5869915	02-27977035#206	https://az804957.vo.msecnd.net/photogym/20140529114640_ICVO0TCN63TCICKOVP8S.jpg	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E6100000EBE1CB4491655E4068E8231907143940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
205	?剖???憸券?恕	?脫?蝮?獢??剖???楝63??10009	10009090	23.7684035	120.5628276	05-5712810	https://az804957.vo.msecnd.net/photogym/20140610121332_SDC11988-s.jpg	????擗?	PAID	0101000020E610000051D20D5E05245E40C7A17E17B6C43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
206	撟喳???蝬??	?梯蝮?ˊ鞊?撟喳?頝?4??10015	10015060	23.88371873	121.5195823	03-8661223#203	https://az804957.vo.msecnd.net/photogym/20140610122415_ISCSBA9HIKCWTSD51MQR.JPG	????擗?	CLOSE	0101000020E610000026851ED640615E40703604643BE23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
207	???葉瘣餃?銝剖?嚗葉甇?尹嚗???蝮????憭批?頝?4??10008	10008010	23.89560314	120.6839508	049-2222460#233	https://az804957.vo.msecnd.net/photogym/20140610123037_瘣餃?銝剖?-憭.JPG	蝢賜???擗?,獢???擗?,????擗?	FREE	0101000020E6100000AD8493D9C52B5E40B27E543F46E53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
208	暽輸??葉蝐????箸蝮?嘀??樴??璁株楝38??10014	10014050	22.90763545	121.134755	08-9551006	https://az804957.vo.msecnd.net/photogym/20140610132314_暽輸??葉???湧尹曈亦??jpg	蝐???????擗?	PAID	0101000020E61000003D7E6FD39F485E40B470FECB5AE83640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
209	銝剖亢憭批飛?惇銝剖ㄑ擃葉?啣???獢?撣葉憯Ｗ?銝?頝?15??68000	68000020	24.96378418	121.2104223	03-4932181#34	https://az804957.vo.msecnd.net/photogym/20140610133420_DSC03028.JPG	?啣???頞喟???????擗?	FREE	0101000020E61000005836188F774D5E408F805D8FBAF63840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
210	銝????啣耦/?渡??Ｚ????敺??	?儔蝮??喲?銝振??6??10010	10010090	23.47120559	120.1743445	05-3732634	https://az804957.vo.msecnd.net/photogym/20140610141300_DSC_0034_1.jpg	蝐???頞喟????啣???FREE	0101000020E6100000336FD575280B5E400DBEF6EDA0783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
211	銝剛蝘?憭批飛?????箔葉撣?撅臬?撱?頝?66??66000	66000080	24.17344833	120.7353982	(04)22391647	https://az804957.vo.msecnd.net/photogym/20140610144817_33.JPG	????擗?	FREE	0101000020E610000063A29CC3102F5E4054E5181C672C3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
212	銴???瘣餃?銝剖?	?脫?蝮??敹????葉?楝72??10009	10009150	23.70114796	120.3100455	05-6341219#046	https://az804957.vo.msecnd.net/photogym/20140606150002_DSCN4781.JPG	????擗?,蝐???PAID	0101000020E610000068B114C9D7135E406CDBC56E7EB33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
213	?典???憭批飛擃擗???蝮???憭批飛頝???10008	10008020	23.95046914	120.9271574	049-2910960#3752	https://az804957.vo.msecnd.net/photogym/20140603111527_02.jpg	蝐???蝢賜???擗?,????擗?,獢???擗?,???恕,皜豢陶瘙?擗?,?亥澈???恍???蝺游恕)	PAID	0101000020E6100000A4CFFD8B563B5E40412810F251F33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
214	?箇蝘?憭批飛????擗?	?箏?撣之摰??粹?頝臬?畾?3??63000	63000030	25.01463568	121.5432715	02-27376912	https://az804957.vo.msecnd.net/photogym/20140610151524_DSC04701.JPG	????擗?	CLOSE	0101000020E61000005456D3F5C4625E4069F4F629BF033940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
215	?典???憭批飛?嗅??	??蝮???憭批飛頝???10008	10008020	23.94827279	120.9266424	049-2910960#3751	https://az804957.vo.msecnd.net/photogym/20140610160012_IMG_1516.JPG	????擗?,蝬脩???擗?,蝐???PAID	0101000020E610000091C5EC1B4E3B5E4097BC6C01C2F23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
216	敶啣?憟喃葉?啣???敶啣?蝮?蔑???儔頝?2??10007	10007010	24.08197588	120.5435532	04-7240042#1306	https://az804957.vo.msecnd.net/photogym/20140610152848_nEO_IMG_IMAG5681.jpg	????擗?,蝐????啣???CLOSE	0101000020E6100000B7685C93C9225E402CA90B5FFC143840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
217	?瑕?憭批飛???	獢?撣?撅勗???銝頝?59??68000	68000070	25.03245065	121.3900466	(03)2118800*2107	https://az804957.vo.msecnd.net/photogym/20140610161950_P6130628 (800x600).jpg	蝐???????CLOSE	0101000020E6100000A0BA0386F6585E40E47B90AF4E083940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
218	???葉??????蝮????憭批?頝?4??10008	10008010	23.89573066	120.6846803	049-2222460#252	https://az804957.vo.msecnd.net/photogym/20140610162920_DSC00643.JPG	????PAID	0101000020E6100000CA2D52CDD12B5E4079B9C29A4EE53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
219	?梯憭批飛擃擗??梯蝮?ˊ鞊?敹飛?之摮貉楝鈭挾1-32??10015	10015060	23.9000076	121.5380861	(03)8632619	https://az804957.vo.msecnd.net/photogym/20140609162207_IMAG1448.jpg	蝐???蝢賜???擗?,????擗?	PAID	0101000020E6100000A97BAE0070625E40C526E8E566E63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
220	?陸??蝐????啁姘蝮?姘?梢銝??3??10004	10004020	24.66131918	121.1220682	03-5949052#120	https://az804957.vo.msecnd.net/photogym/20140608160407_IMG_8156.jpg	蝐???????擗?,頨脤?	FREE	0101000020E61000006CB823F7CF475E404A51BA364CA93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
221	??擃葉瘣餃?銝剖?	?箏?撣?撟喳?撱箏像鈭?111??67000	67000360	22.98735756	120.1787662	06-2932323#321	https://az804957.vo.msecnd.net/photogym/20140606085253_D1020048.JPG	蝐???????CLOSE	0101000020E610000055A8C9E7700B5E408AA80D77C3FC3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
222	?唳?擃葉?啣????箔葉撣??銝?頝臭?畾?89??66000	66000050	24.1585631	120.6866962	04-22334105#6414	https://az804957.vo.msecnd.net/photogym/20140603105815_DSCF0003.JPG	?啣???蝐???????擗?,蝬脩???擗?	CLOSE	0101000020E610000066529ED4F22B5E4035DA609797283840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
223	暽賣散???啣???撅蝮???暽賢??厭瘣脰楝379??10013	10013170	22.48786582	120.4401863	08-8322975	https://az804957.vo.msecnd.net/photogym/20140611104828_??.jpg	?啣???蝐???????擗?	FREE	0101000020E61000006CA928032C1C5E4079BC3DC6E47C3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
224	?唳??葉瘣餃?銝剖?	獢?撣葉憯Ｗ?銝剜迤頝?87撌?8??68000	68000020	24.95649129	121.212523	03-4936194	https://az804957.vo.msecnd.net/photogym/20140611104322_H:\\?????澈\\擃銵\\?游?抒?\\瘣餃?銝剖?.JPG	?啣????嗅/撠???蝐???????擗?,璉????毀蝧,獢???擗?,蝢賜???擗?,?亥澈???恍???蝺游恕)	FREE	0101000020E610000076A911FA994D5E407775F99CDCF43840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
225	?梯蝮??擃擗??梯撣??箸???之頝?3??\N	\N	24.00495408	121.5852857	03-8580686	https://az804957.vo.msecnd.net/photogym/20140611103631_?冽.jpg	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E61000004114275275655E40EF94ABAB44013840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
226	?蝘?憭批飛?????啁姘蝮?鞊??啗?頝???10004	10004060	24.8622973	120.988403	03-5593142#2343	https://az804957.vo.msecnd.net/photogym/20140611115930_DSCN0183.JPG	????CLOSE	0101000020E61000002C11A8FE413F5E40DAED0E84BFDC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
227	憭扳??葉????擗?	?儔蝮?之?憭抒??葉摮貉楝1??10010	10010040	23.60984093	120.4533505	05-2652014	https://az804957.vo.msecnd.net/photogym/20140611115159_DSCN6851.JPG	????擗?	FREE	0101000020E610000004C8D0B1031D5E40BB1C02891E9C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
228	?蝘?憭批飛瘝??????啁姘蝮?鞊??啗?頝???10004	10004060	24.86214641	120.9870243	03-5593142#2343	https://az804957.vo.msecnd.net/photogym/20140611120512_DSCN0193.JPG	瘝?????CLOSE	0101000020E6100000DE36F8672B3F5E4056508BA0B5DC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
229	憭批???瘣餃?銝剖?	獢?撣敺瑕?憭批???撟唾楝638??68000	68000080	24.95634052	121.314801	03-3661419	https://az804957.vo.msecnd.net/photogym/20140611114509_瘣餃?銝剖?1.jpg	蝢賜???擗?,????擗?	CLOSE	0101000020E6100000E1EF17B325545E40593D79BBD2F43840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
230	?葛?桃?擃擗?65145?脫?蝮??皜舫??頝???\N	\N	23.57682014	120.3056896	05-7821799	https://az804957.vo.msecnd.net/photogym/20140610152117_DSCN4919.JPG	蝐???蝢賜???????獢???FREE	0101000020E61000008CAE1C6B90135E4061F9147CAA933740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
231	?曉控撌亥噙摮貊?瘣餃?銝剖?	?箏?撣縑蝢拙?敹??梯楝5畾?36撌?5??63000	63000020	25.03912171	121.5721992	02-27226616	https://az804957.vo.msecnd.net/photogym/20140611140822_DSC_0847.jpg	蝐???蝢賜???擗?,????擗?,獢???擗?,?亥澈???恍???蝺游恕),???恕,皜豢陶瘙?擗?	CLOSE	0101000020E610000008B364E99E645E407B0361E1030A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
232	?楝??????擗?	?儔蝮?之??楝??31??10010	10010040	23.61051433	120.4226661	05-2694974	https://az804957.vo.msecnd.net/photogym/20140611145812_?楝??蝐????冽).JPG	蝐???蝬脩???????FREE	0101000020E61000002F281DF60C1B5E40E016C9AA4A9C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
233	??擃葉蝬脩????箏?撣?撟喳?撱箏像鈭?111??67000	67000360	22.98755852	120.1786816	06-2932323#410	https://az804957.vo.msecnd.net/photogym/20140611144453_F:\\?游閮剖?\\1000218\\SNV31022.JPG	蝬脩???????FREE	0101000020E61000006819F3846F0B5E4042499AA2D0FC3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
234	?憭批飛擃銝擗?獢?撣?撅勗?憭批??噸?楝5??68000	68000070	24.98413081	121.3423151	03-3507001#3523	https://az804957.vo.msecnd.net/photogym/20140611134540_IMG_2098.JPG	蝐???蝢賜???擗?,獢???擗?,????擗?	PAID	0101000020E610000053DB977DE8555E409DEF2BFFEFFB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
235	?典之?葉摰文???????蝮????萄控頝?-6??10008	10008020	23.9732454	120.9447653	049-2913483#317	https://az804957.vo.msecnd.net/photogym/20140611135916_DSC07036.JPG	????FREE	0101000020E61000005279E008773C5E4081FB4B9C26F93740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
236	銝剛?憭批飛????擗?	?箔葉撣???之頝?45??66000	66000030	24.11788431	120.674724	04-22840230#208	https://az804957.vo.msecnd.net/photogym/20140611163018_NFOZ8SHG2KQI05J79TW9.jpg	????擗?	FREE	0101000020E6100000E27492AD2E2B5E405A2988AA2D1E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
237	?憭批飛擃鈭尹	獢?撣?撅勗?憭批??噸?楝5??68000	68000070	24.98803293	121.3416928	03-3507001#3523	https://az804957.vo.msecnd.net/photogym/20140611144641_IMG_2102.JPG	蝐???????擗?,????擗?	PAID	0101000020E6100000D6517A4BDE555E4097B8E1B9EFFC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
238	?憭批飛摰文?蝐???獢?撣?撅勗?憭批??噸?楝5??68000	68000070	24.98369951	121.3429239	03-3507001#3523	https://az804957.vo.msecnd.net/photogym/20140611164947_10.jpg	????擗?,蝐???PAID	0101000020E610000013E11577F2555E408E8A28BBD3FB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
239	?ㄝ???啣????儔撣??ㄝ?梯楝346??10020	10020010	23.48910014	120.4660127	05-2762063#113	https://az804957.vo.msecnd.net/photogym/20140611164353_?2.jpg	?啣???蝐???????擗?	FREE	0101000020E61000005281EE26D31D5E40DFC4B1AA357D3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
240	?脫?蝘?憭批飛摰文??????脫?蝮???剖?憭批飛頝臭?畾?23??10009	10009010	23.69209369	120.5364293	05-5342601#2705	https://az804957.vo.msecnd.net/photogym/20140611213417_IMG_3756.JPG	????擗?	FREE	0101000020E61000006F078FDB54225E406651540D2DB13740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
241	璈??瘣餃?銝剖?	?脫?蝮?漸撖桅?璈??敺瑁楝248??10009	10009130	23.79770943	120.2736747	05-6912358#230	https://az804957.vo.msecnd.net/photogym/20140612074214_DSC05690.JPG	????擗?,蝢賜???擗?	CLOSE	0101000020E6100000878FE3E283115E40918F69AF36CC3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
242	?啁?擃極蝐????箏?撣??銝剜迤頝?8??67000	67000010	23.31401572	120.3175449	06-6322377	https://az804957.vo.msecnd.net/photogym/20140612085011_DSC_0472.JPG	蝐???????FREE	0101000020E6100000BE20D8A752145E4074D48F5563503740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
243	曈單擃葉????擗?	擃?撣陶撅勗??啣?頝?57??64000	64000120	22.61369395	120.3421408	07-7658288	https://az804957.vo.msecnd.net/photogym/20140612093705_10356725_10152473353088158_359325966679296879_n.jpg	????擗?	FREE	0101000020E610000025A886A2E5155E40C800F50B1B9D3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
244	暽輸??葉擃擗??箸蝮?嘀??樴??璁株楝38??10014	10014050	22.90706719	121.1339879	089-551006	https://az804957.vo.msecnd.net/photogym/20140610131656_暽輸??葉???湧尹曈亦??jpg	蝐???蝢賜???擗?,????擗?	PAID	0101000020E6100000D223FC4193485E401A532C8E35E83640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
245	摰園?憟喃葉?啣??湧?閮剔????	?箏?撣葉镼踹??亙熒頝臭?畾?42??67000	67000370	22.9820652	120.2009064	06-2133265#2230	https://az804957.vo.msecnd.net/photogym/20140612103338_ZJL29MLYSX30UCLKSD6Z.jpg	?啣???蝐???????擗?	CLOSE	0101000020E6100000A76384A6DB0C5E402A8AFC9F68FB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
246	鈭日之摮貉正??????啁姘撣?憭批飛頝?001??10018	10018010	24.78792287	120.9946203	03-5712121#51003	https://az804957.vo.msecnd.net/photogym/20140623215440_镼踹????游??JPG	镼踹?????FREE	0101000020E6100000031CE7DBA73F5E40A36B2E50B5C93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
247	撱箏??葉擃擗??脫?蝮??皜舫憭批?頝?68??10009	10009060	23.57385046	120.2961516	05-7832724	https://az804957.vo.msecnd.net/photogym/20140624102149_IMAG1120[1].jpg	????擗?	CLOSE	0101000020E61000001E2AD725F4125E409B7E1EDDE7923740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
248	憌??葉蝬??	?脫?蝮??皝?憌??之?楝81??10009	10009180	23.64256838	120.1737303	05-7723218	https://az804957.vo.msecnd.net/photogym/20140624111528_???湧尹??001.jpg	????擗?,蝐???CLOSE	0101000020E6100000C134B1651E0B5E40308B815C7FA43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
249	撅勗??蝬??	?脫?蝮???琿?撅勗??撅梯楝3??10009	10009170	23.67810253	120.3117996	05-7882152	https://az804957.vo.msecnd.net/photogym/20140624152056_P1400880.JPG	????蝐???FREE	0101000020E6100000FA394F86F4135E4053AF9D2098AD3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
250	??葉蝬脩???擗?	?脫?蝮???剖??脰??69??10009	10009010	23.71366179	120.550999	05-5323296#204	https://az804957.vo.msecnd.net/photogym/20140619105603_IMG_0474.jpg	蝬脩???擗?,????擗?	FREE	0101000020E61000003D484F9143235E406F74008AB2B63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
251	鈭日之摮詨????????啁姘撣???銵?5??10018	10018010	24.79806702	120.9837413	03-5712121#51003	https://az804957.vo.msecnd.net/photogym/20140624223212_?????游??JPG	???∪?????FREE	0101000020E61000005FCE119EF53E5E408BEAC61E4ECC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
252	?葛擃葉憸券?	?脫?蝮??皜舫??頝?6??10009	10009060	23.57920959	120.3039783	05-7821411#307	https://az804957.vo.msecnd.net/photogym/20140625101323_IMAG0188.jpg	????擗?,蝐???FREE	0101000020E6100000654C666174135E405F94661447943740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
253	蝡嫣???蝬脩???擗?	?啁姘蝮?姘??蝡嫣???摮?62銋???10004	10004010	24.83636363	121.01331	03-5552472#12	https://az804957.vo.msecnd.net/photogym/20140609104451_IMG_1017.jpg	蝬脩???擗?	FREE	0101000020E61000006DAD2F12DA405E40F26946ED1BD63840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
254	鈭??葉????擗?	?脫?蝮??撏?撏正?葉甇?楝88??10009	10009110	23.77257644	120.407635	05-5982020#132	https://az804957.vo.msecnd.net/photogym/20140625112925_IMAG0070po.jpg	????擗?	FREE	0101000020E61000001E6D1CB1161A5E40CA75CF91C7C53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
255	鈭??葉????擗?	?脫?蝮??撏?撏正?葉甇?楝88??10009	10009110	23.7737203	120.4073399	05-5982020#132	https://az804957.vo.msecnd.net/photogym/20140625151353_IMAG0060po.jpg	????擗?	FREE	0101000020E6100000C7365FDB111A5E4056C0988812C63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
256	?⊥?擃葉????擗?	敶啣?蝮????耨頝?9??10007	10007100	23.9604601	120.563482	04-8320364#320	https://az804957.vo.msecnd.net/photogym/20140626091838_IMG_8175.JPG	????擗?	FREE	0101000020E61000009E78CE1610245E40E69C8EB6E0F53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
257	?凋遢?葉瘣餃?銝剖?	??蝮?隞賡銝剖亢頝?75??10005	\N	24.69107586	120.9014189	03-7663207#501	https://az804957.vo.msecnd.net/photogym/20140617084954_DSC09342.JPG	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E6100000C3DFE5D8B0395E404DC1F958EAB03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
258	憭扳漯?葉?啣???獢?撣之皞芸?瘞??梯楝210??68000	68000030	24.87985708	121.2967014	03-3882024#315	https://az804957.vo.msecnd.net/photogym/20140620104551_DSC05397.JPG	?啣???????擗?	FREE	0101000020E61000005B6BDE27FD525E400AC147503EE13840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
259	憭扳???瘣餃?銝剖?	?脫?蝮????憭扳?????4??10009	10009120	23.76358727	120.3087473	05-6962741#13	https://az804957.vo.msecnd.net/photogym/20140626130127_DSC00195.JPG	????擗?	CLOSE	0101000020E61000009C0E0984C2135E40BB4A90747AC33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
260	?箇瘚瑟?憭批飛蟡亥?蝬脫??	?粹?撣葉甇???祐頝???10017	10017010	25.15082038	121.772579	02-24622192#2214	https://az804957.vo.msecnd.net/photogym/20140626111428_蟡亥?蝬脫??.JPG	蝬脩???擗?,????擗?	FREE	0101000020E6100000E3A430EF71715E4098AB172A9C263940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
261	????摮貊?瘣餃?銝剖?	??蝮?之皝?蝢拙????楝5??10005	10005080	24.39825665	120.8661801	037-991462#13	https://az804957.vo.msecnd.net/photogym/20140626145703_摮貊?瘣餃?銝剖?.JPG	蝐???????擗?	PAID	0101000020E61000008B7CA87E6F375E401E2AD725F4653840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
262	憭批???蝬??	?儔蝮?摮????楝	10010	10010020	23.45976723	120.2405119	05-2949036#034	https://az804957.vo.msecnd.net/photogym/20140624140616_P1140669.JPG	蝐???????擗?	FREE	0101000020E61000002033068C640F5E405D9F204EB3753740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
263	擐砍??怨風蝞∠?撠?摮豢擃擗??箏?撣????頝?2??63000	63000120	25.12286703	121.4644575	02-28584180#2145	https://az804957.vo.msecnd.net/photogym/20140627130210_C:\\Documents and Settings\\user\\獢\\???啣?\\???啣?-???游?抒?\\?腹\\蝢賜?\\DSC_6523-1.JPG	蝢賜???擗?,????擗?	CLOSE	0101000020E61000007138F3ABB95D5E404D9BB336741F3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
264	曈喳控瘝?????擃?撣陶撅勗?憭扳?頝?64000	64000120	22.61540733	120.33948	07-8224646	https://az804957.vo.msecnd.net/photogym/20140619104517_20130419_152906.jpg	曈喳控瘝?????FREE	0101000020E61000005969520ABA155E409511B4558B9D3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
265	憭扳?蝐??	擃?撣???	64000	64000340	22.96590114	120.5459189	07-7229449#678	https://az804957.vo.msecnd.net/photogym/20140630102525_IMG_0044.JPG	憭扳?蝐??	FREE	0101000020E61000002C71D355F0225E4018780F4C45F73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
266	?臬控??蝐?????蝮???剝?臬控????8??10005	10005070	24.35283484	120.8649536	04-25921221	https://az804957.vo.msecnd.net/photogym/20140630153005_CAM01477.jpg	蝐???蝬脩???擗?,蝢賜???擗?,????擗?	FREE	0101000020E6100000AE2358665B375E407CB05262535A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
267	??葉??擗?擃?撣??桀??啗?頝?7??64000	\N	22.58243342	120.3225875	07-8217677#22	https://az804957.vo.msecnd.net/photogym/20140627150822_20140627_145842.jpg	????擗?	PAID	0101000020E61000004CA60A46A5145E4058FF4A5B1A953640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
268	?啁姘??蝬??	?啁姘撣??飛銵?06??10018	10018010	24.79641129	120.9663123	03-5222153#262	https://az804957.vo.msecnd.net/photogym/20140606092957_1.jpg	蝢賜???擗?,????擗?	PAID	0101000020E61000003E8E8B0FD83D5E4016B73C9CE1CB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
269	?剖飲擃葉瘣餃?銝剖?	?箸蝮?撊潮?璊唳硃??7??10014	10014160	22.04887487	121.5112366	089-732016	https://az804957.vo.msecnd.net/photogym/20140613085143_IMG_8508.JPG	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E61000002B61B719B8605E400A3F4010830C3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
270	?箏?憭批飛????擗?	?箏?撣葉镼踹?璅寞?銵?畾?3??67000	67000370	22.98376512	120.208481	06-2133111#341	https://az804957.vo.msecnd.net/photogym/20140625161125_C:\\Users\\user\\Desktop\\???湧尹?抒?\\??????JPG	????擗?	CLOSE	0101000020E61000009835B1C0570D5E407458E907D8FB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
271	敹急???瘣餃?擗?獢?撣???憭扳?頝?89??68000	68000010	25.01902044	121.3154313	03-3580001	https://az804957.vo.msecnd.net/photogym/20140620135024_IMG_3205.jpg	蝢賜???擗?,蝐???????擗?,頨脤?	PAID	0101000020E6100000A068C30630545E406AC10786DE043940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
272	?望??葉????擗?	?脫?蝮???銝剛?頝?11??10009	10009020	23.67851049	120.4700178	05-5975474#31	https://az804957.vo.msecnd.net/photogym/20140701085904_C:\\Documents and Settings\\user\\獢\\蝐??廄\DSC00854.JPG	????擗?	FREE	0101000020E61000006CE289C5141E5E40FE8A0CDDB2AD3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
273	?啗????株蝐????箸蝮??撜圈??啗???????10014	10014140	22.63162642	121.0031042	089-781687#203	https://az804957.vo.msecnd.net/photogym/20140701110543_DSC_0254.jpg	????擗?	FREE	0101000020E6100000BC5EF5DB32405E408730E144B2A13640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
274	樴??葉擃擗?擃?撣?瞈?樴控?葉?航楝68??64000	64000310	22.87912583	120.5716628	07-6851314	https://az804957.vo.msecnd.net/photogym/20140617133216_IMAG1813.jpg	????擗?	CLOSE	0101000020E6100000BF95911F96245E403AEBF0630EE13640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
275	?折嘀??蝐????箸蝮?絲蝡舫??拍酉???楝1??10014	10014120	23.18611398	121.0253638	089-938040	https://az804957.vo.msecnd.net/photogym/20140701104118_IMG_0477.jpg	????擗?,蝐???FREE	0101000020E610000025E07C8F9F415E40AB6D712AA52F3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
276	瘚琿?撌亙?????擃?撣椰??撌衣?憭扯楝1??64000	64000030	22.67335721	120.2853477	07-5819155#538	https://az804957.vo.msecnd.net/photogym/20140606154310_P1070826.JPG	????FREE	0101000020E610000049DFFF2243125E40CE795B2361AC3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
277	瞍喳??葉?啣????啣?撣葉??撱??頝?9??65000	65000030	25.00205902	121.5052056	02-22488616	https://az804957.vo.msecnd.net/photogym/20140616210927_C14_2468.JPG	憸券?,蝐????????啣???????FREE	0101000020E61000006370DE4955605E40D38F9FF086003940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
278	銝剛??極蝐?????蝮?姘?憭抒?頝?11??10005	10005040	24.68871683	120.8721828	(03)7467360-307	https://az804957.vo.msecnd.net/photogym/20140612140105_IMG_20140612_135020[1].jpg	????擗?	FREE	0101000020E61000008F88CED7D1375E40070E05BF4FB03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
279	曈唾正??銝剖飛????擗?	擃?撣陶撅勗??葉???航楝69??64000	64000120	22.61981447	120.352875	07-7463452#31	https://az804957.vo.msecnd.net/photogym/20140702092656_SAM_0169.jpg	????CLOSE	0101000020E6100000DD24068195165E40D23C3E29AC9E3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
280	镼輯?葉蝐????脫?蝮?正?粹?噙镼輯楝217??10009	10009040	23.79257033	120.462513	05-5863522	https://az804957.vo.msecnd.net/photogym/20140630104248_蝐?1.JPG	????擗?	FREE	0101000020E6100000643E20D0991D5E4043219FE3E5CA3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
281	?剜散??瘣餃?銝剖?	獢?撣撅?銝剖控?梯楝鈭挾668撌?4??68000	68000110	24.96364047	121.1414552	03-4901204	https://az804957.vo.msecnd.net/photogym/20140702153818_IMG_1679-1.JPG	蝢賜???擗?,????擗?	CLOSE	0101000020E610000058761C9A0D495E4088C04F24B1F63840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
282	???葉????擗?	?梯蝮???瘞?銵?0??10015	10015030	23.33563598	121.3115019	03-8882054#13	https://az804957.vo.msecnd.net/photogym/20140702161539_IMG_0634.jpg	????擗?	FREE	0101000020E61000001449AAA5EF535E40FE75553DEC553740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
283	暺??銵飛?Ｙ????	?啣?撣陸撅勗?暺?頝?銋???65000	65000160	25.06631916	121.4209843	02-29097811#1251	https://az804957.vo.msecnd.net/photogym/20140603101616_DSC06096.JPG	蝐???????擗?,蝬脩???擗?	CLOSE	0101000020E610000049282268F15A5E40564CDF4AFA103940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
284	?梯蝮??銝剜迤擃擗??梯蝮??桀?瘞???楝53??10015	10015010	23.97798897	121.6131055	03-8580686	https://az804957.vo.msecnd.net/photogym/20140611151611_?冽.jpg	蝐???????擗?	CLOSE	0101000020E6100000DBDFD91E3D675E40ACFF317C5DFA3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
285	???瘣餃?銝剖?	??蝮???剝?啣??葉撅梯楝125??10005	10005070	24.31239314	120.8247399	04-25892008#723	https://az804957.vo.msecnd.net/photogym/20140616143153_2014-06-16 08.41.03.jpg	蝢賜???擗?,????擗?	CLOSE	0101000020E6100000348DDC89C8345E4075CB2FFFF84F3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
342	?啁姘擃??????啁姘撣?摮詨?頝?28??10018	10018010	24.7957149	120.9841168	03-5722150	https://az804957.vo.msecnd.net/photogym/20140709104519_X3VBLCJRLB1JW0IWW19V.jpg	????FREE	0101000020E61000006DDC07C5FB3E5E409E70C0F8B3CB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
286	撖西?憭批飛擃擗??箏??∪?)	?箏?撣葉撅勗?憭抒銵?0??63000	63000040	25.08457119	121.5456258	02-25381111#3811	https://az804957.vo.msecnd.net/photogym/20140617182508_擃擗冽.JPG	蝐???獢???擗?,????擗?,蝢賜???擗?,?亥澈???恍???蝺游恕),擃?賭葉敹????恕	PAID	0101000020E6100000A5B67988EB625E40DA3B1F75A6153940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
287	撖西?憭批飛擃擗?擃??∪?)	擃?撣??憭批飛頝?00??64000	64000350	22.90517463	120.4667287	07-6678888#3261	https://az804957.vo.msecnd.net/photogym/20140617160150_擃擗典?閫.JPG	蝢賜???擗?,蝐???????擗?,?亥澈???餃??恕	CLOSE	0101000020E6100000B2A60DE2DE1D5E40D7044986B9E73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
288	蝎曇?擃葉?	敶啣?蝮?蔑???ㄝ頝?00??10007	10007010	24.07246456	120.5277658	(04)7622790	https://az804957.vo.msecnd.net/photogym/20140618164841_P1020043.JPG	?啣???蝐???????擗?	FREE	0101000020E6100000A0BC34EAC6215E40AC5193098D123840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
289	璅嫣犖?怨風蝞∠?撠?摮豢????擃?撣楝蝡孵??啁?頝?52??64000	64000240	22.88329219	120.2635735	07-6979333	https://az804957.vo.msecnd.net/photogym/20140618172019_???游??JPG	????擗?	FREE	0101000020E6100000E8A56263DE105E40BADCDC6F1FE23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
290	?航擃葉?	獢?撣???敺抵?頝?39??68000	68000010	24.99061922	121.3022129	03-3322605#1351	https://az804957.vo.msecnd.net/photogym/20140619144210_53872.jpg	?啣????蝐???????CLOSE	0101000020E61000007A7BC67457535E4064B0A03899FD3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
291	瘚瑟?擃葉?啣????梯蝮???????啗楝36??10015	10015040	24.00746309	121.6132879	03-8242588	https://az804957.vo.msecnd.net/photogym/20140619162246_瘚瑟?曈亦??jpg	????擗?,蝐????亥澈???恍???蝺游恕)	CLOSE	0101000020E61000001562E41B40675E40247ADF19E9013840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
292	?賣?憭批飛瘣餃?銝剖?	?箏?撣???蝡噙銵?畾?55??63000	63000120	25.1216217	121.5142487	02-28267000#2169	https://az804957.vo.msecnd.net/photogym/20140620141950_CIMG0740.JPG	????擗?,獢???擗?,?餃??恕,蝐???蝢賜???擗?,?亥澈???恍???蝺游恕),敹?摰?CLOSE	0101000020E6100000AC206173E9605E40E2FB8799221F3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
293	?賣?憭批飛撅曹??	?箏?撣???蝡噙銵?畾?55??63000	63000120	25.11978395	121.5137203	02-28267000#2169	https://az804957.vo.msecnd.net/photogym/20140620161711_CIMG0744.JPG	蝐???????擗?,蝬脩???擗?	FREE	0101000020E6100000A5F21BCBE0605E40F0D53329AA1E3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
294	?賣?憭批飛撅梢??????箏?撣???蝡噙銵?畾?55??63000	63000120	25.12518658	121.514883	02-28267000#2169	https://az804957.vo.msecnd.net/photogym/20140620163000_CIMG0734.JPG	?啣???蝐???????擗?,頞喟???FREE	0101000020E61000000C91D3D7F3605E4083FF4A3A0C203940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
295	擃?蝘?憭批飛撱箏極?∪?????擗?	擃?撣?瘞?撱箏極頝?15??64000	64000050	22.64780399	120.3292018	07-3814526#13536	https://az804957.vo.msecnd.net/photogym/20140701091014_?抒?.JPG	????擗?	FREE	0101000020E610000033326DA411155E40B044777BD6A53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
296	?桀???摰文?蝬??	?脫?蝮???剖?蝷曉????60??10009	10009010	23.69899774	120.5401871	05-6341109#036	https://az804957.vo.msecnd.net/photogym/20140702152104_SAM_6204.JPG	蝬脩???擗?,????擗?,蝐???擗?	CLOSE	0101000020E6100000260EEA6C92225E4025471184F1B23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
297	瘞詨???瘞詨?擗??箔葉撣正撅臬?镼踹扈頝臭?畾?33??66000	66000060	24.18411683	120.6250226	04-24624470#731	https://az804957.vo.msecnd.net/photogym/20140717141602_瘞詨?擗灶憯葬.jpg	蝢賜???擗?,????擗?	PAID	0101000020E6100000B290CA5E00285E40427ED347222F3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
298	撖??擃?擗??箔葉撣???鞊正?葉撅梯楝455??66000	66000090	24.25191434	120.7129025	04-25222542#724	https://az804957.vo.msecnd.net/photogym/20140718101433_DSC00512.JPG	擃?擗?蝐???FREE	0101000020E610000025AFCE31A02D5E4084B14B757D403840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
299	??憭批飛????擗?	??蝮??撖折?憭批飛頝???9020	9020040	24.44695845	118.3223378	082-313802	https://az804957.vo.msecnd.net/photogym/20140718134722_IMG_3740.JPG	????擗?	FREE	0101000020E6100000EF50B92EA1945D40BD6B75DE6B723840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
300	?勗陸?葉????擗?	?箔葉撣?隞?頝?30??66000	66000020	24.12510592	120.6871641	04-22825133#731	https://az804957.vo.msecnd.net/photogym/20140718150659_DSCN7987.JPG	????擗?	FREE	0101000020E61000000F1F227FFA2B5E409DEF0AF106203840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
301	?日?葉蝬??	敶啣?蝮??剝?撏?葉摮貉楝67??10007	10007220	23.88009875	120.4611102	04-8922004#39	https://az804957.vo.msecnd.net/photogym/20140718160406_蝬??.JPG	????FREE	0101000020E610000087365BD4821D5E401F80D4264EE13740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
302	?舀?擃葉?????箏?撣?撅勗??冽???頝?27??63000	63000080	24.98543724	121.568259	02-29390310	https://az804957.vo.msecnd.net/photogym/20140709133437_DSC_0039.JPG	????擗?	CLOSE	0101000020E6100000172AFF5A5E645E407D0F6E9D45FC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
303	???葉?????箔葉撣正?蝢?頝臭?畾?89??66000	66000040	24.14291093	120.6623161	04-23726085	https://az804957.vo.msecnd.net/photogym/20140723113802_K5JC4072.JPG	????擗?	CLOSE	0101000020E610000050471163632A5E4048978ACF95243840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
304	?犖憟喃葉蝐????箏?撣皝??扳?頝臭?畾?14??63000	63000100	25.0812481	121.5877104	02-27956899#401	https://az804957.vo.msecnd.net/photogym/20140610105853_?.JPG	????擗?	CLOSE	0101000020E610000039E1140C9D655E40B55CECACCC143940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
305	擐砍??怠飛?Ｗ??瘣餃?銝剖?	?啣?撣???銝剜迤頝臭?畾?6??65000	65000210	25.2548655	121.4942729	02-26360303#5013	https://az804957.vo.msecnd.net/photogym/20140703144529__IGP1049.JPG	蝐???擗?,????擗?,蝢賜???擗?,獢???擗?	CLOSE	0101000020E61000002433CD2AA25F5E40F2608BDD3E413940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
306	?暹?摰嗅?蝐??	?箏?撣獄鞊??像頝???67000	67000070	23.17797242	120.2460265	06-5722079#305	https://az804957.vo.msecnd.net/photogym/20140603163918_IMG_34591.JPG	蝐???????FREE	0101000020E6100000C2DCEEE5BE0F5E406F7DBB998F2D3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
307	??擃葉????擗?	?箔葉撣云撟喳??噸頝?88??66000	66000270	24.10520758	120.7272524	04-22713911#204	https://az804957.vo.msecnd.net/photogym/20140703155938_DSC_0981.jpg	????擗?	CLOSE	0101000020E6100000007CA64D8B2E5E402C644BE2EE1A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
308	?凋縑擃葉蝐????箏?撣???圈頝?0??67000	67000330	22.97384317	120.2019471	(06)2619885	https://az804957.vo.msecnd.net/photogym/20140703180506_IMG_20140703_181103.jpg	蝐????蝐???????擗?,頨脤?	FREE	0101000020E6100000698187B3EC0C5E403D9536C94DF93640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
309	??憟喃葉鈭?擗??箏?撣????銵?7撌?4??67000	67000340	23.01611379	120.2226859	(06)2740126	https://az804957.vo.msecnd.net/photogym/20140703193956_IMG_5389.JPG	蝐???蝢賜???擗?,????擗?,獢???擗?,???恕	CLOSE	0101000020E6100000F1715C7C400E5E408A10890820043740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
310	?脫??葉?????脫?蝮???剖??噸頝?99??10009	10009010	23.69986962	120.5327171	05-5326071#036	https://az804957.vo.msecnd.net/photogym/20140702144100_IMG_3830.JPG	????擗?	CLOSE	0101000020E610000047A1760918225E402C5DC9A72AB33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
311	?勗??葉????敶啣?蝮?憯??瑟??蔑?∟楝鈭挾580??10007	10007080	24.0303996	120.5507228	04-7862043#45	https://az804957.vo.msecnd.net/photogym/20140707101823_DSC00038.GIF	????FREE	0101000020E610000057CAD70A3F235E40BDCFA744C8073840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
312	?⊥??葉?啣???敶啣?蝮???????瞏剛楝2??10007	10007100	23.96356312	120.5590779	04-8320873	https://az804957.vo.msecnd.net/photogym/20140707101725_??冽.JPG	?啣???????擗?	FREE	0101000020E6100000A61AACEEC7235E401F089812ACF63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
313	憭芸像??蝬??	?梯蝮??皞芷?憭芸像??????10015	10015130	23.40540613	121.3200608	03-8841359	https://az804957.vo.msecnd.net/photogym/20140703141550_蝐???.jpg	????擗?	FREE	0101000020E6100000D22E4BE07B545E40ABF235B2C8673740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
314	暽踵葛???啣???敶啣?蝮?嘀皜舫????瘞楝192??10007	10007020	24.05252866	120.4331642	04-7772038#131	https://az804957.vo.msecnd.net/photogym/20140707141724_26K4UXCC644SQ2C5HHPD.JPG	?啣???蝐???頨脤?,????擗?	FREE	0101000020E6100000123356F6B81B5E407ECDAC84720D3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
315	憭批????啣???敶啣?蝮?撓皜舫?憭批??蔑?啗楝銝挾724??10007	10007050	24.16043938	120.4916391	04-7982307	https://az804957.vo.msecnd.net/photogym/20140707141015_DSCN0020.JPG	?啣???蝐???頨脤?,????擗?	FREE	0101000020E6100000D5FBD703771F5E402C17228E12293840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
316	暽踵葛??瘣餃?銝剖?	敶啣?蝮?嘀皜舫????瘞楝192??10007	10007020	24.05285197	120.4335451	04-7772038	https://az804957.vo.msecnd.net/photogym/20140707142525_DSC01818.JPG	????擗?,蝢賜???擗?	PAID	0101000020E6100000D475F233BF1B5E40DEADEAB4870D3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
317	?擃葉?啣????箔葉撣撜啣???頝?1??66000	66000260	24.06038285	120.704239	04-23393071#313	https://az804957.vo.msecnd.net/photogym/20140707145830_IMG_1352.jpg	?啣???蝐???????擗?	FREE	0101000020E610000056647440122D5E4041FD1D40750F3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
318	????瘣餃?銝剖?	敶啣?蝮?嘀皜舫?啣悅???楝60??10007	10007020	24.05660426	120.4289424	04-7772042#713	https://az804957.vo.msecnd.net/photogym/20140707143459_clip_image0021.jpg	????擗?,蝐???CLOSE	0101000020E610000089F7D2CA731B5E40A883E59D7D0E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
319	?勗??蝬??	?脫?蝮??ａ??勗??璁株楝29撌???10009	10009140	23.6739022	120.2563342	05-6991036	https://az804957.vo.msecnd.net/photogym/20140625121753_5.jpg	蝐???????擗?	FREE	0101000020E61000002A768FC767105E40D4B3C5DA84AC3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
320	?砌???蝬脩???擗?	敶啣?蝮???镼踹噸??鞈Ｚ?35??10007	10007190	23.87049893	120.522058	04-8882119	https://az804957.vo.msecnd.net/photogym/20140708095142_蝬脩???jpg	蝬脩???擗?,????擗?,頨脤?	FREE	0101000020E61000005F27F56569215E40918D9304D9DE3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
321	鈭偌?葉蝐???敶啣?蝮??瘞湧?皞????毽13??10007	10007180	23.804041	120.6445545	04-8791557#32	https://az804957.vo.msecnd.net/photogym/20140707102431_04.JPG	蝐???????擗?	FREE	0101000020E6100000567F846140295E40A5A487A1D5CD3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
322	?⊥???蝐???敶啣?蝮???銝???瘞銵?21??10007	10007100	23.96052383	120.5780303	04-8320145#772	https://az804957.vo.msecnd.net/photogym/20140708103030_B02.jpg	蝐???????FREE	0101000020E610000036A6CC72FE245E40F0E0C4E3E4F53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
323	?儔擃葉蝐???擗?	?儔撣?憭折?頝臭?畾?38??10020	10020010	23.47802778	120.4636931	05-2762804	https://az804957.vo.msecnd.net/photogym/20140530120516_??jpg	頨脤?	FREE	0101000020E610000060F8D225AD1D5E40F3AD5107607A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
324	?????啣???敶啣?蝮??蝢撅梁???5?唬??楝279??10007	10007030	24.10311181	120.4952413	04-7575407	https://az804957.vo.msecnd.net/photogym/20140708095925_100_4731.JPG	?啣???蝐???頨脤?,????擗?	FREE	0101000020E61000003AC89008B21F5E4008C81B89651A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
325	?偏擃葉?????脫?蝮??撠暸?儔頝?22??10009	10009030	23.71147617	120.4418492	05-6322121#351	https://az804957.vo.msecnd.net/photogym/20140708104930_P_20140708_102435.jpg	擃擗?蝢賜???擗?,????擗?	CLOSE	0101000020E6100000E1F0DD41471C5E408908624D23B63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
326	皜憭批飛摰文??????啁姘撣??儔頝臭?畾?01??10018	10018010	24.79646269	120.996719	03-5715131#34677	https://az804957.vo.msecnd.net/photogym/20140708112348_摰文?????2.jpg	????擗?	FREE	0101000020E610000051137D3ECA3F5E40C00896FAE4CB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
327	撊箸蝘?憭批飛?啣耦/?渡??Ｚ????敺??	?箔葉撣?撅臬?撊箸頝???66000	66000070	24.13789817	120.6088275	04-23892088	https://az804957.vo.msecnd.net/photogym/20140708095209_C:\\Users\\LTU\\Desktop\\DSCN1184_隤踵憭批?.JPG	?啣耦/?渡??Ｚ????敺??,?亙??∪??????亙??∪?蝐???撖嗆??∪?蝐???撖嗆??∪?????撖嗆??∪?蝬脩????亙??∪?蝬脩???FREE	0101000020E6100000F3599E07F7265E400854624B4D233840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
328	?脰???啣???敶啣?蝮???瘞貉??云撟唾楝300??10007	10007230	23.94582637	120.3324097	04-8933261#12	https://az804957.vo.msecnd.net/photogym/20140708113038_DSC_0228_01.JPG	?啣???蝐???????擗?,頨脤?	FREE	0101000020E6100000E297553346155E402AD84EAD21F23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
329	瞏剖???????擗?	敶啣?蝮?之??瞏剖??蔬?楝1??10007	10007240	23.83564515	120.3481865	04-8941009	https://az804957.vo.msecnd.net/photogym/20140708142126_????.JPG	蝢賜???擗?	FREE	0101000020E6100000289A07B048165E409F4F2ED7ECD53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
330	擐??蝐???敶啣?蝮???擐???楝10銋???10007	10007200	23.87439879	120.3771544	04-8960654	https://az804957.vo.msecnd.net/photogym/20140708142928_P_20140707_104438.jpg	蝐???????擗?,頨脤?	CLOSE	0101000020E6100000B862354C23185E4044B65E99D8DF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
331	鈭虜??擃擗??箏?撣葉撅勗?銝??撣貉?16??63000	63000040	25.06398309	121.5415442	02-25023416#825	https://az804957.vo.msecnd.net/photogym/20140729102443_P3170022.JPG	????擗?	PAID	0101000020E6100000AA1501A9A8625E400A0C1F3261103940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
332	?扳??葉?嗅??????箏?撣皝?蝝恍???1??63000	63000100	25.07644772	121.5898266	02-27900843	https://az804957.vo.msecnd.net/photogym/20140729103029_????.jpg	????擗?	PAID	0101000020E6100000E55311B8BF655E40F740E91392133940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
333	?喳??葉蝐????箏?撣ㄚ???冽漯??楝2畾?60??63000	63000110	25.10381662	121.5569039	02-28411350#32	https://az804957.vo.msecnd.net/photogym/20140729105830_P1310665.JPG	????擗?	CLOSE	0101000020E6100000F3604150A4635E4067AEDBB9931A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
334	?梢????啣???撅蝮?皜舫?勗???楝45??10013	10013030	22.46386432	120.45084	08-8322064	https://az804957.vo.msecnd.net/photogym/20140616171449_IMAG0696.jpg	頞喟???蝐???頨脤?,????擗?,?啣???FREE	0101000020E6100000A2EE0390DA1C5E40682EE4CFBF763640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
335	隡豢??蝬??	敶啣?蝮?撓皜舫?銝??葉?航楝565??10007	10007050	24.1461099	120.4954746	04-7982314	https://az804957.vo.msecnd.net/photogym/20140708142107_DSC03184.JPG	蝐???????擗?	FREE	0101000020E6100000EABF18DBB51F5E40301F5A7567253840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
336	?箇擃??憭批飛?飛憭扳?(銵??游)	?箔葉撣????頝臭?畾?6??66000	66000050	24.15255897	120.689047	04-22213108#1106	https://az804957.vo.msecnd.net/photogym/20140708153724_?唳?摮詨之璅??jpg	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E61000000B9A9658192C5E4088DCCA1A0E273840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
337	摨瑕祐憭批飛????擗?	?箏?撣???摰葉頝臭?畾?88??67000	67000350	23.0605207	120.1570139	06-2552500#52410	https://az804957.vo.msecnd.net/photogym/20140708164136_蝐???jpg	????擗?	FREE	0101000020E61000001D6107840C0A5E40253BDB487E0F3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
338	?寡??憸券?	敶啣?蝮??蝢憛??蔑?啗楝鈭挾310??10007	10007030	24.13414317	120.5096479	04-7552430	https://az804957.vo.msecnd.net/photogym/20140707143628_IMG_20140703_113927.jpg	????擗?,蝢賜???擗?	CLOSE	0101000020E610000068BE39129E205E40BC21F03457223840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
339	瘚瑚???蝐????箏?撣????∪?頝臭?畾?6??67000	67000350	23.02838929	120.2004665	06-2505013#5102	https://az804957.vo.msecnd.net/photogym/20140709094618_蝬?? 2.jpg	蝐???????擗?	FREE	0101000020E6100000645C7171D40C5E404E1B408544073740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
340	???葉撠?銝剝蝐???敶啣?蝮???????蝡寡楝872??10007	10007200	23.89420287	120.427368	04-8904600#22	https://az804957.vo.msecnd.net/photogym/20140709101049_1.JPG	蝐???????擗?,頨脤?	FREE	0101000020E6100000D8D64FFF591B5E40ACA3B27AEAE43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
341	??擃葉????擗?	?箔葉撣??亙?銝剖控頝臭?畾?97??66000	66000230	24.1048844	120.6367707	04-23341336	https://az804957.vo.msecnd.net/photogym/20140709104112_0IF917RMMLZGLFU6LY83.JPG	????擗?	FREE	0101000020E610000044E3E4D9C0285E404FDC3BB4D91A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
343	摰??葉?啣????箏?撣???摰?頝臭?畾?27??67000	67000350	23.04947156	120.2180672	06-3559652#134	https://az804957.vo.msecnd.net/photogym/20140709085731_C:\\Users\\Administrator\\Desktop\\?.JPG	????擗?	FREE	0101000020E6100000231521D0F40D5E4038480C2BAA0C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
344	瘞???瘣餃?銝剖?	敶啣?蝮?蔑??瘞?頝?38??10007	10007010	24.08475274	120.542306	04-7224122	https://az804957.vo.msecnd.net/photogym/20140709112758_P1220668.JPG	????擗?	PAID	0101000020E61000002C9B3924B5225E40E08B065BB2153840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
345	????頨脤?	敶啣?蝮????????楝銝畾?65??10007	10007200	23.89590232	120.4269952	04-8902322#103	https://az804957.vo.msecnd.net/photogym/20140708142827_DSCN6228.JPG	頨脤?,蝐???????擗?	FREE	0101000020E610000022E3ACE3531B5E407FCFBCDA59E53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
346	蝢擃極????擗?	摰蝮?撅梢?撱??頝?17??10002	10002080	24.66981226	121.7517221	03-9514196#306	https://az804957.vo.msecnd.net/photogym/20140709111258_????.JPG	????擗?	FREE	0101000020E61000008CCB02371C705E40EC28F7D078AB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
347	瘞詨熒?葉?啣??湧?閮剜??	?箏?撣偶摨瑕?銝剖控頝?3??67000	67000310	23.02731037	120.2544277	06-2015247#8023	https://az804957.vo.msecnd.net/photogym/20140709132539_P1000641.JPG	?啣???????擗?	FREE	0101000020E610000093AC1E8B48105E40DDFDF9CFFD063740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
348	?啁?擃葉????擗?	?箏?撣??瘞?頝?01??67000	67000010	23.30814338	120.3111291	06-6562274#204	https://az804957.vo.msecnd.net/photogym/20140709140628_IMG_20140709_133741.jpg	????擗?	FREE	0101000020E61000005F55078AE9135E4033940B7CE24E3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
349	頛?憭批飛銝剔????啣?撣??銝剜迤頝?10??65000	65000050	25.03794066	121.4320296	02-29056436	https://az804957.vo.msecnd.net/photogym/20140618113628_銝剔???.jpg	蝐???????擗?,蝢賜???擗?	PAID	0101000020E6100000DBB97A5FA65B5E407FE3A57AB6093940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
350	???葉????擗?	?箏?撣???楝頝?畾???67000	67000340	23.00930003	120.2166402	06-2517906#130	https://az804957.vo.msecnd.net/photogym/20140709154922_DSC05965.JPG	????擗?	FREE	0101000020E6100000EE7FDB6EDD0D5E40AAB39C7C61023740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
351	瘞???蝐???敶啣?蝮?蔑??瘞?頝?38??10007	10007010	24.08402303	120.5423355	04-7224122	https://az804957.vo.msecnd.net/photogym/20140709110306_P1220655.JPG	????擗?,頨脤?	FREE	0101000020E61000006DFDF49FB5225E40F9F5858882153840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
352	擃葦憭折?銝剔??	擃?撣????望?鈭楝89??64000	6400800	22.75034855	120.4980469	07-7613875#526	https://az804957.vo.msecnd.net/photogym/20140709163915_R0021848.JPG	蝐???????擗?	FREE	0101000020E6100000F3D71A00E01F5E40DCD9B2D716C03640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
353	璅孵噸蝘?憭批飛??-蝬?????擃?撣?撌Ｗ?璈怠控頝?9??64000	64000210	22.76431804	120.3724658	07-6158000#2855	https://az804957.vo.msecnd.net/photogym/20140614134405_??8.gif	蝐???????擗?,璉????毀蝧,憯???蝬脩???擗?,瘝?????FREE	0101000020E61000003978CB7AD6175E40F68AD958AAC33640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
354	璅孵噸蝘?憭批飛??-銝?????擃?撣?撌Ｗ?璈怠控頝?9??64000	64000210	22.76019965	120.3766716	(07)6158000*2855	https://az804957.vo.msecnd.net/photogym/20140614133020_12.gif	?啣???蝐???????擗?	FREE	0101000020E61000003FD532631B185E403F2EBB719CC23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
355	?箸擃葉????擗?	?箸蝮??勗?銝剛頝臭?畾?21??10014	10014010	22.74625418	121.1463904	089-322070#6412	https://az804957.vo.msecnd.net/photogym/20140710095855_DSC_0003.JPG	????擗?	FREE	0101000020E6100000B21CD7755E495E40729A91830ABF3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
356	?梯擃噙?啣????梯蝮??桀?撱箏?頝?61??10015	10015010	23.98273352	121.598525	03-8312358	https://az804957.vo.msecnd.net/photogym/20140709105016_IMAG0177.jpg	?啣???頞喟???????擗?,蝐???FREE	0101000020E6100000A835CD3B4E665E403D15896C94FB3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
357	?箸憭批飛摮貊?瘣餃?銝剖??函????脤尹	?箸蝮??勗?憭批飛頝臭?畾?69??10014	10014010	22.73283175	121.0674369	08-9518232	https://az804957.vo.msecnd.net/photogym/20140708114546_摮貊?瘣餃?銝剖??函????脤尹.jpg	皜豢陶瘙?擗?,蝐???蝢賜???擗?,????擗?,擃?摰?擗????恕,?亥澈???恍???蝺游恕),?撗拙	CLOSE	0101000020E6100000CB02DCE250445E406FB88FDC9ABB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
358	憭扳??極?啣耦/?渡??Ｚ????敺??	?脫?蝮??撠暸?像銵?1??10009	10009030	23.71112764	120.4461047	(05)6322534	https://az804957.vo.msecnd.net/photogym/20140710115720_tcvhs10.jpg	蝐???????擗?,蝬脩???擗?	FREE	0101000020E6100000E245BAFA8C1C5E40E81405760CB63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
359	璅孵噸蝘?憭批飛銵憭扳?蝳桀?嚗擃擗剁?	擃?撣?撌Ｗ?璈怠控頝?9??64000	64000210	22.76484699	120.3764087	(07)6158000*2855	https://az804957.vo.msecnd.net/photogym/20140614115710_10.gif	????擗?,蝢賜???擗?,蝐???CLOSE	0101000020E6100000831B841417185E40797E2803CDC33640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
360	曈喳控擃葉????擗?	擃?撣陶撅勗??儔頝臭?畾?30??64000	64000120	22.63187308	120.3447912	07-7463150#380	https://az804957.vo.msecnd.net/photogym/20140710163121_????.JPG	????擗?	CLOSE	0101000020E6100000B6FC1B0F11165E40A2D2256FC2A13640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
361	皜舀??蝬脩???擗?	?箏?撣正皜臬?皜舀??撘萄?1銋???67000	67000140	23.12294106	120.2092588	06-7952231	https://az804957.vo.msecnd.net/photogym/20140710110418_IMG_0029.JPG	蝬脩???擗?	FREE	0101000020E61000009D99057F640D5E401B09B810791F3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
362	?梁擃葉????擗?	?儔蝮?摮?憭折???53??\N	\N	23.46465861	120.2514768	05-3794180	https://az804957.vo.msecnd.net/photogym/20140711100238_????-1.jpg	????擗?	FREE	0101000020E6100000FAEC253218105E403CC1DDDDF3763740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
363	敺??葉?嗅??????箏?撣?憯????24銋?0??67000	67000050	23.35392105	120.3595296	06-6871974#222	https://az804957.vo.msecnd.net/photogym/20140710172327_P_20140710_153518.jpg	?啣???蝐???????擗?	FREE	0101000020E61000006A7C708802175E40B11DE7919A5A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
364	瘞湧??極??????蝮?偌????頝???10008	10008110	23.80421279	120.8534288	049-2870666#235	https://az804957.vo.msecnd.net/photogym/20140619121546_D:\\?輻?\\photo\\?游\\IMG_0031.JPG	????FREE	0101000020E6100000BB5DD4939E365E402E13B0E3E0CD3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
365	?唳葛??擃葉擃擗??儔蝮?皜舫?摰桀???擃楝1??10010	10010070	23.55963542	120.3509009	05-3747060#254	https://az804957.vo.msecnd.net/photogym/20140710091613_DSC06603.JPG	???恕,蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E6100000C4680C2975165E404E955244448F3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
366	?ㄐ擃葉蝬??	??蝮??鋆⊿摰Ｗ???4?唳?楝19??10005	10005020	24.4392772	120.6549615	037-861042#623	https://az804957.vo.msecnd.net/photogym/20140711105827_IMG_1026.JPG	蝐???????FREE	0101000020E6100000E7A8A3E3EA295E40E2E0777874703840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
367	敺瑕?擃葉擃擗??箏?撣?敺瑕?銵?06??67000	67000320	22.97949385	120.2201539	06-2894560	https://az804957.vo.msecnd.net/photogym/20140711121431_PIC_5064.JPG	皜豢陶瘙?擗?,蝐???????擗?,蝢賜???擗?,獢???擗?	PAID	0101000020E61000008F256200170E5E401562E41BC0FA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
368	銝郭????銝剖?	擃?撣??銝郭銝頝?93??64000	64000060	22.63300536	120.3067946	07-2351150	https://az804957.vo.msecnd.net/photogym/20140711124702_撘萄振??376.JPG	頨脤?,蝐???????擗?,蝢賜???擗?,?啣???CLOSE	0101000020E6100000B965D185A2135E408864A7A30CA23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
369	敺瑕?擃葉?啣????箏?撣?敺瑕?銵?06??67000	67000320	22.97911804	120.2210209	(06)2894560	https://az804957.vo.msecnd.net/photogym/20140711131015_PIC_5065.JPG	?啣???蝐???????擗?	CLOSE	0101000020E6100000E14ED834250E5E403FB9D87AA7FA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
370	?啁?蝘?憭批飛????擗?	?脫?蝮???剖????楝1221??\N	\N	23.67712998	120.5486012	05-5370988#2312	https://az804957.vo.msecnd.net/photogym/20140711143444_IMG_20140715_111504.jpg	????擗?	CLOSE	0101000020E6100000F72235481C235E40BB3DEF6358AD3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
371	撅憭批飛????擗?	撅蝮???勗?瘞?頝???18	10013	10013010	22.66612966	120.5052835	08-7663800#10522	https://az804957.vo.msecnd.net/photogym/20140711150039_IMG_6551.jpg	????擗?(瘞??∪?)	FREE	0101000020E610000057ED9A9056205E407998307987AA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
372	隞噸?葉蝐??湧?閮剜??	?箏?撣?敺瑕?瘞?頝臭?畾?63??67000	67000270	22.95718631	120.2487436	06-2682724#44	https://az804957.vo.msecnd.net/photogym/20140711155055_5.jpg	蝐???????擗?	FREE	0101000020E6100000B7C5466AEB0F5E4001A179290AF53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
373	蝢擃葉頨??(???氬??)	摰蝮???梢?祆迤頝?24??10002	10002020	24.68355919	121.7635172	03-9567645#300	https://az804957.vo.msecnd.net/photogym/20140709113730_IMG_20140709_132532.jpg	?蝐???????擗?	FREE	0101000020E6100000BEFB3E77DD705E4025EE2DBCFDAE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
374	擃?憭批飛????擗?	擃?撣?璇?擃?憭批飛頝?00??64000	64000040	22.73221329	120.2775264	(07)5919490	https://az804957.vo.msecnd.net/photogym/20140711175802_??瑼?JPG	????擗?	PAID	0101000020E6100000B4F116FEC2115E401F3F865472BB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
375	?航????啣???敶啣?蝮?蔑??????敹?銵?08??10007	10007010	24.07654932	120.5984044	04-7384340	https://az804957.vo.msecnd.net/photogym/20140707095027_11 (3).JPG	蝐????啣???頨脤?,????擗?	FREE	0101000020E610000015F2F7414C265E4059EE79BC98133840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
376	蝢擃葉銝剜迤??摰文蝐???	摰蝮???梢?祆迤頝?24??10002	10002020	24.68092784	121.7627414	03-9567645#309	https://az804957.vo.msecnd.net/photogym/20140618145146_IMG_20140710_141924.jpg	蝐???蝢賜???擗?,????擗?	PAID	0101000020E610000089134EC1D0705E4065BC734951AE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
377	???葉蝐???敶啣?蝮?????頝臭?畾?36??10007	10007190	23.87776386	120.5217576	04-8882072#33	https://az804957.vo.msecnd.net/photogym/20140712182957_?抒?--蝐???jpg	蝐???????擗?	FREE	0101000020E6100000201CFD7964215E408C4FE021B5E03740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
378	暺?擃葉????擗?	?箏?撣獄鞊?蝤???41??67000	67000070	23.17300513	120.2480331	(06)5717123頧?34??35	https://az804957.vo.msecnd.net/photogym/20140713100854_DSC01920_2.jpg	????擗?	FREE	0101000020E6100000D53439C6DF0F5E40E6636F104A2C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
379	銵?擃葉????擗?	?箔葉撣?撅臬??像頝?61??66000	66000080	24.18274555	120.6743163	04-22911187	https://az804957.vo.msecnd.net/photogym/20140713211056_???游??JPG	????擗?	FREE	0101000020E610000039EA8DFF272B5E4052BD9069C82E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
380	??憟喃葉蝐??	?啣?撣??樴掖頝臭?畾?63??65000	65000230	25.134391	121.4486194	02-26182287	https://az804957.vo.msecnd.net/photogym/20140714000138_P1270686.jpg	蝐??,????擗?	CLOSE	0101000020E610000079D6242EB65C5E4072E0D57267223940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
381	摰擃葉蝐??	摰蝮???剖?敺抵?頝臭?畾???10002	\N	24.75245808	121.742447	03-9324153#112	https://az804957.vo.msecnd.net/photogym/20140714095026_IMG_5262.JPG	????擗?	FREE	0101000020E6100000DA006C40846F5E400136BD17A1C03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
382	撅憭批飛擃擗?撅蝮???勗?瘞?頝???18	10013	10013010	22.66598115	120.5044466	08-7663800#10522	https://az804957.vo.msecnd.net/photogym/20140714101306_IMG_6595.JPG	????擗?,蝐???蝢賜???擗?	CLOSE	0101000020E6100000046564DA48205E40A2009BBD7DAA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
383	瘝餃像擃葉擃??獢?撣?璇???銝剛?頝?37??68000	68000040	24.91548974	121.1880425	03-4823636#302	https://az804957.vo.msecnd.net/photogym/20140714095328_DSCF1598.JPG	?啣???蝐???????擗?	CLOSE	0101000020E610000084F068E3084C5E40A11F1D895DEA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
384	??銵飛?Ｘ??(擗?	擃?撣之撖桀????摮貉楝288??64000	64000140	22.60863054	120.4265036	(07)7889888	https://az804957.vo.msecnd.net/photogym/20140714112735_????jpg	????擗?	FREE	0101000020E61000001568C1D54B1B5E4096A50836CF9B3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
385	蝝摰?撠??	?箏?撣獄鞊?雓?撖桅?231??67000	67000070	23.15131781	120.2374542	06-5722306#183	https://az804957.vo.msecnd.net/photogym/20140714113011_P1170974.JPG	????擗?	CLOSE	0101000020E610000010D31973320F5E40994095C3BC263740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
386	??憭批飛?????啁姘撣?撅勗??梢???憟楝48??10018	10018030	24.77388624	120.9407347	03-5302255#6141	https://az804957.vo.msecnd.net/photogym/20140714121112_DSC00061.JPG	????FREE	0101000020E610000097AD50FF343C5E40D99F9B681DC63840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
387	蝳熒??瘣餃?銝剖?	擃?撣???瞍ａ銵?7??64000	6400800	22.61898873	120.3292636	07-7227134#721	https://az804957.vo.msecnd.net/photogym/20140714120117_014Q4KOLDB20JQGNPTAI.jpg	????擗?	CLOSE	0101000020E6100000D970A2A712155E404DF19F0B769E3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
388	撅旨擃葉擃擗?撅蝮???勗?鞊??摮貉楝100??10013	10013010	22.6749018	120.5045646	(08)7223409	https://az804957.vo.msecnd.net/photogym/20140714111951_?抒? 029.jpg	????擗?,獢???擗?	CLOSE	0101000020E610000009EE51C94A205E40F402475DC6AC3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
389	?箏?霅瑞??亙熒憭批飛擃擗??箏?撣????噸頝?65??63000	63000120	25.11841799	121.5186274	02-28227101#2901	https://az804957.vo.msecnd.net/photogym/20140714122228_S__4046900.jpg	蝐???蝢賜????????亥澈?恕,?餃??恕,?撗拙	CLOSE	0101000020E6100000CF73FA3031615E40DD4E32A4501E3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
390	摮貊?葉??擗??箏?撣飛?脣??臬?頝?40??67000	67000130	23.2369931	120.1837993	06-7832128#207	https://az804957.vo.msecnd.net/photogym/20140707164447_C:\\Users\\user\\Desktop\\DSCN4743.JPG	????擗?	CLOSE	0101000020E6100000C6A1235EC30B5E40AEE06D94AB3C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
391	銝剖亢憭批飛????獢?撣葉憯Ｗ?銝剖之頝?00??68000	68000020	24.96762828	121.1909473	03-4227151#57251	https://az804957.vo.msecnd.net/photogym/20140714145928_??冽.JPG	????FREE	0101000020E61000009C30067B384C5E40E448A97CB6F73840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
392	憭抒???????擗?	?脫?蝮?獢?憭抒???3??10009	10009090	23.73781914	120.5143654	05-5842504#13	https://az804957.vo.msecnd.net/photogym/20140707143749_????.JPG	????擗?	FREE	0101000020E61000006ACCDA5CEB205E40B0A914B7E1BC3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
393	?唳???????箏?撣?憯??瑞璅寥?銝81??67000	67000050	23.34501401	120.3166866	06-6320902#13	https://az804957.vo.msecnd.net/photogym/20140714162804_P1000320.JPG	????FREE	0101000020E61000003685DF9744145E40A09C91D652583740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
394	銝剖亢憭批飛靘???獢?撣葉憯Ｗ?銝剖之頝?00??68000	68000020	24.96829938	121.1908078	03-4267128	https://az804957.vo.msecnd.net/photogym/20140710103425_靘????JPG	蝐?擗???擗??餃??恕,???摰?擃?賢頨急?摰?PAID	0101000020E61000009734EB31364C5E404BD6D977E2F73840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
395	??擃葉蝐????箏?撣??憭批?頝?6??67000	67000010	23.31327947	120.3219867	06-6352201#1206	https://az804957.vo.msecnd.net/photogym/20140713120018_DSC04352.jpg	????擗?	CLOSE	0101000020E6100000CE8F1A6E9B145E408128561533503740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
396	頛?憭批飛????擗?	?啣?撣??銝剜迤頝?10??65000	65000050	25.03989206	121.4317989	02-29056436	https://az804957.vo.msecnd.net/photogym/20140620125314_DSC_0062.JPG	????擗?	CLOSE	0101000020E6100000B97CDA97A25B5E40F011B55D360A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
397	?勗?蝘?憭批飛樴陶擗??啣?撣楛???楛頝臭?畾?52??65000	65000180	25.00480587	121.6036427	02-86625850	https://az804957.vo.msecnd.net/photogym/20140714175648_IMG_1853-1.JPG	蝐???????FREE	0101000020E610000006BEFD14A2665E40947A1EF53A013940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
398	靘???蝐????箏?撣?敺瑕?銝剜散?葛憓???67000	67000270	22.91280399	120.2617604	06-2662108#020	https://az804957.vo.msecnd.net/photogym/20140714185731_SAM_3712.JPG	蝐???????擗?	FREE	0101000020E6100000D358B1AEC0105E4054B5B485ADE93640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
399	??撖阡?摮豢擃擗?[508]敶啣?蝮??蝢暽踹?頝臬畾?15??\N	\N	24.10519289	120.4914916	04-7552009#304	https://az804957.vo.msecnd.net/photogym/20140714221149_擃擗?.jpg	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E61000008F102F99741F5E405D52D6EBED1A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
400	憭芸??葉蝐????箏?撣??憭芸???40-21??67000	67000010	23.29195342	120.2713144	06-6524762	https://az804957.vo.msecnd.net/photogym/20140715101120_DSCN1658.jpg	蝐???憸券?	FREE	0101000020E6100000C4BB12375D115E40F8DA9675BD4A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
401	?控颲脣極?啣??湧?閮?摨抒??,2摨扳??	擃?撣?撅勗??頝臭?畾?95??64000	64000300	22.90146686	120.4819608	07-6612501#238	https://az804957.vo.msecnd.net/photogym/20140714091850_DSC05459.JPG	?啣???FREE	0101000020E61000000E7D1C72D81E5E40B8203A88C6E63640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
402	摰像??????擗?	?箏?撣?撟喳??∪像頝?92??67000	67000360	22.99473323	120.1757687	06-2996735#733	https://az804957.vo.msecnd.net/photogym/20140714114330_?冽.JPG	蝢賜???擗?	FREE	0101000020E6100000458A5CCB3F0B5E402E1843D6A6FE3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
403	?箇撣怎?憭批飛擃擗??箏?撣之摰??像?梯楝銝畾?62??63000	63000030	25.02614533	121.5273754	02-77343177	https://az804957.vo.msecnd.net/photogym/20140618152733_IMG_4028.jpg	蝐???????擗?	PAID	0101000020E6100000C1EDBF84C0615E400A4BD975B1063940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
404	?漯??蝐????箏?撣??蝢拙ㄚ頝臭?畾???67000	67000040	23.28604554	120.3655565	06-6231824	https://az804957.vo.msecnd.net/photogym/20140711142731_D:\\103撟游極蝔\103撟游漲蝬???港耨撌亦?\\?賢極??\DSCN1895(001).jpg	????擗?	FREE	0101000020E6100000C615174765175E407777CF473A493740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
405	?啁冗擃葉?????箔葉撣蝷曉?敺拍??葉??銝挾?葉撌?0??66000	66000190	24.23725028	120.8067048	04-25812116	https://az804957.vo.msecnd.net/photogym/20170323153428_ZCRJF8SK5EJJI2SVLK0S.JPG	????CLOSE	0101000020E6100000AE612B0DA1335E401D91316FBC3C3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
406	?粹?撣?瘞??葉敹??粹?撣?????頝?-1??10017	10017040	25.12471425	121.7378169	02-24301505#403	https://az804957.vo.msecnd.net/photogym/20161223101941_FJ2YQKYFGPIA4YLGX92H.jpg	璉????毀蝧,蝐???蝢賜???擗?,擃憭怎?蝺渡???????擗?,?撗拙,皜豢陶瘙?擗?,獢???擗?,?亥澈???恍???蝺游恕),???恕	PAID	0101000020E6100000E9FB5F64386F5E405D18E945ED1F3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
407	?箔葉鈭葉?啣????箔葉撣???勗ㄚ頝?09??66000	66000050	24.15316593	120.6760705	04-22021521	https://az804957.vo.msecnd.net/photogym/20140611104534_?啣???.JPG	蝐???????擗?,?啣???FREE	0101000020E610000095D233BD442B5E402036E4E135273840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
408	?交?ㄚ?冗????	94249撅蝮??仿?憯急??ㄚ?楝64-2??\N	\N	22.36829299	120.6639576	08-8781407#58	https://az804957.vo.msecnd.net/photogym/20140613145636_1403686334018.jpg	?蝐???????擗?	FREE	0101000020E6100000907B04487E2A5E4064650B73485E3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
409	擃擗??啁姘撣?摮詨?頝?28??10018	10018010	24.79614345	120.9854472	03-5722150	https://az804957.vo.msecnd.net/photogym/20140708164747_05-03-04.jpg	蝢賜???擗?,????擗?	FREE	0101000020E6100000D3FB2191113F5E40B3ACA00ED0CB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
410	摰園?憟喃葉?噬?(擗?	?箏?撣葉镼踹??亙熒頝臭?畾?42??67000	67000370	22.98176841	120.2004156	06-2133265#2230	https://az804957.vo.msecnd.net/photogym/20140612102530_IMG_4353.JPG	????擗?,蝢賜???擗?	CLOSE	0101000020E6100000EDE6F39BD30C5E402832AD2C55FB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
411	摰????	?儔蝮?皜舫?摰???6??10010	10010070	23.51405923	120.3132105	05-3772940#25	https://az804957.vo.msecnd.net/photogym/20140604104906_IMG_3227.JPG	蝬??,?啣???FREE	0101000020E6100000E2900DA40B145E40940EBD6299833740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
412	皜偌擃葉?啣????箔葉撣?瘞游?銝剖控頝?0??66000	66000120	24.26456184	120.5742109	04-26222116#341	https://az804957.vo.msecnd.net/photogym/20140603161911_R0015217.JPG	?啣???蝐???????擗?	FREE	0101000020E61000006E2013DFBF245E40D0912253BA433840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
413	銝剛??瘣餃?銝剖?	?梯蝮??桀???鈭?22??10015	10015010	23.99239361	121.6068238	03-8324308	https://az804957.vo.msecnd.net/photogym/20140611103341_銴ˊ -DSC01370.JPG	蝐???蝢賜???擗?,????擗?	PAID	0101000020E6100000CEDB7D33D6665E409AB5F3810DFE3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
414	憯賢控?葉?撗拙	擃?撣?撅勗?曌控鈭楝37撌?08??64000	64000020	22.63448211	120.2787152	07-5519150#32	https://az804957.vo.msecnd.net/photogym/20140624103801_DSCN4252.JPG	?撗拙,蝢賜???擗?,????擗?	PAID	0101000020E61000007A394778D6115E40DA58686B6DA23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
415	??擃葉????擗?	?梯蝮???銝剛頝?24??10015	10015030	23.34439682	121.320101	03-8886171#331	https://az804957.vo.msecnd.net/photogym/20140714205824_摰文?????JPG	????擗?	FREE	0101000020E6100000AE9AE7887C545E4014BFD6632A583740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
416	瘜啣控擃葉?啣????啣?撣陸撅勗?颲凋耨頝???65000	65000160	25.05775698	121.4298892	02-22963625	https://az804957.vo.msecnd.net/photogym/20170413091421_EZJOCKJLKOAYUBJ1EX19.JPG	瘜啣控擃葉?啣???摰文?蝐???????擗?	FREE	0101000020E6100000D5B9FD4D835B5E403A375429C90E3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
417	?啣?撣偶??銝剜迤璈椰?湔??(?啣?皞芸椰撗貉銵???.0KM)	?啣?撣偶??銝剜迤璈椰?湔??(?啣?皞芸椰撗貉銵???.0KM)	65000	65000040	25.01944821	121.5123081	02-89699596#521	https://az804957.vo.msecnd.net/photogym/20141227090021_29.jpg	????擗?	FREE	0101000020E610000075BEE9A7C9605E406EEAD18EFA043940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
418	?啣?撣?瘣脣?敺桅◢?眾?喳?????啣?撣?瘣脣?敺桅◢?眾?喳頞喟???65000	65000140	25.08847505	121.4549625	02-89699596#508	https://az804957.vo.msecnd.net/photogym/20140730120359_41.jpg	????擗?	FREE	0101000020E6100000029A081B1E5D5E401043064DA6163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
419	?啣?撣偶??蝬窄?喳???(?啣?皞芸椰撗貉銵???.5KM)	?啣?撣偶??蝬窄?喳???(?啣?皞芸椰撗貉銵???.5KM)	65000	65000040	25.01798989	121.5090251	02-89699596#521	https://az804957.vo.msecnd.net/photogym/20141226111755_19.jpg	????擗?	FREE	0101000020E6100000F65503DE93605E40693545FC9A043940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
420	?啣?撣摨??賢?????瘝??????啣?皞芸椰撗貉銵???2.8KM)	?啣?撣摨??賢?????瘝??????啣?皞芸椰撗貉銵???2.8KM)	65000	\N	24.97601196	121.5207624	02-89699596#521	https://az804957.vo.msecnd.net/photogym/20141227092116_39.jpg	瘝?????FREE	0101000020E6100000223FD12B54615E4072B478EBDBF93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
421	??擃葉蝬??	?脫?蝮???銝剖控頝?12??10009	10009020	23.68247506	120.4759991	05-5972059	https://az804957.vo.msecnd.net/photogym/20140604140948_蝐???02.jpg	????擗?,蝐???蝐???CLOSE	0101000020E61000003ADBEDC4761E5E4020097FAFB6AE3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
422	?????箏?撣??銝剖控?梯楝鈭挾1330??67000	67000040	23.27936376	120.3254038	06-6223208#27	https://az804957.vo.msecnd.net/photogym/20180403121046_O0BUU9OQ62SD78S9HNJE.JPG	????擗?	CLOSE	0101000020E6100000A0BF756AD3145E4039E3246284473740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
423	?飯?葉?啣???獢?撣葉憯Ｗ??暹頝???68000	68000020	24.96053282	121.1739475	03-4200026#314	https://az804957.vo.msecnd.net/photogym/20140618084041_?游??JPG	?啣???蝐???????擗?	FREE	0101000020E610000024EEB1F4214B5E4079A2987AE5F53840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
424	?啣???獢?撣?璇?擃?頝???68000	68000040	24.9215467	121.1489439	03-4789618	https://az804957.vo.msecnd.net/photogym/20140617111807_YRLBCM3Z7XDK581VW0HW.jpg	蝐???頞喟???????擗?	FREE	0101000020E610000014DCFE4B88495E409A3C0A7CEAEB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
425	蝬??葉?啣???獢?撣???蝬?頝?76??68000	68000010	25.02244258	121.3041258	03-3572699#314	https://az804957.vo.msecnd.net/photogym/20140606155730_123.jpg	?????啣???FREE	0101000020E6100000AB370FCC76535E404B2303CCBE053940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
426	????????撅蝮???????葉撅梯楝68??10013	10013190	22.43304872	120.5191514	08-8752120#14	https://az804957.vo.msecnd.net/photogym/20180418120513_76I76CCAOJWRH3DHUYIA.jpg	????擗?	CLOSE	0101000020E61000000C2BCBC639215E4083F9E947DC6E3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
427	曌控擃葉瘣餃?銝剖?	擃?撣?撅勗??噸頝???64000	64000020	22.65270651	120.2756174	07-5213258	https://az804957.vo.msecnd.net/photogym/20180312144534_GADQBQMED7QBA4DBV1U6.JPG	蝢賜???擗?,????擗?	CLOSE	0101000020E610000059CD29B7A3115E4018561AC617A73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
428	?啣?擃極?啣????箏?撣???望旨?縑蝢抵楝54??67000	67000180	23.03821171	120.3186634	06-5903994#2025	https://az804957.vo.msecnd.net/photogym/20170411120525_ORVRPH9TIJKFO5DTBRCZ.jpg	?啣???蝐???蝬脩???擗?,????擗?	FREE	0101000020E6100000A95B2CFB64145E4034C61C3EC8093740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
429	摰像?葉?????箏?撣?撟喳??嗅像頝?87??67000	67000360	22.99741462	120.1681137	06-2990461#802	https://az804957.vo.msecnd.net/photogym/20170928155756_WVT1JX4HZ4KJ05UODNOH.jpg	????擗?	CLOSE	0101000020E61000009DE0F65FC20A5E40C873859056FF3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
430	瞏剔??葉擃擗??箔葉撣蔬摮??蔬頝臭?畾?75??66000	66000170	24.21557881	120.6996632	04-25343542#215	https://az804957.vo.msecnd.net/photogym/20140725160815_P1130711.JPG	????擗?	CLOSE	0101000020E6100000BE8D2848C72C5E401DA9422C30373840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
431	???葉蝬??	??蝮????????楝200??10008	10008050	23.83188765	120.7842989	049-2762013	https://az804957.vo.msecnd.net/photogym/20170418104115_HH2ZVFN1GKHXZWBRKHMF.jpg	????擗?,蝐???蝬脩???擗?	PAID	0101000020E61000007B7203F431325E4040B2CA96F6D43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
432	撱嗅像??瘣餃?銝剖?	??蝮?姘撅梢?控頝臭?畾?161??10008	10008040	23.76793097	120.7071787	04-92642450	https://az804957.vo.msecnd.net/photogym/20140604154055_P1080096.JPG	????CLOSE	0101000020E6100000613B736A422D5E404DBCC11F97C43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
433	蝐????梯蝮?陶??瑟?頝???10015	10015020	23.7075665	121.4178193	03-8751264	https://az804957.vo.msecnd.net/photogym/20140821091759_K8APCD8K2VH9XBU3Y4JA.jpg	蝐???????擗?	FREE	0101000020E6100000CF48298DBD5A5E40C43E011423B53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
434	憯賢控?葉????擃?撣?撅勗?曌控鈭楝37撌?08??64000	64000020	22.63329254	120.2784759	07-5519150	https://az804957.vo.msecnd.net/photogym/20180425194752_WS0L90J7RKBIIU81F9HV.JPG	????擗?	FREE	0101000020E610000059CE948CD2115E40CC19BC751FA23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
435	曈單??葉瘣餃?銝剖?	擃?撣?皜臬?樴陶頝?59??64000	64000110	22.52167501	120.3485298	07-8711130	https://az804957.vo.msecnd.net/photogym/20140630131814_IMG_1129.JPG	蝐???蝢賜???擗?,????擗?,頞喟???皜豢陶瘙?擗?	FREE	0101000020E61000009C2BEF4F4E165E402917537E8C853640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
436	銝剜迤擃葉????擗?	?箏?撣??????楝77??63000	63000120	25.10397692	121.5149447	02-28234811#330	https://az804957.vo.msecnd.net/photogym/20140616182820_CIMG9202.JPG	????擗?	PAID	0101000020E6100000E86F9DDAF4605E4056F03E3B9E1A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
437	?啗?擃葉?啣??氬??銝剜??	擃?撣椰????頝?9??64000	64000030	22.6804702	120.3162575	07-3420103	https://az804957.vo.msecnd.net/photogym/20140707105348_IMG_20140705_090715.jpg	?啣???FREE	0101000020E610000058E718903D145E400FE7864B33AE3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
438	撅蝮???圈???憭??賜????脤尹	撅蝮???圈????唳?銝剜迤頝臭?畾?00??10013	10013260	22.71251666	120.6558967	08-7991104#702	https://az804957.vo.msecnd.net/photogym/20140820145239_擃擗?jpg	蝐???蝢賜???擗?,????擗?	FREE	0101000020E61000007A032736FA295E401E8EE87D67B63640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
439	摰?擃葉摰文??	?粹?撣?璅?摰?頝?60??10017	10017060	25.13505324	121.7305475	02-24236600#31	https://az804957.vo.msecnd.net/photogym/20140618091815_P6181932.JPG	蝐???????擗?	CLOSE	0101000020E61000002C2B4D4AC16E5E40D30461D992223940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
440	曈喳控?葉璅黎??擃?撣陶撅勗?銝剖控?梯楝227??64000	64000120	22.62504345	120.3721654	07-7462774#213	https://az804957.vo.msecnd.net/photogym/20140704100031_DSC_0369.JPG	????擗?,蝢賜???擗?	CLOSE	0101000020E6100000FA6CD38ED1175E403A54F8D802A03640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
441	獢???頨脤?	擃?撣?皜臬?獢????質楝390??64000	64000110	22.58265136	120.3504986	07-7910766#723	https://az804957.vo.msecnd.net/photogym/20140613100729_IMG_0843.JPG	頨脤?,頞喟???????擗?	CLOSE	0101000020E6100000CD12AE916E165E40802BB8A328953640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
442	撖嗡???蝐???擃?撣樴?撖嗡??葉甇?楝89??64000	64000320	23.10817439	120.7014602	07-6881009	https://az804957.vo.msecnd.net/photogym/20140618160629_P1020986(1).jpg	????擗?,蝐???FREE	0101000020E6100000859C52B9E42C5E4093501B51B11B3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
443	?噸摰嗅?蝐??	??蝮??撅舫銝剜迤頝臬?勗毽8??10008	10008030	23.99804463	120.6958394	04-92553109	https://az804957.vo.msecnd.net/photogym/20200331110411_PYIA8QHMPTEM2IGDE3BR.jpg	蝐??	CLOSE	0101000020E61000002B91FAA1882C5E4065CC55DA7FFF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
444	?予??蝬??	?箔葉撣之?脣?蝬?頝?68??66000	66000110	24.34487286	120.617954	04-26872040#821	https://az804957.vo.msecnd.net/photogym/20200401161217_5J933PNRZRL87P5PPR8V.jpg	????擗?	CLOSE	0101000020E6100000AC1BEF8E8C275E405DFA769649583840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
445	??颲脣極	?箏?撣蔔???剖???17??67000	67000120	23.17600476	120.1808703	06-7260148#222	https://az804957.vo.msecnd.net/photogym/20140703111618_O4AXXXKROQSDJPHH6PAO.jpg	蝐????啣???????蝬脩???CLOSE	0101000020E610000055D40561930B5E40ED23E0A50E2D3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
446	?啁姘擃葉?????啁姘撣?摮詨?頝?6??10018	10018010	24.79367441	120.980793	03-5736666#206	https://az804957.vo.msecnd.net/photogym/20140911144824_???游?啁??.jpg	????擗?	FREE	0101000020E610000054C90050C53E5E40429F023F2ECB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
447	?踹之?葉擃擗??箏?撣?撅勗??踹之銝銵?53??63000	63000080	24.98787653	121.584819	02-82377500#9441	https://az804957.vo.msecnd.net/photogym/20140529142512_D:\\My Documents\\蝮賢??\蝛粹??蔭?\1030616擃擗函?\DSCN0477.jpg	蝐???????擗?,蝢賜???擗?	PAID	0101000020E610000015C5ABAC6D655E4002D6EC79E5FC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
448	?儔憟喃葉????擗?	?儔撣正???頝?43??10020	10020020	23.47292999	120.4509312	05-2254603#1361	https://az804957.vo.msecnd.net/photogym/20140611155350_??1.jpg	????擗?	CLOSE	0101000020E6100000BF2F890EDC1C5E40FD5898F011793740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
449	???葉??????蝮????憭批?頝?4??10008	10008010	23.89582385	120.6830174	049-2222460#252	https://az804957.vo.msecnd.net/photogym/20140610151204_?-1.JPG	?啣???蝐???瘝?????PAID	0101000020E610000055E69C8EB62B5E4010BA3AB654E53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
450	?啗?擃葉????擗?	擃?撣??鈭?鈭楝218??64000	64000060	22.62363719	120.2993703	07-2727127#2050	https://az804957.vo.msecnd.net/photogym/20140529122351_DSC03855.JPG	????擗?	PAID	0101000020E610000033F90BE228135E408D9ED7AFA69F3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
451	敺????啣???擃?撣之撖桀?敺????楝28??64000	64000140	22.63755553	120.3890526	07-7035278	https://az804957.vo.msecnd.net/photogym/20140612103007_P1050773.JPG	?啣???蝐???????擗?	FREE	0101000020E61000001F5BE03CE6185E40E4BBD6D636A33640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
452	瘝單??蝐????箏?撣瘝喳?瘝單??3銋???67000	67000030	23.34462167	120.4370803	06-6852527	https://az804957.vo.msecnd.net/photogym/20140715120400_DSC02603.jpg	蝐???????擗?	FREE	0101000020E6100000758EA61FF91B5E409524322039583740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
453	???葉蝐????箏?撣???楝頝?畾???67000	67000340	23.00918153	120.2166563	06-2517906#130	https://az804957.vo.msecnd.net/photogym/20140709154403_DSC05961.JPG	蝐???????擗?	FREE	0101000020E61000003BBE62B2DD0D5E40C61383B859023740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
454	???葉憸券?	?箏?撣???楝頝?畾???67000	67000340	23.00926053	120.216651	06-2517906#130	https://az804957.vo.msecnd.net/photogym/20140709153647_DSC05953.JPG	憸券?,?蝐???蝢賜???擗?,????擗?	FREE	0101000020E610000053E9279CDD0D5E405E7EE9E55E023740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
455	?像??敶拍蕉擗??儔撣正?敺瑕?頝?0??10020	10020020	23.48434531	120.4316998	05-2333746#705	https://az804957.vo.msecnd.net/photogym/20140605104559_????jpg	蝢賜???擗?,????擗?	CLOSE	0101000020E610000025AC32F8A01B5E40C56BE20DFE7B3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
456	樴控??????擃?撣?瞈?樴控??撅梯?62??64000	64000310	22.86429169	120.5566089	07-6833654#30	https://az804957.vo.msecnd.net/photogym/20140612132353_DSC08699.JPG	????擗?	FREE	0101000020E6100000678AEF7A9F235E402CC15E3842DD3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
457	曋箸??葉?啣????啣?撣?瘣脣??瑟?頝?35??65000	65000140	25.09061269	121.4617968	02-82862517	https://az804957.vo.msecnd.net/photogym/20140619104245_IMAG0170[1].jpg	?啣???蝐???????擗?	FREE	0101000020E610000070592A148E5D5E401027AC6432173940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
458	?砍??葉蝐???敶啣?蝮???敶啣?頝臬?畾?7撌?0??10007	10007090	24.01213304	120.626058	049-2522001#304	https://az804957.vo.msecnd.net/photogym/20140707095203_??1.jpg	蝐???????擗?	FREE	0101000020E61000008CD9925511285E404500A2261B033840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
459	鈭?蝐???擃?撣?瘞?憭扳?銝頝?00??64000	64000050	22.65602697	120.3243041	07-3813210	https://az804957.vo.msecnd.net/photogym/20170414153337_PXU3B5T162O5K2GDC7PA.jpg	蝐???CLOSE	0101000020E61000005CDDFB65C1145E40A8712D62F1A73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
460	?文??葉????擗?	?脫?蝮???????質楝2??10009	10009070	23.64666181	120.567264	05-5821004#204	https://az804957.vo.msecnd.net/photogym/20140630155527_DSC08715.JPG	????擗?	FREE	0101000020E6100000AE0CAA0D4E245E40AD85DDA08BA53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
461	???葉?	獢?撣???瘞?頝?29??68000	68000010	25.00969657	121.3076448	03-3552776#315	https://az804957.vo.msecnd.net/photogym/20140606155405_?芸??JPG	蝐???????擗?,?啣???FREE	0101000020E610000035B2D073B0535E408B0873797B023940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
462	?儔?極?????梯蝮??敺拚??ㄝ頝?00??10015	10015070	23.66789476	121.4290309	03-8700245#207	https://az804957.vo.msecnd.net/photogym/20140719213410_????.JPG	????FREE	0101000020E61000004D1E053E755B5E40A95EA726FBAA3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
463	雿唾??葉蝐????箏?撣蔔??瘞??摰?4銋???67000	67000120	23.18239765	120.1956439	06-7260291#13	https://az804957.vo.msecnd.net/photogym/20150922143445_1XG7GR31BNI6CXSWDIKV.JPG	蝐???????擗?	FREE	0101000020E61000005C0AFE6D850C5E40049EC59CB12E3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
464	蝬??	?脫?蝮????????????10009	10009120	23.7918046	120.3302586	05-6552384	https://az804957.vo.msecnd.net/photogym/20170418101039_X6ZZLT2NUQB2VGIM1QNQ.JPG	????擗?	FREE	0101000020E6100000418EF7F422155E4086D2CDB4B3CA3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
465	?扳?擃葉?????箏?撣皝?蝝恍??敺瑁楝218??63000	63000100	25.07784947	121.5870881	02-27977035#206	https://az804957.vo.msecnd.net/photogym/20140606094902_84ZZJC693TMUINB0MA23.jpg	????FREE	0101000020E6100000BB57F7D992655E4033A95FF1ED133940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
466	銝剖?????????蝮?姘撅梢?控頝臭?畾?55??10008	10008040	23.81201864	120.7381895	049-2622030#112	https://az804957.vo.msecnd.net/photogym/20180430104130_AO3VW7QUAIGPJSY8QX4B.JPG	銝剖???????擗?	FREE	0101000020E61000000A302C7F3E2F5E40DB8A1E74E0CF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
467	瘣餃?銝剖?摰文?????脫?蝮???琿???頝?6??10009	10009170	23.64509914	120.3169227	05-7882012	https://az804957.vo.msecnd.net/photogym/20180508093227_9FKVRXGYSFK5EZ5O4KH8.jpg	????擗?	CLOSE	0101000020E61000000BF7257648145E404CFA9C3725A53740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
468	皞???箏?撣??镼輸?頝臭?畾?23??67000	67000340	23.0054264	120.2053696	06-2223014#19	https://az804957.vo.msecnd.net/photogym/20170928111641_O3ZQ08BFRTQ934VJVWRC.JPG	????擗?	CLOSE	0101000020E6100000EDE588C6240D5E40F788E29F63013740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
469	????撅蝮?銝寥??雁?銝寡楝2畾???10013	10013050	22.59689081	120.4884519	08-7772020	https://az804957.vo.msecnd.net/photogym/20170706113745_F831J8V6AG6VTBYKLZD7.JPG	????擗?	CLOSE	0101000020E6100000D20AC2CB421F5E40A33B0CD6CD983640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
470	摮貊?葉憸券?	?箏?撣飛?脣??臬?頝?40??67000	67000130	23.23681969	120.1851404	06-7832128	https://az804957.vo.msecnd.net/photogym/20180514084746_OZJOVAMHUR7T26Z7NRNK.jpg	????擗?	CLOSE	0101000020E6100000C6CA1E57D90B5E404F991737A03C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
471	鞊膨?葉擃擗??梯蝮??瞈梢?鞊膨??鞊楝26??10015	10015080	23.60064392	121.5216637	03-8791159#117	https://az804957.vo.msecnd.net/photogym/20140702142749_1030627蝬?擃擗? .jpg	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E6100000AAC024F062615E40F5F0C8CCC3993740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
472	擃?撣??望??葉????擃?撣????望?頝?47??64000	6400800	22.61512903	120.3239447	07-7150949#526	https://az804957.vo.msecnd.net/photogym/20170623164709_TEV38BC3Y0B5N2JQBQ2Q.JPG	????擗?	CLOSE	0101000020E61000009A0D8D82BB145E4092AB9A18799D3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
473	蝳??葉蝐????啣?撣偶??瘞詨頝?1??65000	65000040	25.00453028	121.5222098	02-29289493#229	https://az804957.vo.msecnd.net/photogym/20170929150941_8VV5DQ6J7866LTRVLZZE.JPG	蝐???????擗?	FREE	0101000020E6100000A529A7E26B615E4015717CE528013940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
474	??擃極?啣?????蝮???銝剖控頝臭?畾?35??10008	10008020	23.97297709	120.9793326	04-92982225#407	https://az804957.vo.msecnd.net/photogym/20200421081816_TR9AP89A7BZ3FUO4K60K.jpg	?啣???????擗?	FREE	0101000020E6100000073AA462AD3E5E40A84ECD0615F93740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
475	?葛颲脣極?????脫?蝮??皜舫憭芸像頝?0??10009	10009060	23.57952425	120.3072238	05-7832246#533	https://az804957.vo.msecnd.net/photogym/20140606112343_????jpg	????FREE	0101000020E61000006263038EA9135E402AFD84B35B943740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
476	?葛颲脣極瘣餃?銝剖?	?脫?蝮??皜舫憭芸像頝?0??10009	10009060	23.57881381	120.3076234	05-7832246#533	https://az804957.vo.msecnd.net/photogym/20140603141343_100_5300.JPG	蝢賜???????CLOSE	0101000020E6100000FF9E0E1AB0135E40546C50242D943740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
477	敶啣??葉镼輸??	敶啣?蝮?蔑??銝剜迤頝臭?畾?30??10007	10007010	24.07064009	120.5346885	04-7236117#231	https://az804957.vo.msecnd.net/photogym/20140707101252_48QLBRY1HVPWRRTIQ8NG.JPG	頝?,蝐???????擗?	FREE	0101000020E610000007431D5638225E4025560C7815123840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
478	?黎?葉?啣???敶啣?蝮??蝢????撖株楝銝畾?90??10007	10007030	24.1126992	120.5195689	04-7350071#134	https://az804957.vo.msecnd.net/photogym/20140707095230_P1140907.JPG	蝐???????擗?,?啣???FREE	0101000020E61000003261EA9D40215E400E49D2DAD91C3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
479	銝剜迤?葉?脰??撅蝮???勗?瘞飛頝???10013	10013010	22.67235264	120.509119	08-7226387#41	https://az804957.vo.msecnd.net/photogym/20140618094121_h6.jpg	瘣餃?銝剖?	FREE	0101000020E61000006CB1DB6795205E40E42D784D1FAC3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
480	皞芷?葉憸券?	敶啣?蝮?漯撌??????楝1??10007	10007260	23.82386811	120.5431187	04-8802151#31	https://az804957.vo.msecnd.net/photogym/20140707102105_CIMG0423.JPG	憸券?	FREE	0101000020E61000002596EF74C2225E40D6AA3C05E9D23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
481	?像銝剖飛瘣餃?銝剖?	?梯蝮?陶??怠噸頝?2??10015	10015020	23.78404888	121.4571673	03-8772586#131	https://az804957.vo.msecnd.net/photogym/20140610142058_DSC07902.JPG	蝢賜???蝐???擗?,????擗?	CLOSE	0101000020E61000003D93A23A425D5E40C0106A6DB7C83740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
482	隞??葉擃瘣餃?銝剖?	獢?撣?璇?擃旨??1?唳擃控??-8??68000	68000040	24.92515093	121.1842569	03-4641123#316	https://az804957.vo.msecnd.net/photogym/20200422135103_EI2RVZZUJH47CWSGKNUQ.jpg	蝐???蝢賜???????CLOSE	0101000020E6100000FDE373DDCA4B5E40C836FCB0D6EC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
483	?賣?擃葉-?啣???獢?蝮????敺瑕ˊ銵???\N	\N	24.98033975	121.3032246	03-3672706#102	https://az804957.vo.msecnd.net/photogym/20190625164917_UF032O0DBM2B127BSJN4.jpg	????頝喲????,頝?,?蝐???FREE	0101000020E6100000EE15270868535E400438BD8BF7FA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
484	?踵??葉瘝??????啣?撣璈?銝剜迤頝?37??65000	65000010	25.02614547	121.4527898	02-29666498#650	https://az804957.vo.msecnd.net/photogym/20200422150833_CNR1RTU32GXYTAHA3SLO.jpg	瘝?????CLOSE	0101000020E610000098BD1182FA5C5E40AB963278B1063940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
485	?踵??葉擃擗??啣?撣璈?銝剜迤頝?37??65000	65000010	25.02552187	121.4528362	02-29666498#650	https://az804957.vo.msecnd.net/photogym/20140618130905_IMG_7004.JPG	????擗?,蝐???CLOSE	0101000020E6100000795CAF44FB5C5E4096FBEC9988063940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
486	?葛擃葉敹??暑?葉敹??脫?蝮??皜舫??頝?6??10009	10009060	23.57865894	120.3051209	05-7821411#307	https://az804957.vo.msecnd.net/photogym/20140623093450_038-1.JPG	蝢賜???擗?,????擗?	CLOSE	0101000020E6100000DFB4CF1987135E4089D606FE22943740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
487	?旨?葉????撅蝮?????祚?撖株楝1銋?5??10013	10013180	22.51337463	120.5182922	08-8631112#13	https://az804957.vo.msecnd.net/photogym/20200423122223_ZIO6PUTB8EIPB92DIVD2.jpg	????擗?	CLOSE	0101000020E610000067310CB32B215E4034720E856C833640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
488	?啗?擃葉蝐????????啣???擃?撣??鈭?鈭楝218??64000	64000060	23.22778053	120.6539154	07-2727127#2050	https://az804957.vo.msecnd.net/photogym/20140529111933_DSC03848.JPG	蝐???PAID	0101000020E61000007356FABFD9295E40FB0327D34F3A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
489	隞???????撅蝮????隞??葉撅梯楝417??10013	10013190	22.43756298	120.5115652	08-8752201#12	https://az804957.vo.msecnd.net/photogym/20140609144803_IMG_20140610_131316.jpg	????擗?	FREE	0101000020E610000064F1F67BBD205E40510AA12004703640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
490	?陸?葉蝐?????蝮?嘀靚琿?隞?頝?54銋???10008	10008070	23.78296893	120.775044	049-2671712#13	https://az804957.vo.msecnd.net/photogym/20140612110825_DSC07349.JPG	????擗?	FREE	0101000020E6100000813D26529A315E405522DCA670C83740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
491	甇?噸擃葉蝐???敶啣?蝮?蔑???踵??蔑瘞渲楝145??10007	10007010	24.05810563	120.5188134	(04)7524109#112	https://az804957.vo.msecnd.net/photogym/20140612130507_蝐??游.jpg	蝐???????擗?	CLOSE	0101000020E6100000806E1E3D34215E404090B402E00E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
492	蝳控?葉蝐???擃?撣椰???縑頝?15??64000	64000030	22.6798317	120.3142512	07-3501581#29	https://az804957.vo.msecnd.net/photogym/20140612132542_IMG_8329.JPG	蝐???????擗?	FREE	0101000020E6100000A4AE10B11C145E40BA48467309AE3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
493	??憭批飛????擗?	?啣?撣楚瘞游???銵?2??65000	65000100	25.17847362	121.435377	02-26212121#1714	https://az804957.vo.msecnd.net/photogym/20140612133748_DSC03366.JPG	????擗?	PAID	0101000020E61000008F1B7E37DD5B5E4046197972B02D3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
494	?啗????啣????啣?撣楚瘞游??啗?銵?23??65000	65000100	25.18004412	121.4394647	02-26203646#823	https://az804957.vo.msecnd.net/photogym/20140612111717_?01.jpg	?啣???????擗?	FREE	0101000020E6100000C68F8C30205C5E40B33C175F172E3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
495	??擃葉????擗?	?箏?撣???摰葉頝臭?畾?65??67000	67000350	23.05640175	120.1506472	06-2577014#305	https://az804957.vo.msecnd.net/photogym/20140612153351_G:\\DCIM\\101MSDCF\\DSC03208.JPG	????擗?	CLOSE	0101000020E6100000F94E2734A4095E40EAAF5758700E3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
496	?游??葉瘣餃?銝剖?	?儔蝮?摮?蝡孵??之?楝245??10010	10010020	23.43797262	120.2322451	05-3792201#204	https://az804957.vo.msecnd.net/photogym/20140612153819_DSC_5622.JPG	??擗?CLOSE	0101000020E6100000004A8D1ADD0E5E4085713FF91E703740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
497	???葉????擗?	??蝮??憪??喲???憪楝237??10008	10008100	24.04240767	120.8587718	049-2721144#400	https://az804957.vo.msecnd.net/photogym/20140612164024_????IMG_9612.jpg	???葉????FREE	0101000020E610000088EEFE1DF6365E40E3BFA33ADB0A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
498	?控?葉?????儔撣正???頝???10020	10020020	23.46912171	120.425123	05-2357980#212	https://az804957.vo.msecnd.net/photogym/20140606104937_20140606_IMG_0001.JPG	????FREE	0101000020E6100000C1711937351B5E40294B425C18783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
499	憭扳蔬??憸券?	撅蝮?皜舫憭扳蔬?之瞏剛楝93??10013	10013030	22.45784139	120.4957101	08-8324226	https://az804957.vo.msecnd.net/photogym/20140610211034_?芸??- 1.jpg	蝐???????擗?	CLOSE	0101000020E610000000F3DAB6B91F5E4020CEE41735753640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
500	憭扳蔬??蝬??	撅蝮?皜舫憭扳蔬?之瞏剛楝93??10013	10013030	22.45728499	120.4955857	08-8324226	https://az804957.vo.msecnd.net/photogym/20140610203413_DSC_8581.jpg	頨脤?,蝐???????FREE	0101000020E6100000617715ADB71F5E406F000DA110753640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
501	瘚瑕控擃葉????擗?	?啣?撣璈?瞍Ｙ??梯楝215??65000	65000010	25.01100429	121.4717317	02-29517475#223	https://az804957.vo.msecnd.net/photogym/20140613100426_????.JPG	????擗?,?蝐???CLOSE	0101000020E610000023FF27DA305E5E406BAA592DD1023940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
502	????獢?撣之??瘝????唳絲皜航楝2撌?7??68000	68000060	25.10975258	121.2388945	03-3835026#410	https://az804957.vo.msecnd.net/photogym/20140613095810_頨脤?2.JPG	頨脤?	PAID	0101000020E61000006F2C280C4A4F5E406AC0BDBE181C3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
503	?望葛擃?瘚瑚?瘞渡?瑟平摮豢????擗?	撅蝮?皜舫鞊?銵?6??10013	10013030	22.4657661	120.4412645	08-8333131#233	https://az804957.vo.msecnd.net/photogym/20140613103545_W4ZDKCZ9CJ12PHF5Z5NI.JPG	????擗?	CLOSE	0101000020E6100000B11875AD3D1C5E40E11577723C773640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
504	鞊?擃葉????擗?	?箔葉撣???瘞湔?頝?50??66000	66000090	24.25812172	120.7420484	04-25290381#1241	https://az804957.vo.msecnd.net/photogym/20140613104733_5_20140612_085015.jpg	????擗?	FREE	0101000020E6100000258392B87D2F5E408AC9D94314423840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
505	蝡孵控擃葉????擗?	??蝮?姘撅梢銝帖銵?53??10008	10008040	23.76003267	120.6799865	049-2643344#126	https://az804957.vo.msecnd.net/photogym/20140613112332_IMG_8994.jpg	????擗?	FREE	0101000020E61000002DCE18E6842B5E40A48A458091C23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
506	撅?平?銵飛?Ｘ??(擗?	撅蝮???勗?瘞??梯楝51??10013	10013010	22.65827446	120.5114579	(08)7238700	https://az804957.vo.msecnd.net/photogym/20140613112740_IMG_0228.jpg	????擗?	FREE	0101000020E6100000F971EAB9BB205E40F87DCDAC84A83640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
507	?啁????????脫?蝮???琿??行???楝11??10009	10009170	23.63845762	120.35891	05-7983093	https://az804957.vo.msecnd.net/photogym/20140613102219_C:\\Users\\USer\\Desktop\\???廄\2014-06-13 08.38.07.jpg	????擗?	FREE	0101000020E6100000450DA661F8165E4031C865F571A33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
508	擃?瘚瑟?蝘?憭批飛????擃?撣?璇?瘚瑕?頝?42??64000	64000040	22.72601861	120.3174806	07-3617141#2901	https://az804957.vo.msecnd.net/photogym/20140613153941_IMG_20140613_132203.jpg	????FREE	0101000020E61000005387269A51145E40C53C0A5BDCB93640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
509	?粹??極?啣????粹?撣??萄??望銵?2??10017	10017020	25.09418049	121.7177688	02-24567126#231	https://az804957.vo.msecnd.net/photogym/20140613150111_P1020260.JPG	?啣???蝐???????CLOSE	0101000020E6100000B5858CECEF6D5E40A4786C361C183940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
510	蝳控?葉瘣餃?銝剖?	擃?撣椰???縑頝?15??64000	64000030	22.68059888	120.3146482	07-3501581#29	https://az804957.vo.msecnd.net/photogym/20140612135509_DSC00585.JPG	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E6100000B22F343223145E40534B6BBA3BAE3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
511	?粹??極擃擗??粹?撣??萄??望銵?2??10017	10017020	25.09423393	121.718493	02-24567126#231	https://az804957.vo.msecnd.net/photogym/20140605152322_P1020274.JPG	????擗?	CLOSE	0101000020E6100000EA5910CAFB6D5E400886FFB61F183940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
512	擃?瘚瑟?蝘?憭批飛擃擗?擃?撣?璇?瘚瑕?頝?42??64000	64000040	22.72729213	120.316802	07-3617141#2901	https://az804957.vo.msecnd.net/photogym/20140612153807_IMG_20140613_133453.jpg	?亥澈???恍???蝺游恕),皜豢陶瘙?擗?,蝢賜???????獢???蝐???????PAID	0101000020E6100000AC53E57B46145E40F9FC28D12FBA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
513	撅蝮??????撅蝮???勗??頝???10013	10013010	22.67683272	120.4929119	08-7362589#223	https://az804957.vo.msecnd.net/photogym/20140612164829_????jpg	蝮??????FREE	0101000020E6100000CA935ADE8B1F5E404243BDE844AD3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
514	?啁姘擃極????擗?	?啁姘撣?銝剛頝臭?畾???10018	10018010	24.8101388	120.9836107	03-5318646	https://az804957.vo.msecnd.net/photogym/20140613170219_DSC_1797.JPG	????擗?	FREE	0101000020E6100000B91F4B7AF33E5E407F38A34165CF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
515	撘?蝘?憭批飛擃擗?????	?箔葉撣?暽踹??箇憭折??剜挾1018??66000	66000130	24.21753086	120.58097	04-26318652#7009	https://az804957.vo.msecnd.net/photogym/20140614132806_????JPG	????擗?	PAID	0101000020E6100000417DCB9C2E255E401D92391AB0373840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
516	?扈?極????擗?	??蝮??撅舫憓拍?頝?畾?88??10008	10008030	23.99671126	120.6653631	049-2362082	https://az804957.vo.msecnd.net/photogym/20140615135151_IMG_20140613_114909.jpg	????擗?	CLOSE	0101000020E6100000C59D1C4F952A5E404541197828FF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
517	?喟?擃葉?啣????啣?撣蝣?????祚45??65000	65000190	25.01322592	121.6428566	02-26631224#203	https://az804957.vo.msecnd.net/photogym/20140616083819_P6160015.JPG	?啣???蝐???????擗?	FREE	0101000020E61000002341029024695E4009DC1DC662033940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
518	?喟?擃葉蝐????啣?撣蝣?????祚45??65000	65000190	25.01307035	121.6427708	02-26631224#203	https://az804957.vo.msecnd.net/photogym/20140616091452_P6160017.JPG	蝐???蝢賜???擗?,????擗?	FREE	0101000020E6100000B834232823695E401ACC159458033940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
519	??憭批飛擃擗??箏?撣獄鞊?????Ｗ祚70-11??67000	67000070	23.2181576	120.2267146	06-5703100#7761	https://az804957.vo.msecnd.net/photogym/20140616091617_撘萄??擃擗其?憭?JPG	?飢銝剖?,擃?賭葉敹?????擗?,蝐????啣???PAID	0101000020E6100000A521F47D820E5E40B55F2D2DD9373740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
520	?勗憭批飛擃擗??箏?撣ㄚ???冽漯頝?0??63000	63000110	25.09415671	121.5463655	(02)28819471#5606	https://az804957.vo.msecnd.net/photogym/20140616095059_?漯擃擗?2.jpg	蝐???蝢賜???擗?,????擗?	PAID	0101000020E6100000698A00A7F7625E40222676A71A183940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
521	銝魚??瘣餃?銝剖?	?啣?撣?撜賢?銝剖控頝?6??65000	65000090	24.93493422	121.3687845	02-26711018#824	https://az804957.vo.msecnd.net/photogym/20140612141232_IMAG1636.jpg	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E610000064B14D2A9A575E40AFCF5AD957EF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
522	?勗憭批飛????擗?	?箏?撣ㄚ???冽漯頝?0??63000	63000110	25.0954368	121.5452778	(02)28819471#5606	https://az804957.vo.msecnd.net/photogym/20140616105753_?漯????2.jpg	????擗?	PAID	0101000020E6100000078FDBD4E5625E40BCD5CE8B6E183940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
523	銝??葉瘣餃?銝剖?	?啣?撣???瘛⊿?頝臭?畾?8??65000	65000210	25.25915431	121.5017509	933490310	https://az804957.vo.msecnd.net/photogym/20140616085423_IMGP0370.jpg	蝐???????擗?	FREE	0101000020E6100000458FCEAF1C605E404411D6EF57423940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
524	????撠飛憸券?	?啣?撣??∪??陸頝臭?畾?93??65000	65000150	25.09955392	121.4502499	02-22933613	https://az804957.vo.msecnd.net/photogym/20140616110551_DSC08502.JPG	蝐???擗?	FREE	0101000020E6100000BFE1F4E4D05C5E40AF969E5D7C193940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
525	???葉?啣????啣?撣???銝剜迤?楝107??65000	65000020	25.06393814	121.4892304	02-29844132#318	https://az804957.vo.msecnd.net/photogym/20140616102648_??冽.jpg	?啣???頞喟???????擗?	FREE	0101000020E6100000600D068D4F5F5E405F44FC3F5E103940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
526	鈭陸?葉?啣????啣?撣摨?銝剛?頝臭?畾?53??65000	65000060	24.96673954	121.5438227	02-29112005	https://az804957.vo.msecnd.net/photogym/20140616111903_2013-09-11 08.09.09.jpg	?啣???蝐???????擗?	FREE	0101000020E6100000A3D4B9FDCD625E40D20C143E7CF73840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
527	??擃葉????擗?	?箏?撣蔔???剖???69??67000	67000120	23.16754539	120.1776055	06-7222150	https://az804957.vo.msecnd.net/photogym/20140616124046_DSC03392.JPG	????擗?	FREE	0101000020E6100000BE8575E35D0B5E4044A53241E42A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
528	?箸擃?銝剛????箸蝮??勗??瑕?銵??喳誨頝臭漱?	10014	10014010	22.75939333	121.1443627	089-350575#2302	https://az804957.vo.msecnd.net/photogym/20140616131258_銝剛???.jpg	蝐???蝢賜???????PAID	0101000020E6100000C9D00C3D3D495E408A26ED9967C23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
529	銝??葉蝐????啣?撣???瘛⊿?頝臭?畾?8??65000	65000210	25.2591252	121.5017617	933490310	https://az804957.vo.msecnd.net/photogym/20140616101617_IMAG2193.jpg	憸券?,憸券?	PAID	0101000020E6100000AAF81ADD1C605E40C891730756423940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
530	?箸擃??啣????箸蝮??勗?甇?除頝?40??10014	10014010	22.75906685	121.1449957	089-350575#2209	https://az804957.vo.msecnd.net/photogym/20140616134029_摰文?????.jpg	?啣???蝐???????FREE	0101000020E6100000E1630B9C47495E404D3A803452C23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
531	銝剖控擃葉???	擃?撣?璇???頝?16??64000	64000040	22.72853708	120.2941346	07-3641116#131	https://az804957.vo.msecnd.net/photogym/20140616110415_????扯?.JPG	蝐???????擗?,蝐???FREE	0101000020E6100000D0E7ED19D3125E40F985F46781BA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
532	?亥?蝘?憭批飛?	獢?撣葉憯Ｗ??亥?頝?29??68000	68000020	24.94756151	121.2298286	03-4581196#3531	https://az804957.vo.msecnd.net/photogym/20140616141342_8GJDEZ4K54C1VCSLHBPU.JPG	????蝐????啣???FREE	0101000020E6100000DF2B0483B54E5E40FC65206493F23840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
533	?箇閫?飛?Ｘ??	?梯蝮?ˊ鞊?鞊控?葉??268??10015	10015060	23.85924999	121.4881253	(038)653906#835	https://az804957.vo.msecnd.net/photogym/20140616141912_DSC08284.JPG	????擗?	PAID	0101000020E610000069F6E5713D5F5E406923AECEF7DB3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
534	鞊ㄐ??蝬??????梯蝮?ˊ鞊?鞊ㄐ?葉撅梯楝299??10015	10015060	23.84272558	121.5082955	03-8652183	https://az804957.vo.msecnd.net/photogym/20140616142519_DSC00506.JPG	蝐???????擗?,?啣???FREE	0101000020E61000000E4DD9E987605E40469A15DDBCD73740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
535	?噫瘚瑚?蝐???摰蝮??瞉喲?葛頝?13??10002	10002030	24.59432217	121.8434496	03-9951661#324	https://az804957.vo.msecnd.net/photogym/20140616150242_H1640010-1.jpg	????擗?	FREE	0101000020E6100000C1F40714FB755E4011706B7F25983840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
536	?憭批飛????擗?	?儔蝮?之??頝臭?畾?5??10010	10010040	23.56882547	120.4938358	05-2721001#2992	https://az804957.vo.msecnd.net/photogym/20140616153251_10485306_814966178521484_516303687_o.jpg	????擗?	FREE	0101000020E610000004A678019B1F5E4026C8C68B9E913740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
537	?勗憭批飛擃擗??箏?撣葉甇??鞎湧銵?畾?6??63000	63000050	25.03787504	121.5100175	(02)28819471#5606	https://az804957.vo.msecnd.net/photogym/20140616153647_?葉擃擗?1.jpg	????擗?,蝢賜???擗?	PAID	0101000020E6100000D0B87020A4605E407B22BA2DB2093940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
538	??擃葉????擗?	?儔蝮????撱箏?頝臭?畾?1??10010	10010050	23.53214986	120.4338705	05-2213045#235	https://az804957.vo.msecnd.net/photogym/20140616135654_DSC00018.JPG	????擗?	CLOSE	0101000020E6100000BF0CC688C41B5E405F4525F93A883740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
539	瘙??葉????擗?	?啣?撣璈??暹?銵?3??65000	65000010	25.0286158	121.4676923	02-22518007#260	https://az804957.vo.msecnd.net/photogym/20140616154655_DSCF6530.JPG	????擗?	FREE	0101000020E6100000D345AFABEE5D5E401D26755D53073940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
540	???亦?憭批飛?嗅??????箏?撣?敺瑕?鈭?頝臭?畾?0??67000	67000270	22.92458853	120.2293038	06-2664911#1219	https://az804957.vo.msecnd.net/photogym/20140616154405_????.JPG	????擗?	CLOSE	0101000020E61000004E76D8E9AC0E5E40529B7AD5B1EC3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
541	?臬?擃?摰文??????儔撣??蔗銵?9??10020	10020010	23.4779343	120.4592943	05-2787140#137	https://az804957.vo.msecnd.net/photogym/20140616155346_IMG_6751.jpg	????FREE	0101000020E61000004F6FEB13651D5E40FC22FCE6597A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
542	蝢拙陸擃?銝剖飛瘣餃?銝剖?	?脫?蝮???折??獄?皞?01??10009	10009100	23.75940423	120.5952501	05-5800099#533	https://az804957.vo.msecnd.net/photogym/20140603162633_IMG_3247.JPG	蝢賜???擗?,????擗?,璉???CLOSE	0101000020E6100000351CE09318265E40484BCC5068C23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
543	曊舀?撌亙?????擗?	?啣?撣雄甇?銝剜迤銝楝154??65000	65000080	24.93993957	121.3353199	02-26775040#823	https://az804957.vo.msecnd.net/photogym/20140604144024_IMG_8220.JPG	????擗?	CLOSE	0101000020E6100000AC0C99E175555E40C65D31E19FF03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
544	擐砍??葉????擗?	?脫?蝮??摨恍擐砍???撟唾?101??10009	10009050	23.69277159	120.3561044	05-6653587#23	https://az804957.vo.msecnd.net/photogym/20140616160311_DSC01048.JPG	????FREE	0101000020E61000008DFD1B6ACA165E40DEA59A7A59B13740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
545	皜偌擃葉蝬?擃擗??啣?撣????噸頝臭?畾?2??65000	65000130	24.98184714	121.4645863	02-22707801	https://az804957.vo.msecnd.net/photogym/20140612140224_DSC05863.JPG	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E6100000DB2A2DC8BB5D5E409CF88B555AFB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
546	皜偌擃葉?啣????啣?撣????噸頝臭?畾?2??65000	65000130	24.98210262	121.4646506	02-22707801#330	https://az804957.vo.msecnd.net/photogym/20140613113609_頞喟???jpg	頞喟????啣???蝐???????擗?	FREE	0101000020E610000046C4DED5BC5D5E404637CA136BFB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
547	?箔葉銝銝剔敺	?箔葉撣???脫?銵???66000	66000050	24.15104647	120.6868637	04-22226081#305	https://az804957.vo.msecnd.net/photogym/20140616135308_DSC_0337.jpg	?啣???蝐???????擗?,蝬脩???擗?,頞喟???FREE	0101000020E6100000D0132A93F52B5E4085D340FBAA263840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
548	摰╡?葉蝬??	?脫?蝮?皝?璇批????楝1??10009	10009190	23.54627945	120.1953113	05-7907254#13	https://az804957.vo.msecnd.net/photogym/20140617005512_10471386_863791096983915_883301798_o.jpg	蝐???????擗?	PAID	0101000020E61000008382F7FA7F0C5E40143A54F8D88B3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
549	蝬?蝞∠??典摨瑕飛?Ｙ????	?粹?撣葉撅勗?敺抵?頝?36??10017	10017050	25.1500483	121.7278183	02-24372093#331	https://az804957.vo.msecnd.net/photogym/20140604111602_C360_2014-06-04-11-07-12-821.jpg	蝐???????FREE	0101000020E61000008AFB3493946E5E400652BD9069263940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
550	憭扳???瘣餃?銝剖?	獢?撣敺瑕?撱??頝?1??68000	68000080	24.95765853	121.2979996	03-3661155#313	https://az804957.vo.msecnd.net/photogym/20140617093345_IMG_1379.JPG	????擗?	CLOSE	0101000020E6100000260EEA6C12535E40DF15031C29F53840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
551	憭抒?葉蝐???擃?撣?甇血?憭抒???楝99??64000	64000170	22.67569871	120.3433371	07-3711715	https://az804957.vo.msecnd.net/photogym/20140613151631_DSC_2983.JPG	????蝬脩???擗?	FREE	0101000020E610000039002C3CF9155E403E663597FAAC3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
552	?梯憭批飛????擗?(蝢??∪?)	?梯撣镼輯楝123??\N	\N	24.0092664	121.6181374	(03)8632619	https://az804957.vo.msecnd.net/photogym/20140613155146_摰文????惺mage001.jpg	????擗?	PAID	0101000020E6100000CE5B2B908F675E40A0F364485F023840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
553	?ㄐ??撠飛摮貊?瘣餃?銝剖?	??蝮??鋆⊿銝剖控頝?07??10005	10005020	24.44804464	120.6546128	03-7861013#25	https://az804957.vo.msecnd.net/photogym/20140616142113_DSC03658.JPG	獢???擗?,????擗?,蝢賜???擗?	CLOSE	0101000020E6100000C0E2152DE5295E40B6F2B30DB3723840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
554	???葉????擗?	?啣?撣???銝剜迤?楝107??65000	65000020	25.06419082	121.4887154	02-29844132#318	https://az804957.vo.msecnd.net/photogym/20140617114612_摰文????游??jpg	????擗?	FREE	0101000020E61000004D03F51C475F5E407A9A40CF6E103940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
555	镼輯颲脣極瘣餃?銝剖?	?脫?蝮?正?粹憭批?頝???10009	10009040	23.79483804	120.4683387	05-5862024#331	https://az804957.vo.msecnd.net/photogym/20140617113347_2014镼輯颲脣極蝬?瘣餃?銝剖?憭?.jpg	????擗?,?啣???FREE	0101000020E6100000E0FCE142F91D5E40AF6A7B817ACB3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
556	銴??葉瘣餃?銝剖?	?脫?蝮??敹?銝剖?頝?2??10009	10009150	23.69940298	120.3113651	05-6972056	https://az804957.vo.msecnd.net/photogym/20140617123701_20140623_IMG_0951.JPG	蝐???擗?憸券?,????擗?憸券?	CLOSE	0101000020E61000006967E267ED135E402FD3DD120CB33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
557	鞊?擃?瘣餃?銝剖?	?箔葉撣?????楝50??66000	66000090	24.24548252	120.7136375	04-25283556	https://az804957.vo.msecnd.net/photogym/20140603155109_IMG_2362.JPG	????擗?,蝢賜???擗?	PAID	0101000020E6100000C0EC9E3CAC2D5E40C12343F1D73E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
558	?舀?蝘?憭批飛????擗?	?啣?撣摨?摰?頝?9??65000	65000060	24.95131638	121.5097761	02-82122000#2213	https://az804957.vo.msecnd.net/photogym/20140617135418_???游?抒? 052.jpg	????擗?	CLOSE	0101000020E61000001372EF2BA0605E40C63F647889F33840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
559	?踵??葉?????脫?蝮?獢?颲脫頝???10009	10009090	23.75080205	120.5077189	05-5842014#107	https://az804957.vo.msecnd.net/photogym/20140606105949_C:\\Documents and Settings\\ttjh\\獢\\???渡?\I??1.jpg	????擗?	FREE	0101000020E6100000E9C369777E205E400F852A9034C03740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
560	銝剖控擃葉????擗?	擃?撣?璇???頝?16??64000	64000040	22.72865831	120.2922946	07-3641116#131	https://az804957.vo.msecnd.net/photogym/20140616104020_????.jpg	????擗?	FREE	0101000020E610000009F368F4B4125E409C68DB5989BA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
561	???葉蝐??游????擃?撣瓷撅勗????縑銝剛?486??64000	64000190	22.81580409	120.3124595	07-6221039#35	https://az804957.vo.msecnd.net/photogym/20140617142609_DSCF3164.JPG	蝐???????擗?	FREE	0101000020E6100000C5742156FF135E40387E6E89D8D03640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
562	?啣??葉????擗?	?梯蝮????????楝143??10015	10015040	24.03044125	121.6049677	03-8263911#243	https://az804957.vo.msecnd.net/photogym/20140617134105_DSCN6313.jpg	????擗?	CLOSE	0101000020E6100000BAA871CAB7665E4009336DFFCA073840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
563	?喲陶蝘?憭批飛?剖?銝剖?(擃擗?	62153?儔蝮????撱箏?頝臭?畾?17??\N	\N	23.53469313	120.4319572	05-2267125#21642	https://az804957.vo.msecnd.net/photogym/20140617090652_?剖?銝剖?(擃擗?).jpg	蝐???蝢賜??????????恕,獢??恕,?餃??恕,?撗拙,?亥澈銝剖?,頞喟???FREE	0101000020E610000064D1CF2FA51B5E40F2BE22A6E1883740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
564	镼輯颲脣極????擗?	?脫?蝮?正?粹憭批?頝???10009	10009040	23.79419994	120.4691648	05-5862024#331	https://az804957.vo.msecnd.net/photogym/20140617151704_2014镼輯颲脣極???游?閫.jpg	????擗?	FREE	0101000020E6100000CD1BCCCB061E5E4000C9F0AF50CB3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
565	?梯憭批飛????擗?(憯質??∪?)	?梯蝮?ˊ鞊?敹飛?之摮貉楝鈭挾1-30??10015	10015060	23.89972785	121.534667	03-8906619	https://az804957.vo.msecnd.net/photogym/20140613154504_IMG_2075.JPG	????擗?	PAID	0101000020E610000007D0EFFB37625E40E70C7B9054E63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
566	銝剖控?葉????擃?撣?皜臬?瞍Ｘ?頝?52??64000	64000110	22.56651318	120.3564155	07-8021765#531	https://az804957.vo.msecnd.net/photogym/20140617161450_PNRR24HGS7YNEFC9ATEF.jpg	????FREE	0101000020E61000006612F582CF165E405CDAFC0107913640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
567	?儔?葉瘣餃?銝剖?	?儔撣????蝳?86??10020	10020010	23.48811404	120.4645032	05-2762625#230	https://az804957.vo.msecnd.net/photogym/20140617171030_G:\\擃擗?jpg	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E6100000CA38A16BBA1D5E40B884AE0AF57C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
568	??葉?啣????啣?撣璈??頝?21??65000	65000010	24.99780007	121.4624137	02-29543001#504	https://az804957.vo.msecnd.net/photogym/20140617180002_9OFCVZ2VDIY7ZIBV2P0Z.JPG	?啣???????擗?,頨脤?	FREE	0101000020E61000003BAEA12F985D5E40B5984CD36FFF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
569	敶啣?撣怎?憭批飛擃擗?敶啣?蝮?蔑???脣噸頝???10007	10007010	24.08067804	120.5593783	04-7232105#1942	https://az804957.vo.msecnd.net/photogym/20140617161133_IMGP0373.JPG	蝬??-蝐???蝢賜???獢??恕,擃??恕,?餃??恕,??恕,??閮毀摰?蝬??-????蝬??-????CLOSE	0101000020E6100000E525A4DACC235E402D4EE750A7143840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
570	?箏?蝘?憭批飛?望?????嚗??嚗??箏?撣之摰?敹??梯楝銝挾1??63000	63000030	25.04307304	121.5381847	02-27712171#3327	https://az804957.vo.msecnd.net/photogym/20140617213306_volleyball - 1.jpg	????擗?	PAID	0101000020E6100000496D3D9E71625E40A923B2D5060B3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
571	????????擗?	?啣?撣璈??舐????楝163??65000	65000010	25.025415	121.4739391	02-22517272#104	https://az804957.vo.msecnd.net/photogym/20140618075104_????01.jpg	????擗?	FREE	0101000020E6100000ECB2A904555E5E40EDD3F19881063940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
572	憭扳慰?銵飛?Ｘ??	?梯蝮???憭扳慰?邦鈭箄?1??10015	10015040	24.03799848	121.6089106	(03)8210879	https://az804957.vo.msecnd.net/photogym/20140618092650_????.JPG	????FREE	0101000020E6100000044C2A64F8665E40D0E5B444BA093840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
573	?控擃葉蝐???擃?撣野?曉?憭批頝?1??64000	64000180	22.64815426	120.3538199	07-7777272#360	https://az804957.vo.msecnd.net/photogym/20140617174010_蝐??游?蝮?jpg	????FREE	0101000020E610000023CB38FCA4165E408C760570EDA53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
574	?急?擃葉瘣餃?銝剖?	?粹?撣葉甇???啗?銵?00??10017	10017010	25.14037019	121.787138	02-24692366#20	https://az804957.vo.msecnd.net/photogym/20140617141114_mobile0c083b16-aba5-417d-bc72-1e0188fe6fee.jpg	????擗?	FREE	0101000020E610000016DC0F7860725E402062FF4CEF233940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
575	蝡孵??葉?啣????啁姘撣???像頝???10018	10018020	24.80879467	120.9550953	03-5246683#625	https://az804957.vo.msecnd.net/photogym/20140618095543_DSC_1756.JPG	?啣???蝐???????FREE	0101000020E61000000D840948203D5E4041D4E02A0DCF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
576	敶啣?撣怎?憭批飛蝬脩?擗?敶啣?蝮?蔑???脣噸頝???10007	10007010	24.08043806	120.5604672	04-7232105#1942	https://az804957.vo.msecnd.net/photogym/20140618102158_蝬脩?擗?.jpg	蝬脩?擗?蝬脩?擗券?璅憭???蝐???蝬脩?擗券?璅憭???????CLOSE	0101000020E6100000C49ED1B1DE235E40BE0DB59697143840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
577	?楷?葉????擗?	擃?撣?撌Ｗ?銝剛?頝?67??64000	64000210	22.78541066	120.3645238	07-6161267#25	https://az804957.vo.msecnd.net/photogym/20140618104651_P1150154.JPG	????擗?	FREE	0101000020E610000046E7A15B54175E4039A14AAC10C93640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
578	銝寥陶擃葉蝐????啣?撣??樴?頝?2??65000	65000050	25.02105234	121.4166337	02-29089627	https://az804957.vo.msecnd.net/photogym/20140605173132_IMGP3800.JPG	????擗?	CLOSE	0101000020E610000056FA6420AA5A5E40E5CDA7AF63053940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
579	銝剖?蝘?憭批飛蝐????啁姘蝮?????銝剖控頝臭?畾?30??10004	10004050	24.91854988	121.0565257	03-6991111#1616	https://az804957.vo.msecnd.net/photogym/20140618110636_IMG_0260.JPG	蝐???????CLOSE	0101000020E61000008B38F81D9E435E404058BE1526EB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
580	?脖???蝬??	?脫?蝮?獢?????5??10009	10009090	23.7582848	120.4867387	05-5842525	https://az804957.vo.msecnd.net/photogym/20140618111736_ball01.jpg	蝐???????擗?	FREE	0101000020E6100000A58C13BA261F5E40CC0DE1F31EC23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
581	銝寥陶擃葉?蝐????啣?撣??樴?頝?2??65000	65000050	25.02105234	121.4166605	02-29089627#115	https://az804957.vo.msecnd.net/photogym/20140609114724_IMGP3835.JPG	????擗?	CLOSE	0101000020E61000003E42CD90AA5A5E40E5CDA7AF63053940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
582	銝剖??葉擃擗?擃?撣之撖桀?銝剖????楝銝挾1437??64000	64000140	22.63760999	120.4006398	07-7033166#213	https://az804957.vo.msecnd.net/photogym/20140617172812_P_20131126_143649.jpg	????擗?	PAID	0101000020E6100000769E1D15A4195E4024A786683AA33640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
583	瘛⊥偌?葉?啣????啣?撣楚瘞游???????10??65000	65000100	25.17485437	121.4381182	02-26218821	https://az804957.vo.msecnd.net/photogym/20140618102338_?啣??游?閫.JPG	?啣???蝐???????擗?	FREE	0101000020E61000001332EB200A5C5E4072B68841C32C3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
584	瘛⊥偌?葉銝剜迤??瘣餃?銝剖?	?啣?撣楚瘞游???????10??65000	65000100	25.17486165	121.4375147	02-26218821	https://az804957.vo.msecnd.net/photogym/20140617105113_銝剜迤??閫.JPG	蝐???????擗?,蝢賜???擗?	PAID	0101000020E61000003B01A83D005C5E401913ACBBC32C3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
585	蝡孵?擃?銝剖飛??????蝮?姘?銝剜迤頝?8??10005	10005040	24.68579236	120.8737868	03-7476855#210	https://az804957.vo.msecnd.net/photogym/20140618114924_DSCF8954.jpg	????FREE	0101000020E61000004C6B781FEC375E40F20B8E1690AF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
586	銝剖控?怠飛憭批飛????擗?	?箔葉撣??撱箏??楝銝畾?10??66000	66000030	24.12001657	120.6504607	04-22651657	https://az804957.vo.msecnd.net/photogym/20140618120016_DSC_0054.JPG	????擗?	FREE	0101000020E61000005475EA25A1295E40CB20EB67B91E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
587	暽踵葛擃葉????擗?	敶啣?蝮?嘀皜舫?梁?葉撅梯楝661??10007	10007020	24.06028786	120.4238302	04-7772403#671	https://az804957.vo.msecnd.net/photogym/20140618133809_122-31憸券?.JPG	????擗?	CLOSE	0101000020E6100000A803B408201B5E40BB0B73066F0F3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
588	銝??極????擗?	?啣?撣???銝剜迤?楝163??65000	65000020	25.06933668	121.4794403	02-29715606#303	https://az804957.vo.msecnd.net/photogym/20140618135729_IMG_5787.JPG	????擗?	FREE	0101000020E61000009A385E26AF5E5E406203750CC0113940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
589	?澈??????擗?	撅蝮??皜舫?銝剖??葉?楝33??10013	10013090	22.80702699	120.4924196	08-7731553	https://az804957.vo.msecnd.net/photogym/20140616165755_20140616_155545.jpg	?勗蝬?蝐???FREE	0101000020E6100000347A7FCD831F5E40110A215299CE3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
590	?質健??銝?撠敺	?啁姘撣???頝???10018	10018010	24.76874752	120.9659582	(03)5296380#381	https://az804957.vo.msecnd.net/photogym/20140618133744_2014-06-19_155059.jpg	?啣???蝐???????擗?	CLOSE	0101000020E610000065935742D23D5E40F74731A3CCC43840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
591	敺抵?擃葉?啣????箏?撣???敺抵??楝70??63000	63000120	25.14274001	121.5020084	02-28914131#330	https://az804957.vo.msecnd.net/photogym/20140618133957_DSC000651.jpg	蝐????????啣???FREE	0101000020E61000004E14D7E720605E40DDC7FA9B8A243940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
592	???極?啣????箏?撣葉甇???梢????楝1畾???63000	63000050	25.04172921	121.5216744	02-23212666#212	https://az804957.vo.msecnd.net/photogym/20140618142306_11.jpg	?啣????啣耦/?渡??Ｚ????敺??,蝐???????擗?	CLOSE	0101000020E610000044CA051D63615E40E83CF8C3AE0A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
593	敺瑟?鞎∠?蝘?憭批飛?????箏?撣皝??啣控頝臭?畾?6??63000	63000100	25.08746238	121.5669233	02-26585801#5196	https://az804957.vo.msecnd.net/photogym/20140618145913_mobile9e074ac5-48d4-4203-9450-5ccb0db647d5.jpg	????FREE	0101000020E6100000C935AA7848645E40F7BA3DEF63163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
594	敶啣?撣怎?憭批飛撖嗅控?∪?????敶啣?蝮?蔑??撣怠之頝臭???10007	10007010	24.06925151	120.55749	04-7232105#1942	https://az804957.vo.msecnd.net/photogym/20140618151908_??12.jpg	撖嗅控?∪?????CLOSE	0101000020E6100000367689EAAD235E400CA68A77BA113840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
595	??撟湧????	擃?撣????噸銵???64000	6400800	22.62716271	120.3319108	07-7111164	https://az804957.vo.msecnd.net/photogym/20140611174133_??撟游??.jpg	??撟湧????蝐?????撟湧????璆菟????湔璉?????撟湧????璆菟????湔??,??撟湧????蝐雯?,??撟湧????璆菟?????CLOSE	0101000020E61000001CCCCB063E155E4082B840BC8DA03640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
596	撅蝘?憭批飛????擗?	撅蝮???摮詨?頝???10013	10013130	22.64542265	120.6134462	(08)7703202#6481	https://az804957.vo.msecnd.net/photogym/20140618151233_11.jpg	????擗?	CLOSE	0101000020E6100000C0B6D9B342275E4000D9356B3AA53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
597	銝剖控?怠飛憭批飛憭??賡??	?箔葉撣??撱箏??楝銝畾?10??66000	66000030	24.12303985	120.6505251	04-22651657	https://az804957.vo.msecnd.net/photogym/20140618153404_DSC06571.JPG	蝐???????FREE	0101000020E6100000896E0734A2295E40D1DA238A7F1F3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
598	撅蝘?憭批飛摮孕擃擗?撅蝮???摮詨?頝???10013	10013130	22.64403641	120.6140471	08-7703202#6481	https://az804957.vo.msecnd.net/photogym/20140610144306_G8-1.jpg	?亥澈???恍???蝺游恕),???恕,獢???擗?,?撗拙,?啣????單???擗?蝢賜???擗?,蝐???????擗?	CLOSE	0101000020E6100000082D358C4C275E401C62F691DFA43640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
599	敹??蝬??	?儔撣正?銝郭頝臬?畾?41??10020	10020020	23.46243931	120.4452395	05-2857924	https://az804957.vo.msecnd.net/photogym/20140613141441_109_1212.JPG	蝐???????FREE	0101000020E6100000CBD8D0CD7E1C5E40B6D5306C62763740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
600	??憭批飛?交?靽正鈭?擃擗??箔葉撣?暽踹??箇憭折?7畾?00??66000	66000130	24.22923276	120.581072	04-26328001#16321	https://az804957.vo.msecnd.net/photogym/20140617172140_??擃擗?JPG	摰文蝐???摰文?????撗拙,???恕,憭??賣?摰?憌憚?恕,蝢賜???獢??恕,?亥澈銝剖?	CLOSE	0101000020E6100000C4279D4830255E402F5F87FFAE3A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
601	?勗?葉蝐????脫?蝮??ａ??望旨頝?5??10009	10009140	23.67255112	120.2575761	05-6991035#23	https://az804957.vo.msecnd.net/photogym/20140618182613_DSC00285.JPG	蝐???????擗?	FREE	0101000020E6100000CC6E77207C105E40C649694F2CAC3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
602	?芣??葉擃擗??啣?撣???葉頝???65000	65000200	24.93762541	121.7118202	02-26656210	https://az804957.vo.msecnd.net/photogym/20140618103626_擃擗?JPG	蝐???蝢賜???擗?,獢???擗?,????擗?,???恕	FREE	0101000020E610000076E84F768E6D5E403DD9073808F03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
603	?芣??葉?啣????啣?撣???葉頝???65000	65000200	24.93746854	121.7123204	02-26656210	https://az804957.vo.msecnd.net/photogym/20140619080200_?啣???JPG	?啣???蝐???????擗?	FREE	0101000020E610000083914DA8966D5E40315430F0FDEF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
604	蝛靽振???(擗?	?啣?撣???銝剜迤?楝560撌?8??65000	65000020	25.06958935	121.4712971	02-29712343#304	https://az804957.vo.msecnd.net/photogym/20140619091901_P1040820.JPG	????擗?	CLOSE	0101000020E6100000C7CC4FBB295E5E4060668E9BD0113940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
605	憭扯????啣????啣?撣璈?憭扯?頝臭?畾?0??65000	65000010	25.0088604	121.4498663	02-29603373#831	https://az804957.vo.msecnd.net/photogym/20140617094659_DSC09948.JPG	蝐???????擗?,?啣???FREE	0101000020E6100000A484059CCA5C5E40BF3AD8AC44023940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
606	銝????啣????啣?撣???銝?頝臭?畾???65000	65000020	25.07029513	121.4976257	02-29722095#182	https://az804957.vo.msecnd.net/photogym/20140617154401_20140617_150621.jpg	?啣???蝐???????擗?,頨脤?	FREE	0101000020E61000008BC97619D95F5E40076B94DCFE113940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
607	敶啣?蝮??擃?湔??	敶啣?撣?楝1??\N	\N	24.06850702	120.5532628	04-7112175	https://az804957.vo.msecnd.net/photogym/20140619095924_P6189903(001).jpg	????FREE	0101000020E6100000FA0560A868235E40487212AD89113840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
608	?啣????啣????啣?撣摨?摰?頝臭?畾?00??65000	65000060	24.98522169	121.5180051	02-29400170#823	https://az804957.vo.msecnd.net/photogym/20140619102620_?啣???jpg	?啣???蝐???????頨脤?	FREE	0101000020E610000051EADCFE26615E401FDC197D37FC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
639	蝢??葉擃擗?擃?撣?瞈????葉甇?楝銝畾?91??64000	64000310	22.89457978	120.5434245	07-6816166	https://az804957.vo.msecnd.net/photogym/20140620095043_IMAG1602.jpg	蝐???????PAID	0101000020E610000017D68D77C7225E404CC3322E03E53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
609	?砍??葉????擗?	撅蝮?撌??砍???敹楝5??10013	10013120	22.5703027	120.5749887	08-7812537#14	https://az804957.vo.msecnd.net/photogym/20140619105323_C:\\Documents and Settings\\user\\獢\\摮豢?游\\??1.JPG	????擗?	FREE	0101000020E61000007484679DCC245E400C52955BFF913640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
610	?脫?擃葉瘣餃?銝剖?	?箏?撣?皜臬??頝?66??63000	63000090	25.05826237	121.6096187	02-26530475#541	https://az804957.vo.msecnd.net/photogym/20140611143603_C:\\Documents and Settings\\user\\獢\\6F蝐???jpg	蝐???蝢賜???擗?,????擗?,皜豢陶瘙?擗?	PAID	0101000020E6100000ECE126FE03675E40CABC5D48EA0E3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
611	銝剖控憭批飛擃擗?擃?撣?撅勗??格絲頝?0??64000	64000020	22.62463742	120.2663416	07-5252000#2801	https://az804957.vo.msecnd.net/photogym/20140618092210_20140619_170126.jpg	蝐???蝢賜???擗?,????擗?,?餃??恕,獢???擗?,?亥澈???恍???蝺游恕)	PAID	0101000020E61000001E64A3BD0B115E4000C2EA3CE89F3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
612	銝剖控憭批飛?啣???擃?撣?撅勗??格絲頝?0??64000	64000020	22.62288454	120.2648449	07-5252000#2801	https://az804957.vo.msecnd.net/photogym/20140619101706_DSC09691.JPG	蝐???????摰文撠悌???啣???頞喟????啣???PAID	0101000020E6100000CB000638F3105E40E87B785C759F3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
613	曊舀???瘣餃?銝剖?	?啣?撣雄甇????撅勗?頝?06??65000	65000080	24.95121667	121.3466227	02-26792038#223	https://az804957.vo.msecnd.net/photogym/20140619134030_瘣餃?銝剖?.JPG	????擗?	CLOSE	0101000020E61000004723FA102F565E405E0F89EF82F33840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
614	?砌號??????擗?	撅蝮?銝寥?撖嗅???啗楝1497??10013	10013050	22.58306742	120.4883641	08-7772014#13	https://az804957.vo.msecnd.net/photogym/20140619140252_1.jpg	????擗?	CLOSE	0101000020E610000097827F5B411F5E405A430CE843953640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
615	憭批??葉????擗?	獢?撣葉憯Ｗ???頝臭?畾?0??68000	68000020	24.99233517	121.1800522	03-4982840#310	https://az804957.vo.msecnd.net/photogym/20140613142856_STB_2964.JPG	????擗?	CLOSE	0101000020E6100000AAA4A9F9854B5E4013D27DAD09FE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
616	?控?葉瘣餃?銝剖?	擃?撣?撅勗?憭批噸?葉摮貉楝42??64000	64000300	22.88111018	120.4816425	07-6612650#214	https://az804957.vo.msecnd.net/photogym/20140618144244_IMG_1789.jpg	????擗?,蝢賜???擗?,蝐???CLOSE	0101000020E61000004777103BD31E5E40CE45CF6F90E13640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
617	?啣?擃葉蝐????箏?撣??敹?銵???67000	67000180	23.04045047	120.3104932	06-5982065#4002	https://az804957.vo.msecnd.net/photogym/20140619130211_蝐???.JPG	蝐???????擗?	FREE	0101000020E610000058E8DE1EDF135E4001C245F65A0A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
618	摰擃?蝐???摰蝮???剖?撱嗅像頝?0??10002	\N	24.75487922	121.7661256	03-9384147#330	https://az804957.vo.msecnd.net/photogym/20140606155619_摰文?蝐???.jpg	????擗?	FREE	0101000020E61000003728AB3308715E407A54BAC33FC13840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
619	?曉控撌亥噙?啣????箏?撣縑蝢拙?敹??梯楝5畾?36撌?5??63000	63000020	25.03962961	121.5730011	02-27226616#351	https://az804957.vo.msecnd.net/photogym/20140619150012_BYA1HL24VSOIXSPKEFE9.JPG	?啣???蝐???????FREE	0101000020E61000009C44CE0CAC645E403AE7862A250A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
620	鈭云?菜??銵飛?ａ??葉敹???蝮?隞賡摮詨?頝?10??10005	\N	24.68203432	120.9696811	037-605560	https://az804957.vo.msecnd.net/photogym/20140619150924_摰文?????.jpg	蝐???蝬脩???擗?,????擗?	FREE	0101000020E6100000280351410F3E5E404C261BCD99AE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
621	敺抵??極蝐????啣?撣偶??蝘?楝銝畾?01??65000	65000040	25.00360991	121.5184987	02-29262121#218	https://az804957.vo.msecnd.net/photogym/20140619143347_IMAG3827.jpg	????CLOSE	0101000020E61000002FE12B152F615E403A643D94EC003940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
622	?∩號?葉蝐???撅蝮?銝寥??喲???頝?-1??10013	10013330	22.12904071	120.775306	08-8831014	https://az804957.vo.msecnd.net/photogym/20140617171408_2014-06-19 12.49.51.jpg	????擗?	FREE	0101000020E610000020990E9D9E315E40794DDDCF08213640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
623	?梯???蝬??	?脫?蝮????蝢???楝1??10009	10009120	23.75640924	120.3735495	05-6962164#11	https://az804957.vo.msecnd.net/photogym/20140616083547_蝐???JPG	蝐???頨脤?,????擗?	FREE	0101000020E6100000FA7B293CE8175E4035313409A4C13740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
624	銝剔?撖阡?擃?銝剖飛瘣餃?銝剖?	42878?唬葉撣之??撟喳?頝?27??\N	\N	24.22992251	120.624733	04-25686850#1320	https://az804957.vo.msecnd.net/photogym/20140619152602_2014-06-19 15.10.27_resize.jpg	蝐???皜豢陶瘙?擗?,蝢賜???擗?,????擗?,???恕	CLOSE	0101000020E6100000D9EE1EA0FB275E4072109D33DC3A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
625	蝢拙?憭批飛擃擗?擃?撣之璅孵?銝??飛?楝銝畾???64000	64000150	22.7269785	120.4073131	07-6577711	https://az804957.vo.msecnd.net/photogym/20140603165939_mobile918d7518-3a09-471b-be46-42247f6154e0.jpg	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E6100000DFEEF66A111A5E40286552431BBA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
626	?血?擃葉?啣????啣?撣葉???血?頝?63??65000	65000030	24.99326384	121.4913332	02-22498566	https://az804957.vo.msecnd.net/photogym/20140619155807_DSC09197.JPG	?啣???????擗?,蝐???FREE	0101000020E6100000195CCE00725F5E407119FD8946FE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
627	?交???啣???94249撅蝮??仿??交??亥楝314??\N	\N	22.36944389	120.6273508	08-8782433#14	https://az804957.vo.msecnd.net/photogym/20140619152954_111.jpg	?啣???????擗?,頞喟???FREE	0101000020E6100000A547F88326285E40CC41F1DF935E3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
628	?剖??葉憸券?	?啣?撣??銝剖?頝???65000	65000050	25.05602697	121.4592218	02-85222862	https://az804957.vo.msecnd.net/photogym/20140617124711_2014-06-17 11.42.42.jpg	?啣???蝢賜???擗?	FREE	0101000020E61000000E27D5E3635D5E400FD893C8570E3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
629	銝剔?撖阡?擃?銝剖飛蝐??	42878?唬葉撣之??撟喳?頝?27??\N	\N	24.22916916	120.6248403	04-25686850#1320	https://az804957.vo.msecnd.net/photogym/20140619161929_2014-06-19 15.14.29_resize.jpg	蝐???????擗?	CLOSE	0101000020E6100000436E2B62FD275E40A9737FD4AA3A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
630	?啣?擃葉????擗?	?箏?撣??敹?銵???67000	67000180	23.04026777	120.3086641	06-5982065#4002	https://az804957.vo.msecnd.net/photogym/20140619164924_????.JPG	????擗?	FREE	0101000020E6100000C1BC1127C1135E409C3B13FD4E0A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
631	?擃葉????擗?	擃?撣??桀??桐葉頝?32??64000	\N	22.58917445	120.3186446	07-8226841#206	https://az804957.vo.msecnd.net/photogym/20140619171233_DSC05608.JPG	????擗?	FREE	0101000020E6100000020352AC64145E4088630223D4963640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
632	憭扯?擃葉蝐????箏?撣?撅勗??祈????楝2畾?75??63000	63000080	24.99067232	121.5783978	02-22348989#34	https://az804957.vo.msecnd.net/photogym/20140619154428_C:\\Documents and Settings\\PEHT\\獢\\擃蝯\102摮詨僑摨吒\?祆??辣\\撱箸??典????湧尹鞈?蝬脰??怎???\DSC09658.JPG	????擗?	FREE	0101000020E610000004C5347804655E40D4737FB39CFD3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
633	?喲陶蝘?憭批飛????擗?	62153?儔蝮????撱箏?頝臭?畾?17??\N	\N	23.5357979	120.435521	05-2267125#21642	https://az804957.vo.msecnd.net/photogym/20140618163222_???游.JPG	????FREE	0101000020E610000028EE7893DF1B5E40F6C3190D2A893740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
634	摰╡?葉擃擗??脫?蝮?皝?璇批????楝1??10009	10009190	23.54613684	120.195601	05-7907254#13	https://az804957.vo.msecnd.net/photogym/20140616173844_10471386_863791096983915_883301798_o.jpg	蝢賜???擗?,蝐???????擗?	PAID	0101000020E610000027840EBA840C5E40D7F0BA9FCF8B3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
635	憭批???瘣餃?銝剖?	獢?撣敺瑕?敹?銵?8??68000	68000080	24.95992976	121.3012129	03-3635206#511	https://az804957.vo.msecnd.net/photogym/20140610153333_D:\\103撟游漲\\瘣餃?銝剖?.jpg	????擗?,蝢賜???擗?	PAID	0101000020E610000088A8781247535E403AA8EDF4BDF53840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
636	??擃葉摰文???????蝮?????頝?4??9020	9020010	24.4345362	118.3155844	082-325450#213	https://az804957.vo.msecnd.net/photogym/20140620085506_????JPG	????擗?	FREE	0101000020E61000002E48E98832945D4099EDAFC33D6F3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
637	?噸??????擗?	撅蝮??撖桅??控??敺瑁楝186??10013	10013160	22.3634	120.6006789	08-8782096	https://az804957.vo.msecnd.net/photogym/20140620092520_IMG_9320.JPG	????擗?	FREE	0101000020E61000006DB9E98571265E40CC5D4BC8075D3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
638	?啣?擃葉蝐???擃?撣之撖桀?敺??陶撅?頝?17??64000	64000140	22.63555526	120.3901201	(07)7019888	https://az804957.vo.msecnd.net/photogym/20140620092833_DSCN5539.JPG	????擗?,蝐???CLOSE	0101000020E6100000C9C04BBAF7185E403380E0BFB3A23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
640	瘞游??蝐???撅蝮????瘞游??瞍楝117??10013	10013190	22.41937966	120.5042052	08-8752745	https://az804957.vo.msecnd.net/photogym/20140620101638_蝐?.JPG	????擗?	FREE	0101000020E6100000481EE3E544205E40BF4E24775C6B3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
641	?箔葉摰嗅??????箔葉撣??像銵?0??66000	66000020	24.1331153	120.6850934	04-22223307	https://az804957.vo.msecnd.net/photogym/20140620093652_?抒? 252.jpg	????擗?	CLOSE	0101000020E610000026EDFC91D82B5E40E41824D813223840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
642	撅蝮??憒?????擗?	撅蝮??憒?銋?頝臭?畾?16??10013	10013080	22.73133259	120.4823935	08-7394216	https://az804957.vo.msecnd.net/photogym/20140620111331_C:\\Documents and Settings\\Administrator\\獢\\IMG_0188.JPG	????擗?	FREE	0101000020E61000006493FC88DF1E5E408A8CD49C38BB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
643	璅寞?擃葉?啣????啣?撣邦??銝剛頝???65000	65000070	24.98347122	121.421231	02-86852011#3101	https://az804957.vo.msecnd.net/photogym/20140620111628_?啣???JPG	?啣???????擗?,頞喟???????擗?	FREE	0101000020E6100000EE43DE72F55A5E400C7516C5C4FB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
644	憭批?憭批飛?????箏?撣葉撅勗?銝剖控?楝銝挾40??63000	63000040	25.06771131	121.5204298	02-21822928#7519	https://az804957.vo.msecnd.net/photogym/20140620141503_DSC_7397.JPG	????CLOSE	0101000020E610000049B7CAB84E615E40F204468755113940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
645	?批???擃擗?撅蝮????批??誨瞈楝2??10013	10013130	22.61040083	120.5664861	08-7792055#13	https://az804957.vo.msecnd.net/photogym/20140620101257_DSC01758.JPG	????擗?	PAID	0101000020E6100000DF48EA4E41245E401F4D923A439C3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
646	鈭?撌亙?蝐???敶啣?蝮???鞊???楝?挾500??10007	10007200	23.90004252	120.3777337	04-8962132#323	https://az804957.vo.msecnd.net/photogym/20140620144002_DSC03195-1.jpg	蝐???????擗?	PAID	0101000020E61000003606F8C92C185E40D068C42F69E63740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
647	瘛⊥?擃葉蝐??	?啣?撣楚瘞游???銵?6??65000	65000100	25.17561658	121.4363775	(02)2620-3850	https://az804957.vo.msecnd.net/photogym/20140620144507_20140122-IMG_6223.JPG	蝐??	FREE	0101000020E610000075CDE49BED5B5E4041BC4B35F52C3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
648	摰憭批飛擃擗?摰蝮???剖?蟡噙頝臭?畾???10002	\N	24.74539899	121.7463523	03-9357400#7194	https://az804957.vo.msecnd.net/photogym/20140620155431_?抒? 015.jpg	蝢賜???擗?,????擗?,獢???擗?,?撗拙,蝐???????PAID	0101000020E6100000D7F26F3CC46F5E407D85DC77D2BE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
649	????瘣餃?銝剖?	擃?撣???????摮正頝?0??64000	\N	22.50808691	120.3939664	07-6412125	https://az804957.vo.msecnd.net/photogym/20140620163944_CIMG7710.JPG	????擗?	CLOSE	0101000020E610000043EED8BE36195E40C7F9D5FB11823640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
650	摰憭批飛?啣???摰蝮???剖?蟡噙頝臭?畾???10002	\N	24.74527232	121.7478812	03-9357400#7194	https://az804957.vo.msecnd.net/photogym/20140620114557_?抒? 1111.jpg	?啣???蝐???????頞喟???FREE	0101000020E6100000C4D21B49DD6F5E409903B12ACABE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
651	?啣??葉????擗?	?啣?撣璈??唳絲頝?81??65000	65000010	25.02497023	121.4589429	02-22572275#318	https://az804957.vo.msecnd.net/photogym/20140620172016_20140620_102559.jpg	????擗?	FREE	0101000020E6100000CF8E0A525F5D5E403E39F17264063940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
652	?啁擐?憭批飛????擗?	?箏?撣獄鞊??168??67000	67000070	23.19252292	120.2679563	(06)5718888	https://az804957.vo.msecnd.net/photogym/20140620172546_H:\\?湧?擃摰么\???游?抒?\\???廄\IMG_0034.JPG	????擗?	CLOSE	0101000020E610000075502E3226115E4063219D2E49313740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
653	蝢拙?憭批飛蝐???擃?撣之璅孵?銝??飛?楝銝畾???64000	64000150	22.72787902	120.4068169	07-6577711	https://az804957.vo.msecnd.net/photogym/20140620151328_蝐??冽2.jpg	蝐???????擗?	CLOSE	0101000020E6100000723DC049091A5E4033588A4756BA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
654	撗∪控擃葉摰文?????擃?撣瓷撅勗??砍?頝?2??64000	64000190	22.79651187	120.2898645	07-6212033#320	https://az804957.vo.msecnd.net/photogym/20140620175142_IMG_5814.JPG	摰文?????FREE	0101000020E61000005EF1D4238D125E409B86B033E8CB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
655	憭批?擃葉蝬??(蝐??潭??)	撅蝮???勗??像頝?29??10013	10013010	22.67789639	120.4751998	08-7663916	https://az804957.vo.msecnd.net/photogym/20140621135539_CIMG1987.JPG	蝐???????擗?	CLOSE	0101000020E610000035046CAC691E5E406020299E8AAD3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
656	瘛⊥?憭批飛蝝寡洧蝝敹菟??脤尹	?啣?撣楚瘞游??勗?頝?51??65000	65000100	25.17580685	121.4488336	02-26230985	https://az804957.vo.msecnd.net/photogym/20140529154254_蝝寡洧蝝敹菟??脤尹.jpg	蝐???蝢賜???擗?,獢???擗?,????擗?,???恕,頝?/擗?CLOSE	0101000020E6100000245690B0B95C5E40AC297FAD012D3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
657	鈭日之摮賊??脤尹	?啁姘撣?憭批飛頝?001??10018	10018010	24.78891492	120.9958454	03-5712121#51003	https://az804957.vo.msecnd.net/photogym/20140622164056_擃擗?.JPG	蝐???????擗?,?餃??恕,擃?賣?摰??亥澈???恍???蝺游恕)	PAID	0101000020E6100000CF3758EEBB3F5E40F9B90454F6C93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
658	銝剖???????擗?	擃?撣之撖桀?銝剖??葉摨楝59??64000	64000140	22.63591669	120.397346	07-7032838#741	https://az804957.vo.msecnd.net/photogym/20140619105901_IMGP3382.JPG	????擗?	CLOSE	0101000020E610000092CCEA1D6E195E40D387AA6FCBA23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
659	???蝐????脫?蝮???折?銝剜迤頝?11??10009	10009100	23.75978228	120.618234	05-5892019	https://az804957.vo.msecnd.net/photogym/20140623115647_DSC05925.JPG	????擗?	FREE	0101000020E61000009ED1562591275E4029AE6C1781C23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
660	??憭批飛摰文??????箔葉撣?暽踹??箇憭折?7畾?00??66000	66000130	24.22644191	120.5778882	04-26328001#16320	https://az804957.vo.msecnd.net/photogym/20140623133550_摰文?????JPG	????FREE	0101000020E6100000A3EFC91EFC245E40CEE4D518F8393840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
661	暻亙祚擃葉瘣餃?銝剖?	?脫?蝮?漸撖桅?銝剛?頝?10??10009	10009130	23.75776436	120.2519166	05-6932050#043	https://az804957.vo.msecnd.net/photogym/20140623151141_IMG_2086.JPG	????擗?	CLOSE	0101000020E61000007394CD661F105E403D4658D8FCC13740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
662	?葛擃葉????擗?	?脫?蝮??皜舫??頝?6??10009	10009060	23.57864911	120.3045309	05-7821411#307	https://az804957.vo.msecnd.net/photogym/20140623134008_蝐?鞈?012.jpg	????擗?	FREE	0101000020E6100000C6072C6F7D135E403C4F1B5922943740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
663	憭批????啣?擗??箔葉撣之???批?頝?20??66000	66000280	24.09911603	120.6904578	04-24834568	https://az804957.vo.msecnd.net/photogym/20140722145302_outlook.jpg	????擗?,蝢賜???擗?	PAID	0101000020E61000002991E975302C5E40FF5B0BAB5F193840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
664	憭批????	?箔葉撣之???曉盛頝?0??66000	66000280	24.09996808	120.6908977	04-24834568	https://az804957.vo.msecnd.net/photogym/20140722161044_S4502.jpg	?啣???頨脤?,????蝐???FREE	0101000020E61000006C98FCAA372C5E40713E128297193840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
665	鈭散擗?蝐????箏?撣??憭扳?頝臭?畾???67000	67000330	22.97463834	120.2023709	06-2640175#304	https://az804957.vo.msecnd.net/photogym/20140722170229_DSC_3127.JPG	????擗?	CLOSE	0101000020E6100000604A13A5F30C5E404CBAF3E581F93640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
666	?脤?擃擃擗??箏?撣撅勗?蝢??祐摰?12??63000	63000010	25.04993775	121.5543598	02-25706767#306	https://az804957.vo.msecnd.net/photogym/20140724112836_IMAG0358.jpg	????擗?	CLOSE	0101000020E6100000E5CD86A17A635E40F9156BB8C80C3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
667	隤迤?葉瘣餃?銝剖?	?箏?撣?皜臬??啣???摨瑁?1撌?4??63000	63000090	25.0541531	121.6195895	02-27828094#1314	https://az804957.vo.msecnd.net/photogym/20140721115932_P1020405.JPG	????擗?,蝐???PAID	0101000020E61000007BDCB75AA7675E401E7A41FADC0D3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
668	憭批????????箔葉撣正?敹??楝515??66000	66000040	24.13421353	120.6590098	04-23755959	https://az804957.vo.msecnd.net/photogym/20140724124048_IMAG5633.jpg	????擗?,蝬脩???擗?	FREE	0101000020E610000096AF70372D2A5E40DD0762D15B223840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
669	瘝嘀?葉憸券?	?箔葉撣?暽踹?銝剜迤銵???66000	66000130	24.2344963	120.5622107	04-26622163	https://az804957.vo.msecnd.net/photogym/20140722102049_IMG_0456.JPG	????擗?	CLOSE	0101000020E6100000857D9642FB235E40738813F3073C3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
670	瘞賊??葉?啣???敶啣?蝮?偶?????憯質楝123??10007	10007160	23.93021522	120.5508059	04-8221929	https://az804957.vo.msecnd.net/photogym/20140724160428_?甇?.jpg	????擗?,?啣???頞喟???FREE	0101000020E610000068BC636740235E403624AC9522EE3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
671	暽賢??葉蝬??	撅蝮?厭??暽賢????抵楝30??10013	10013100	22.75487353	120.5743697	08-7932001#13	https://az804957.vo.msecnd.net/photogym/20140725094614_蝬?? (2).jpg	????擗?	FREE	0101000020E61000000E542179C2245E4051F743643FC13640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
672	?祆??葉蝐????箔葉撣?暽踹??祆??葉皜楝?剜挾567??66000	66000130	24.24852239	120.5998394	04-26154262#222	https://az804957.vo.msecnd.net/photogym/20140718145355_DSCF8893.JPG	????擗?	FREE	0101000020E61000008B76CBC463265E40AF5FD1299F3F3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
673	?祆??葉?????箔葉撣?暽踹??祆??葉皜楝?剜挾567??66000	66000130	24.24938723	120.5990252	04-26154262#222	https://az804957.vo.msecnd.net/photogym/20140718114113_QEVAFIM6BC6TQYB0HDJ8.JPG	????擗?	FREE	0101000020E6100000B6DECA6D56265E40D9E36CD7D73F3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
674	瞏桀??葉?啣???撅蝮?蔭撌??頝?6??10013	10013020	22.55445537	120.5439663	08-7882401#10	https://az804957.vo.msecnd.net/photogym/20140724120822_P1130594.JPG	?啣???蝐???????擗?	FREE	0101000020E610000012280758D0225E40D83D81C9F08D3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
675	???葉蝐?????蝮??皝憭芣?頝臭?畾???9020	9020030	24.43647389	118.4215236	082-332612#123	https://az804957.vo.msecnd.net/photogym/20140721112139_10566239_886197864727032_645101936_n.jpg	蝐???????擗?	FREE	0101000020E6100000801F1F3EFA9A5D409F1BBBC0BC6F3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
676	瞍悸??蝳桀?	?箏?撣?頠??瑟旨????67000	67000160	23.19849549	120.1597613	06-7942012	https://az804957.vo.msecnd.net/photogym/20140709171524_IMG_3502.JPG	????擗?	FREE	0101000020E6100000A7AA7587390A5E4018F4B599D0323740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
677	皜??葉?????箔葉撣?瘞游????瘚瑁楝27銋???66000	66000120	24.30578217	120.5925679	04-26113134#725	https://az804957.vo.msecnd.net/photogym/20140724175358_??????jpg	????FREE	0101000020E610000034CAE9A1EC255E4094D983BD474E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
678	?舐???蝐????箏?撣?撅勗??航????108??63000	63000080	24.98931791	121.5404562	02-29322151#123	https://az804957.vo.msecnd.net/photogym/20140728152613_DSC05793_1.jpg	蝐???????擗?,頨脤?	CLOSE	0101000020E6100000E8FA99D596625E400DCC44F043FD3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
679	靽∠儔?葉?啣????箏?撣縑蝢拙??曆?頝?58撌???63000	63000020	25.02961223	121.5678889	02-27236771	https://az804957.vo.msecnd.net/photogym/20140728155005_SANY0272.JPG	?啣???蝐???????擗?	FREE	0101000020E6100000BB50AF4A58645E406169C7AA94073940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
680	瘞??葉????擗?	?箏?撣之????楝銝挾1??63000	63000060	25.0637632	121.5142071	02-25931951#123	https://az804957.vo.msecnd.net/photogym/20140722150932_IMG_7084.JPG	????擗?,?啣耦/?渡??Ｚ????敺??	FREE	0101000020E6100000BE77E5C4E8605E4035B0FAC852103940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
681	憭扳??葉?????箏?撣??镼輸?頝臭?畾?06??67000	67000330	22.9782278	120.2001554	06-2630011#310	https://az804957.vo.msecnd.net/photogym/20140730182907_DSC01761.JPG	????擗?	FREE	0101000020E61000008A479858CF0C5E40BC0919236DFA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
682	隞噸?郭?葉摰文??????箏?撣?敺瑕?靽??葉甇?楝銝畾?85??67000	67000270	22.91920541	120.2287209	06-2662392#12	https://az804957.vo.msecnd.net/photogym/20140731092357_CIMG7287.JPG	????擗?	FREE	0101000020E6100000595AFC5CA30E5E409B41B60B51EB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
683	憭折???璁桀祝擃擗??箔葉撣之??銝??飛摨楝230??66000	66000180	24.22188251	120.6519279	04-25667766	https://az804957.vo.msecnd.net/photogym/20140723144404_IMG_1610.JPG	????擗?	CLOSE	0101000020E61000006676CC2FB9295E402001CC4ACD383840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
684	???葉銝剜迤???箔葉撣????頝?58??66000	66000050	24.15251982	120.6919599	04-22334445#730	https://az804957.vo.msecnd.net/photogym/20140731100420_144552.jpg	????擗?,蝢賜???擗?	CLOSE	0101000020E61000002E292D12492C5E404DE4F6890B273840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
685	憭批???瘣餃?銝剖?	?箏?撣之摰??喳??樴?129??63000	63000030	25.01929509	121.5501541	02-27322332#824	https://az804957.vo.msecnd.net/photogym/20140724131633___ 1 (1).JPG	蝢賜???擗?,????擗?	CLOSE	0101000020E6100000A9D08AB935635E40FC85E485F0043940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
686	???葉?????啣?撣邦????銵?畾?25??65000	65000070	24.95410908	121.3847999	02-26801958#109	https://az804957.vo.msecnd.net/photogym/20140731160506_DSC_0031.JPG	???葉????擗?	FREE	0101000020E61000004380C28FA0585E40A96A1F7E40F43840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
687	憭批?擃極?啣????箏?撣之摰?樴??儔??頝?畾?2??63000	63000030	25.03207447	121.54117	02-27091630#123	https://az804957.vo.msecnd.net/photogym/20140731113532_?.jpg	蝐????啣???蝬脩???擗?,????擗?	CLOSE	0101000020E6100000E2E47E87A2625E40C1AF4F0836083940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
688	撏怠?銝剔敺	?箔葉撣??敹??楝653??66000	66000030	24.13095144	120.6583142	04-23712324#731	https://az804957.vo.msecnd.net/photogym/20140804181351_DSC_0498.JPG	?啣???????擗?,????鈭犖?嗉雲?)	FREE	0101000020E610000084DFE1D1212A5E40032A980886213840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
689	獢?擃葉????擗?	獢?撣?????頝臭?畾?8??68000	68000010	24.99918687	121.3275099	03-3946001#6024	https://az804957.vo.msecnd.net/photogym/20140603102756_IMG_1888.jpg	????FREE	0101000020E6100000706715ECF5545E401B3EF1B5CAFF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
690	憭扳???憸券?	?箏?撣??∪?憭批祚??6銋???67000	67000150	23.15022527	120.1538873	06-7872730	https://az804957.vo.msecnd.net/photogym/20140804095535_DSCF0973.jpg	蝢賜???擗?,????擗?	CLOSE	0101000020E610000043311E4AD9095E40CAAECD2975263740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
691	雿喳?葉瘣餃?銝剖?	撅蝮?蔔?祇????之?楝1??10013	10013210	22.42880632	120.5671781	08-8662041	https://az804957.vo.msecnd.net/photogym/20140721104300_?芸??- 1.jpg	????擗?	CLOSE	0101000020E61000007AA05FA54C245E40D6B74040C66D3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
692	銝剖??葉瘣餃?銝剖?	?儔蝮?葉??銝剖???77??10010	10010130	23.42459713	120.5205935	05-2531002	https://az804957.vo.msecnd.net/photogym/20140612141508_mobileac643ce9-fea9-47ad-b88f-cd01a074a428.jpg	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E6100000A740666751215E405153C365B26C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
693	撏???蝐????箔葉撣之??憭扳?頝?81??66000	66000280	24.11410444	120.6844336	04-24818836#5035	https://az804957.vo.msecnd.net/photogym/20140806143547_蝬??.JPG	????擗?	FREE	0101000020E6100000261296C2CD2B5E40DE20D6F2351D3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
694	暽輯??葉?啣????儔蝮?嘀??暽輯?頝?32??10010	10010110	23.41055059	120.3129825	05-3752037	https://az804957.vo.msecnd.net/photogym/20140624103933_IMGP7526.JPG	?啣???蝐???????擗?,頞喟???FREE	0101000020E61000001A6EC0E707145E404C67EDD719693740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
695	镼踹扈??蝐????箔葉撣正撅臬?镼踹扈頝臭?畾?00??66000	66000060	24.17986422	120.6412876	04-27013534#720	https://az804957.vo.msecnd.net/photogym/20140815202143_IMG_1914.JPG	蝐???頨脤?,????擗?	FREE	0101000020E6100000245525DB0A295E40DC9EDE940B2E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
696	銋??葉蝐???撅蝮??憒??偌頝?6??10013	10013080	22.71808683	120.484845	08-7392404#14	https://az804957.vo.msecnd.net/photogym/20140825095451_蝐???jpg	蝐???????擗?	FREE	0101000020E610000044A852B3071F5E40CF89DA89D4B73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
697	銝??葉瘣餃?銝剖?	?箔葉撣?撅臬?銝?銝銵?7??66000	66000080	24.16730933	120.6978258	04-22313699#730	https://az804957.vo.msecnd.net/photogym/20140828095215_P1090789.JPG	蝢賜???擗?,蝐???????擗?	CLOSE	0101000020E610000086538B2DA92C5E4069AAC4C8D42A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
698	銝??葉蝬??	?箔葉撣?撅臬?銝?銝銵?7??66000	66000080	24.16806235	120.6978071	04-22313699#731	https://az804957.vo.msecnd.net/photogym/20140828101725_P1090793.JPG	蝐???????擗?	FREE	0101000020E6100000AA5A1CDFA82C5E405CF05822062B3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
699	???葉蝐????箏?撣?敺瑕??頝?93??67000	67000270	22.9766287	120.2442241	(06)2703301*14	https://az804957.vo.msecnd.net/photogym/20140721115920_DSC08507.JPG	????擗?	CLOSE	0101000020E610000048991E5EA10F5E40C2D5A65604FA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
700	暽輸陷?葉蝐???敶啣?蝮?嘀皜舫?剖????楝銝挾167??10007	10007020	24.0982248	120.4685962	04-7713846#251	https://az804957.vo.msecnd.net/photogym/20140707100047_ASACREJUHD7R3TPALPTC.jpg	蝐???????擗?	CLOSE	0101000020E6100000E981EA7AFD1D5E40F9A7AF4225193840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
701	???瘣餃?銝剖?	敶啣?蝮??蝢??蔑蝢楝鈭挾210??10007	10007030	24.10938139	120.5022311	04-7552724	https://az804957.vo.msecnd.net/photogym/20140905155021_55.JPG	????擗?	CLOSE	0101000020E61000002F62E98D24205E404DD7346B001C3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
702	??蝧啁??憭批飛?芸撥?????啣?撣楚瘞游?瘛⊿?頝臬?畾?99??65000	65000100	25.2263003	121.4506227	02-28013131#6217	https://az804957.vo.msecnd.net/photogym/20140821075618_?芸撥????1.JPG	????擗?	FREE	0101000020E610000074D59700D75C5E40329303D1EE393940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
703	??蝧啁??憭批飛?芸撥?????啣?撣楚瘞游?瘛⊿?頝臬?畾?99??65000	65000100	25.2263003	121.4506227	02-28013131#6217	https://az804957.vo.msecnd.net/photogym/20140821075621_?芸撥????1.JPG	????擗?	FREE	0101000020E610000074D59700D75C5E40329303D1EE393940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
704	?望絲憭批飛?????箔葉撣正撅臬??箇憭折??挾1727??66000	66000060	24.18114045	120.6043482	(04)23590121	https://az804957.vo.msecnd.net/photogym/20140724150055__MG_5455-3.jpg	????擗?	FREE	0101000020E6100000609912A4AD265E4094BB74385F2E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
705	??葉?啣????箔葉撣??亙??啗?頝?57??66000	66000230	24.1034154	120.6179094	04-23381009	https://az804957.vo.msecnd.net/photogym/20140909094938_IMG_2561.JPG	?啣???????擗?	FREE	0101000020E61000000639DED38B275E401BE7806E791A3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
706	鞊??葉擃擗??箔葉撣???鞊?銵?51??66000	66000090	24.23905526	120.7171994	04-25280185	https://az804957.vo.msecnd.net/photogym/20140905182043_?湧尹憭?(3).JPG	????擗?,皜豢陶瘙?擗?	CLOSE	0101000020E61000007EED4F98E62D5E4004A3BBB9323D3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
707	??怠飛?Ｙ敺	?箏?撣皝?瘞??梯楝?剜挾161??63000	63000100	25.07173247	121.5987504	(02)87923144	https://az804957.vo.msecnd.net/photogym/20140708152207_DSCN4424_compressed.jpg	?啣???頞喟???蝐???蝬脩???擗?,????擗?	CLOSE	0101000020E6100000E29D32ED51665E4018B6240F5D123940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
708	瞏桀??桅?????脤尹	92045撅蝮?蔭撌銝?頝?01??\N	\N	22.54451209	120.5491698	08-7895333	https://az804957.vo.msecnd.net/photogym/20140915153036_9QAXIKIW4DLACWRP0B2V.JPG	????擗?	FREE	0101000020E6100000DBBC169925235E409DD3F224658B3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
709	?撥撌亙?蝐????啣?撣摨???頝?2??65000	65000060	24.98074334	121.5452027	02-29155144	https://az804957.vo.msecnd.net/photogym/20140717110558_20130107801.JPG	蝐???????擗?,?亥澈???恍???蝺游恕)	CLOSE	0101000020E6100000388CDD99E4625E40DF11DBFE11FB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
767	?散?葉瘣餃?銝剖?	?啣?撣?瘣脣?銝剜迤頝?65??65000	65000140	25.08560861	121.4653587	02-22811571#215	https://az804957.vo.msecnd.net/photogym/20140612102141_DSCN2504.JPG	????擗?,蝐???PAID	0101000020E61000002E5ADB6FC85D5E40BE342472EA153940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
710	?葛???啣???敶啣?蝮?嘀皜舫?葉???楝?挾251??10007	10007020	24.10637052	120.4612309	04-7712834#714	https://az804957.vo.msecnd.net/photogym/20140710163946_???游??.jpg	?啣???頨脤?,????擗?	FREE	0101000020E6100000E6D99BCE841D5E4094A830193B1B3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
711	?????箏?撣???摮詨?頝???63000	63000120	25.13517567	121.4693123	02-28927154#2501	https://az804957.vo.msecnd.net/photogym/20141022120149_????jpg	????擗?	FREE	0101000020E610000013077536095E5E4069DD69DF9A223940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
712	????擗??儔蝮?儔蝡寥??啣???7??10010	10010100	23.34071911	120.1926184	05-3427394	https://az804957.vo.msecnd.net/photogym/20141209162406_?脰擗?001.jpg	蝢賜???擗?	FREE	0101000020E6100000E72620DC530C5E407D921A5E39573740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
713	蝢拍姘??蝬??	?儔蝮?儔蝡寥??剜???08??10010	10010100	23.33646348	120.2461767	05-3412203	https://az804957.vo.msecnd.net/photogym/20160509114824_1.jpg	????擗?	FREE	0101000020E610000062E2EA5BC10F5E40FAE57A7822563740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
714	憭扳???憸券?	?儔蝮?之?镼踵??葉甇?楝423??10010	10010040	23.60216041	120.4520752	05-2652061	https://az804957.vo.msecnd.net/photogym/20140611095504_P1030138.JPG	????擗?	PAID	0101000020E61000004AD5D1CCEE1C5E405DE5432F279A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
715	蝢????	??蝮?縑蝢拚?蝢??縑蝑毽銝??3??10008	10008120	23.62787423	120.8706594	049-2831327	https://az804957.vo.msecnd.net/photogym/20140623122604_DSC01612.JPG	?啣耦/?渡??Ｚ????敺??,????擗?,蝐???FREE	0101000020E61000001E3D34E2B8375E40E7D9935DBCA03740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
716	?剔?葉瘣餃?銝剖?	?箏?撣?脣?瘞?銵?3??67000	67000090	23.22469456	120.3505683	06-6982040	https://az804957.vo.msecnd.net/photogym/20140710110750_IMGP0412_憭批?.JPG	????擗?	CLOSE	0101000020E6100000EBE005B66F165E4003CA2A9585393740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
717	鞊??瘣餃?銝剖?	?箔葉撣????啣?頝臭?畾?90??66000	66000090	24.236947	120.7221293	04-25262891#730	https://az804957.vo.msecnd.net/photogym/20140717152940_撘?璅??jpg	??蝢??	CLOSE	0101000020E6100000F0BECF5D372E5E40A4E2FF8EA83C3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
718	銝剖控憟喃葉蝐????箏?撣葉撅勗????摰頝?畾?41??63000	63000040	25.0486025	121.5384248	02-25073148#401	https://az804957.vo.msecnd.net/photogym/20140604113216_DSC09774.JPG	????擗?,蝢賜???擗?,蝐???CLOSE	0101000020E6100000BED64A8D75625E40FC00A436710C3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
719	銝??葉??????	?箏?撣???銝剖控頝臭?畾?12??67000	67000080	23.23788829	120.2722183	06-6891105#131	https://az804957.vo.msecnd.net/photogym/20151002153949_?冽1.jpg	????擗?	FREE	0101000020E6100000DBF74D066C115E40C0A6393FE63C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
720	銝??葉??????	?箏?撣???銝剖控頝臭?畾?12??67000	67000080	23.23810272	120.2719152	06-6891105#131	https://az804957.vo.msecnd.net/photogym/20160606163514_141782.jpg	????擗?	FREE	0101000020E610000042D2020F67115E40187DC34CF43C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
721	???葉?????箏?撣???瘞貉??銋???67000	67000170	23.25262341	120.1279879	06-7862014#14	https://az804957.vo.msecnd.net/photogym/20150812165947_????.jpg	????擗?,????擗?	FREE	0101000020E6100000283229F430085E406D2784EDAB403740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
722	?梯蝮?璁桅?蝡???????梯蝮?璁桅??祆旨????9??10015	10015120	23.81188406	121.4417231	03-8751321#77	https://az804957.vo.msecnd.net/photogym/20160623174238_D:\\backup\\Desktop\\A-Di 璆剖?鞈?\\镼踵?蝬????砍?\\蝬????砍???抒?\\105.01.30皜??脣漲撌∟?\\105.1.30镼踵?蝬????砍?皜?撌∟?_5054.jpg	蝐???????擗?	CLOSE	0101000020E6100000D118F730455C5E40FDD73DA2D7CF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
723	?箏?擃??啣????箏?撣???亙熒頝臭?畾?27??67000	67000330	22.98067848	120.2013892	06-2617123	https://az804957.vo.msecnd.net/photogym/20140529162155_IMAG4288.jpg	頞喟????啣???蝐???????擗?	FREE	0101000020E610000020F1868FE30C5E40B27DAFBE0DFB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
724	???儔摰嗉?????儔撣?擃頝???10020	10020010	23.4714777	120.4587976	05-2259640#1340	https://az804957.vo.msecnd.net/photogym/20160701161339_13582330_1156264597727942_1042427073_o.jpg	????擗?,?啣耦/?渡??Ｚ????敺??	FREE	0101000020E6100000EEDE9BF05C1D5E40164B36C3B2783740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
725	蝐??	撅蝮???蝢????楝23??10013	10013130	22.60399434	120.5611185	08-7799821#8214	https://az804957.vo.msecnd.net/photogym/20160705101745_P1060632.JPG	?蝐???FREE	0101000020E61000008FAB915DE9235E40E444815F9F9A3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
726	?????儔撣正???????280??10020	10020020	23.49494569	120.4273653	05-2374673#120	https://az804957.vo.msecnd.net/photogym/20160707155318_IMG_7524.JPG	???葉????擗?	CLOSE	0101000020E61000007FBCFCF3591B5E409ED8BFC2B47E3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
727	憭??葉蝐????箔葉撣???憭?頝?99??66000	66000210	24.33224805	120.6507987	04-26833721#212	https://az804957.vo.msecnd.net/photogym/20140722132514_DSCN8418.JPG	蝐???????擗?	FREE	0101000020E6100000E03197AFA6295E40E7E84C350E553840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
728	擃?憭批飛瘣芸?撌??誨???恕?抒???	擃?撣?璇?擃?憭批飛頝?00??64000	64000040	22.73140186	120.2797472	07-5919576	https://az804957.vo.msecnd.net/photogym/20140710203557_瘣芸?撌??誨??jpg	蝐???????擗?	PAID	0101000020E610000072C9CC60E7115E40FEEEFC263DBB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
729	???亦?憭批飛擃擗??箏?撣?敺瑕?鈭?頝臭?畾?0??67000	67000270	22.92258258	120.2253878	06-2664911#1220	https://az804957.vo.msecnd.net/photogym/20140616134313_d_20080722144010.jpg	??蝢??	CLOSE	0101000020E6100000B67AF3C06C0E5E4095F5385F2EEC3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
730	撖西???瘣餃?銝剖?	?箏?撣?撅勗?璅?????1畾???63000	63000080	24.98295255	121.557945	02-29360725#135	https://az804957.vo.msecnd.net/photogym/20160818142431_撖血?瘣餃?銝剖?憭1.jpg	蝢賜???擗?,????擗?	CLOSE	0101000020E6100000DFFDF15EB5635E4012C53FC7A2FB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
731	瘞豢??瘣餃?銝剖?	?箏?撣縑蝢拙?瘞豢?撅梯楝225撌?8??63000	63000020	25.04412039	121.5793097	02-27641314#632	https://az804957.vo.msecnd.net/photogym/20160507145555_瘣餃?銝剖?憭?.jpeg	????擗?	CLOSE	0101000020E61000005BF0FD6813655E40032350794B0B3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
732	?脣予蝬??	擃?撣???批??之摮貉楝200??64000	64000350	22.90541182	120.4665363	07-6678888#3261	https://az804957.vo.msecnd.net/photogym/20160830112915_蝐??.jpg	????擗?	CLOSE	0101000020E610000066B911BBDB1D5E40D54FAC11C9E73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
733	瘞詨????????箸蝮?嘀??瘞詨??嘀撖株楝31??10014	10014050	22.9339999	121.1289024	08-9551172	https://az804957.vo.msecnd.net/photogym/20160826151706_Image80.JPG	????擗?	CLOSE	0101000020E61000000F18DAEF3F485E409FF7109E1AEF3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
734	?梯憟喃葉蝐????梯蝮??桀??銵???10015	10015010	23.97869969	121.6163296	03-8321202#133	https://az804957.vo.msecnd.net/photogym/20160504163142_IMG_4296.JPG	蝐???????擗?	CLOSE	0101000020E6100000A2E3B4F171675E40C42719108CFA3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
735	?摰嗅??????脫?蝮???剖???頝?20??10009	10009010	23.70630384	120.547613	05-5322147	https://az804957.vo.msecnd.net/photogym/20160308135434_DSCN3906.JPG	????擗?	FREE	0101000020E6100000537765170C235E40D7D61554D0B43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
736	????瘣餃?銝剖?	?箏?撣皝??望??熒撖扯楝3畾?05??63000	63000100	25.07086404	121.6112781	02-26323477#41	https://az804957.vo.msecnd.net/photogym/20160918170024_IMAG4510.jpg	????擗?,蝢賜???擗?,皜豢陶瘙?擗?	CLOSE	0101000020E6100000B5102E2E1F675E402F434E2524123940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
737	?勗???蝐???撅蝮?皜舫???乩?頝?5??10013	10013030	22.46875715	120.4602277	08-8324927#13	https://az804957.vo.msecnd.net/photogym/20140619104337_IMG_5533.JPG	蝐???????擗?	FREE	0101000020E6100000A70DE25E741D5E402304F57700783640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
738	?摮豢鞎∪?瘜犖?箔葉撣??舫?蝝極璆剛璆剖飛?∠??	?箔葉撣云撟喳??勗像頝?8??66000	66000270	24.13802055	120.7364845	04-23949009#1240	https://az804957.vo.msecnd.net/photogym/20160919093835_???湧尹02.jpg	蝐???????CLOSE	0101000020E6100000B360E28F222F5E400A6D945055233840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
739	?瑕?憭批飛????獢?撣?撅勗???銝頝?59??68000	68000070	25.03510407	121.3906721	03-2118800#2107	https://az804957.vo.msecnd.net/photogym/20140610163655_P6130664 (800x526).jpg	摰文?????FREE	0101000020E61000006B3D8DC500595E40439B9094FC083940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
740	?瑕?憭批飛擃擗?獢?撣?撅勗???銝頝?59??68000	68000070	25.0326019	121.3902912	03-2118800#2107	https://az804957.vo.msecnd.net/photogym/20140609104329_P6130654 (800x600).jpg	蝢賜???????蝐???CLOSE	0101000020E6100000A9FAF087FA585E4097491E9958083940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
741	摰文??????儔撣????蝳?86??10020	10020010	23.48763188	120.4662681	05-2762625	https://az804957.vo.msecnd.net/photogym/20160513192837_IMG_1984-1.jpg	????擗?	FREE	0101000020E6100000C12A2856D71D5E4045166171D57C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
742	憭批??葉摰文?蝐????儔蝮????憭批????2銋???10010	10010050	23.51533324	120.4876989	05-2211651#15	https://az804957.vo.msecnd.net/photogym/20160920114942_DSC_1230.JPG	蝐???擗?	FREE	0101000020E6100000E4727275361F5E407B5714E1EC833740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
743	????憸券?	撅蝮????????楝217??10013	10013170	22.48747535	120.4578652	08-8325896	https://az804957.vo.msecnd.net/photogym/20160510191922_DSC05241.JPG	????擗?	CLOSE	0101000020E61000007FFED6A94D1D5E402DDB3D2FCB7C3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
744	?瑟旨憭批飛擃擗??箏?撣飛隞??瑕之頝???67000	67000280	22.90473979	120.275107	06-2785123#1552	https://az804957.vo.msecnd.net/photogym/20140709163124_967.jpg	蝐???蝢賜???擗?,????擗?,??摰?CLOSE	0101000020E6100000A5F9635A9B115E409E70E1069DE73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
745	摮貊??瘣餃?銝剖?	?箏?撣飛?脣?蝘??3?唬?蝘30??67000	67000130	23.23648592	120.175066	06-7833229	https://az804957.vo.msecnd.net/photogym/20140715155335_DSCN6287.JPG	????擗?	CLOSE	0101000020E61000000F290648340B5E404E5D5C578A3C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
746	???怨風蝞∠?撠?摮豢蝐????箏?撣??銝剖控?梯楝鈭挾1116??67000	67000040	23.27996494	120.3289175	06-6226111#368	https://az804957.vo.msecnd.net/photogym/20140717093119_????JPG	蝐???????CLOSE	0101000020E61000004165FCFB0C155E409C5345C8AB473740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
747	???葉蝬脩?????蝮????銝剖控?蔑?楝237??10008	10008060	23.85350005	120.6780338	04-92732046	https://az804957.vo.msecnd.net/photogym/20160720123717_IMAG4491.jpg	蝬脩???擗?,????擗?	FREE	0101000020E61000004925E1E7642B5E4066E2B1FA7EDA3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
748	?粹??極蝬剜擗??粹?撣??萄??望銵?2??10017	10017020	25.09378992	121.7182589	02-24567126#231	https://az804957.vo.msecnd.net/photogym/20140605153655_P1020272.JPG	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E6100000E6632DF4F76D5E402E18BF9D02183940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
749	敺葛??蝬脩????箏?撣??∪?憭扳蔬?瞏???67000	67000150	23.18348565	120.137279	06-7941305#14	https://az804957.vo.msecnd.net/photogym/20140714144626_DSCN3740.JPG	蝬脩???????擗?	FREE	0101000020E61000005EDBDB2DC9085E400A0962EAF82E3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
750	瘞詨??葉????擗?	擃?撣偶摰?靽?銝頝???64000	64000270	22.82219247	120.2404904	07-6912064#33	https://az804957.vo.msecnd.net/photogym/20140624145219_C:\\Users\\Administrator\\Desktop\\P_20140624_143722.jpg	????擗?	CLOSE	0101000020E610000020C0D831640F5E40DFAAA9347BD23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
751	憭拇??葉?啣????箏?撣ㄚ??憭拙??予瘥頝?20??63000	63000110	25.11695113	121.5378481	02-28754864	https://az804957.vo.msecnd.net/photogym/20170619103731_1AGPNV0GQN4949ZYU4OK.jpg	????蝐???CLOSE	0101000020E6100000CFED6F1A6C625E408B945E82F01D3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
752	擃?擃極????擗?	擃?撣?瘞?撱箏極頝?19??64000	64000050	22.64872483	120.3259242	07-3815366#2252	https://az804957.vo.msecnd.net/photogym/20140605115851_D:\\雓銝\?鞈?\\?蝡??抒?\\憯葬瑼\DSC04281.JPG	????擗?	FREE	0101000020E610000066FE2CF1DB145E4002F498D412A63640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
753	曈交?葉????擃?撣野?曉??曉??毽5銋???64000	64000180	22.66721952	120.371806	07-7323977#22	https://az804957.vo.msecnd.net/photogym/20170626100146_RUKFD2AF8AD6ROI6JMRJ.JPG	????擗?	FREE	0101000020E6100000399D64ABCB175E401FA701E6CEAA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
754	璆??????擃?撣?璇?璆頝?00??64000	64000040	22.72594854	120.3320074	07-3520675#131	https://az804957.vo.msecnd.net/photogym/20170626111040_GNDLRKIVT1ZIM6UFPTM6.jpg	????擗?	FREE	0101000020E6100000EB41F79B3F155E4003E175C3D7B93640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
755	憭芸像?葉?????箔葉撣云撟喳?銝剖控頝臭?畾?16??66000	66000270	24.14864306	120.7340759	04-23922540#124	https://az804957.vo.msecnd.net/photogym/20160506150601_????--s.jpg	????擗?	CLOSE	0101000020E610000008D27B19FB2E5E40357AB9780D263840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
756	撖嗡??葉?啣???擃?撣樴?撖嗡??葉甇?楝137??64000	64000320	23.10943749	120.703032	07-6881258#31	https://az804957.vo.msecnd.net/photogym/20140612153618_?啣???jpg	?啣???憯???蝐???????擗?,蝬脩???FREE	0101000020E6100000A702EE79FE2C5E409F816818041C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
757	曊舀??葉瘣餃?銝剖?	?啣?撣雄甇?撠控?楝108??65000	65000080	24.95083	121.3447022	02-26701461#230	https://az804957.vo.msecnd.net/photogym/20140618090838_DSC04236.JPG	????擗?,蝐???蝢賜???擗?,?啣???CLOSE	0101000020E6100000FEF6D0990F565E40410E4A9869F33840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
758	?漯擃葉?啣????啣?撣?皞芸?璇姘頩???65000	65000250	25.0364461	121.8620306	02-24931028#221	https://az804957.vo.msecnd.net/photogym/20170627141057_TPZAO4UEVKKA48ORV5MV.jpg	蝐???????擗?	PAID	0101000020E6100000AEC964822B775E401691178854093940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
759	蝛??葉?啣????啣?撣葉??瘞?銵?6??65000	65000030	25.00035254	121.4797354	02-22234747#832	https://az804957.vo.msecnd.net/photogym/20170627095840_7XP5EEB4HRNLSQP21120.JPG	?啣???????擗?	CLOSE	0101000020E6100000F16E1BFCB35E5E4042C5A31A17003940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
760	蝢拙飛?葉?????啣?撣陸撅勗?瘞?頝?3??65000	65000160	25.05053872	121.4305651	02-22961168#290	https://az804957.vo.msecnd.net/photogym/20170628093629_13NDR2IERCO0F0V29EOK.jpg	????擗?	FREE	0101000020E610000022D3EB608E5B5E40EA94051BF00C3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
761	蝧?????擃?撣?璇?蝧?頝?35??64000	64000040	22.72930909	120.2992827	07-3683018#133	https://az804957.vo.msecnd.net/photogym/20170628111040_R4W41RGPTHJMBK4VGFA7.JPG	?啣耦/?渡??Ｚ????敺??	FREE	0101000020E61000008D30A07227135E40BC392200B4BA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
762	擃?撣?撅勗?撠◢?函???擃?撣?瞈?樴控??撅梯?62??64000	64000310	22.86446098	120.5559826	07-6833654	https://az804957.vo.msecnd.net/photogym/20160826023334_IMG_1467.JPG	蝐???????擗?	PAID	0101000020E610000048090B3895235E40A3C495504DDD3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
763	甇行蔬??撟喳??憸券?	撅蝮?陸甇阡?撟喳??云?毽1??10013	10013290	22.55608032	120.6361485	08-7851265	https://az804957.vo.msecnd.net/photogym/20140707090321_1404696426724.jpg	蝐???????擗?	FREE	0101000020E610000091B932A8B6285E406659A4475B8E3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
764	???葉蝐???撅蝮????銝剜迤頝?58??10013	10013220	22.33534454	120.3678471	08-8612509#14	https://az804957.vo.msecnd.net/photogym/20160929221911_7ATV8IFBVUXV4I8MRW5J.jpg	????擗?	FREE	0101000020E61000006C1B90CE8A175E403231C823D9553640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
765	瘜啣控擃葉?????啣?撣陸撅勗?颲凋耨頝???65000	65000160	25.05764424	121.4295995	02-22963625#303	https://az804957.vo.msecnd.net/photogym/20170629161150_BQICR5ZXAF2OAWE5AOQF.JPG	????擗?	FREE	0101000020E610000030B8E68E7E5B5E404F9ADDC5C10E3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
766	?勗???蝐?????蝮??瘙??勗???毽36??10008	10008090	23.89069354	120.9668648	04-92880584	https://az804957.vo.msecnd.net/photogym/20140603133639_?抒? 035.jpg	????擗?	FREE	0101000020E6100000D4E9E51CE13D5E40F80EE97D04E43740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
768	銝剛?憭批飛?惇擃?銝剖飛?啣????箔葉撣之???望旨頝?69??66000	66000280	24.10889517	120.6835091	04-24875199#521	https://az804957.vo.msecnd.net/photogym/20140610111356_IMG_20140610_122010[1].jpg	?啣???????FREE	0101000020E61000002DC1F39CBE2B5E40A5D7C98DE01B3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
769	?剝?擃葉??銝剖?	擃?撣樴?蝢拙窄??敺抵楝212??64000	64000320	22.99295548	120.6346786	07-6891023	https://az804957.vo.msecnd.net/photogym/20140530113636_DSCF0364.JPG	A????B蝐???C蝐???D蝐????啣???FREE	0101000020E6100000269EFD929E285E40E6FB905432FE3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
770	?賣眾?極蝐????箏?撣瘝喳?瘞詨???楝528??67000	67000030	23.35491342	120.4176182	06-6852054	https://az804957.vo.msecnd.net/photogym/20140604162043_IMG_1587.jpg	????擗?	FREE	0101000020E6100000B9CDAF41BA1A5E40BFCF1B9BDB5A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
771	?散?葉?????啣?撣?瘣脣?銝剜迤頝?65??65000	65000140	25.08617705	121.4656001	02-22811571#215	https://az804957.vo.msecnd.net/photogym/20170704150449_TPNRSZK9BHKL1YMCFPH2.jpg	蝢賜???擗?	FREE	0101000020E6100000EBA05C64CC5D5E406F6AFBB20F163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
772	?箏???憭批飛????擗?	?箏?撣???摮詨?頝???63000	63000120	25.13650941	121.47443	02-28961000#3663	https://az804957.vo.msecnd.net/photogym/20140609193005_???游??jpg	????擗?	FREE	0101000020E6100000718FA50F5D5E5E40D78BDB47F2223940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
773	?萄祚??蝬脩???擃?撣?摰?蝳株???楝177??64000	64000290	22.73324921	120.2478953	07-6101044	https://az804957.vo.msecnd.net/photogym/20170703094238_WL09BF8Q95MH5IB9YXMK.jpg	????擗?	CLOSE	0101000020E610000041953F84DD0F5E4091C46038B6BB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
774	?控擃葉?啣耦/?渡??Ｚ????敺??	?啣?撣?撅勗?蝢????頝???65000	65000270	25.22477165	121.6374707	02-24982028#410	https://az804957.vo.msecnd.net/photogym/20140611105856_PU17.jpg	????擗?	PAID	0101000020E6100000202AE851CC685E4066D185A28A393940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
775	瘞湧??葉??????蝮?偌??瘞?頝?8??10008	10008110	23.81017791	120.8581104	04-92770134#132	https://az804957.vo.msecnd.net/photogym/20170418145250_F24ACJQXUTV189L2JSBI.JPG	????擗?	CLOSE	0101000020E6100000E116E247EB365E404264CBD167CF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
776	??葉憭??賜???擃?撣??桀?銝剖控銝楝43??64000	\N	22.60402484	120.3075778	07-3331522	https://az804957.vo.msecnd.net/photogym/20140702164815_????jpg	憭??賜???????擗?,頞喟???FREE	0101000020E610000071FECB5AAF135E408AC5355FA19A3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
777	?怠噸?葉瘣餃?銝剖?	獢?撣敺瑕???頝?21??68000	68000080	24.92946653	121.2867022	03-3685322#510	https://az804957.vo.msecnd.net/photogym/20160930120408_NHPBZEFOYY7VI1UNZ6ZG.JPG	????擗?	CLOSE	0101000020E61000003D2C2F5459525E409C13BD84F1ED3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
778	獢??葉????擗?	?箸蝮?辣撟喲?獢???撟唾楝178??10014	10014130	22.90238105	121.0807121	089-561255#13	https://az804957.vo.msecnd.net/photogym/20140620144822_CIMG5286.JPG	????擗?,蝐???FREE	0101000020E61000000E7915632A455E40B747CA7102E73640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
779	?唬葉擃極?????箔葉撣??擃極頝?91??66000	66000030	24.11552925	120.6629598	04-22613158#5200	https://az804957.vo.msecnd.net/photogym/20170714184131_W7WNWZIKRDQ7GA0LLLDO.JPG	????擗?	PAID	0101000020E610000003E4F0EE6D2A5E403E7B2E53931D3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
780	曊舀?撌亙?瘣餃?銝剖?	?啣?撣雄甇?銝剜迤銝楝154??65000	65000080	24.939777	121.3353162	02-26775040#823	https://az804957.vo.msecnd.net/photogym/20140603132504_IMG_8215.JPG	蝐???蝢賜???擗?,????擗?	PAID	0101000020E61000006A3414D275555E407288B83995F03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
781	皞芸????????啣?撣璈?憭扯?頝臭?畾?0撌?0??65000	65000010	24.99687145	121.4314878	02-26869727	https://az804957.vo.msecnd.net/photogym/20170712170859_1Q605T9SKRPRTB6H4GSC.JPG	????擗?	CLOSE	0101000020E6100000DF67017F9D5B5E40EC10A4F732FF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
782	摰文擃擗??啣?撣蝣??舀６頝???65000	65000190	24.98133171	121.6913402	02-26632102#2710	https://az804957.vo.msecnd.net/photogym/20140605164214_DSC_6058(2.jpg	蝐???蝢賜???????CLOSE	0101000020E61000003F5AF7EA3E6C5E404EFA108E38FB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
783	?舀６憭批飛蝐????啣?撣蝣??舀６頝???65000	65000190	24.98167938	121.6930676	02-26632102#2710	https://az804957.vo.msecnd.net/photogym/20140620111204_??2.jpg	蝐???????FREE	0101000020E6100000B4FA34385B6C5E40EF4100574FFB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
784	撏敶梯?蝘?憭批飛摰文?蝬??	?粹?撣縑蝢拙?蝢拐?頝?0??10017	10017070	25.13154122	121.7535889	02-24237785#616	https://az804957.vo.msecnd.net/photogym/20140710113109_IMAG7050[1].jpg	蝐???????CLOSE	0101000020E61000003B08F0CC3A705E40D7F975AFAC213940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
785	撏敶梯?蝘?憭批飛擃擗??粹?撣縑蝢拙?蝢拐?頝?0??10017	10017070	25.13301276	121.7545116	02-24237785#616	https://az804957.vo.msecnd.net/photogym/20140709161122_IMAG7101[1].jpg	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E6100000F89C05EB49705E409426CE1F0D223940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
786	?暹?颲脣極憸券?	?箏?撣獄鞊????????67000	67000070	23.18715937	120.2633214	06-5721137#305	https://az804957.vo.msecnd.net/photogym/20170709175424_GLNDAUWFZLGRDS3VBGE7.JPG	憸券?	FREE	0101000020E610000090550042DA105E403B4A2DADE92F3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
787	?支滬??擃擗?摰蝮?ㄞ???支滬?鈭剛楝81??10002	10002060	24.77122193	121.7984569	03-9301022#206	https://az804957.vo.msecnd.net/photogym/20140611112637_IMAG2093.jpg	????擗?	CLOSE	0101000020E6100000FF30F8EA19735E40D94EE7CC6EC53840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
788	擃?蝘?憭批飛擃擗?擃?撣楝蝡孵?銝剖控頝?821??64000	64000240	22.83902235	120.2678061	07-6077777	https://az804957.vo.msecnd.net/photogym/20140603152232_E:\\銝玨??.PPT\\1-5???蔣-隤脩??批捆........隡?蝟颱?撟渡?銝飛??摮詨?敹耨隤脩?.........撱?瘚愧\Home Work\\?雿平\\_IGP2603.JPG	蝐???蝢賜???擗?,????擗?,蝐???璉???蝬脩???擗?,頞喟???CLOSE	0101000020E6100000D64A32BC23115E40F2DC312BCAD63640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
789	?噸?極?啣???敶啣?蝮?銝剝銝剖?頝臭?畾?77??10007	10007120	23.85280837	120.6087213	04-8753929#122	https://az804957.vo.msecnd.net/photogym/20140609161729_IMG_8974.JPG	皜豢陶瘙?擗?,蝐???????擗?,蝬脩???擗?,頨脤?,?啣???FREE	0101000020E61000003BF82E4AF5265E40B3E73AA651DA3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
790	瘞詨僑擃葉????擗?	?脫?蝮??摨恍撱箏?頝?3??10009	10009050	23.67869226	120.4010046	05-6622540#218	https://az804957.vo.msecnd.net/photogym/20140714133900_S__557079.jpg	????擗?,????擗?	CLOSE	0101000020E6100000EAA2320FAA195E4092BFA4C6BEAD3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
791	?啣?擃葉?????啣?撣???銝縑頝???65000	65000020	25.08819327	121.4916873	02-28577326#127	https://az804957.vo.msecnd.net/photogym/20170710115916_PT7L2B4SFHBCI5HBJNN2.JPG	????擗?	FREE	0101000020E6100000F25602CE775F5E4097608AD593163940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
792	撱箏噸?葉蝐????粹?撣?璅?摰?銝銵?9??10017	10017060	25.12783072	121.722073	02-24321234#31	https://az804957.vo.msecnd.net/photogym/20140609111326_蝐???.JPG	蝐???????擗?	PAID	0101000020E6100000C614AC71366E5E40FAD29983B9203940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
793	?儔?∪?蝐????箏?撣?憭批飛頝???67000	67000320	22.99730416	120.2154547	06-2757575#50385	https://az804957.vo.msecnd.net/photogym/20170706123342_05K4JST604ZSSIOKI787.jpg	蝐???????擗?	FREE	0101000020E61000003F918202CA0D5E40605D4F534FFF3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
794	摰文?憭??賜????儔撣正??唳?頝?01??10020	10020020	23.46407318	120.4388763	05-2855331#250	https://az804957.vo.msecnd.net/photogym/20170905120506_OUFB0QYB7MX8EDQ1X8SM.jpg	璉??恕憭??	FREE	0101000020E610000054DF9E8C161C5E40FC0CFB7FCD763740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
795	瘛⊥?憭批飛鈭?撏????啣?撣楚瘞游??勗?頝?51??65000	65000100	25.1756226	121.4539701	02-26230985	https://az804957.vo.msecnd.net/photogym/20170906110829_XVFP07CO70DPOPJZA30Z.JPG	蝐???????蝬脩???FREE	0101000020E610000029379BD80D5D5E4041704B9AF52C3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
796	瘜唳??葉憸券?????箸蝮?瘝喲???????0??10014	10014070	23.00200392	121.2895138	089-891252#207	https://az804957.vo.msecnd.net/photogym/20140618142647_C:\\Users\\User-PC\\Desktop\\IMG_1471.jpg	蝐???????擗?,蝢賜???擗?	FREE	0101000020E610000067AFE36487525E4022DD325483003740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
797	?唳陸?葉瘣餃?銝剖?	?啣?撣???唳陸頝?59??65000	65000050	25.04252142	121.4441746	02-29960745#501	https://az804957.vo.msecnd.net/photogym/20140612141137_瘣餃?銝剖?1.jpg	?啣???蝐???憸券?,璉????毀蝧	FREE	0101000020E6100000B02D4D5B6D5C5E408C470CAFE20A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
798	擃撌亙?蝬??	擃?撣之撖桀?曈單?銝楝19撌?4??64000	64000140	22.59332489	120.4005271	07-7832991	https://az804957.vo.msecnd.net/photogym/20170919150856_HMHBRJKYSQ84L20YNFNW.jpg	蝐???????擗?	FREE	0101000020E61000005AEA6A3CA2195E40EB73D623E4973640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
799	?瑟擗?摰蝮??皞芷?????撠曇楝160??10002	10002050	24.81624943	121.723752	03-9871000#11252	https://az804957.vo.msecnd.net/photogym/20140704105433_DSC_2457.jpg	?瑟擗?蝢賜???擗?,????擗?	CLOSE	0101000020E6100000899AE8F3516E5E40883AFFB8F5D03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
800	?葉?啣????啣?撣??喳?銝摮?頝???65000	65000120	25.10790188	121.814974	02-24972145#0223	https://az804957.vo.msecnd.net/photogym/20170922092601_OBUTI9J1IJ9E8TWGUIYA.jpg	????擗?,?啣???FREE	0101000020E6100000C845B58828745E40E4C625759F1B3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
801	蝘瘞游?銝剔敶??渡??Ｚ????敺??	敶啣?蝮??瘞湧?摰?葉撅梯楝202??10007	10007070	24.03618968	120.5037342	04-7696031#330	https://az804957.vo.msecnd.net/photogym/20140707102136_IMG_2410.jpg	?啣耦/?渡??Ｚ????敺??,蝐???????擗?	FREE	0101000020E61000001CB85E2E3D205E407E0D14BA43093840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
802	摰蝮????撠??脤尹	摰蝮???梢??楝100??10002	10002020	24.67149462	121.7681587	03-9542156#112	https://az804957.vo.msecnd.net/photogym/20140923220853_003_G.jpg	蝐???蝢賜???擗?,甇西???????擗?	CLOSE	0101000020E6100000D3A81B8329715E4007574812E7AB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
803	?????啁姘撣?隞啣噸頝?1??10018	10018010	24.81215448	121.0027474	03-5711125	https://az804957.vo.msecnd.net/photogym/20170925133721_FZF6OQTI52GQ0XYNI4LO.jpg	????擗?	FREE	0101000020E61000008A496E032D405E405FE6225BE9CF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
804	銝??葉????摰蝮??????????54??10002	10002100	24.66786143	121.6537678	03-9892012#235	https://az804957.vo.msecnd.net/photogym/20170925140343_M5H66C9BBRP271ZN9CWZ.JPG	????擗?	FREE	0101000020E6100000620BE654D7695E401B1C78F7F8AA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
805	銝???摮貊?瘣餃?銝剖?	摰蝮????銝?頝臭?畾?6??10002	10002100	24.6661128	121.6503904	03-9892026#12	https://az804957.vo.msecnd.net/photogym/20140617092741_20140617_091016.jpg	蝐???蝢賜???擗?,頨脤?,????擗?	CLOSE	0101000020E610000079680EFF9F695E406E72535E86AA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
806	銝??葉?????啣?撣???銝?頝臬?畾?16??65000	65000020	25.07634811	121.4867842	02-22879890#623	https://az804957.vo.msecnd.net/photogym/20170926125200_WMR4KF4GLBBFC95596XB.jpg	????FREE	0101000020E610000069CDEA78275F5E40B98FBB8C8B133940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
807	銝剖祚??蝐?????蝮?葉撖桅?瘞詨像?偶撟唾楝316??10008	10008080	23.8800627	120.7637036	049-2691322	https://az804957.vo.msecnd.net/photogym/20170927095730_SUI1MMAJ17W50AW4ZA33.JPG	蝐???頨脤?,????擗?	FREE	0101000020E610000099751085E0305E40F1ED02CA4BE13740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
808	銝剖祚??瘣餃?銝剖?	??蝮?葉撖桅?瘞詨像?偶撟唾楝316??10008	10008080	23.87913733	120.7638484	049-2691322	https://az804957.vo.msecnd.net/photogym/20170927094750_3JNEUFKGXQWX5KH7IS05.JPG	????擗?	CLOSE	0101000020E6100000864666E4E2305E40F20AE1240FE13740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
809	?勗??葉擃擗?摰蝮???梢??楝201??10002	10002020	24.67156745	121.7675471	03-9542603	https://az804957.vo.msecnd.net/photogym/20140610153620_950829.jpg	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E6100000F028DF7D1F715E40E1CE2AD8EBAB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
810	?脣噸撌亙振蝐????箏?撣???亙熒頝?11??67000	67000010	23.31542959	120.3118157	06-6563275#235	https://az804957.vo.msecnd.net/photogym/20140529135614_DSC02604.JPG	????擗?,蝐???CLOSE	0101000020E61000004778D6C9F4135E409E3D5DFEBF503740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
811	銝剜迤?葉擃擗??粹?撣葉甇??銝剛頝?6撌?9??10017	10017010	25.13561826	121.7533582	02-24282191	https://az804957.vo.msecnd.net/photogym/20140611092217_DSC00097.JPG	蝢賜???擗?,蝐???????擗?	PAID	0101000020E610000019CB4F0537705E40C070D7E0B7223940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
812	鈭??葉擃擗?摰蝮??蝯?憭批??之??頝?8??10002	10002090	24.70274359	121.8017721	03-9501105#13	https://az804957.vo.msecnd.net/photogym/20140610142127_DSC04795.JPG	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E61000001816ED3B50735E400D860001E7B33840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
813	擃?擃?????擃?撣??鈭?鈭楝3??64000	64000060	22.62551583	120.3103083	07-2269975	https://az804957.vo.msecnd.net/photogym/20170922171235_P5EAZFE2U122T2SPA5WF.JPG	????擗?	FREE	0101000020E61000005A0B5817DC135E40F5FA30CE21A03640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
814	???葉????擗?	?箏?撣?鈭?憭扳?頝?52??67000	67000230	23.12396968	120.4713053	06-5742214	https://az804957.vo.msecnd.net/photogym/20140715104038_P1250571 (800x600).jpg	????擗?	FREE	0101000020E61000009D7BB4DD291E5E40AB4B197ABC1F3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
815	???蝐????箏?撣??????5銋???67000	67000170	23.30154516	120.1240692	06-7863141#14	https://az804957.vo.msecnd.net/photogym/20140804110016_333.JPG	????擗?	FREE	0101000020E6100000371CF1BFF0075E4093774810324D3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
816	撖嗅控?葉???蝐????啁姘蝮?窄撅勗?銝剛?????\N	\N	24.73652705	121.0258037	03-5761278	https://az804957.vo.msecnd.net/photogym/20170928105723_CCU0MA0KUN4WWS1HJ6R8.JPG	????擗?,蝬脩???擗?,蝐???FREE	0101000020E610000069E78FC4A6415E408E5E68098DBC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
817	憭扳邦??蝬??	擃?撣之璅孵?銝剜迤銝頝?49??64000	64000150	22.68763206	120.4346931	07-6513752	https://az804957.vo.msecnd.net/photogym/20170930154855_U396WNGCXARTK8L48VVH.jpg	????擗?	FREE	0101000020E610000000130203D21B5E40906199A708B03640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
818	鞊怎?撌亙??????啣?撣璈???頝臭?畾?91??65000	65000010	24.99734792	121.4589375	02-29519810#351	https://az804957.vo.msecnd.net/photogym/20140620103055_P1030757.JPG	????擗?	CLOSE	0101000020E61000001D5A643B5F5D5E4035227B3152FF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
819	撏?憟喃葉?	?啣?撣摨?銝?頝?8??65000	65000060	24.97154544	121.5386125	02-29112543#215	https://az804957.vo.msecnd.net/photogym/20160910113937_???jpg	?啣耦/?渡??Ｚ????敺??,蝐???????擗?	CLOSE	0101000020E6100000E02D90A078625E40C060B333B7F83840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
820	?舀???蝐???摰蝮?撅梢??舀????航楝158??10002	10002080	24.67687125	121.7320293	03-9511355#103	https://az804957.vo.msecnd.net/photogym/20140613131641_IMGP3349.JPG	蝐???????擗?,頨脤?	FREE	0101000020E6100000AECD6B91D96E5E40475A2A6F47AD3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
821	撱???????游璅?頞喟??游頨脤?	?啣?撣???摮詨?頝臭?畾?27??65000	65000130	24.98683527	121.4548142	02-22626782#303	https://az804957.vo.msecnd.net/photogym/20170926144458_ZLAPITQEKL7GPAZQDHUV.jpg	璅?頞喟???CLOSE	0101000020E610000069B004AD1B5D5E4078307B3CA1FC3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
822	?寡?葉?????啁姘撣?摮詨?頝???10018	10018010	24.79360136	120.9776044	03-5721301#40	https://az804957.vo.msecnd.net/photogym/20171013163649_MVHMY45KV3YA5JJBYX3U.jpg	????擗?	CLOSE	0101000020E61000003F9B0B12913E5E40D9426F7529CB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
823	蝷漯?葉鈭擗?摰蝮??皞芷?蝷漯頝?畾?3??10002	10002050	24.81665073	121.7666781	03-9882412	https://az804957.vo.msecnd.net/photogym/20140612105119_IMG_8707-1.JPG	蝐???????擗?	CLOSE	0101000020E6100000CD83054111715E40C29AB10510D13840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
824	?葛擃葉?啣????箏?撣?皜臬?镼踵???質楝21??63000	63000090	25.05219512	121.5941628	02-27837863#245	https://az804957.vo.msecnd.net/photogym/20171016133441_0SRI7EWVKLIQQVMLXPCY.jpg	?啣???蝐???????擗?	FREE	0101000020E6100000FD9F68C306665E402A69CDA85C0D3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
825	?賣眾??瘣餃?銝剖?	?箏?撣瘝喳?瘞詨???瘞楝448??67000	67000030	23.35201262	120.4143995	06-6852177	https://az804957.vo.msecnd.net/photogym/20140709152722_DSC_1732.JPG	????擗?,獢???擗?	CLOSE	0101000020E6100000A4FE7A85851A5E40E5ADC27F1D5A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
826	蟡亙???蝐????儔蝮?摮?蟡亙?鈭楝镼踵挾9??10010	10010020	23.456842	120.2878475	05-3621839	https://az804957.vo.msecnd.net/photogym/20140611133540_tn_2.JPG	????擗?	FREE	0101000020E610000010AFEB176C125E407270E998F3743740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
827	?楝???啣????儔蝮?之??楝??31??10010	10010040	23.61059298	120.4221725	05-2694974	https://az804957.vo.msecnd.net/photogym/20140611141041_?楝???啣??游.JPG	?啣???????擗?	FREE	0101000020E61000005131CEDF041B5E40664450D24F9C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
828	蝳??葉瘣餃?銝剖?	獢?撣???撱嗅像頝?26??68000	68000010	24.97684106	121.3129207	03-3669547#314	https://az804957.vo.msecnd.net/photogym/20140611164250_A02-9604-瘣餃?銝剖?.jpg	蝐???????擗?	CLOSE	0101000020E6100000742F8BE406545E400917764112FA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
829	?郭??蝬脩???擗?	?脫?蝮?正?粹暽踹??鞈Ｚ楝1??10009	10009040	23.74735512	120.4651201	05-6341157#046	https://az804957.vo.msecnd.net/photogym/20140609165135_P6090905.jpg	蝬脩???擗?,????擗?	CLOSE	0101000020E6100000958D1887C41D5E40EEE546AA52BF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
830	?勗??瘣餃?銝剖?	?脫?蝮??ａ??勗??璁株楝29撌???10009	10009140	23.67412328	120.256691	05-6991036	https://az804957.vo.msecnd.net/photogym/20140625080559_01.jpg	????擗?,蝐???PAID	0101000020E61000005D8B16A06D105E407F12E15793AC3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
831	銝??葉瘣餃?銝剖?	?箏?撣皝?皝???甈頝?畾?5??63000	63000100	25.06908401	121.586042	02-27924772#257	https://az804957.vo.msecnd.net/photogym/20140804111548_瘣餃?銝剖?.JPG	蝐???蝢賜???擗?,????擗?,皜豢陶瘙?擗?	CLOSE	0101000020E610000047054EB681655E4065A05B7DAF113940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
832	?箏??怠飛憭批飛蝬??	?箏?撣縑蝢拙??唾?銵?50??63000	63000020	25.02602989	121.5613765	02-27361661#2274	https://az804957.vo.msecnd.net/photogym/20140609114740_??2.jpg	蝢賜???擗?,蝐???????擗?	PAID	0101000020E61000008C0FB397ED635E40BB4416E5A9063940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
833	撣怠之?葉????擗?	?箏?撣之摰????縑蝢抵楝3畾?43??63000	63000030	25.03563485	121.5410743	02-27075215#271	https://az804957.vo.msecnd.net/photogym/20140620131653_mobiled563b1d3-6c79-4cf0-a3f3-84e8fed2dad1.jpg	????擗?	CLOSE	0101000020E610000031CD19F6A0625E400E59935D1F093940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
834	??擃葉瘣餃?銝剖?	?梯蝮???銝剛頝?24??10015	10015030	23.34351672	121.3192159	03-8886171#331	https://az804957.vo.msecnd.net/photogym/20140612101458_擃擗?JPG	蝐???????擗?,蝢賜???擗?,?亥澈???恍???蝺游恕),獢???擗?	PAID	0101000020E61000003FB786086E545E40790736B6F0573740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
835	擃?蝘?憭批飛?楷?∪??日?擗?擃?撣?撌Ｗ??瘛曹葉頝?8??64000	\N	22.77260677	120.3988796	07-3814526#13534	https://az804957.vo.msecnd.net/photogym/20160907095522_104617174.jpg	蝐???????擗?	FREE	0101000020E6100000A9424D3E87195E4075D1A98EC9C53640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
836	?梯擃極?啣????梯蝮??桀?摨?頝?7??10015	10015010	23.99872056	121.617955	03-8226108#308	https://az804957.vo.msecnd.net/photogym/20140609112517_YE6KSJMCYMJ2F42STSLN.JPG	?啣???頞喟???????擗?,蝐???FREE	0101000020E610000094D920938C675E40F50A8F26ACFF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
837	?之?噙?????箔葉撣??唬葉頝?83??66000	66000020	24.1285085	120.6852557	04-22810010#303	https://az804957.vo.msecnd.net/photogym/20160815143953_NXFN59E6M8SC7MKQR3Y7.JPG	????擗?	FREE	0101000020E61000007239B93ADB2B5E400DC2DCEEE5203840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
838	擃?擗?憭批飛憭??賣暑?葉敹?擃?撣?皜臬??曉?頝???64000	64000110	22.56604592	120.3719338	07-8060505#1332	https://az804957.vo.msecnd.net/photogym/20140609161444_P6191561.JPG	蝐???蝬脩???擗?,蝢賜???擗?,?啣???????擗?,獢???擗?,?????亥澈???恍???蝺游恕),???恕,頞喟???FREE	0101000020E6100000BAD16CC3CD175E402A6FAA62E8903640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
839	甇?噸擃葉?啣???敶啣?蝮?蔑???踵??蔑瘞渲楝145??10007	10007010	24.05746965	120.5188465	(04)7524109#112	https://az804957.vo.msecnd.net/photogym/20140619163023_?啣???.JPG	?啣???蝐???????擗?,頞喟???CLOSE	0101000020E61000003849F3C734215E403843BB54B60E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
840	?蝘之?????箔葉撣撜啣??陸?梯楝168??66000	66000260	24.0685462	120.7155311	04-23323000#3059	https://az804957.vo.msecnd.net/photogym/20170710105501_YSI7DYGNMVV1FMQ06SQV.JPG	????擗?	FREE	0101000020E61000005771F442CB2D5E40DC43673E8C113840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
841	?蝘之?啣????箔葉撣撜啣??陸?梯楝168??66000	66000260	24.06764986	120.716148	04-23323000#3059	https://az804957.vo.msecnd.net/photogym/20170711093027_8BAR6QLLFZPQ22Z7O9I0.JPG	蝐???????擗?,頝喲???FREE	0101000020E610000022C66B5ED52D5E406B47508051113840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
842	?箇撣怎?憭批飛?啣????怨雲?)	?啣?撣????隞?頝臭?畾???65000	65000170	25.06906943	121.4044833	02-77148466	https://az804957.vo.msecnd.net/photogym/20140605090924_P8200128.JPG	?啣???蝐??游????游?2??頞喟???PAID	0101000020E6100000CD51EC0DE3595E40DC00BF88AE113940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
843	?啣??湧?閮剔???敺?身頞喟??氬敺?身????獢?撣葉憯Ｗ?樴?頝?00??68000	68000020	24.93878675	121.2397313	03-4575200#313	https://az804957.vo.msecnd.net/photogym/20140619152904_DSC04403-1.jpg	蝐???頞喟???????擗?	FREE	0101000020E6100000F754F3C1574F5E400A2B155454F03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
844	蝢拇?擃葉?	?啁姘蝮?姘??銝剜迤镼輯楝15??10004	10004010	24.83908204	121.0042159	03-5552020#149	https://az804957.vo.msecnd.net/photogym/20140611163446_P1060165 (2736 x 1542).jpg	?啣???????擗?,蝐???蝬脩???擗?,頞喟???CLOSE	0101000020E6100000E327C41245405E400276A014CED63840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
845	?控?葉?啣???擃?撣?撅勗?憭批噸?葉摮貉楝42??64000	64000300	22.8807746	120.4810349	07-6612650#214	https://az804957.vo.msecnd.net/photogym/20140619145104_IMG_1791.jpg	????擗?,蝐????啣???頞喟???FREE	0101000020E610000004EF9A46C91E5E40C125B6717AE13640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
846	?里?葉?啣???獢?撣???憭扯?頝?22??68000	68000010	25.01688641	121.3132453	03-3551496#511	https://az804957.vo.msecnd.net/photogym/20140626140942_IMG_0087.JPG	擃?賢頨怠?,蝐???????頞喟???FREE	0101000020E61000000CC803360C545E4065B2F2AA52043940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
847	??葉擃擗函??	?粹?撣??????唾楝132??10017	10017040	25.12343195	121.7506278	02-24223120#30	https://az804957.vo.msecnd.net/photogym/20140618094852_DY5Z78LOR8TL028T5EED.jpg	蝐???????擗?	FREE	0101000020E6100000FB1D2F490A705E4011887C3C991F3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
848	鈭散憭批飛擃擗??箔葉撣撜啣??唾?頝?00??66000	66000260	24.04825942	120.6874323	04-23323456#3241	https://az804957.vo.msecnd.net/photogym/20140708145356_1253.jpg	蝐???蝢賜???擗?,????擗?,?餃??恕,???摰?頞喟????啣???CLOSE	0101000020E6100000B3AD0BE4FE2B5E40BA9FB6BA5A0C3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
849	憭找??葉????擃?撣???撱箏?銝頝?48??64000	6400800	22.63447886	120.3297605	07-7114302#71	https://az804957.vo.msecnd.net/photogym/20180607122238_WMJ7ONIOMIWHT5YKYTD5.jpg	????擗?	FREE	0101000020E6100000CFC0C8CB1A155E4010B4E1346DA23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
850	??葉????擃?撣?????賡?膨瘚瑁楝?挾29??64000	64000260	22.90675588	120.1807094	07-6900054#31	https://az804957.vo.msecnd.net/photogym/20160831175022_1.jpg	?啣???蝐???????擗?,璈??(?臬?撘?甈???	FREE	0101000020E61000001BC528BE900B5E40420E422721E83640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
851	?腹??瘣餃?銝剖?	?箏?撣???銝剖亢?楝4畾?81??63000	63000120	25.12660924	121.4662613	02-28975205	https://az804957.vo.msecnd.net/photogym/20140731121328_DSC028030000.jpg	蝢賜???擗?,蝐???????擗?,皜豢陶瘙?擗?	PAID	0101000020E6100000FDB8A239D75D5E40E22B917669203940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
852	撠葛擃葉?啣???擃?撣?皜臬?摮詨?頝?17??64000	64000110	22.56474966	120.3557825	07-8062627#206	https://az804957.vo.msecnd.net/photogym/20140612103419_P1210802.JPG	?啣???蝐???,????擗?,蝬脩???擗?,蝐???,頞喟???FREE	0101000020E61000004E7FF623C5165E408B20086F93903640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
853	????瘣餃?銝剖?	獢?撣?璇?璇漯????99??68000	68000040	24.91067872	121.1718207	03-4825284#520	https://az804957.vo.msecnd.net/photogym/20190423124045_EM31SMSKV03TE40P7GH7.JPG	蝐???蝢賜???擗?,????擗?	CLOSE	0101000020E6100000A7D13F1CFF4A5E402A90973D22E93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
854	瘞賊?擃極瘣餃?銝剖?	敶啣?蝮?偶??瘞詨??偶?∟楝101??10007	10007160	23.92616994	120.54461	04-8221810#515	https://az804957.vo.msecnd.net/photogym/20140620145027_01 (憭批?).JPG	蝢賜???擗?,蝐???璉????毀蝧,????擗?,蝝??	FREE	0101000020E6100000C6C4E6E3DA225E409AD6227919ED3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
855	憭抒姘???啣耦/?渡??Ｚ????敺??	敶啣?蝮?蔑??敶啣?頝臭?畾?64撌?1??10007	10007010	24.08289661	120.5800688	04-7381436	https://az804957.vo.msecnd.net/photogym/20140707103937_P1040736.jpg	?啣???蝐???頨脤?,????擗?	FREE	0101000020E6100000855BE3D81F255E4036E654B638153840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
856	???????擗?	撅蝮???勗???撌?2??10013	10013010	22.68017322	120.4858804	08-7652038	https://az804957.vo.msecnd.net/photogym/20140618154802_IMG_6760.JPG	????擗?	PAID	0101000020E61000001DF11AAA181F5E40D88307D51FAE3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
857	銝剛?擃葉????擗?	??蝮????銝剛??唳?銝剖飛頝???10008	10008010	23.95047895	120.6961226	049-2331014	https://az804957.vo.msecnd.net/photogym/20140603094411_10409446_10202373800726141_7629426621647111052_n.jpg	????擗?	FREE	0101000020E61000006A40CE458D2C5E4053C9A59652F33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
858	?怠噸?葉?	獢?撣敺瑕???頝?21??68000	68000080	24.92965214	121.2871705	03-3685322#510	https://az804957.vo.msecnd.net/photogym/20190507090751_KBATN7S3P2H9MYX5KHWG.jpg	蝐???????CLOSE	0101000020E61000001078600061525E40D8F4C1AEFDED3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
859	?湔????啣????儔蝮?漯????湔???07??10010	10010060	23.60677369	120.3706554	05-2691440	https://az804957.vo.msecnd.net/photogym/20140604093451_1MJQ44PQMLAWDQBRZVEA.JPG	蝐???????擗?,?啣耦/?渡??Ｚ????敺??	FREE	0101000020E61000007E456DD1B8175E408D9F4285559B3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
860	敺抵??葉????摰蝮???剖?敺抵?頝臭?畾?7??10002	\N	24.74901384	121.7471784	03-9322942#5033	https://az804957.vo.msecnd.net/photogym/20190508152908_K28876OQ5XMO13QNS1T0.JPG	????擗?	FREE	0101000020E6100000C4115AC5D16F5E40270DFB5EBFBF3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
861	撏????	撅蝮???樴????楝6??10013	10013130	22.66691756	120.6000566	08-7701004	https://az804957.vo.msecnd.net/photogym/20181025162631_YS1OKAQP45IP213KG3MZ.jpg	蝐????啣???????擗?	CLOSE	0101000020E6100000EF2FCC5367265E400054F51BBBAA3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
862	憭扳??葉蝐????箏?撣偶摨瑕??望???1??67000	67000310	23.02341598	120.2308184	06-3021793	https://az804957.vo.msecnd.net/photogym/20140716093142_IMAG2271.jpg	蝐???????擗?	FREE	0101000020E61000002AD489BAC50E5E40C54DF496FE053740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
863	憸券?	?啣?撣?撜賢?敺抵?頝?38??65000	65000090	24.94110331	121.3699681	02-26711043#136	https://az804957.vo.msecnd.net/photogym/20190516094143_224VOZVRIISK0TP8WON1.jpg	????擗?	PAID	0101000020E61000000C84AE8EAD575E407B9B8225ECF03840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
864	?批??葉?	撅蝮?????頝?62??10013	10013130	22.61087128	120.5703592	08-7792013#34	https://az804957.vo.msecnd.net/photogym/20140619100122_20160923_102345_Richtone(HDR).jpg	?啣???????蝐???蝬脩???頞喟???FREE	0101000020E610000041BEDFC380245E4069AA690F629C3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
865	??擃葉????擃?撣?撅勗??勗像?邦鈭箄楝21??64000	64000300	22.8860262	120.4933104	07-6612502#350	https://az804957.vo.msecnd.net/photogym/20190515210440_H5VJJ4P5I6LIR5L9596U.jpg	????擗?	CLOSE	0101000020E6100000B5B1C865921F5E402F66F09CD2E23640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
866	?祚擃葉擃擗?撅蝮??撖桅??圈??儔瘞楝3??10013	10013160	22.37061958	120.5903524	08-8782095	https://az804957.vo.msecnd.net/photogym/20140715114906_IMG_9649.JPG	????CLOSE	0101000020E61000005EC76E55C8255E40755BBFECE05E3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
867	???撠飛蝬?擗??啣?撣璈?撱??銵?1??65000	65000010	24.995126	121.4625156	02-29565592#305	https://az804957.vo.msecnd.net/photogym/20140619175326_擃擗典??JPG	皜豢陶瘙?擗?,蝬??,?,?亥澈???恍???蝺游恕),????擗?	CLOSE	0101000020E6100000F3F807DB995D5E403866D993C0FE3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
868	銝???蝐??	?箸蝮???銝??蝧祈楝?恍16??10014	10014020	23.11978994	121.3938886	089-851960#22	https://az804957.vo.msecnd.net/photogym/20140612091020_1XAIM8QKU3DNFKLNO8YS.jpg	蝐???FREE	0101000020E61000001AD1877835595E4097B0B28DAA1E3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
869	璆??葉????獢?撣?璇??啗噙銵?37??68000	68000040	24.91124817	121.1548367	03-4781525#501	https://az804957.vo.msecnd.net/photogym/20140618215419_WUBWRI86SWVH2ZZK9UW4.jpg	????擗?	FREE	0101000020E61000001EAE30D8E8495E409AB0608F47E93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
870	蝳?擃葉瘣餃?銝剖?	擃?撣陶撅勗?鈭銝楝176??64000	64000120	22.58982327	120.3227806	07-8224646#400	https://az804957.vo.msecnd.net/photogym/20170628152506_8L0XJFURQERES6CHOBP0.jpg	????擗?	PAID	0101000020E61000002132F66FA8145E40DD1167A8FE963640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
871	?勗??葉擃擗?獢?撣像?桀?撟單頝?68??68000	68000100	24.91694773	121.2493497	03-4601407#311	https://az804957.vo.msecnd.net/photogym/20140619080142_IMG_20140618_114131-1.jpg	????擗?	FREE	0101000020E61000001DB17158F54F5E40CF7D2016BDEA3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
872	銝剖祚?葉蝐?????蝮?葉撖桅?敺抵???銝剖毽50??10008	10008080	23.8829094	120.7669061	049-2691247	https://az804957.vo.msecnd.net/photogym/20140604125328_100_3938.jpg	蝐???????擗?	FREE	0101000020E610000096A652FD14315E40BB54B65906E23740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
873	隞郎擃葉蝬??	擃?撣?甇血?隞?頝?0??64000	64000170	22.70290346	120.3550662	07-3721640#213	https://az804957.vo.msecnd.net/photogym/20190530162037_EXP8X4MPPYZIHK0ZIBVL.jpg	????擗?	FREE	0101000020E61000008F3A9567B9165E40FCF12C7BF1B33640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
874	????瘣餃?銝剖?	?脫?蝮??皝????葉撅望頝?7??10009	10009180	23.63683343	120.2292573	05-7872100	https://az804957.vo.msecnd.net/photogym/20140624111932_C:\\Documents and Settings\\Administrator\\獢\\1.jpg	????擗?	CLOSE	0101000020E6100000A277CF26AC0E5E4079D9028407A33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
875	銝???瘣餃?銝剖?	?箏?撣撅勗????甈頝臭?畾???63000	63000010	25.06393328	121.5645683	02-27646080#222	https://az804957.vo.msecnd.net/photogym/20140728151559_100?∪?憸冽 (61).JPG	????擗?,?啣???CLOSE	0101000020E6100000EF3614E321645E40DCB972EE5D103940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
876	?箏?憭批飛銝剖控擃擗??箏?撣葉镼踹?璅寞?銵?畾?3??67000	67000370	22.98414045	120.2071613	06-2133111#341	https://az804957.vo.msecnd.net/photogym/20140529155846_Q84RQ86PSO9N70CFBWU5.jpg	蝢賜???擗?,????擗?,蝐???CLOSE	0101000020E6100000CC1F7821420D5E40B56BE7A0F0FB3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
877	擃?蝘?憭批飛撱箏極?∪?擃擗?擃?撣?瘞?撱箏極頝?15??64000	64000050	22.64997736	120.3279412	07-3814526#13536	https://az804957.vo.msecnd.net/photogym/20140625141902_photo (4).JPG	蝢賜???擗?,????擗?,?亥澈???恍???蝺游恕),獢???擗?,???恕	CLOSE	0101000020E6100000B44016FDFC145E40265790EA64A63640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
878	?勗擃極瘣餃?銝剖?	?箔葉撣?Ｗ??梢?頝?畾?328??66000	66000100	24.24270915	120.8341974	04-25872136#207	https://az804957.vo.msecnd.net/photogym/20140605164311_?唳?蝛箇??靽格1嚗?jpg	????擗?	PAID	0101000020E610000020DA7D7D63355E40A1B0D52F223E3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
879	?箏?撣???敺琿?銝剔?????	?箏?撣縑蝢拙?敹??梯楝鈭挾790撌?7??63000	63000020	25.04198923	121.5835235	02-27265775#124	https://az804957.vo.msecnd.net/photogym/20170905175711_F2GM6RJCFDOB7N8A00ZU.jpg	蝐???????CLOSE	0101000020E6100000A33CF37258655E405CA261CEBF0A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
880	??擃葉?啣????箏?撣??銝剛?頝?2??67000	67000010	23.29848351	120.314219	06-6335408#123	https://az804957.vo.msecnd.net/photogym/20140715181002_DSC03617.JPG	?啣???蝐???????擗?,?亥澈???恍???蝺游恕),蝬脩???擗?,獢???擗?	CLOSE	0101000020E61000000932022A1C145E4065D8516A694C3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
881	撱箏?銝剖飛瘣餃?銝剖?	?箏?撣葉甇??樴???瘚瑁楝56??63000	63000050	25.02953932	121.5126085	02-23034381	https://az804957.vo.msecnd.net/photogym/20140605085653_瘣餃?銝剖?.jpg	蝐???????擗?,皜豢陶瘙?擗?,蝢賜???擗?	CLOSE	0101000020E6100000B4C9E193CE605E4099588DE38F073940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
882	??蝘?憭批飛蝐????梯蝮??桀?撱箏?頝臭?畾?80??10015	10015010	23.99831418	121.5648271	03-8572158#2356	https://az804957.vo.msecnd.net/photogym/20140606184101_DSC00245.jpg	蝐???????擗?	CLOSE	0101000020E61000004099902026645E40AA3BA28491FF3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
883	撟喲?葉?啣???獢?撣像?桀??啣???楝2??68000	68000100	24.94448401	121.2182468	03-4572150#328	https://az804957.vo.msecnd.net/photogym/20140616112616_10464052_10202512077228811_936294471509006369_n (960x720).jpg	?啣???????蝐???FREE	0101000020E61000003A1D6DC1F74D5E40818B3EB4C9F13840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
884	瘞??葉?啣???擃?撣?瘞?閬箸?頝?63??64000	64000050	22.63871904	120.3327155	07-3818718#20	https://az804957.vo.msecnd.net/photogym/20140703142923_IMG_4730.JPG	蝐???蝬脩???擗?,????擗?,頞喟???FREE	0101000020E6100000D4D7F3354B155E40ED214C1783A33640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
885	瘞貉?擃葉????獢?撣敺瑕?瘞貉?頝?09??68000	68000080	24.97531266	121.2690037	03-3692679#312	https://az804957.vo.msecnd.net/photogym/20140619111411_1403139606815.jpg	頞喟???????擗?,蝐????啣???PAID	0101000020E610000031804B5B37515E4024132A17AEF93840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
886	????敺控?	?箏?撣?皜臬???????1畾?00??63000	63000090	25.03915122	121.6191273	02-27821418#130	https://az804957.vo.msecnd.net/photogym/20140725105441_C745A1GLNSXEA1HR856F.JPG	蝐???頨脤?,?啣???????擗?	CLOSE	0101000020E6100000E4631CC89F675E409E7F79D0050A3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
887	?剖?擃葉?啣???獢?蝮?像?桀??詨?頝?80??\N	\N	24.94546691	121.1858912	03-4204000#205	https://az804957.vo.msecnd.net/photogym/20190304111354_JWS54N7GZZPE6FFARQN3.jpg	?啣???頞喟???????擗?	CLOSE	0101000020E61000004F2734A4E54B5E4072E6911E0AF23840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
888	銝???蝬脩???擗?	?儔蝮?之?銝剛?頝臭?畾?37??10010	10010040	23.60537033	120.4872408	05-2949120#04	https://az804957.vo.msecnd.net/photogym/20140612112846_P1090516-400.jpg	蝬脩???擗?,蝬脩???CLOSE	0101000020E6100000B85109F42E1F5E409851C98CF99A3740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
889	?旨?葉?啣????箔葉撣之???望旨頝?80??66000	66000280	24.11124008	120.6876361	04-24831428#163	https://az804957.vo.msecnd.net/photogym/20140909095332_IMG_0017.JPG	?啣???蝐???????擗?,????擗?	CLOSE	0101000020E61000002343D83A022C5E40BC9AD93A7A1C3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
890	?寞??極????擗?	獢?撣?瞏剖?銝??葉?楝銝畾?0??68000	68000090	24.8574981	121.2011129	03-4796345#312	https://az804957.vo.msecnd.net/photogym/20140616121448_13392.jpg	????擗?	CLOSE	0101000020E61000007013A408DF4C5E40D4E1D7FE84DB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
891	?箏?撣?撖西??葉瘣餃?銝剖?	?箏?撣?撅勗?璅???鈭亥楝銝挾67??63000	63000080	24.98342988	121.5547782	02-22362857#150	https://az804957.vo.msecnd.net/photogym/20160513123637_擃擗典??(1).JPG	蝐???蝢賜???擗?,??????蝐???FREE	0101000020E610000029626C7C81635E405B82840FC2FB3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
892	敹??葉蝬??	?箏?撣之?????正撖批?頝?2??63000	63000060	25.05099719	121.5076894	02-25524890	https://az804957.vo.msecnd.net/photogym/20170908193846_U4HAR6HSVGWUX1NBG6BF.JPG	蝐???????擗?	FREE	0101000020E6100000A861AEFB7D605E40E73CDF260E0D3940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
893	????瘣餃?銝剖?	?箔葉撣之??镼踵??正皝楝32??66000	66000280	24.07826352	120.6899267	04-24953078	https://az804957.vo.msecnd.net/photogym/20140718154219_DSC_0004.JPG	????擗?,蝢賜???擗?	CLOSE	0101000020E6100000C84851C2272C5E40AEDEFA1309143840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
894	?啣???蝐???擃?撣椰???臬?頝?00??64000	64000030	22.68018807	120.3057057	07-3438577#212	https://az804957.vo.msecnd.net/photogym/20140625163506_蝐?1.jpg	蝐???????擗?	FREE	0101000020E6100000DAECA3AE90135E4084C72BCE20AE3640	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
895	?臬?憭批飛蝚砌?(鈭撅??∪?瘣餃?銝剖?3F擃擗???蝮?????剜?憭???10005	10005010	24.54607804	120.8126829	03-7381273	https://az804957.vo.msecnd.net/photogym/20140530103330_瘣餃?銝剖?擃擗?.JPG	蝐???????擗?,蝢賜???擗?	CLOSE	0101000020E61000002E6123FF02345E4021DD3AC5CB8B3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
896	?臬?憭批飛蝚砌?(鈭撅??∪??啣?????蝮?????剜?憭???10005	10005010	24.54587798	120.8135412	03-7381273	https://az804957.vo.msecnd.net/photogym/20140530170938_200?砍偕頝????.JPG	?啣???????FREE	0101000020E6100000B6FC1B0F11345E40E0B4C7A8BE8B3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
897	?臬?憭批飛蝚砌?(?怎)?∪?憸券?	??蝮??????憭???10005	10005010	24.5356288	120.7918024	03-7381273	https://az804957.vo.msecnd.net/photogym/20160721194336_f1425521704121.jpg	蝐???????擗?	FREE	0101000020E61000003C39F9E3AC325E40B5CB12F81E893840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
898	銝剛???撠飛瘣餃?銝剖?	?粹?撣縑蝢拙?靽∩?頝?0??10017	10017070	25.13086129	121.7571563	02-24225038#30	https://az804957.vo.msecnd.net/photogym/20140618115830_DSC_0030.JPG	蝢賜???擗?,蝐???????擗?	FREE	0101000020E6100000779DB23F75705E40C4DC202080213940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
899	?舀???瘣餃?銝剖?	?箏?撣?臬??唳眾?楝2畾?50撌?2撘???63000	63000070	25.03419725	121.4912498	02-23064352#134	https://az804957.vo.msecnd.net/photogym/20140722092316_DSC_0273.JPG	蝢賜???擗?,????擗?	PAID	0101000020E6100000A94A00A3705F5E40F65CA626C1083940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
900	撣??潸?葉蝬?蝐????箏?撣ㄚ???賣??趕敺瑕之??畾?5??63000	63000110	25.13086964	121.5464429	02-28610079#109	https://az804957.vo.msecnd.net/photogym/20160506153026_S__24371266.jpg	蝐???擗?	CLOSE	0101000020E61000006928A4EBF8625E40DCD637AC80213940	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
901	蝳擃葉	?脫?蝮???暻餃??像??3??10009	10009070	23.63683941	120.5242144	05-5828222#6422	https://az804957.vo.msecnd.net/photogym/20180803104350_JZYMC1YEQ2NZ6F5KQI1Q.jpg	????擗?	CLOSE	0101000020E6100000E8058EBA8C215E4002C156E807A33740	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
902	銝憭批飛擃擗??箏?撣?撅勗??冽頝臭?畾?7撌???63000	63000080	24.98986033	121.5454119	02-22368225#83078	https://az804957.vo.msecnd.net/photogym/20140604122953_摰文??s.jpg	蝐???蝢賜???擗?,????擗?,獢???擗?,????擗????恕,擃?賭葉敹?(?恍???蝺游恕)	PAID	0101000020E61000005A565007E8625E4030F5907C67FD3840	2021-05-02 13:37:42.012715	2021-05-02 13:37:42.012715
\.


--
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file (file_id, file_name, tag, file_url, created_by, reference_id, is_public, description, meta, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game (game_id, game_name, host_user_id, game_start_at, game_end_at, sell_start_at, sell_end_at, total_player_number, court_type, game_type, description, game_status, meta, is_public, deleted, created_at, updated_at, court_id) FROM stdin;
\.


--
-- Data for Name: game_stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_stock (game_stock_id, game_id, spec_name, stock_amount, price, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: game_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_ticket (game_ticket_id, game_id, game_stock_id, owner_user_id, game_ticket_status, "isPaid", meta, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: game_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_user (game_ticket_id, game_stock_id, game_id, game_user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (user_id, profile_name, email, gender, phone, password, user_status, user_role, description, meta, created_at, updated_at) FROM stdin;
ec27f218-1f68-46e6-bc4d-d12b34c21fdf	tom lee	xu3cl40122@gmail.com	MALE	\N	$2b$10$u7VXPObZq/QULXlTzRS.IOU.biQMqyZaGyFg3zhKVsIHpTIoKcMTa	ENABLED	NORMAL_USER	\N	{}	2021-05-02 12:00:48.141589	2021-05-02 12:01:24.39289
\.


--
-- Data for Name: verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.verification (verification_id, verification_code, verification_type, expires_at, created_at, updated_at, "userIdUserId") FROM stdin;
274f5025-0773-4989-9623-c3ccbc246c60	274075	ENABLE_ACCOUNT	2021-05-02 12:05:48.209	2021-05-02 12:00:48.210981	2021-05-02 12:00:48.210981	ec27f218-1f68-46e6-bc4d-d12b34c21fdf
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: court_court_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.court_court_id_seq', 1, false);


--
-- Name: file PK_37d2332c95c19b4882bdab5e261; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT "PK_37d2332c95c19b4882bdab5e261" PRIMARY KEY (file_id);


--
-- Name: game_ticket PK_53d1666c72d9c3c7bad2ef01ed6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_ticket
    ADD CONSTRAINT "PK_53d1666c72d9c3c7bad2ef01ed6" PRIMARY KEY (game_ticket_id);


--
-- Name: game PK_5b09eea8ea244730f3f339e3152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT "PK_5b09eea8ea244730f3f339e3152" PRIMARY KEY (game_id);


--
-- Name: user PK_758b8ce7c18b9d347461b30228d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_758b8ce7c18b9d347461b30228d" PRIMARY KEY (user_id);


--
-- Name: verification PK_9e7eb9e23e11af4d8a03ee7ceca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification
    ADD CONSTRAINT "PK_9e7eb9e23e11af4d8a03ee7ceca" PRIMARY KEY (verification_id);


--
-- Name: game_stock PK_d93d35c22ac203a45bbd6ecb75f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_stock
    ADD CONSTRAINT "PK_d93d35c22ac203a45bbd6ecb75f" PRIMARY KEY (game_stock_id);


--
-- Name: court PK_e84cace66755aeecf2ef3ab8832; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.court
    ADD CONSTRAINT "PK_e84cace66755aeecf2ef3ab8832" PRIMARY KEY (court_id);


--
-- Name: game_user PK_f5ed62c7391f1108378c27ba6ed; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_user
    ADD CONSTRAINT "PK_f5ed62c7391f1108378c27ba6ed" PRIMARY KEY (game_ticket_id);


--
-- Name: user UQ_e12875dfb3b1d92d7d7c5377e22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE (email);


--
-- Name: game_user UQ_f5ed62c7391f1108378c27ba6ed; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_user
    ADD CONSTRAINT "UQ_f5ed62c7391f1108378c27ba6ed" UNIQUE (game_ticket_id);


--
-- Name: game FK_0f239f21b330ce2dd367cefebdc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT "FK_0f239f21b330ce2dd367cefebdc" FOREIGN KEY (host_user_id) REFERENCES public."user"(user_id);


--
-- Name: verification FK_141fc5b4b87e3235562d1890f8f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification
    ADD CONSTRAINT "FK_141fc5b4b87e3235562d1890f8f" FOREIGN KEY ("userIdUserId") REFERENCES public."user"(user_id);


--
-- Name: game_ticket FK_340bc11e60f77a655399aa39612; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_ticket
    ADD CONSTRAINT "FK_340bc11e60f77a655399aa39612" FOREIGN KEY (game_stock_id) REFERENCES public.game_stock(game_stock_id);


--
-- Name: game_ticket FK_64860f6eb2bace145f118fb75c8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_ticket
    ADD CONSTRAINT "FK_64860f6eb2bace145f118fb75c8" FOREIGN KEY (game_id) REFERENCES public.game(game_id);


--
-- Name: game FK_70770718037f17dfbd3eb522f4b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT "FK_70770718037f17dfbd3eb522f4b" FOREIGN KEY (court_id) REFERENCES public.court(court_id);


--
-- Name: game_ticket FK_8787b1257cafee444c5fdaea308; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_ticket
    ADD CONSTRAINT "FK_8787b1257cafee444c5fdaea308" FOREIGN KEY (owner_user_id) REFERENCES public."user"(user_id);


--
-- Name: game_user FK_89a578784008cdc27989250cfea; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_user
    ADD CONSTRAINT "FK_89a578784008cdc27989250cfea" FOREIGN KEY (game_user_id) REFERENCES public."user"(user_id);


--
-- Name: game_stock FK_aff064f3d81a9c2bac1072360cc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_stock
    ADD CONSTRAINT "FK_aff064f3d81a9c2bac1072360cc" FOREIGN KEY (game_id) REFERENCES public.game(game_id);


--
-- Name: game_user FK_c70af6a37a797e2eb30892e8295; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_user
    ADD CONSTRAINT "FK_c70af6a37a797e2eb30892e8295" FOREIGN KEY (game_stock_id) REFERENCES public.game_stock(game_stock_id);


--
-- Name: game_user FK_f5ed62c7391f1108378c27ba6ed; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_user
    ADD CONSTRAINT "FK_f5ed62c7391f1108378c27ba6ed" FOREIGN KEY (game_ticket_id) REFERENCES public.game_ticket(game_ticket_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template_postgis; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template_postgis WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template_postgis OWNER TO postgres;

\connect template_postgis

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template_postgis; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template_postgis IS_TEMPLATE = true;
ALTER DATABASE template_postgis SET search_path TO '$user', 'public', 'tiger';


\connect template_postgis

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO postgres;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO postgres;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

