//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: CM_SelectItem_FromWorkTypeList
	// Description
	//   Selecting list item according to the project type
	//
	// Parameters
	// ----------------------------------------------------
End if 

Case of 
		
		//New Bridge  Category 
	: ([Contract_Assignment_Maintenance:101]ProjectType:36="New Bridge")
		SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 1)
		
		//Bridge Betterment Category 
	: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Betterment")
		
		Case of 
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Deck Replacement & Safety Upgrade")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 2)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Substructure Scour or Seismic Retrofit")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 3)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Superstructure Upgrade")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 4)
				
			Else 
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 1)
				
		End case 
		
		//Bridge Maintenance Category 
	: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Maintenance")
		
		Case of 
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Routine - Drainage, Scupper & Downpouts")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 2)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Routine - Washing")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 3)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - Deck")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 4)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - DrawBridge")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 5)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - Shielding")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 6)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - Substructure")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 7)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - Structural")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 8)
				
			Else 
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 1)
				
		End case 
		
		//Bridge Preservation Category
	: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Preservation")
		
		Case of 
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Joints")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 2)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Painting")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 3)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Substructure")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 4)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Wearing Surface, Membrane & Deck Patching")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 5)
				
			Else 
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 1)
				
		End case 
		
		//Bridge Rehabilitation Category
	: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Rehabilitation")
		SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 1)
		
		//Bridge Replacement Category
	: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Replacement")
		SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 1)
		
		//Weight Restricted Category
	: ([Contract_Assignment_Maintenance:101]ProjectType:36="Weight Restricted")
		
		Case of 
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Deck Replacement")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 2)
				
			: ([Contract_Project_Maintenance:100]Project Type:3="Superstructure Upgrade")
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 3)
				
			Else 
				SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 1)
				
		End case 
		
		//there is no Project Type for the current record  
	Else 
		SELECT LIST ITEMS BY REFERENCE:C630(MntWorkTypeHList; 1)
		
End case 
