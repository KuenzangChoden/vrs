require 'rails_helper'

RSpec.describe Report, type: :model do
  current_admin= Admin.first_or_create!(email: 'a@a.com', password:'password', password_confirmation:'password')
  
  # it "has an admin" do

  # end

  it "has a email" do
    report= Report.new(
      email:"",
      name:"test sender",
      phone:"17888888",
      address:'street',
      vtype: "Domestic violence",
      )

    expect(report).to_not be_valid
    report.email="ts@example.com"
    expect(report).to be_valid
  end

  it "has a phone" do
    report= Report.new(
      email:"ts@example.com",
      name:"test sender",
      phone:"",
      address:'street',
      vtype: "Domestic violence",
      )

    expect(report).to_not be_valid
    report.phone="17000000"
    expect(report).to be_valid
  end

  it "has a address" do
    report= Report.new(
      email:"ts@example.com",
      name:"test sender",
      phone:"17000000",
      address:'',
      vtype: "Domestic violence",
      )

    expect(report).to_not be_valid
    report.address="xdfsadf"
    expect(report).to be_valid
  end

  it "has a vtype" do
    report= Report.new(
      email:"ts@example.com",
      name:"test sender",
      phone:"17000000",
      address:'asdsdf',
      vtype: "",
      )

    expect(report).to_not be_valid
    report.vtype="Domestic violence"
    expect(report).to be_valid
  end

 
  # it "has an admin" do
  #   report= Report.new(
  #     email:"ts@example.com",
  #     name:"test sender",
  #     phone:"17000000",
  #     address:'asdsdf',
  #     vtype: "Domestic violence",
  #     status: "completed",
  #     admin_id: "",
  #     )

    
  #   expect(report).to_not be_valid
  #   report.admin_id= current_admin.id
  #   expect(report).to be_valid

  # end
end
