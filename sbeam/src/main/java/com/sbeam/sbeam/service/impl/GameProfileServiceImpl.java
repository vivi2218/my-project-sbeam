package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.GameProfile;
import com.sbeam.sbeam.mapper.GameProfileMapper;
import com.sbeam.sbeam.service.IGameProfileService;
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
public class GameProfileServiceImpl extends ServiceImpl<GameProfileMapper, GameProfile> implements IGameProfileService {

}
