# 📊🪪 Insurance Agency Database: Agent and Policy Management System 🪪📊  

The Insurance Agency Database is a robust system designed to manage a network of insurance agents and the policies they sell. It stores detailed information about agents, including their personal details, sales performance, and the specific insurance policies they are responsible for. Each policy has important attributes, such as coverage type and premium amount.

<img width="800" alt="Memo Game" src="https://github.com/user-attachments/assets/835a2fde-a7bd-457b-b42b-d11710a13898" />

# 💻 Technologies Used

Insurance Agency Database: Agent and Policy Management System is built using the following technologies:

📍 PostgreSQL


# 🏁 Getting Started

To get started with the Insurance Agency Database, follow these steps:

1️⃣ Clone the Repository  

Download the repository to your local machine by running the following command in your terminal:  

```bash
git clone https://github.com/hsialitskaya/DBSecure.git
```

2️⃣ Set Up PostgreSQL

Ensure you have PostgreSQL installed on your system. You can download and install PostgreSQL from [here](https://www.postgresql.org/download/). 

After installation, ensure the PostgreSQL service is running. For example, on Linux, you can run:

```bash
sudo systemctl start postgresql
```

3️⃣ Create the Database

Once PostgreSQL is installed and running, open the PostgreSQL command line tool:

```bash
psql -U postgres
```


Create the database for the insurance agency:

```bash
CREATE DATABASE insurance_agency;
```

4️⃣ Set Up the Database Schema

After creating the database, you need to set up the tables and relationships. Navigate to the folder containing the repository and open the create.sql file. This file contains the SQL queries needed to create the necessary tables, such as agents, policies, and sales.

Run the SQL script to set up the schema:

```bash
psql -U postgres -d insurance_agency -f create.sql
```

5️⃣ Populate the Database with Sample Data

To test the database, you can populate it with sample data. Open the data.sql file and run the following command to insert sample records:

```bash
psql -U postgres -d insurance_agency -f insert.sql
```


6️⃣ Add Additional Modifications

After creating the core tables and schema, you can add additional database objects that are necessary for the application. These might include custom views, stored procedures, or triggers.

To do this, navigate to the additional.sql file, which contains extra SQL statements to enhance the database. This file could include commands to create views, add indexes, or alter tables with additional fields.

To apply the modifications from additional.sql, run the following:

```bash
psql -U postgres -d insurance_agency -f additional.sql
```


7️⃣ Test the Database

After setting up the database and adding sample data, you can test the connection by querying the database. For example, to view all policies, run:

```bash
SELECT * FROM polisa;
```

8️⃣ Remove Data from the Database (Optional)

If you need to remove data from the database (but not drop the entire database), you can use the delete.sql file. This file contains SQL queries that will delete data from specific tables, such as agents, policies, and other records, without removing the structure of the tables.

To execute the deletion run the SQL script to delete data from the relevant tables (without dropping the tables themselves):

```bash
psql -U postgres -d insurance_agency -f delete.sql
```

This will delete all the data from the specified tables but leave the tables and their structure intact.

Important:
Ensure that you have backed up any important data before running the delete script, as this operation cannot be undone.  
If you want to completely remove the tables and the database, you can follow the "Remove the Database" steps mentioned in step 9 below.


9️⃣ Remove the Database (Optional)

If you ever need to delete the insurance_agency database entirely (including all tables and data), follow these steps. Be careful, as this will permanently remove the database and all its data.

Disconnect from the database if you're currently connected:
```bash
\q
```

Drop the database:

```bash
psql -U postgres -c "DROP DATABASE insurance_agency;"
```

 🆘 **This will delete the insurance_agency database and all its contents. Make sure to back up any important data before executing this command.** 🆘 

Happy coding and enjoy managing Insurance Agency Database! 🎉
