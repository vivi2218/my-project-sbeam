package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Message;
import com.sbeam.sbeam.mapper.MessageMapper;
import com.sbeam.sbeam.service.IMessageService;
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
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements IMessageService {

}
