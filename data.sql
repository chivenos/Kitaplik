SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `adresses`;

-- fabricate-flush

DELETE FROM `authors`;

-- fabricate-flush

DELETE FROM `book_definitions`;

-- fabricate-flush

DELETE FROM `categories`;

-- fabricate-flush

DELETE FROM `cities`;

-- fabricate-flush

DELETE FROM `counties`;

-- fabricate-flush

DELETE FROM `countries`;

-- fabricate-flush

DELETE FROM `listings`;

-- fabricate-flush

DELETE FROM `offers`;

-- fabricate-flush

DELETE FROM `other_processes`;

-- fabricate-flush

DELETE FROM `publishers`;

-- fabricate-flush

DELETE FROM `purchase_processes`;

-- fabricate-flush

DELETE FROM `reviews`;

-- fabricate-flush

DELETE FROM `users`;

-- fabricate-flush

DELETE FROM `view_active_listings`;

-- fabricate-flush

DELETE FROM `view_active_offers`;

-- fabricate-flush

DELETE FROM `view_catalog_summary`;

-- fabricate-flush

DELETE FROM `view_full_addresses`;

-- fabricate-flush


INSERT INTO `adresses` (`adress_id`, `user_id`, `county_id`, `adress_name`, `adress_detail`) VALUES
(1, 2, 13, 'Ev', 'Tunalı Hilmi Caddesi No:17 Daire:17'),
(2, 2, 16, 'Daire', 'Moda Caddesi No:35 Daire:17'),
(3, 3, 11, 'Ev', 'Bağdat Caddesi No:145 Daire:2'),
(4, 3, 29, 'Yazlık', 'Cumhuriyet Bulvarı No:7 Daire:2'),
(5, 4, 31, 'Ev', 'Bahariye Caddesi No:98 Daire:5'),
(6, 4, 3, 'Ofis', 'Kadife Sokak No:52 Daire:12'),
(7, 4, 13, 'Daire', 'İstiklal Caddesi No:63 Daire:17'),
(8, 5, 1, 'Ev', 'İstiklal Caddesi No:110 Daire:13'),
(9, 6, 30, 'Ev', 'İnönü Sokak No:72 Daire:10'),
(10, 7, 11, 'Ev', 'Bahariye Caddesi No:22 Daire:14'),
(11, 7, 28, 'İş', 'Cumhuriyet Bulvarı No:100 Daire:9'),
(12, 8, 2, 'Ev', 'Tunalı Hilmi Caddesi No:107 Daire:16'),
(13, 9, 2, 'Ev', 'Tunalı Hilmi Caddesi No:60 Daire:14'),
(14, 10, 7, 'Ev', 'Tunalı Hilmi Caddesi No:86 Daire:15'),
(15, 11, 30, 'Ev', 'Kadife Sokak No:59 Daire:10'),
(16, 11, 28, 'Anne Evi', 'Kadife Sokak No:103 Daire:6'),
(17, 12, 27, 'Ev', 'Kadife Sokak No:128 Daire:14'),
(18, 12, 19, 'Ev', 'Moda Caddesi No:122 Daire:4'),
(19, 12, 14, 'Ofis', 'Cumhuriyet Bulvarı No:100 Daire:19'),
(20, 13, 21, 'Ev', 'Kadife Sokak No:131 Daire:16'),
(21, 14, 9, 'Ev', 'Bağdat Caddesi No:93 Daire:18'),
(22, 14, 1, 'İş', 'Kadife Sokak No:114 Daire:7'),
(23, 15, 27, 'Ev', 'Atatürk Caddesi No:56 Daire:14'),
(24, 15, 30, 'İş', 'Nişantaşı Sokak No:16 Daire:11'),
(25, 18, 21, 'Ev', 'İstiklal Caddesi No:88 Daire:19'),
(26, 18, 19, 'İş', 'Atatürk Caddesi No:44 Daire:8'),
(27, 20, 2, 'Ev', 'İstiklal Caddesi No:85 Daire:5'),
(28, 21, 16, 'Ev', 'İnönü Sokak No:143 Daire:8'),
(29, 22, 4, 'Ev', 'Moda Caddesi No:48 Daire:7'),
(30, 23, 11, 'Ev', 'Nişantaşı Sokak No:19 Daire:12'),
(31, 26, 6, 'Ev', 'Nişantaşı Sokak No:53 Daire:11'),
(32, 26, 34, 'Daire', 'Cumhuriyet Bulvarı No:27 Daire:1'),
(33, 28, 22, 'Ev', 'İnönü Sokak No:25 Daire:19'),
(34, 30, 25, 'Ev', 'Bağdat Caddesi No:7 Daire:7'),
(35, 31, 25, 'Ev', 'Moda Caddesi No:17 Daire:10'),
(36, 32, 24, 'Ev', 'Bağdat Caddesi No:25 Daire:5'),
(37, 33, 18, 'Ev', 'Bahariye Caddesi No:21 Daire:8'),
(38, 33, 4, 'Yazlık', 'Bağdat Caddesi No:98 Daire:10'),
(39, 35, 14, 'Ev', 'Atatürk Caddesi No:79 Daire:8'),
(40, 35, 17, 'Anne Evi', 'İnönü Sokak No:51 Daire:9'),
(41, 36, 4, 'Ev', 'İnönü Sokak No:81 Daire:18'),
(42, 37, 12, 'Ev', 'Tunalı Hilmi Caddesi No:117 Daire:1'),
(43, 39, 20, 'Ev', 'Bahariye Caddesi No:48 Daire:11'),
(44, 41, 14, 'Ev', 'Bahariye Caddesi No:34 Daire:12'),
(45, 41, 18, 'İş', 'Bahariye Caddesi No:17 Daire:16'),
(46, 42, 6, 'Ev', 'Tunalı Hilmi Caddesi No:18 Daire:12'),
(47, 42, 3, 'Yazlık', 'Kadife Sokak No:51 Daire:6'),
(48, 42, 4, 'İş', 'İnönü Sokak No:135 Daire:1'),
(49, 43, 29, 'Ev', 'Bahariye Caddesi No:84 Daire:20'),
(50, 46, 21, 'Ev', 'Nişantaşı Sokak No:140 Daire:15'),
(51, 47, 3, 'Ev', 'Moda Caddesi No:84 Daire:7'),
(52, 47, 23, 'Ofis', 'Nişantaşı Sokak No:109 Daire:4'),
(53, 48, 19, 'Ev', 'Atatürk Caddesi No:137 Daire:8'),
(54, 49, 5, 'Ev', 'Atatürk Caddesi No:118 Daire:20'),
(55, 50, 33, 'Ev', 'Moda Caddesi No:52 Daire:10'),
(56, 50, 17, 'Daire', 'İnönü Sokak No:51 Daire:4');


-- fabricate-flush


INSERT INTO `authors` (`author_id`, `author_name`) VALUES
(1, 'Orhan Pamuk'),
(2, 'Sabahattin Ali'),
(3, 'Zülfü Livaneli'),
(4, 'Ahmet Ümit'),
(5, 'Elif Şafak'),
(6, 'Yaşar Kemal'),
(7, 'Nazım Hikmet'),
(8, 'Aziz Nesin'),
(9, 'Sait Faik Abasıyanık'),
(10, 'Oğuz Atay'),
(11, 'Attila İlhan'),
(12, 'Cemal Süreya'),
(13, 'Can Yücel'),
(14, 'Murathan Mungan'),
(15, 'Hakan Günday'),
(16, 'Ayşe Kulin'),
(17, 'Buket Uzuner'),
(18, 'Perihan Mağden'),
(19, 'Emrah Serbes'),
(20, 'Ece Temelkuran'),
(21, 'Aslı Erdoğan'),
(22, 'Şebnem İşigüzel'),
(23, 'Kürşat Başar'),
(24, 'Pınar Kür'),
(25, 'Tomris Uyar'),
(26, 'George Orwell'),
(27, 'J.K. Rowling'),
(28, 'Stephen King'),
(29, 'Haruki Murakami'),
(30, 'Franz Kafka'),
(31, 'Gabriel Garcia Marquez'),
(32, 'Fyodor Dostoyevski'),
(33, 'Leo Tolstoy'),
(34, 'Victor Hugo'),
(35, 'Albert Camus'),
(36, 'Ernest Hemingway'),
(37, 'Jack London'),
(38, 'Oscar Wilde'),
(39, 'Charles Dickens'),
(40, 'Jane Austen'),
(41, 'William Shakespeare'),
(42, 'Agatha Christie'),
(43, 'Arthur Conan Doyle'),
(44, 'Jules Verne'),
(45, 'J.R.R. Tolkien'),
(46, 'Paulo Coelho'),
(47, 'Dan Brown'),
(48, 'Umberto Eco'),
(49, 'Milan Kundera'),
(50, 'Hermann Hesse'),
(51, 'Virginia Woolf'),
(52, 'Marcel Proust'),
(53, 'James Joyce'),
(54, 'Samuel Beckett'),
(55, 'Isaac Asimov'),
(56, 'Ray Bradbury'),
(57, 'Philip K. Dick'),
(58, 'Ursula K. Le Guin'),
(59, 'Kurt Vonnegut'),
(60, 'Margaret Atwood'),
(61, 'Toni Morrison'),
(62, 'John Steinbeck'),
(63, 'Mark Twain'),
(64, 'Edgar Allan Poe'),
(65, 'H.P. Lovecraft'),
(66, 'Neil Gaiman'),
(67, 'Terry Pratchett'),
(68, 'George R.R. Martin'),
(69, 'Brandon Sanderson'),
(70, 'Patrick Rothfuss');


-- fabricate-flush


INSERT INTO `book_definitions` (`book_def_id`, `isbn`, `title`, `author_id`, `publisher_id`, `category_id`, `major`, `publishing_date`, `general_rating`) VALUES
(1, '9789750738555', 'Kürk Mantolu Madonna', 2, 1, 1, NULL, '2015-03-15', 4.5),
(2, '9789750719387', 'Masumiyet Müzesi', 1, 2, 1, NULL, '2008-08-29', 4.2),
(3, '9789750802942', 'Kar', 1, 2, 1, NULL, '2002-11-20', 4.35),
(4, '9789750500527', 'Benim Adım Kırmızı', 1, 2, 1, NULL, '1998-09-14', 4.45),
(5, '9789752897427', 'İnce Memed 1', 6, 1, 1, NULL, '2016-01-10', 4.65),
(6, '9789752897434', 'İnce Memed 2', 6, 1, 1, NULL, '2016-01-10', 4.6),
(7, '9789750516764', 'Tutunamayanlar', 10, 2, 1, NULL, '2014-06-12', 4.75),
(8, '9789750824821', 'Beyoğlu Rapsodisi', 11, 1, 8, NULL, '2017-02-20', 4.25),
(9, '9789755106793', 'Sokak', 3, 4, 1, NULL, '2012-09-15', 4.1),
(10, '9786053609759', 'Kavim', 3, 4, 1, NULL, '2019-11-08', 4.3),
(11, '9789750738012', 'Beyoğlu''nun En Güzel Abisi', 4, 1, 4, NULL, '2013-04-22', 4.4),
(12, '9789750516252', 'İstanbul Hatırası', 4, 2, 4, NULL, '2010-10-18', 4.35),
(13, '9789750730221', 'Aşk', 5, 4, 1, NULL, '2009-03-12', 4.15),
(14, '9789750823152', 'Baba ve Piç', 5, 4, 1, NULL, '2006-09-20', 4.5),
(15, '9789755108155', 'Bir Kedi Bir Adam Bir Ölüm', 15, 4, 1, NULL, '2001-05-14', 4.2),
(16, '9789750719394', '1984', 26, 1, 2, NULL, '2017-08-10', 4.8),
(17, '9789750823787', 'Hayvan Çiftliği', 26, 1, 1, NULL, '2016-11-15', 4.7),
(18, '9789754584394', 'Harry Potter ve Felsefe Taşı', 27, 1, 3, NULL, '2012-02-20', 4.85),
(19, '9789754584400', 'Harry Potter ve Sırlar Odası', 27, 1, 3, NULL, '2012-02-20', 4.82),
(20, '9789754584417', 'Harry Potter ve Azkaban Tutsağı', 27, 1, 3, NULL, '2012-02-20', 4.88),
(21, '9789750718992', 'Şeytan', 28, 11, 4, NULL, '2018-06-12', 4.55),
(22, '9789750820786', 'Cinnet', 28, 11, 4, NULL, '2019-09-25', 4.4),
(23, '9789752896055', 'Kafka Kıyıda', 29, 4, 1, NULL, '2015-05-18', 4.6),
(24, '9789752896734', '1Q84', 29, 4, 1, NULL, '2013-11-22', 4.45),
(25, '9789750718718', 'Dönüşüm', 30, 1, 1, NULL, '2014-03-10', 4.5),
(26, '9789750824555', 'Yüzyıllık Yalnızlık', 31, 1, 1, NULL, '2016-07-14', 4.75),
(27, '9789750802225', 'Suç ve Ceza', 32, 2, 1, NULL, '2017-01-20', 4.85),
(28, '9789750802232', 'Karamazov Kardeşler', 32, 2, 1, NULL, '2018-04-15', 4.82),
(29, '9789752896482', 'Anna Karenina', 33, 2, 1, NULL, '2015-09-10', 4.7),
(30, '9789750823435', 'Sefiller', 34, 1, 5, NULL, '2014-12-05', 4.78),
(31, '9789750816772', 'Yabancı', 35, 1, 1, NULL, '2016-02-28', 4.65),
(32, '9789750816789', 'Veba', 35, 1, 1, NULL, '2017-05-15', 4.6),
(33, '9789750824234', 'İhtiyar Adam ve Deniz', 36, 1, 1, NULL, '2015-08-20', 4.4),
(34, '9789750718015', 'Beyaz Diş', 37, 5, 11, NULL, '2013-06-18', 4.55),
(35, '9789750816345', 'Dorian Gray''in Portresi', 38, 2, 1, NULL, '2014-11-10', 4.48),
(36, '9789750824111', 'İki Şehrin Hikayesi', 39, 2, 5, NULL, '2016-03-22', 4.35),
(37, '9789750824678', 'Doğu Ekspresinde Cinayet', 42, 11, 4, NULL, '2015-07-12', 4.72),
(38, '9789750824685', 'Nil''de Ölüm', 42, 11, 4, NULL, '2015-07-12', 4.65),
(39, '9789750816888', 'Sherlock Holmes - Dörtlerin İmzası', 43, 2, 4, NULL, '2016-09-15', 4.58),
(40, '9789750816895', 'Sherlock Holmes - Baskerville''in Köpeği', 43, 2, 4, NULL, '2016-09-15', 4.7),
(41, '9789752896888', 'Dünya''nın Merkezine Yolculuk', 44, 5, 2, NULL, '2014-05-20', 4.3),
(42, '9789750823999', 'Yüzüklerin Efendisi: Yüzük Kardeşliği', 45, 11, 3, NULL, '2017-12-10', 4.9),
(43, '9789750824005', 'Yüzüklerin Efendisi: İki Kule', 45, 11, 3, NULL, '2017-12-10', 4.88),
(44, '9789750824012', 'Yüzüklerin Efendisi: Kralın Dönüşü', 45, 11, 3, NULL, '2017-12-10', 4.92),
(45, '9789750816123', 'Simyacı', 46, 1, 1, NULL, '2013-01-15', 4.25),
(46, '9789750823666', 'Da Vinci Şifresi', 47, 11, 4, NULL, '2015-04-18', 4.15),
(47, '9789750818234', 'Gülün Adı', 48, 1, 5, NULL, '2016-06-22', 4.68),
(48, '9789750816432', 'Varolmanın Dayanılmaz Hafifliği', 49, 1, 1, NULL, '2014-08-15', 4.52),
(49, '9789750823123', 'Siddhartha', 50, 1, 7, NULL, '2015-11-20', 4.6),
(50, '9789750824889', 'Vaktiyle Bir Hayat', 54, 1, 1, NULL, '2018-02-14', 4.42);


-- fabricate-flush


INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Roman'),
(2, 'Bilim Kurgu'),
(3, 'Fantastik'),
(4, 'Polisiye'),
(5, 'Tarih'),
(6, 'Kişisel Gelişim'),
(7, 'Felsefe'),
(8, 'Şiir'),
(9, 'Deneme'),
(10, 'Biyografi'),
(11, 'Çocuk Kitapları'),
(12, 'Gençlik'),
(13, 'Psikoloji'),
(14, 'Ekonomi'),
(15, 'Sanat');


-- fabricate-flush


INSERT INTO `cities` (`city_id`, `country_id`, `city_name`) VALUES
(1, 1, 'İstanbul'),
(2, 1, 'Ankara'),
(3, 1, 'İzmir'),
(4, 1, 'Bursa'),
(5, 1, 'Antalya'),
(6, 1, 'Adana'),
(7, 1, 'Gaziantep'),
(8, 1, 'Konya');


-- fabricate-flush


INSERT INTO `counties` (`county_id`, `city_id`, `county_name`) VALUES
(1, 1, 'Kadıköy'),
(2, 1, 'Beşiktaş'),
(3, 1, 'Üsküdar'),
(4, 1, 'Şişli'),
(5, 1, 'Bakırköy'),
(6, 1, 'Maltepe'),
(7, 1, 'Beyoğlu'),
(8, 1, 'Kartal'),
(9, 2, 'Çankaya'),
(10, 2, 'Keçiören'),
(11, 2, 'Yenimahalle'),
(12, 2, 'Mamak'),
(13, 2, 'Etimesgut'),
(14, 3, 'Karşıyaka'),
(15, 3, 'Bornova'),
(16, 3, 'Konak'),
(17, 3, 'Buca'),
(18, 3, 'Alsancak'),
(19, 4, 'Osmangazi'),
(20, 4, 'Nilüfer'),
(21, 4, 'Yıldırım'),
(22, 4, 'Mudanya'),
(23, 5, 'Muratpaşa'),
(24, 5, 'Kepez'),
(25, 5, 'Konyaaltı'),
(26, 5, 'Alanya'),
(27, 6, 'Seyhan'),
(28, 6, 'Yüreğir'),
(29, 6, 'Çukurova'),
(30, 7, 'Şahinbey'),
(31, 7, 'Şehitkamil'),
(32, 8, 'Meram'),
(33, 8, 'Selçuklu'),
(34, 8, 'Karatay');


-- fabricate-flush


INSERT INTO `countries` (`country_id`, `country_name`) VALUES
(1, 'Türkiye');


-- fabricate-flush


INSERT INTO `listings` (`listing_id`, `owner_user_id`, `book_def_id`, `condition`, `explanation`, `book_cover`, `addition_date`, `status`, `price`) VALUES
(1, 1, 7, 'Yeni Gibi', 'Acil satılık.', NULL, '2025-01-07 17:08:52', 'Kapandı', 125),
(2, 2, 40, 'İyi', 'Az kullanılmış, temiz.', NULL, '2025-08-06 17:08:52', 'Yayinda', 129),
(3, 3, 21, 'İdare Eder', 'Acil satılık.', NULL, '2025-09-21 17:08:52', 'Yayinda', 158),
(4, 3, 27, 'Çok İyi', 'Güzel durumda, tavsiye ederim.', NULL, '2025-11-16 17:08:52', 'Kapandı', 238),
(5, 3, 50, 'İdare Eder', 'İkinci el, okunabilir durumda.', NULL, '2025-09-28 17:08:52', 'Yayinda', 224),
(6, 3, 44, 'İdare Eder', 'Bir kez okundu, çok temiz.', NULL, '2025-09-24 17:08:52', 'Yayinda', 150),
(7, 4, 37, 'Çok İyi', '', NULL, '2025-06-12 17:08:52', 'Yayinda', 104),
(8, 6, 35, 'Yeni Gibi', 'Bir kez okundu, çok temiz.', NULL, '2025-11-13 17:08:52', 'İşlemde', 66),
(9, 6, 41, 'İdare Eder', 'Okunmuş ama güzel durumda.', NULL, '2025-08-04 17:08:52', 'Yayinda', 188),
(10, 6, 19, 'İyi', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-11-20 17:08:52', 'Yayinda', 89),
(11, 7, 13, 'Çok İyi', 'Tertemiz, hiç kullanılmadı.', NULL, '2024-08-12 17:08:52', 'Yayinda', 77),
(12, 8, 42, 'İdare Eder', 'Güzel durumda, tavsiye ederim.', NULL, '2025-05-11 17:08:52', 'Yayinda', 204),
(13, 8, 4, 'Yeni', 'Koleksiyon temizliği.', NULL, '2024-09-18 17:08:52', 'Yayinda', 203),
(14, 8, 29, 'İyi', 'Okunmuş ama güzel durumda.', NULL, '2024-03-09 17:08:52', 'Satıldı', 159),
(15, 9, 30, 'İyi', 'Kütüphanemde yer kalmadı.', NULL, '2025-04-18 17:08:52', 'Kapandı', 100),
(16, 9, 7, 'İdare Eder', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-08-20 17:08:52', 'İşlemde', 148),
(17, 9, 50, 'İyi', 'Okunmuş ama güzel durumda.', NULL, '2025-05-01 17:08:52', 'Kapandı', 237),
(18, 9, 23, 'Yeni', 'Acil satılık.', NULL, '2025-05-11 17:08:52', 'Yayinda', 226),
(19, 9, 26, 'İyi', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-05-05 17:08:52', 'İşlemde', 196),
(20, 9, 16, 'Çok İyi', '', NULL, '2025-03-25 17:08:52', 'Kapandı', 111),
(21, 9, 13, 'İyi', 'Acil satılık.', NULL, '2025-04-24 17:08:52', 'Yayinda', 140),
(22, 9, 25, 'İdare Eder', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-10-20 17:08:52', 'İşlemde', 214),
(23, 9, 32, 'İdare Eder', '', NULL, '2025-03-06 17:08:52', 'Kapandı', 222),
(24, 11, 22, 'Yeni Gibi', 'Acil satılık.', NULL, '2025-09-28 17:08:52', 'Yayinda', 127),
(25, 11, 3, 'İdare Eder', 'Kütüphanemde yer kalmadı.', NULL, '2025-09-17 17:08:52', 'Yayinda', 153),
(26, 11, 29, 'İdare Eder', 'Okunmuş ama güzel durumda.', NULL, '2025-10-25 17:08:52', 'Yayinda', 210),
(27, 11, 9, 'Yeni', 'Koleksiyon temizliği.', NULL, '2025-10-06 17:08:52', 'Yayinda', 250),
(28, 12, 17, 'Yeni', 'Acil satılık.', NULL, '2024-10-15 17:08:52', 'Yayinda', 154),
(29, 12, 22, 'Yeni Gibi', '', NULL, '2025-11-06 17:08:52', 'Kapandı', 72),
(30, 12, 33, 'Çok İyi', 'Kütüphanemde yer kalmadı.', NULL, '2025-08-30 17:08:52', 'Yayinda', 102),
(31, 13, 35, 'Yeni', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-09-30 17:08:52', 'Yayinda', 145),
(32, 13, 16, 'Yeni Gibi', 'İkinci el, okunabilir durumda.', NULL, '2025-11-06 17:08:52', 'Yayinda', 195),
(33, 13, 29, 'İdare Eder', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-11-08 17:08:52', 'Yayinda', 240),
(34, 13, 22, 'İyi', 'Az kullanılmış, temiz.', NULL, '2025-09-30 17:08:52', 'İşlemde', 229),
(35, 15, 4, 'Yeni Gibi', 'Sayfalarda hafif sararma var.', NULL, '2025-09-16 17:08:52', 'Satıldı', 92),
(36, 15, 7, 'Yeni Gibi', '', NULL, '2024-03-20 17:08:52', 'Yayinda', 113),
(37, 16, 39, 'Yeni', 'İkinci el, okunabilir durumda.', NULL, '2025-08-19 17:08:52', 'Yayinda', 273),
(38, 16, 2, 'İdare Eder', 'Tertemiz, hiç kullanılmadı.', NULL, '2025-04-06 17:08:52', 'İşlemde', 191),
(39, 16, 33, 'İdare Eder', 'Güzel durumda, tavsiye ederim.', NULL, '2024-10-08 17:08:52', 'Yayinda', 106),
(40, 16, 1, 'Yeni Gibi', 'Tertemiz, hiç kullanılmadı.', NULL, '2024-09-19 17:08:52', 'Yayinda', 71),
(41, 17, 46, 'İyi', 'Tertemiz, hiç kullanılmadı.', NULL, '2024-07-02 17:08:52', 'Yayinda', 271),
(42, 17, 38, 'Yeni', 'Sayfalarda hafif sararma var.', NULL, '2024-04-23 17:08:52', 'Yayinda', 86),
(43, 17, 31, 'Çok İyi', 'Sayfalarda hafif sararma var.', NULL, '2024-06-01 17:08:52', 'Yayinda', 156),
(44, 17, 7, 'Yeni Gibi', 'Koleksiyon temizliği.', NULL, '2025-06-14 17:08:52', 'Satıldı', 90),
(45, 17, 49, 'İdare Eder', 'Tertemiz, hiç kullanılmadı.', NULL, '2024-12-28 17:08:52', 'Yayinda', 154),
(46, 17, 1, 'Yeni', 'Bir kez okundu, çok temiz.', NULL, '2024-09-22 17:08:52', 'Yayinda', 237),
(47, 18, 2, 'Çok İyi', 'Bir kez okundu, çok temiz.', NULL, '2025-01-19 17:08:52', 'Yayinda', 152),
(48, 18, 12, 'İdare Eder', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-08-10 17:08:52', 'Yayinda', 163),
(49, 19, 27, 'Çok İyi', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2024-11-26 17:08:52', 'Yayinda', 172),
(50, 19, 5, 'Çok İyi', 'Tertemiz, hiç kullanılmadı.', NULL, '2025-07-15 17:08:52', 'Kapandı', 80),
(51, 21, 49, 'İyi', 'Güzel durumda, tavsiye ederim.', NULL, '2025-08-09 17:08:52', 'Yayinda', 174),
(52, 22, 28, 'Çok İyi', 'Kütüphanemde yer kalmadı.', NULL, '2024-06-26 17:08:52', 'Kapandı', 163),
(53, 22, 15, 'Çok İyi', 'Kütüphanemde yer kalmadı.', NULL, '2025-07-08 17:08:52', 'Yayinda', 256),
(54, 22, 17, 'İdare Eder', '', NULL, '2025-02-08 17:08:52', 'Yayinda', 206),
(55, 22, 11, 'Yeni Gibi', 'Az kullanılmış, temiz.', NULL, '2024-10-11 17:08:52', 'Yayinda', 111),
(56, 23, 27, 'Çok İyi', '', NULL, '2025-07-12 17:08:52', 'Yayinda', 242),
(57, 23, 5, 'İdare Eder', 'Tertemiz, hiç kullanılmadı.', NULL, '2024-07-25 17:08:52', 'Yayinda', 248),
(58, 26, 5, 'İdare Eder', 'Güzel durumda, tavsiye ederim.', NULL, '2024-12-19 17:08:52', 'Yayinda', 172),
(59, 26, 36, 'İdare Eder', 'Güzel durumda, tavsiye ederim.', NULL, '2025-03-10 17:08:52', 'Kapandı', 193),
(60, 26, 13, 'İyi', 'Az kullanılmış, temiz.', NULL, '2025-08-07 17:08:52', 'Yayinda', 112),
(61, 27, 11, 'İdare Eder', 'Az kullanılmış, temiz.', NULL, '2025-09-27 17:08:52', 'İşlemde', 262),
(62, 27, 20, 'Yeni Gibi', 'İkinci el, okunabilir durumda.', NULL, '2025-11-16 17:08:52', 'İşlemde', 228),
(63, 27, 24, 'İyi', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-11-25 17:08:52', 'İşlemde', 267),
(64, 28, 17, 'Yeni Gibi', 'Sayfalarda hafif sararma var.', NULL, '2024-12-28 17:08:52', 'Yayinda', 66),
(65, 29, 8, 'İdare Eder', 'Sayfalarda hafif sararma var.', NULL, '2025-06-23 17:08:52', 'Yayinda', 107),
(66, 34, 33, 'Çok İyi', 'Kütüphanemde yer kalmadı.', NULL, '2025-11-18 17:08:52', 'Yayinda', 251),
(67, 34, 20, 'Çok İyi', 'İkinci el, okunabilir durumda.', NULL, '2025-11-30 17:08:52', 'Kapandı', 243),
(68, 34, 26, 'İyi', 'İkinci el, okunabilir durumda.', NULL, '2025-11-28 17:08:52', 'İşlemde', 110),
(69, 34, 12, 'Yeni Gibi', 'Acil satılık.', NULL, '2025-11-25 17:08:52', 'Yayinda', 209),
(70, 36, 24, 'İdare Eder', 'Az kullanılmış, temiz.', NULL, '2024-10-10 17:08:52', 'Satıldı', 272),
(71, 37, 44, 'İyi', '', NULL, '2024-09-02 17:08:52', 'Yayinda', 114),
(72, 37, 30, 'Yeni', 'Tertemiz, hiç kullanılmadı.', NULL, '2025-05-18 17:08:52', 'Satıldı', 270),
(73, 37, 31, 'İyi', 'Tertemiz, hiç kullanılmadı.', NULL, '2025-11-05 17:08:52', 'Yayinda', 259),
(74, 39, 31, 'Yeni Gibi', 'Koleksiyon temizliği.', NULL, '2024-12-12 17:08:52', 'Yayinda', 211),
(75, 39, 44, 'Çok İyi', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-09-25 17:08:52', 'Yayinda', 132),
(76, 39, 46, 'İyi', 'Güzel durumda, tavsiye ederim.', NULL, '2025-02-10 17:08:52', 'Satıldı', 114),
(77, 39, 37, 'Yeni', 'Bir kez okundu, çok temiz.', NULL, '2024-08-04 17:08:52', 'Yayinda', 118),
(78, 39, 46, 'Yeni', 'Tertemiz, hiç kullanılmadı.', NULL, '2024-08-04 17:08:52', 'Yayinda', 145),
(79, 39, 40, 'Yeni Gibi', '', NULL, '2025-07-19 17:08:52', 'Yayinda', 75),
(80, 39, 28, 'Yeni Gibi', 'Az kullanılmış, temiz.', NULL, '2024-09-20 17:08:52', 'Yayinda', 92),
(81, 39, 33, 'Yeni', 'Okunmuş ama güzel durumda.', NULL, '2025-09-07 17:08:52', 'İşlemde', 231),
(82, 39, 32, 'İyi', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-03-28 17:08:52', 'Yayinda', 193),
(83, 40, 35, 'İyi', 'Sayfalarda hafif sararma var.', NULL, '2025-08-31 17:08:52', 'Yayinda', 91),
(84, 40, 20, 'İdare Eder', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-08-25 17:08:52', 'Yayinda', 252),
(85, 40, 14, 'İdare Eder', '', NULL, '2025-08-28 17:08:52', 'Yayinda', 108),
(86, 40, 14, 'İyi', 'Okunmuş ama güzel durumda.', NULL, '2025-11-01 17:08:52', 'Yayinda', 254),
(87, 41, 11, 'Yeni Gibi', 'İkinci el, okunabilir durumda.', NULL, '2025-11-17 17:08:52', 'İşlemde', 268),
(88, 41, 25, 'Çok İyi', 'Koleksiyon temizliği.', NULL, '2025-11-11 17:08:52', 'Yayinda', 237),
(89, 42, 33, 'Yeni', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-05-07 17:08:52', 'İşlemde', 80),
(90, 42, 6, 'Yeni', 'Az kullanılmış, temiz.', NULL, '2025-10-31 17:08:52', 'Yayinda', 236),
(91, 42, 30, 'Yeni Gibi', 'Güzel durumda, tavsiye ederim.', NULL, '2025-10-15 17:08:52', 'Satıldı', 175),
(92, 43, 43, 'Yeni', 'Az kullanılmış, temiz.', NULL, '2024-11-30 17:08:52', 'Satıldı', 115),
(93, 44, 47, 'İdare Eder', 'Az kullanılmış, temiz.', NULL, '2025-03-11 17:08:52', 'Yayinda', 224),
(94, 45, 26, 'İdare Eder', 'Hediye olarak alındı, hiç okunmadı.', NULL, '2025-09-14 17:08:52', 'Yayinda', 212),
(95, 45, 20, 'İdare Eder', 'Güzel durumda, tavsiye ederim.', NULL, '2024-09-02 17:08:52', 'Yayinda', 145),
(96, 45, 14, 'Yeni', 'Güzel durumda, tavsiye ederim.', NULL, '2025-05-10 17:08:52', 'İşlemde', 130),
(97, 45, 38, 'Çok İyi', 'Güzel durumda, tavsiye ederim.', NULL, '2025-10-12 17:08:52', 'Kapandı', 208),
(98, 45, 9, 'Çok İyi', 'Koleksiyon temizliği.', NULL, '2025-10-24 17:08:52', 'Yayinda', 196),
(99, 48, 19, 'Yeni Gibi', 'Acil satılık.', NULL, '2025-10-18 17:08:52', 'Kapandı', 74),
(100, 48, 35, 'Yeni', '', NULL, '2025-09-07 17:08:52', 'İşlemde', 239),
(101, 48, 30, 'Yeni Gibi', 'İkinci el, okunabilir durumda.', NULL, '2025-04-07 17:08:52', 'Yayinda', 234),
(102, 48, 49, 'Çok İyi', 'Sayfalarda hafif sararma var.', NULL, '2025-08-12 17:08:52', 'Satıldı', 227),
(103, 48, 24, 'Çok İyi', 'İkinci el, okunabilir durumda.', NULL, '2025-02-15 17:08:52', 'İşlemde', 83);


-- fabricate-flush


INSERT INTO `offers` (`offer_id`, `listing_id`, `requester_id`, `offer_type`, `payment_type`, `deliver_type`, `price`, `lending_duration`, `status`, `offer_date`) VALUES
(1, 1, 2, 'Satın Alma', 'Nakit', 'Buluşarak', 129, NULL, 'Reddedildi', '2025-10-04 17:08:52'),
(2, 2, 39, 'Satın Alma', 'Nakit', 'Kargo', 144, NULL, 'Aktif', '2025-09-13 17:08:52'),
(3, 8, 9, 'Satın Alma', 'Nakit', 'Elden', 69, NULL, 'Onaylandı', '2025-11-15 17:08:52'),
(4, 10, 17, 'Satın Alma', 'Kredi Kartı', 'Elden', 84, NULL, 'İptal Edildi', '2025-11-21 17:08:52'),
(5, 10, 17, 'Satın Alma', 'Kredi Kartı', 'Kargo', 91, NULL, 'Aktif', '2025-11-20 17:08:52'),
(6, 15, 22, 'Satın Alma', 'Nakit', 'Buluşarak', 92, NULL, 'Onaylandı', '2025-06-26 17:08:52'),
(7, 17, 11, 'Ödünç', 'Nakit', 'Elden', 206, 14, 'Onaylandı', '2025-05-19 17:08:52'),
(8, 19, 3, 'Satın Alma', 'Kapıda Ödeme', 'Elden', 184, NULL, 'Reddedildi', '2025-08-27 17:08:52'),
(9, 20, 32, 'Satın Alma', 'Kapıda Ödeme', 'Kargo', 106, NULL, 'İptal Edildi', '2025-06-13 17:08:52'),
(10, 21, 15, 'Ödünç', 'Kredi Kartı', 'Kargo', 156, 14, 'Aktif', '2025-05-30 17:08:52'),
(11, 21, 25, 'Ödünç', 'Kredi Kartı', 'Kargo', 138, 7, 'Aktif', '2025-07-13 17:08:52'),
(12, 24, 22, 'Ödünç', 'Kapıda Ödeme', 'Kargo', 145, 14, 'İptal Edildi', '2025-10-27 17:08:52'),
(13, 24, 28, 'Satın Alma', 'Kredi Kartı', 'Buluşarak', 120, NULL, 'Reddedildi', '2025-11-28 17:08:52'),
(14, 24, 18, 'Ödünç', 'Havale', 'Elden', 135, 28, 'Aktif', '2025-11-14 17:08:52'),
(15, 29, 22, 'Ödünç', 'Havale', 'Elden', 62, 28, 'Reddedildi', '2025-12-02 17:08:52'),
(16, 30, 26, 'Satın Alma', 'Kredi Kartı', 'Buluşarak', 111, NULL, 'Aktif', '2025-10-25 17:08:52'),
(17, 30, 24, 'Satın Alma', 'Kredi Kartı', 'Elden', 92, NULL, 'İptal Edildi', '2025-09-04 17:08:52'),
(18, 31, 7, 'Ödünç', 'Kapıda Ödeme', 'Elden', 148, 28, 'Aktif', '2025-11-29 17:08:52'),
(19, 33, 29, 'Satın Alma', 'Nakit', 'Elden', 275, NULL, 'Aktif', '2025-11-08 17:08:52'),
(20, 37, 8, 'Ödünç', 'Havale', 'Kargo', 272, 21, 'Onaylandı', '2025-09-06 17:08:52'),
(21, 38, 43, 'Satın Alma', 'Kredi Kartı', 'Elden', 175, NULL, 'Reddedildi', '2025-11-29 17:08:52'),
(22, 39, 37, 'Ödünç', 'Havale', 'Elden', 108, 21, 'Onaylandı', '2025-08-31 17:08:52'),
(23, 41, 40, 'Ödünç', 'Nakit', 'Kargo', 292, 28, 'Reddedildi', '2025-11-29 17:08:52'),
(24, 49, 2, 'Ödünç', 'Havale', 'Kargo', 172, 21, 'Aktif', '2025-10-21 17:08:52'),
(25, 49, 39, 'Ödünç', 'Nakit', 'Buluşarak', 184, 14, 'Aktif', '2025-10-20 17:08:52'),
(26, 50, 12, 'Ödünç', 'Havale', 'Kargo', 80, 7, 'İptal Edildi', '2025-10-25 17:08:52'),
(27, 50, 17, 'Ödünç', 'Kredi Kartı', 'Buluşarak', 70, 14, 'Onaylandı', '2025-09-26 17:08:52'),
(28, 58, 28, 'Satın Alma', 'Kapıda Ödeme', 'Kargo', 154, NULL, 'Onaylandı', '2025-07-27 17:08:52'),
(29, 59, 28, 'Ödünç', 'Kapıda Ödeme', 'Elden', 192, 21, 'Onaylandı', '2025-06-25 17:08:52'),
(30, 59, 46, 'Ödünç', 'Havale', 'Kargo', 209, 14, 'Onaylandı', '2025-04-12 17:08:52'),
(31, 59, 3, 'Satın Alma', 'Kredi Kartı', 'Elden', 177, NULL, 'Aktif', '2025-07-30 17:08:52'),
(32, 60, 11, 'Ödünç', 'Nakit', 'Kargo', 109, 14, 'Aktif', '2025-10-05 17:08:52'),
(33, 69, 10, 'Ödünç', 'Kapıda Ödeme', 'Elden', 223, 28, 'Onaylandı', '2025-11-30 17:08:52'),
(34, 70, 34, 'Ödünç', 'Havale', 'Kargo', 311, 14, 'Onaylandı', '2025-05-13 17:08:52'),
(35, 71, 32, 'Satın Alma', 'Kapıda Ödeme', 'Kargo', 129, NULL, 'Aktif', '2025-06-14 17:08:52'),
(36, 71, 24, 'Satın Alma', 'Kapıda Ödeme', 'Buluşarak', 124, NULL, 'Reddedildi', '2025-04-29 17:08:52'),
(37, 76, 8, 'Ödünç', 'Nakit', 'Elden', 118, 7, 'Onaylandı', '2025-04-21 17:08:52'),
(38, 76, 2, 'Satın Alma', 'Nakit', 'Kargo', 118, NULL, 'Onaylandı', '2025-05-31 17:08:52'),
(39, 77, 13, 'Satın Alma', 'Kapıda Ödeme', 'Buluşarak', 116, NULL, 'Onaylandı', '2024-09-14 17:08:52'),
(40, 77, 24, 'Satın Alma', 'Kredi Kartı', 'Kargo', 106, NULL, 'Reddedildi', '2025-04-08 17:08:52'),
(41, 79, 6, 'Ödünç', 'Havale', 'Buluşarak', 78, 14, 'Onaylandı', '2025-07-30 17:08:52'),
(42, 79, 28, 'Ödünç', 'Nakit', 'Buluşarak', 64, 14, 'Reddedildi', '2025-07-27 17:08:52'),
(43, 80, 9, 'Ödünç', 'Kapıda Ödeme', 'Elden', 90, 7, 'Aktif', '2025-01-02 17:08:52'),
(44, 81, 7, 'Ödünç', 'Havale', 'Kargo', 214, 28, 'Aktif', '2025-10-30 17:08:52'),
(45, 85, 39, 'Ödünç', 'Kapıda Ödeme', 'Kargo', 121, 7, 'Reddedildi', '2025-10-30 17:08:52'),
(46, 86, 29, 'Ödünç', 'Kredi Kartı', 'Elden', 240, 14, 'Aktif', '2025-11-23 17:08:52'),
(47, 89, 28, 'Ödünç', 'Nakit', 'Elden', 91, 7, 'Aktif', '2025-05-24 17:08:52'),
(48, 91, 11, 'Ödünç', 'Kredi Kartı', 'Kargo', 168, 7, 'Reddedildi', '2025-11-21 17:08:52'),
(49, 96, 50, 'Satın Alma', 'Havale', 'Buluşarak', 130, NULL, 'Onaylandı', '2025-05-12 17:08:52'),
(50, 96, 43, 'Satın Alma', 'Havale', 'Kargo', 142, NULL, 'İptal Edildi', '2025-09-27 17:08:52'),
(51, 98, 43, 'Ödünç', 'Kredi Kartı', 'Buluşarak', 186, 7, 'Aktif', '2025-11-02 17:08:52'),
(52, 100, 19, 'Satın Alma', 'Nakit', 'Kargo', 213, NULL, 'İptal Edildi', '2025-10-25 17:08:52'),
(53, 100, 1, 'Satın Alma', 'Kapıda Ödeme', 'Elden', 217, NULL, 'Reddedildi', '2025-10-29 17:08:52'),
(54, 101, 2, 'Satın Alma', 'Kredi Kartı', 'Buluşarak', 213, NULL, 'İptal Edildi', '2025-08-05 17:08:52'),
(55, 101, 27, 'Ödünç', 'Kredi Kartı', 'Kargo', 249, 21, 'Onaylandı', '2025-08-19 17:08:52'),
(56, 102, 41, 'Satın Alma', 'Havale', 'Elden', 194, NULL, 'Aktif', '2025-11-07 17:08:52'),
(57, 102, 9, 'Satın Alma', 'Nakit', 'Elden', 241, NULL, 'Reddedildi', '2025-10-21 17:08:52'),
(58, 103, 41, 'Ödünç', 'Kapıda Ödeme', 'Elden', 82, 28, 'Reddedildi', '2025-11-16 17:08:52'),
(59, 103, 31, 'Ödünç', 'Kredi Kartı', 'Elden', 72, 28, 'Reddedildi', '2025-06-13 17:08:52');


-- fabricate-flush


INSERT INTO `other_processes` (`process_id`, `offer_id`, `process_start_date`, `process_finish_date`, `status`) VALUES
(1, 7, '2025-05-21', NULL, 'Talep Edildi'),
(2, 20, '2025-09-07', NULL, 'Ödünç Verildi'),
(3, 22, '2025-09-02', NULL, 'Talep Edildi'),
(4, 27, '2025-09-27', NULL, 'Talep Edildi'),
(5, 29, '2025-06-28', '2025-07-15', 'İade Edildi'),
(6, 30, '2025-04-13', NULL, 'Talep Edildi'),
(7, 33, '2025-12-03', NULL, 'Talep Edildi'),
(8, 34, '2025-05-16', NULL, 'Talep Edildi'),
(9, 37, '2025-04-22', '2025-05-24', 'İade Edildi'),
(10, 41, '2025-07-31', NULL, 'Ödünç Verildi'),
(11, 55, '2025-08-20', NULL, 'Ödünç Verildi');


-- fabricate-flush


INSERT INTO `publishers` (`publisher_id`, `publisher_name`) VALUES
(1, 'Can Yayınları'),
(2, 'Yapı Kredi Yayınları'),
(3, 'İletişim Yayınları'),
(4, 'Doğan Kitap'),
(5, 'Everest Yayınları'),
(6, 'İş Bankası Kültür Yayınları'),
(7, 'Türkiye İş Bankası Yayınları'),
(8, 'Alfa Yayınları'),
(9, 'Remzi Kitabevi'),
(10, 'Kırmızı Kedi Yayınevi'),
(11, 'İthaki Yayınları'),
(12, 'Destek Yayınları'),
(13, 'Pegasus Yayınları'),
(14, 'Altın Kitaplar'),
(15, 'Koridor Yayıncılık'),
(16, 'Metis Yayınları'),
(17, 'Sel Yayıncılık'),
(18, 'Ayrıntı Yayınları');


-- fabricate-flush


INSERT INTO `purchase_processes` (`process_id`, `offer_id`, `process_date`, `status`) VALUES
(1, 3, '2025-11-22 17:08:52', 'Tamamlandı'),
(2, 6, '2025-07-04 17:08:52', 'Tamamlandı'),
(3, 28, '2025-08-06 17:08:52', 'Kargolandı'),
(4, 38, '2025-06-06 17:08:52', 'Tamamlandı'),
(5, 39, '2024-09-22 17:08:52', 'Teslim Edildi'),
(6, 49, '2025-05-15 17:08:52', 'Tamamlandı');


-- fabricate-flush


INSERT INTO `reviews` (`review_id`, `book_def_id`, `listing_id`, `degerlendiren_kullanici_id`, `degerlendirilen_kullanici_id`, `point`, `comment`, `comment_date`) VALUES
(1, 35, 8, 9, 6, 4, 'Fiyat-performans dengesi çok iyi.', '2025-11-29 17:08:52'),
(2, 30, 15, 22, 9, 5, 'Fiyat-performans dengesi çok iyi.', '2025-07-02 17:08:52'),
(3, 30, 15, 9, 22, 5, 'Sorunsuz işlem.', '2025-07-02 17:08:52'),
(4, 50, 17, 11, 9, 4, 'Çok memnun kaldım, teşekkürler!', '2025-05-24 17:08:52'),
(5, 5, 50, 17, 19, 5, 'Kesinlikle tekrar alışveriş yaparım.', '2025-10-08 17:08:52'),
(6, 5, 50, 19, 17, 4, 'Sorunsuz işlem.', '2025-10-08 17:08:52'),
(7, 5, 58, 28, 26, 4, 'Kitap biraz yıpranmış ama idare eder.', '2025-08-04 17:08:52'),
(8, 36, 59, 46, 26, 4, 'Paketi çok özenli hazırlanmıştı.', '2025-04-20 17:08:52'),
(9, 12, 69, 10, 34, 5, 'Kesinlikle tekrar alışveriş yaparım.', '2025-12-14 17:08:52'),
(10, 24, 70, 34, 36, 5, 'Hızlı kargo, güvenilir satıcı.', '2025-05-27 17:08:52'),
(11, 46, 76, 2, 39, 5, 'Çok memnun kaldım, teşekkürler!', '2025-06-11 17:08:52'),
(12, 14, 96, 50, 45, 4, 'Kesinlikle tekrar alışveriş yaparım.', '2025-05-17 17:08:52'),
(13, 14, 96, 45, 50, 5, 'Tekrar bekleriz.', '2025-05-17 17:08:52'),
(14, 30, 101, 27, 48, 5, 'Sorunsuz teslim, teşekkürler.', '2025-08-25 17:08:52');


-- fabricate-flush


INSERT INTO `users` (`user_id`, `name`, `surname`, `user_name`, `email`, `password`, `register_date`, `seller_user_rating`, `customer_user_rating`) VALUES
(1, 'Aslı', 'Aksoy', 'asliaksoy700', 'asliaksoy700@yahoo.com', 'hashed_password_1', '2024-04-06 17:08:52', 3.29, 4.8),
(2, 'Onur', 'Kaya', 'onurkaya705', 'onurkaya705@gmail.com', 'hashed_password_2', '2024-01-08 17:08:52', 3.89, 3.59),
(3, 'Onur', 'Koç', 'onurkoc556', 'onurkoc556@yandex.com', 'hashed_password_3', '2025-09-06 17:08:52', 4.92, 3.34),
(4, 'Cem', 'Arslan', 'cemarslan836', 'cemarslan836@yandex.com', 'hashed_password_4', '2025-04-23 17:08:52', 3.98, 3.58),
(5, 'İrem', 'Doğan', 'i̇remdogan639', 'i̇remdogan639@gmail.com', 'hashed_password_5', '2024-08-25 17:08:52', 4.14, 4.43),
(6, 'Umut', 'Çetin', 'umutcetin638', 'umutcetin638@hotmail.com', 'hashed_password_6', '2025-07-20 17:08:52', 4.68, 3.68),
(7, 'Nazlı', 'Özdemir', 'nazliozdemir359', 'nazliozdemir359@hotmail.com', 'hashed_password_7', '2024-07-24 17:08:52', 4.34, 4.09),
(8, 'Gökhan', 'Özdemir', 'gokhanozdemir579', 'gokhanozdemir579@outlook.com', 'hashed_password_8', '2023-12-14 17:08:52', 4.49, 3.85),
(9, 'Mert', 'Aksoy', 'mertaksoy499', 'mertaksoy499@outlook.com', 'hashed_password_9', '2025-02-19 17:08:52', 4.09, 4.75),
(10, 'Pınar', 'Aslan', 'pinaraslan266', 'pinaraslan266@outlook.com', 'hashed_password_10', '2025-03-13 17:08:52', 4.61, 4.97),
(11, 'Deniz', 'Güneş', 'denizgunes195', 'denizgunes195@gmail.com', 'hashed_password_11', '2025-08-06 17:08:52', 3.68, 4.92),
(12, 'Nazlı', 'Şen', 'nazlisen8', 'nazlisen8@yahoo.com', 'hashed_password_12', '2024-09-08 17:08:52', 3.24, 4.49),
(13, 'Şeyma', 'Taş', 'seymatas541', 'seymatas541@yandex.com', 'hashed_password_13', '2025-09-28 17:08:52', 4.69, 3.76),
(14, 'Barış', 'Acar', 'barisacar396', 'barisacar396@outlook.com', 'hashed_password_14', '2024-05-09 17:08:52', 4.46, 3.37),
(15, 'Mehmet', 'Öztürk', 'mehmetozturk636', 'mehmetozturk636@hotmail.com', 'hashed_password_15', '2023-12-17 17:08:52', 4.19, 4.17),
(16, 'Pınar', 'Şahin', 'pinarsahin570', 'pinarsahin570@outlook.com', 'hashed_password_16', '2024-07-19 17:08:52', 4.18, 4.43),
(17, 'Ahmet', 'Türk', 'ahmetturk604', 'ahmetturk604@hotmail.com', 'hashed_password_17', '2024-04-20 17:08:52', 3.71, 4.58),
(18, 'Burak', 'Demir', 'burakdemir824', 'burakdemir824@hotmail.com', 'hashed_password_18', '2024-11-13 17:08:52', 4.55, 3.35),
(19, 'Deniz', 'Erdoğan', 'denizerdogan78', 'denizerdogan78@outlook.com', 'hashed_password_19', '2024-10-21 17:08:52', 3.94, 3.04),
(20, 'Şeyma', 'Demir', 'seymademir418', 'seymademir418@gmail.com', 'hashed_password_20', '2025-10-01 17:08:52', 3.05, 3.43),
(21, 'İbrahim', 'Çetin', 'i̇brahimcetin889', 'i̇brahimcetin889@outlook.com', 'hashed_password_21', '2025-04-04 17:08:52', 4.88, 3.4),
(22, 'Volkan', 'Ay', 'volkanay704', 'volkanay704@hotmail.com', 'hashed_password_22', '2023-12-26 17:08:52', 3.29, 3.83),
(23, 'Arda', 'Arslan', 'ardaarslan552', 'ardaarslan552@gmail.com', 'hashed_password_23', '2024-03-22 17:08:52', 3.42, 3.68),
(24, 'Barış', 'Erdoğan', 'bariserdogan352', 'bariserdogan352@gmail.com', 'hashed_password_24', '2025-05-21 17:08:52', 4.79, 3.22),
(25, 'Zeynep', 'Aslan', 'zeynepaslan239', 'zeynepaslan239@outlook.com', 'hashed_password_25', '2024-08-16 17:08:52', 4.3, 3.48),
(26, 'Mustafa', 'Erdoğan', 'mustafaerdogan575', 'mustafaerdogan575@yahoo.com', 'hashed_password_26', '2024-02-16 17:08:52', 4.35, 3.77),
(27, 'Serkan', 'Çetin', 'serkancetin484', 'serkancetin484@yahoo.com', 'hashed_password_27', '2025-09-21 17:08:52', 3.89, 3.63),
(28, 'Gökhan', 'Özdemir', 'gokhanozdemir54', 'gokhanozdemir54@hotmail.com', 'hashed_password_28', '2024-11-01 17:08:52', 4.9, 4.71),
(29, 'Burcu', 'Aydın', 'burcuaydin549', 'burcuaydin549@yandex.com', 'hashed_password_29', '2024-05-26 17:08:52', 4, 4.99),
(30, 'Beste', 'Yavuz', 'besteyavuz247', 'besteyavuz247@hotmail.com', 'hashed_password_30', '2025-01-13 17:08:52', 3.39, 3.12),
(31, 'Can', 'Çelik', 'cancelik569', 'cancelik569@yahoo.com', 'hashed_password_31', '2025-10-07 17:08:52', 3.91, 4.15),
(32, 'Derin', 'Akın', 'derinakin695', 'derinakin695@yahoo.com', 'hashed_password_32', '2025-03-19 17:08:52', 4.49, 4.53),
(33, 'Burcu', 'Keskin', 'burcukeskin596', 'burcukeskin596@outlook.com', 'hashed_password_33', '2025-04-02 17:08:52', 3.91, 4.35),
(34, 'Ahmet', 'Taş', 'ahmettas461', 'ahmettas461@outlook.com', 'hashed_password_34', '2025-11-14 17:08:52', 3.84, 3.47),
(35, 'Tolga', 'Koç', 'tolgakoc356', 'tolgakoc356@yandex.com', 'hashed_password_35', '2025-10-31 17:08:52', 4.67, 3.77),
(36, 'Fatma', 'Kaya', 'fatmakaya703', 'fatmakaya703@gmail.com', 'hashed_password_36', '2024-03-10 17:08:52', 4.44, 4.6),
(37, 'Ege', 'Koç', 'egekoc951', 'egekoc951@yandex.com', 'hashed_password_37', '2024-05-24 17:08:52', 3.01, 3.67),
(38, 'Canan', 'Karataş', 'canankaratas351', 'canankaratas351@yahoo.com', 'hashed_password_38', '2025-07-30 17:08:52', 4.65, 3.01),
(39, 'Hatice', 'Özkan', 'haticeozkan292', 'haticeozkan292@hotmail.com', 'hashed_password_39', '2024-07-14 17:08:52', 3.1, 3.02),
(40, 'Emine', 'Aslan', 'emineaslan372', 'emineaslan372@hotmail.com', 'hashed_password_40', '2025-08-03 17:08:52', 3.59, 3.84),
(41, 'Gizem', 'Çelik', 'gizemcelik412', 'gizemcelik412@yandex.com', 'hashed_password_41', '2025-07-28 17:08:52', 4.68, 3.67),
(42, 'Selin', 'Yavuz', 'selinyavuz247', 'selinyavuz247@gmail.com', 'hashed_password_42', '2025-03-20 17:08:52', 4.86, 4.87),
(43, 'Serkan', 'Polat', 'serkanpolat492', 'serkanpolat492@gmail.com', 'hashed_password_43', '2024-10-16 17:08:52', 3.86, 3.58),
(44, 'Hasan', 'Doğan', 'hasandogan678', 'hasandogan678@outlook.com', 'hashed_password_44', '2025-01-11 17:08:52', 4.87, 3.53),
(45, 'Ayşe', 'Arslan', 'aysearslan757', 'aysearslan757@outlook.com', 'hashed_password_45', '2024-05-21 17:08:52', 3.91, 3.03),
(46, 'Canan', 'Koç', 'canankoc398', 'canankoc398@yahoo.com', 'hashed_password_46', '2025-03-23 17:08:52', 4.46, 4.33),
(47, 'Hasan', 'Yavuz', 'hasanyavuz788', 'hasanyavuz788@outlook.com', 'hashed_password_47', '2025-06-21 17:08:52', 3.81, 4.55),
(48, 'Beste', 'Öztürk', 'besteozturk572', 'besteozturk572@yandex.com', 'hashed_password_48', '2025-01-25 17:08:52', 4.95, 3.04),
(49, 'Volkan', 'Aydın', 'volkanaydin170', 'volkanaydin170@yahoo.com', 'hashed_password_49', '2025-05-31 17:08:52', 3.18, 3.68),
(50, 'Alp', 'Karataş', 'alpkaratas126', 'alpkaratas126@yahoo.com', 'hashed_password_50', '2024-03-17 17:08:52', 4.48, 3.02);


-- fabricate-flush


INSERT INTO `view_active_listings` (`listing_id`, `title`, `seller`, `condition`, `status`) VALUES
(2, 'Sherlock Holmes - Baskerville''in Köpeği', 'onurkaya705', 'İyi', 'Yayinda'),
(3, 'Şeytan', 'onurkoc556', 'İdare Eder', 'Yayinda'),
(5, 'Vaktiyle Bir Hayat', 'onurkoc556', 'İdare Eder', 'Yayinda'),
(6, 'Yüzüklerin Efendisi: Kralın Dönüşü', 'onurkoc556', 'İdare Eder', 'Yayinda'),
(7, 'Doğu Ekspresinde Cinayet', 'cemarslan836', 'Çok İyi', 'Yayinda'),
(9, 'Dünya''nın Merkezine Yolculuk', 'umutcetin638', 'İdare Eder', 'Yayinda'),
(10, 'Harry Potter ve Sırlar Odası', 'umutcetin638', 'İyi', 'Yayinda'),
(11, 'Aşk', 'nazliozdemir359', 'Çok İyi', 'Yayinda'),
(12, 'Yüzüklerin Efendisi: Yüzük Kardeşliği', 'gokhanozdemir579', 'İdare Eder', 'Yayinda'),
(13, 'Benim Adım Kırmızı', 'gokhanozdemir579', 'Yeni', 'Yayinda'),
(18, 'Kafka Kıyıda', 'mertaksoy499', 'Yeni', 'Yayinda'),
(21, 'Aşk', 'mertaksoy499', 'İyi', 'Yayinda'),
(24, 'Cinnet', 'denizgunes195', 'Yeni Gibi', 'Yayinda'),
(25, 'Kar', 'denizgunes195', 'İdare Eder', 'Yayinda'),
(26, 'Anna Karenina', 'denizgunes195', 'İdare Eder', 'Yayinda'),
(27, 'Sokak', 'denizgunes195', 'Yeni', 'Yayinda'),
(28, 'Hayvan Çiftliği', 'nazlisen8', 'Yeni', 'Yayinda'),
(30, 'İhtiyar Adam ve Deniz', 'nazlisen8', 'Çok İyi', 'Yayinda'),
(31, 'Dorian Gray''in Portresi', 'seymatas541', 'Yeni', 'Yayinda'),
(32, '1984', 'seymatas541', 'Yeni Gibi', 'Yayinda'),
(33, 'Anna Karenina', 'seymatas541', 'İdare Eder', 'Yayinda'),
(36, 'Tutunamayanlar', 'mehmetozturk636', 'Yeni Gibi', 'Yayinda'),
(37, 'Sherlock Holmes - Dörtlerin İmzası', 'pinarsahin570', 'Yeni', 'Yayinda'),
(39, 'İhtiyar Adam ve Deniz', 'pinarsahin570', 'İdare Eder', 'Yayinda'),
(40, 'Kürk Mantolu Madonna', 'pinarsahin570', 'Yeni Gibi', 'Yayinda'),
(41, 'Da Vinci Şifresi', 'ahmetturk604', 'İyi', 'Yayinda'),
(42, 'Nil''de Ölüm', 'ahmetturk604', 'Yeni', 'Yayinda'),
(43, 'Yabancı', 'ahmetturk604', 'Çok İyi', 'Yayinda'),
(45, 'Siddhartha', 'ahmetturk604', 'İdare Eder', 'Yayinda'),
(46, 'Kürk Mantolu Madonna', 'ahmetturk604', 'Yeni', 'Yayinda'),
(47, 'Masumiyet Müzesi', 'burakdemir824', 'Çok İyi', 'Yayinda'),
(48, 'İstanbul Hatırası', 'burakdemir824', 'İdare Eder', 'Yayinda'),
(49, 'Suç ve Ceza', 'denizerdogan78', 'Çok İyi', 'Yayinda'),
(51, 'Siddhartha', 'i̇brahimcetin889', 'İyi', 'Yayinda'),
(53, 'Bir Kedi Bir Adam Bir Ölüm', 'volkanay704', 'Çok İyi', 'Yayinda'),
(54, 'Hayvan Çiftliği', 'volkanay704', 'İdare Eder', 'Yayinda'),
(55, 'Beyoğlu''nun En Güzel Abisi', 'volkanay704', 'Yeni Gibi', 'Yayinda'),
(56, 'Suç ve Ceza', 'ardaarslan552', 'Çok İyi', 'Yayinda'),
(57, 'İnce Memed 1', 'ardaarslan552', 'İdare Eder', 'Yayinda'),
(58, 'İnce Memed 1', 'mustafaerdogan575', 'İdare Eder', 'Yayinda'),
(60, 'Aşk', 'mustafaerdogan575', 'İyi', 'Yayinda'),
(64, 'Hayvan Çiftliği', 'gokhanozdemir54', 'Yeni Gibi', 'Yayinda'),
(65, 'Beyoğlu Rapsodisi', 'burcuaydin549', 'İdare Eder', 'Yayinda'),
(66, 'İhtiyar Adam ve Deniz', 'ahmettas461', 'Çok İyi', 'Yayinda'),
(69, 'İstanbul Hatırası', 'ahmettas461', 'Yeni Gibi', 'Yayinda'),
(71, 'Yüzüklerin Efendisi: Kralın Dönüşü', 'egekoc951', 'İyi', 'Yayinda'),
(73, 'Yabancı', 'egekoc951', 'İyi', 'Yayinda'),
(74, 'Yabancı', 'haticeozkan292', 'Yeni Gibi', 'Yayinda'),
(75, 'Yüzüklerin Efendisi: Kralın Dönüşü', 'haticeozkan292', 'Çok İyi', 'Yayinda'),
(77, 'Doğu Ekspresinde Cinayet', 'haticeozkan292', 'Yeni', 'Yayinda'),
(78, 'Da Vinci Şifresi', 'haticeozkan292', 'Yeni', 'Yayinda'),
(79, 'Sherlock Holmes - Baskerville''in Köpeği', 'haticeozkan292', 'Yeni Gibi', 'Yayinda'),
(80, 'Karamazov Kardeşler', 'haticeozkan292', 'Yeni Gibi', 'Yayinda'),
(82, 'Veba', 'haticeozkan292', 'İyi', 'Yayinda'),
(83, 'Dorian Gray''in Portresi', 'emineaslan372', 'İyi', 'Yayinda'),
(84, 'Harry Potter ve Azkaban Tutsağı', 'emineaslan372', 'İdare Eder', 'Yayinda'),
(85, 'Baba ve Piç', 'emineaslan372', 'İdare Eder', 'Yayinda'),
(86, 'Baba ve Piç', 'emineaslan372', 'İyi', 'Yayinda'),
(88, 'Dönüşüm', 'gizemcelik412', 'Çok İyi', 'Yayinda'),
(90, 'İnce Memed 2', 'selinyavuz247', 'Yeni', 'Yayinda'),
(93, 'Gülün Adı', 'hasandogan678', 'İdare Eder', 'Yayinda'),
(94, 'Yüzyıllık Yalnızlık', 'aysearslan757', 'İdare Eder', 'Yayinda'),
(95, 'Harry Potter ve Azkaban Tutsağı', 'aysearslan757', 'İdare Eder', 'Yayinda'),
(98, 'Sokak', 'aysearslan757', 'Çok İyi', 'Yayinda'),
(101, 'Sefiller', 'besteozturk572', 'Yeni Gibi', 'Yayinda');


-- fabricate-flush


INSERT INTO `view_active_offers` (`offer_id`, `title`, `requester`, `offer_type`, `price`, `status`) VALUES
(2, 'Sherlock Holmes - Baskerville''in Köpeği', 'haticeozkan292', 'Satın Alma', 144, 'Aktif'),
(5, 'Harry Potter ve Sırlar Odası', 'ahmetturk604', 'Satın Alma', 91, 'Aktif'),
(10, 'Aşk', 'mehmetozturk636', 'Ödünç', 156, 'Aktif'),
(11, 'Aşk', 'zeynepaslan239', 'Ödünç', 138, 'Aktif'),
(14, 'Cinnet', 'burakdemir824', 'Ödünç', 135, 'Aktif'),
(16, 'İhtiyar Adam ve Deniz', 'mustafaerdogan575', 'Satın Alma', 111, 'Aktif'),
(18, 'Dorian Gray''in Portresi', 'nazliozdemir359', 'Ödünç', 148, 'Aktif'),
(19, 'Anna Karenina', 'burcuaydin549', 'Satın Alma', 275, 'Aktif'),
(24, 'Suç ve Ceza', 'onurkaya705', 'Ödünç', 172, 'Aktif'),
(25, 'Suç ve Ceza', 'haticeozkan292', 'Ödünç', 184, 'Aktif'),
(31, 'İki Şehrin Hikayesi', 'onurkoc556', 'Satın Alma', 177, 'Aktif'),
(32, 'Aşk', 'denizgunes195', 'Ödünç', 109, 'Aktif'),
(35, 'Yüzüklerin Efendisi: Kralın Dönüşü', 'derinakin695', 'Satın Alma', 129, 'Aktif'),
(43, 'Karamazov Kardeşler', 'mertaksoy499', 'Ödünç', 90, 'Aktif'),
(44, 'İhtiyar Adam ve Deniz', 'nazliozdemir359', 'Ödünç', 214, 'Aktif'),
(46, 'Baba ve Piç', 'burcuaydin549', 'Ödünç', 240, 'Aktif'),
(47, 'İhtiyar Adam ve Deniz', 'gokhanozdemir54', 'Ödünç', 91, 'Aktif'),
(51, 'Sokak', 'serkanpolat492', 'Ödünç', 186, 'Aktif'),
(56, 'Siddhartha', 'gizemcelik412', 'Satın Alma', 194, 'Aktif');


-- fabricate-flush


INSERT INTO `view_catalog_summary` (`title`, `author_name`, `isbn`, `general_rating`, `total_listings_available`) VALUES
('Kürk Mantolu Madonna', 'Sabahattin Ali', '9789750738555', 4.5, 2),
('Masumiyet Müzesi', 'Orhan Pamuk', '9789750719387', 4.2, 1),
('Kar', 'Orhan Pamuk', '9789750802942', 4.35, 1),
('Benim Adım Kırmızı', 'Orhan Pamuk', '9789750500527', 4.45, 1),
('İnce Memed 1', 'Yaşar Kemal', '9789752897427', 4.65, 2),
('İnce Memed 2', 'Yaşar Kemal', '9789752897434', 4.6, 1),
('Tutunamayanlar', 'Oğuz Atay', '9789750516764', 4.75, 1),
('Beyoğlu Rapsodisi', 'Attila İlhan', '9789750824821', 4.25, 1),
('Sokak', 'Zülfü Livaneli', '9789755106793', 4.1, 2),
('Kavim', 'Zülfü Livaneli', '9786053609759', 4.3, 0),
('Beyoğlu''nun En Güzel Abisi', 'Ahmet Ümit', '9789750738012', 4.4, 1),
('İstanbul Hatırası', 'Ahmet Ümit', '9789750516252', 4.35, 2),
('Aşk', 'Elif Şafak', '9789750730221', 4.15, 3),
('Baba ve Piç', 'Elif Şafak', '9789750823152', 4.5, 2),
('Bir Kedi Bir Adam Bir Ölüm', 'Hakan Günday', '9789755108155', 4.2, 1),
('1984', 'George Orwell', '9789750719394', 4.8, 1),
('Hayvan Çiftliği', 'George Orwell', '9789750823787', 4.7, 3),
('Harry Potter ve Felsefe Taşı', 'J.K. Rowling', '9789754584394', 4.85, 0),
('Harry Potter ve Sırlar Odası', 'J.K. Rowling', '9789754584400', 4.82, 1),
('Harry Potter ve Azkaban Tutsağı', 'J.K. Rowling', '9789754584417', 4.88, 2),
('Şeytan', 'Stephen King', '9789750718992', 4.55, 1),
('Cinnet', 'Stephen King', '9789750820786', 4.4, 1),
('Kafka Kıyıda', 'Haruki Murakami', '9789752896055', 4.6, 1),
('1Q84', 'Haruki Murakami', '9789752896734', 4.45, 0),
('Dönüşüm', 'Franz Kafka', '9789750718718', 4.5, 1),
('Yüzyıllık Yalnızlık', 'Gabriel Garcia Marquez', '9789750824555', 4.75, 1),
('Suç ve Ceza', 'Fyodor Dostoyevski', '9789750802225', 4.85, 2),
('Karamazov Kardeşler', 'Fyodor Dostoyevski', '9789750802232', 4.82, 1),
('Anna Karenina', 'Leo Tolstoy', '9789752896482', 4.7, 2),
('Sefiller', 'Victor Hugo', '9789750823435', 4.78, 1),
('Yabancı', 'Albert Camus', '9789750816772', 4.65, 3),
('Veba', 'Albert Camus', '9789750816789', 4.6, 1),
('İhtiyar Adam ve Deniz', 'Ernest Hemingway', '9789750824234', 4.4, 3),
('Beyaz Diş', 'Jack London', '9789750718015', 4.55, 0),
('Dorian Gray''in Portresi', 'Oscar Wilde', '9789750816345', 4.48, 2),
('İki Şehrin Hikayesi', 'Charles Dickens', '9789750824111', 4.35, 0),
('Doğu Ekspresinde Cinayet', 'Agatha Christie', '9789750824678', 4.72, 2),
('Nil''de Ölüm', 'Agatha Christie', '9789750824685', 4.65, 1),
('Sherlock Holmes - Dörtlerin İmzası', 'Arthur Conan Doyle', '9789750816888', 4.58, 1),
('Sherlock Holmes - Baskerville''in Köpeği', 'Arthur Conan Doyle', '9789750816895', 4.7, 2),
('Dünya''nın Merkezine Yolculuk', 'Jules Verne', '9789752896888', 4.3, 1),
('Yüzüklerin Efendisi: Yüzük Kardeşliği', 'J.R.R. Tolkien', '9789750823999', 4.9, 1),
('Yüzüklerin Efendisi: İki Kule', 'J.R.R. Tolkien', '9789750824005', 4.88, 0),
('Yüzüklerin Efendisi: Kralın Dönüşü', 'J.R.R. Tolkien', '9789750824012', 4.92, 3),
('Simyacı', 'Paulo Coelho', '9789750816123', 4.25, 0),
('Da Vinci Şifresi', 'Dan Brown', '9789750823666', 4.15, 2),
('Gülün Adı', 'Umberto Eco', '9789750818234', 4.68, 1),
('Varolmanın Dayanılmaz Hafifliği', 'Milan Kundera', '9789750816432', 4.52, 0),
('Siddhartha', 'Hermann Hesse', '9789750823123', 4.6, 2),
('Vaktiyle Bir Hayat', 'Samuel Beckett', '9789750824889', 4.42, 1);


-- fabricate-flush


INSERT INTO `view_full_addresses` (`adress_id`, `user_name`, `adress_name`, `adress_detail`, `county_name`, `city_name`, `country_name`) VALUES
(1, 'onurkaya705', 'Ev', 'Tunalı Hilmi Caddesi No:17 Daire:17', 'Etimesgut', 'Ankara', 'Türkiye'),
(2, 'onurkaya705', 'Daire', 'Moda Caddesi No:35 Daire:17', 'Konak', 'İzmir', 'Türkiye'),
(3, 'onurkoc556', 'Ev', 'Bağdat Caddesi No:145 Daire:2', 'Yenimahalle', 'Ankara', 'Türkiye'),
(4, 'onurkoc556', 'Yazlık', 'Cumhuriyet Bulvarı No:7 Daire:2', 'Çukurova', 'Adana', 'Türkiye'),
(5, 'cemarslan836', 'Ev', 'Bahariye Caddesi No:98 Daire:5', 'Şehitkamil', 'Gaziantep', 'Türkiye'),
(6, 'cemarslan836', 'Ofis', 'Kadife Sokak No:52 Daire:12', 'Üsküdar', 'İstanbul', 'Türkiye'),
(7, 'cemarslan836', 'Daire', 'İstiklal Caddesi No:63 Daire:17', 'Etimesgut', 'Ankara', 'Türkiye'),
(8, 'i̇remdogan639', 'Ev', 'İstiklal Caddesi No:110 Daire:13', 'Kadıköy', 'İstanbul', 'Türkiye'),
(9, 'umutcetin638', 'Ev', 'İnönü Sokak No:72 Daire:10', 'Şahinbey', 'Gaziantep', 'Türkiye'),
(10, 'nazliozdemir359', 'Ev', 'Bahariye Caddesi No:22 Daire:14', 'Yenimahalle', 'Ankara', 'Türkiye'),
(11, 'nazliozdemir359', 'İş', 'Cumhuriyet Bulvarı No:100 Daire:9', 'Yüreğir', 'Adana', 'Türkiye'),
(12, 'gokhanozdemir579', 'Ev', 'Tunalı Hilmi Caddesi No:107 Daire:16', 'Beşiktaş', 'İstanbul', 'Türkiye'),
(13, 'mertaksoy499', 'Ev', 'Tunalı Hilmi Caddesi No:60 Daire:14', 'Beşiktaş', 'İstanbul', 'Türkiye'),
(14, 'pinaraslan266', 'Ev', 'Tunalı Hilmi Caddesi No:86 Daire:15', 'Beyoğlu', 'İstanbul', 'Türkiye'),
(15, 'denizgunes195', 'Ev', 'Kadife Sokak No:59 Daire:10', 'Şahinbey', 'Gaziantep', 'Türkiye'),
(16, 'denizgunes195', 'Anne Evi', 'Kadife Sokak No:103 Daire:6', 'Yüreğir', 'Adana', 'Türkiye'),
(17, 'nazlisen8', 'Ev', 'Kadife Sokak No:128 Daire:14', 'Seyhan', 'Adana', 'Türkiye'),
(18, 'nazlisen8', 'Ev', 'Moda Caddesi No:122 Daire:4', 'Osmangazi', 'Bursa', 'Türkiye'),
(19, 'nazlisen8', 'Ofis', 'Cumhuriyet Bulvarı No:100 Daire:19', 'Karşıyaka', 'İzmir', 'Türkiye'),
(20, 'seymatas541', 'Ev', 'Kadife Sokak No:131 Daire:16', 'Yıldırım', 'Bursa', 'Türkiye'),
(21, 'barisacar396', 'Ev', 'Bağdat Caddesi No:93 Daire:18', 'Çankaya', 'Ankara', 'Türkiye'),
(22, 'barisacar396', 'İş', 'Kadife Sokak No:114 Daire:7', 'Kadıköy', 'İstanbul', 'Türkiye'),
(23, 'mehmetozturk636', 'Ev', 'Atatürk Caddesi No:56 Daire:14', 'Seyhan', 'Adana', 'Türkiye'),
(24, 'mehmetozturk636', 'İş', 'Nişantaşı Sokak No:16 Daire:11', 'Şahinbey', 'Gaziantep', 'Türkiye'),
(25, 'burakdemir824', 'Ev', 'İstiklal Caddesi No:88 Daire:19', 'Yıldırım', 'Bursa', 'Türkiye'),
(26, 'burakdemir824', 'İş', 'Atatürk Caddesi No:44 Daire:8', 'Osmangazi', 'Bursa', 'Türkiye'),
(27, 'seymademir418', 'Ev', 'İstiklal Caddesi No:85 Daire:5', 'Beşiktaş', 'İstanbul', 'Türkiye'),
(28, 'i̇brahimcetin889', 'Ev', 'İnönü Sokak No:143 Daire:8', 'Konak', 'İzmir', 'Türkiye'),
(29, 'volkanay704', 'Ev', 'Moda Caddesi No:48 Daire:7', 'Şişli', 'İstanbul', 'Türkiye'),
(30, 'ardaarslan552', 'Ev', 'Nişantaşı Sokak No:19 Daire:12', 'Yenimahalle', 'Ankara', 'Türkiye'),
(31, 'mustafaerdogan575', 'Ev', 'Nişantaşı Sokak No:53 Daire:11', 'Maltepe', 'İstanbul', 'Türkiye'),
(32, 'mustafaerdogan575', 'Daire', 'Cumhuriyet Bulvarı No:27 Daire:1', 'Karatay', 'Konya', 'Türkiye'),
(33, 'gokhanozdemir54', 'Ev', 'İnönü Sokak No:25 Daire:19', 'Mudanya', 'Bursa', 'Türkiye'),
(34, 'besteyavuz247', 'Ev', 'Bağdat Caddesi No:7 Daire:7', 'Konyaaltı', 'Antalya', 'Türkiye'),
(35, 'cancelik569', 'Ev', 'Moda Caddesi No:17 Daire:10', 'Konyaaltı', 'Antalya', 'Türkiye'),
(36, 'derinakin695', 'Ev', 'Bağdat Caddesi No:25 Daire:5', 'Kepez', 'Antalya', 'Türkiye'),
(37, 'burcukeskin596', 'Ev', 'Bahariye Caddesi No:21 Daire:8', 'Alsancak', 'İzmir', 'Türkiye'),
(38, 'burcukeskin596', 'Yazlık', 'Bağdat Caddesi No:98 Daire:10', 'Şişli', 'İstanbul', 'Türkiye'),
(39, 'tolgakoc356', 'Ev', 'Atatürk Caddesi No:79 Daire:8', 'Karşıyaka', 'İzmir', 'Türkiye'),
(40, 'tolgakoc356', 'Anne Evi', 'İnönü Sokak No:51 Daire:9', 'Buca', 'İzmir', 'Türkiye'),
(41, 'fatmakaya703', 'Ev', 'İnönü Sokak No:81 Daire:18', 'Şişli', 'İstanbul', 'Türkiye'),
(42, 'egekoc951', 'Ev', 'Tunalı Hilmi Caddesi No:117 Daire:1', 'Mamak', 'Ankara', 'Türkiye'),
(43, 'haticeozkan292', 'Ev', 'Bahariye Caddesi No:48 Daire:11', 'Nilüfer', 'Bursa', 'Türkiye'),
(44, 'gizemcelik412', 'Ev', 'Bahariye Caddesi No:34 Daire:12', 'Karşıyaka', 'İzmir', 'Türkiye'),
(45, 'gizemcelik412', 'İş', 'Bahariye Caddesi No:17 Daire:16', 'Alsancak', 'İzmir', 'Türkiye'),
(46, 'selinyavuz247', 'Ev', 'Tunalı Hilmi Caddesi No:18 Daire:12', 'Maltepe', 'İstanbul', 'Türkiye'),
(47, 'selinyavuz247', 'Yazlık', 'Kadife Sokak No:51 Daire:6', 'Üsküdar', 'İstanbul', 'Türkiye'),
(48, 'selinyavuz247', 'İş', 'İnönü Sokak No:135 Daire:1', 'Şişli', 'İstanbul', 'Türkiye'),
(49, 'serkanpolat492', 'Ev', 'Bahariye Caddesi No:84 Daire:20', 'Çukurova', 'Adana', 'Türkiye'),
(50, 'canankoc398', 'Ev', 'Nişantaşı Sokak No:140 Daire:15', 'Yıldırım', 'Bursa', 'Türkiye'),
(51, 'hasanyavuz788', 'Ev', 'Moda Caddesi No:84 Daire:7', 'Üsküdar', 'İstanbul', 'Türkiye'),
(52, 'hasanyavuz788', 'Ofis', 'Nişantaşı Sokak No:109 Daire:4', 'Muratpaşa', 'Antalya', 'Türkiye'),
(53, 'besteozturk572', 'Ev', 'Atatürk Caddesi No:137 Daire:8', 'Osmangazi', 'Bursa', 'Türkiye'),
(54, 'volkanaydin170', 'Ev', 'Atatürk Caddesi No:118 Daire:20', 'Bakırköy', 'İstanbul', 'Türkiye'),
(55, 'alpkaratas126', 'Ev', 'Moda Caddesi No:52 Daire:10', 'Selçuklu', 'Konya', 'Türkiye'),
(56, 'alpkaratas126', 'Daire', 'İnönü Sokak No:51 Daire:4', 'Buca', 'İzmir', 'Türkiye');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
