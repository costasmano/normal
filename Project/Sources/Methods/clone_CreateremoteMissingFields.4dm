//%attributes = {"invisible":true}
//Method: clone_CreateremoteMissingFields
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/11/18, 15:23:57
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06
	
End if 
//
C_LONGINT:C283($TableNumber_L)

C_BLOB:C604($report_blb)
C_LONGINT:C283($loop_L)
C_TEXT:C284($4DType_txt)
C_LONGINT:C283($Type_l; $ArrayPosition_L)

ARRAY TEXT:C222(clone_RemoteTables_atxt; 0)


For ($TableNumber_L; 1; Get last table number:C254)
	If (Is table number valid:C999($Tablenumber_L))
		ARRAY TEXT:C222($Cname_atxt; 0)
		ARRAY LONGINT:C221($DataType_aL; 0)
		ARRAY LONGINT:C221($DataLength_aL; 0)
		ARRAY LONGINT:C221($ColumnID_aL; 0)
		
		Begin SQL
			select 
			COLUMN_NAME, 
			DATA_TYPE, 
			DATA_LENGTH, 
			COLUMN_ID 
			from
			_USER_COLUMNS
			where
			TABLE_ID = :$TableNumber_L
			into
			:$Cname_atxt, :$DataType_aL, :$DataLength_aL,  :$ColumnID_aL;
			
			select
			TABLE_NAME
			from 
			_USER_TABLES
			into
			:clone_RemoteTables_atxt;
			
		End SQL
		For ($loop_L; 1; Get last field number:C255($TableNumber_L))
			If (Is field number valid:C1000($TableNumber_L; $loop_L))
				$ArrayPosition_L:=Find in array:C230($ColumnID_aL; $loop_L)
				If ($ArrayPosition_L>0)
				Else 
					
					APPEND TO ARRAY:C911(clone_MissRemoteTableFld_atxt; Table name:C256($TableNumber_L)+"--"+Field name:C257($TableNumber_L; $loop_L))
				End if 
			End if 
		End for 
	End if 
End for 

//End clone_CreateremoteMissingFields