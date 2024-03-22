//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_MetricConv
	//ACI University Programming Classes
	//Created by: Jim Steinman
	//Date: 10/5/95
	
	//Purpose: This procedure creates or brings to front the Customers Process
	
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 
C_LONGINT:C283($LMetrConvID)
$LMetrConvID:=LSpawnProcess("P_MetricConv"; 0; "$Metric_Conversion"; True:C214; False:C215)
//◊LFilePalPID:=LSpawnProcess ("P_MetricConv";32000;"$Metric_Conversion";True;Fals

//End of procedure 