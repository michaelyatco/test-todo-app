require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it "should change a false complete to true" do
      task = Task.create(complete: false)

      task.toggle_complete!
      expect(task.complete).to eq(true)
      expect(task.complete).to_not eq(false)
    end
  end

  describe '#toggle_favorite!' do
    it "should change a false favorite to true" do
      task = Task.create(favorite: false)

      task.toggle_favorite!
      expect(task.favorite).to eq(true)
      expect(task.favorite).to_not eq(false)
    end
  end

  describe '#overdue?' do
    it "should state if Time.now is greater than deadline" do
      time = Time.now
      deadline = 4.days.ago
      task = Task.create(deadline: deadline)

      expect(task.overdue?).to eq(true)
      expect(task.overdue?).to_not eq(false)
    end
  end

  describe '#increment_priority!' do
    it "should increase priority by 1 if priority less than 10" do
      task = Task.create(priority: 9)

      task.increment_priority!
      expect(task.priority).to eq(10)
      expect(task.priority).to_not eq(9)
    end

    it "should not increase priority by 1 if priority is 10 or more" do
      task = Task.create(priority: 10)

      task.increment_priority!
      expect(task.priority).to eq(10)
      expect(task.priority).to_not eq(11)
    end
  end

  describe '#decrement_priority!' do
    it "should decrease priority by 1 if priority more than 1" do
      task = Task.create(priority: 2)

      task.decrement_priority!
      expect(task.priority).to eq(1)
      expect(task.priority).to_not eq(2)
    end

    it "should not decrease priority by 1 if priority is 1 or less" do
      task = Task.create(priority: 1)

      task.decrement_priority!
      expect(task.priority).to eq(1)
      expect(task.priority).to_not eq(0)
    end
  end

  describe '#snooze_hour!' do
    it "should increase the deadline by 1 hour" do
      deadline = Time.now
      task = Task.create(deadline: deadline)

      task.snooze_hour!
      expect(task.deadline).to eq(deadline + 1.hour)
      expect(task.deadline).to_not eq(Time.now)
    end
  end
end