import fs from "fs";
import path from "path";
import readline from 'readline';

const packageJsonPath = path.join(__dirname, "package.json");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

function main() {
  rl.question("Enter challenge name: ", (name: string) => {
    try {
      // Check a name is entered
      if (name === '') {
        throw new Error('Challenge name is required');
      }

      // Validate that the challenge does not already exist

      createChallenge(name);
      rl.close();
    } catch (error: any) {
      console.log(error.message)

      main();
    }
  });
}

function createChallenge(name: string) {
  const challengeFolder = `challenge-${name}`;

  // get all challenge folders
  const doesExist = fs.readdirSync(__dirname, { withFileTypes: true })
    .filter(dirent => dirent.isDirectory())
    .map(dirent => dirent.name)
    .some(name => name === challengeFolder);

  // check if challenge folder exists, if yes throw error
  if (doesExist) {
    throw new Error(`Challenge ${name} already exists`);
  }

  console.log(`Creating challenge: ${name}...`);

  // if no, create challenge folder
  fs.mkdirSync(path.join(__dirname, challengeFolder));

  // Add the following to new folder
  // prisma directory with schema.prisma and seed.ts
  fs.mkdirSync(path.join(__dirname, challengeFolder, "prisma"));
  fs.writeFileSync(
    path.join(__dirname, challengeFolder, "prisma", "schema.prisma"),
    `generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model Item {
  id      Int      @id @default(autoincrement())
  name    String

  @@map("items")
}`);

  fs.writeFileSync(
    path.join(__dirname, challengeFolder, "prisma", "seed.ts"),
    `import { PrismaClient } from '@prisma/client'
import { faker } from '@faker-js/faker';

const prisma = new PrismaClient();

async function main() {
  console.log('seeding db...');
  for (let i = 0; i < 100; i += 1) {
    await prisma.item.create({
      data: {
        name: faker.lorem.words({min: 1, max: 3}),
      },
    });
  }
  console.log('seeding complete');
}

main();`);

  // queries directory
  fs.mkdirSync(path.join(__dirname, challengeFolder, "queries"));

  // markdown file named after challenge name
  fs.writeFileSync(path.join(__dirname, challengeFolder, `Challenge-${name}.md`),
    `# Getting Started

To get started with this challenge, run from the root directory:

\`\`\`
docker compose up database -d

npm run challenge:${name}
\`\`\`

# Tables

- List of tables goes here

# Challenges

- List of challenges goes here

# Concepts Learned

- List of concepts goes here

# Additional Resources

- Any additional resources goes here`);


  // then create challenge script
  const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, "utf-8"));

  // add challenge to scripts section
  const scripts = packageJson.scripts;

  const newChallengeScript = `challenge:${name}`;
  scripts[newChallengeScript] = `npx prisma migrate dev --name init --schema=./${challengeFolder}/prisma/schema.prisma && ts-node ./${challengeFolder}/prisma/seed.ts`;

  const newChallengeResetScript = `challenge:${name}:reset`;
  scripts[newChallengeResetScript] = `prisma migrate reset --schema=./challenge-${name}/prisma/schema.prisma`

  // write the package.json file
  fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2));
  console.log('Done creating challenge...');
}


/**
 * Script to scaffold a new challenge.
 * 
 * 1. Ask for the challenge name
 * 2. Check if the challenge already exists
 * 3. Create a new challenge folder
 * 4. Add a new script to the package.json file
 */
main();