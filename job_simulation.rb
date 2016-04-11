require './stack.rb'
require './Queue.rb'

class Employees

  attr_accessor :total_employees, :available_positions  #if company wants to adjust number of available positions
  attr_reader :workers, :waiting

  def initialize(company_info)
    @available_positions = company_info[:available_positions].to_i
    @total_employees = company_info[:total_employees].to_i
    start_process
  end

  def start_process
    @waiting = Queue.new # enqueue, dequeue
    @workers = Stack.new # push, pop
    @total_employees_array = (1..@total_employees).to_a
    employee_initial_position
  end

  def employee_initial_position

    @total_employees_array.each do |emp|
      if emp <= @available_positions
        @workers.push(emp)
      else
        @waiting.enqueue(emp)
      end
    end

  end

  def employee_position_rotation
    # dice_roll method returns a random number from 1 to to available_positions
    rotation_number = dice_roll

    # moves employees that are fired to @waiting list
    fired(rotation_number)

    # moves employees that are hired to @workers list
    hired(rotation_number)

  end

  def fired(rotation_number)

    rotation_number.times do
      fired = @workers.pop
      @waiting.enqueue(fired)
    end

  end

  def hired(rotation_number)

    rotation_number.times do
      hired = @waiting.dequeue
      @workers.push(hired)
    end

  end

  def dice_roll
    rand(1..@available_positions.to_i)
  end

  def reset
    start_process
  end

  def status
    status = {workers: @workers, waiting: @waiting}
  end
  
end

@company = Employees.new(available_positions: 6, total_employees: 10)
