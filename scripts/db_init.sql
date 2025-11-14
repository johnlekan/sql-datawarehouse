-- init_database_pgsql.sql
/*
=============================================================
Create Database and Schemas (PostgreSQL Version)
=============================================================
Script Purpose:
    This script creates a new database named 'datawarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'datawarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.

Note:
    - You must be connected to a different database (like 'postgres') when running this script
    - PostgreSQL database names are case-insensitive but typically use lowercase
*/

-- Drop the database if it exists and recreate it
-- Note: In PostgreSQL, we cannot drop a database while connected to it
-- This script should be run from the 'postgres' database or another database

-- First, disconnect all active connections to the target database
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'datawarehouse'
  AND pid <> pg_backend_pid();

-- Drop the database if it exists
DROP DATABASE IF EXISTS datawarehouse;

-- Create the new database
CREATE DATABASE datawarehouse;

-- Connect to the new database
\c datawarehouse

-- Create Schemas
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;


-- Display confirmation message
\echo '============================================================='
\echo 'Database and schemas created successfully!'
\echo 'Database: datawarehouse'
\echo 'Schemas: bronze, silver, gold'
\echo '============================================================='