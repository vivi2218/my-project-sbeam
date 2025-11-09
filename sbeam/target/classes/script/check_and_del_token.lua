-- check_and_del_token.lua
-- 原子判断 + 删除 token（安全版，校验 value,兼容 JSON 序列化）
-- RedisTemplate<String, Object> 用 JSON 序列化会导致多一层引号
-- 如果 key 的值等于传入的 value，则删除并返回 1，否则返回 0
local val = redis.call('get', KEYS[1])
if val then
    -- 去掉两边的引号
    val = string.gsub(val, '^"(.*)"$', '%1')
end

if val == ARGV[1] then
    redis.call('del', KEYS[1])
    return 1
else
    return 0
end