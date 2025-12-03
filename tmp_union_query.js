const mysql = require('mysql2/promise');
(async ()=>{
  const pool = mysql.createPool({ host: 'localhost', user: 'root', password: 'Allah123!', database: 'kitaplik_deneme_db' });
  const userId = 2;
  const buyerSql = `SELECT o.offer_id,l.listing_id,bd.book_def_id,bd.title AS book_title,o.price AS amount,o.status,o.offer_date AS process_date,'buyer' AS role,u_owner.user_name AS counterparty_user_name,u_owner.user_id AS counterparty_user_id FROM offers o JOIN listings l ON o.listing_id = l.listing_id JOIN book_definitions bd ON l.book_def_id = bd.book_def_id JOIN users u_owner ON l.owner_user_id = u_owner.user_id WHERE o.requester_id = ?`;
  const sellerSql = `SELECT o.offer_id,l.listing_id,bd.book_def_id,bd.title AS book_title,o.price AS amount,o.status,o.offer_date AS process_date,'seller' AS role,u_buyer.user_name AS counterparty_user_name,u_buyer.user_id AS counterparty_user_id FROM offers o JOIN listings l ON o.listing_id = l.listing_id JOIN book_definitions bd ON l.book_def_id = bd.book_def_id JOIN users u_buyer ON o.requester_id = u_buyer.user_id WHERE l.owner_user_id = ?`;
  const unionSql = `(${buyerSql}) UNION ALL (${sellerSql}) ORDER BY process_date DESC`;
  try{
    const [rows] = await pool.query(unionSql, [userId, userId]);
    console.log(JSON.stringify(rows, null, 2));
  }catch(e){ console.error('ERR', e); }
  await pool.end();
  process.exit();
})();
