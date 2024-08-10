--
-- PostgreSQL database dump
--

-- Dumped from database version 13.16 (Debian 13.16-1.pgdg120+1)
-- Dumped by pg_dump version 13.16 (Debian 13.16-1.pgdg120+1)

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
-- Name: conversations; Type: TABLE; Schema: public; Owner: your_username
--

CREATE TABLE public.conversations (
    id text NOT NULL,
    question text NOT NULL,
    answer text NOT NULL,
    group_name text NOT NULL,
    model_used text NOT NULL,
    response_time double precision NOT NULL,
    relevance text NOT NULL,
    relevance_explanation text NOT NULL,
    prompt_tokens integer NOT NULL,
    completion_tokens integer NOT NULL,
    total_tokens integer NOT NULL,
    eval_prompt_tokens integer NOT NULL,
    eval_completion_tokens integer NOT NULL,
    eval_total_tokens integer NOT NULL,
    groq_cost double precision NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.conversations OWNER TO your_username;

--
-- Name: feedback; Type: TABLE; Schema: public; Owner: your_username
--

CREATE TABLE public.feedback (
    id integer NOT NULL,
    conversation_id text,
    feedback integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.feedback OWNER TO your_username;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: your_username
--

CREATE SEQUENCE public.feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedback_id_seq OWNER TO your_username;

--
-- Name: feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: your_username
--

ALTER SEQUENCE public.feedback_id_seq OWNED BY public.feedback.id;


--
-- Name: feedback id; Type: DEFAULT; Schema: public; Owner: your_username
--

ALTER TABLE ONLY public.feedback ALTER COLUMN id SET DEFAULT nextval('public.feedback_id_seq'::regclass);


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: your_username
--

COPY public.conversations (id, question, answer, group_name, model_used, response_time, relevance, relevance_explanation, prompt_tokens, completion_tokens, total_tokens, eval_prompt_tokens, eval_completion_tokens, eval_total_tokens, groq_cost, "timestamp") FROM stdin;
008037e7-3967-4663-8661-df578574791e	Pep Guardiola là ai ?	Pep Guardiola là một người Westbrook, cổ đó người Tây Ban Nha, từng làm huấn luyện viên của các đội bóng như Barcelona và Manchester City.	General	groq/llama3-8b-8192	0.9424905776977539	RELEVANT	The generated answer correctly identifies Pep Guardiola, providing accurate information about his nationality (Tây Ban Nha) and his experience as a coach for Barcelona and Manchester City, which is highly relevant to the question 'Pep Guardiola là ai?'	1981	33	2014	206	67	273	0.0030375000000000003	2024-08-10 03:12:01.997635+00
8022aaeb-190c-48a7-ad4e-e091fc22583a	Đi xe đạp bằng chân bị phạt bao nhiêu tiền ? 	Câu hỏi: Đi xe đạp bằng chân bị phạt bao nhiêu tiền?\n\nrespuesta: Không có dữ liệu trong bối cảnh này cho câu hỏi về phạt vi phạm đi xe đạp bằng chân.	General	groq/llama3-8b-8192	0.8462905883789062	NON_RELEVANT	The generated answer is not relevant to the question because it simply repeats the question itself, instead of providing an actual answer. Additionally, it states that there is no data in this context, which is not an answer at all.	1894	43	1937	225	64	289	0.002927	2024-08-10 03:12:16.497184+00
4e4ab811-4c45-4201-8e9a-99ef8d6db6e8	Đi xe đạp bằng chân bị phạt bao nhiêu tiền ? 	Đi xe đạp bằng chân không bị phạt. Bởi vì trong văn bản không có nhắc đến vấn đề đi xe đạp bằng chân và không có quy định phạt tiền đối với hành vi đi xe đạp bằng chân.	Legal	groq/llama3-8b-8192	0.7771272659301758	RELEVANT	The generated answer directly addresses the question of whether going cycling with one's hands can lead to a fine and provides a justification for the answer by citing the lack of relevant regulations or mention in the relevant documents.	1959	48	2007	230	59	289	0.0030345	2024-08-10 03:14:47.821282+00
dd23bce4-48fd-4879-b107-a4523e5b7550	Pep Guardiola là ai ?	Pep Guardiola là người bóng đá người Tây Ban Nha, đang làm nhiệm vụ là huấn luyện viên trưởng của câu lạc bộ Manchester City.	General	groq/llama3-8b-8192	0.8785605430603027	RELEVANT	The generated answer directly answers the question 'Pep Guardiola là ai?' by providing information about Pep Guardiola's identity, nationality, and job title. The answer is relevant because it provides specific details about the person Pep Guardiola is, matching the question's intent.	1981	31	2012	204	72	276	0.0030335	2024-08-10 03:14:59.076563+00
52ff3b25-f400-4a34-8cc0-7fc3ee94bb7f	Pep Guardiola đã tổ chức tiệc cho các cầu thủ Manchester city, đúng hay sai ?	Pep Guardiola đã tổ chức tiệc cho các cầu thủ Manchester City, đúng. Ba đời sau chiến thắng nhọc nhằn trước Leicester ở Carabao Cup, Pep Guardiola đã mở bữa tiệc mừng Giáng sinh với sự góp mặt của các học trò cưng cùng hàng trăm nhân viên của Manchester City. Khá nhiều người đã nhận ra Pep Guardiola và xin được chụp ảnh chung với vị thuyền trưởng đáng kính của Man City.	General	groq/llama3-8b-8192	0.9039561748504639	RELEVANT	The generated answer is directly relevant to the question, which asks whether Pep Guardiola had organized a party for Manchester City players. The answer confirms that he did, providing additional context about the party and why it was special.	2180	99	2279	286	62	348	0.003468	2024-08-10 03:15:28.547343+00
8e2110a5-0a5d-4e25-a074-75b5db6ec334	Pep Guardiola đã tổ chức tiệc cho các cầu thủ Manchester city, đúng hay sai ?	Pep Guardiola chưa tổ chức tiệc cho các cầu thủ Manchester City, đúng. Bởi vì câu trả lời bạn đọc được là Pep Guardiola đã tổ chức bữa tiệc mừng vô địch lượt đi sớm tại một hộp đêm ở Manchester, và có sự góp mặt của các học trò cưng cùng hàng trăm nhân viên của Manchester City.	General	groq/llama3-8b-8192	1.0220248699188232	RELEVANT	The generated answer directly addresses the question, stating Pep Guardiola did not organize a party for Manchester City players, and provides evidence to support this claim. The answer is relevant to the question and provides a valid response.	2180	75	2255	262	61	323	0.00342	2024-08-10 03:27:59.16999+00
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: your_username
--

COPY public.feedback (id, conversation_id, feedback, "timestamp") FROM stdin;
1	4e4ab811-4c45-4201-8e9a-99ef8d6db6e8	1	2024-08-10 03:15:34.913464+00
2	8e2110a5-0a5d-4e25-a074-75b5db6ec334	-1	2024-08-10 03:28:17.506213+00
\.


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: your_username
--

SELECT pg_catalog.setval('public.feedback_id_seq', 2, true);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: your_username
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: your_username
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: feedback feedback_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: your_username
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


--
-- PostgreSQL database dump complete
--

