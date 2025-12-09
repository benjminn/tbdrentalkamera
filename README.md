# 🎥 Sistem Rental Kamera

**Aplikasi web untuk mengelola bisnis penyewaan peralatan kamera**

Dikembangkan oleh **Tim TBD - Universitas Gadjah Mada**

---

## 📋 Tentang Aplikasi

Sistem Rental Kamera adalah aplikasi web modern yang dibangun dengan Next.js dan Supabase untuk mengelola:
- 📦 **Equipment Management** - Kelola inventori kamera dan aksesori
- 👥 **Customer Management** - Database pelanggan lengkap
- 📝 **Rental Transactions** - Buat dan track transaksi sewa
- 💳 **Payment Processing** - Record pembayaran dan deposit
- 📊 **Dashboard & Reports** - Monitoring dan analytics

---

## 🚀 Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/benjminn/tbdrentalkamera.git
cd tbdrentalkamera
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Setup Supabase
1. Buat account di [supabase.com](https://supabase.com)
2. Buat project baru
3. Jalankan script `database_setup.sql` di Supabase SQL Editor
4. Copy Project URL dan API Key

### 4. Environment Variables
Buat file `.env.local` di root folder:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
```

### 5. Run Development Server
```bash
npm run dev
```

Buka [http://localhost:3000](http://localhost:3000)

---

## 🔐 Login Credentials

**Admin Account:**
```
Username: UgmTBD
Password: ugmtebede
```

> ⚠️ **Security Note:** Ubah password default setelah login pertama kali!

---

## 🛠️ Tech Stack

- **Frontend:** Next.js 15, React 19, Tailwind CSS 4
- **Backend:** Supabase (PostgreSQL + Auth + Real-time)
- **UI Components:** Lucide React, React Icons
- **Deployment:** Vercel/Netlify ready

---

## 📁 Struktur Folder

```
tbdrentalkamera/
├── src/
│   ├── app/              # Next.js App Router
│   │   ├── auth/         # Authentication pages
│   │   ├── customers/    # Customer management
│   │   ├── equipment/    # Equipment management
│   │   ├── rentals/      # Rental transactions
│   │   └── payments/     # Payment processing
│   ├── components/       # React components
│   │   ├── Auth/
│   │   ├── Customer/
│   │   ├── Equipment/
│   │   ├── Rental/
│   │   ├── Shared/       # Reusable components
│   │   └── UI/           # UI primitives
│   └── context/          # React Context (Auth)
├── lib/                  # Utilities & Supabase config
├── database_setup.sql    # Database setup script
├── DOKUMENTASI.md        # Full documentation (Bahasa)
└── KREDENSIAL_LOGIN.md   # Login guide
```

---

## ✨ Fitur Utama

### 1. Manajemen Equipment
- ✅ CRUD equipment (kamera, lensa, aksesori)
- ✅ Track serial numbers & kondisi
- ✅ Status: Available/Rented/Maintenance
- ✅ Equipment types dengan pricing

### 2. Manajemen Customer
- ✅ Database pelanggan lengkap
- ✅ Contact information & KTP
- ✅ Rental history per customer
- ✅ Customer status tracking

### 3. Transaksi Rental
- ✅ Pilih multiple equipment per transaksi
- ✅ Auto-calculate:
  - Rental duration (days)
  - Subtotal per item
  - Total amount
  - Required deposit
- ✅ Status tracking (Active/Completed/Cancelled)
- ✅ Edit & cancel rentals

### 4. Manajemen Payment
- ✅ Record deposit & rental payments
- ✅ Multiple payment methods
- ✅ Payment history
- ✅ Link payments to rentals

### 5. UI/UX
- ✅ Responsive design (mobile-friendly)
- ✅ Modern UI dengan Tailwind CSS
- ✅ Loading states & error handling
- ✅ Data tables dengan pagination
- ✅ Status badges dengan color coding

---

## 📖 Dokumentasi Lengkap

Untuk dokumentasi detail, lihat:
- **[DOKUMENTASI.md](./DOKUMENTASI.md)** - Dokumentasi lengkap (150+ halaman)
  - Arsitektur sistem
  - Database schema (ERD)
  - Panduan penggunaan detail
  - API documentation
  - Troubleshooting guide
  
- **[KREDENSIAL_LOGIN.md](./KREDENSIAL_LOGIN.md)** - Panduan login & security

- **[database_setup.sql](./database_setup.sql)** - SQL script untuk setup database

---

## 🎯 Roadmap

### Coming Soon
- [ ] Dashboard statistics & charts
- [ ] Advanced search & filters
- [ ] Email notifications
- [ ] Late fee calculation
- [ ] Export to PDF/Excel
- [ ] User management panel
- [ ] Customer portal
- [ ] Mobile app

---

## 🔧 Development

### Build for Production
```bash
npm run build
npm start
```

### Lint Code
```bash
npm run lint
```

### Run Tests (Coming Soon)
```bash
npm test
```

---

## 📦 Deployment

### Vercel (Recommended)
```bash
npm i -g vercel
vercel
```

### Netlify
```bash
npm i -g netlify-cli
netlify deploy --prod
```

### Docker
```bash
docker build -t rental-kamera .
docker run -p 3000:3000 rental-kamera
```

---

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

---

## 📄 License

This project is licensed under the MIT License.

---

## 👥 Team

**Tim TBD - Universitas Gadjah Mada**

- Developer: [benjminn](https://github.com/benjminn)

---

## 📞 Support

Untuk pertanyaan atau bantuan:
- 📧 Email: admin@ugm.ac.id
- 🐛 Issues: [GitHub Issues](https://github.com/benjminn/tbdrentalkamera/issues)

---

## 🙏 Acknowledgments

- Built with [Next.js](https://nextjs.org)
- Powered by [Supabase](https://supabase.com)
- Styled with [Tailwind CSS](https://tailwindcss.com)
- Icons by [Lucide](https://lucide.dev)

---

**Made with ❤️ by Tim TBD - UGM**
