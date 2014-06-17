package
{
	import flash.display.Sprite;

	public class ErossNode extends Sprite
	{
		public static var numbers:int = 0;
		private var type:int;
		private var curType:int;
		public var N:int = 4;
		private var r:int = 20;
		private var c:uint;
		public var curArr:Array;
		private var arr1:Array = 
		[
		[[0,1,0,0],
		 [0,1,0,0],
		 [0,1,0,0],
		 [0,1,0,0]],
		 
		[[0,0,0,0],
		 [1,1,1,1],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[0,1,0,0],
		 [0,1,0,0],
		 [0,1,0,0],
		 [0,1,0,0]],
		 
		[[0,0,0,0],
		 [1,1,1,1],
		 [0,0,0,0],
		 [0,0,0,0]]
		];
		 
		private var arr2:Array = 
		[
		[[0,1,0,0],
		 [0,1,0,0],
		 [0,1,1,0],
		 [0,0,0,0]],
		 
		[[0,0,1,0],
		 [1,1,1,0],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[1,1,0,0],
		 [0,1,0,0],
		 [0,1,0,0],
		 [0,0,0,0]],
		 
		[[0,0,0,0],
		 [1,1,1,0],
		 [1,0,0,0],
		 [0,0,0,0]]
		];
		
		private var arr3:Array = 
		[
		[[0,1,0,0],
		 [0,1,0,0],
		 [1,1,0,0],
		 [0,0,0,0]],
		 
		[[0,0,0,0],
		 [1,1,1,0],
		 [0,0,1,0],
		 [0,0,0,0]],
		 
		[[0,1,1,0],
		 [0,1,0,0],
		 [0,1,0,0],
		 [0,0,0,0]],
		 
		[[1,0,0,0],
		 [1,1,1,0],
		 [0,0,0,0],
		 [0,0,0,0]]
		];
		
		private var arr4:Array = 
		[
		[[1,1,0,0],
		 [0,1,1,0],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[0,0,1,0],
		 [0,1,1,0],
		 [0,1,0,0],
		 [0,0,0,0]],
		 
		[[1,1,0,0],
		 [0,1,1,0],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[0,0,1,0],
		 [0,1,1,0],
		 [0,1,0,0],
		 [0,0,0,0]]
		];
		
		private var arr5:Array = 
		[
		[[0,0,1,1],
		 [0,1,1,0],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[0,1,0,0],
		 [0,1,1,0],
		 [0,0,1,0],
		 [0,0,0,0]],
		 
		[[0,0,1,1],
		 [0,1,1,0],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[0,1,0,0],
		 [0,1,1,0],
		 [0,0,1,0],
		 [0,0,0,0]]
		];
		
		private var arr6:Array = 
		[
		[[0,1,0,0],
		 [1,1,1,0],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[0,1,0,0],
		 [1,1,0,0],
		 [0,1,0,0],
		 [0,0,0,0]],
		 
		[[0,0,0,0],
		 [1,1,1,0],
		 [0,1,0,0],
		 [0,0,0,0]],
		 
		[[0,1,0,0],
		 [0,1,1,0],
		 [0,1,0,0],
		 [0,0,0,0]]
		];
		
		private var arr7:Array = 
		[
		[[1,1,0,0],
		 [1,1,0,0],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[1,1,0,0],
		 [1,1,0,0],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[1,1,0,0],
		 [1,1,0,0],
		 [0,0,0,0],
		 [0,0,0,0]],
		 
		[[1,1,0,0],
		 [1,1,0,0],
		 [0,0,0,0],
		 [0,0,0,0]]
		];
		
		private var blocksArr:Array = [arr1,arr2,arr3,arr4,arr5,arr6,arr7];
		
		public function ErossNode(_type:int,_c:uint = 0x000000)
		{
			this.type = _type;
			this.c = _c;
			init();
		}
		
		public function init():void
		{
			curType = 0;
			curArr = blocksArr[type][curType];
			update();
		}
		
		public function update():void
		{
			this.graphics.clear();
			this.graphics.beginFill(c);
			for(var i:int = 0; i < 4; i++)
			{
				for(var j:int = 0; j < 4; ++j)
				{
					if(curArr[i][j])
					this.graphics.drawRect(j*r,i*r,r,r);
				}
			}
			this.graphics.endFill();
		}
		
		public function getNextArr():Array
		{
			return blocksArr[type][(curType + 1) % curArr.length];
		}
		
		public function changeState():void
		{
			this.curType = (this.curType + 1) % arr1.length;
			curArr = blocksArr[type][curType];
			update();
		}
	}
}