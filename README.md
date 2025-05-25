### 1. PostgreSQL কী?
**PostgreSQL** হলো একটি উন্নতমানের ওপেন-সোর্স Relational Database Management System (RDBMS)। এটি ডেটাবেইজ তৈরি, পরিচালনা ও অনুসন্ধানের জন্য ব্যবহৃত হয়। PostgreSQL ACID (Atomicity, Consistency, Isolation, Durability) প্রিন্সিপল অনুসরণ করে, যার ফলে ডেটা সঠিক ও নিরাপদ থাকে। এটি SQL standard অনুসরণ করে এবং জটিল query, table relationship, trigger, stored procedure, এবং JSON data type সাপোর্ট করে। বড় বড় websites, enterprise systems এবং data-centric applications এ এটি ব্যাপকভাবে ব্যবহৃত হয়।

**উদাহরণ:**  
একটি web application যেখানে ইউজারদের তথ্য সংরক্ষণ করা হয়, সেখানে PostgreSQL ব্যবহার করা যেতে পারে যেহেতু এটি স্কেলযোগ্য এবং নিরাপদ।

---

### 2. PostgreSQL-এ Database Schema-এর উদ্দেশ্য কী?
**Database schema** হলো একটি logical structure যা ডেটাবেসের ভেতরে থাকা objects (যেমন table, view, function ইত্যাদি) কে সংগঠিত ও শ্রেণীবদ্ধ করে। এটি বিভিন্ন ইউজার বা অ্যাপ্লিকেশনের মধ্যে ডেটা ভাগ করার সুযোগ দেয়। এর মাধ্যমে ডেটার organization এবং security আরও উন্নত হয়।

**উদাহরণ:**
`public` হলো ডিফল্ট schema, কিন্তু আপনি চাইলে `sales` এবং `hr` নামে দুটি schema তৈরি করে সেই অনুযায়ী ডেটা আলাদা রাখতে পারেন, যেমন:

```sql
CREATE SCHEMA sales;
CREATE SCHEMA hr;
```

---

### 3. PostgreSQL-এ Primary Key এবং Foreign Key কী?
**Primary Key** হলো এমন একটি বা একাধিক কলামের সমষ্টি যেগুলোর মাধ্যমে প্রতিটি রেকর্ডকে ইউনিকভাবে শনাক্ত করা যায়। এতে duplicate বা NULL ভ্যালু থাকতে পারে না।

**Foreign Key** হলো একটি কলাম যেটা অন্য একটি টেবিলের Primary Key-এর রেফারেন্স হিসেবে কাজ করে। এটি দুইটি টেবিলের মধ্যে সম্পর্ক স্থাপন করে।

**উদাহরণ:**

```sql
CREATE TABLE departments (
  dept_id SERIAL PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE employees (
  emp_id SERIAL PRIMARY KEY,
  emp_name VARCHAR(50),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```

এখানে `departments` টেবিলের `dept_id` হলো Primary Key এবং `employees` টেবিলের `dept_id` হলো Foreign Key।

---

### 4. VARCHAR এবং CHAR ডেটা টাইপের মধ্যে পার্থক্য কী?
**CHAR(n)** হলো Fixed-length ডেটা টাইপ, যেখানে আপনি যে সাইজ দেন, প্রতিটি ভ্যালু সেই সাইজ অনুযায়ী সংরক্ষিত হয়, এমনকি যদি কম ক্যারেক্টার থাকে তাও ফাঁকা জায়গায় padding করে।

**VARCHAR(n)** হলো Variable-length ডেটা টাইপ, যেখানে ডাটা ঠিক যতটুকু দরকার, ততটুকু জায়গা নেয়।  এটি storage efficiency এবং performance এর জন্য ভালো।

**উদাহরণ:**

```sql
CREATE TABLE test_char (
  name CHAR(10)
);

CREATE TABLE test_varchar (
  name VARCHAR(10)
);
```

যদি `name` কলামে "Shamim" ইনসার্ট করা হয়, তাহলে `CHAR(10)` টাইপে অতিরিক্ত 4টা স্পেস রাখা হবে, কিন্তু `VARCHAR(10)` টাইপে শুধু 6 ক্যারেক্টারই সংরক্ষিত হবে।

---

### 5. SELECT স্টেটমেন্টে WHERE ক্লজের ভূমিকা কী?
**WHERE** ব্যবহার করা হয় ডেটা filter করার জন্য। এটি একটি নির্দিষ্ট condition নির্ধারণ করে যেটির ভিত্তিতে শুধুমাত্র প্রাসঙ্গিক রেকর্ডগুলো retrieve করা হয়।

**উদাহরণ:**

```sql
SELECT * FROM employees
WHERE dept_id = 2;
```

এই কুয়েরিটি `employees` টেবিল থেকে শুধুমাত্র সেইসব এমপ্লয়িদের রেকর্ড রিটার্ন করবে যাদের `dept_id` হলো 2।
