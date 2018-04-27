require 'rails_helper'

RSpec.describe PrepProcessMachine, type: :model do
  context "#find_or_create" do
    before(:each) do
      @user = create(:user)
      @segment = create(:segment)
    end

    subject { PrepProcessMachine.new(segment: @segment, user: @user) }
    it "creates a PrepProcess when it doesn't exist" do
      expect { subject.find_or_create }.to change { PrepProcess.count }.by(1)
    end

    it "doesnt' create a PrepProcess when it exists" do
      create(:prep_process, segment_processor: @user, processed_segment: @segment)
      expect { subject.find_or_create }.not_to change { PrepProcess.count }
    end

    it "returns a PrepProcess" do
      expect(subject.find_or_create).to be_a(PrepProcess)
    end

    it "creates a PrepProcess when the user has one for another segment" do
      create(:prep_process, segment_processor: @user, processed_segment: create(:segment))
      expect { subject.find_or_create }.to change { PrepProcess.count }.by(1)
    end

    context "#prep_step_ones" do
      it "creates a prep_step_one" do
        expect { subject.find_or_create }.to change { Prep::StepOne.count }.by(1)
      end

      it "doesn't create a step_one if it already exists" do
        subject.find_or_create
        expect { subject.find_or_create }.not_to change { Prep::StepOne.count }
      end
    end
  end

  context "#create" do
    before(:each) do
      @user = create(:user)
      @segment = create(:segment)
    end

    subject { PrepProcessMachine.new(segment: @segment, user: @user) }

    it "creates a PrepProcess" do
      expect { subject.create }.to change { PrepProcess.count }.by(1)
    end
  end
end
