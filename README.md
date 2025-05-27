# fastShuffle

A table shuffle module, with designed to be fast in roblox luau.

## Note

- This module is best for use-case, where you have million of element in the array.
and not strict to the low quality of randomness.
- This module always give new address table when executed,
unlike roblox [Random.new():Shuffle()](https://create.roblox.com/docs/reference/engine/datatypes/Random#Shuffle)

# Exmaple

## import fastShuffle module
```lua
local fastShuffle = require(script.fastShuffle)
```

## sample ArrayOfNumbers 100k Elements
```lua
local arrayOfNumbers = {}
for index = 1, 100_000 do
    arrayOfNumbers[Index] = Index
end
```

## fastShuffle(array: T & {}, seed: (number | Random)?) -> T
```lua
-- Shuffle with default random
local shuffled_1 = fastShuffle(ArrayOfNumbers) 
-- Shuffle with custom random
local shuffled_2 = fastShuffle(ArrayOfNumbers, 12345)
local shuffled_3 = fastShuffle(ArrayOfNumbers, Random.new(12345))
```

# Benchmark
```lua
local function benchmark(TestFunction: () -> (), SymbolFunction: string, Simulation: number): number
    local elapsed = os.clock()
    for _ = 1, Simulation do
        TestFunction()
    end
    print(`@{SymbolFunction}, took: {os.clock() - elapsed}s`)
    return elapsed
end

local randomizer = Random.new()
local robloxShuffle = randomizer.Shuffle

-- RobloxShuffle // Random.new():Shuffle()
benchmark(function()
    robloxShuffle(randomizer, ArrayOfNumbers)
end, "RobloxShuffle", 10) -- @RobloxShuffle, took: 0.014617400000133784s

-- fastShuffle
benchmark(function()
    fastShuffle(ArrayOfNumbers)
end, "fastShuffler", 10) -- @fastShuffler, took: 0.006270200000017212s
```
