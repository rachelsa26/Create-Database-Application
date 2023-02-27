CREATE DATABASE eCommerce
USE eCommerce

CREATE TABLE Customer (
	CustomerID CHAR(5) PRIMARY KEY NOT NULL,
	CONSTRAINT cekCustomerID CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(50) NOT NULL,
	CustomerGender VARCHAR(10),
	CONSTRAINT cekCustomerGender CHECK(CustomerGender = 'Male' or CustomerGender = 'Female'),
	CustomerPhone VARCHAR(13),
	CustomerAddress VARCHAR(100)
	)

CREATE TABLE Staff (
	StaffID CHAR(5) PRIMARY KEY NOT NULL,
	CONSTRAINT cekStaffID CHECK(StaffID LIKE 'SF[0-9][0-9][0-9]'),
	StaffName VARCHAR(50) NOT NULL,
	StaffGender VARCHAR(10),
	CONSTRAINT cekStaffGender CHECK(StaffGender = 'Male' or StaffGender = 'Female'),
	StaffPhone VARCHAR(13),
	StaffAddress VARCHAR(100),
	StaffSalary NUMERIC(11,2),
	StaffPosition VARCHAR(20)
	)

CREATE TABLE ItemType(
	ItemTypeID CHAR(5) PRIMARY KEY NOT NULL,
	CONSTRAINT cekItemTypeID CHECK(ItemTypeID LIKE 'IT[0-9][0-9][0-9]'),
	ItemTypeName VARCHAR(50) NOT NULL
	)

CREATE TABLE Item(
	ItemID CHAR(5) PRIMARY KEY NOT NULL,
	CONSTRAINT cekItemID CHECK(ItemID LIKE 'IM[0-9][0-9][0-9]'),
	ItemTypeID CHAR(5) REFERENCES ItemType ON UPDATE CASCADE ON DELETE CASCADE,
	ItemName VARCHAR(20) NOT NULL,
	Price NUMERIC(11,2),
	Quantity INT
	)

CREATE TABLE HeaderSellTransaction (
	TransactionID CHAR(5) PRIMARY KEY NOT NULL
	CONSTRAINT cekTransactionID CHECK(TransactionID LIKE 'TR[0-9][0-9][0-9]'),
	CustomerID CHAR(5) REFERENCES Customer ON UPDATE CASCADE ON DELETE CASCADE,
	StaffID CHAR(5) REFERENCES Staff ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate DATE,
	PaymentType VARCHAR(20)
	)

CREATE TABLE DetailSellTransaction (
	TransactionID CHAR(5) REFERENCES HeaderSellTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	ItemID CHAR(5) REFERENCES Item ON UPDATE CASCADE ON DELETE CASCADE,
	SellQuantity INT,
	PRIMARY KEY (TransactionID, ItemID)
	)

--DROP TABLE DetailSellTransaction;
--ALTER TABLE Item
----ADD "Description" VARCHAR(100)

--ALTER TABLE Item
----DROP COLUMN "Description"