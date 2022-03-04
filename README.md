# Buycoins Engineering Challenge

> A solution to the Buycoins backend engineering challenge

## About This Project
The project is a GraphQL API that collects user's banking details and fetches their bank account name from through the Paystack API. The program also calculates the levenshtein distance between user supplied names and the Paystack supplied name, so it can still verify user's in cases of simple misspellings.

## Built With

- Ruby v3.0.0
- Ruby on Rails 6
- GraphQL
- Paystack API

### Set up Project

- Install [git](https://git-scm.com/downloads)
- Install [the Ruby programming language](https://ruby-doc.org/downloads/), if you haven't already.
- - Install [the Ruby on Rails MVC Framework](https://rubyonrails.org/), if you haven't already.
- Open Terminal
- Navigate to the preferred location/folder you want the app on your local machine. Use `cd <file-path>` for this.
- Run `git clone https://github.com/Moreneecoder/buycoins-challenge.git` to download the project source code.
- Now that you have a local copy of the project, navigate to the root of the project folder from your terminal.
- Run `bundle install` to install all dependencies in the Gemfile file.

### Set up Database
- This project uses [postgresql](https://www.postgresql.org/download/), so ensure you have that installed first
- Run the commands below to create and migrate database
```
   rails db:create
   rails db:reset
   rails db:migrate
```

### Other Dependencies
- Paystack Bank Resolution API: Bank account resolution is handled by [Paystack](https://paystack.com/), to set this up, create an account and enter the details of your paystack test api secret key in the .env file as detailed further below.

- Install the gem `dotenv-rails`.
- Create .env file in the project root directory to locally store/use your Paystack APIs like so:
```
PAYSTACK_SECRET=<YOUR_PAYSTACK_SECRET_KEY>
```

> 🗣 NOTE: All PAYSTACK API KEYS can be found in your Paystack dashboard, under **_Settings_**.

## Running Tests
- RSpec: This is a tool for testing the effectiveness of the program's logic at every step. To set up RSpec:
  - run `gem install rspec` in your terminal. This should install rspec globally on your local machine.
  - run `rspec --version`. This should display your rspec version if successfully installed.
  - run `rspec` to see passing and failing tests.

### Usage

- Start server with: `rails server`

- Open [http://localhost:3000/graphiql](http://localhost:3000/graphiql) in your browser to access a query enviroment.

## Authors

👤 **Bello Morenikeji Fuad**

- GitHub: [@moreenecoder](https://github.com/Moreneecoder)
- Twitter: [@mo_bello19](https://twitter.com/mo_bello19)
- LinkedIn: [Morenikeji Bello](https://linkedin.com/in/morenikeji-bello)

## Acknowledgments

[Buycoins Africa](https://buycoins.africa/)

## 📝 License

This project is [MIT](./LICENSE) licensed.