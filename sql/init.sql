create table typeorm_metadata
(
    type     varchar not null,
    database varchar,
    schema   varchar,
    "table"  varchar,
    name     varchar,
    value    text
);

alter table typeorm_metadata
    owner to "user";

create table chat
(
    "chatSeq"    serial
        constraint "PK_5753de67ae458033877a0cc71c8"
            primary key,
    "chatType"   varchar                               not null,
    "chatName"   varchar                               not null
        constraint "UQ_34822c10953e549fcedc2a4ed2b"
            unique,
    password     varchar default ''::character varying not null,
    "isDirected" boolean default false                 not null
);

alter table chat
    owner to "user";

create table "user"
(
    "userSeq"       serial
        constraint "PK_251823649a4f8a98603086b07b9"
            primary key,
    "userId"        integer                                                   not null
        constraint "UQ_d72ea127f30e21753c9e229891e"
            unique,
    "nickName"      varchar                                                   not null
        constraint "UQ_f15a1d20dcbcde42b43563aaecb"
            unique,
    email           varchar                                                   not null
        constraint "UQ_e12875dfb3b1d92d7d7c5377e22"
            unique,
    "secAuthStatus" boolean   default false                                   not null,
    "avatarImgUri"  varchar   default '/api/upload/DefaultProfile.jpg'::character varying not null,
    status          varchar   default 'USST10'::character varying             not null,
    "deleteStatus"  boolean   default false                                   not null,
    "createdAt"     timestamp default now()                                   not null
);

alter table "user"
    owner to "user";

create table alarm
(
    "alarmSeq"    serial
        constraint "PK_4b68b684e35e98c7cf081170288"
            primary key,
    "alarmType"   varchar                 not null,
    "alarmCode"   varchar                 not null,
    read          boolean   default false not null,
    delete        boolean   default false not null,
    "createdAt"   timestamp default now() not null,
    "receiverSeq" integer
        constraint "FK_69212ed6569624a43cb27796875"
            references "user",
    "senderSeq"   integer
        constraint "FK_e8de4e0887f4d1f0aad1a1aced7"
            references "user"
);

alter table alarm
    owner to "user";

create table chat_participant
(
    "partcSeq"  serial
        constraint "PK_8f2cfbb5e2371e15f36652bdc3c"
            primary key,
    "userSeq"   integer                 not null
        constraint "FK_1dbc37eb1b23cd775fbde1889ab"
            references "user",
    "chatSeq"   integer                 not null
        constraint "FK_11c37338577809d81f4bc2b6f42"
            references chat,
    "partcAuth" varchar                 not null,
    "enteredAt" timestamp default now() not null,
    "leavedAt"  timestamp
);

alter table chat_participant
    owner to "user";

create table chat_event
(
    "eventSeq"       serial
        constraint "PK_ef76d74e89bbb3d5640d55ea859"
            primary key,
    "eventType"      varchar                                                                  not null,
    "createdAt"      timestamp default '2022-07-12 07:57:12.723'::timestamp without time zone not null,
    "deletedCheck"   boolean   default false                                                  not null,
    "expiredAt"      timestamp default '2022-07-12 07:57:12.723'::timestamp without time zone not null,
    "fromWho"        integer
        constraint "FK_6edf6b8af14cc2b81c4f7f57919"
            references chat_participant,
    "toWho"          integer
        constraint "FK_f3fb8fd9674b602dfbd7619595c"
            references chat_participant,
    "chatSeq"        integer
        constraint "FK_2be9c80149696d940259e764781"
            references chat
);

alter table chat_event
    owner to "user";

create table message
(
    "msgSeq"    serial
        constraint "PK_2d499022f8161d10e3241765d6f"
            primary key,
    message     varchar                 not null,
    "createdAt" timestamp default now() not null,
    "chatSeq"   integer
        constraint "FK_f73cd744648e8934d122fe7f9ee"
            references chat,
    "userSeq"   integer
        constraint "FK_3ab1ef7b41f5dd7625bd758b82e"
            references "user"
);

alter table message
    owner to "user";

create table friends
(
    "friendSeq"   serial
        constraint "PK_a23064cc1ad7e9e6866e66e585f"
            primary key,
    "isBlocked"   boolean default false not null,
    status        varchar               not null,
    "followerSeq" integer
        constraint "FK_2dd8bb7093f2890afe8d4538228"
            references "user",
    "followeeSeq" integer
        constraint "FK_2026211a1824b6b93bd044eddd1"
            references "user"
);

alter table friends
    owner to "user";

create table game_log
(
    "gameLogSeq"        serial
        constraint "PK_9c05647fe50dfdc35337f1e394c"
            primary key,
    "roomId"            varchar                 not null,
    "isRankGame"        boolean                 not null,
    "blueUserSeq"       integer                 not null,
    "redUserSeq"        integer                 not null,
    "blueUserName"      varchar                 not null,
    "redUserName"       varchar                 not null,
    "winnerSeq"         integer                 null,
    "blueScore"         integer   default 0     not null,
    "redScore"          integer   default 0     not null,
    "paddleSize"        numeric(5, 2)                 not null,
    "ballSpeed"         numeric(5, 2)                 not null,
    "matchScore"        integer                 not null,
    "createdAt"         timestamp default now() not null,
    "updatedAt"         timestamp default now() not null,
    "blueUserSeqUserSeq" integer
        constraint "FK_1c430a90644d54f160d4f0799e9"
            references "user",
    "redUserSeqUserSeq"  integer
        constraint "FK_57749872aa6821e3437719a7fa1"
            references "user",
    "winnerSeqUserSeq"   integer
        constraint "FK_68c0bfc674ca97e446bcb4b55c1"
            references "user"
);

alter table game_log
    owner to "user";

create table achiv
(
    "achivSeq"    serial
        constraint "PK_5ce5764d38c7500bfdbb94e84c1"
            primary key,
    "achivTitle"  varchar not null,
    "achivImgUri" varchar not null,
    "totalScore"  integer not null
);

alter table achiv
    owner to "user";

create table user_achiv
(
    "userAchivSeq" serial
        constraint "PK_7474f16dde5db7d7a0d718a41ca"
            primary key,
    "userSeq"      integer
        constraint "FK_ad1faa0cb03c272dd5676adb3c4"
            references "user",
    "achivSeq"     integer
        constraint "FK_28199a23e5cd0196556a0ef2f8f"
            references achiv
);

alter table user_achiv
    owner to "user";

create table rank
(
    "rankSeq"   serial
        constraint "PK_58b9d75e8455cdb851eb6b747b0"
            primary key,
    "rankScore" integer default 0 not null,
    "userSeq"   integer           not null
        constraint "REL_4fa7dc8ca8f2f8f15c6553ff90"
            unique
        constraint "FK_4fa7dc8ca8f2f8f15c6553ff90e"
            references "user"
);

alter table rank
    owner to "user";

create table profile
(
    "profileSeq" serial
        constraint "PK_1aeb306fa084c9dbe66c86a64d2"
            primary key,
    "userSeq"    integer not null
        constraint "REL_c973778928aa70415e31febf5d"
            unique
        constraint "FK_c973778928aa70415e31febf5d0"
            references "user",
    "rankSeq"    integer not null
        constraint "REL_8b9c11cfcb36acd40f5959d5f0"
            unique
        constraint "FK_8b9c11cfcb36acd40f5959d5f0d"
            references rank
);

alter table profile
    owner to "user";

create table "query-result-cache"
(
    id         serial
        constraint "PK_6a98f758d8bfd010e7e10ffd3d3"
            primary key,
    identifier varchar,
    time       bigint  not null,
    duration   integer not null,
    query      text    not null,
    result     text    not null
);

alter table "query-result-cache"
    owner to "user";

INSERT INTO achiv VALUES (1, 'Score50', './achiv1.jpg', 50);
INSERT INTO achiv VALUES (2, 'Score100', './achiv2.jpg', 100);
INSERT INTO achiv VALUES (3, 'Score150', './achiv3.jpg', 150);

INSERT INTO "user" ( "userId", "nickName", "email", "secAuthStatus", "avatarImgUri", "status", "deleteStatus", "createdAt") VALUES
(75023,	'hybae',	'hybae@student.42seoul.kr',	'0',	'/api/upload/DefaultProfile.jpg',	'USST10',	'0',	'2022-07-21 05:29:21.827393'),
(76295,	'수퍼꽃미남낌',	'kkim@student.42seoul.kr',	'0',	'/api/upload/DefaultProfile.jpg',	'USST10',	'0',	'2022-07-20 11:24:58.14967'),
(81304,	'멋쟁이형요',	'hyungyyo@student.42seoul.kr',	'0',	'/api/upload/DefaultProfile.jpg',	'USST10',	'0',	'2022-07-20 23:11:40.43843'),
(76317,	'joopark',	'joopark@student.42seoul.kr',	'0',	'/api/upload/DefaultProfile.jpg',	'USST10',	'0',	'2022-07-21 05:29:21.827393');

INSERT INTO "chat" ("chatType", "chatName", "password", "isDirected") VALUES
('CHTP20',	'푸주홍의 등산클럽',	'',	'0'),
('CHTP30',	'장이수의 도박클럽',	'$2b$10$gnY2ITzIrJKgw2HxH5GETOKO6ICbRLCvge1e3xta1UM1CceZCz1Ia',	'0'),
('CHTP40',	'장첸의 마라롱샤클럽',	'',	'0'),
('CHTP20',	'크립스 갱스터들',	'',	'0'),
('CHTP20',	'스킴 80kg 만들기 목표방',	'',	'0');

INSERT INTO "message" ("message", "createdAt", "chatSeq", "userSeq") VALUES
('안녕하세요 형요님, 주팍님',	now() + INTERVAL '1 MINUTE',	1,	1),
('네 안녕하세요',	now() + INTERVAL '2 MINUTE',	1,	2),
('게임하러 왔으면 곱게 놀아야지',	now() + INTERVAL '3 MINUTE',	2,	1),
('뭐이라니? 정신나갔니?',	now() + INTERVAL '4 MINUTE',	2,	3),
('어. 정신나갔다. 맞제?',	now() + INTERVAL '5 MINUTE',	2,	1),
('시끄럽다',	now() + INTERVAL '6 MINUTE',	2,	3),
('죄송합니다 형님',	now() + INTERVAL '7 MINUTE',	2,	1),
('니들 뭐이야',	now() + INTERVAL '8 MINUTE',	2,	3),
('마라롱샤 한그릇 5천원~',	now() + INTERVAL '9 MINUTE',	3,	1),
('Much Crip love',	now() + INTERVAL '10 MINUTE',	4,	1),
('On a blue day like this',	now() + INTERVAL '11 MINUTE',	4,	1),
('Packin a .44',	now() + INTERVAL '12 MINUTE',	4,	1),
('Roll in a Crip 6',	now() + INTERVAL '13 MINUTE',	4,	1),
('They call me Sin Loc',	now() + INTERVAL '14 MINUTE',	4,	1),
('Yes, the G that aint no joke',	now() + INTERVAL '15 MINUTE',	4,	1),
('스킴 80kg 만들기 정말 가능할까요?',	now() + INTERVAL '16 MINUTE',	5,	2),
('아이 그럼요~ 지금처럼만 하면 두달이면 가능하죠~',	now() + INTERVAL '17 MINUTE',	5,	1);

INSERT INTO "chat_participant" ("userSeq", "chatSeq", "partcAuth", "enteredAt", "leavedAt") VALUES
(1,	1, 'CPAU30', now(),	NULL),
(2,	1, 'CPAU20', now(),	NULL),
(3,	1, 'CPAU10', now(),	NULL),
(1,	2, 'CPAU30', now(),	NULL),
(3,	2, 'CPAU10', now(),	NULL),
(1,	3, 'CPAU30', now(),	NULL),
(1,	4, 'CPAU30', now(),	NULL),
(2,	4, 'CPAU10', now(),	NULL);

-- INSERT INTO "friends"("isBlocked", "status", "followerSeq", "followeeSeq") VALUES
-- (false, 'FRST10', 1, 5),
-- (false, 'FRST10', 5, 1);
