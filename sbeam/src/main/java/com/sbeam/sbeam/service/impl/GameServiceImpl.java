package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.mapper.GameMapper;
import com.sbeam.sbeam.service.IGameService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author smith
 * @since 2025-10-07
 */
@Service
public class GameServiceImpl extends ServiceImpl<GameMapper, Game> implements IGameService {

}
