# VLO import benchmark

Ready-to-use benchmarking distribution on basis of the VLO importer and a SOLR
instance running inside Tomcat. 

The dataset can be obtained from 
[this b2drop share](https://b2drop.eudat.eu/public.php?service=files&t=a3e18f04e900fab527e4af3727524f55).

## Setup and running: step by step

- Make a directory `/var/vlo`

- Copy or link the 'data' directory with VLO benchmark data to that directory so
that we have
  * `/var/vlo/data/clarin-others`
  * `/var/vlo/data/hathi`
  * `/var/vlo/data/KB`
  * `/var/vlo/data/test`

- Make a directory `/var/vlo/solrdata` and make sure it is writable to the user
that will be running the tomcat server; this directory will be populated by
the SOLR index data, make sure there is enough disk space (at least several
gigabytes)
	
- Start the Tomcat instance with SOLR inside using `start-solr.sh`
  * The Tomcat will run on __port 9080__ - make sure it is available before starting
  (it will also occupy ports 9005, 9009 and 9443)
  * Check that it's running at <http://localhost:9080/vlo-solr-3.1>
  * The Tomcat can be stopped again by running `stop-solr.sh`

- Start the import by running `time-import.sh`
  * The import will fail with an exception if the SOLR Tomcat is not running or
  cannot be found at the expected location (see above)
  * This will create a file `import-time.out.${timestamp}` with timing
  information
  * Detailed importer output is available at `vlo/log/vlo-importer.log`
  * The import can take a long time so you may want to run it detached from
  any terminal session
  * A __quick test import__ can be carried out by running
 		`time-import.sh vlo/config/VloConfig-test.xml`

## Scheduled setup ##

In a scheduled setup, the following should happen periodically (assuming that 
the SOLR Tomcat is running already):
- Download a fresh copy of the data set
- Unpack the data set into the import location (`/var/vlo/data`)
- Run the import via `time-import.sh`

## Notes

### Custom configuration

- The _import locations_ (defaults are in `/var/vlo/data`) are configured in
`vlo/config/VloConfig.xml`
- The _SOLR data directory_ location (default is `/var/vlo/solrdata`) 
is configured in `vlo/config/solr/collection1/conf/solrconfig.xml`
- If you wish to change the _Tomcat port(s)_, change the following:
 * The actual port configurations in `tomcat/conf/server.xml`
 * The SOLR ULR for the importer to connect to in `vlo/config/VloConfig.xml`

### Execution 
 
- Do NOT try to start the tomcat from any other location using the Tomcat 
startup script, as the location of the SOLR configuration is defined with a 
relative path (in `tomcat/webapps/vlo-solr-3.1/META-INF/context.xml`)
