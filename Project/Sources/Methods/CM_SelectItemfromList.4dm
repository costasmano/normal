//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: CM_CM_SelectItemfromList
	// Description
	//   Selecting list item according to the project type
	//
	// Parameters
	// ----------------------------------------------------
End if 


Case of 
		//Bridge Betterment Category 
	: ([Contract_Project_Maintenance:100]Project Type:3="Deck Replacement & Safety Upgrade")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 201)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Substructure Scour or Seismic Retrofit")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 202)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Superstructure Upgrade")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 203)
		
		//Bridge Maintenance Category 
	: ([Contract_Project_Maintenance:100]Project Type:3="Routine - Drainage, Scupper & Downpouts")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 301)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Routine - Washing")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 302)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - Deck")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 303)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - DrawBridge")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 304)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - Shielding")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 305)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - Substructure")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 306)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Scheduled & Emergency - Structural")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 307)
		
		//Bridge Preservation Category
	: ([Contract_Project_Maintenance:100]Project Type:3="Joints")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 401)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Painting")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 402)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Substructure")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 403)
		
	: ([Contract_Project_Maintenance:100]Project Type:3="Wearing Surface, Membrane & Deck Patching")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 404)
		
		//Bridge Rehabilitation Category(RefID=500)
		//still waiting for the items of this category
		
		//Bridge Replacement Category(RefID:=600)
		//still waiting for the items of this category
		
		//Weight Restricted Category
	: ([Contract_Project_Maintenance:100]Project Type:3="Deck Replacement")
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 701)
		
	Else 
		//there is no Project Type 
		SELECT LIST ITEMS BY REFERENCE:C630(WorkTypeHList; 100)
		
End case 