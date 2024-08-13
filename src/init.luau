--!native
--!optimize 2
--!strict

local GlobalRandomizer = Random.new()
return function <T> (array: T & {}, seed: (number | Random)?): T
	local Randomizer = 
		if typeof(seed) == "Random" then seed 
		elseif type(seed) == "number" then Random.new(seed)
		else GlobalRandomizer
	local size, x32 = #array, 2^32
	local result = table.create(size)
	local r3 = math.ceil(size / 3) -- three ratio size
	local split = Randomizer:NextInteger(r3, (r3 + (r3 * 1.5)) // 1)
	table.move(array, split, size, 1, result)
	table.move(array, 1, split - 1, size + 1 - split + 1, result)
	local snr3, r3o1 = size - r3, r3 + 1 -- snr3 = 2/3, r3o1 = r3 offset 1
	local y = size
	local r = Randomizer:NextInteger(0, x32 - 1) -- state
	for x = 1, r3 do
		--r = (r * 1103515245 + 12345) % 2^31 -- glibc (used by GCC)
		r = (r * 0x6C078965 + 0x3039) % x32 -- The WELL (Well Equidistributed Long-period Linear)
		y = (r % snr3) + r3o1
		result[x], result[y] = result[y], result[x]
	end
	return result :: any
end