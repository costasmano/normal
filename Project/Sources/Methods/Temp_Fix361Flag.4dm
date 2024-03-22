//%attributes = {"invisible":true}
//  `Temp_Fix361Flag
//If (User in group(Current user;"Design Access Group"))
//C_LONGINT($i;$j;$k;$vlNumBINs;$vlNumPontis;$vlScourFlags)
//C_TEXT($msg)
//C_TIME($LogFile)
//
//$vlNumBINs:=Records in selection([Bridge MHD NBIS])
//If ($vlNumBINs>0)
//$LogFile:=Create document("")  `prompt for it...
//◊ProgressPID:=StartProgress ("361Fix";"None";"Fixing 361 Flags")
//$msg:="BDEPT"+◊sTAB+"BIN"+◊sTAB+"Brg Cat"+◊sTAB+"Brg Own"+◊sTAB+"It 113"+◊sTAB+"Sta 1"+◊sTAB+"Sta 2"+◊sTAB+"Sta 3"+◊sTAB
//$msg:=$msg+"InspFound"+◊sTAB+"I Date"+◊sTAB+"Match"+◊sTAB+"O Sta 1"+◊sTAB+"O Sta 2"+◊sTAB+"O Sta 3"
//$msg:=$msg+◊sCR
//SEND PACKET($LogFile;$msg)
//C_BOOLEAN($vbSaveMods;$vbSaveAdds)
//CONFIRM("Don't save Changes?";"Don't Save";"Save")
//$vbSaveMods:=(OK#1)
//CONFIRM("Don't save Additions?";"Don't Save";"Save")
//$vbSaveAdds:=(OK#1)
//FIRST RECORD([Bridge MHD NBIS])
//For ($i;1;$vlNumBINs)
//$msg:=[Bridge MHD NBIS]BDEPT+◊sTAB+[Bridge MHD NBIS]BIN+◊sTAB+[Bridge MHD NBIS]Item8 BridgeCat+◊sTAB+[Bridge MHD NBIS]Item8 Owner+◊sTAB+[Bridge MHD NBIS]Item113+◊sTAB
//C_REAL($vrState1;$vrState2;$vrState3)
//$vrState1:=0
//$vrState2:=0
//$vrState3:=0
//Case of 
//: (Position([Bridge MHD NBIS]Item113;"0;1;2;3;4")>0)
//$vrState3:=1
//: ([Bridge MHD NBIS]Item113="5")
//$vrState2:=1
//: (Position([Bridge MHD NBIS]Item113;"7;8;9")>0)
//$vrState1:=1
//End case 
//$msg:=$msg+String($vrState1)+◊sTAB+String($vrState2)+◊sTAB+String($vrState3)+◊sTAB
//RELATE MANY([Bridge MHD NBIS])
//QUERY SELECTION([BMS Inspections];[BMS Inspections]Insp Date>!12/31/97!)  `only inspections 98 and on
//$vlNumPontis:=Records in selection([BMS Inspections])
//If ($vlNumPontis>0)
//ORDER BY([BMS Inspections];[BMS Inspections]Insp Date;<)
//FIRST RECORD([BMS Inspections])
//$msg:=$msg+"I Date :"+◊sTAB+String([BMS Inspections]Insp Date)+◊sTAB
//RELATE MANY([BMS Inspections])
//QUERY SELECTION([Cond Units];[Cond Units]Element ID=24361)  `look for flags
//$vlScourFlags:=Records in selection([Cond Units])
//If ($vlScourFlags=1)
//  `fix the current flag
//FIRST RECORD([Cond Units])
//If (([Cond Units]CondState1=$vrState1) & ([Cond Units]CondState2=$vrState2) & ([Cond Units]CondState3=$vrState3))
//$msg:=$msg+"Match!"
//Else 
//$msg:=$msg+"From "+◊sTAB+String([Cond Units]CondState1)+◊sTAB+String([Cond Units]CondState2)+◊sTAB+String([Cond Units]CondState3)
//[Cond Units]CondState1:=$vrState1
//[Cond Units]CondState2:=$vrState2
//[Cond Units]CondState3:=$vrState3
//[Cond Units]Comment:="Fixed to match Item 113 "+String(Current date(*))
//End if   `if matching state       
//If ($vbSaveMods)
//SAVE RECORD([Cond Units])
//End if 
//Else 
//$msg:=$msg+String($vlScourFlags)+" Flags for this record"
//If ($vlScourFlags=0)
//RELATE MANY([BMS Inspections])
//ARRAY INTEGER($aEnvs;0)
//C_INTEGER($nEnv;$iEnv)
//SELECTION TO ARRAY([Cond Units]Environment;$aEnvs)
//$nEnv:=Size of array($aEnvs)
//$iEnv:=1  `initialize enviroment to 1
//If ($nEnv>0)
//SORT ARRAY($aEnvs)
//$iEnv:=$aEnvs{$nEnv}  `pick the worst enviroment
//End if 
//CREATE RECORD([Cond Units])
//[Cond Units]Inspection ID:=[BMS Inspections]Inspection ID
//[Cond Units]Element ID:=24361
//[Cond Units]CondState1:=$vrState1
//[Cond Units]CondState2:=$vrState2
//[Cond Units]CondState3:=$vrState3
//[Cond Units]CondState4:=-1
//[Cond Units]CondState5:=-1
//[Cond Units]Metric:=[BMS Inspections]Metric
//[Cond Units]Environment:=$iEnv
//[Cond Units]Total Quantity:=1
//[Cond Units]Comment:="Added to match Item 113"+String(Current date(*))
//$msg:=$msg+"Added "+◊sTAB+String([Cond Units]CondState1)+◊sTAB+String([Cond Units]CondState2)+◊sTAB+String([Cond Units]CondState3)
//If ($vbSaveAdds)
//Inc_Sequence ("Cond Unit ID";->[Cond Units]Cond Unit ID)
//SAVE RECORD([Cond Units])
//End if 
//
//End if 
//End if   ` if found one flag only          
//
//Else 
//$msg:=$msg+"No Pontis Insp found for this record"
//End if   `if we have pontis inspections
//$msg:=$msg+◊sCR
//SEND PACKET($LogFile;$msg)
//UpdateProgress ($i;$vlNumBINs)
//
//NEXT RECORD([Bridge MHD NBIS])
//End for   `Loop of BINs           
//CALL PROCESS(◊ProgressPID)
//CLOSE DOCUMENT($LogFile)
//
//End if   `if we have a number of BINs
//
//End if   `if authorized user