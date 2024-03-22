//%attributes = {"invisible":true}
//Method: PON_NBE_INIT
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/03/15, 12:45:17
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
End if 
//

PON_INIT

C_BOOLEAN:C305($NBEOn_b)
$NBEOn_b:=PON_NBEDateOn_b([Inspections:27]Insp Date:78)
OBJECT SET VISIBLE:C603(*; "@PON_@"; $NBEOn_b)
OBJECT SET VISIBLE:C603(*; "@pontis@"; Not:C34($NBEOn_b))
C_LONGINT:C283($Ponpage_L)

If ($NBEOn_b)
	
	If (Type:C295(vTabRoutingPages)=Is undefined:K8:13)
	Else 
		$Ponpage_L:=Find in array:C230(vTabRoutingPages; "Pontis")
		If ($Ponpage_L>0)
			vTabRoutingPages{$Ponpage_L}:="NBE"
		End if 
	End if 
	If (Type:C295(CulvertTabCtrl)=Is undefined:K8:13)
	Else 
		$Ponpage_L:=Find in array:C230(CulvertTabCtrl; "Pontis")
		If ($Ponpage_L>0)
			CulvertTabCtrl{$Ponpage_L}:="NBE"
		End if 
		
	End if 
	
	If (Records in selection:C76([Cond Units:45])>0)
		OBJECT SET VISIBLE:C603(*; "PON_ShowCoRE"; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*; "PON_ShowCoRE"; False:C215)
	End if 
	If (Records in selection:C76([PON_ELEM_INSP:179])>0)
		OBJECT SET VISIBLE:C603(*; "PON_CopyNBE"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "PON_CopyNBE"; True:C214)
	End if 
Else 
	
	If (Type:C295(vTabRoutingPages)=Is undefined:K8:13)
		
	Else 
		$Ponpage_L:=Find in array:C230(vTabRoutingPages; "NBE")
		If ($Ponpage_L>0)
			vTabRoutingPages{$Ponpage_L}:="Pontis"
		End if 
	End if 
	
	If (Type:C295(CulvertTabCtrl)=Is undefined:K8:13)
		
	Else 
		$Ponpage_L:=Find in array:C230(CulvertTabCtrl; "NBE")
		If ($Ponpage_L>0)
			CulvertTabCtrl{$Ponpage_L}:="Pontis"
		End if 
	End if 
	
End if 
//End PON_NBE_INIT