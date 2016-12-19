
--Sets the privs for changing settings
minetest.register_privilege("mymonths", {
	description = "Change the weather and date",
	give_to_singleplayer = false
})

-- Set weather
if mymonths.use_weather == true then

minetest.register_chatcommand("setweather", {
	params = "<mymonths>",
	description = "Set weather to rain, snow, wind or clear",
	privs = {mymonths = true},

	func = function(name, param)

		if param == "rain"
		or param == "storm"
		or param == "snow"
		or param == "snowstorm"
		or param == "sandstorm"
		or param == "hail"
		or param == "clear" then

			mymonths.weather = param
			mymonths.save_table()
		else
			minetest.chat_send_player(name,
				"invalid input - use rain, storm, snow, snowstorm, sandstorm, hail or clear.")
			return
		end
	end
})

end -- END IF

--Set month
minetest.register_chatcommand("setmonth", {
	params = "",
	description = "Set the month. Use the number 1-12 or the name",
	privs = {mymonths = true},

	func = function(name, param)

		if param == "1"
		or param == "January"
		or param == "january"
		or param == "jan" then

			mymonths.month = "January"
			mymonths.month_counter = 1
			minetest.chat_send_player(name," Month has been changed to January")

		elseif param == "2"
		or param == "February"
		or param == "february"
		or param == "feb" then

			mymonths.month = "Febuary"
			mymonths.month_counter = 2
			minetest.chat_send_player(name, "Month has been changed to Febuary")

		elseif param == "3"
		or param == "March"
		or param == "march"
		or param == "mar" then

			mymonths.month = "March"
			mymonths.month_counter = 3
			minetest.chat_send_player(name, "Month has been changed to March")

		elseif param == "4"
		or param == "April"
		or param == "april"
		or param == "apr" then

			mymonths.month = "April"
			mymonths.month_counter = 4
			minetest.chat_send_player(name, "Month has been changed to April")

		elseif param == "5"
		or param == "May"
		or param == "may" then

			mymonths.month = "May"
			mymonths.month_counter = 5
			minetest.chat_send_player(name, "Month has been changed to May")

		elseif param == "6"
		or param == "June"
		or param == "june"
		or param == "jun" then

			mymonths.month = "June"
			mymonths.month_counter = 6
			minetest.chat_send_player(name, "Month has been changed to June")

		elseif param == "7"
		or param == "July"
		or param == "july"
		or param == "jul" then

			mymonths.month = "July"
			mymonths.month_counter = 7
			minetest.chat_send_player(name, "Month has been changed to July")

		elseif param == "8"
		or param == "August"
		or param == "august"
		or param == "aug" then

			mymonths.month = "Augest"
			mymonths.month_counter = 8
			minetest.chat_send_player(name, "Month has been changed to August")

		elseif param == "9"
		or param == "September"
		or param == "september"
		or param == "sep" then

			mymonths.month = "September"
			mymonths.month_counter = 9
			minetest.chat_send_player(name, "Month has been changed to September")

		elseif param == "10"
		or param == "October"
		or param == "october"
		or param == "oct" then

			mymonths.month = "October"
			mymonths.month_counter = 10
			minetest.chat_send_player(name, "Month has been changed to October")

		elseif param == "11"
		or param == "November"
		or param == "november"
		or param == "nov" then

			mymonths.month = "November"
			mymonths.month_counter = 11
			minetest.chat_send_player(name, "Month has been changed to November")

		elseif param == "12"
		or param == "December"
		or param == "december"
		or param == "dec"then

			mymonths.month = "December"
			mymonths.month_counter = 12
			minetest.chat_send_player(name, "Month has been changed to December")

		else
			minetest.chat_send_player(name, "invalid input")
			return
		end

		mymonths.save_table()
	end
})

--Set Days
minetest.register_chatcommand("setday", {
	params = "",
	description = "Set the day of the month",
	privs = {mymonths = true},

	func = function(name, param)

		local d = tonumber(param)

		if d then
			for day = 1, 14 do

				if tonumber(param) >= 15 then
					return
				end

				if tonumber(param) == day then
					mymonths.day_counter = tonumber(day)
				end
			end
		end
	end
})

--Weather
if mymonths.use_weather == true then

minetest.register_chatcommand("weather", {
	params = "",
	description = "Tells player the weather",

	func = function(name, param)

		minetest.chat_send_player(name,"The weather is " .. mymonths.weather2)
	end
})

end -- END IF

--Time and Date
minetest.register_chatcommand("date", {
	params = "",
	description = "Say the date in chat",

	func = function(name, param)

		local t = tostring(minetest.get_timeofday() * 2400)
		local tt = string.find(t, "%p",1)

		tt = tt or "0" -- if nil then force value

		local th = string.sub(t, tt-4,tt-3)
		local tm = string.sub(t, tt-2,tt-1)
		local m = (tm/100)*60
		local mx = m+1000
		local my = ".00"
		local mz = mx..my
		local mf = string.find(mz, "%p",1)
		local mi = string.sub(mx,mf-2,mf-1) 
		local ampm = "am"

		th = th or 0 -- if nil then force value

		if tonumber(th..tm) >= 1201
		and tonumber(th) <= 2400 then

			ampm = "pm"

			th = th - 12

			if th == 0 then
				th = 12
			end
		else
			ampm = "am"

			if th == 0
			or th == "" then
				th = 12
			end
		end

		minetest.chat_send_player(name, "The time is " ..th.. ":"
			.. mi .. " " .. ampm .. " on " .. mymonths.day_name
			.. " " .. mymonths.month .. " " .. mymonths.day_counter)
	end
})

--Gives list of holidays
minetest.register_chatcommand("holidays", {
	params = "",
	description = "Say the date in chat",

	func = function(name, param)

		minetest.chat_send_player(name, "New Years Day - January 1")
		minetest.chat_send_player(name, "Friendship Day - March 12")
		minetest.chat_send_player(name, "Miners Day - April 10")
		minetest.chat_send_player(name, "Minetest Day - June 5")
		minetest.chat_send_player(name, "Builders Day - Augest 12")
		minetest.chat_send_player(name, "Harvest Day - October 8")
		minetest.chat_send_player(name, "New Years Eve - December 14")
	end
})
