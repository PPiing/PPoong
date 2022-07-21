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
    "chatSeqChatSeq" integer
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
    "gameType"          varchar                 not null,
    "topUserName"       varchar                 not null,
    "btmUserName"       varchar                 not null,
    "topSideScore"      integer   default 0     not null,
    "btmSideScore"      integer   default 0     not null,
    option1             varchar                 not null,
    option2             varchar                 not null,
    option3             varchar                 not null,
    "createdAt"         timestamp default now() not null,
    "updatedAt"         timestamp default now() not null,
    "topUserSeqUserSeq" integer
        constraint "FK_6583a2bb12e378cf30c42662360"
            references "user",
    "btmUserSeqUserSeq" integer
        constraint "FK_fbd4306b511d55485ffc8ca48ca"
            references "user",
    "winnerSeqUserSeq"  integer
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

INSERT INTO "user" ("userSeq", "userId", "nickName", "email", "secAuthStatus", "avatarImgUri", "status", "deleteStatus", "createdAt") VALUES
(1,	76295,	'수퍼꽃미남낌',	'kkim@student.42seoul.kr',	'0',	'/api/upload/DefaultProfile.jpg',	'USST10',	'0',	'2022-07-20 11:24:58.14967'),
(2,	81304,	'멋쟁이형요',	'hyungyyo@student.42seoul.kr',	'0',	'/api/upload/DefaultProfile.jpg',	'USST10',	'0',	'2022-07-20 23:11:40.43843'),
(3,	76317,	'joopark',	'joopark@student.42seoul.kr',	'0',	'/api/upload/DefaultProfile.jpg',	'USST10',	'0',	'2022-07-21 05:29:21.827393');