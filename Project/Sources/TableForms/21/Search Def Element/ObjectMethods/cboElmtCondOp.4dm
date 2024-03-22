If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/11/05, 06:14:05
	// ----------------------------------------------------
	// Method: Object Method: cboElmtCondOp
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/20/11, 10:43:25      ` Type all local variables for v11
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				vElmtCondOp:=""
			: (Self:C308->=2)
				vElmtCondOp:="="
			: (Self:C308->=3)
				vElmtCondOp:="#"
			: (Self:C308->=4)
				vElmtCondOp:="<"
			: (Self:C308->=5)
				vElmtCondOp:="<="
			: (Self:C308->=6)
				vElmtCondOp:=">"
			: (Self:C308->=7)
				vElmtCondOp:=">="
		End case 
		LIST TO ARRAY:C288("Rating Categories"; $aTempCategory)
		LIST TO ARRAY:C288("Rating Codes"; $aTempCodes)
		LIST TO ARRAY:C288("Rating Categories"; $aTempCategoryNum)
		LIST TO ARRAY:C288("Rating Codes"; $aTempCodesNum)
		C_LONGINT:C283($i; $k)
		
		For ($i; Size of array:C274($aTempCodesNum); 1; -1)
			If (Not:C34(bIsNumeric($aTempCodesNum{$i})))
				DELETE FROM ARRAY:C228($aTempCodesNum; $i; 1)
				DELETE FROM ARRAY:C228($aTempCategoryNum; $i; 1)
			End if 
			
		End for 
		
		If (Self:C308->>=4)
			If (Not:C34(bIsNumeric(cboElmtCondCode{cboElmtCond})))
				//if current code is not numeric - reset it and list only numeric.
				COPY ARRAY:C226($aTempCodesNum; cboElmtCondCode)
				COPY ARRAY:C226($aTempCategoryNum; cboElmtCond)
				cboElmtCond:=0
			Else 
				//if it is numeric -make sure we show only numeric but remember current sel.
				$k:=Find in array:C230($aTempCodesNum; cboElmtCondCode{cboElmtCond})
				COPY ARRAY:C226($aTempCodesNum; cboElmtCondCode)
				COPY ARRAY:C226($aTempCategoryNum; cboElmtCond)
				If ($k>=0)
					cboElmtCond:=$k
				Else 
					cboElmtCond:=0
				End if 
				
			End if 
		Else 
			//show all but remember current sel.
			$k:=Find in array:C230($aTempCodes; cboElmtCondCode{cboElmtCond})
			COPY ARRAY:C226($aTempCodes; cboElmtCondCode)
			COPY ARRAY:C226($aTempCategory; cboElmtCond)
			If ($k>=0)
				cboElmtCond:=$k
			Else 
				cboElmtCond:=0
			End if 
			
		End if 
		
End case 
