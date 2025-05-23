# lib/tasks/sample_data.rake

require 'csv'

desc "Fill the database tables with some sample data"
task({ sample_data: :environment }) do
  puts "Sample data task running..."

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  puts "Clearing existing data..."
  Party.destroy_all
  Task.destroy_all
  Contract.destroy_all
  User.destroy_all

  puts "Loading Users..."
  CSV.foreach(Rails.root.join('db', 'sample_data', 'Sample Data Upload - Users.csv'), headers: true) do |row|
    User.create!(
      id: row['id'],
      email: row['email'],
      encrypted_password: row['encrypted_password'],
      first_name: row['first_name'],
      last_name: row['last_name'],
      account_type: row['account_type'],
      organization: row['organization'],
      created_at: row['created_at'],
      updated_at: row['updated_at'],
      username: row['username']
    )
  end

  puts "Loading Contracts..."
  CSV.foreach(Rails.root.join('db', 'sample_data', 'Sample Data Upload - Contracts.csv'), headers: true) do |row|
    Contract.create!(
      id: row['id'],
      contract_name: row['contract_name'],
      monetary_comp: row['monetary_comp'],
      other_comp: row['other_comp'],
      created_by: row['created_by'],
      token: row['token'],
      tasks_count: row['tasks_count'],
      created_at: row['created_at'],
      updated_at: row['updated_at'],
      description: row['description'],
      status: row['status']
    )
  end

  puts "Loading Tasks..."
  CSV.foreach(Rails.root.join('db', 'sample_data', 'Sample Data Upload - Tasks.csv'), headers: true) do |row|
    Task.create!(
      id: row['id'],
      contract_id: row['contract_id'],
      task_name: row['task_name'],
      description: row['description'],
      created_by: row['created_by'],
      deadline: row['deadline'],
      completion_status: row['completion_status'] == 'true',
      completed_on: row['completed_on'].presence,
      created_at: row['created_at'],
      updated_at: row['updated_at'],
      assigned_to: row['assigned_to']
    )
  end

  puts "Loading Parties..."
  CSV.foreach(Rails.root.join('db', 'sample_data', 'Sample Data Upload - Parties.csv'), headers: true) do |row|
    Party.create!(
      id: row['id'],
      contract_id: row['contract_id'],
      party_id: row['party_id'],
      created_at: row['created_at'],
      updated_at: row['updated_at']
    )
  end

  puts "Done loading!"
  puts "Users: #{User.count}"
  puts "Contracts: #{Contract.count}"
  puts "Tasks: #{Task.count}"
  puts "Parties: #{Party.count}"
end
