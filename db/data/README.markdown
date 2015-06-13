DATA DUMPS
==========


Generate Dump File
------------------

On the server, run:

    pg_dump -d ruboto -U ruboto -W -t TABLENAME -a > TABLENAME.dump



Load Dump File
--------------

run:

  psql -d DATABASE -U USERNAME -W -f TABLENAME.dump
