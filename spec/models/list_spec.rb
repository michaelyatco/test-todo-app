require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it "should mark all of a list's tasks as complete" do
      list = List.create(name: "Jack Spy Me 3")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      # expect(list.tasks.where(complete: true).length).to eq(3)
      list.tasks.map { |task|
        expect(task.complete).to eq(true) }
    end
  end

  describe '#snooze_all_tasks!' do
    it "should add one hour to all tasks's deadlines" do
      list = List.create(name: "Jack Spy Me 3")
      deadline = 1.hour.ago
      new_deadline = deadline + 1.hour
      Task.create(deadline: deadline, list_id: list.id)
      Task.create(deadline: deadline, list_id: list.id)
      Task.create(deadline: deadline, list_id: list.id)
      list.snooze_all_tasks!
      # expect(list.tasks.where(complete: true).length).to eq(3)
      list.tasks.each do |task|
        # binding.pry
        expect(task.deadline).to eq(new_deadline)
      end
    end
  end
 
  describe '#total_duration' do
    it "should mark all of a list's tasks as complete" do
      list = List.create(name: "Jack Spy Me 3")
      Task.create(duration: 0, list_id: list.id)
      Task.create(duration: 3, list_id: list.id)
      Task.create(duration: 5, list_id: list.id)
      list.total_duration
      expect(list.total_duration).to eq(8) 
    end
  end

  describe '#incomplete_tasks' do
    it "should push all incomplete tasks into the array" do
      list = List.create(name: "Jack Spy Me 3")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      incomplete_tasks = list.incomplete_tasks
      incomplete_tasks.each do |task|
        expect(task.complete).to eq(false) 
      end
    end
  end

  describe '#favorite_tasks' do
    it "should push all favorite tasks into the array" do
      list = List.create(name: "Jack Spy Me 3")
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: true, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      list.favorite_tasks
      expect(list.favorite_tasks.length).to eq(1) 
    end
  end


end
