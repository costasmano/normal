//%attributes = {"invisible":true}
//Method: WP_GetExpressions
//Description
// fills the arrays passed with the locations and content
// of the expressions in the styled text
// Call: Count:=WritePro_GetExpressions(ObjectPointer;ArrayPtrPositions;ArrayPtrExrpessions)
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// Method: WritePro_GetExpressions
	// ----------------------------------------------------
	// ----------------------------------------------------
	// UserName (OS): Alexander Heintz
	// Date and Time: 04.08.15, 13:02:02
	// ----------------------------------------------------
	// Does:
	// ----------------------------------------------------
	// Parameters:
	// -> $1 pointer styled text or WP Area
	// -> $2 pointer array long
	// -> $3 pointer array text
	// -> $0 longint number of expressions found
	// ----------------------------------------------------
	
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/31/21, 19:50:36
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_POINTER:C301(WP_GetExpressions; $1)
	C_POINTER:C301(WP_GetExpressions; $2)
	C_POINTER:C301(WP_GetExpressions; $3)
	C_LONGINT:C283(WP_GetExpressions; $0)
	
End if 
//

// Parameter Definition
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_LONGINT:C283($0)
// ----------------------------------------------------
// Local Variable Definition
C_LONGINT:C283($l)
C_LONGINT:C283($l_DetCheckEnd)
C_LONGINT:C283($l_EndSub)
C_LONGINT:C283($l_Length)
C_LONGINT:C283($l_Start)
C_LONGINT:C283($l_StartSub)
C_POINTER:C301($p_Area)
C_POINTER:C301($p_Exp)
C_POINTER:C301($p_Pos)
C_LONGINT:C283($l_End)
// ----------------------------------------------------
// Parameter Assignment
$p_Area:=$1
$p_Pos:=$2
$p_Exp:=$3
// ----------------------------------------------------
$l_Start:=1
$l_Length:=Length:C16(ST Get plain text:C1092($p_Area->))
If (ST Get content type:C1286($p_Area->; $l_Start; $l_Length)=ST Mixed type:K78:4)
	//split to 100 chars
	While ($l_Start<$l_Length)
		$l_StartSub:=$l_Start
		$l_EndSub:=$l_StartSub+100
		$l_EndSub:=Choose:C955($l_EndSub>$l_Length; $l_Length; $l_EndSub)
		$l_End:=$l_Start+100
		If (ST Get content type:C1286($p_Area->; $l_Start; $l_End)=ST Mixed type:K78:4)
			//batches of 10
			While ($l_StartSub<$l_EndSub)
				$l_End:=$l_StartSub+10
				If (ST Get content type:C1286($p_Area->; $l_StartSub; $l_End)=ST Mixed type:K78:4)
					$l_DetCheckEnd:=$l_StartSub+10
					$l_DetCheckEnd:=Choose:C955($l_DetCheckEnd>$l_Length; $l_Length; $l_DetCheckEnd)
					For ($l; $l_StartSub; $l_DetCheckEnd)
						$l_End:=$l+1
						If (ST Get content type:C1286($p_Area->; $l; $l_End)=ST Expression type:K78:3)
							APPEND TO ARRAY:C911($p_Pos->; $l)
							APPEND TO ARRAY:C911($p_Exp->; ST Get expression:C1287($p_Area->; $l; $l+1))
						End if 
					End for 
				End if 
				$l_StartSub:=$l_StartSub+10
			End while 
		End if 
		$l_Start:=$l_Start+100
	End while 
End if 
$0:=Size of array:C274($p_Pos->)
//End WP_GetExpressions