require 'spec_helper'

describe PgReplicationMonitor do
  # A class that mocks a PG::Connection
  class FakeConnection < Struct.new(:db_info)
    def exec
      []
    end
  end

  before :each do
    # Mock the PG::Connection
    PG::Connection.stub(:open) {|info| FakeConnection.new(info)}
  end
  let(:db_info) { {dbname: "pizzas"} }
  let(:cloudwatch_info) { {} }
  let(:monitor) { PgReplicationMonitor.new(db_info, cloudwatch_info) }
  # the definition of replica_state is at the bottom since it's long

  describe "#new" do
    it "sets up the PG connection" do
      expect(monitor.connection).to be_a(FakeConnection)
      expect(monitor.connection.db_info).to eq(db_info)
    end
  end

  describe "#check_replication" do
    before :each do
    end

    it "runs a report using the secondary states" do
      # coming soon!
    end
  end

  let(:replica_state) do
    [
      {
        "procpid" => "22089",
        "usesysid" => "16384",
        "usename" => "database_user",
        "application_name" => "walreceiver",
        "client_addr" => Faker::Internet.ip,
        "client_hostname" => "",
        "client_port" => "52985",
        "backend_start" => "2012-12-11 19:32:22.615125+00",
        "state" => "streaming",
        "sent_location" => "F6/9A143358",
        "write_location" => "F6/9A143358",
        "flush_location" => "F6/9A143358",
        "replay_location" => "F6/9A143358",
        "sync_priority" => "0",
        "sync_state" => "async"
      },
      {
        "procpid" => "22090",
        "usesysid" => "16384",
        "usename" => "database_user",
        "application_name" => "walreceiver",
        "client_addr" => Faker::Internet.ip,
        "client_hostname" => "",
        "client_port" => "39231",
        "backend_start" => "2012-12-11 19:32:22.618439+00",
        "state" => "streaming",
        "sent_location" => "F6/9A143358",
        "write_location" => "F6/9A143358",
        "flush_location" => "F6/9A143358",
        "replay_location" => "F6/9A143358",
        "sync_priority" => "0",
        "sync_state" => "async"
      },
      {
        "procpid" => "23774",
        "usesysid" => "16384",
        "usename" => "database_user",
        "application_name" => "walreceiver",
        "client_addr" => Faker::Internet.ip,
        "client_hostname" => "",
        "client_port" => "41817",
        "backend_start" => "2012-12-11 21:28:13.510776+00",
        "state" => "streaming",
        "sent_location" => "F6/9A143358",
        "write_location" => "F6/9A143358",
        "flush_location" => "F6/9A143358",
        "replay_location" => "F6/9A143358",
        "sync_priority" => "0",
        "sync_state" => "async"
      },
      {
        "procpid" => "24706",
        "usesysid" => "16384",
        "usename" => "database_user",
        "application_name" => "walreceiver",
        "client_addr" => Faker::Internet.ip,
        "client_hostname" => "",
        "client_port" => "43593",
        "backend_start" => "2012-12-11 22:48:35.583494+00",
        "state" => "streaming",
        "sent_location" => "F6/9A143358",
        "write_location" => "F6/9A143358",
        "flush_location" => "F6/9A143358",
        "replay_location" => "F6/9A143358",
        "sync_priority" => "0",
        "sync_state" => "async"
      },
      {
        "procpid" => "24716",
        "usesysid" => "16384",
        "usename" => "database_user",
        "application_name" => "walreceiver",
        "client_addr" => Faker::Internet.ip,
        "client_hostname" => "",
        "client_port" => "49354",
        "backend_start" => "2012-12-11 22:50:01.18205+00",
        "state" => "streaming",
        "sent_location" => "F6/9A143358",
        "write_location" => "F6/9A143358",
        "flush_location" => "F6/9A143358",
        "replay_location" => "F6/9A143358",
        "sync_priority" => "0",
        "sync_state" => "async"
      }
    ]
  end
end
