# PgReplicationMonitor

A simple gem that connects to a PG master and checks the replication state of
its secondaries.  If a secondary is found to be significantly behind, it will
fire off a CloudWatch alert.

Though narrowly defined now, it'll be possible in the future (perhaps through
your contribution? ^^) to define both custom rules for what's considered dangerously
out of sync and to report to other systems.

### Usage

PgReplicationMonitor will come with a CLI, which can be cronjob'd to run as
frequently as desired.  As the CLI is built out, more details will be added
here.

## Thanks

To 6Wunderkinder, for all their support for this open-source project, and their
general awesomeness.

## Issues? Questions? Ideas?

Open a ticket or send a pull request!
