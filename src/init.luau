--!native
--!optimize 2
--!strict

local globalRandomizer = Random.new()

return function <T> (array: T & {}, seed: (number | Random)?): T
	local randomizer = 
		if typeof(seed) == "Random" then seed 
		elseif type(seed) == "number" then Random.new(seed)
		else globalRandomizer
	
	local size, x26 = #array, 2^26 -- x26 is a maximum array element in one table
	local result = table.create(size)
	local r3 = math.ceil(size / 3) -- three ratio size
	local split = randomizer:NextInteger(r3, (r3 + (r3 * 1.5)) // 1)
	table.move(array, split, size, 1, result)
	table.move(array, 1, split - 1, size + 1 - split + 1, result)
	local y = 0
	local r = randomizer:NextInteger(0, x26^2) -- state (x52)

	for x = 1, size, 3 do
		-- (x: [1, x26]) * x26 + (x26^2) = x53
		y = ((x * x26 + r) % size) + 1
		result[x], result[y] = result[y], result[x]
	end

	return result :: any
end
