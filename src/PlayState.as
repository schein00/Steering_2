package 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Jeferson Schein E Ivair Puerari
	 */
	public class PlayState extends FlxState
	{
		
		private var auxX : int;
		
		[Embed(source="../Assets/warrior_f.png")]
		public var imgPlayer : Class;
		
		[Embed(source="../Assets/Mapa_0.txt",  mimeType = 'application/octet-stream')]
		private static var map_1 : Class;
		
		[Embed(source="../Assets/tileable_grass_00.png")]
		private var chao : Class;
		
		[Embed(source="../Assets/star.fw.png")]
		private var imgStar : Class;
		
		private const OBJ_WIDTH : uint = 16;
		private const OBJ_HEIGHT : uint = 16;
		
		private var Map : FlxTilemap;
		
		private var scoreT : FlxText;
		private var scoreV : uint = 0;
		private var scoreS : String = "Score: ";
		
		public var player : FlxSprite;
		public var star : FlxSprite;
		public var star_2 : FlxSprite;
		public var star_3 : FlxSprite;
		public var star_4 : FlxSprite;
 		
		
		override public function create() :void
		{
			Map = new FlxTilemap();
			Map.loadMap( new map_1() , chao, OBJ_WIDTH, OBJ_HEIGHT,FlxTilemap.OFF);
			add(Map);
			
			setPlayer();
			setStar();
			
			scoreT = new FlxText(FlxG.width - 75, 10, 75 , scoreS + scoreV);
			add(scoreT);
		}
		
		
		override public function update() : void
		{
			
			FlxG.collide(player, Map);
			FlxG.collide(star, Map );
			FlxG.collide(star_2, Map );
			FlxG.collide(star_3, Map );
			FlxG.collide(star_4, Map );
			
			FlxG.overlap(player, star, colizao);
			FlxG.overlap(player, star_2, colizao);
			FlxG.overlap(player, star_3, colizao);
			FlxG.overlap(player, star_4, colizao);
			
			if(star.y > FlxG.height){
				star.y = 10;
			}
			
			if(star_2.y > FlxG.height){
				star_2.y = 10;
			}
			if(star_3.y > FlxG.height){
				star_3.y = 10;
			}
			if(star_4.y > FlxG.height){
				star_4.y = 10;
			}
			
			
			updatePlayer();
			super.update();
		}
		
		public function colizao( p : FlxSprite, s : FlxSprite): void 
		{
			
			//s.kill();
			scoreV += (Math.random() * 100);
			scoreT.text = scoreS + scoreV;
			
			s.x = (Math.random() * FlxG.width);
			s.y = (Math.random() * FlxG.width);
			
			
		}
		
		
		public function setStar():void 
		{
			
			star = new FlxSprite((Math.random() * FlxG.width), FlxG.height);
			star.loadGraphic(imgStar, true, true, 16);
			
			star.x = (Math.random() * FlxG.width);
			star.y = 10;
			
			star.acceleration.y = 500;
			star.maxVelocity.y = 210;
			
			add(star);
			
			star_2 = new FlxSprite((Math.random() * FlxG.width), FlxG.height);
			star_2.loadGraphic(imgStar, true, true, 16);
			
			star_2.x = (Math.random() * FlxG.width);
			star_2.y = 10;
			
			star_2.acceleration.y = 500;
			star_2.maxVelocity.y = 210;
			
			add(star_2);
			
			star_3 = new FlxSprite((Math.random() * FlxG.width), FlxG.height);
			star_3.loadGraphic(imgStar, true, true, 16);
			
			star_3.x = (Math.random() * FlxG.width);
			star_3.y = 10;
			
			star_3.acceleration.y = 500;
			star_3.maxVelocity.y = 210;
			
			add(star_3);
			
			star_4 = new FlxSprite((Math.random() * FlxG.width), FlxG.height);
			star_4.loadGraphic(imgStar, true, true, 16);
			
			star_4.x = (Math.random() * FlxG.width);
			star_4.y = 10;
			
			star_4.acceleration.y = 500;
			star_4.maxVelocity.y = 210;
			
			add(star_4);
			
		}
		
		
		public function setPlayer():void 
		{
			player = new FlxSprite(FlxG.width , FlxG.height - 40);
			player.loadGraphic(imgPlayer, true, true,16);
			
			player.width = 14;
			player.height = 14;
			player.offset.x = 1;
			player.offset.y = 1;
			
			//fisica basica
			player.drag.x = 700;
			player.acceleration.y = 450;
			player.maxVelocity.x = 75;
			player.maxVelocity.y = 210;
			
			player.addAnimation("normal", [7]);
			player.addAnimation("run", [ 3 , 4 , 5 ], 10);
			player.addAnimation("pulo", [4]);
			
			add(player);
			
			
		}
		
		
		public function updatePlayer(): void
		{
			wrap(player);
			
			//movimentacao
			player.acceleration.x = 0;
			
			
			
			if (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("A")) 
			{
				player.facing = FlxObject.LEFT;
				player.acceleration.x -= player.drag.x;
			}
			else if (FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("D")) 
			{
				player.facing = FlxObject.RIGHT;
				player.acceleration.x += player.drag.x;
			}
			
			if ((FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W")) && player.velocity.y == 0) {
				player.y -= 1;
				player.velocity.y = - 200;
			}
			
			//animacao
			if (player.velocity.y != 0)
			{
				player.play("pulo");
			}
			else if (player.velocity.x == 0) 
			{
				player.play("normal");
			}
			else
			{
				player.play("run");
			}
			
		}
		
		public function wrap( obj : FlxObject) : void
		{
			obj.x = (obj.x + obj.width / 2 + FlxG.width) % FlxG.width - obj.width / 2;
			obj.y = (obj.y + obj.height / 2) % FlxG.height - obj.height / 2;
			
		}
		
	}

}