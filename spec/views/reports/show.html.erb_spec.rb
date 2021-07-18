# require 'spec_helper';

# RSpec.describe "reports/show", type: :view do 
# 	current_admin= Admin.first_or_create!(email:'a@gmail', password: 'password', password_confirmation:'password')
# 	before(:each) do 
# 		@report = assign(:report, Report.create!(
# 				name: 'name',
# 				email: 'email@email.com',
# 				address: 'address',
# 				phone: '17000000',
# 				vtype: 'Domestic violence',
				
# 				status: 'pending',


# 				))
		
# 	end

# 	it "renders attribute in <p>" do
# 		render
# 		expect(rendered).to match(/name/)
# 		expect(rendered).to match(/email/)
# 		expect(rendered).to match(/phone/)
# 		expect(rendered).to match(/address/)
# 		expect(rendered).to match(/Domestic violence/)
# 		expect(rendered).to match(/pending/)
# 	end

# end 