-- ============================================
-- SISTEM RENTAL KAMERA - DATABASE SETUP
-- Universitas Gadjah Mada - Tim TBD
-- ============================================

-- STEP 1: CREATE TABLES
-- ============================================

-- Tabel User (Admin dan Staff)
CREATE TABLE IF NOT EXISTS "User" (
  "userID" SERIAL PRIMARY KEY,
  "username" VARCHAR(50) UNIQUE NOT NULL,
  "password" VARCHAR(255) NOT NULL,
  "email" VARCHAR(100) UNIQUE NOT NULL,
  "full_name" VARCHAR(100) NOT NULL,
  "phone" VARCHAR(20),
  "address" TEXT,
  "role" VARCHAR(20) NOT NULL DEFAULT 'user',
  "join_date" TIMESTAMP DEFAULT NOW(),
  "status" VARCHAR(20) DEFAULT 'true'
);

-- Tabel Customer
CREATE TABLE IF NOT EXISTS "Customer" (
  "customerID" SERIAL PRIMARY KEY,
  "full_name" VARCHAR(100) NOT NULL,
  "email" VARCHAR(100) UNIQUE NOT NULL,
  "phone" VARCHAR(20) NOT NULL,
  "address" TEXT,
  "ID_card" VARCHAR(50),
  "join_date" TIMESTAMP DEFAULT NOW(),
  "status" VARCHAR(20) DEFAULT 'Active'
);

-- Tabel EquipmentType
CREATE TABLE IF NOT EXISTS "EquipmentType" (
  "typeID" SERIAL PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL,
  "description" TEXT,
  "rate" DECIMAL(10,2) NOT NULL,
  "deposit_amount" DECIMAL(10,2) NOT NULL
);

-- Tabel Equipment
CREATE TABLE IF NOT EXISTS "Equipment" (
  "equipmentID" SERIAL PRIMARY KEY,
  "typeID" INTEGER REFERENCES "EquipmentType"("typeID") ON DELETE SET NULL,
  "serial_number" VARCHAR(100) UNIQUE NOT NULL,
  "purchase_date" DATE,
  "condition" VARCHAR(20) NOT NULL DEFAULT 'Good',
  "status" VARCHAR(20) DEFAULT 'Available',
  "notes" TEXT
);

-- Tabel Rental
CREATE TABLE IF NOT EXISTS "Rental" (
  "rentalID" SERIAL PRIMARY KEY,
  "customerID" INTEGER REFERENCES "Customer"("customerID") ON DELETE SET NULL,
  "userID" INTEGER REFERENCES "User"("userID") ON DELETE SET NULL,
  "start_date" DATE NOT NULL,
  "end_date" DATE NOT NULL,
  "status" VARCHAR(20) DEFAULT 'Active',
  "total_amount" DECIMAL(10,2) NOT NULL,
  "notes" TEXT
);

-- Tabel RentalDetail
CREATE TABLE IF NOT EXISTS "RentalDetail" (
  "detailID" SERIAL PRIMARY KEY,
  "rentalID" INTEGER REFERENCES "Rental"("rentalID") ON DELETE CASCADE,
  "equipmentID" INTEGER REFERENCES "Equipment"("equipmentID") ON DELETE SET NULL,
  "time_quantity" INTEGER NOT NULL,
  "subtotal" DECIMAL(10,2) NOT NULL,
  "required_deposit" DECIMAL(10,2) NOT NULL
);

-- Tabel Payment
CREATE TABLE IF NOT EXISTS "Payment" (
  "payment_id" SERIAL PRIMARY KEY,
  "rentalID" INTEGER REFERENCES "Rental"("rentalID") ON DELETE SET NULL,
  "userID" INTEGER REFERENCES "User"("userID") ON DELETE SET NULL,
  "deposit_payment" DECIMAL(10,2) NOT NULL,
  "rental_payment" DECIMAL(10,2) NOT NULL,
  "payment_date" TIMESTAMP DEFAULT NOW(),
  "payment_method" VARCHAR(50) NOT NULL
);

-- ============================================
-- STEP 2: CREATE INDEXES (Performance)
-- ============================================

CREATE INDEX IF NOT EXISTS idx_rental_customer ON "Rental"("customerID");
CREATE INDEX IF NOT EXISTS idx_rental_user ON "Rental"("userID");
CREATE INDEX IF NOT EXISTS idx_rental_status ON "Rental"("status");
CREATE INDEX IF NOT EXISTS idx_rental_dates ON "Rental"("start_date", "end_date");

CREATE INDEX IF NOT EXISTS idx_equipment_type ON "Equipment"("typeID");
CREATE INDEX IF NOT EXISTS idx_equipment_status ON "Equipment"("status");
CREATE INDEX IF NOT EXISTS idx_equipment_condition ON "Equipment"("condition");

CREATE INDEX IF NOT EXISTS idx_rental_detail_rental ON "RentalDetail"("rentalID");
CREATE INDEX IF NOT EXISTS idx_rental_detail_equipment ON "RentalDetail"("equipmentID");

CREATE INDEX IF NOT EXISTS idx_payment_rental ON "Payment"("rentalID");
CREATE INDEX IF NOT EXISTS idx_payment_user ON "Payment"("userID");

CREATE INDEX IF NOT EXISTS idx_customer_status ON "Customer"("status");
CREATE INDEX IF NOT EXISTS idx_user_role ON "User"("role");

-- ============================================
-- STEP 3: INSERT DEFAULT ADMIN USER
-- ============================================

-- Admin Account
-- Username: UgmTBD
-- Password: ugmtebede
INSERT INTO "User" (username, password, email, full_name, phone, address, role, status)
VALUES 
  ('UgmTBD', 'ugmtebede', 'admin@ugm.ac.id', 'Admin UGM TBD', '081234567890', 'Yogyakarta', 'admin', 'true')
ON CONFLICT (username) DO NOTHING;

-- ============================================
-- STEP 4: INSERT SAMPLE EQUIPMENT TYPES
-- ============================================

INSERT INTO "EquipmentType" (name, description, rate, deposit_amount)
VALUES 
  ('Canon EOS R5', 'Professional mirrorless camera with 45MP full-frame sensor, 8K video, advanced autofocus', 150.00, 500.00),
  ('Sony A7 IV', 'Full-frame mirrorless camera with 33MP sensor, 4K 60fps video, excellent low-light', 120.00, 400.00),
  ('Nikon Z6 II', 'Full-frame mirrorless camera with 24.5MP sensor, dual processors, great for video', 100.00, 350.00),
  ('Canon EOS R6', 'Full-frame mirrorless with 20MP sensor, 4K 60fps, incredible IBIS', 130.00, 450.00),
  ('Fujifilm X-T4', 'APS-C mirrorless camera with 26MP sensor, in-body stabilization, film simulations', 90.00, 300.00),
  
  -- Lenses
  ('Canon RF 24-70mm f/2.8L IS', 'Professional standard zoom lens with image stabilization', 80.00, 300.00),
  ('Canon RF 70-200mm f/2.8L IS', 'Professional telephoto zoom lens', 100.00, 400.00),
  ('Sony FE 24-70mm f/2.8 GM', 'Premium standard zoom lens for Sony E-mount', 85.00, 320.00),
  ('Sony FE 70-200mm f/2.8 GM OSS II', 'Professional telephoto zoom with excellent optics', 110.00, 450.00),
  ('Sigma 35mm f/1.4 Art', 'Premium wide-angle prime lens', 60.00, 200.00),
  
  -- Accessories
  ('DJI Ronin-S', 'Professional 3-axis gimbal stabilizer for DSLRs and mirrorless cameras', 70.00, 250.00),
  ('Manfrotto Tripod Pro', 'Professional carbon fiber tripod with fluid head', 40.00, 150.00),
  ('Godox AD600 Flash', 'Powerful portable flash system with battery pack', 50.00, 180.00),
  ('Rode VideoMic Pro+', 'Professional on-camera microphone with rechargeable battery', 30.00, 100.00),
  ('Atomos Ninja V', '5-inch HDR monitor and recorder for professional video', 60.00, 220.00)
ON CONFLICT DO NOTHING;

-- ============================================
-- STEP 5: INSERT SAMPLE EQUIPMENT
-- ============================================

-- Canon Cameras
INSERT INTO "Equipment" (typeID, serial_number, purchase_date, condition, status, notes)
VALUES 
  (1, 'CR5-001-2024', '2024-01-15', 'Good', 'Available', 'Brand new, includes battery and charger'),
  (1, 'CR5-002-2024', '2024-01-15', 'Good', 'Available', 'Brand new, includes battery and charger'),
  (4, 'CR6-001-2024', '2024-02-20', 'Good', 'Available', 'Excellent condition'),
  
  -- Sony Cameras
  (2, 'SA7-001-2024', '2024-01-20', 'Good', 'Available', 'Includes 2 batteries'),
  (2, 'SA7-002-2024', '2024-01-20', 'Good', 'Available', 'Includes 2 batteries'),
  
  -- Nikon Cameras
  (3, 'NZ6-001-2023', '2023-12-10', 'Good', 'Available', 'Low shutter count'),
  
  -- Fujifilm Cameras
  (5, 'FXT4-001-2024', '2024-03-01', 'Good', 'Available', 'Perfect for photography and video'),
  
  -- Lenses
  (6, 'CRF24-001-2024', '2024-01-15', 'Good', 'Available', 'Professional L-series lens'),
  (7, 'CRF70-001-2024', '2024-01-15', 'Good', 'Available', 'Professional telephoto'),
  (8, 'SFE24-001-2024', '2024-02-01', 'Good', 'Available', 'GM Master series'),
  (9, 'SFE70-001-2024', '2024-02-01', 'Good', 'Available', 'Latest version with OSS'),
  (10, 'SIG35-001-2023', '2023-11-20', 'Good', 'Available', 'Art series, multiple mounts available'),
  
  -- Accessories
  (11, 'DJI-RS-001-2024', '2024-01-10', 'Good', 'Available', 'Full gimbal kit with case'),
  (12, 'MAN-TP-001-2023', '2023-10-15', 'Good', 'Available', 'Professional tripod with bag'),
  (13, 'GOD-FL-001-2024', '2024-02-15', 'Good', 'Available', 'Includes light stand and softbox'),
  (14, 'ROD-VM-001-2024', '2024-03-01', 'Good', 'Available', 'Broadcast quality audio'),
  (15, 'ATO-NV-001-2024', '2024-02-20', 'Good', 'Available', 'Includes SSD and accessories')
ON CONFLICT (serial_number) DO NOTHING;

-- ============================================
-- STEP 6: INSERT SAMPLE CUSTOMERS (Optional)
-- ============================================

INSERT INTO "Customer" (full_name, email, phone, address, ID_card, status)
VALUES 
  ('Budi Santoso', 'budi.santoso@email.com', '081234567890', 'Jl. Malioboro No. 123, Yogyakarta', '3374010101990001', 'Active'),
  ('Siti Nurhaliza', 'siti.nurhaliza@email.com', '081234567891', 'Jl. Kaliurang KM 5, Sleman', '3471020202880002', 'Active'),
  ('Ahmad Fauzi', 'ahmad.fauzi@email.com', '081234567892', 'Jl. Gejayan No. 45, Yogyakarta', '3374030303920003', 'Active')
ON CONFLICT (email) DO NOTHING;

-- ============================================
-- STEP 7: ENABLE ROW LEVEL SECURITY (RLS)
-- ============================================

ALTER TABLE "User" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Customer" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Equipment" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "EquipmentType" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Rental" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "RentalDetail" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Payment" ENABLE ROW LEVEL SECURITY;

-- ============================================
-- STEP 8: CREATE RLS POLICIES
-- ============================================

-- Policies untuk SELECT (Read)
CREATE POLICY "Enable read for all authenticated users" ON "User" 
  FOR SELECT USING (true);

CREATE POLICY "Enable read for all authenticated users" ON "Customer" 
  FOR SELECT USING (true);

CREATE POLICY "Enable read for all authenticated users" ON "Equipment" 
  FOR SELECT USING (true);

CREATE POLICY "Enable read for all authenticated users" ON "EquipmentType" 
  FOR SELECT USING (true);

CREATE POLICY "Enable read for all authenticated users" ON "Rental" 
  FOR SELECT USING (true);

CREATE POLICY "Enable read for all authenticated users" ON "RentalDetail" 
  FOR SELECT USING (true);

CREATE POLICY "Enable read for all authenticated users" ON "Payment" 
  FOR SELECT USING (true);

-- Policies untuk INSERT
CREATE POLICY "Enable insert for authenticated users" ON "User" 
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable insert for authenticated users" ON "Customer" 
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable insert for authenticated users" ON "Equipment" 
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable insert for authenticated users" ON "Rental" 
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable insert for authenticated users" ON "RentalDetail" 
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable insert for authenticated users" ON "Payment" 
  FOR INSERT WITH CHECK (true);

-- Policies untuk UPDATE
CREATE POLICY "Enable update for authenticated users" ON "User" 
  FOR UPDATE USING (true);

CREATE POLICY "Enable update for authenticated users" ON "Customer" 
  FOR UPDATE USING (true);

CREATE POLICY "Enable update for authenticated users" ON "Equipment" 
  FOR UPDATE USING (true);

CREATE POLICY "Enable update for authenticated users" ON "Rental" 
  FOR UPDATE USING (true);

CREATE POLICY "Enable update for authenticated users" ON "Payment" 
  FOR UPDATE USING (true);

-- Policies untuk DELETE
CREATE POLICY "Enable delete for authenticated users" ON "Customer" 
  FOR DELETE USING (true);

CREATE POLICY "Enable delete for authenticated users" ON "Equipment" 
  FOR DELETE USING (true);

CREATE POLICY "Enable delete for authenticated users" ON "Rental" 
  FOR DELETE USING (true);

CREATE POLICY "Enable delete for authenticated users" ON "RentalDetail" 
  FOR DELETE USING (true);

-- ============================================
-- SETUP COMPLETE!
-- ============================================

-- Verify admin user created
SELECT 'Admin user created successfully!' as message, * FROM "User" WHERE username = 'UgmTBD';

-- Verify equipment types
SELECT 'Equipment types created:' as message, COUNT(*) as total FROM "EquipmentType";

-- Verify equipment
SELECT 'Equipment items created:' as message, COUNT(*) as total FROM "Equipment";

-- Verify customers
SELECT 'Sample customers created:' as message, COUNT(*) as total FROM "Customer";

-- ============================================
-- NOTES
-- ============================================

/*
✅ Database setup complete!

Admin Credentials:
  Username: UgmTBD
  Password: ugmtebede

Next Steps:
1. Copy NEXT_PUBLIC_SUPABASE_URL dan NEXT_PUBLIC_SUPABASE_ANON_KEY
2. Buat file .env.local di root project
3. Run: npm install
4. Run: npm run dev
5. Open: http://localhost:3000
6. Login with admin credentials

Security Recommendations for Production:
- Change default admin password
- Implement password hashing (bcryptjs)
- Tighten RLS policies based on user roles
- Enable HTTPS
- Setup proper backup strategy
- Implement rate limiting
- Add audit logging

For more information, see DOKUMENTASI.md
*/
