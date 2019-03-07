package com.zxfdospy.mybill.mapper;

import com.zxfdospy.mybill.pojo.Record;
import com.zxfdospy.mybill.pojo.RecordExample;
import java.util.List;

public interface RecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Record record);

    int insertSelective(Record record);

    List<Record> selectByExample(RecordExample example);

    Record selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Record record);

    int updateByPrimaryKey(Record record);
}