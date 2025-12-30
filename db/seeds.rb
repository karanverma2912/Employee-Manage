require 'faker'
# Clear existing data
[
  AuditLog,                    # No dependencies
  Performance,                 # Depends on Employee ✓
  ProjectAssignment,           # Depends on Project/Employee ✓
  # Certification join table first, THEN Certification
  Certification,               # THEN Certification
  Budget,                      # Depends on Department ✓
  Salary,                      # Depends on Employee ✓
  EmployeeProfile,             # Depends on Employee ✓
  Project,                     # Depends on ProjectAssignment (already cleared) ✓
  Employee,                    # Depends on Department/Manager ✓
  Department                   # No dependencies ✓
].each(&:delete_all)

puts "🌱 Starting database seed..."

# ============ DEPARTMENTS ============
puts "📁 Creating departments..."
hr_dept = Department.create!(
  name: 'Human Resources',
  budget_allocation: 500000
)

engineering_dept = Department.create!(
  name: 'Engineering',
  budget_allocation: 2000000
)

sales_dept = Department.create!(
  name: 'Sales',
  budget_allocation: 1500000
)

marketing_dept = Department.create!(
  name: 'Marketing',
  budget_allocation: 800000
)

finance_dept = Department.create!(
  name: 'Finance',
  budget_allocation: 1000000
)

departments = [ hr_dept, engineering_dept, sales_dept, marketing_dept, finance_dept ]

# ============ CERTIFICATIONS ============
puts "🏆 Creating certifications..."
certifications = [
  Certification.create!(
    name: 'AWS Solutions Architect',
    issuing_body: 'Amazon Web Services',
    description: 'Professional certification for AWS architecture',
    valid_from: 2.years.ago,
    valid_to: 5.years.from_now
  ),
  Certification.create!(
    name: 'Azure Developer Associate',
    issuing_body: 'Microsoft',
    description: 'Developer certification for Microsoft Azure',
    valid_from: 1.year.ago,
    valid_to: 4.years.from_now
  ),
  Certification.create!(
    name: 'Google Cloud Professional Data Engineer',
    issuing_body: 'Google Cloud',
    description: 'Professional data engineering certification',
    valid_from: 3.years.ago,
    valid_to: 2.years.from_now
  ),
  Certification.create!(
    name: 'Certified Kubernetes Administrator',
    issuing_body: 'Cloud Native Computing Foundation',
    description: 'CKA certification',
    valid_from: 1.year.ago,
    valid_to: 3.years.from_now
  ),
  Certification.create!(
    name: 'PMP - Project Management Professional',
    issuing_body: 'Project Management Institute',
    description: 'Project management certification',
    valid_from: 4.years.ago,
    valid_to: 1.year.from_now
  ),
  Certification.create!(
    name: 'Scrum Master Certified',
    issuing_body: 'Scrum Alliance',
    description: 'Agile scrum master certification',
    valid_from: 2.years.ago,
    valid_to: 3.years.from_now
  )
]

# ============ EMPLOYEES & MANAGERS ============
puts "👥 Creating employees..."

# Senior managers (no manager)
ceo = Employee.create!(
  first_name: 'Rajesh',
  last_name: 'Kumar',
  email: 'rajesh.kumar@company.com',
  job_title: 'Chief Executive Officer',
  hire_date: 10.years.ago,
  department: engineering_dept,
  manager_id: nil,
  is_active: true
)

hr_manager = Employee.create!(
  first_name: 'Priya',
  last_name: 'Sharma',
  email: 'priya.sharma@company.com',
  job_title: 'HR Manager',
  hire_date: 8.years.ago,
  department: hr_dept,
  manager_id: ceo.id,
  is_active: true
)

engineering_manager = Employee.create!(
  first_name: 'Amit',
  last_name: 'Patel',
  email: 'amit.patel@company.com',
  job_title: 'Engineering Manager',
  hire_date: 6.years.ago,
  department: engineering_dept,
  manager_id: ceo.id,
  is_active: true
)

sales_manager = Employee.create!(
  first_name: 'Deepika',
  last_name: 'Singh',
  email: 'deepika.singh@company.com',
  job_title: 'Sales Director',
  hire_date: 5.years.ago,
  department: sales_dept,
  manager_id: ceo.id,
  is_active: true
)

marketing_manager = Employee.create!(
  first_name: 'Vikram',
  last_name: 'Reddy',
  email: 'vikram.reddy@company.com',
  job_title: 'Marketing Manager',
  hire_date: 4.years.ago,
  department: marketing_dept,
  manager_id: ceo.id,
  is_active: true
)

finance_manager = Employee.create!(
  first_name: 'Anjali',
  last_name: 'Gupta',
  email: 'anjali.gupta@company.com',
  job_title: 'Finance Director',
  hire_date: 7.years.ago,
  department: finance_dept,
  manager_id: ceo.id,
  is_active: true
)

managers = [ ceo, hr_manager, engineering_manager, sales_manager, marketing_manager, finance_manager ]

# Create employee data in bulk
employee_data = []
first_names = [ 'Rohit', 'Neha', 'Arjun', 'Sneha', 'Vikram', 'Pooja', 'Sanjay', 'Ananya', 'Rahul', 'Shruti',
               'Nikhil', 'Divya', 'Aditya', 'Priya', 'Akshay', 'Meera', 'Karan', 'Zara', 'Varun', 'Tanvi',
               'Harsh', 'Isha', 'Chirag', 'Avni', 'Rohan', 'Diya', 'Kunal', 'Nisha', 'Anish', 'Sakshi' ]
last_names = [ 'Verma', 'Chopra', 'Nair', 'Malhotra', 'Arora', 'Kapoor', 'Bhat', 'Desai', 'Iyer', 'Kulkarni',
              'Joshi', 'Pandey', 'Rao', 'Mishra', 'Saxena', 'Tiwari', 'Singh', 'Khan', 'Roy', 'Das' ]

job_titles = {
  engineering_dept => [ 'Senior Developer', 'Full Stack Developer', 'DevOps Engineer', 'Frontend Developer', 'Backend Developer', 'QA Engineer', 'Solutions Architect' ],
  sales_dept => [ 'Sales Executive', 'Account Manager', 'Business Development Manager', 'Sales Representative' ],
  marketing_dept => [ 'Digital Marketing Specialist', 'Content Writer', 'Marketing Executive', 'SEO Specialist' ],
  hr_dept => [ 'HR Executive', 'Recruiter', 'Training Specialist' ],
  finance_dept => [ 'Accountant', 'Financial Analyst', 'Audit Manager' ]
}

50.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  department = departments.sample
  manager = department.employees.where.not(manager_id: nil).sample || managers.sample

  employee_data << {
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}#{i}@company.com",
    job_title: job_titles[department].sample,
    hire_date: Faker::Date.between(from: 10.years.ago, to: 6.months.ago),
    department_id: department.id,
    manager_id: manager.id,
    is_active: [ true, true, true, false ].sample,
    created_at: Time.current,
    updated_at: Time.current
  }
end

Employee.insert_all(employee_data)
puts "✅ Created #{Employee.count} total employees"

# ============ EMPLOYEE PROFILES ============
puts "👤 Creating employee profiles..."
profile_data = Employee.all.map do |emp|
  {
    employee_id: emp.id,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    country: 'India',
    date_of_birth: Faker::Date.between(from: 60.years.ago, to: 20.years.ago),
    created_at: Time.current,
    updated_at: Time.current
  }
end

EmployeeProfile.insert_all(profile_data)
puts "✅ Created #{EmployeeProfile.count} employee profiles"

# ============ SALARIES ============
puts "💰 Creating salary records..."
salary_data = []
Employee.all.each do |emp|
  base_salary = case emp.job_title
  when /Manager|Director|CEO/
                  Faker::Number.between(from: 1500000, to: 3000000)
  when /Senior|Architect/
                  Faker::Number.between(from: 1000000, to: 1500000)
  when /Developer|Engineer|Specialist/
                  Faker::Number.between(from: 600000, to: 1000000)
  else
                  Faker::Number.between(from: 400000, to: 700000)
  end

  # Current salary
  salary_data << {
    employee_id: emp.id,
    amount: base_salary,
    effective_from: Faker::Date.between(from: 3.years.ago, to: 6.months.ago),
    effective_to: nil,
    currency: 'INR',
    created_at: Time.current,
    updated_at: Time.current
  }

  # Previous salary (50% chance)
  if rand > 0.5
    salary_data << {
      employee_id: emp.id,
      amount: (base_salary * 0.85).to_i,
      effective_from: Faker::Date.between(from: 5.years.ago, to: 3.years.ago),
      effective_to: salary_data.last[:effective_from] - 1.day,
      currency: 'INR',
      created_at: Time.current,
      updated_at: Time.current
    }
  end
end

Salary.insert_all(salary_data)
puts "✅ Created #{Salary.count} salary records"

# ============ PROJECTS ============
puts "🚀 Creating projects..."
project_data = []
20.times do |i|
  project_data << {
    name: Faker::App.name,
    description: Faker::Lorem.paragraphs(number: 2).join(' '),
    start_date: Faker::Date.between(from: 2.years.ago, to: 1.month.ago),
    end_date: [ nil, Faker::Date.between(from: Time.current, to: 2.years.from_now) ].sample,
    budget: Faker::Number.between(from: 500000, to: 5000000),
    status: [ 'Active', 'Active', 'Active', 'Completed', 'On Hold', 'Planning' ].sample,
    created_at: Time.current,
    updated_at: Time.current
  }
end

Project.insert_all(project_data)
puts "✅ Created #{Project.count} projects"

# ============ PROJECT ASSIGNMENTS ============
puts "🔗 Creating project assignments..."
project_assignment_data = []
Project.all.each do |project|
  rand(3..8).times do
    employee = Employee.where(department_id: engineering_dept.id).sample
    break if employee.nil?

    project_assignment_data << {
      employee_id: employee.id,
      project_id: project.id,
      assigned_date: Faker::Date.between(from: project.start_date, to: project.start_date + 3.months),
      end_date: project.end_date,
      hours_allocated: [ 20, 30, 40, 50 ].sample,
      created_at: Time.current,
      updated_at: Time.current
    }
  end
end

ProjectAssignment.insert_all(project_assignment_data)
puts "✅ Created #{ProjectAssignment.count} project assignments"

# ============ CERTIFICATIONS ASSIGNMENTS ============
puts "🎓 Assigning certifications to employees..."
Employee.all.each do |emp|
  certifications.sample(rand(0..4)).each do |cert|
    emp.certifications << cert
  end
end
puts "✅ Assigned certifications to employees"

# ============ PERFORMANCES ============
puts "⭐ Creating performance records..."
performance_data = []
Employee.all.each do |emp|
  (1..3).each do |year_offset|
    performance_data << {
      employee_id: emp.id,
      review_date: Date.new(Date.current.year - year_offset, Faker::Number.between(from: 1, to: 12), Faker::Number.between(from: 1, to: 28)),
      rating: Faker::Number.between(from: 1, to: 5),
      comments: Faker::Lorem.sentences(number: 3).join(' '),
      created_at: Time.current,
      updated_at: Time.current
    }
  end
end

Performance.insert_all(performance_data)
puts "✅ Created #{Performance.count} performance records"

# ============ BUDGETS ============
puts "💵 Creating budgets..."
budget_data = []
departments.each do |dept|
  budget_data << {
    department_id: dept.id,
    allocated_amount: dept.budget_allocation,
    spent_amount: (dept.budget_allocation * Faker::Number.between(from: 40, to: 95) / 100).to_i,
    fiscal_year: Date.current.year,
    created_at: Time.current,
    updated_at: Time.current
  }
end

Budget.insert_all(budget_data)
puts "✅ Created #{Budget.count} budgets"

# ============ AUDIT LOGS ============
puts "📋 Creating audit logs..."
audit_log_data = []

# Audit logs for employees
Employee.limit(10).each do |emp|
  audit_log_data << {
    auditable_id: emp.id,
    auditable_type: 'Employee',
    action: 'created',
    changes_data: { first_name: emp.first_name, last_name: emp.last_name }.to_json,
    changed_by: 'system',
    created_at: emp.created_at,
    updated_at: emp.created_at
  }
end

# Audit logs for departments
departments.each do |dept|
  audit_log_data << {
    auditable_id: dept.id,
    auditable_type: 'Department',
    action: 'updated',
    changes_data: { budget_allocation: dept.budget_allocation }.to_json,
    changed_by: 'admin',
    created_at: Time.current,
    updated_at: Time.current
  }
end

AuditLog.insert_all(audit_log_data)
puts "✅ Created #{AuditLog.count} audit logs"

puts "\n" + "="*50
puts "🎉 Database seeding completed successfully!"
puts "="*50
puts "\nSummary:"
puts "  📁 Departments: #{Department.count}"
puts "  👥 Employees: #{Employee.count}"
puts "  💰 Salary Records: #{Salary.count}"
puts "  🚀 Projects: #{Project.count}"
puts "  🔗 Project Assignments: #{ProjectAssignment.count}"
puts "  🏆 Certifications: #{Certification.count}"
puts "  ⭐ Performance Records: #{Performance.count}"
puts "  💵 Budgets: #{Budget.count}"
puts "  📋 Audit Logs: #{AuditLog.count}"
