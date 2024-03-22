//%attributes = {"invisible":true}
//Method: DB_ReturnLockStatusInfo
//Description
// Update a status object of a .lock() with an attribute that has all the info combined in one text
// Parameters
// $1 : $lockstatus_o
//    add .dblockstatusinfo
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 19, 2024, 10:41:53
	Mods_2024_01
	// ----------------------------------------------------
	
	C_OBJECT:C1216(DB_ReturnLockStatusInfo; $1)
End if 
//
C_OBJECT:C1216($1)

C_TEXT:C284($dblockstatusinfo_txt)

Case of 
	: ($1.success)
		//no error
	Else 
		$dblockstatusinfo_txt:=$1.statusText
		
		If ($1.lockKindText#Null:C1517)
			
			If ($1.lockKindText="@record")
				//locked by process - need the username
				C_TEXT:C284($user_txt; $start_txt; $pw_txt)
				C_LONGINT:C283($nlogin_L)
				C_DATE:C307($lastLogin_d)
				GET USER PROPERTIES:C611($1.lockInfo.user4d_id; $user_txt; $start_txt; $pw_txt; $nlogin_L; $lastLogin_d)
				$dblockstatusinfo_txt:=$dblockstatusinfo_txt+"\n"+\
					"Locked by user "+$user_txt+\
					", in process "+$1.lockInfo.task_name+\
					", on workstation "+$1.lockInfo.host_name+\
					", OS username "+$1.lockInfo.user_name
			Else 
				//locked by REST
				$dblockstatusinfo_txt:=$dblockstatusinfo_txt+"\n"+\
					"Locked by host URL "+$1.lockInfo.host+\
					", at IP address "+$1.lockInfo.IPAddr+\
					", with browser "+$1.lockInfo.userAgent
			End if 
			
		End if 
		
		If ($1.errors#Null:C1517)
			//compile the objects in errors
			If ($1.errors.length>0)
				C_OBJECT:C1216($error_o)
				$dblockstatusinfo_txt:=$dblockstatusinfo_txt+"\n"+\
					"List of errors \n"
				For each ($error_o; $1.errors)
					$dblockstatusinfo_txt:=$dblockstatusinfo_txt+"\n"+\
						"Error number "+String:C10($error_o.errCode)+\
						" : "+$error_o.message+\
						", signature "+$error_o.componentsignatue
				End for each 
				
			End if 
			
		End if 
		
End case 

OB SET:C1220($1; "dblockstatusinfo"; $dblockstatusinfo_txt)

//End DB_ReturnLockStatusInfo   