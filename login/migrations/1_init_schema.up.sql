create table User
(
    id int auto_increment primary key not null,
    username varchar(50) not null,
    password_hash varchar(75) not null,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    date_of_birth Date not null,
    email varchar(300) not null,
    isEmailVerified bool default 0 not null,
    created TIMESTAMP not null
);

create unique index User_email_uindex
    on User (email);

create unique index User_id_uindex
    on User (id);

create unique index User_username_uindex
    on User (username);

create table user_agent
(
    id int auto_increment primary key not null,
    name varchar(300) not null
);

create unique index user_agent_id_uindex
    on user_agent (id);

create table refresh_token
(
    id int auto_increment primary key not null,
    user_id int not null,
    user_agent int not null,
    token varchar(100) not null,
    valid_to TIMESTAMP not null,
    created TIMESTAMP not null,
    last_used TIMESTAMP not null,
    is_disabled BOOLEAN default 0 not null,
    disabled_when TIMESTAMP null,
    issued_from_ip varchar(17) not null,
    last_used_with_ip varchar(17) not null,
    constraint refresh_token_user_id_fk
        foreign key (user_id) references user (id),
    constraint refresh_token_user_agent_id_fk
        foreign key (user_agent) references user_agent (id)
);

create unique index refresh_token_id_uindex
    on refresh_token (id);



