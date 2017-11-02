# Bangazon Terminal Interface - Tutshill Tornados

Welcome to The Command Line Ordering System. This project will be allow a user to interact with a basic product ordering database via a command line interface.

## Get Started

To get started, navigate to the directory of your choice and run the following code in the command line
```
git clone https://github.com/TutshillTornados/Bangazon_Terminal_Interface.git
cd Bangazon_Terminal_Interface
```
If you would like to run this api on your local machine, these installation tips are a helpful quick start. 

### Install

* [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [Install SQLite3](https://rubygems.org/gems/sqlite3-ruby/versions/1.3.3)

### Setup Database
After forking the repo and installing Ruby and SQLite3, in console, run the following code to setup the database
```
ruby init.rb
```
Exit the Program
```
> 12
```
Build the Database
```
ruby lib/dba/build_database.rb
```
Then seed the database
```
ruby lib/support/seed.rb
```

## Ordering System Interface
Below is a view of the main menu for the terminal interface.

### Main Menu
```
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

## Software Versions
```
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
