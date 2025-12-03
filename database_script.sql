-- 0. hazirlik (eski veritabanini temizle ve yeniden kur)
drop database if exists kitaplik_deneme_db;
create database kitaplik_deneme_db;
use kitaplik_deneme_db;

-- 1. normalizasyon tablolari
create table countries (
    country_id int auto_increment primary key,
    country_name varchar(50) not null unique
);

create table cities (
    city_id int auto_increment primary key,
    country_id int not null,
    city_name varchar(50) not null,
    foreign key (country_id) references countries(country_id) on delete cascade
);

create table counties (
    county_id int auto_increment primary key,
    city_id int not null,
    county_name varchar(50) not null,
    foreign key (city_id) references cities(city_id) on delete cascade
);

create table authors (
    author_id int auto_increment primary key,
    author_name varchar(255) not null unique
);

create table publishers (
    publisher_id int auto_increment primary key,
    publisher_name varchar(100) not null unique
);

create table categories (
    category_id int auto_increment primary key,
    category_name varchar(100) not null unique
);

-- 2. kullanicilar tablosu
create table users (
    user_id int auto_increment,
    name varchar(100) not null,
    surname varchar(100) not null,
    user_name varchar(50) not null,
    email varchar(255) not null,
    `password` varchar(255) not null,
    register_date timestamp default current_timestamp,
    seller_user_rating decimal(3, 2) default 0.00,
    customer_user_rating decimal(3, 2) default 0.00,
    primary key (user_id),
    unique (user_name),
    unique (email)
);

-- 3. kitap tanimlari (katalog)
create table book_definitions (
    book_def_id int auto_increment,
    isbn varchar(13) unique,
    title varchar(255) not null,
    author_id int,
    publisher_id int,
    category_id int,
    major varchar(100), 
    publishing_date date,
    general_rating decimal(3, 2) default 0.00, 
    primary key (book_def_id),
    foreign key (author_id) references authors(author_id),
    foreign key (publisher_id) references publishers(publisher_id),
    foreign key (category_id) references categories(category_id)
);

-- 4. ilanlar
create table listings (
    listing_id int auto_increment,
    owner_user_id int not null,
    book_def_id int not null,
    `condition` varchar(50),
    explanation text,
    book_cover varchar(255),
    addition_date timestamp default current_timestamp,
    status varchar(20) default 'Yayinda',
    price decimal(10, 2) not null default 0.00,
    primary key (listing_id),
    foreign key (owner_user_id) references users(user_id) on delete cascade,
    foreign key (book_def_id) references book_definitions(book_def_id)
);

-- 5. teklifler
create table offers (
    offer_id int auto_increment,
    listing_id int not null,
    requester_id int not null,
    offer_type varchar(20),
    payment_type varchar(50),
    deliver_type varchar(20), 
    price decimal(10, 2) not null default 0.00,
    lending_duration int,
    status varchar(20) default 'Aktif',
    offer_date timestamp default current_timestamp,
    primary key (offer_id),
    foreign key (listing_id) references listings(listing_id) on delete cascade,
    foreign key (requester_id) references users(user_id) on delete cascade
);

-- 6. islem tablolari
create table purchase_processes (
    process_id int auto_increment,
    offer_id int not null,
    process_date timestamp default current_timestamp on update current_timestamp,
    status varchar(20) not null default 'Talep Edildi',
    primary key (process_id),
    unique (offer_id),
    foreign key (offer_id) references offers(offer_id) on delete cascade
);

create table other_processes (
    process_id int auto_increment,
    offer_id int not null,
    process_start_date date,
    process_finish_date date,
    status varchar(20) not null default 'Talep Edildi',
    primary key (process_id),
    unique (offer_id), 
    foreign key (offer_id) references offers(offer_id) on delete cascade
);

-- 7. adresler
create table adresses (
    adress_id int auto_increment,
    user_id int not null,
    county_id int not null,
    adress_name varchar(50) not null, 
    adress_detail text not null,
    primary key (adress_id),
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (county_id) references counties(county_id)
);

-- 8. degerlendirmeler
create table reviews (
    review_id int auto_increment,
    book_def_id int,
    listing_id int,
    degerlendiren_kullanici_id int not null,
    degerlendirilen_kullanici_id int not null,
    point int not null check (point >= 1 and point <= 5),
    `comment` text,
    comment_date timestamp default current_timestamp,
    primary key (review_id),
    foreign key (book_def_id) references book_definitions(book_def_id),
    foreign key (listing_id) references listings(listing_id),
    foreign key (degerlendiren_kullanici_id) references users(user_id),
    foreign key (degerlendirilen_kullanici_id) references users(user_id)
);

-- 9. indexler
create index idx_book_title on book_definitions(title);
create index idx_book_isbn on book_definitions(isbn);
create index idx_user_name on users(name, surname);
create index idx_offer_status on offers(status);

-- 10. viewlar
create view view_catalog_summary as
select bd.title, a.author_name, bd.isbn, bd.general_rating, count(b.listing_id) as total_listings_available
from book_definitions bd
left join listings b on bd.book_def_id = b.book_def_id and b.status = 'Yayinda'
left join authors a on bd.author_id = a.author_id
group by bd.book_def_id;

create view view_active_listings as
select b.listing_id, bd.title, u.user_name as seller, b.condition, b.status
from listings b
join book_definitions bd on b.book_def_id = bd.book_def_id
join users u on b.owner_user_id = u.user_id
where b.status = 'Yayinda';

create view view_full_addresses as
select a.adress_id, u.user_name, a.adress_name, a.adress_detail, cnt.county_name, ci.city_name, co.country_name
from adresses a
join users u on a.user_id = u.user_id
join counties cnt on a.county_id = cnt.county_id
join cities ci on cnt.city_id = ci.city_id
join countries co on ci.country_id = co.country_id;

create view view_active_offers as
select o.offer_id, bd.title, u.user_name as requester, o.offer_type, o.price, o.status
from offers o
join listings b on o.listing_id = b.listing_id
join book_definitions bd on b.book_def_id = bd.book_def_id
join users u on o.requester_id = u.user_id
where o.status = 'Aktif';

