require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "creates messages" do
    before do
      patient = User.create(first_name: 'Luke', last_name: 'Skywalker', inbox: Inbox.new, outbox: Outbox.new)
      doctor = User.create(first_name: 'Leia', last_name: 'Organa', is_doctor: true, is_patient: false, inbox: Inbox.new, outbox: Outbox.new)
      admin = User.create(first_name: 'Obi-wan', last_name: 'Kenobi', is_admin: true, is_patient: false, inbox: Inbox.new, outbox: Outbox.new)

      message = Message.create(body: 'Thanks for your order.',
               outbox: doctor.outbox,
               inbox: patient.inbox)
    end

    it "makes message unread once created" do
      expect(Message.first.read).to be_falsey
    end

    it "sends to correct inbox" do
      expect(Message.first.inbox.user).to eq User.patient.first
    end

    it "sends to correct outbox" do
      expect(Message.first.outbox.user).to eq User.doctor.first
      puts Inbox.all.inspect
    end
  end
end
