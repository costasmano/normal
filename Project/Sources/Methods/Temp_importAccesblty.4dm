//%attributes = {"invisible":true}
//  `Import and re-interpret Accesibility Item codings
//  `for table [Bridge MHD NBIS]. This must be done once,
//  `after conversion of the Accessibility items from Boolean to
//  `Char(2) fields.
//
//SET CHANNEL(10;"")
//If (Ok=1)
//C_STRING(40;$vfiletype)
//RECEIVE VARIABLE($vfiletype)
//If ($vfiletype#"ACCESSIBILITYEXP")
//ALERT("This is not an Accessibility Export file")
//Else 
//ARRAY STRING(3;$aBINs1;0)
//ARRAY BOOLEAN($abLiftBucket;0)
//ARRAY BOOLEAN($abLadder;0)
//ARRAY BOOLEAN($abBoat;0)
//ARRAY BOOLEAN($abWader;0)
//ARRAY BOOLEAN($abInsp50;0)
//ARRAY BOOLEAN($abRigging;0)
//ARRAY BOOLEAN($abStaging;0)
//ARRAY BOOLEAN($abTraffic;0)
//ARRAY BOOLEAN($abRRFlagman;0)
//ARRAY BOOLEAN($abPolice;0)
//ARRAY BOOLEAN($abOther;0)
//ARRAY STRING(3;$aBINs2;0)
//C_BLOB($vTempBlob)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$aBINs1)
//  `ALERT("Data type $aBINs is :"+fGetDataType (Type($aBINs1))+
//  `" Size of array is :"+String(Size of array($aBINs1)))
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abLiftBucket)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abLadder)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abBoat)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abWader)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abInsp50)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abRigging)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abStaging)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abTraffic)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abRRFlagman)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abPolice)
//RECEIVE VARIABLE($vTempBlob)
//BLOB TO VARIABLE($vTempBlob;$abOther)
//SET CHANNEL(11)  `close the export file
//SET BLOB SIZE($vTempBlob;0)
//C_LONGINT($i;$numrecs;$k;$nummatches)
//$numrecs:=Size of array($aBINs1)
//QUERY WITH ARRAY([Bridge MHD NBIS]BIN;$aBINs1)
//$nummatches:=Records in selection([Bridge MHD NBIS])
//ALERT("found "+String($nummatches)+" records in [Bridge MHD NBIS] !!!!!")
//SELECTION TO ARRAY([Bridge MHD NBIS]BIN;$aBINs2)
//ARRAY STRING(2;$asLiftBucket;$nummatches)
//ARRAY STRING(2;$asLadder;$nummatches)
//ARRAY STRING(2;$asBoat;$nummatches)
//ARRAY STRING(2;$asWader;$nummatches)
//ARRAY STRING(2;$asInsp50;$nummatches)
//ARRAY STRING(2;$asRigging;$nummatches)
//ARRAY STRING(2;$asStaging;$nummatches)
//ARRAY STRING(2;$asTraffic;$nummatches)
//ARRAY STRING(2;$asRRFlagman;$nummatches)
//ARRAY STRING(2;$asPolice;$nummatches)
//ARRAY STRING(2;$asOther;$nummatches)
//For ($i;1;$nummatches)
//$k:=Find in array($aBINs1;$aBINs2{$i})
//If ($k>0)
//$asLiftBucket{$i}:=f_Boolean2String ($abLiftBucket{$k};"YN")+f_Boolean2String ($abLiftBucket{$k};"YN")
//$asLadder{$i}:=f_Boolean2String ($abLadder{$k};"YN")+f_Boolean2String ($abLadder{$k};"YN")
//$asBoat{$i}:=f_Boolean2String ($abBoat{$k};"YN")+f_Boolean2String ($abBoat{$k};"YN")
//$asWader{$i}:=f_Boolean2String ($abWader{$k};"YN")+f_Boolean2String ($abWader{$k};"YN")
//$asInsp50{$i}:=f_Boolean2String ($abInsp50{$k};"YN")+f_Boolean2String ($abInsp50{$k};"YN")
//$asRigging{$i}:=f_Boolean2String ($abRigging{$k};"YN")+f_Boolean2String ($abRigging{$k};"YN")
//$asStaging{$i}:=f_Boolean2String ($abStaging{$k};"YN")+f_Boolean2String ($abStaging{$k};"YN")
//$asTraffic{$i}:=f_Boolean2String ($abTraffic{$k};"YN")+f_Boolean2String ($abTraffic{$k};"YN")
//$asRRFlagman{$i}:=f_Boolean2String ($abRRFlagman{$k};"YN")+f_Boolean2String ($abRRFlagman{$k};"YN")
//$asPolice{$i}:=f_Boolean2String ($abPolice{$k};"YN")+f_Boolean2String ($abPolice{$k};"YN")
//$asOther{$i}:=f_Boolean2String ($abOther{$k};"YN")+f_Boolean2String ($abOther{$k};"YN")
//End if 
//End for 
//ARRAY TO SELECTION($asLiftBucket;[Bridge MHD NBIS]LiftBucket)
//ARRAY TO SELECTION($asLadder;[Bridge MHD NBIS]Ladder)
//ARRAY TO SELECTION($asBoat;[Bridge MHD NBIS]Boat)
//ARRAY TO SELECTION($asWader;[Bridge MHD NBIS]Wader)
//ARRAY TO SELECTION($asInsp50;[Bridge MHD NBIS]Inspector50)
//ARRAY TO SELECTION($asRigging;[Bridge MHD NBIS]Rigging)
//ARRAY TO SELECTION($asStaging;[Bridge MHD NBIS]Staging)
//ARRAY TO SELECTION($asTraffic;[Bridge MHD NBIS]Traffic Control)
//ARRAY TO SELECTION($asRRFlagman;[Bridge MHD NBIS]RR Flagman)
//ARRAY TO SELECTION($asPolice;[Bridge MHD NBIS]Police)
//ARRAY TO SELECTION($asOther;[Bridge MHD NBIS]OtherAccBool)
//  `save
//FLUSH BUFFERS
//ALERT("Done importing from file : "+Document)
//End if 
//End if 