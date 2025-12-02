const express = require('express');
const mysql = require('mysql2/promise'); // using promise version for async/await
const path = require('path');
const cors = require('cors');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json()); 
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

const pool = mysql.createPool({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'Allah123!',
    database: 'kitaplik_deneme_db',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

(async () => {
    try {
        const connection = await pool.getConnection();
        console.log('MySQL Veritabanına Başarıyla Bağlandı!');
        connection.release();
    } catch (err) {
        console.error('DB Bağlantı Hatası:', err);
    }
})();

//
app.get('/api/catalog', async (req, res) => { // katalog
    try {
        const { q, isbn } = req.query;
        let sql = `
            SELECT bd.book_def_id, bd.isbn, bd.title, a.author_name, bd.general_rating,
                   COUNT(CASE WHEN b.status = 'Yayinda' THEN 1 END) AS total_listings_available
            FROM book_definitions bd
            LEFT JOIN listings b ON bd.book_def_id = b.book_def_id
            LEFT JOIN authors a ON bd.author_id = a.author_id
        `;
        let params = [];

        if (isbn) {
            sql += ` WHERE bd.isbn = ? GROUP BY bd.book_def_id`;
            params = [isbn];
        } else if (q) {
            const like = `%${q}%`;
            sql += ` WHERE bd.title LIKE ? OR a.author_name LIKE ? OR bd.isbn LIKE ? GROUP BY bd.book_def_id`;
            params = [like, like, like];
        } else {
            sql += ` GROUP BY bd.book_def_id`;
        }

        const [results] = await pool.query(sql, params);
        res.json(results);
    } catch (err) {
        console.error(err);
        res.status(500).json(err);
    }
});

app.get('/api/listings', async (req, res) => { // listings with optional sorting
    try {
        const { q, isbn, sort } = req.query;
        let sql = `
            SELECT l.listing_id, bd.title, u.user_name as seller, l.condition, l.status, l.price, bd.general_rating
            FROM listings l
            JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
            JOIN users u ON l.owner_user_id = u.user_id
            LEFT JOIN authors a ON bd.author_id = a.author_id
            WHERE l.status = 'Yayinda'
        `;
        const params = [];

        if (isbn) {
            sql += ` AND bd.isbn = ?`;
            params.push(isbn);
        } else if (q) {
            const like = `%${q}%`;
            sql += ` AND (bd.title LIKE ? OR a.author_name LIKE ? OR bd.isbn LIKE ?)`;
            params.push(like, like, like);
        }

        // Sorting
        let orderClause = 'l.listing_id DESC'; // default: newest by id desc
        switch ((sort || '').toLowerCase()) {
            case 'price_asc': orderClause = 'l.price ASC'; break;
            case 'price_desc': orderClause = 'l.price DESC'; break;
            case 'rating': orderClause = 'bd.general_rating DESC'; break;
            case 'alpha': orderClause = 'bd.title ASC'; break;
            case 'newest': orderClause = 'l.listing_id DESC'; break;
        }

        sql += ` ORDER BY ${orderClause}`;

        const [results] = await pool.query(sql, params);
        res.json(results);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/listings/:id', async (req, res) => {
    try {
        const sql = `
            SELECT l.*, bd.title, u.user_name, u.seller_user_rating as seller_user_rating, u.user_id as owner_user_id
            FROM listings l
            JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
            JOIN users u ON l.owner_user_id = u.user_id
            WHERE l.listing_id = ?
        `;
        const [results] = await pool.query(sql, [req.params.id]);
        res.json(results[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.post('/api/listings', async (req, res) => {  // create listing
    try {
        const { owner_user_id, book_def_id, price, condition, explanation } = req.body;
        await pool.query(
            `INSERT INTO listings (owner_user_id, book_def_id, price, \`condition\`, explanation, status) VALUES (?, ?, ?, ?, ?, 'Yayinda')`,
            [owner_user_id, book_def_id, price, condition, explanation]
        );
        res.json({ success: true });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.put('/api/listings/:id', async (req, res) => { // update listing
    try {
        const { condition, explanation, price } = req.body;
        await pool.query('UPDATE listings SET `condition` = ?, explanation = ?, price = ? WHERE listing_id = ?', 
            [condition, explanation, price, req.params.id]
        );
        res.json({ success: true });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.post('/api/listings/:id/status', async (req, res) => { 
    try {
        const { status } = req.body;
        await pool.query('UPDATE listings SET status = ? WHERE listing_id = ?', [status, req.params.id]);
        res.json({ success: true });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.delete('/api/listings/:id', async (req, res) => { // delete listing 
    try {
        await pool.query('DELETE FROM listings WHERE listing_id = ?', [req.params.id]);
        res.json({ success: true });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/listings/:id/offers', async (req, res) => { // teklifler/offerlar
    try {
        const sql = `SELECT o.*, u.user_name as requester_name FROM offers o JOIN users u ON o.requester_id = u.user_id WHERE o.listing_id = ? ORDER BY o.offer_date DESC`;
        const [results] = await pool.query(sql, [req.params.id]);
        res.json(results);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.post('/api/offers', async (req, res) => {
    try {
        const { listing_id, requester_id, offer_type, price, payment_type, deliver_type, lending_duration } = req.body;
        const [rows] = await pool.query('SELECT owner_user_id FROM listings WHERE listing_id = ?', [listing_id]);
        if (rows.length === 0) return res.status(404).json({ message: 'Listing not found' });
        if (rows[0].owner_user_id === parseInt(requester_id)) return res.status(400).json({ message: 'Kendi ilanına teklif veremezsiniz' }); // kendi ilanına teklif veremezsin
        const sql = 'INSERT INTO offers (listing_id, requester_id, offer_type, price, payment_type, deliver_type, lending_duration) VALUES (?,?,?,?,?,?,?)';
        const [result] = await pool.query(sql, [listing_id, requester_id, offer_type, price, payment_type, deliver_type, lending_duration || null]);
        res.json({ success: true, insertId: result.insertId });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.post('/api/offers/:id/accept', async (req, res) => { //accept offer, while rejecting others 
    const connection = await pool.getConnection(); 
    try {
        await connection.beginTransaction();
        const offerId = req.params.id;
        const [offers] = await connection.query('SELECT * FROM offers WHERE offer_id = ?', [offerId]);
        if (offers.length === 0) throw new Error('Offer not found');
        
        const offer = offers[0];
        const listingId = offer.listing_id;

        await connection.query("UPDATE offers SET status = 'Onaylandı' WHERE offer_id = ?", [offerId]);
        await connection.query("UPDATE offers SET status = 'Pasif' WHERE listing_id = ? AND offer_id != ? AND status = 'Aktif'", [listingId, offerId]);
        await connection.query("UPDATE listings SET status = 'İşlemde' WHERE listing_id = ?", [listingId]);
        if (offer.offer_type && offer.offer_type.toLowerCase().includes('sat')) await connection.query('INSERT INTO purchase_processes (offer_id, status) VALUES (?, ?)', [offerId, 'Talep Edildi']);
        else {
            const duration = offer.lending_duration;
            if (duration) await connection.query(`INSERT INTO other_processes (offer_id, process_start_date, process_finish_date, status) VALUES (?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL ? DAY), ?)`, [offerId, duration, 'Talep Edildi']);
            else await connection.query('INSERT INTO other_processes (offer_id, process_start_date, status) VALUES (?, CURDATE(), ?)', [offerId, 'Talep Edildi']);
        }
        await connection.commit();
        res.json({ success: true });
    } catch (err) {
        await connection.rollback();
        console.error("Transaction Failed:", err);
        res.status(500).json({ error: err.message });
    } finally {
        connection.release();
    }
});

app.post('/api/offers/:id/reject', async (req, res) => {
    try {
        await pool.query("UPDATE offers SET status = 'Reddedildi' WHERE offer_id = ?", [req.params.id]);
        res.json({ success: true });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/offers/:id', async (req, res) => { 
    try {
        const sql = `SELECT o.*, bd.title, u.user_name as requester_name 
                     FROM offers o 
                     JOIN listings l ON o.listing_id = l.listing_id
                     JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
                     JOIN users u ON o.requester_id = u.user_id
                     WHERE o.offer_id = ?`;
        const [results] = await pool.query(sql, [req.params.id]);
        res.json(results[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/active-offers', async (req, res) => {
    try {
        const [results] = await pool.query('SELECT * FROM view_active_offers');
        res.json(results);
    } catch (err) {
        res.status(500).json(err);
    }
});

// userlar ve authentication
app.post('/api/login', async (req, res) => {
    try {
        //hem email hem user_name 'email'le temsil ediliyp
        const { email, password } = req.body;
        
        const sql = 'SELECT * FROM users WHERE email = ? OR user_name = ?';
        const [users] = await pool.query(sql, [email, email]); 

        if (users.length === 0) {
            return res.status(404).json({ success: false, errorType: 'USER_NOT_FOUND', message: 'Böyle bir hesap yok, lütfen kayıt olun.' });
        }
        const user = users[0];
        if (user.password === password) {
            res.json({ success: true, user: user });
        } else {
            res.status(401).json({ success: false, errorType: 'WRONG_PASSWORD', message: 'Şifre hatalı!' });
        }

    } catch (err) {
        console.error(err);
        res.status(500).json(err);
    }
});

app.post('/api/register', async (req, res) => {
    try {
        const { name, surname, user_name, email, password } = req.body;
        // check uniqueness for email and user_name
        const [exists] = await pool.query('SELECT * FROM users WHERE email = ? OR user_name = ? LIMIT 1', [email, user_name]);
        if (exists.length > 0) {
            const u = exists[0];
            if (u.email === email) return res.status(400).json({ success: false, errorType: 'EMAIL_TAKEN', message: 'Bu email zaten kullanılıyor.' });
            if (u.user_name === user_name) return res.status(400).json({ success: false, errorType: 'USERNAME_TAKEN', message: 'Bu kullanıcı adı zaten alınmış.' });
            return res.status(400).json({ success: false, message: 'Kullanıcı bilgileri çakışıyor.' });
        }

        const [result] = await pool.query('INSERT INTO users (name, surname, user_name, email, password) VALUES (?,?,?,?,?)', [name, surname, user_name, email, password]);
        res.json({ success: true, insertId: result.insertId });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/user/username/:username', async (req, res) => {
    try {
        const [results] = await pool.query('SELECT * FROM users WHERE user_name = ?', [req.params.username]);
        if (results.length === 0) return res.status(404).json({ message: 'User not found' });
        res.json(results[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/user/:id', async (req, res) => { // profile detail
    try {
        const userId = req.params.id;
        const [users] = await pool.query('SELECT * FROM users WHERE user_id = ?', [userId]);
        const [listings] = await pool.query('SELECT l.*, bd.title FROM listings l JOIN book_definitions bd ON l.book_def_id = bd.book_def_id WHERE l.owner_user_id = ?', [userId]);
        const [offers] = await pool.query(`
            SELECT o.*, bd.title, u.user_name as requester_name 
            FROM offers o 
            JOIN listings l ON o.listing_id = l.listing_id 
            JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
            JOIN users u ON o.requester_id = u.user_id
            WHERE l.owner_user_id = ? AND o.status = 'Aktif'
        `, [userId]);

        res.json({
            user: users[0],
            listings: listings,
            offers: offers
        });
    } catch (err) {
        res.status(500).json(err);
    }
});

// Update user profile
app.put('/api/user/:id', async (req, res) => {
    try {
        const userId = req.params.id;
        const { name, surname, user_name, email, password } = req.body;

        // Basic validation: ensure required fields
        if (!user_name || !email) return res.status(400).json({ success: false, message: 'Kullanıcı adı ve email gerekli.' });

        // Check uniqueness: email or username used by another user?
        const [conflicts] = await pool.query('SELECT * FROM users WHERE (email = ? OR user_name = ?) AND user_id != ? LIMIT 1', [email, user_name, userId]);
        if (conflicts.length > 0) {
            const u = conflicts[0];
            if (u.email === email) return res.status(400).json({ success: false, errorType: 'EMAIL_TAKEN', message: 'Bu email başka bir kullanıcı tarafından kullanılıyor.' });
            if (u.user_name === user_name) return res.status(400).json({ success: false, errorType: 'USERNAME_TAKEN', message: 'Bu kullanıcı adı başka bir kullanıcı tarafından alınmış.' });
            return res.status(400).json({ success: false, message: 'Kullanıcı bilgileri çakışıyor.' });
        }

        // Perform update
        const params = password ? [name, surname, user_name, email, password, userId] : [name, surname, user_name, email, userId];
        const sql = 'UPDATE users SET name = ?, surname = ?, user_name = ?, email = ?' + (password ? ', password = ?' : '') + ' WHERE user_id = ?';
        const [result] = await pool.query(sql, params);
        res.json({ success: true, affectedRows: result.affectedRows });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/user/:id/orders', async (req, res) => { 
    try {
        const sql = `
            SELECT o.offer_id, l.listing_id, bd.book_def_id, l.owner_user_id as seller_user_id, bd.title, o.status, o.offer_date as process_date, o.price
            FROM offers o
            JOIN listings l ON o.listing_id = l.listing_id
            JOIN book_definitions bd ON l.book_def_id = bd.book_def_id
            WHERE o.requester_id = ?
            ORDER BY o.offer_date DESC
        `;
        const [results] = await pool.query(sql, [req.params.id]);
        res.json(results);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.post('/api/books', async (req, res) => { // book definitions
    try {
        const { isbn, title, author, publisher, category } = req.body;
        const getOrInsert = async (table, col, val) => {
            if (!val) return null;
            const [rows] = await pool.query(`SELECT * FROM ${table} WHERE ${col} = ? LIMIT 1`, [val]);
            if (rows.length > 0) return rows[0][col.replace('_name', '_id')]; 
            
            const [res] = await pool.query(`INSERT INTO ${table} (${col}) VALUES (?)`, [val]);
            return res.insertId;
        };

        const author_id = await getOrInsert('authors', 'author_name', author);
        const publisher_id = await getOrInsert('publishers', 'publisher_name', publisher);
        const category_id = await getOrInsert('categories', 'category_name', category);
        const [result] = await pool.query(
            `INSERT INTO book_definitions (isbn, title, author_id, publisher_id, category_id) VALUES (?, ?, ?, ?, ?)`,
            [isbn || null, title || null, author_id, publisher_id, category_id]
        );

        res.json({ success: true, insertId: result.insertId });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.post('/api/addresses', async (req, res) => {  // adresler 
    try {
        const { user_id, county_id, adress_name, adress_detail } = req.body;
        const [result] = await pool.query('INSERT INTO adresses (user_id, county_id, adress_name, adress_detail) VALUES (?, ?, ?, ?)', 
            [user_id, county_id, adress_name, adress_detail]
        );
        res.json({ success: true, insertId: result.insertId });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/user/:id/addresses', async (req, res) => {
    try {
        const sql = `SELECT a.*, cnt.county_name, ci.city_name, co.country_name FROM adresses a JOIN counties cnt ON a.county_id = cnt.county_id JOIN cities ci ON cnt.city_id = ci.city_id JOIN countries co ON ci.country_id = co.country_id WHERE a.user_id = ?`;
        const [results] = await pool.query(sql, [req.params.id]);
        res.json(results);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/addresses/:id', async (req, res) => {
    try {
        const [results] = await pool.query('SELECT a.*, cnt.county_name, ci.city_name, co.country_name FROM adresses a JOIN counties cnt ON a.county_id = cnt.county_id JOIN cities ci ON cnt.city_id = ci.city_id JOIN countries co ON ci.country_id = co.country_id WHERE a.adress_id = ?', [req.params.id]);
        if (results.length === 0) return res.status(404).json({ message: 'Address not found' });
        res.json(results[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.put('/api/addresses/:id', async (req, res) => {
    try {
        const { county_id, adress_name, adress_detail } = req.body;
        await pool.query('UPDATE adresses SET county_id = ?, adress_name = ?, adress_detail = ? WHERE adress_id = ?', 
            [county_id, adress_name, adress_detail, req.params.id]
        );
        res.json({ success: true });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.delete('/api/addresses/:id', async (req, res) => {
    try {
        await pool.query('DELETE FROM adresses WHERE adress_id = ?', [req.params.id]);
        res.json({ success: true });
    } catch (err) {
        res.status(500).json(err);
    }
});

// reviewlar ve ratingler
app.post('/api/reviews', async (req, res) => {
    try {
        const { book_def_id, listing_id, degerlendiren_kullanici_id, degerlendirilen_kullanici_id, point, comment } = req.body;

        // First, check if this reviewer already left a review for this listing or book
        let existing = [];
        if (listing_id) {
            const [rows] = await pool.query('SELECT * FROM reviews WHERE listing_id = ? AND degerlendiren_kullanici_id = ? LIMIT 1', [listing_id, degerlendiren_kullanici_id]);
            existing = rows;
        } else if (book_def_id) {
            const [rows] = await pool.query('SELECT * FROM reviews WHERE book_def_id = ? AND degerlendiren_kullanici_id = ? AND listing_id IS NULL LIMIT 1', [book_def_id, degerlendiren_kullanici_id]);
            existing = rows;
        }

        let reviewId = null;
        if (existing && existing.length > 0) {
            // Update existing review (user edits their previous review)
            const rev = existing[0];
            await pool.query('UPDATE reviews SET point = ?, `comment` = ?, comment_date = NOW() WHERE review_id = ?', [point, comment || null, rev.review_id]);
            reviewId = rev.review_id;
        } else {
            const sql = 'INSERT INTO reviews (book_def_id, listing_id, degerlendiren_kullanici_id, degerlendirilen_kullanici_id, point, `comment`) VALUES (?, ?, ?, ?, ?, ?)';
            const [result] = await pool.query(sql, [book_def_id || null, listing_id || null, degerlendiren_kullanici_id, degerlendirilen_kullanici_id, point, comment || null]);
            reviewId = result.insertId;
        }

        // Recalculate aggregates
        if (book_def_id) { // update book rating
            const [rows] = await pool.query('SELECT AVG(point) AS avgp FROM reviews WHERE book_def_id = ?', [book_def_id]);
            if (rows.length > 0) await pool.query('UPDATE book_definitions SET general_rating = ? WHERE book_def_id = ?', [rows[0].avgp || 0, book_def_id]);
        }

        // update user ratings
        const [r1] = await pool.query('SELECT AVG(point) AS avg_seller FROM reviews WHERE degerlendirilen_kullanici_id = ? AND listing_id IS NOT NULL', [degerlendirilen_kullanici_id]);
        await pool.query('UPDATE users SET seller_user_rating = ? WHERE user_id = ?', [r1[0].avg_seller || 0, degerlendirilen_kullanici_id]);

        // update customer rating
        const [r2] = await pool.query('SELECT AVG(point) AS avg_customer FROM reviews WHERE degerlendirilen_kullanici_id = ? AND listing_id IS NULL', [degerlendirilen_kullanici_id]);
        await pool.query('UPDATE users SET customer_user_rating = ? WHERE user_id = ?', [r2[0].avg_customer || 0, degerlendirilen_kullanici_id]);

        res.json({ success: true, reviewId });
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/reviews', async (req, res) => {
    try {
        const { book_def_id, listing_id } = req.query;
        if (listing_id) {
            const [results] = await pool.query('SELECT * FROM reviews WHERE listing_id = ?', [listing_id]);
            return res.json(results);
        }
        if (book_def_id) {
            const [results] = await pool.query('SELECT * FROM reviews WHERE book_def_id = ?', [book_def_id]);
            return res.json(results);
        }
        const [results] = await pool.query('SELECT * FROM reviews ORDER BY comment_date DESC LIMIT 100');
        res.json(results);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/user/:id/reviews', async (req, res) => { // bir kişinin aldığı yorumlar
    try {
        const userId = req.params.id;
        const sql = `
            SELECT r.*, u.user_name as reviewer_name, bd.title as book_title, l.listing_id
            FROM reviews r
            JOIN users u ON r.degerlendiren_kullanici_id = u.user_id
            LEFT JOIN book_definitions bd ON r.book_def_id = bd.book_def_id
            LEFT JOIN listings l ON r.listing_id = l.listing_id
            WHERE r.degerlendirilen_kullanici_id = ?
            ORDER BY r.comment_date DESC
        `;
        const [results] = await pool.query(sql, [userId]);
        res.json(results);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.get('/api/countries', async (req, res) => {
    const [results] = await pool.query('SELECT * FROM countries');
    res.json(results);
});

app.get('/api/cities/:countryId', async (req, res) => {
    const [results] = await pool.query('SELECT * FROM cities WHERE country_id = ?', [req.params.countryId]);
    res.json(results);
});

app.get('/api/counties/:cityId', async (req, res) => {
    const [results] = await pool.query('SELECT * FROM counties WHERE city_id = ?', [req.params.cityId]);
    res.json(results);
});

app.get('/api/authors', async (req, res) => {
    const [results] = await pool.query('SELECT * FROM authors ORDER BY author_name');
    res.json(results);
});

app.get('/api/publishers', async (req, res) => {
    const [results] = await pool.query('SELECT * FROM publishers ORDER BY publisher_name');
    res.json(results);
});

app.get('/api/categories', async (req, res) => {
    const [results] = await pool.query('SELECT * FROM categories ORDER BY category_name');
    res.json(results);
});

// serveri başlat
app.listen(PORT, () => { console.log(`Sunucu çalışıyor: http://localhost:${PORT}`); });