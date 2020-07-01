#!/bin/bash

#This is a program to create DROID metadata for CDs.

BLUE='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}This script will create DROID metadata for a CD.${NC}"
echo -e "${BLUE}Please drag the CD icon over this window. See the CD path displayed? Hit return!:${NC}"

read CD

echo -e "${BLUE}Please enter the MediaID for this CD and hit return:${NC}"

read MediaID
#remove - and disk# to create collection#
Collection=${MediaID%-*}
#echo -e $Collection
CD= $CD | sed -e "s/'//g"
#hide java errrors
#exec 3>&2
#exec 2> /dev/null
/home/bcadmin/droid-binary-6.2.1-bin/droid.sh -R -a "$CD" -p "/media/sf_Staging/MISC/$MediaID.droid"
/home/bcadmin/droid-binary-6.2.1-bin/droid.sh -p "/media/sf_Staging/MISC/$MediaID.droid" -n "File count and sizes" -t "DROID Report XML" -r "/media/sf_Staging/ingest/fileTransfers/$Collection/$MediaID/metadata/$MediaID.xml"
/home/bcadmin/droid-binary-6.2.1-bin/droid.sh -p "/media/sf_Staging/MISC/$MediaID.droid" -e "/media/sf_Staging/ingest/fileTransfers/$Collection/$MediaID/metadata/$MediaID.csv"
#end hide
#exec 2>&3
if [ -n "$(find /media/sf_Staging/ingest/fileTransfers/$Collection/$MediaID/metadata/ -maxdepth 1 -name "*.xml")" ]
then
	echo -e "${BLUE}DROID XML has been created in metadata directory.${NC}"
else
	echo -e "${BLUE}DROID XML ERROR.${NC}"
fi
if [ -n "$(find /media/sf_Staging/ingest/fileTransfers/$Collection/$MediaID/metadata/ -maxdepth 1 -name "*.csv")" ]
then
	echo -e "${BLUE}DROID CSV has been created in metadata directory.${NC}"
else
	echo -e "${BLUE}DROID CSV ERROR.${NC}"
fi


