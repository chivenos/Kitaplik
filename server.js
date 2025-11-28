const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const path = require('path');
const cors = require('cors');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

const db = mysql.createConnection({
    host: 'localhost',
    port: 3006,
    user: 'root',      // mysql username
    password: 'Bou0tmF5!',      // mysql password
    database: 'kitaplik_deneme_db'
});

db.connect(err => {
    if (err) {
        console.error('DB Bağlantı Hatası:', err);
        return;
    }
    console.log('MySQL Veritabanına Başarıyla Bağlandı!');
    // Ensure required schema changes for POC: add `price` column to listings if missing
    const schemaCheckSql = `SELECT COUNT(*) AS cnt FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = ? AND TABLE_NAME = 'listings' AND COLUMN_NAME = 'price'`;
    db.query(schemaCheckSql, [db.config.database], (err2, rows) => {
        if (err2) { console.warn('Schema check failed:', err2); return; }
        const has = rows && rows[0] && rows[0].cnt > 0;
        if (!has) {
            console.log('`price` column missing on `listings` - attempting to add it (DECIMAL(10,2)).');
            db.query("ALTER TABLE listings ADD COLUMN price DECIMAL(10,2) NULL", (err3) => {
                if (err3) console.warn('Failed to add price column:', err3);
                else console.log('Added `price` column to `listings`.');
            });
        }
    });
});

app.get('/api/catalog', (req, res) => { // ?q= search
    const { q, isbn } = req.query;
        if (isbn) {
            const sql = `SELECT bd.book_def_id, bd.isbn, bd.title, a.author_name, bd.general_rating,
                                COUNT(CASE WHEN b.status = 'Yayinda' THEN 1 END) AS total_listings_available
                         FROM book_definitions bd
                         LEFT JOIN listings b ON bd.book_def_id = b.book_def_id
                         LEFT JOIN authors a ON bd.author_id = a.author_id
                         WHERE bd.isbn = ?
                         GROUP BY bd.book_def_id`;
            db.query(sql, [isbn], (err, results) => {
                if (err) return res.status(500).json(err);
                return res.json(results);
            });
            return;
        }

        if (q) {
            const like = '%' + q + '%';
            const sql = `SELECT bd.book_def_id, bd.isbn, bd.title, a.author_name, bd.general_rating,
                                COUNT(CASE WHEN b.status = 'Yayinda' THEN 1 END) AS total_listings_available
                         FROM book_definitions bd
                         LEFT JOIN listings b ON bd.book_def_id = b.book_def_id
                         LEFT JOIN authors a ON bd.author_id = a.author_id
                         WHERE bd.title LIKE ? OR a.author_name LIKE ? OR bd.isbn LIKE ?
                         GROUP BY bd.book_def_id`;
            db.query(sql, [like, like, like], (err, results) => {
                if (err) return res.status(500).json(err);
                return res.json(results);
            });
            return;
        }

        const baseSql = `
            SELECT bd.book_def_id, bd.isbn, bd.title, a.author_name, bd.general_rating,
                   COUNT(CASE WHEN b.status = 'Yayinda' THEN 1 END) AS total_listings_available
            FROM book_definitions bd
            LEFT JOIN listings b ON bd.book_def_id = b.book_def_id
            LEFT JOIN authors a ON bd.author_id = a.author_id
            GROUP BY bd.book_def_id`;
        db.query(baseSql, (err, results) => {
            if (err) return res.status(500).json(err);
            res.json(results);
        });
});


        app.get('/api/listings/:id/offers', (req, res) => {
            const sql = `SELECT o.*, u.user_name as requester_name FROM offers o JOIN users u ON o.requester_id = u.user_id WHERE o.listing_id = ? ORDER BY o.offer_date DESC`;
            db.query(sql, [req.params.id], (err, results) => {
                if (err) return res.status(500).json(err);
                res.json(results);
            });
        });
app.get('/api/listings', (req, res) => { // ilanlari listeleme, view_active_listings tablosundan veri çeker
    const { q, isbn } = req.query;
    if (isbn) {
        const sql = `SELECT l.listing_id, bd.title, u.user_name as seller, l.condition, l.status
                     FROM listings l
                     JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
                     JOIN users u ON l.owner_user_id = u.user_id
                     WHERE bd.isbn = ? AND l.status = 'Yayinda'`;
        db.query(sql, [isbn], (err, results) => {
            if (err) return res.status(500).json(err);
            res.json(results);
        });
        return;
    }

    if (q) {
        const like = '%' + q + '%';
        const sql = `SELECT l.listing_id, bd.title, u.user_name as seller, l.condition, l.status
                     FROM listings l
                     JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
                     JOIN users u ON l.owner_user_id = u.user_id
                     LEFT JOIN authors a ON bd.author_id = a.author_id
                     WHERE (bd.title LIKE ? OR a.author_name LIKE ? OR bd.isbn LIKE ?) AND l.status = 'Yayinda'`;
        db.query(sql, [like, like, like], (err, results) => {
            if (err) return res.status(500).json(err);
            res.json(results);
        });
        return;
    }

    let sql = 'SELECT * FROM view_active_listings';
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

app.get('/api/listings/:id', (req, res) => { // ilan detayi
    const sql = `
        SELECT l.*, bd.title, u.user_name 
        FROM listings l
        JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
        JOIN users u ON l.owner_user_id = u.user_id
        WHERE l.listing_id = ?
    `;
    db.query(sql, [req.params.id], (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results[0]);
    });
});

app.get('/api/offers/:id', (req, res) => { // teklif detayi (offer-detail.html için)
    const sql = `SELECT o.*, bd.title, u.user_name as requester_name 
                 FROM offers o 
                 JOIN listings l ON o.listing_id = l.listing_id
                 JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
                 JOIN users u ON o.requester_id = u.user_id
                 WHERE o.offer_id = ?`;
    db.query(sql, [req.params.id], (err, resDb) => {
        if (err) return res.status(500).json(err);
        res.json(resDb[0]);
    });
});

app.get('/api/active-offers', (req, res) => { // aktif orderlerı listele
    db.query('SELECT * FROM view_active_offers', (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

app.get('/api/user/username/:username', (req, res) => { // kullanici adina gore bak
    db.query('SELECT * FROM users WHERE user_name = ?', [req.params.username], (err, results) => {
        if (err) return res.status(500).json(err);
        if (results.length === 0) return res.status(404).json({ message: 'User not found' });
        res.json(results[0]);
    });
});

app.get('/api/user/:id', (req, res) => { // profil verileri
    const userId = req.params.id;
    const sqlUser = 'SELECT * FROM users WHERE user_id = ?';
    const sqlListings = 'SELECT l.*, bd.title FROM listings l JOIN book_definitions bd ON l.book_def_id = bd.book_def_id WHERE l.owner_user_id = ?';
    const sqlOffersReceived = `
        SELECT o.*, bd.title, u.user_name as requester_name 
        FROM offers o 
        JOIN listings l ON o.listing_id = l.listing_id 
        JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
        JOIN users u ON o.requester_id = u.user_id
        WHERE l.owner_user_id = ? AND o.status = 'Aktif'
    `;
    db.query(sqlUser, [userId], (err, users) => {
        if (err) return res.status(500).json(err);
        db.query(sqlListings, [userId], (err, listings) => {
            if (err) return res.status(500).json(err);
            db.query(sqlOffersReceived, [userId], (err, offers) => {
                if (err) return res.status(500).json(err);
                res.json({
                    user: users[0],
                    listings: listings,
                    offers: offers
                });
            });
        });
    });
});

app.get('/api/user/:id/orders', (req, res) => { //siparislerim/islemlerim
    const sql = `
        SELECT o.offer_id, bd.title, o.status, o.offer_date as process_date, o.price
        FROM offers o
        JOIN listings l ON o.listing_id = l.listing_id
        JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
        WHERE o.requester_id = ? 
        AND (o.status = 'Onaylandı' OR o.status = 'Tamamlandı' OR o.status = 'Kargolandı')
        ORDER BY o.offer_date DESC
    `;
    db.query(sql, [req.params.id], (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

app.post('/api/login', (req, res) => { // login
    const { email, password } = req.body;
    db.query('SELECT * FROM users WHERE email = ? AND password = ?', [email, password], (err, resDb) => {
        if (err) return res.status(500).json(err);
        if (resDb.length > 0) res.json({ success: true, user: resDb[0] });
        else res.status(401).json({ success: false, message: 'Hatalı bilgi' });
    });
});

app.post('/api/register', (req, res) => { // register
    const { name, surname, user_name, email, password } = req.body;
    db.query('INSERT INTO users (name, surname, user_name, email, password) VALUES (?,?,?,?,?)', 
        [name, surname, user_name, email, password], 
        (err, result) => {
            if (err) return res.status(500).json(err);
            res.json({ success: true, insertId: result.insertId });
    });
});

app.post('/api/listings', (req, res) => { // yeni ilan
    const { owner_user_id, book_def_id, price, condition, explanation } = req.body;
    const sql = `INSERT INTO listings (owner_user_id, book_def_id, price, \`condition\`, explanation, status) VALUES (?, ?, ?, ?, ?, 'Yayinda')`;
    db.query(sql, [owner_user_id, book_def_id, price, condition, explanation], (err, r) => {
        if (err) return res.status(500).send(err);
        res.json({ success: true });
    });
});

// Update existing listing (POC)
app.put('/api/listings/:id', (req, res) => {
    const { condition, explanation, price } = req.body;
    db.query('UPDATE listings SET `condition` = ?, explanation = ?, price = ? WHERE listing_id = ?', [condition, explanation, price, req.params.id], (err) => {
        if (err) return res.status(500).json(err);
        res.json({ success: true });
    });
});

app.post('/api/offers', (req, res) => { // make offer
    const { listing_id, requester_id, offer_type, price, payment_type, deliver_type, lending_duration } = req.body;
    // Prevent users from making offers on their own listings
    db.query('SELECT owner_user_id FROM listings WHERE listing_id = ?', [listing_id], (err, rows) => {
        if (err) return res.status(500).json(err);
        if (!rows || rows.length === 0) return res.status(404).json({ message: 'Listing not found' });
        const owner = rows[0].owner_user_id;
        if (owner === parseInt(requester_id)) return res.status(400).json({ message: 'Cannot make an offer on your own listing' });

        const sql = 'INSERT INTO offers (listing_id, requester_id, offer_type, price, payment_type, deliver_type, lending_duration) VALUES (?,?,?,?,?,?,?)';
        db.query(sql, [listing_id, requester_id, offer_type, price, payment_type, deliver_type, lending_duration || null], (err2, result) => {
            if (err2) return res.status(500).json(err2);
            res.json({ success: true, insertId: result.insertId });
        });
    });
});

app.post('/api/books', (req, res) => { // yeni kitap 
    const { isbn, title, author, publisher, category } = req.body;

        // Helper: find or create a value in a table by name
        function findOrCreate(table, colName, val, cb) {
            if (!val) return cb(null, null);
            const sel = `SELECT * FROM ${table} WHERE ${colName} = ? LIMIT 1`;
            db.query(sel, [val], (err, rows) => {
                if (err) return cb(err);
                if (rows && rows.length > 0) return cb(null, rows[0]);
                const ins = `INSERT INTO ${table} (${colName}) VALUES (?)`;
                db.query(ins, [val], (err2, r2) => {
                    if (err2) return cb(err2);
                    cb(null, { [colName.replace('_name','') + '_id']: r2.insertId });
                });
            });
        }

        // Resolve author, publisher, category sequentially
        findOrCreate('authors', 'author_name', author, (errA, aRow) => {
            if (errA) return res.status(500).json(errA);
            const author_id = aRow ? (aRow.author_id || aRow.author_id === 0 ? aRow.author_id : aRow.author_id) : null;

            findOrCreate('publishers', 'publisher_name', publisher, (errP, pRow) => {
                if (errP) return res.status(500).json(errP);
                const publisher_id = pRow ? (pRow.publisher_id || pRow.publisher_id === 0 ? pRow.publisher_id : pRow.publisher_id) : null;

                findOrCreate('categories', 'category_name', category, (errC, cRow) => {
                    if (errC) return res.status(500).json(errC);
                    const category_id = cRow ? (cRow.category_id || cRow.category_id === 0 ? cRow.category_id : cRow.category_id) : null;

                    const sql = `INSERT INTO book_definitions (isbn, title, author_id, publisher_id, category_id) VALUES (?, ?, ?, ?, ?)`;
                    db.query(sql, [isbn || null, title || null, author_id, publisher_id, category_id], (err, r) => {
                        if (err) return res.status(500).send(err);
                        res.json({ success: true, insertId: r.insertId });
                    });
                });
            });
        });
});

// Transactional flow:
// 1) fetch offer
// 2) mark selected offer Onaylandı
// 3) mark other active offers for same listing as Pasif
// 4) set listing to İşlemde
// 5) create a process row in purchase_processes or other_processes
app.post('/api/offers/:id/accept', (req, res) => { // accept offer
    const offerId = req.params.id;
    db.query('SELECT * FROM offers WHERE offer_id = ?', [offerId], (err, offers) => {
        if (err) return res.status(500).json(err);
        if (!offers || offers.length === 0) return res.status(404).json({ message: 'Offer not found' });
        const offer = offers[0];
        const listingId = offer.listing_id;
        db.beginTransaction(errt => {
            
            if (errt) return res.status(500).json(errt);
            db.query("UPDATE offers SET status = 'Onaylandı' WHERE offer_id = ?", [offerId], (err2) => {
                
                if (err2) return db.rollback(() => res.status(500).json(err2));
                db.query("UPDATE offers SET status = 'Pasif' WHERE listing_id = ? AND offer_id != ? AND status = 'Aktif'", [listingId, offerId], (err3) => { // mark other offers for same listing as Pasif
                    
                    if (err3) return db.rollback(() => res.status(500).json(err3));
                    db.query("UPDATE listings SET status = 'İşlemde' WHERE listing_id = ?", [listingId], (err4) => { // set listing to İşlemde
                       
                        if (err4) return db.rollback(() => res.status(500).json(err4));
                        if (offer.offer_type && offer.offer_type.toLowerCase().includes('sat')) { // create process row depending on offer_type
                            db.query('INSERT INTO purchase_processes (offer_id, status) VALUES (?, ?)', [offerId, 'Talep Edildi'], (err5) => { // purchase
                               
                                if (err5) return db.rollback(() => res.status(500).json(err5));
                                db.commit(commitErr => {
                                    
                                    if (commitErr) return db.rollback(() => res.status(500).json(commitErr));
                                    res.json({ success: true });
                                });
                            });
                        } else { //kiralama/odunc alma
                            const duration = offer.lending_duration || null;
                            const finishExpr = duration ? `DATE_ADD(CURDATE(), INTERVAL ${duration} DAY)` : 'NULL';
                            const sql = duration ? 'INSERT INTO other_processes (offer_id, process_start_date, process_finish_date, status) VALUES (?, CURDATE(), ?, ?)' : 'INSERT INTO other_processes (offer_id, process_start_date, status) VALUES (?, CURDATE(), ?)';
                            const params = duration ? [offerId, finishExpr, 'Talep Edildi'] : [offerId, 'Talep Edildi'];
                            if (duration) {
                                db.query(`INSERT INTO other_processes (offer_id, process_start_date, process_finish_date, status) VALUES (?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL ? DAY), ?)` , [offerId, duration, 'Talep Edildi'], (err6) => {
                                    if (err6) return db.rollback(() => res.status(500).json(err6));
                                    db.commit(commitErr => {
                                        if (commitErr) return db.rollback(() => res.status(500).json(commitErr));
                                        res.json({ success: true });
                                    });
                                });
                            } else {
                                db.query('INSERT INTO other_processes (offer_id, process_start_date, status) VALUES (?, CURDATE(), ?)', [offerId, 'Talep Edildi'], (err6) => {
                                    if (err6) return db.rollback(() => res.status(500).json(err6));
                                    db.commit(commitErr => {
                                        if (commitErr) return db.rollback(() => res.status(500).json(commitErr));
                                        res.json({ success: true });
                                    });
                                });
                            }
                        }
                    });
                });
            });
        });
    });
});

app.post('/api/offers/:id/reject', (req, res) => { // offer ret
    db.query("UPDATE offers SET status = 'Reddedildi' WHERE offer_id = ?", [req.params.id], (err) => {
        if (err) return res.status(500).json(err);
        res.json({ success: true });
    });
});

// lokasyonlar
app.get('/api/countries', (req, res) => {
    db.query('SELECT * FROM countries', (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

app.get('/api/cities/:countryId', (req, res) => {
    db.query('SELECT * FROM cities WHERE country_id = ?', [req.params.countryId], (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

app.get('/api/counties/:cityId', (req, res) => {
    db.query('SELECT * FROM counties WHERE city_id = ?', [req.params.cityId], (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

app.post('/api/addresses', (req, res) => { 
    const { user_id, county_id, adress_name, adress_detail } = req.body;
    db.query('INSERT INTO adresses (user_id, county_id, adress_name, adress_detail) VALUES (?, ?, ?, ?)', [user_id, county_id, adress_name, adress_detail], (err, result) => {
        if (err) return res.status(500).json(err);
        res.json({ success: true, insertId: result.insertId });
    });
});

app.get('/api/user/:id/addresses', (req, res) => {
    const sql = `SELECT a.*, cnt.county_name, ci.city_name, co.country_name FROM adresses a JOIN counties cnt ON a.county_id = cnt.county_id JOIN cities ci ON cnt.city_id = ci.city_id JOIN countries co ON ci.country_id = co.country_id WHERE a.user_id = ?`;
    db.query(sql, [req.params.id], (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

// Get single address by id
app.get('/api/addresses/:id', (req, res) => {
    db.query('SELECT a.*, cnt.county_name, ci.city_name, co.country_name FROM adresses a JOIN counties cnt ON a.county_id = cnt.county_id JOIN cities ci ON cnt.city_id = ci.city_id JOIN countries co ON ci.country_id = co.country_id WHERE a.adress_id = ?', [req.params.id], (err, results) => {
        if (err) return res.status(500).json(err);
        if (!results || results.length === 0) return res.status(404).json({ message: 'Address not found' });
        res.json(results[0]);
    });
});

app.put('/api/addresses/:id', (req, res) => {
    const { county_id, adress_name, adress_detail } = req.body;
    db.query('UPDATE adresses SET county_id = ?, adress_name = ?, adress_detail = ? WHERE adress_id = ?', [county_id, adress_name, adress_detail, req.params.id], (err) => {
        if (err) return res.status(500).json(err);
        res.json({ success: true });
    });
});

app.delete('/api/addresses/:id', (req, res) => {
    db.query('DELETE FROM adresses WHERE adress_id = ?', [req.params.id], (err) => {
        if (err) return res.status(500).json(err);
        res.json({ success: true });
    });
});

// reviewlar. 
app.post('/api/reviews', (req, res) => {
    const { book_def_id, listing_id, degerlendiren_kullanici_id, degerlendirilen_kullanici_id, point, comment } = req.body;
    const sql = 'INSERT INTO reviews (book_def_id, listing_id, degerlendiren_kullanici_id, degerlendirilen_kullanici_id, point, `comment`) VALUES (?, ?, ?, ?, ?, ?)';
    db.query(sql, [book_def_id || null, listing_id || null, degerlendiren_kullanici_id, degerlendirilen_kullanici_id, point, comment || null], (err, result) => {
        if (err) return res.status(500).json(err);
        if (book_def_id) {// book_def_id varsa göster.
            db.query('SELECT AVG(point) AS avgp FROM reviews WHERE book_def_id = ?', [book_def_id], (err2, rows) => {
                if (!err2 && rows && rows[0]) {
                    db.query('UPDATE book_definitions SET general_rating = ? WHERE book_def_id = ?', [rows[0].avgp || 0, book_def_id], () => {});
                }
            });
        }
        // user'in ratingini guncelle. 
        db.query('SELECT AVG(point) AS avg_seller FROM reviews WHERE degerlendirilen_kullanici_id = ? AND listing_id IS NOT NULL', [degerlendirilen_kullanici_id], (err3, r1) => {
            const avgSeller = (r1 && r1[0] && r1[0].avg_seller) ? r1[0].avg_seller : 0;
            db.query('UPDATE users SET seller_user_rating = ? WHERE user_id = ?', [avgSeller, degerlendirilen_kullanici_id], () => {});
        });

        db.query('SELECT AVG(point) AS avg_customer FROM reviews WHERE degerlendirilen_kullanici_id = ? AND listing_id IS NULL', [degerlendirilen_kullanici_id], (err4, r2) => {
            const avgCustomer = (r2 && r2[0] && r2[0].avg_customer) ? r2[0].avg_customer : 0;
            db.query('UPDATE users SET customer_user_rating = ? WHERE user_id = ?', [avgCustomer, degerlendirilen_kullanici_id], () => {});
        });
        res.json({ success: true, insertId: result.insertId });
    });
});

app.get('/api/reviews', (req, res) => { // reviewlari al
    const { book_def_id, listing_id } = req.query;
    if (listing_id) {
        db.query('SELECT * FROM reviews WHERE listing_id = ?', [listing_id], (err, results) => {
            if (err) return res.status(500).json(err);
            res.json(results);
        });
        return;
    }
    if (book_def_id) {
        db.query('SELECT * FROM reviews WHERE book_def_id = ?', [book_def_id], (err, results) => {
            if (err) return res.status(500).json(err);
            res.json(results);
        });
        return;
    }
    db.query('SELECT * FROM reviews ORDER BY comment_date DESC LIMIT 100', (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

app.listen(PORT, () => { //usunucu baslatici 3000
    console.log(`Sunucu çalışıyor: http://localhost:${PORT}`);
});

// Update listing status (POC)
app.post('/api/listings/:id/status', (req, res) => {
    const { status } = req.body;
    db.query('UPDATE listings SET status = ? WHERE listing_id = ?', [status, req.params.id], (err) => {
        if (err) return res.status(500).json(err);
        res.json({ success: true });
    });
});

// Delete listing
app.delete('/api/listings/:id', (req, res) => {
    db.query('DELETE FROM listings WHERE listing_id = ?', [req.params.id], (err) => {
        if (err) return res.status(500).json(err);
        res.json({ success: true });
    });
});

// Authors / publishers / categories lists
app.get('/api/authors', (req, res) => {
    db.query('SELECT * FROM authors ORDER BY author_name', (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

app.get('/api/publishers', (req, res) => {
    db.query('SELECT * FROM publishers ORDER BY publisher_name', (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});

app.get('/api/categories', (req, res) => {
    db.query('SELECT * FROM categories ORDER BY category_name', (err, results) => {
        if (err) return res.status(500).json(err);
        res.json(results);
    });
});