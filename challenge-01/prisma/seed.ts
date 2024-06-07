import { PrismaClient } from '@prisma/client'
import { faker } from '@faker-js/faker';

const prisma = new PrismaClient();

function numbersBetween(min: number = 1, max: number = 10) {
  return Array.from({ length: (max - min) + 1 }, (_, i) => i + min);
}

async function main() {
  console.log('seeding db...');
  for (let i = 0; i < 100; i += 1) {
    await prisma.user.create({
      data: {
        ...generateUser(),
        profile: {
          create: generateProfile()
        },
        posts: {
          create: generatePosts(faker.helpers.arrayElement(numbersBetween(0, 50))),
        }
      },
    });
  }
  console.log('seeding complete');
}

function generateUser() {
  const firstName = faker.person.firstName();
  const lastName = faker.person.lastName();

  return {
    email: faker.internet.email({ firstName, lastName }),
    name: `${firstName} ${lastName}`,
  }
}

function generateProfile() {
  return {
    bio: faker.lorem.sentences({ min: 1, max: 3 }),
  }
}

function generatePosts(n: number = 3) {
  const posts = [];

  for (let i = 0; i < n; i += 1) {
    posts.push({
      title: faker.lorem.sentence({ min: 3, max: 10 }),
      content: faker.lorem.paragraphs(3),
      published: faker.helpers.arrayElement([true, false]),
      createdAt: faker.date.past({ years: 2 })
    });
  }

  return posts;
}

main();