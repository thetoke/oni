package oni.components.weather 
{
	import flash.utils.getQualifiedClassName;
	import oni.components.weather.entities.Clouds;
	import oni.components.weather.entities.Haze;
	import oni.core.ISerializable;
	import oni.core.Scene;
	import oni.entities.environment.StaticTexture;
	import oni.Oni;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author Sam Hellawell
	 */
	public class WeatherSystem extends EventDispatcher implements ISerializable
	{
		private var _clouds:Array;
		
		private var _haze:Haze;
		
		private var _scene:Scene;
		
		private var _params:Object;
		
		public function WeatherSystem(scene:Scene, params:Object) 
		{
			//Set parameters
			_params = params;
			
			//Set scene
			var i:uint;
			_scene = scene;
			
			//Check if we want clouds
			if (params.clouds != null && params.clouds is Array)
			{
				//Add the clouds!
				_clouds = new Array();
				for (i = 0; i < params.clouds.length; i++)
				{
					_clouds.push(new Clouds(params.clouds[i]));
				}
			}
			
			//Check if we want haze
			if (params.haze != null)
			{
				//Create
				_haze = new Haze(params.haze);
				if (params.haze.enabled != null) _haze.enabled = params.haze.enabled;
			}
			
			//Listen for events
			addEventListener(Oni.COMPONENT_ADDED, _onAdded);
			addEventListener(Oni.COMPONENT_REMOVED, _onRemoved);
		}
		
		private function _onAdded(e:Event):void
		{
			//Add clouds
			if (_clouds != null)
			{
				for (var i:uint = 0; i < _clouds.length; i++)
				{
					_scene.addEntity(_clouds[i]);
				}
			}
			
			//Add haze
			if (_haze != null) _scene.addEntity(_haze);
		}
		
		private function _onRemoved(e:Event):void
		{
			//Remove clouds
			if (_clouds != null)
			{
				for (var i:uint = 0; i < _clouds.length; i++)
				{
					_scene.removeEntity(_clouds[i]);
				}
			}
			
			//Add haze
			if (_haze != null) _scene.removeEntity(_haze);
		}
		
		public function get haze():Haze
		{
			return _haze;
		}
		
		public function get clouds():Array
		{
			return _clouds;
		}
		
		public function serialize():Object
		{
			return {
				className: getQualifiedClassName(this),
				params: _params
			};
		}
		
	}

}