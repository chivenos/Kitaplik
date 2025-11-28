document.addEventListener('DOMContentLoaded', () => {
    const path = window.location.pathname;
    const user = JSON.parse(localStorage.getItem('user'));

    updateNav(user);

    if (path.includes('catalog.html')) loadCatalog();
    else if (path.includes('listings.html')) loadListings();
    else if (path.includes('profile.html')) loadProfile(user);
    else if (path.includes('manage-listing.html')) setupManageListingPage(user);
    else if (path.includes('offer.html')) setupOfferPage(user);
    else if (path.includes('add-listing.html')) setupAddListingPage(user);
    else if (path.includes('edit-address.html')) setupEditAddressPage(user);
    else if (path.includes('add-book-def.html')) setupAddBookDefPage(user);
    else if (path.includes('offer-detail.html')) setupOfferDetailPage(user);
    else if (path.includes('my-orders.html')) loadMyOrders(user);
    else if (path.includes('leave-review.html')) setupLeaveReviewPage(user);
    
    if (document.getElementById('loginBtn')) document.getElementById('loginBtn').addEventListener('click', handleLogin);
    if (document.getElementById('registerBtn')) document.getElementById('registerBtn').addEventListener('click', handleRegister);
});

function updateNav(user) {
    const navDiv = document.querySelector('nav div:last-child') || document.getElementById('nav-links');
    if (!navDiv) return;
    
    if (user) {
        navDiv.innerHTML = `
            <a href="index.html">Ana Sayfa</a>
            <a href="catalog.html">Katalog</a>
            <a href="listings.html">İlanlar</a>
            <a href="profile.html">Profil (${user.user_name})</a>
            <a href="#" onclick="logout()">Çıkış</a>
        `;
    } else {
        navDiv.innerHTML = `
            <a href="index.html">Ana Sayfa</a>
            <a href="catalog.html">Katalog</a>
            <a href="listings.html">İlanlar</a>
            <a href="login.html">Giriş Yap</a>
        `;
    }
}
function logout() { localStorage.removeItem('user'); window.location.href = 'index.html'; }

async function apiFetch(url, options = {}) {
    try {
        const res = await fetch(url, options);
        return await res.json();
    } catch (e) { console.error("API Hatası:", e); return []; }
}
// katalog
async function loadCatalog() {
    const params = new URLSearchParams(window.location.search);
    const isbnParam = params.get('isbn');
    let url = '/api/catalog';
    if (isbnParam) {
        url += `?isbn=${encodeURIComponent(isbnParam)}`;
    } else {
        const searchInput = document.getElementById('searchTitle');
        if (searchInput && searchInput.value && searchInput.value.trim() !== '') {
            url += `?q=${encodeURIComponent(searchInput.value.trim())}`;
        }
    }
    const data = await apiFetch(url);
    const container = document.getElementById('catalog-container');
    if (!container) return;
    
    if (!Array.isArray(data) || data.length === 0) {
        container.innerHTML = '<p>Katalogda sonuç bulunamadı.</p>';
        return;
    }
    container.innerHTML = data.map(book => `
        <div class="item">
            <b>${book.title}</b><br>
            ${book.author_name || ''}<br>
            ISBN: ${book.isbn}<br>
            <span class="tag sale">Aktif İlan: ${book.total_listings_available || 0}</span>
            <br><br>
            <a href="listings.html?isbn=${book.isbn}">İlanları Gör</a>
        </div>
    `).join('');
}

async function loadListings() { //ilanlar
    const params = new URLSearchParams(window.location.search);
    const isbnParam = params.get('isbn');
    let url = '/api/listings';
    if (isbnParam) {
        url += `?isbn=${encodeURIComponent(isbnParam)}`;
    } else {
        const searchInput = document.getElementById('listingSearch');
        if (searchInput && searchInput.value && searchInput.value.trim() !== '') {
            const q = searchInput.value.trim();
            url += `?q=${encodeURIComponent(q)}`;
        }
    }
    const data = await apiFetch(url);
    const container = document.getElementById('listings-container');
    if (!container) return;

    container.innerHTML = data.map(l => `
        <div class="item list-row">
            <img src="img/book1.jpg">
            <div>
                <b>${l.title}</b><br>
                Satıcı: ${l.seller}<br>
                Durum: ${l.condition}<br>
                <a href="offer.html?listing=${l.listing_id}">Teklif Ver</a>
            </div>
        </div>
    `).join('');
}

async function loadProfile(user) { //profil
    if (!user) return window.location.href = 'login.html';
    const data = await apiFetch(`/api/user/${user.user_id}`);
    document.getElementById('profile-username').innerText = data.user.user_name;
    document.getElementById('profile-name').innerText = `${data.user.name} ${data.user.surname}`;
    document.getElementById('seller-rating').innerText = data.user.seller_user_rating;

    // İlanlar
    const listDiv = document.getElementById('my-listings'); // ilanlar
    if (data.listings.length === 0) listDiv.innerHTML = '<p>Aktif ilanınız yok.</p>';
    else {
        listDiv.innerHTML = data.listings.map(l => `
            <div class="list-row">
                <img src="img/book1.jpg" width="50">
                <div>
                    <b>${l.title}</b><br>
                    Durum: ${l.status}<br>
                    <a class="btn" href="manage-listing.html?id=${l.listing_id}">Yönet</a>
                </div>
            </div>
        `).join('');
    }

    const offerDiv = document.getElementById('incoming-offers'); //teklifler
    if (data.offers.length === 0) offerDiv.innerHTML = '<p>Bekleyen teklif yok.</p>';
    else {
        offerDiv.innerHTML = data.offers.map(o => `
            <div class="offer-box" style="border:1px solid #eee; padding:10px; margin-bottom:10px;">
                <b>Kitap:</b> ${o.title}<br>
                <b>Teklif Veren:</b> ${o.requester_name}<br>
                <b>Fiyat:</b> ${o.price}₺ (${o.offer_type})<br>
                <a class="btn" href="offer-detail.html?id=${o.offer_id}" style="margin-top:5px;">İncele</a>
            </div>
        `).join('');
    }
    loadAddresses(user.user_id); // adresler
}

async function setupAddListingPage(user) { // yeni ilan ekleme
    if (!user) return window.location.href = 'login.html';
    
    const books = await apiFetch('/api/catalog'); // Catalog endpointi tüm kitapları döner
    const select = document.getElementById('bookSelect');
    
    const validBooks = books.filter(b => b.book_def_id !== null && b.book_def_id !== undefined && b.book_def_id !== '');
    
    if (validBooks.length > 0) select.innerHTML = '<option value="">-- Kitap Seçin --</option>' + validBooks.map(b => `<option value="${b.book_def_id}">${b.title} (${b.author_name || 'Yazar Bilinmiyor'})</option>`).join('');
    else select.innerHTML = '<option value="">Katalogda hiç kitap bulunmuyor.</option>';
    
    document.getElementById('addListingBtn').onclick = async () => {
        const body = {
            owner_user_id: user.user_id,
            book_def_id: select.value,
            price: document.getElementById('listingPrice').value,
            condition: document.getElementById('listingCondition').value,
            explanation: document.getElementById('listingDesc').value
        };

        if (!body.book_def_id) {
            alert('Lütfen bir kitap seçiniz.');
            return;
        }
        
        const res = await fetch('/api/listings', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(body)
        });
        
        if (res.ok) { 
            alert('İlan başarıyla eklendi!'); 
            window.location.href = 'profile.html';
        } else {
            const err = await res.json();
            console.error('İlan eklenirken hata:', err);
            alert('İlan eklenirken bir hata oluştu. Lütfen bilgileri kontrol edin.');
        }
    };
}

function setupAddBookDefPage(user) { // yeni kitap tanımlama
    document.getElementById('saveBookDefBtn').onclick = async () => {
        const body = {
            isbn: document.getElementById('newIsbn').value,
            title: document.getElementById('newTitle').value,
            author: document.getElementById('newAuthor').value,
            publisher: document.getElementById('newPublisher').value,
            category: document.getElementById('newCategory').value
        };

        const res = await fetch('/api/books', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(body)
        });

        if (res.ok) { alert('Kitap kataloğa eklendi!'); window.location.href = 'add-listing.html'; }
    };
}

async function setupOfferDetailPage(user) {
    const params = new URLSearchParams(window.location.search);
    const offerId = params.get('id');
    const offer = await apiFetch(`/api/offers/${offerId}`); // teklif detayını çek (Server.js'de /api/offers/:id olmalı)
    
    const container = document.getElementById('offer-detail-container');
    container.innerHTML = `
        <p><b>Kitap:</b> ${offer.title || 'Bilinmiyor'}</p>
        <p><b>Teklif Veren:</b> ${offer.requester_name}</p>
        <p><b>Tutar:</b> ${offer.price}₺</p>
        <p><b>Tip:</b> ${offer.offer_type}</p>
        <p><b>Ödeme:</b> ${offer.payment_type}</p>
    `;

    const actions = document.getElementById('action-buttons'); // sadece ilan sahibi onaylayabilir
    actions.style.display = 'block';

    document.getElementById('acceptOfferBtn').onclick = async () => {
        await fetch(`/api/offers/${offerId}/accept`, { method: 'POST' });
        alert('Teklif kabul edildi!');
        window.location.href = 'profile.html';
    };
    
    document.getElementById('rejectOfferBtn').onclick = async () => {
        await fetch(`/api/offers/${offerId}/reject`, { method: 'POST' });
        alert('Teklif reddedildi.');
        window.location.href = 'profile.html';
    };
}

async function loadMyOrders(user) { // sipraisler
    if (!user) return;    
    const orders = await apiFetch(`/api/user/${user.user_id}/orders`); 
    const container = document.getElementById('my-orders-container');
    
    if (orders.length === 0) container.innerHTML = 'İşlem geçmişiniz boş.';
    else {
        container.innerHTML = orders.map(o => `
            <div class="process-card">
                <b>${o.title}</b><br>
                Durum: <span class="status-badge">${o.status}</span><br>
                Tarih: ${new Date(o.process_date).toLocaleDateString()}
            </div>
        `).join('');
    }
}

async function handleLogin(e) {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    const res = await fetch('/api/login', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({email, password})
    });
    const result = await res.json();
    if (result.success) {
        localStorage.setItem('user', JSON.stringify(result.user));
        window.location.href = 'profile.html';
    } else { alert('Hatalı giriş!'); }
}

async function handleRegister(e) {
    e.preventDefault();
    const body = {
        name: document.getElementById('regName').value,
        surname: document.getElementById('regSurname').value,
        user_name: document.getElementById('regUsername').value,
        email: document.getElementById('regEmail').value,
        password: document.getElementById('regPassword').value
    };
    const res = await fetch('/api/register', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(body)
    });
    if (res.ok) { alert('Kayıt başarılı! Giriş yapınız.'); window.location.href = 'login.html'; }
    else alert('Kayıt hatası.');
}

async function setupOfferPage(user) { 
    if (!user) { alert('Giriş yapmalısın!'); window.location.href = 'login.html'; return; }
    const params = new URLSearchParams(window.location.search);
    const listingId = params.get('listing');
    const listing = await apiFetch(`/api/listings/${listingId}`);
    
    document.getElementById('summary-book').innerText = listing.title;
    document.getElementById('summary-seller').innerText = listing.user_name;
    document.getElementById('summary-condition').innerText = listing.condition;
    document.getElementById('summary-price').innerText = listing.price || '-';

    document.getElementById('submitOfferBtn').onclick = async () => {
        const body = {
            listing_id: listingId,
            requester_id: user.user_id,
            offer_type: document.getElementById('offerType').value,
            price: document.getElementById('offerPrice').value,
            payment_type: document.getElementById('paymentType').value,
            deliver_type: document.getElementById('deliverType').value
        };
        const res = await fetch('/api/offers', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(body)
        });
        if (res.ok) { alert('Teklif gönderildi!'); window.location.href = 'profile.html'; }
    };
}

async function setupLeaveReviewPage(user) {
    if (!user) return window.location.href = 'login.html';

    const sellerElem = document.querySelector('.item p b');
    const sellerUsername = sellerElem ? sellerElem.innerText.trim() : null;
    let reviewedUserId = null;
    if (sellerUsername) {
        try {
            const u = await apiFetch(`/api/user/username/${encodeURIComponent(sellerUsername)}`);
            reviewedUserId = u.user_id;
        } catch (e) { console.warn('Seller lookup failed', e); }
    }

    document.getElementById('submitReviewBtn').onclick = async (e) => {
        e.preventDefault();
        const rating = document.querySelector('input[name="rating"]:checked');
        const point = rating ? parseInt(rating.value, 10) : null;
        const comment = document.getElementById('reviewText').value;

        if (!point) { alert('Lütfen bir puan seçin.'); return; }
        const params = new URLSearchParams(window.location.search);
        const listingId = params.get('listing') || null;

        const body = {
            book_def_id: params.get('book_def') || null,
            listing_id: listingId,
            degerlendiren_kullanici_id: user.user_id,
            degerlendirilen_kullanici_id: reviewedUserId,
            point: point,
            comment: comment
        };

        const res = await fetch('/api/reviews', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(body)
        });
        if (res.ok) { alert('Teşekkürler — değerlendirme kaydedildi.'); window.location.href = 'profile.html'; }
        else { alert('Değerlendirme gönderilirken hata oldu.'); }
    };
}

async function setupManageListingPage(user) { //listing yönetimi
    const params = new URLSearchParams(window.location.search);
    const id = params.get('id');
    if (!id) return document.getElementById('listings-container') && (document.getElementById('listings-container').innerText = 'İlan ID eksik.');

    const listing = await apiFetch(`/api/listings/${id}`);
    if (!listing) return alert('İlan bulunamadı');

    document.getElementById('listing-title').innerText = listing.title || 'Bilinmiyor';
    document.getElementById('listing-condition').innerText = listing.condition || '-';
    document.getElementById('listing-seller').innerText = listing.user_name || '-';
    document.getElementById('listing-price').innerText = listing.price ? (listing.price + '₺') : '-';

    document.getElementById('manage-desc').value = listing.explanation || '';
    if (listing.price) document.getElementById('manage-price').value = listing.price;
    if (listing.condition) document.getElementById('manage-condition').value = listing.condition;

    const offers = await apiFetch(`/api/listings/${id}/offers`);
    const offersDiv = document.getElementById('manage-offers');
    if (!offers || offers.length === 0) offersDiv.innerHTML = '<p>Bu ilana ait teklif yok.</p>';
    else {
        offersDiv.innerHTML = offers.map(o => `
            <div class="offer-box">
                <p><b>${o.requester_name}</b> — ${o.price}₺ teklif verdi</p>
                <p>Tür: ${o.offer_type || '-'}</p>
                <p>Tarih: ${new Date(o.offer_date).toLocaleDateString()}</p>
                <a class="btn" href="offer-detail.html?id=${o.offer_id}">Teklifi Gör</a>
            </div>
        `).join('');
    }

    document.getElementById('saveListingBtn').onclick = async () => { //kaydet post ile
        const body = {
            condition: document.getElementById('manage-condition').value,
            explanation: document.getElementById('manage-desc').value,
            price: document.getElementById('manage-price').value
        };
        const res = await fetch(`/api/listings/${id}`, {
            method: 'PUT',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(body)
        });
        if (res.ok) { alert('İlan güncellendi.'); window.location.reload(); }
        else { alert('Güncelleme hatası.'); }
    };

    document.getElementById('toggleStatusBtn').onclick = async () => { // durum değiştir
        const newStatus = listing.status === 'Yayinda' ? 'Pasif' : 'Yayinda';
        await fetch(`/api/listings/${id}/status`, { method: 'POST', headers: {'Content-Type':'application/json'}, body: JSON.stringify({status: newStatus}) });
        alert('Durum değiştirildi.'); window.location.reload();
    };

    document.getElementById('deleteListingBtn').onclick = async () => { // ilan sil
        if (!confirm('İlanı silmek istediğinize emin misiniz?')) return;
        await fetch(`/api/listings/${id}`, { method: 'DELETE' });
        alert('İlan silindi.'); window.location.href = 'profile.html';
    };
}

async function loadAddresses(userId) { // adresleri yükle
    const container = document.getElementById('address-container');
    if (!container) return;
    const data = await apiFetch(`/api/user/${userId}/addresses`);
    if (!data || data.length === 0) {
        container.innerHTML = '<p>Adres eklenmemiş.</p>';
        return;
    }
    container.innerHTML = data.map(a => `
        <div style="border:1px solid #eee; padding:10px; margin-bottom:8px;">
            <b>${a.adress_name}</b><br>
            ${a.county_name || ''} / ${a.city_name || ''} / ${a.country_name || ''}<br>
            ${a.adress_detail || ''}<br>
            <a class="btn" href="edit-address.html?id=${a.adress_id}">Düzenle</a>
        </div>
    `).join('');
}

async function setupEditAddressPage(user) { // adres düzenleme
    const params = new URLSearchParams(window.location.search);
    const addrId = params.get('id');
    if (!user) return window.location.href = 'login.html';

    const countries = await apiFetch('/api/countries'); // ülkeleri al
    const countrySelect = document.getElementById('addr-country');
    countrySelect.innerHTML = countries.map(c => `<option value="${c.country_id}">${c.country_name}</option>`).join('');

    document.getElementById('addr-country').onchange = async (e) => {
        const countryId = e.target.value;
        const cities = await apiFetch(`/api/cities/${countryId}`);
        document.getElementById('addr-city').innerHTML = cities.map(ci => `<option value="${ci.city_id}">${ci.city_name}</option>`).join('');
        if (cities.length > 0) {
            const counties = await apiFetch(`/api/counties/${cities[0].city_id}`);
            document.getElementById('addr-county').innerHTML = counties.map(ct => `<option value="${ct.county_id}">${ct.county_name}</option>`).join('');
        }
    };

    document.getElementById('addr-city').onchange = async (e) => {
        const cityId = e.target.value;
        const counties = await apiFetch(`/api/counties/${cityId}`);
        document.getElementById('addr-county').innerHTML = counties.map(ct => `<option value="${ct.county_id}">${ct.county_name}</option>`).join('');
    };

    if (addrId) {
        const addr = await apiFetch(`/api/addresses/${addrId}`);
        if (addr) {
            document.getElementById('addr-name').value = addr.adress_name || '';
            document.getElementById('addr-detail').value = addr.adress_detail || '';
            // select country
            if (addr.country_name) {
                // find country option index by text
                for (const opt of countrySelect.options) if (opt.text === addr.country_name) opt.selected = true;
                // trigger change to load cities
                const event = new Event('change');
                countrySelect.dispatchEvent(event);
                // wait a tick then set city and county (best-effort)
                setTimeout(async () => {
                    const citySelect = document.getElementById('addr-city');
                    for (const opt of citySelect.options) if (opt.text === addr.city_name) opt.selected = true;
                    const cityEvent = new Event('change'); citySelect.dispatchEvent(cityEvent);
                    setTimeout(() => {
                        const countySelect = document.getElementById('addr-county');
                        for (const opt of countySelect.options) if (opt.text === addr.county_name) opt.selected = true;
                    }, 200);
                }, 200);
        }
    }

    document.getElementById('saveAddressBtn').onclick = async () => {
        const body = {
            user_id: user.user_id,
            county_id: document.getElementById('addr-county').value,
            adress_name: document.getElementById('addr-name').value,
            adress_detail: document.getElementById('addr-detail').value
        };
        if (addrId) {
            const res = await fetch(`/api/addresses/${addrId}`, { method: 'PUT', headers: {'Content-Type':'application/json'}, body: JSON.stringify(body) });
            if (res.ok) { alert('Adres güncellendi.'); window.location.href = 'profile.html'; }
            else alert('Adres güncelleme hatası.');
        } else {
            const res = await fetch('/api/addresses', { method: 'POST', headers: {'Content-Type':'application/json'}, body: JSON.stringify(body) });
            if (res.ok) { alert('Adres kaydedildi.'); window.location.href = 'profile.html'; }
            else alert('Adres ekleme hatası.');
        }
    };
    }
}