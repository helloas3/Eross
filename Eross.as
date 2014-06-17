package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class Eross extends Sprite
	{
		private var board:Array;
		private var wid:int = 10;
		private var hig:int = 24;
		private var r:int = 20;
		private var node:ErossNode;
		private var centerX:int = (stage.stageWidth - wid*r) / 2;
		private var centerY:int = (stage.stageHeight - hig*r) / 2;
		private var curX:int;
		private var curY:int;
		
		private var curNode:ErossNode;
		private var nexNode:ErossNode;
		
		private var timer:Timer;
		
		private var nextBoard:Sprite;
		
		public function Eross()
		{
			init();
		}
		
		
		public function init():void
		{
			board = new Array();
			
			nextBoard = new Sprite();
			this.addChild(nextBoard);
			nextBoard.graphics.lineStyle(0x000000);
			nextBoard.graphics.beginFill(0xffffff);
			nextBoard.graphics.drawRect(0,0,r*4,r*4);
			
			nextBoard.x = stage.stageWidth - centerX + r/2;
			nextBoard.y = centerY;
			
			for(var i:int = 0; i < hig; ++i)
			 board[i] = new Array();
			
			for(i = 0; i < hig; ++i)
				for(var j:int = 0; j < wid; ++j)
					board[i][j] = 0;
			
			update();
			
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onMove);
		}
		
		public function onMove(e:KeyboardEvent):void
		{
			if(curNode == null)
			return;
			
			switch(e.keyCode)
			{
				case Keyboard.RIGHT:
				{
					if(!checkRight())
					return;
					
					curX += 1;
					curNode.x += r;
					break;
				}
				case Keyboard.LEFT:
				{
					if(!checkLeft())
					return;
					
					curX -= 1;
					curNode.x -= r;
					break;
				}
				case Keyboard.UP:
				{
					if(!checkUp())
					return;
					
					curNode.changeState();
					break;
				}
				case Keyboard.DOWN:
				{
					if(!checkDown())
					return;
					
					curY++;
					curNode.y += r;
					break;
				}
				default:break;
			}
		}
		
		
		public function checkRight():Boolean
		{
			var tempX:int = curX + 1;
			var tempY:int = curY;
			for(var i:int = 0; i < curNode.N; ++i)
			{
				for(var j:int = 0; j < curNode.N; ++j)
				{
					if(curNode.curArr[i][j] && tempX + j >= wid)
					return false;
					if(curNode.curArr[i][j] && board[tempY+i][tempX+j])
					return false;
				}
			}
			return true;
		}
		
		public function checkLeft():Boolean
		{
			var tempX:int = curX - 1;
			var tempY:int = curY;
			for(var i:int = 0; i < curNode.N; ++i)
			{
				for(var j:int = 0; j < curNode.N; ++j)
				{
					if(curNode.curArr[i][j] && tempX + j <0)
					return false;
					if(curNode.curArr[i][j] && board[tempY+i][tempX+j])
					return false;
				}
			}
			return true;
		}
		
		public function checkUp():Boolean
		{
			var tempX:int = curX;
			var tempY:int = curY;
			var arr:Array = curNode.getNextArr();
			
			for(var i:int = 0; i < curNode.N; ++i)
			{
				for(var j:int = 0; j < curNode.N; ++j)
				{
					if(arr[i][j] && (tempX + j < 0 || tempX + j >= wid))
					   return false;
					if(arr[i][j] && board[tempY+i][tempX+j])
						return false;
				}
			}
			return true;
		}
		
		public function checkDown():Boolean
		{
			var tempX:int = curX;
			var tempY:int = curY + 1;
			
			for(var i:int = 0; i < curNode.N; ++i)
			{
				for(var j:int = 0; j < curNode.N; ++j)
				{
					if(curNode.curArr[i][j] && tempY + i >= hig)
					{
						finish();
						return false;
					}
					if(curNode.curArr[i][j] && board[tempY + i][tempX + j])
					{
						finish();
						return false;
					}
				}
			}
			return true;
		}
		
		public function finish():void
		{
			for(var i:int = 0; i < curNode.N; ++i)
			{
				for(var j:int = 0; j < curNode.N; ++j)
				{
					if(curNode.curArr[i][j])
					{
						board[curY + i][curX + j] = 1;
					}
				}
			}
			
			removeLines();
			stage.removeChild(curNode);
			curNode = null;
			createNode();
			update();
		}
		
		
		
		public function removeLines():void
		{
			for(var i:int = hig - 1; i >=0; --i)
			{
				var ok:Boolean = true;
				for(var j:int = 0; j < wid; ++j)
				{
					if(board[i][j] != 1)
					{
						ok = false;
						break;
					}
				}
				if(ok)
				{
					for(var k:int = 0; k < wid; ++k)
						board[0][k] = 0;
					for(k = i; k >= 1; k--)
					{
						for(j = 0; j < wid; ++j)
						{
							board[k][j] = board[k-1][j];
						}
					}
					i++;
				}
			}
		}		
		
		public function onTimer(e:TimerEvent):void
		{
			if(curNode == null)
			createNode();
			else
			{
				if(!checkDown())
				return;
				
				curNode.y += r;
				curY++;
				return;
			}
		}
		
		public function createNode():void
		{	
			curX = 3;
			curY = 0;
			if(!nexNode)
			{
				curNode = new ErossNode(int(Math.random()*7));
				curNode.x = centerX + curX * r;
				curNode.y = centerY + curY * r;
				stage.addChild(curNode);
			}
			else
			{
				curNode = nexNode;
				nextBoard.removeChild(nexNode);
				curNode.x = centerX + curX * r;
				curNode.y = centerY + curY * r;
				stage.addChild(curNode);
			}
			
			nexNode = new ErossNode(int(Math.random()*7));
			nextBoard.addChild(nexNode);
		}
		
		public function update():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(0x000000);
			for(var i:int = 0; i < hig; ++i)
			{
				for(var j:int = 0; j < wid; ++j)
				{
					if(board[i][j] == 0)
					{
						this.graphics.beginFill(0xffffff)
					}
					else if(board[i][j] == 1)
					{
						this.graphics.beginFill(0x111111);
					}
					this.graphics.drawRect(centerX+j*r,centerY + i*r,r,r);
				}
			}
			this.graphics.endFill();
		}
	}
}