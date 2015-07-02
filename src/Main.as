package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Jeferson Schein E Ivair Puerari
	 */
	public class Main extends FlxGame 
	{
		
		public function Main() : void
		{
			
			super(400, 300, PlayState, 2);
			
			FlxG.mouse.show();
			
		}
	}
}