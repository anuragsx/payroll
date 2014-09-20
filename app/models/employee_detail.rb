class EmployeeDetail < ActiveRecord::Base

  SEX = [["Male",1], ["Female",0]]

  belongs_to :employee

  def formatted_date_of_birth
    date_of_birth.to_s(:month_date_and_year) if date_of_birth
  end
  
end
