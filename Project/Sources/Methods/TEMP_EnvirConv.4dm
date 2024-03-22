//%attributes = {"invisible":true}
//If (False)
//  `GP TEMP_EnvirConv
//
//  `This procedure was used once and should not be used again.
//  `It converts the environments in inspections prior to October 1995,
//  `when the default environment changed from 3 to 2.
//
//C_TEXT($text;$file)
//C_INTEGER($NoCUs;$i;$j)
//C_REAL($AVG;$Sum)
//
//TRACE
//C_TIME($dConvertRpt)
//$file:="Tom's 8500 HD:BMS:Data:Environment Conv. Oct95 Report"
//$dConvertRpt:=Create document($file)
//$text:="Environment Conversion - October 1995 - Report"+(2*◊sCR)
//$text:=$text+"Inspection ID"+◊sTab+"BIN"+◊sTab+"Date"+◊sTab+"No. CU's"+◊sTab+"Avg. Env."
//$text:=$text+◊sTab+"Action"+(2*◊sCR)
//SEND PACKET($dConvertRpt;$text)
//
//QUERY([BMS Inspections];[BMS Inspections]Insp Date<=!12/31/95!)
//ORDER BY([BMS Inspections];[BMS Inspections]Inspection ID)
//
//For ($i;1;Records in selection([BMS Inspections]))
//
//RELATE MANY([BMS Inspections]Inspection ID)
//$NoCUs:=Records in selection([Cond Units])
//$Sum:=0
//For ($j;1;$NoCUs)
//$Sum:=$Sum+[Cond Units]Environment
//NEXT RECORD([Cond Units])
//End for 
//
//$AVG:=$Sum/$NoCUs
//$text:=String([BMS Inspections]Inspection ID)+◊sTab+[BMS Inspections]BIN+◊sTab
//$text:=$text+String([BMS Inspections]Insp Date)+◊sTab+String($NoCUs)+◊sTab+String($AVG;"0.0000")+◊sTab
//Case of 
//: ($AVG>=3)
//$text:=$text+"Decremented Environment"
//FIRST RECORD([Cond Units])
//For ($j;1;$NoCUs)
//[Cond Units]Environment:=[Cond Units]Environment-1
//SAVE RECORD([Cond Units])
//NEXT RECORD([Cond Units])
//End for 
//: ($AVG<2.5)
//$text:=$text+"ok"
//Else 
//$text:=$text+"***** Boarder Line!  Check it manually. *****"
//End case 
//$text:=$text+◊sCR
//SEND PACKET($dConvertRpt;$text)
//
//
//NEXT RECORD([BMS Inspections])
//End for 
//
//CLOSE DOCUMENT($dConvertRpt)
//End if 
