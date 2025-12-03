const mysql = require('mysql2/promise');
(async ()=>{
  const pool = mysql.createPool({ host: 'localhost', port: 3306, user: 'root', password: 'Allah123!', database: 'kitaplik_deneme_db' });
  const sql = `SELECT o.offer_id,l.listing_id,bd.title as book_title,l.owner_user_id,u.user_name as owner_name,o.requester_id,ur.user_name as requester_name,o.status,o.offer_date,o.price FROM offers o JOIN listings l ON o.listing_id=l.listing_id JOIN book_definitions bd ON l.book_def_id=bd.book_def_id JOIN users u ON l.owner_user_id=u.user_id LEFT JOIN users ur ON o.requester_id=ur.user_id ORDER BY o.offer_date DESC LIMIT 200`;
  try{
    const [rows] = await pool.query(sql);
    console.log(JSON.stringify(rows, null, 2));
  }catch(e){console.error(e)}
  process.exit();
})();
