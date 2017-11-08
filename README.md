# Bangazon Terminal Interface - Tutshill Tornados

Welcome to The Command Line Ordering System. This project will allow a user to interact with a basic product ordering database via a command line interface.

- [Get Started](#get-started)
- [Install](#install)
- [Setup Database](#setup-database)
  - [Build the Database](#build-the-database)
  - [Seed the Database](#seed-the-database) (OPTIONAL)
- [Database Admin](#database-admin)
  - [Drop All Tables](#drop-all-tables)
  - [Drop Individual Tables](#drop-individual-tables)
  - [Build the Database](#build-the-database)
- [Ordering System Interface](#ordering-system-interface)
- [Software Versions](#software-versions)
- [Contribute](#contribute)
- [Report Bugs](#report-bugs)
- [Meet the Dev Team](#meet-the-dev-team)

## Video Walk Through of the App
[![Bangazon Terminal Interface](http://www.drteresavasquez.com/wp-content/uploads/2017/11/bangazon-e1510170979908.png)](https://www.youtube.com/watch?v=Jaita4YJUJo)

## Get Started

To get started, navigate to the directory of your choice and run the following code in the command line
```ruby
git clone https://github.com/TutshillTornados/Bangazon_Terminal_Interface.git
cd Bangazon_Terminal_Interface
```
If you would like to run this app on your local machine, these installation tips are a helpful quick start. 

### Install

* [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [Install SQLite3](https://rubygems.org/gems/sqlite3-ruby/versions/1.3.3)
* Install Faker Gem
```ruby
gem install faker
```

### Setup Database
After forking the repo and installing Ruby and SQLite3, in console, run the following code to setup the database

**Build the Database**
```ruby
ruby lib/database_admin/build_database.rb
```
**Seed the Database**
```ruby
ruby lib/database_admin/seed.rb
```

### Database Admin
If there comes a time that you need to drop tables or update the database here are some options...

**Drop All Tables**
```ruby
ruby lib/database_admin/drop_all_tables.rb
```
**Drop Individual Tables**

**_Customers Table_**
```ruby
ruby lib/database_admin/drop_customers.rb
```
**_Orders Table_**
```ruby
ruby lib/database_admin/drop_orders.rb
```
**_Payments Table_**
```ruby
ruby lib/database_admin/drop_payments.rb
```
**_Products Table_**
```ruby
ruby lib/database_admin/drop_products.rb
```
**_Order-Products Table_**
```ruby
ruby lib/database_admin/drop_order_products.rb
```
To rebuild the database, use the Build the Database command
```ruby
ruby lib/database_admin/build_database.rb
```

## Ordering System Interface
Below is a view of the main menu for the terminal interface.

To begin the program, run:
```ruby
ruby init.rb
```

### Main Menu

```ruby
*********************************************************
**  Welcome to Bangazon! Command Line Ordering System  **
*********************************************************
1. Create a customer account
2. Choose active customer
3. Create a payment option
4. Add product to sell
5. Add product to shopping cart
6. Complete an order
7. Remove customer product
8. Update product information
9. Show stale products
10. Show customer revenue report
11. Show overall product popularity
12. Leave Bangazon!
>
```

![alt text](http://www.drteresavasquez.com/wp-content/uploads/2017/11/orderinterface.png "Bangazon! Command Line Ordering System")

<!-- [See more details about the interface](https://github.com/TutshillTornados/Bangazon_Terminal_Interface/blob/master/ORDERING_SYSTEM_INTERFACE.md) -->

## Software Versions
```ruby
SQLite  Ver 3.20.1
Ruby Ver 2.4.2p198
```

## Contribute
Fork this repository and submit your contributions as a [pull request](https://github.com/TutshillTornados/Bangazon_Terminal_Interface/blob/master/PULL_REQUEST_TEMPLATE.md) using the PR template.

## Report Bugs
Create an [issue report](https://github.com/TutshillTornados/Bangazon_Terminal_Interface/issues/new)

## Meet the Dev Team
- [Austin Kurtis](https://github.com/austinKurtis)
- [Daniel Greene](https://github.com/danielgreene101)
- [Matt Minner](https://github.com/Mminner4248)
- [Dr. Teresa Vasquez](https://github.com/drteresavasquez)
