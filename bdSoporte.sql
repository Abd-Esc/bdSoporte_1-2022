/*--Crear y eliminar la BD
create database bdSoporte
drop database if exists bdSoporte
*/

use bdSoporte
CREATE TABLE dimTiempo (
idTiempo int PRIMARY KEY,
Mes nvarchar(50),
Trimestre nvarchar(50),
Anio nvarchar(50)
)
go
CREATE TABLE dimTipoEstado (
idTipoEstado int PRIMARY KEY,
EstadoDescripcion nvarchar(50)
)
go
CREATE TABLE dimEmpleado (
idEmpleado int PRIMARY KEY,
NombreEmpleado nvarchar(150),
SucursalEmpleado nvarchar(100) null
)
go
CREATE TABLE dimTipoCliente(
idTipoCliente int PRIMARY KEY,
TipoCliente varchar(100) NULL
)
go
CREATE TABLE dimCliente (
idCliente int PRIMARY KEY,
NombreCliente nvarchar(150),
NombreSucursal nvarchar(100),
RegionCliente nvarchar(100),
TipoCliente nvarchar(100)
)
go
CREATE TABLE dimProducto(
idProducto int PRIMARY KEY,
NombreProducto varchar(200) NULL,
Categoria varchar(100) NULL
)
go
CREATE TABLE dimSucursal(
idSucursal int PRIMARY KEY,
NombreSucursal varchar(100) NULL,
Region varchar(100) NULL
)
go

use bdSoporte

--factEntrega
CREATE TABLE factEntrega (
idTiempo int,
idTipoEstado int,
idEmpleado int,
Cantidad int,
MontoTotal decimal(16,4),
Foreign key(idTiempo)references dimTiempo (idTiempo),
Foreign key(idTipoEstado)references dimTipoEstado (idTipoEstado),
Foreign key(idEmpleado)references dimEmpleado (idEmpleado)
)

--factCobranza
CREATE TABLE factCobranza (
idTiempo int,
idCliente int,
idEmpleado int,
MontoTotal decimal(16,4),
SaldoTotal decimal(16,4),
CantidadDeVeces int,
Foreign key(idTiempo)references dimTiempo (idTiempo),
Foreign key(idCliente)references dimCliente (idCliente),
Foreign key(idEmpleado)references dimEmpleado (idEmpleado)
)

--factDevoluciones
CREATE TABLE factDevoluciones(
idTiempo int NULL,
idSucursal int NULL,
idProducto int NULL,
/*
MontoTotal 
Cantidad 
*/
Foreign key(idTiempo)references dimTiempo (idTiempo),
Foreign key(idSucursal)references dimSucursal (idSucursal),
Foreign key(idProducto)references dimProducto (idProducto)
)

--factPedidos
CREATE TABLE factPedidos(
idTiempo int NULL,
idSucursal int NULL,
idCliente int NULL,
idProducto int NULL,
/*
Cantidad 
*/
Foreign key(idTiempo)references dimTiempo (idTiempo),
Foreign key(idSucursal)references dimSucursal (idSucursal),
Foreign key(idCliente)references dimCliente (idCliente),
Foreign key(idProducto)references dimProducto (idProducto)
)

--factVentas
CREATE TABLE factVentas(
idCliente int NULL,
idEmpleado int NULL,
idTiempo int NULL,
idProducto int NULL,
idSucursal int NULL,
/*
Cantidad 
MonTototal 
*/
Foreign key(idCliente)references dimCliente (idCliente),
Foreign key(idEmpleado)references dimEmpleado (idEmpleado),
Foreign key(idTiempo)references dimTiempo (idTiempo),
Foreign key(idProducto)references dimProducto (idProducto),
Foreign key(idSucursal)references dimSucursal (idSucursal)
)

--factRegistro
CREATE TABLE factRegistro(
idCliente int NULL,
idTiempo int NULL,
idTipoCliente int NULL,
idSucursal int NULL,
/*
Cantidad 
*/
Foreign key(idCliente)references dimCliente (idCliente),
Foreign key(idTiempo)references dimTiempo (idTiempo),
Foreign key(idTipoCliente)references dimTipoCliente (idTipoCliente),
Foreign key(idSucursal)references dimSucursal (idSucursal)
)

/*
----Vaciar la tabla----
delete from factEntrega
delete from factCobranza
delete from factDevoluciones
delete from factPedidos
delete from factVentas
delete from factRegistro
go
delete from dimTiempo
delete from dimTipoEstado
delete from dimEmpleado
delete from dimTipoCliente
delete from dimCliente
delete from dimProducto
delete from dimSucursal

----Visualizar----
SELECT * FROM dimTiempo
SELECT * FROM dimTipoEstado
SELECT * FROM dimEmpleado
SELECT * FROM dimTipoCliente
SELECT * FROM dimCliente
SELECT * FROM dimProducto
SELECT * FROM dimSucursal

SELECT * FROM factEntrega
SELECT * FROM factCobranza
SELECT * FROM factDevoluciones
SELECT * FROM factPedidos
SELECT * FROM factVentas
SELECT * FROM factRegistro

----Eliminar las tablas de la BD----
drop table if exists factEntrega
drop table if exists factCobranza
drop table if exists factDevoluciones
drop table if exists factPedidos
drop table if exists factVentas
drop table if exists factRegistro
go
drop table if exists dimTiempo
drop table if exists dimTipoEstado
drop table if exists dimEmpleado
drop table if exists dimTipoCliente
drop table if exists dimCliente
drop table if exists dimProducto
drop table if exists dimSucursal
*/