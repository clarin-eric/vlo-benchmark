#!/bin/sh
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
OUTFILE=${DIR}/log/import-time.out.`date "+%s"`
date > $OUTFILE
echo "${DIR}/vlo/bin/vlo_solr_importer.sh $@" >> $OUTFILE
(time ${DIR}/vlo/bin/vlo_solr_importer.sh $@) 2>> $OUTFILE
