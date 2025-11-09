-- decr_stock.lua
-- KEYS[1]: 库存key，例如 game:stock:1
-- ARGV[1]: 扣减数量

local val = redis.call('get', KEYS[1])
if val then
    val = string.gsub(val, '^"(.*)"$', '%1')
end

local stock = tonumber(val)
if not stock then
    return -1  -- key 不存在
end

local decr = tonumber(ARGV[1])
if stock < decr then
    return 0  -- 库存不足
end

redis.call('set', KEYS[1], stock - decr)
return 1  -- 扣减成功
