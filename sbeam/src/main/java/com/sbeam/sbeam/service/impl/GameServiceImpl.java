package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.query.QueryChainWrapper;
import com.sbeam.sbeam.entity.*;
import com.sbeam.sbeam.entity.VO.*;
import com.sbeam.sbeam.mapper.*;
import com.sbeam.sbeam.service.IGameService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class GameServiceImpl extends ServiceImpl<GameMapper, Game> implements IGameService {
    @Autowired
    private GameMapper gameMapper;
    @Autowired
    private GameProfileMapper gameProfileMapper;
    @Autowired
    private GameBundleMapper gameBundleMapper;
    @Autowired
    private GamePriceHistoryMapper gamePriceHistoryMapper;
    @Autowired
    private GameImagesMapper gameImagesMapper;
    @Autowired
    private GameAchievementMapper gameAchievementMapper;
    @Autowired
    private UserFollowMapper userFollowMapper;

    /**
     * 获取游戏详情
     *
     * @param gameId
     * @param userId
     * @return
     */
    @Override
    public GameDetailVO getGameDetails(Integer gameId, Integer userId) {

        GameDetailVO gameDetailVO = new GameDetailVO();
        //获取游戏基本信息
        Game game = gameMapper.selectById(gameId);
        if (game == null) {
            throw new RuntimeException("未找到该游戏");
        }
        gameDetailVO.setGameId(game.getGameId());
        gameDetailVO.setGameName(game.getGameName());
        gameDetailVO.setGameOriginalPrice(game.getGameOriginalPrice());
        gameDetailVO.setReleaseDate(game.getReleaseDate().atStartOfDay());
        gameDetailVO.setMainImageUrl(game.getMainImageUrl());

        //获取游戏详细信息
        GameProfile gameProfile = gameProfileMapper.selectOne(
                new QueryWrapper<GameProfile>().eq("game_id", gameId));
        if (gameProfile != null) {
            GameProfileVO profileVO = new GameProfileVO();
            profileVO.setGameProfileId(gameProfile.getGameProfileId());
            profileVO.setGameName(gameProfile.getGameName());
            profileVO.setGameDescription(gameProfile.getGameDescription());
            profileVO.setGameDeveloper(gameProfile.getGameDeveloper());
            profileVO.setGameTagName(gameProfile.getGameTagName());
            profileVO.setGameConfig(gameProfile.getGameConfig());
            profileVO.setSeries(gameProfile.getSeries());

            gameDetailVO.setGameProfile(profileVO);
        }
        //3.捆绑包信息
        List<GameBundle> gameBundleList = gameBundleMapper.selectList(new QueryWrapper<GameBundle>().eq("game_id", gameId));
        List<GameBundleVO> bundleVOList = gameBundleList.stream().map(bundle -> {
            GameBundleVO vo = new GameBundleVO();
            vo.setBundleName(bundle.getBundleName());
            vo.setDiscountPolicy(bundle.getDiscountPolicy());
            return vo;
        }).collect(Collectors.toList());
        gameDetailVO.setGameBundles(bundleVOList);

        //4.价格历史
        List<GamePriceHistory> priceHistoryList = gamePriceHistoryMapper.selectList(
                new QueryWrapper<GamePriceHistory>().eq("game_id", gameId)
        );
        List<GamePriceHistoryVO> priceHistoryVOList = priceHistoryList.stream().map(p -> {
            GamePriceHistoryVO vo = new GamePriceHistoryVO();
            vo.setPriceDate(p.getCreatedAt());
            vo.setPrice(p.getCurrentPrice());
            return vo;
        }).collect(Collectors.toList());
        gameDetailVO.setPriceHistory(priceHistoryVOList);

        //5.游戏图片
        List<GameImages> imagesList = gameImagesMapper.selectList(
                new QueryWrapper<GameImages>().eq("game_id", gameId)
        );
        List<String> imageUrls = imagesList.stream().map(GameImages::getImageUrl)
                .collect(Collectors.toList());
        gameDetailVO.setGameImages(imageUrls);

        //6.游戏成就
        List<GameAchievement> achievementList = gameAchievementMapper.selectList(
                new QueryWrapper<GameAchievement>().eq("game_id", gameId)
        );
        List<GameAchievementVO> achievementVOList = achievementList.stream().map(a -> {
            GameAchievementVO vo = new GameAchievementVO();
            vo.setAchievementName(a.getAchievementName());
            vo.setAchievementDescription(a.getAchievementDescription());
            return vo;
        }).collect(Collectors.toList());
        gameDetailVO.setGameAchievements(achievementVOList);

        //7.是否关注（只有传了 userId 才判断）
        if (userId != null) {
            boolean isFollowed = userFollowMapper.exists(
                    new QueryWrapper<UserFollow>().eq("user_id", userId).eq("game_id", gameId)
            );
            gameDetailVO.setUserFollowed(isFollowed);
        } else {
            //未登录用户默认不关注
            gameDetailVO.setUserFollowed(false);
        }

        return gameDetailVO;
    }

//根据游戏类型获取游戏
    @Override
    public Game getGameByType(String type) {
        return null;
    }

    @Override
    public List<Game> listAllGames() {
        return this.list(); // MyBatis-Plus 自带 list 查询全部
    }
}
