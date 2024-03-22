//%attributes = {"invisible":true}
//If (False)
//Temp_FixActLog 
//  `Fix act log from errors where BIN is not recorded in a NRC record.
//End if 
//
//  `First see if we did this already
//C_LONGINT($vlActLogFixes)
//SET QUERY DESTINATION(Into variable ;$vlActLogFixes)
//QUERY([Activity Log];[Activity Log]Activity Type="FIX")
//If ($vlActLogFixes=0)
//  `didn't check yet  
//  `look for records with no Parent ID
//C_LONGINT($vlNoParentID)
//SET QUERY DESTINATION(Into set ;"TempNoParentID")
//QUERY([Activity Log];[Activity Log]Activity Type="NRC";*)
//QUERY([Activity Log]; & ;[Activity Log]FileID Local=27;*)
//QUERY([Activity Log]; & ;[Activity Log]Parent ID="")
//$vlNoParentID:=Records in set("TempNoParentID")
//SET QUERY DESTINATION(Into current selection )
//If ($vlNoParentID>0)
//  `found some blank ones    
//USE SET("TempNoParentID")
//ARRAY STRING(20;$aInspIDs;0)
//SELECTION TO ARRAY([Activity Log]Local ID;$aInspIDs)
//QUERY WITH ARRAY([Activity Log]Local ID;$aInspIDs)
//QUERY SELECTION([Activity Log];[Activity Log]Activity Type#"NRC")
//ARRAY STRING(20;$aInspIDList;0)
//ARRAY STRING(20;$aBinsList;0)
//SELECTION TO ARRAY([Activity Log]Local ID;$aInspIDList;[Activity Log]Parent ID;$aBinsList)
//USE SET("TempNoParentID")
//FIRST RECORD([Activity Log])
//C_LONGINT($k;$i;$vlNotFound)
//C_STRING(20;$vsInspID;$vsBINID)
//$vlNotFound:=0
//For ($i;1;$vlNoParentID)
//$vsInspID:=[Activity Log]Local ID
//$k:=Find in array($aInspIDList;$vsInspID)
//If ($k>0)
//$vsBINID:=$aBinsList{$k}
//If (Replace string($vsBINID;" ";"")#"")
//[Activity Log]Parent ID:=$vsBINID
//Else 
//$vlNotFound:=$vlNotFound+1
//End if 
//
//Else 
//$vlNotFound:=$vlNotFound+1
//End if 
//SAVE RECORD([Activity Log])
//NEXT RECORD([Activity Log])
//End for 
//FLUSH BUFFERS
//If ($vlNotFound>0)
//ALERT("Could not fix some Inspections.")
//End if 
//End if 
//
//CLEAR SET("TempNoParentID")
//  `mark the activity log as checked. 
//CREATE RECORD([Activity Log])
//Inc_Sequence ("Activity Log";->[Activity Log]RefID)  `Get the next sequence
//[Activity Log]Activity Type:="FIX"
//[Activity Log]Status:=1  `so it doesn't show in unsent
//SAVE RECORD([Activity Log])
//FLUSH BUFFERS
//
//End if 
//  `end
//SET QUERY DESTINATION(Into current selection )