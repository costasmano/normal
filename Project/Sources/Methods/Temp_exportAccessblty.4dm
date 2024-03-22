//%attributes = {"invisible":true}
//If (False)
//  `Temp_exportAccesblty
//  `Create an export of the Accessibility Fields from the Bridge MHD NBIS table
//  `to prepare for conversion from Boolean to Alpha 2 fields.
//
//  `ALL RECORDS([Bridge MHD NBIS])
//C_LONGINT($vrecs)
//$vrecs:=Records in selection([Bridge MHD NBIS])
//ALERT("This routine will not work with the current structure any more!")
//If (False)
//CONFIRM("Export accessibility values for "+String($vrecs)+" records?")
//If (Ok=1)
//ARRAY STRING(3;$aBINs;0)
//ARRAY BOOLEAN($aLiftBucket;0)
//ARRAY BOOLEAN($aLadder;0)
//ARRAY BOOLEAN($aBoat;0)
//ARRAY BOOLEAN($aWader;0)
//ARRAY BOOLEAN($aInsp50;0)
//ARRAY BOOLEAN($aRigging;0)
//ARRAY BOOLEAN($aStaging;0)
//ARRAY BOOLEAN($aTraffic;0)
//ARRAY BOOLEAN($aRRFlagman;0)
//ARRAY BOOLEAN($aPolice;0)
//ARRAY BOOLEAN($aOther;0)
//
//  `These were commented out for compilation.......
//  `SELECTION TO ARRAY([Bridge MHD NBIS]BIN;$aBINs)
//  ` SELECTION TO ARRAY([Bridge MHD NBIS]LiftBucket;$aLiftBucket)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]Ladder;$aLadder)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]Boat;$aBoat)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]Wader;$aWader)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]Inspector50;$aInsp50)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]Rigging;$aRigging)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]Staging;$aStaging)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]Traffic Control;$aTraffic)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]RR Flagman;$aRRFlagman)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]Police;$aPolice)
//  `SELECTION TO ARRAY([Bridge MHD NBIS]OtherAccBool;$aOther)
//  `open a file of choise
//SET CHANNEL(12;"")
//If (OK=1)
//C_STRING(20;$vfiletype)
//$vfiletype:="ACCESSIBILITYEXP"
//SEND VARIABLE($vfiletype)  ` to mark the file as what it is 
//C_BLOB($vtempblob)
//VARIABLE TO BLOB($aBINs;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aLiftBucket;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aLadder;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aBoat;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aWader;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aInsp50;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aRigging;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aStaging;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aTraffic;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aRRFlagman;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aPolice;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aOther;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//SET CHANNEL(11)  `close export file
//ALERT("Export complete")
//Else 
//ALERT("No export file selected")
//End if 
//
//End if 
//End if 
//End if 
