package com.zxfdospy.mybill.service.Impl;

import com.zxfdospy.mybill.mapper.CategoryMapper;
import com.zxfdospy.mybill.pojo.Category;
import com.zxfdospy.mybill.pojo.CategoryExample;
import com.zxfdospy.mybill.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    CategoryMapper categoryMapper;


    @Override
    public void add(Category category) {
        categoryMapper.insert(category);
    }

    @Override
    public void delete(int id) {
        categoryMapper.deleteByPrimaryKey(id);

    }

    @Override
    public void update(Category category) {
        categoryMapper.updateByPrimaryKey(category);
    }

    @Override
    public Category get(int id) {
        return null;
    }

    @Override
    public List<Category> listByUid(int uid) {
        CategoryExample example=new CategoryExample();
        example.createCriteria().andUidEqualTo(uid);
        List<Category> result=categoryMapper.selectByExample(example);
        return result;
    }

    @Override
    public boolean isExist(int uid,String name) {
        CategoryExample example=new CategoryExample();
        example.createCriteria().andUidEqualTo(uid).andNameEqualTo(name);
        List<Category> result=categoryMapper.selectByExample(example);
        if(result.isEmpty())
            return false;
        return true;
    }

    @Override
    public List<Category> listSearch(int uid,boolean all,List<Integer> cs) {
        CategoryExample example=new CategoryExample();
        if(all)
            example.createCriteria().andUidEqualTo(uid);
        else
            example.createCriteria().andUidEqualTo(uid).andIdIn(cs);
        List<Category> categories=categoryMapper.selectByExample(example);
        return categories;
    }

    @Override
    public int getTotal(int uid) {
        CategoryExample example=new CategoryExample();
        example.createCriteria().andUidEqualTo(uid);
        List<Category> cs=categoryMapper.selectByExample(example);
        return cs.size();
    }
}
