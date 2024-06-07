import { PrismaClient } from '@prisma/client'
import { faker } from '@faker-js/faker';

const prisma = new PrismaClient();

const departments = [
  { id: 1, name: 'Engineering' },
  { id: 2, name: 'Marketing' },
  { id: 3, name: 'Sales' },
  { id: 4, name: 'Human Resources' },
  { id: 5, name: 'Customer Support' },
];

const salaryRangesByDepartment = [
  { min: 60000, max: 300000 }, // engineering
  { min: 40000, max: 125000 }, // marketing
  { min: 50000, max: 100000 }, // sales
  { min: 40000, max: 60000 }, // hr
  { min: 25000, max: 50000 }, // customer support
];

const employeeCount = [
  50, // engineering
  100, // marketing
  200, // sales
  25, // hr
  300, // customer support
];

async function main() {
  console.log('seeding db...');

  // Create the departments
  console.log('creating departments...');
  await prisma.department.createMany({
    data: departments,
  });

  // add employees to departments
  for (let i = 0; i < departments.length; i += 1) {
    const dep = departments[i];

    console.log('adding employes to department:', dep.name);

    await prisma.employee.createMany({
      data: generateEmployees(dep.id, employeeCount[i]),
    })
  }
  console.log('seeding complete!');
}

function createEmployee(departmentId: number) {
  return {
    firstName: faker.person.firstName(),
    lastName: faker.person.lastName(),
    salary: faker.number.int(salaryRangesByDepartment[departmentId - 1]),
    departmentId,
    hireDate: faker.date.past({ years: 5 }),
  };
}

function generateEmployees(departmentId: number, count: number = 100) {
  const employees = [];

  for (let i = 0; i < count; i += 1) {
    employees.push(createEmployee(departmentId));
  }

  return employees;
}

main();