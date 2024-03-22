//%attributes = {"invisible":true}
//  `Temp_exportsigns
//  `Create an export of the Signs Fields from the Inspections table
//  `to prepare for conversion from Boolean to Alpha 2 fields.
//
//  `ALL RECORDS([Bridge MHD NBIS])
//C_LONGINT($vrecs)
//$vrecs:=Records in selection([Inspections])
//  `ALERT("This routine will not work with the current structure any more!")
//  `If (False)
//CONFIRM("Export accessibility values for "+String($vrecs)+" records?")
//If (Ok=1)
//ARRAY LONGINT($aInspIDs;0)
//ARRAY BOOLEAN($aBPSNE;0)
//ARRAY BOOLEAN($aBPSSW;0)
//ARRAY BOOLEAN($aAPSNE;0)
//ARRAY BOOLEAN($aAPSSW;0)
//ARRAY BOOLEAN($aBCLNE;0)
//ARRAY BOOLEAN($aBCLSW;0)
//ARRAY BOOLEAN($aACLNE;0)
//ARRAY BOOLEAN($aACLSW;0)
//
//  `These were commented out for compilation... for new release....
//  `SELECTION TO ARRAY([Inspections]InspID;$aInspIDs)
//  `SELECTION TO ARRAY([Inspections]BrPostSignsNE;$aBPSNE)
//  `SELECTION TO ARRAY([Inspections]BrPostSignsSW;$aBPSSW)
//  `SELECTION TO ARRAY([Inspections]AdPostSignNE;$aAPSNE)
//  `SELECTION TO ARRAY([Inspections]AdPostSignSW;$aAPSSW)
//  `SELECTION TO ARRAY([Inspections]BrClrSignsNE;$aBCLNE)
//  `SELECTION TO ARRAY([Inspections]BrClrSignsSW;$aBCLSW)
//  `SELECTION TO ARRAY([Inspections]AdClrSignNE;$aACLNE)
//  `SELECTION TO ARRAY([Inspections]AdClrSignSW;$aACLSW)
//  `open a file of choise
//SET CHANNEL(12;"")
//If (OK=1)
//C_STRING(20;$vfiletype)
//$vfiletype:="SIGNAGEEXP"
//SEND VARIABLE($vfiletype)  ` to mark the file as what it is 
//C_BLOB($vtempblob)
//VARIABLE TO BLOB($aInspIDs;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aBPSNE;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aBPSSW;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aAPSNE;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aAPSSW;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aBCLNE;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aBCLSW;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aACLNE;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//VARIABLE TO BLOB($aACLSW;$vtempblob)
//SEND VARIABLE($vtempblob)
//SET BLOB SIZE($vtempblob;0)  `reset the blob
//SET CHANNEL(11)  `close export file
//ALERT("Export complete")
//Else 
//ALERT("No export file selected")
//End if 
//
//End if 
//  `End if 