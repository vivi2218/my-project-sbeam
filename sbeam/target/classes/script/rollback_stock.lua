-- rollback_stock.lua
-- KEYS[1]: 库存key，例如 game:stock:1
-- ARGV[1]: 回滚数量

local val = redis.call('get', KEYS[1])
if val then
    val = string.gsub(val, '^"(.*)"$', '%1')
end

local stock = tonumber(val) or 0
local rollback = tonumber(ARGV[1])
if rollback <= 0 then
    return 0
end

redis.call('set', KEYS[1], stock + rollback)
return 1
