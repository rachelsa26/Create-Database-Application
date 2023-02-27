--Basic Select
SELECT * FROM Customer
SELECT * FROM Staff
SELECT * FROM Item
SELECT * FROM ItemType
SELECT * FROM HeaderSellTransaction
SELECT * FROM DetailSellTransaction

SELECT CONCAT('There are a total of',' ', COUNT(*), ' ', LOWER(CustomerGender),'.s')
FROM Customer
GROUP BY CustomerGender;


--DML Select with String Function

---Left => LEFT(nama_kolon, berapa digit)
SELECT [Nama] = LEFT(StaffName,2)
FROM Staff

---Right => RIGHT(nama_kolon, berapa digit)
SELECT [Nama] = RIGHT(StaffName,3)
FROM Staff

---Reverse => REVERSE(nama_kolom) => untuk membalikkan satu kata
SELECT [Balik Name] = REVERSE(StaffName)
FROM Staff

---Charindex => CHARINDEX('Mau_cari_apa', nama_kolom)
SELECT StaffName, [Index Huruf N] = CHARINDEX('n',StaffName)
FROM Staff
WHERE StaffPhone = '081092871896'

---Substring => SUBSTRING(nama_kolom, start, berapa_digit)
SELECT [Index ke-2 empat huruf] = SUBSTRING(StaffName, 2, 4)
FROM Staff

SELECT [Kata Pertama] = SUBSTRING(StaffName, 1, CHARINDEX(' ', StaffName)-1)
FROM Staff

--UPPER => UPPER(nama_kolom) => menampilkan huruf besar
SELECT [Nama Huruf Besar] = UPPER(StaffName)
From Staff

--LOWER => LOWER(nama_kolom) => menampilkan huruf besar
SELECT [Nama Huruf Besar] = LOWER(StaffName)
From Staff

--DML Select with Math Function
---MAX
SELECT [Gaji Terbesar] = MAX(StaffSalary)
From Staff

---MIN
SELECT [Gaji Terkecil] = MIN(StaffSalary)
From Staff

---AVG
SELECT [Rata Rata Gaji] = AVG(StaffSalary)
From Staff

---COUNT
SELECT [Banyak Transaksi] = COUNT(TransactionID)
From HeaderSellTransaction

---SUM
SELECT [Total Gaji] = SUM(StaffSalary)
FROM Staff

--DML Select with Date Function

---DATENAME => DATENAME(interval, date)
----interval = Day, Weakday, Month, Year
SELECT DATENAME(DAY, TransactionDate)
FROM HeaderSellTransaction

SELECT DATENAME(WEEKDAY, TransactionDate)
FROM HeaderSellTransaction

SELECT DATENAME(MONTH, TransactionDate)
FROM HeaderSellTransaction

SELECT DATENAME(YEAR, TransactionDate)
FROM HeaderSellTransaction

SELECT DATENAME(WEEKDAY, '1945/08/16') --Melihat hari apa di tangal tbs


---DATEDIFF => DATEDIFF(interval, tanggal_pertama, tanggal_kedua)
SELECT DATEDIFF(Year,'1945/08/17','2022/02/25') --Melihat umur indonesia merdeka


---DATEADD => DATEADD(interval, mau_tambah_berapa, date)
SELECT DATEADD(DAY, 4, '1999/10/26') --menambah hari dari targal tertentu
SELECT DATEADD(WEEKDAY, 4, '1999/10/26') --menambah hari dari targal tertentu
SELECT DATEADD(MONTH, 4, '1999/10/26') --menambah hari dari targal tertentu
SELECT DATEADD(YEAR, 4, '1999/10/26') --menambah tahun dari targal tertentu

--DML Advanced Select

---CAST => CAST(nama_kolom AS tipe_data_yang_diinginkan) -> mengubah tipe data dari suatu kolom
SELECT [GAJI] = 'RP' + CAST(StaffSalary AS varchar)
FROM Staff

---CONVERT => CONVERT(tipe_data_yang_diinginkan, nama_kolom, kode_tujuan)
--Untuk melihat kode tujuan, blok dan klik f1 pada convert dibawah ini
CONVERT
SELECT [Tanggal yang sudah di convert] = CONVERT(VARCHAR, TransactionDate, 107)
FROM HeaderSellTransaction

--DML Insert
---Insert digunakan untuk menambahkan data
---Transaction
BEGIN TRANSACTION
--Perintah-perintah
--ROLLBACK --PERINTAH TIDAK AKAN KE SAVE
--COMMIT --PERINTAH AKAN KE SAVE

INSERT INTO Customer VALUES
('CU006','Elsa', 'Female','082121728886','Jalan Gereja')
COMMIT --Data elsa telah tersimpan di database

BEGIN TRANSACTION
INSERT INTO Customer (CustomerID, CustomerName) VALUES
('CU007', 'Frans')
ROLLBACK
SELECT * FROM Customer

BEGIN TRANSACTION
INSERT INTO Customer VALUES
('CU007', 'Putri', 'Female', '082121728884', 'Jalan Maju')
COMMIT

BEGIN TRANSACTION
INSERT INTO Customer VALUES
('CU008','Yuna', 'Female', '0987638272637', 'Jalan Serba'),
('CU009','Ferdy', 'Male', '082121728885', 'Jalan Gang')
COMMIT


--DML Delete
SELECT * FROM Customer

---DELETE data customer dengan nama tertentu
BEGIN TRANSACTION
DELETE FROM Customer
WHERE CustomerName = 'Ferdy'
ROLLBACK

---Delete transaksi yang terjadi pada tanggal 21
BEGIN TRANSACTION
DELETE FROM HeaderSellTransaction
WHERE DATENAME(DAY, TransactionDate) = 21
ROLLBACK

--DML Join => Menghubungkan tabel-table yg sudah berelasi
SELECT * 
FROM HeaderSellTransaction
WHERE DATENAME(DAY, TransactionDate) = 21

SELECT *
FROM Customer cs, HeaderSellTransaction hst
WHERE cs.CustomerID = hst.CustomerID AND 
DATENAME(DAY, TransactionDate) = 21

--AGREGATE
---MAX 
SELECT MAX(StaffSalary)
FROM Staff

---MIN 
SELECT MIN(StaffSalary)
FROM Staff

---AVG 
SELECT AVG(StaffSalary)
FROM Staff

--COUNT
SELECT COUNT(StaffSalary)
FROM Staff

--SUM
SELECT SUM(StaffSalary)
FROM Staff

--LATIHAN
SELECT [Maksimum Price] = MAX(Price), [Mimimum Price ] = MIN(Price), [Rata Rata Price] = AVG(Price) 
FROM Item

SELECT [Gender] = LEFT(StaffGender, 1), [Rata Rata Gaji] = 'Rp.' + CAST(AVG(StaffSalary) AS VARCHAR)
FROM Staff
GROUP BY StaffGender

SELECT [Nama Tipe Item] = ItemTypeName, [Total Transaksi] = COUNT(TransactionID)
FROM ItemType it,Item im, DetailSellTransaction dst
WHERE it.ItemTypeID = im.ItemTypeID AND im.ItemID = dst.ItemID 
Group by ItemTypeName
ORDER BY ItemTypeName

Select TransactionID, [Quantity per transaction] = SUM(SellQuantity)
FROM DetailSellTransaction 
GROUP BY TransactionID

--ODER BY
---kecil ke besar
SELECT * FROM Staff
ORDER BY StaffSalary ASC

---besar ke kecil
SELECT * FROM Staff
ORDER BY StaffSalary DESC

--HAVING
SELECT ItemTypeID, SUM(Quantity) 
FROM Item
GROUP BY ItemTypeID
HAVING SUM(Quantity) > 100

--SUBQUERY
---Subquery adalah query di dalam query
--==SELECT ..
--==FROM ..
--==WHERE (SELECT ..)

--IN
--IN memungkinkan kita untuk menguji apakah value yang kita cari ada di dalam in
SELECT*
FROM Staff
WHERE StaffPosition in ('Cashier', 'Supervisor')

SELECT*
FROM Staff
WHERE StaffID IN (
	SELECT StaffID
	FROM Staff
	WHERE StaffSalary > 7000000
	)


--Exists -> operator yang digunakan untuk mengetahui apakah subquery yang dijalankan mengembalikan sesuati atau tidak
SELECT*
FROM Staff
WHERE EXISTS(
	SELECT StaffID --tidak perlu ada from
	WHERE StaffSalary > 7000000
	)

--ALIAS SUBQUERY -> subquery yang memiliki alias/nama lain
SELECT ItemName, Price
FROM Item, (SELECT [Rata Rata] = AVG(Price) FROM Item) AS tt
WHERE Price > tt.[Rata Rata]

SELECT AVG(Price)
FROM Item

--VIEW
CREATE VIEW [List Staff Male] AS
SELECT * FROM Staff
WHERE StaffGender = 'Male'

SELECT * FROM [List Staff Male]

---DROP VIEW [List Staff Male]
ALTER VIEW [List Staff Male] AS 
SELECT [Nama Depan] = Left(StaffName, CHARINDEX(' ', StaffName)-1), 
[Gender] = LEFT(StaffGender, 1)
FROM StafF


------
SELECT CONCAT('There are a total of',' ', COUNT(*), ' ', LOWER(CustomerGender),'.s')
FROM Customer
GROUP BY CustomerGender;