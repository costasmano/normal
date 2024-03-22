//%attributes = {"invisible":true}
//Method: ut_TempUpdateScourCritCmts
//Description
// method to load into [ScourCriticalInfo] comments from a text file 
// text file is tab delimited two columns BIN, comments.
// After import, need to execute Relog records for [ScourCriticalInfo] to transfer info to other servers
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/12/15, 10:56:15
	// ----------------------------------------------------
	//Created : 
	Mods_2015_01
End if 
//
Compiler_SQL
C_TIME:C306($importDoc_t)
$importDoc_t:=Open document:C264(""; ""; Read mode:K24:5)
If (OK=1)
	C_TEXT:C284($tbuffer_txt; $username_txt; $password_txt; $serverIP_txt)
	C_TEXT:C284(v_150_016_txt)  //Comments_txt
	C_TEXT:C284(v_1_003_txt)  //BIN
	C_LONGINT:C283(v_1_006_l)  //Rank - just to avoid extra param variables
	
	$username_txt:=Request:C163("Username "; Current user:C182)
	C_TEXT:C284(OP_Password_txt)
	C_LONGINT:C283($err_L; $linecount_L; $lineUpdate_L; $LineCreateNew_L)
	$err_L:=OP_GetPassword("Enter passowrd")
	$serverIP_txt:=Request:C163("server IP:SQLport")
	
	SQL LOGIN:C817("IP:"+$serverIP_txt; $username_txt; OP_Password_txt; *)
	If (OK=1)
		$linecount_L:=0
		$lineUpdate_L:=0
		$LineCreateNew_L:=0
		While (OK=1)
			RECEIVE PACKET:C104($importDoc_t; $tbuffer_txt; <>sCR)
			$linecount_L:=$linecount_L+1
			
			If (Substring:C12($tbuffer_txt; 1; 1)=<>sLF)
				//if 1st char is a LF then skip it    
				$tbuffer_txt:=Substring:C12($tbuffer_txt; 2)
			End if 
			//exclude blank lines
			If ($tbuffer_txt#"")
				//skip fisrt line
				//MESSAGE(" tBuffer "+$tBuffer)
				v_1_003_txt:=Substring:C12($tbuffer_txt; 1; 3)
				v_150_016_txt:=Substring:C12($tbuffer_txt; 5)
				// 1st check if bridge record exists
				Begin SQL
					select count(*) from [Bridge MHD NBIS]
					WHERE BIN = :v_1_003_txt into :v_1_006_l ;
				End SQL
				If (v_1_006_l=1)
					//check if we need to create a [ScourCriticalInfo] or not
					Begin SQL
						select count(*) from [ScourCriticalInfo] 
						WHERE BIN = :v_1_003_txt into :v_1_006_l For update ;
					End SQL
					If (v_1_006_l=0)
						Begin SQL
							insert INTO [ScourCriticalInfo] ([BIN] , [Comments_txt])
							values (:v_1_003_txt , :v_150_016_txt) ;
						End SQL
						$LineCreateNew_L:=$LineCreateNew_L+1
					Else 
						Begin SQL
							update [ScourCriticalInfo] set [Comments_txt] = :v_150_016_txt
							WHERE BIN = :v_1_003_txt ;
						End SQL
						$lineUpdate_L:=$lineUpdate_L+1
					End if 
				Else 
					ALERT:C41("Bridge record for BIN : ["+v_1_003_txt+"] does not exist!!")
				End if 
				
			End if 
			
		End while 
		SQL LOGOUT:C872
	End if 
	CLOSE DOCUMENT:C267($importDoc_t)
	ALERT:C41("Processed "+String:C10($linecount_L)+" lines. Updated "+String:C10($lineUpdate_L)+" records. Created "+String:C10($LineCreateNew_L)+" records")
End if 
//End ut_TempUpdateScourCritCmts
