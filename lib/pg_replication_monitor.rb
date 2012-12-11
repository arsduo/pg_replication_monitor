require 'pg'

# Public: A tool for tracking Postgres replication status.  Check the
# replication progress of secondary nodes; if they've fallen significantly
# behind the primary, fire off a Cloudwatch alert.
class PgReplicationMonitor
  # Public: A result row for a pg_stat_replication table query, representing a
  # the state of a secondary server.
  class ReplicaResult
    # Public: Get all replica results.
    #
    # connection - a connection to a master Postgres database
    #
    # Returns an Array of ReplicaResults.
    def self.all(connection)
      connection.execute(REPLICATION_STATUS_QUERY).map {|r| self.new(r)}
    end

    # Public: Create a new result from a PG::Result.
    def initialize(result)
      @data = result
    end

    # Public: is this replication stream okay?  Defined as either
    #   1) it's new and is in backup, fetching all data from postgres (we don't
    #   monitor how long that goes, though that could be added)
    #   2) the master xlog location (the state of our DB) is sufficiently close
    #   to the current replay location on the secondary
    def okay?(current_xlog)
      @data["sent_location"] = "0/0" or
        @data["replay_location"][0...6] == current_xlog[0...6]
    end
  end

  # Public: Start a new replication check.
  #
  # db_info - access information for the database, suitable for the PG gem
  # (see http://deveiate.org/code/pg/PG/Connection.html#method-c-new).
  # cloudwatch_info - info for your cloudwatch account
  def initialize(db_info, cloudwatch_info)
    @connection = PG::Connection.open(db_info)
    @cloudwatch_info = cloudwatch_info
  end

  # Public: The database connection.
  attr_reader :connection

  # Internal: The query used to get replication status.
  REPLICATION_STATUS_QUERY = "select * from pg_stat_replication;"
  # Internal: The query used to see where the write-ahead log currently stands
  # on the master.
  MASTER_LOG_LOCATION_QUERY = "SELECT pg_current_xlog_location()"

  # Public: Check the replication state of the secondaries connected to this
  # server.
  def check_replication
    secondary_states = ReplicaResult.all(@connection)
    master_state = @connection.execute(MASTER_LOG_LOCATION_QUERY)

    report!(secondary_states, master_state)
  end

  # Public: Report the results.  Currently hard-wired for CloudWatch but in the
  # future will be more flexible.
  def report!(secondary_state, master_status)
  end
end

