
-- Save table to file
function mymonths.save_table()

	local data = mymonths
	local f, err = io.open(minetest.get_worldpath() .. "/mymonths_data", "w")

	if err then
		return err
	end

	f:write(minetest.serialize(data))
	f:close()
end

-- Reads saved file
function mymonths.read_mymonths()

	local f, err = io.open(minetest.get_worldpath() .. "/mymonths_data", "r")
	local data = minetest.deserialize(f:read("*a"))

	f:close()

	return data
end

-- Saves the table every 10 seconds
local tmr = 0

minetest.register_globalstep(function(dtime)

	tmr = tmr + dtime

	if tmr >= 10 then

		tmr = 0

		mymonths.save_table()
	end
end)

-- Check to see if file exists and if not sets default values.
local f, err = io.open(minetest.get_worldpath().."/mymonths_data", "r")

if f == nil then

	mymonths.day_counter = 1
	mymonths.month_counter = 6
	mymonths.month = "June"
	mymonths.weather = "clear"
	mymonths.day_name = "Monday"
else
	mymonths.day_counter = mymonths.read_mymonths().day_counter
	mymonths.month_counter = mymonths.read_mymonths().month_counter
	mymonths.month = mymonths.read_mymonths().month
	mymonths.weather = mymonths.read_mymonths().weather
	mymonths.day_name = mymonths.read_mymonths().day_name
end
