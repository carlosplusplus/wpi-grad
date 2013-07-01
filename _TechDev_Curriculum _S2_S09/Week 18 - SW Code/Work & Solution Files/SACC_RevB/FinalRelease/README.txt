SACC Usage:

SACC.exe [--noheart] <threat-list-filename>
  where:
  --noheart specifies not to start the heartbeat thread. This
    will ignore the heartbeat messages from the MC and not
    send any responses.
  <threat-list-filename> is the name of the file that
    contains the list of threat types in either CSV, binary,
    or XML format. The file extension must be .csv, .bin, or
    .xml accordingly, or the file will not be recognized.

The output from the SACC program is mostly for initialization
and error conditions. Messages are not output for normal system
operations like adding tracks, or allocating the CM.

==========

SACC_Debug.exe [--noheart] <threat-list-filename>
  where:
  <threat-list-filename> is the name of the file that
    contains the list of threat types in either CSV, binary,
    or XML format. The file extension must be .csv, .bin, or
    .xml accordingly, or the file will not be recognized.
  
The output from the SACC_Debug program will display every single
time the SACC receives INU data or sensor data. This will prove
that our program is interpreting information correctly.

