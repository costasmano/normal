//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/23/10, 10:57:30
	// ----------------------------------------------------
	// Method: QR_Decade
	// Description
	// Return the Decade as a String of the year passed as parameter 1.
	// Optional params 2,3 min and max decades.
	// QR_Decade(1949) = "1940"
	// QR_Decade(1890) = "1890"
	// QR_Decade(1890;1900) = "Pre-1900"
	// QR_Decade(2021;1900;2020) = "2020"
	// QR_Decade(2031;1900;2020) = "Post-2020"
	
	// 
	// Parameters
	// $0 : $Decade_txt
	// $1 : $Year_L - must be > 0
	// $2 : $MinDecade_L (Optional)
	// $3 : $MaxDecade_L (Optional)
	// ----------------------------------------------------
	
	Mods_2010_03
End if 
C_TEXT:C284($0; $Decade_txt)
$Decade_txt:=""
C_LONGINT:C283($1; $Year_L; $Decade_L; $MinDecade_L; $MaxDecade_L)
$Year_L:=$1
$MinDecade_L:=-9990
$MaxDecade_L:=-9990
If (Count parameters:C259>1)
	C_LONGINT:C283($2)
	$MinDecade_L:=$2
	$MinDecade_L:=($MinDecade_L\10)*10
	If ($MinDecade_L<0)
		$MinDecade_L:=-9990
	End if 
	
End if 
If (Count parameters:C259>2)
	C_LONGINT:C283($3)
	
	$MaxDecade_L:=$3
	$MaxDecade_L:=($MaxDecade_L\10)*10
	If ($MaxDecade_L<0)
		$MaxDecade_L:=-9990
	End if 
	
End if 
If (($MinDecade_L>0) & ($MaxDecade_L>0))
	If ($MinDecade_L>=$MaxDecade_L)
		//something not right - ignore both
		$MinDecade_L:=-9990
		$MaxDecade_L:=-9990
	End if 
	
End if 

If ($Year_L>0)
	$Decade_txt:=""
	$Decade_L:=($Year_L\10)*10
	Case of 
		: (($MinDecade_L>0) & ($Decade_L<$MinDecade_L))
			$Decade_txt:="Pre-"+String:C10($MinDecade_L)
		: (($MaxDecade_L>0) & ($Decade_L>$MaxDecade_L))
			$Decade_txt:="Post-"+String:C10($MaxDecade_L)
		Else 
			$Decade_txt:=String:C10($Decade_L)
	End case 
	
	If (False:C215)
		If ($MinDecade_L>0)
			If ($Decade_L<$MinDecade_L)
				$Decade_txt:="Pre-"
			End if 
		End if 
		If ($MaxDecade_L>0)
			If ($Decade_L>$MaxDecade_L)
				$Decade_txt:="Post-"
			End if 
			
		End if 
		
		$Decade_txt:=$Decade_txt+String:C10($Decade_L)
		
	End if 
End if 

$0:=$Decade_txt