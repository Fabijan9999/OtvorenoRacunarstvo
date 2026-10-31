--
-- PostgreSQL database dump
--

\restrict cebsBmyhlvlOxG4nvu2EumweUnRNjrSgIq9DsNcl1bv3ze41TG16MqyCfKLZcC5

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-10-31 16:07:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 224 (class 1259 OID 20333)
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor (
    actorid integer NOT NULL,
    firstname character varying(100) NOT NULL,
    lastname character varying(100) NOT NULL,
    country character varying(100) NOT NULL
);


ALTER TABLE public.actor OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 20332)
-- Name: actor_actorid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.actor ALTER COLUMN actorid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.actor_actorid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 20304)
-- Name: director; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.director (
    directorid integer NOT NULL,
    firstname character varying(100) NOT NULL,
    lastname character varying(100) NOT NULL
);


ALTER TABLE public.director OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 20303)
-- Name: director_directorid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.director ALTER COLUMN directorid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.director_directorid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 20343)
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    genreid integer NOT NULL,
    genrename character varying(100) NOT NULL
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 20342)
-- Name: genre_genreid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.genre ALTER COLUMN genreid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.genre_genreid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 20313)
-- Name: movie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie (
    movieid integer NOT NULL,
    title character varying(255) NOT NULL,
    releasedate date NOT NULL,
    durationminutes integer NOT NULL,
    agerestriction integer NOT NULL,
    rating numeric(3,1) NOT NULL,
    originallanguage character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    directorid integer NOT NULL,
    CONSTRAINT chk_movie_age_restriction CHECK ((agerestriction >= 0)),
    CONSTRAINT chk_movie_duration CHECK ((durationminutes > 0)),
    CONSTRAINT chk_movie_rating CHECK (((rating >= (0)::numeric) AND (rating <= (10)::numeric)))
);


ALTER TABLE public.movie OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 20350)
-- Name: movie_actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_actor (
    charactername character varying(100) NOT NULL,
    movieid integer NOT NULL,
    actorid integer NOT NULL
);


ALTER TABLE public.movie_actor OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 20368)
-- Name: movie_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_genre (
    movieid integer NOT NULL,
    genreid integer NOT NULL
);


ALTER TABLE public.movie_genre OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 20312)
-- Name: movie_movieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.movie ALTER COLUMN movieid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.movie_movieid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5051 (class 0 OID 20333)
-- Dependencies: 224
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actor (actorid, firstname, lastname, country) FROM stdin;
1	Tim	Robbins	United States
2	Morgan	Freeman	United States
3	Marlon	Brando	United States
4	Al	Pacino	United States
5	Christian	Bale	United Kingdom
6	Heath	Ledger	Australia
7	Tom	Hanks	United States
8	Robin	Wright	United States
9	Leonardo	DiCaprio	United States
10	Matthew	McConaughey	United States
11	Anne	Hathaway	United States
12	Kate	Winslet	United Kingdom
13	Sam	Neill	New Zealand
14	Elijah	Wood	United States
15	Ian	McKellen	United Kingdom
16	Mark	Hamill	United States
17	Harrison	Ford	United States
18	Song	Kang-ho	South Korea
19	Choi	Woo-shik	South Korea
20	Daniel	Craig	United Kingdom
21	Vlatko	Dulić	Croatia
22	Ljubomir	Kerekeš	Croatia
23	Ivan	Brkić	Croatia
24	Predrag	Vušović	Croatia
25	Matija	Prskalo	Croatia
26	François	Cluzet	France
27	Omar	Sy	France
28	Dev	Patel	United Kingdom
29	Freida	Pinto	India
30	Mark	Wahlberg	United States
31	Charlize	Theron	South Africa
32	Edward	Norton	United States
33	Jason	Statham	United Kingdom
34	Vin	Diesel	United States
35	Paul	Walker	United States
36	Michelle	Rodriguez	United States
37	Jordana	Brewster	United States
38	Samy	Naceri	France
39	Frédéric	Diefenthal	France
40	Marion	Cotillard	France
\.


--
-- TOC entry 5047 (class 0 OID 20304)
-- Dependencies: 220
-- Data for Name: director; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.director (directorid, firstname, lastname) FROM stdin;
1	Frank	Darabont
2	Francis Ford	Coppola
3	Christopher	Nolan
4	Robert	Zemeckis
5	James	Cameron
6	Steven	Spielberg
7	Peter	Jackson
8	George	Lucas
9	Bong	Joon-ho
10	Martin	Campbell
11	Vinko	Brešan
12	Olivier	Nakache
13	Danny	Boyle
14	F. Gary	Gray
15	Rob	Cohen
16	Gérard	Pirès
\.


--
-- TOC entry 5053 (class 0 OID 20343)
-- Dependencies: 226
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (genreid, genrename) FROM stdin;
1	Drama
2	Crime
3	Action
4	Thriller
5	Science Fiction
6	Adventure
7	Romance
8	Fantasy
9	Comedy
\.


--
-- TOC entry 5049 (class 0 OID 20313)
-- Dependencies: 222
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie (movieid, title, releasedate, durationminutes, agerestriction, rating, originallanguage, country, directorid) FROM stdin;
1	The Shawshank Redemption	1994-09-23	142	16	8.7	English	United States	1
2	The Godfather	1972-03-24	175	18	8.7	English	United States	2
3	The Dark Knight	2008-07-18	152	16	8.5	English	United States	3
4	Forrest Gump	1994-07-06	142	12	8.5	English	United States	4
5	Interstellar	2014-11-07	169	12	8.5	English	United States	3
6	Titanic	1997-12-19	195	12	7.9	English	United States	5
7	Jurassic Park	1993-06-11	127	12	8.0	English	United States	6
8	The Lord of the Rings: The Fellowship of the Ring	2001-12-19	178	12	8.4	English	New Zealand	7
9	Star Wars: A New Hope	1977-05-25	121	12	8.2	English	United States	8
10	Parasite	2019-05-30	132	15	8.5	Korean	South Korea	9
11	Casino Royale	2006-11-17	144	13	7.6	English	United Kingdom	10
12	Kako je počeo rat na mom otoku	1996-08-07	97	12	6.2	Croatian	Croatia	11
13	The Intouchables	2011-11-02	112	12	8.3	French	France	12
14	Slumdog Millionaire	2008-11-12	120	15	7.7	English	United Kingdom	13
15	The Italian Job	2003-05-30	111	13	6.8	English	United States	14
16	The Fast and the Furious	2001-06-22	106	13	7.0	English	United States	15
17	Taxi	1998-04-08	86	12	6.7	French	France	16
\.


--
-- TOC entry 5054 (class 0 OID 20350)
-- Dependencies: 227
-- Data for Name: movie_actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_actor (charactername, movieid, actorid) FROM stdin;
Andy Dufresne	1	1
Ellis Boyd Redding	1	2
Vito Corleone	2	3
Michael Corleone	2	4
Bruce Wayne / Batman	3	5
Joker	3	6
Forrest Gump	4	7
Jenny Curran	4	8
Cooper	5	10
Brand	5	11
Jack Dawson	6	9
Rose DeWitt Bukater	6	12
Dr. Alan Grant	7	13
Frodo Baggins	8	14
Gandalf	8	15
Luke Skywalker	9	16
Han Solo	9	17
Kim Ki-taek	10	18
Kim Ki-woo	10	19
James Bond	11	20
Blaž Gajski	12	21
Major Aleksa Milosavljević	12	22
Roko Papak	12	23
Murko Munita	12	24
Lucija Milosavljević	12	25
Philippe	13	26
Driss	13	27
Jamal Malik	14	28
Latika	14	29
Charlie Croker	15	30
Stella Bridger	15	31
Steve Frazelli	15	32
Handsome Rob	15	33
Dominic Toretto	16	34
Brian O'Conner	16	35
Letty Ortiz	16	36
Mia Toretto	16	37
Daniel Morales	17	38
Émilien Coutant-Kerbalec	17	39
Lilly Bertineau	17	40
\.


--
-- TOC entry 5055 (class 0 OID 20368)
-- Dependencies: 228
-- Data for Name: movie_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_genre (movieid, genreid) FROM stdin;
1	1
2	1
2	2
3	3
3	4
4	1
4	7
5	1
5	5
5	6
6	1
6	7
7	5
7	6
7	4
8	8
8	6
9	5
9	6
10	1
10	4
10	9
11	3
11	4
11	6
12	1
12	9
13	1
13	9
14	1
14	2
15	3
15	2
16	3
16	4
17	3
17	9
\.


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 223
-- Name: actor_actorid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actor_actorid_seq', 40, true);


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 219
-- Name: director_directorid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.director_directorid_seq', 16, true);


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 225
-- Name: genre_genreid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_genreid_seq', 9, true);


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 221
-- Name: movie_movieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_movieid_seq', 17, true);


--
-- TOC entry 4887 (class 2606 OID 20341)
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actorid);


--
-- TOC entry 4883 (class 2606 OID 20311)
-- Name: director director_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_pkey PRIMARY KEY (directorid);


--
-- TOC entry 4889 (class 2606 OID 20349)
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (genreid);


--
-- TOC entry 4891 (class 2606 OID 20357)
-- Name: movie_actor movie_actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT movie_actor_pkey PRIMARY KEY (movieid, actorid);


--
-- TOC entry 4893 (class 2606 OID 20374)
-- Name: movie_genre movie_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre
    ADD CONSTRAINT movie_genre_pkey PRIMARY KEY (movieid, genreid);


--
-- TOC entry 4885 (class 2606 OID 20326)
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (movieid);


--
-- TOC entry 4895 (class 2606 OID 20363)
-- Name: movie_actor movie_actor_actorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT movie_actor_actorid_fkey FOREIGN KEY (actorid) REFERENCES public.actor(actorid);


--
-- TOC entry 4896 (class 2606 OID 20358)
-- Name: movie_actor movie_actor_movieid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT movie_actor_movieid_fkey FOREIGN KEY (movieid) REFERENCES public.movie(movieid);


--
-- TOC entry 4894 (class 2606 OID 20327)
-- Name: movie movie_directorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_directorid_fkey FOREIGN KEY (directorid) REFERENCES public.director(directorid);


--
-- TOC entry 4897 (class 2606 OID 20380)
-- Name: movie_genre movie_genre_genreid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre
    ADD CONSTRAINT movie_genre_genreid_fkey FOREIGN KEY (genreid) REFERENCES public.genre(genreid);


--
-- TOC entry 4898 (class 2606 OID 20375)
-- Name: movie_genre movie_genre_movieid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre
    ADD CONSTRAINT movie_genre_movieid_fkey FOREIGN KEY (movieid) REFERENCES public.movie(movieid);


-- Completed on 2026-10-31 16:07:40

--
-- PostgreSQL database dump complete
--

\unrestrict cebsBmyhlvlOxG4nvu2EumweUnRNjrSgIq9DsNcl1bv3ze41TG16MqyCfKLZcC5

