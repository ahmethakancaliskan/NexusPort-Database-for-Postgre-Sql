# NexusPortCommerceDb-for-postgre-sql-script

# 🛒 NexusPort E-Commerce Database | PostgreSQL Training Schema

This repository contains the setup script for **NexusPortCommerce**, a realistic mock e-commerce database designed for PostgreSQL.

It was created specifically for educational purposes, enabling students (especially QA Automation Engineers and Data Analysts) to practice complex SQL queries with consistent results. 
(Data that appear to be errors in some query results are used for test scenarios. These incorrect scenarios are stated in the questions file prepared for the database.)


## ⚙️ Setup Instructions

This script is a single, executable file for any standard PostgreSQL environment. It handles all necessary environment settings, deletes old tables for a clean start, and inserts all static data.

**There are two easy ways to load the database by using pgAdmin:**


---- First Way

1.  **Open the Script:** Open the `Nexus-Port-Commerce-Database-Sample.sql` file and copy the entire content.
2.  **Open pgAdmin :** Create new database under `Server/Databases` by right clicking databases
3.  **Database Name :** Give the name  `NexusPort`
4.  **Open Query Tool :**  Right click on created database `NexusPort` and click `Query Tool` on list
5.  **Paste and Execute:** Paste the **entire content** of the `Nexus-Port-Commerce-Database-Sample.sql` file into the query window and execute it (usually by pressing **F5** or the **Execute** button or Play Icon on other saying).

---- Second Way

1.  **Download the .tar filet:** Download the .tar file  `NexusPort.tar`.
2.  **Open pgAdmin :** Create new database under `Server/Databases` by right clicking databases
3.  **Database Name :** Give the name `NexusPort`
4.  **Restore :** Right click on database  `NexusPort` and click Restore
5.  **Choose .tar File :** Upload  `NexusPort.tar` file and click Restore button

The script will automatically create all of the tables, you can check it `Server/Databases/NexusPort/Schemas(1)/public/tables(8)` 
