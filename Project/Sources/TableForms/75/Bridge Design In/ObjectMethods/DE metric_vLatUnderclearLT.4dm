If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/30/2007 08:49:47)
	Mods_2007_CM08
End if 

C_TEXT:C284($CR)  // Command Replaced was o_C_STRING length was 1
$CR:=Char:C90(13)

If ([Bridge Design:75]MetricUnit:38=True:C214)
	
	If ((metric_vLatUnderclearLT=99.9) | (metric_vLatUnderclearLT=99.8) | (metric_vLatUnderclearLT<=0))
		ALERT:C41("Please put in a value less than 99.8 and"+$CR+"greater than 00.0 for a valid left lateral underclearance!")
	Else 
		uItem56a:=0
		uItem56b:=0
		uItem56c:=0
		uItem56d:=1
	End if 
	[Bridge Design:75]MinLatUnderclearLT:47:=Round:C94(metric_vLatUnderclearLT*3.280839850131; 5)
	PushChange(1; ->[Bridge Design:75]MinLatUnderclearLT:47)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item54B:108:=Round:C94(metric_vLatUnderclearLT; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item54B:108)
	End if 
End if 