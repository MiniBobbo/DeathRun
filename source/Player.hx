package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import inputhelper.InputHelper;

/**
 * ...
 * @author Dave
 */
class Player extends Entity
{

	//Movement variables
	var GRAV:Int = 5000;
	var JMPLEN:Float = .14;
	var JMPSTR:Int = 1000;
	var RUNSPD:Int = 500;
	
	//Jumping variables
	var _falling:Bool = true;
	var _jumpTime:Float = 0;
	
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		//Set up the player variables
		acceleration.y = GRAV;
		maxVelocity.set(RUNSPD, JMPSTR);
		
		//Create player graphics.
		makeGraphic(40, 40, FlxColor.RED);
		
	}
	
	override public function update():Void 
	{
		movementCode();
		
		super.update();
	}

	/**
	 * Contains all the movement code for the player.
	 */
	public function movementCode() {
		/**
		 * Horizontal Movement Code
		 */
		velocity.x = 0;
		if (InputHelper.isButtonPressed("left")) { 
			velocity.x = -RUNSPD;
		} else if (InputHelper.isButtonPressed("right")) {
			velocity.x = RUNSPD;
		}
		
		/**
		 * Jumping Code
		 */
		//If we are jumping, check if we hit the ground.  If we did, reset the jump variables.
		if (_falling && isTouching(FlxObject.FLOOR)) {
			_jumpTime = 0;
			_falling = false;
		}
		
		if (InputHelper.isButtonPressed("up"))
		_falling = true;
		
		//If we aren't touching the floor, set the jumping variable.
		if (!isTouching(FlxObject.FLOOR))
		_falling = true;
		
		//If we are in the air...
		if (_falling) {
			//If we let go of the button, increase the jump time so it no longer applies.
			if (!InputHelper.isButtonPressed("up") || isTouching(FlxObject.CEILING))
			_jumpTime= 100;
			else if (_jumpTime <= JMPLEN) {
			velocity.y = -JMPSTR;
			_jumpTime += FlxG.elapsed;
			
			}
		}
		
	}
}