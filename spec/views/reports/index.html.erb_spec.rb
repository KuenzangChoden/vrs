require 'spec_helper';

RSpec.describe "reports/index", type: :view do 
	current_admin= Admin.first_or_create!(email:'a@gmail', password: 'password', password_confirmation:'password')
	before(:each) do 
		assign(:reports, [
			Report.create!(
				name: 'name',
				email: 'email@email.com',
				address: 'address',
				phone: '17000000',
				vtype: 'Domestic violence',
				
				status: 'pending',


				),
			Report.create!(
				name: 'name',
				email: 'email@email.com',
				address: 'address',
				phone: '17000000',
				vtype: 'Domestic violence',

				status: 'inprogress',
				admin_id: current_admin.id,
				

				)
		])
		
	end

	it "renders a list of reports" do
		render
		assert_select 'tr>td', text: "name".to_s, count: 2
		assert_select 'tr>td', text: "email@email.com".to_s, count: 2
		assert_select 'tr>td', text: "17000000".to_s, count: 2
		assert_select 'tr>td', text: "Domestic violence".to_s, count: 2
		assert_select 'tr>td', text: "".to_s, count: 1
		assert_select 'tr>td', text: current_admin.id.to_s, count: 1
		assert_select 'tr>td', text: "pending".to_s, count: 1
		assert_select 'tr>td', text: 'inprogress'.to_s, count: 1

	end

end 