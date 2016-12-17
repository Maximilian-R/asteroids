package commands {
	import core.Entity;
	
	public interface Command {
		function execute(player:Entity):void;
	}
}