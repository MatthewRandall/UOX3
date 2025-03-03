const scriptID = 4033;

function onMakeItem( pSock, crafter, itemCrafted, craftEntryID )
{
	if( pSock == null || !ValidateObject( crafter ))
		return;

	// Apply special effect based on item crafted
	if( ValidateObject( itemCrafted ))
	{
		switch( craftEntryID )
		{
			case 239: // necklace
			case 240: // necklace
			case 241: // earrings
			case 242: // necklace
			case 243: // bracelet
				// Name the jewelry after the gems used to craft them
				itemCrafted.name = crafter.GetTempTag( "targetedSubResourceName" ) + " " + itemCrafted.name;
				break;
			case 63: // Small Chest
			case 64: // Small Crate
			case 65: // Medium Crate
			case 67: // Large Crate
			case 68: // Chest
			case 70: // Armoire
			case 71: // Armoire
				// Add locks (and keys) to these containers if player has high enough Tinkering skill
				var createEntry = CreateEntries[craftEntryID];
				var skills = createEntry.skills; // list of skill requirements
				for( var i = 0; i < skills.length; i++ )
			    {
			        var skillReq = skills[i];
			        var skillNumber = skillReq[0];
					var minSkill = skillReq[1];

					if( skillNumber == 11 ) // Carpentry
					{
						// Do a random check to see if player succeeds at making a lock for the container
						if( crafter.skills.tinkering >= RandomNumber( minSkill / 2, 1000 ))
						{
							// Great success! Add a key to the container, set MORE values to match for both!
							var newKey = CreateDFNItem( pSock, crafter, "0x100E", 1, "ITEM", true );
							newKey.container = itemCrafted;
							newKey.PlaceInPack();
							newKey.name = "key for " + itemCrafted.name;

							// Set more of key AND box to match serial of box
							newKey.more = itemCrafted.serial;
							itemCrafted.more = itemCrafted.serial;
							pSock.SysMessage( GetDictionaryEntry( 12009, pSock.language )); // You added a lock and key to the container!
						}
						break;
					}
				}
				break;
			case 0: // Failed to craft item
			default:
				break;
		}
	}

	// Clean up some tags while we're here
	crafter.SetTempTag( "targetedSubResourceID", null );
	crafter.SetTempTag( "targetedSubResourceName", null );
	crafter.SetTempTag( "targetedMainResourceID", null );
	crafter.SetTempTag( "targetedMainResourceSerial", null );

	// Remove script from player
	crafter.RemoveScriptTrigger( scriptID );
}