package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sbeam.sbeam.entity.UserGameLibrary;
import com.sbeam.sbeam.entity.VO.GameLibraryVO;
import com.sbeam.sbeam.mapper.UserGameLibraryMapper;
import com.sbeam.sbeam.service.IUserGameLibraryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class UserGameLibraryServiceImpl extends ServiceImpl<UserGameLibraryMapper, UserGameLibrary> implements IUserGameLibraryService {
    @Autowired
    private UserGameLibraryMapper userGameLibraryMapper;
    @Override
    public List<GameLibraryVO> getUserLibrary(Integer userId) {
        return userGameLibraryMapper.selectUserLibrary(userId);
    }

    @Override
    public boolean addOrUpdateGame(Integer userId, Integer gameId, String source) {
        QueryWrapper<UserGameLibrary> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id",userId).eq("game_id",gameId);
        UserGameLibrary existing = userGameLibraryMapper.selectOne(wrapper);
        if(existing !=null){
            //如果存在但被逻辑删除,恢复
            if(existing.getStatus() == 1){
                existing.setStatus(0);
                userGameLibraryMapper.updateById(existing);
                return true;
            }
            return false;//存在了,有效,不重复插入
        }
        //不存在则新增
        UserGameLibrary newRecord = new UserGameLibrary();
        newRecord.setUserId(userId);
        newRecord.setGameId(gameId);
        newRecord.setSource(source);
        newRecord.setStatus(0);
        newRecord.setVersion(1);
        userGameLibraryMapper.insert(newRecord);
        return true;
    }

    @Override
    public boolean removeGameFromLibrary(Integer userId, Integer gameId) {
        QueryWrapper<UserGameLibrary> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id",userId).eq("game_id",gameId);
        UserGameLibrary existing = userGameLibraryMapper.selectOne(wrapper);
        if(existing !=null && existing.getStatus() == 0){
            //如果存在但被逻辑删除,恢复
                existing.setStatus(1);//1表示删除
                userGameLibraryMapper.updateById(existing);
                return true;
        }
        return false;
    }

//    @Autowired
//    private RedisTemplate redisTemplate;
//    @Autowired
//    private UserGameLibraryMapper userGameLibraryMapper;
//
//    // Redis缓存键前缀
//    private static final String USER_GAME_LIBRARY_KEY = "user:game:library:";
//    @Override
//    public List<Integer> getUserGameLibrary(Integer userId) {
//        // 先从Redis查询
//        String key = USER_GAME_LIBRARY_KEY + userId;
//        Set<Object> gameIdSet = redisTemplate.opsForSet().members(key);
//
//        if (gameIdSet != null && !gameIdSet.isEmpty()) {
//            return gameIdSet.stream()
//                    .map(id -> Integer.parseInt(id.toString()))
//                    .collect(Collectors.toList());
//        }
//
//        // Redis没有则从数据库查询
//        QueryWrapper<UserGameLibrary> wrapper =new QueryWrapper<>();
//        wrapper.eq("user_id",userId);
//        List<UserGameLibrary> userGameLibraryList = userGameLibraryMapper.selectList(wrapper);
//        // 提取游戏ID列表
//        List<Integer> gameIdList = userGameLibraryList.stream()
//                .map(UserGameLibrary::getGameId)
//                .collect(Collectors.toList());
//        // 存入Redis，设置过期时间
//
//        if(!gameIdList.isEmpty()){
//            // 遍历List，将每个Integer转为String后存入Redis集合
//            for (Integer gameId : gameIdList) {
//                redisTemplate.opsForSet().add(key, String.valueOf(gameId));//.toString
//            }
//            redisTemplate.expire(key,1, TimeUnit.HOURS);
//        }
//        return gameIdList;
//    }
//
//    @Override
//    public boolean addGameToLibrary(Integer userId, Integer gameId, String source) {
//        //先检查是否已存在该游戏
//        if(hasGame(userId,gameId))
//            return true;//已存在,返回成功
//        //向数据库中添加记录
//        UserGameLibrary userGameLibrary = new UserGameLibrary();
//        userGameLibrary.setUserId(userId);
//        userGameLibrary.setGameId(gameId);
//        userGameLibrary.setSource(source);
//        userGameLibrary.setStatus(0);
//        userGameLibrary.setVersion(1);
//        userGameLibrary.setCreatedAt(LocalDateTime.now());
//        int rows = userGameLibraryMapper.insert(userGameLibrary);
//        // 如果数据库添加成功，同步更新Redis
//        if(rows > 0){
//            String key = USER_GAME_LIBRARY_KEY + userId;
//            redisTemplate.opsForSet().add(key, String.valueOf(gameId));
//            redisTemplate.expire(key, 1, TimeUnit.HOURS);
//            return true;
//        }
//        return false;
//    }
//
//    @Override
//    public boolean removeGameFromLibrary(Integer userId, Integer gameId) {
//        // 先检查是否存在该游戏
//        if (!hasGame(userId, gameId)) {
//            return true; // 不存在，返回成功
//        }
//
//        // 数据库删除记录
//        QueryWrapper<UserGameLibrary> wrapper = new QueryWrapper<>();
//        wrapper.eq("user_id", userId)
//                .eq("game_id", gameId);
//        int rows = userGameLibraryMapper.delete(wrapper);
//
//        // 如果数据库删除成功，同步更新Redis
//        if (rows > 0) {
//            String key = USER_GAME_LIBRARY_KEY + userId;
//            redisTemplate.opsForSet().remove(key, String.valueOf(gameId));
//            return true;
//        }
//        return false;
//    }
//
//    @Override
//    public boolean hasGame(Integer userId, Integer gameId) {
//
//        String key = USER_GAME_LIBRARY_KEY + userId;
//
//        // 先从Redis检查
//        Boolean isMember = redisTemplate.opsForSet().isMember(key, String.valueOf(gameId));
//        if (isMember != null && isMember) {
//            return true;
//        }
//
//        // Redis没有则从数据库检查
//        QueryWrapper<UserGameLibrary> wrapper = new QueryWrapper<>();
//        wrapper.eq("user_id", userId)
//                .eq("game_id", gameId);
//        Long count = userGameLibraryMapper.selectCount(wrapper);
//
//        // 如果数据库存在，同步到Redis
//        if (count != null && count > 0) {
//            redisTemplate.opsForSet().add(key, String.valueOf(gameId));
//            redisTemplate.expire(key, 1, TimeUnit.HOURS);
//            return true;
//        }return false;
//    }
}
