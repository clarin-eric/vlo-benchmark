# VLO import benchmark

Ready-to-use benchmarking distribution on basis of the VLO importer and a SOLR
instance running inside Tomcat. 

The dataset can be obtained from 
[this b2drop share](https://b2drop.eudat.eu/public.php?service=files&t=a3e18f04e900fab527e4af3727524f55).

## Setup and running: step by step

- Make a directory `/var/vlo`

- Copy or link the 'data' directory with VLO benchmark data to that directory so
that we have
  * /var/vlo/data/clarin-others
  * /var/vlo/data/hathi
  * /var/vlo/data/KB
  * /var/vlo/data/test

- Make a directory '/var/vlo/solrdata' and make sure it is writable to the user
that will be running the tomcat server; this directory will be populated by
the SOLR index data, make sure there is enough disk space (at least several
gigabytes)
	
- Start the Tomcat instance with SOLR inside using `start-solr.sh`
  * check that it's running at <http://localhost:8080/vlo-solr-3.1>

- Start the import by running `time-import.sh`
  * this will create a file import-time.out.${timestamp} with timing information
  * detailed importer output is available at vlo/log/vlo-importer.log
  * the import can take a long time so you may want to run it detached from
  any terminal session
  * a QUICK TEST IMPORT can be carried out by running
 		`time-import.sh vlo/config/VloConfig-test.xml`

## Note

- The import locations are configured in vlo/config/VloConfig.xml
- The SOLR data directory location is configured in
`vlo/config/solr/collection1/conf/solrconfig.xml`
- Do not try to start the tomcat from any other location, as the location of the 
SOLR configuration is defined with a relative path
