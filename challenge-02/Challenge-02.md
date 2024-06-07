# Getting Started

To get started with this challenge, run from the root directory:

```
docker compose up database -d

npm run challenge:01
```

# Tables

- departments

```
{
  id: Int;
  name: String;
}
```

- employees

```
{
  id: Int;
  first_name: VarChar(50);
  last_name: VarChar(50);
  salary: Int;
  department_id: Int;
  hire_date: DateTime;
}
```

# Challenges

- How many departments are there?
- What is the employee count per department?
- What is the average salary for all employees?
- What is the average salary per department?
- Who is the highest paid employee?
- Who is the highest paid employee per department?
- What is the minimum and maximum salaries at the company? Per department?
- What's the variability of salary per department?
- Do we see a yearly increase in salaries for new employees?
- Who has been at the company longest?
- Can you extract the year and month a person was hired?
- What year saw the most people hired?

# Concepts Learned

- List of concepts goes here

# Additional Resources

- Any additional resources goes here
