package com.vissim.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vissim.pojo.IntermediateConnection;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Mapper
@Component
public interface IntermediateConnectionMapper extends BaseMapper<IntermediateConnection> {
}
