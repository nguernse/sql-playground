# About

This project is a playground for learning to write SQL queries using a [Postgresql](https://www.postgresql.org/) Database.

The project is organized into **challenges** around different types of data (blog posts, e-commerce orders, salaries, etc.). Each challenge includes everything needed to start querying data.

The goal of each challenge is to focus on practicing specific concepts on writing SQL queries, forcing you to think how the data is related and how to answer questions about the data.

This project is **not** about database management. Just a way to practice querying data from an existing database.

# Why?

I like to learn by doing, usually by breaking things :). At the time of this project, I had mostly worked with non-relational databases, like MongoDB. I had wanted to learn SQL and Postgresql as they are standard technologies in the industry.

To that end, while there are plenty of publicly available datasets to work with, I didn't want to hunt down sample data to practice SQL. Sometimes there's a certain scenario to practice, but would be a time sink to find the appropriate data. So I chose to use [fakerjs](https://fakerjs.dev/guide/) and [prisma](https://www.prisma.io).

Prisma is used to quickly setup the database and schemas, while Faker is used to populate the database with "fake but reasonable data"[[1]](https://fakerjs.dev/guide/).

# Getting Started

To get started with this project you will need two things:

- [Docker](https://www.docker.com/) to spin up and tear down a local database
- [pgAdmin4](https://www.pgadmin.org/) or any similar GUI to query the data

Once you have these two installed, the next steps are:

1. Spin up the database

```
docker compose up -d
```

2. Seed the database with a challenge

```
npm run challenge:01
```

3. Connect to the database with pgAdmin.

```
Host name: localhost
Port: 5432
Database: postgres
Username: postgres
Password: postgres
```

4. Start playing! You can find accompanying info for a challenge in the `/challenge-*` directories.

# Stopping the Database

```
docker compose down
```

# Stopping and removing data

```
docker compose down -v
```

> NOTE: If you clear the volumes you will need to re-seed the database.

# Troubleshooting

- Make sure you have the docker container running. See step 1.
- If you need to reset the database for a challenge run:

```
npm run challenge:<challenge>:reset
```

for example:

```
npm run challenge:01:reset
```

# Extending the project

> **TIP**: If you do not want to manually create a challenge, you can run `npm run challenge:add` to scaffold a new challenge.

This project can be extended by doing the following:

- Create a new `challenge` folder
- Create a `prisma` sub-directory
- Create ` schema.prisma` file and add your [prisma schemas](https://www.prisma.io/docs/orm/prisma-schema)
- Create a `seed.ts` file and write the methods to [seed](https://www.prisma.io/docs/orm/prisma-migrate/workflows/seeding#integrated-seeding-with-prisma-migrate) the database using fake data with [fakerjs](https://fakerjs.dev/guide/).
- Add a new setup script to the `package.json` file. The format is `challenge:<number>`.
- Then follow the getting started steps

Search for `challenge-01` as an example.

> **NOTE**: Prisma is used for convenience. If you would like to use another ORM for the playground. Feel free to swap it out.

> **Bonus**: Extending the project with new challenges also lets you practice designing data schemas and think about how data relations work.

> **Bonus^2** If you are wanting to learn an ORM, like Prisma, feel free to play around with schemas, data types, migrations, and [other concepts](https://www.prisma.io/docs/orm). You could convert those into challenges if you'd like.

# Resources

- [W3Schools SQL](https://www.w3schools.com/sql/default.asp)
- [Postgresql Essential Training](https://www.linkedin.com/learning-login/share?account=73720220&forceAccount=false&redirect=https%3A%2F%2Fwww.linkedin.com%2Flearning%2Fpostgresql-essential-training-22611610%3Ftrk%3Dshare_ent_url%26shareId%3DqknDBWjVQzCsk7Kymxu5QA%253D%253D)
- [Postgresql Advanced Queries](https://www.linkedin.com/learning-login/share?account=73720220&forceAccount=false&redirect=https%3A%2F%2Fwww.linkedin.com%2Flearning%2Fpostgresql-advanced-queries%3Ftrk%3Dshare_ent_url%26shareId%3DgXxcHnbETAGlj95E6cRkBA%253D%253D)
- [Prisma SQL Examples](https://github.com/prisma/database-schema-examples/tree/main/postgres)
- [SQL Murder Mystery](https://mystery.knightlab.com/)
- [Select Star SQL](https://selectstarsql.com/beazley.html)
