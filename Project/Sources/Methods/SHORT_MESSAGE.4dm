//%attributes = {"invisible":true}
//GP SHORT_MESSAGE
//Displays a short message (<= 50 characters) in a centered window.

If (False:C215)
	//© October 1995, Thomas D. Nee, All Rights Reserved.
	
	//Modified 2-10-2000 : CM
	//    Adjusted GOTO XY x param from 5 pixels to 1 character
	
	Mods_2005_CM16
	
	// Modified by: Costas Manousakis-(Designer)-(7/20/20 12:24:54)
	Mods_2020_07_bug
	//  `Use window type 0 always so it does not block other messages. Fix for Call Reference #730
	MODS_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	//Set to not display if running on server
End if 
C_BOOLEAN:C305(INSP_CreatePDFsofApproved_B)
If (Application type:C494=4D Server:K5:6)
Else 
	If (Not:C34(INSP_CreatePDFsofApproved_B))
		C_TEXT:C284($Message)
		C_LONGINT:C283($Len; $hMarg; $vMarg; $Width; $Height)
		C_LONGINT:C283($PixPerChar; $PixPerLine)  //Command Replaced was o_C_INTEGER
		//TRACE
		$Message:=$1
		$Len:=Length:C16($Message)
		If ($Len>50)
			$Len:=50
		End if 
		$hMarg:=1  //2-10-2000 : CM
		$vMarg:=1
		Case of 
				
			: (<>PL_LPlatfrm>=3)
				//Wintel:  Monospaced Courier? font.
				$PixPerChar:=11  //9 pixels per character wide.
				$PixPerLine:=16  //15 pixels per line high.
			Else 
				//Mac:  Monospaced Monaco font.
				//$PixPerChar:=6  `6 pixels per character wide.
				//$PixPerLine:=11  `11 pixels per line high.
				
				// Modified by: costasmanousakis-(Designer)-(9/11/05 12:47:13)
				$PixPerChar:=9  //3-3-2001 ASL
				$PixPerLine:=15  //3-3-2001 ASL
		End case 
		$Width:=($Len+(2*$hMarg))*$PixPerChar
		$Height:=(1+(2*$vMarg))*$PixPerLine
		//If (Not(Is compiled mode))
		//Else 
		//CENTER_WINDOW ($Width;$Height)
		//End if 
		CENTER_WINDOW($Width; $Height; 0)
		
		GOTO XY:C161($hMarg; $vMarg)
		MESSAGE:C88(Substring:C12($Message; 1; $Len))
	End if 
End if 