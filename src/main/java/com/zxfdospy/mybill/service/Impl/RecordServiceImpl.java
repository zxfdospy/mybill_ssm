package com.zxfdospy.mybill.service.Impl;

import com.zxfdospy.mybill.mapper.CategoryMapper;
import com.zxfdospy.mybill.mapper.RecordMapper;
import com.zxfdospy.mybill.pojo.Category;
import com.zxfdospy.mybill.pojo.Record;
import com.zxfdospy.mybill.pojo.RecordExample;
import com.zxfdospy.mybill.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecordServiceImpl implements RecordService {
    @Autowired
    RecordMapper recordMapper;
    @Autowired
    CategoryMapper categoryMapper;

    @Override
    public void add(Record record) {
        recordMapper.insert(record);
    }

    @Override
    public void delete(int id) {
        recordMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Record record) {
        recordMapper.updateByPrimaryKey(record);
    }

    @Override
    public Record get(int id) {
        return null;
    }

    @Override
    public List<Record> listOrderByDate(int uid) {
        RecordExample example=new RecordExample();
        example.createCriteria().andUidEqualTo(uid);
        example.setOrderByClause("date desc");
        List<Record> rs=recordMapper.selectByExample(example);
        setCategories(rs);
        return rs;
    }

    private void setCategory(Record record){
        int cid=record.getCid();
        Category category=categoryMapper.selectByPrimaryKey(cid);
        record.setCategory(category);
    }

    private void setCategories(List<Record> rs){
        for(Record r:rs){
            setCategory(r);
        }
    }
}
