/// @desc

enum InputIndex
{
	right, up, left, down,
	fire, focus, credit,
	
	_size
}

function InputManager() constructor
{
	inputcount = InputIndex._size;
	inputkey = array_create(InputIndex._size);
	inputpad = array_create(InputIndex._size);
	
	for (var i = 0; i < inputcount; i++)
	{
		inputkey[i] = [];
		inputpad[i] = [];
	}
	
	device = -1;
	
	ipressed = 0;
	iheld = 0;
	ireleased = 0;
	
	sensitivity = 0.5;
	
	/// @arg input_index,key1,key2,...
	function DefineKey()
	{
		for (var i = 1; i < argument_count; i++)
		{
			array_push(inputkey[argument[0]], is_string(argument[i])? ord(string_upper(argument[i])): argument[i] );
		}
	}
	
	/// @arg input_index,pad1,pad2,...
	function DefinePad()
	{
		for (var i = 1; i < argument_count; i++)
		{
			array_push(inputpad[argument[0]], argument[i]);
		}
	}
	
	function Update()
	{
		var lastheld = iheld;
		iheld = 0;
		
		var b;
		for (var i = 0; i < inputcount; i++)
		{
			b = inputkey[i];
			for (var j = 0; j < array_length(b); j++)
			{
				iheld |= (1 << i) * keyboard_check(b[j]);
			}
			
			if (HasDevice())
			{
				var axis;
				axis = gamepad_axis_value(device, gp_axislh);
				iheld |= (
					( (1 << InputIndex.right) * (axis>sensitivity) ) | 
					( (1 << InputIndex.left) * (axis<-sensitivity) )
					);
				
				axis = gamepad_axis_value(device, gp_axislv);
				iheld |= (
					( (1 << InputIndex.down) * (axis>sensitivity) ) | 
					( (1 << InputIndex.up) * (axis<-sensitivity) )
					);
				
				b = inputpad[i];
				for (var j = 0; j < array_length(b); j++)
				{
					iheld |= (1 << i) * gamepad_button_check(device, b[j]);
				}
			}
			
		}
		
		ipressed = ~lastheld & iheld;
		ireleased = lastheld & ~iheld;
	}
	
	function IPressed(input_index) {return ( (1 << input_index) & ipressed ) != 0;}
	function IHeld(input_index) {return ( (1 << input_index) & iheld ) != 0;}
	function IReleased(input_index) {return ( (1 << input_index) & ireleased ) != 0;}
	
	function ILevPressed(positive_index, negative_index) {return (IPressed(positive_index)?1:0)-(IPressed(negative_index)?1:0);}
	function ILevHeld(positive_index, negative_index) {return (IHeld(positive_index)?1:0)-(IHeld(negative_index)?1:0);}
	function ILevReleased(positive_index, negative_index) {return (IReleased(positive_index)?1:0)-(IReleased(negative_index)?1:0);}
	
	function IAnyPressed() {return ipressed != 0;}
	
	function PollDevice()
	{
		if (device == -1)
		{
			for (var i = 0; i < 32; i++)
			{
				if (gamepad_button_check_pressed(i, gp_face1))
				{
					device = i;
					return true;
				}
			}
			
			return false;
		}
		
		return true;
	}
	
	function GetDevice() {return device;}
	function HasDevice() {return device != -1;}
}