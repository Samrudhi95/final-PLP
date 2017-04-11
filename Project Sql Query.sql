/**  Sql Query of Admin table **/
CREATE TABLE [EcommerceShoppingStore].[Admin] (
    [UserName] VARCHAR (10) NULL,
    [Password] VARCHAR (10) NULL
);

/**  Sql Query of Category table **/
CREATE TABLE [EcommerceShoppingStore].[Category] (
    [Category Id]          INT            NOT NULL,
    [Category Name]        NVARCHAR (MAX) NOT NULL,
    [Category Description] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Category Id] ASC)
);

/**  Sql Query of Customer table **/
CREATE TABLE [EcommerceShoppingStore].[Customer] (
    [Customer Id] INT            IDENTITY (1, 1) NOT NULL,
    [First Name]  NVARCHAR (MAX) NOT NULL,
    [Last Name]   NVARCHAR (MAX) NOT NULL,
    [Email ID]    NVARCHAR (MAX) NOT NULL,
    [Mobile No.]  NVARCHAR (50)  NOT NULL,
    [User ID]     NVARCHAR (50)  NOT NULL,
    [Password]    NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Customer Id] ASC),
    UNIQUE NONCLUSTERED ([User ID] ASC)
);

/**  Sql Query of Order table **/
CREATE TABLE [EcommerceShoppingStore].[Order] (
    [Order ID]    INT            IDENTITY (1, 1) NOT NULL,
    [Order Date]  DATETIME       NOT NULL,
    [Customer ID] INT            NULL,
    [Product ID]  INT            NOT NULL,
    [Price]       INT            NOT NULL,
    [Quantity]    INT            NOT NULL,
    [Total]       INT            NOT NULL,
    [Address]     NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Order ID] ASC),
    CONSTRAINT [FK_Order_Customer] FOREIGN KEY ([Customer ID]) REFERENCES [EcommerceShoppingStore].[Customer] ([Customer Id]),
    CONSTRAINT [FK_Order_Product] FOREIGN KEY ([Product ID]) REFERENCES [EcommerceShoppingStore].[Product] ([Product ID])
);

/**  Sql Query of Product table **/
CREATE TABLE [EcommerceShoppingStore].[Product] (
    [Product ID]           INT            NOT NULL,
    [Product Name]         NVARCHAR (50)  NOT NULL,
    [Category Id]          INT            NOT NULL,
    [Product Desc]         NVARCHAR (MAX) NOT NULL,
    [Units]                INT            NOT NULL,
    [Unit Price]           INT            NOT NULL,
    [MRP]                  INT            NOT NULL,
    [Discount]             DECIMAL (18)   NOT NULL,
    [Picture]              IMAGE          NOT NULL,
    [Category Description] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([Product ID] ASC),
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([Category Id]) REFERENCES [EcommerceShoppingStore].[Category] ([Category Id])
);


/**  Stored Procedure for  Adding Customer **/
Create PROCEDURE  [EcommerceShoppingStore].[addCustomer]
	@FirstName nvarchar(max),
	@LastName nvarchar(max),
	@EmailID nvarchar(max),
	@MobileNo nvarchar(50),
	@UserID nvarchar(50),
	@Password nvarchar(max)
AS
	INSERT INTO  [EcommerceShoppingStore].[Customer]
           ([First Name]
           ,[Last Name]
           ,[Email ID]
           ,[Mobile No.]
           ,[User ID]
           ,[Password])
     VALUES
           (@FirstName,@LastName,@EmailID,@MobileNo,@UserID,@Password)


/**  Stored Procedure for  Adding Order **/
create  PROCEDURE [EcommerceShoppingStore].[addOrder]
	@ODate datetime,
	@CID int,
	@PID int,
	@Price int,
	@Quantity int,
	@Total int,
	@address varchar(max)
AS
	INSERT INTO [EcommerceShoppingStore].[Order]
           (
		   [Order Date],
		   [Customer ID]          
           ,[Product ID]
           ,[Price]
           ,[Quantity]
           ,[Total],
		    [Address]
		   )
		  		
     VALUES
           (@ODate,@CID,@PID,@Price,@Quantity,@Total,@address)



/**  Stored Procedure for  Adding Product **/
create PROCEDURE [EcommerceShoppingStore].[AddProduct]
(
@ProductID Int,
@ProductName NVARCHAR(Max),
@CategoryID INT,
@ProductDesc NVARCHAR(MAX),
@Units INT, 
@UnitPrice INT , 
@MRP INT,
@Discount DECIMAL,
@Picture Image,
@CategoryDescription NVARCHAR(MAX)
)
As
BEGIN
insert into [EcommerceShoppingStore].[Product]
([Product ID],[Product Name],[Category Id],[Product Desc],[Units],[Unit Price],[MRP],[Discount],[Picture],[Category Description]) 
values(@ProductID,@ProductName,@CategoryID,@ProductDesc,@Units,@UnitPrice,@MRP,@Discount,@Picture,@CategoryDescription)
END

/**  Stored Procedure for  Authenticating  Customer **/
create  PROCEDURE [EcommerceShoppingStore].[authenticateCustomer]
	@UID nvarchar(max),
	@Pass nvarchar(max)
AS
	SELECT * from [EcommerceShoppingStore].Customer 
	where Customer.[User ID]=@UID and Customer.Password=@Pass


/**  Stored Procedure for  Deleteing  Product **/
create PROCEDURE [EcommerceShoppingStore].[DeleteProduct]
(
@ProductID INT
)
AS
BEGIN
 DELETE FROM [EcommerceShoppingStore].[Product]
 WHERE [Product ID]=@ProductID
 END


/**  Stored Procedure for  Getting  Category **/
create  PROCEDURE [EcommerceShoppingStore].[getCategory]
AS
Select * from EcommerceShoppingStore.Category

/**  Stored Procedure for  Getting  Product By Name **/
create  PROCEDURE [EcommerceShoppingStore].[getProductByName]
	@Type nvarchar(max)
AS
	Select * from [EcommerceShoppingStore].[Product] where [EcommerceShoppingStore].[Product].[Product Name]=@Type


/**  Stored Procedure for  Search Category **/
create PROCEDURE [EcommerceShoppingStore].[searchCategory]
	@Type nvarchar(max)
AS
	SELECT [EcommerceShoppingStore].Category.[Category Name] from [EcommerceShoppingStore].Category where [EcommerceShoppingStore].Category.[Category Description]=@Type;


/**  Stored Procedure for  Search Product **/
create PROCEDURE [EcommerceShoppingStore].[searchProduct]
	@Type nvarchar(max),
	@Type1 nvarchar(max)
AS
	Select * from [EcommerceShoppingStore].[Product] join [EcommerceShoppingStore].[Category] on [EcommerceShoppingStore].[Product].[Category Id]=[EcommerceShoppingStore].[Category].[Category Id] where[EcommerceShoppingStore].[Category].[Category Name]=@Type and [EcommerceShoppingStore].Product.[Category Description]=@Type1

/**  Stored Procedure for  Search Products **/
create  procedure [EcommerceShoppingStore].[SearchProducts]
(
@ProductID Int
)
AS
BEGIN
 select * FROM [EcommerceShoppingStore].[Product]
 WHERE [Product ID]=@ProductID
END

/**  Stored Procedure for Update Product **/
create PROCEDURE [EcommerceShoppingStore].[UpdateProduct]
(
@ProductID int,
@ProductName nvarchar(50),
@ProductDesc  NVARCHAR(MAX),
@Units int,
@UnitPrice INT , 
@Discount DECIMAL
)
As
BEGIN
UPDATE [EcommerceShoppingStore].[Product]
SET 
[Product Name]=@ProductName,
[Product Desc]=@ProductDesc,
[Units]=@Units,
[Unit Price]=@UnitPrice, 
[Discount]=@Discount
where [Product ID]=@ProductID
END

/**  Stored Procedure for Vaildate Admin **/
create PROC [EcommerceShoppingStore].[ValidateAdmin]
(
	@User	VARCHAR(10),
	@Password VARCHAR(10)
)
AS
BEGIN
	SELECT UserName FROM LoginUser_115022 
	WHERE UserName = @User AND Password = @Password
END

/**  Stored Procedure for Displaying Customer **/
create  PROCEDURE [EcommerceShoppingStore].[viewCustomer]
As
BEGIN
select * from [EcommerceShoppingStore].[Customer]  
END

/**  Stored Procedure for Displaying Order **/
create  PROCEDURE [EcommerceShoppingStore].[viewOrder]
As
BEGIN
select * from [EcommerceShoppingStore].[Order]
END

/**  Stored Procedure for Displaying Product **/
create PROCEDURE [EcommerceShoppingStore].[viewProduct]
As
BEGIN
select * from [EcommerceShoppingStore].[Product]
END