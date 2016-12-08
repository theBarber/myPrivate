Feature: create test data via API 

@campaign 
Scenario Outline: generate campaigns via API only if needed 
	Given Zoneset named {<zs>} 
	And Zone named {<z>} is in the zoneset named {<zs>}
#	And Zone named {<z>} is the only one in zoneset named {<zs>} 
	 
	Given Campaign named {<c>}
	And Campaign named {<c>} is in the zoneset named {<zs>}
#	And Campaign named {<c>} is the only one in zoneset named {<zs>} 
	
	And Campaign named {<c>} has a creative with banner named {<b>} 
	
	#	And Zoneset named {<zs>} 
	#	And Zone named {<z>} is in the zoneset named {<zs>} 
	#	And Campaign named {<c>} zoneset list contains the zoneset named {<zs>} 
	
	
	Examples: 
		| c | b | cr |z  | zs | 
		|Test Advertiser - Remnant Campaign|Test Banner1|cr2 | qa.undertone.com - Full Banner|hwu zonesets |
		#	| c3|b1 |cr1 | z1|zs1 |
		#   | c2|b2 |cr2 | z1|zs2 |
		#   | c1|b1 |cr2 | z1|zs2 |
    