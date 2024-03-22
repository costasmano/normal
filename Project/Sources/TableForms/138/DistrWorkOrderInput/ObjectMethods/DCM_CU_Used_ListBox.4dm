If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/7/09 17:19:05)
	Mods_2009_08  //Copied to Server on : 08/26/09, 15:35:56
	// Modified by: costasmanousakis-(Designer)-(12/13/10 09:52:32)
	Mods_2010_12
	//  `Added popup menu to help with editing
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($mousex; $mouseY; $mousBtn)
		GET MOUSE:C468($mousex; $mouseY; $mousBtn)
		C_LONGINT:C283($RowSel_L; $ColSel_L)
		$RowSel_L:=DCM_CUUsedQ1_ar
		If ($RowSel_L>0)
			If ((Right click:C712) | (Macintosh control down:C544))
				C_TEXT:C284($PopMenuCmds_txt)
				$PopMenuCmds_txt:=". Choises for"+String:C10(DCM_CUUsedElNos_aL{$RowSel_L})
				$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Copy Total Q to Used Q"
				$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Edit Used Quantity"
				$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Edit Comments"
				
				C_LONGINT:C283($Ret_L)
				$Ret_L:=Pop up menu:C542($PopMenuCmds_txt)
				Case of 
					: ($Ret_L=2)
						DCM_CUUsedQ1_ar{$RowSel_L}:=DCM_CUUsedQ_ar{$RowSel_L}
						[DCM_Project:138]CurrCost:12:=[DCM_Project:138]CurrCost:12  //show record modified change
					: ($Ret_L=3)
						EDIT ITEM:C870(DCM_CUUsedQ1_ar; $RowSel_L)
					: ($Ret_L=4)
						EDIT ITEM:C870(DCM_CUUsedComments_atxt; $RowSel_L)
				End case 
				
			End if 
		End if 
	: (Form event code:C388=On Drag Over:K2:13)
		//C_POINTER($vpSrcObj)
		//C_LONGINT($vlSrcElem; $vlPID)
		//_O_DRAG AND DROP PROPERTIES($vpSrcObj; $vlSrcElem; $vlPID)
		//If ($vpSrcObj=Get pointer("DCM_CUListBox"))
		////Accept objects only from DCM_CUListBox      
		//$0:=0
		//Else 
		//$0:=-1
		//End if 
		
		
	: (Form event code:C388=On Begin Drag Over:K2:44)
		
		C_LONGINT:C283($col; $row)
		
		Use (Storage:C1525)
			Storage:C1525.dragAndDrop:=New shared object:C1526
			//If (Not(Undefined(Storage.dragAndDrop)))
			Use (Storage:C1525.dragAndDrop)
				Storage:C1525.dragAndDrop.source:=FORM Event:C1606.objectName
				LISTBOX GET CELL POSITION:C971(PHotos_LB; $col; $row)
				Storage:C1525.dragAndDrop.index:=$row
				Storage:C1525.dragAndDrop.process:=Current process:C322
			End use 
			//End if 
		End use 
		
	: (Form event code:C388=On Drop:K2:12)
		C_POINTER:C301($sourceObject)
		C_LONGINT:C283($sourceNumber; $sourceProcess)
		C_TEXT:C284($sourceObjectName)
		C_LONGINT:C283($Src_element; $Src_process; $dropRow_L; $ColNum_L)
		
		//_O_DRAG AND DROP PROPERTIES($sourceObject; $sourceNumber; $sourceProcess)
		
		Use (Storage:C1525)
			If (Not:C34(Undefined:C82(Storage:C1525.dragAndDrop)))
				Use (Storage:C1525.dragAndDrop)
					$sourceObjectName:=Storage:C1525.dragAndDrop.source
					$sourceNumber:=Storage:C1525.dragAndDrop.index
					$sourceProcess:=Storage:C1525.dragAndDrop.process
				End use 
			End if 
		End use 
		//ALERT("Droped item "+String(DCM_CUElNos_aL{$sourceNumber})+" "+DCM_CUDesc_atxt{$sourceNumber}+" Env "+String(DCM_CUEnv_ai{$sourceNumber}))
		C_LONGINT:C283($inList_L; $Start_L)
		C_BOOLEAN:C305($InList_B; $done_b)
		$InList_B:=False:C215
		$done_b:=False:C215
		$Start_L:=1
		ARRAY LONGINT:C221($Posisiotn_al; 0)
		
		Repeat 
			$inList_L:=Find in array:C230(DCM_CUUsedElNos_aL; DCM_CUElNos_aL{$sourceNumber}; $Start_L)
			If ($inList_L<=0)
				$done_b:=True:C214
			Else 
				APPEND TO ARRAY:C911($Posisiotn_al; $inList_L)
				If (DCM_CUUsedEnv_ai{$inList_L}=DCM_CUEnv_ai{$sourceNumber})
					$InList_B:=True:C214
					$done_b:=True:C214
				Else 
					$Start_L:=$inList_L+1
				End if 
				
			End if 
		Until ($done_b)
		If (Not:C34($InList_B))
			DCM_ControlCUs("ADDTOUSED"; $sourceNumber)
		End if 
		
End case 