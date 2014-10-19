package ;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxStringUtil;
import inputhelper.InputHelper;
import openfl.Assets;

/**
 * ...
 * @author Dave
 */
class LevelState extends FlxState
{
	var _map:FlxTilemap;
	var _p : Player;

	//FlxGroups
	var _enemies:FlxTypedGroup<Entity>;
	var _entities:FlxTypedGroup<Entity>;
	
	override public function create():Void 
	{
		super.create();
		
		//Initialize variables
		_enemies = new FlxTypedGroup<Entity>();
		_entities = new FlxTypedGroup<Entity>();
		
		//Load the map.
		_map = new FlxTilemap();
		_map.loadMap(FlxStringUtil.bitmapToCSV(Assets.getBitmapData("assets/images/testlevel.png")), "assets/images/whiteblock.png");
		
		//Create the player.
		_p = new Player(40, 40);
		_entities.add(_p);
		
		
		
		//Add the vatiables to the stage
		add(_map);
		add(_p);
	}
	
	
	override public function update():Void 
	{
		InputHelper.updateKeys();
		super.update();
		FlxG.collide(_entities, _map);
	}
	
}