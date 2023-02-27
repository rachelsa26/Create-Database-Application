--Ubahlah CustomerName menjadi nama pertama dari CustomerName pada table Customer dimana Customer tersebut pernah melakukan transaksi pada tanggal 21.Kemudian tampilkan seluar data dari Customer. 
Begin Transaction
UPDATE Customer
SET CustomerName = LEFT(CustomerName,CHARINDEX(' ', CustomerName)-1)
FROM Customer cs, HeaderSellTransaction hst
WHERE cs.CustomerID = hst.CustomerID AND
DATENAME(DAY, TransactionDate) = 21
COMMIT

SELECT *
FROM Customer, HeaderSellTransaction

--Ubahlah PaymentType menjadi “Hutang” untuk setiap transaksi yang di lakukan oleh Customer CU001.
Begin Transaction
UPDATE HeaderSellTransaction
SET PaymentType = 'Hutang'
FROM Customer cs, HeaderSellTransaction hst
WHERE cs.CustomerID = hst.CustomerID AND
cs.CustomerID = 'CU001'
ROLLBACK

--Hapus data staff yang memiliki Salary di bawah Rp.7.000.000.Kemudian Tampilkan Seluruh data dari table Staff
BEGIN TRAN
DELETE FROM Staff
WHERE StaffSalary < 7000000.00
ROLLBACK

SELECT * FROM Staff

--Tamplikan TransactionDate,CustomerName,itemName,Discount(didapat dari 20% Price) dan PaymentType dimana transaksi terjadi pada tanggal 22.
SELECT TransactionDate, CustomerName, ItemName, [Discount] = 0.2 * Price, PaymentType
FROM Customer cs, Item im, HeaderSellTransaction hst, DetailSellTransaction dst
WHERE cs.CustomerID = hst.CustomerID AND hst.TransactionID = dst.TransactionID AND
dst.ItemID = im.ItemID AND DATENAME(DAY, TransactionDate) = 22