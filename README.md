# FastShuffle

A table shuffle module, with designed to be fast in roblox luau.

## Note

- This module is best for use-case, where you have million of element in the array.
and not strict to the low quality of randomness.
- This module always give new address table when executed,
unlike roblox [Random.new():Shuffle()](https://create.roblox.com/docs/reference/engine/datatypes/Random#Shuffle)

# Exmaple

## import FastShuffle module
```lua
local FastShuffle = require(script.FastShuffle)
```

## sample ArrayOfNumbers 1M Elements
```lua
local ArrayOfNumbers = {}
for Index = 1, 100_000 do
    ArrayOfNumbers[Index] = Index
end
```

## FastShuffle(array: T & {}, seed: (number | Random)?) -> T
```lua
-- Shuffle with default random
local Shuffled_1 = FastShuffle(ArrayOfNumbers) 
-- Shuffle with custom random
local Shuffled_2 = FastShuffle(ArrayOfNumbers, 12345)
local Shuffled_3 = FastShuffle(ArrayOfNumbers, Random.new(12345))
```

# Benchmark
```lua
local function Benchmark(TestFunction: () -> (), SymbolFunction: string, Simulation: number): number
    local elapsed = os.clock()
    for _ = 1, Simulation do
        TestFunction()
    end
    print(`@{SymbolFunction}, took: {os.clock() - elapsed}s`)
    return elapsed
end

local Randomizer = Random.new()
local RobloxShuffle = Randomizer.Shuffle

-- RobloxShuffle // Random.new():Shuffle()
Benchmark(function()
    RobloxShuffle(Randomizer, ArrayOfNumbers)
end, "RobloxShuffle", 10) -- @RobloxShuffle, took: 0.014617400000133784s

-- FastShuffle
Benchmark(function()
    FastShuffle(ArrayOfNumbers)
end, "FastShuffler", 10) -- @FastShuffler, took: 0.006270200000017212s
```
