# Disbursement Service

## Overview

This Repository should serve as a template for the default github configurations for Rails apps 

## Getting Started

### Prerequisites

- ruby 3.0.3
- bundler >= 2.3.3
- postgresql >= 12
- redis >= 5.0.7

## Installation

Clone this the repository:


```sh
bundle install
```

Run Migrations

```sh
rails db:setup
```

## Usage

```sh
# in one terminal
rails s
# in another terminal
sidekiq
```

## Run tests

```sh
rspec
```


## Run Linter

```sh
rubocop
```


## Swagger docs

```sh
http://localhost:3000/api-docs/index.html
```


## Tech Approach

For this challenge these pieces of code were created

1. APIs to sign in and sign up Merchants and Shopper; Users can have both roles
2. Once User signs up or signs in a JWT token will be provided in the response header see endpoints under Sessions & Auth section in Swagger
3. With this JWT token a shopper will be able to create orders for a given merchant using Order creation endpoind, the orders created from there will have a "Pending" status; Merchants are not authorized to create orders by design, Providing that ability to Merchants would require more validations
4. Using the Order completion endpoint Merchants will be able to approve their pending Orders; See endpoints under Orders section in Swagger
5. Finally Every monday at 1:00 AM a job will run to collect the completed orders for the last week (not current) and calculate the disbursement for each one.
6. There is an endpoint to see the disburments for a given week and merchant(optional) under Disbursement section in SWagger.
7.DB schema here https://dbdiagram.io/d/630d36290911f91ba5ee9aef

# Oustanding Libs used

1. Devise and Devise JWT for Authentication
2. CanCanCan for Authorization
3. Sidekiq for Background Jobs
4. Rubocop for Linter
5. Rspec for unit testing
6. RSwagger for API documentation

# TODO

1. Review Collect logic and add more tests
2. Provide the ability to cancel Orders
3. Provide the ability to create orders for any given data for testing purporses, right now via Endpoints you would need to wait one week to collect the last week orders, this was done by design.
4. Provide a flow to handle adjustments and recalculations when completed Orders are collected
5. Provide the ability to run the Collect job via Admin or API manually for a given week
5. Handle Timezones for collect Job
6. Improve Swagger Documentation by adding more cases and schemas.
7. Add the manager role to see Disbursements for all Merchants , a Merchant should only see his Disbursements
8. Add Tracking/Logs for the collect Job and better retry logic if process fails
9. Dockerize 
10. Separate this service into multiple micro services such as authentication and disbursement calculation  
11. Create a Helper or Service to calculate week number and dates and add more tests since there are too many edge cases 
12. Add more Unit testings those are never enough :)

