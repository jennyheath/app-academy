class Employee
  attr_accessor :boss, :salary

  def initialize(name, title, salary)
    @name = name
    @boss = nil
    @title = title
    @salary = salary
  end

  def bonus(multiplier = 1)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary)
    super
    @employees = []
  end

  def add_employee(employee)
    @employees << employee
    employee.boss = self
  end

  def bonus(multiplier)
    if @employees.empty?
      return 0
    else
      bonus = 0
      @employees.each do |employee|
        if employee.is_a?(Manager)
          bonus += employee.salary + employee.bonus(1)
        else
          bonus += employee.salary
        end
      end
    end

    bonus * multiplier
  end


  # def bonus(multiplier)
  #   bonus_sum = 0
  #   if @employees.empty?
  #     return 0
  #   else
  #     @employees.each do |employee|
  #       if employee.is_a?(Manager)
  #         p employee.bonus(multiplier)
  #         bonus_sum += employee.bonus(multiplier)
  #       else
  #         bonus_sum += employee.salary
  #       end
  #     end
  #   end
  #   p bonus_sum
  #   bonus_sum * multiplier
  # end

end

david = Employee.new("David", "TA", 10_000)
shawna = Employee.new("Shawna", "TA", 12_000)
darren = Manager.new("Darren", "TA Manager", 78_000)
ned = Manager.new("Ned", "Founder", 1_000_000)
darren.add_employee(david)
darren.add_employee(shawna)
ned.add_employee(darren)

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)

# steve = Employee.new('steve')
# jeff = Manager.new('Jeff')
# jeff.add_employee(steve)
# p jeff.employees
