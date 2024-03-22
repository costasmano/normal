If (False:C215)
	//[Dialogs];"BigAlert"
	// Modified by: Costas Manousakis-(Designer)-(11/16/18 12:53:03)
	Mods_2018_11
	//  `added form method to resize window to display better the message
	//  // made Message field multistyle
	// Modified by: Costas Manousakis-(Designer)-(12/5/18 09:29:08)
	Mods_2018_12_bug
	//  `don't allow the window to become less than original width or height
	// Modified by: Costas Manousakis-(Designer)-(2022-12-15 15:23:51)
	Mods_2022_12_bug
	//  `use .messageDisplay of the Form object for the message if it is defined.
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (OB Is defined:C1231(Form:C1466; "messageDisplay"))
			vtMessage:=Form:C1466.messageDisplay
		End if 
		C_LONGINT:C283($L; $T; $R; $B; $bestW; $bestH; $WL; $WT; $WR; $WB; $SW; $SH; $maxW; \
			$Rborder; $maxwPosScr; $maxwPosW; $Bborder; $maxHPosScr; $maxHPosW; \
			$WW; $WH; $IncrW; $IncrH; $maxH)
		GET WINDOW RECT:C443($WL; $WT; $WR; $WB)
		$WW:=$WR-$WL
		$WH:=$WB-$WT
		$SW:=Screen width:C187
		$SH:=Screen height:C188
		OBJECT GET COORDINATES:C663(*; "Message"; $L; $T; $R; $B)
		
		$Rborder:=$WW-$R
		$maxwPosScr:=$SW-(50+$Rborder)  //allow extra 50 pixels from screen edge
		$maxwPosW:=$maxwPosScr-$WL
		$maxW:=$maxwPosW-$L  //max width of object
		$maxW:=MinNum($maxW; (1.5*($R-$L)))
		OBJECT GET BEST SIZE:C717(*; "Message"; $bestW; $bestH; $maxW)
		$IncrW:=$bestW-($R-$L)
		
		$Bborder:=$WH-$B
		$maxHPosScr:=$SH-(50+$Bborder)  //allow extra 50 pixels from screen edge
		$maxHPosW:=$maxHPosScr-$WT
		$maxH:=$maxHPosW-$T
		$bestH:=MinNum($bestH; $maxH)
		
		$IncrH:=$bestH-($B-$T)
		If ($IncrH<0)
			$IncrH:=0
		End if 
		If ($IncrW<0)
			$IncrW:=0
		End if 
		
		SET WINDOW RECT:C444($WL; $WT; ($WR+$IncrW); ($WB+$IncrH))
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 
