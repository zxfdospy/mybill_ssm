package com.zxfdospy.mybill.service.Impl;

import com.zxfdospy.mybill.mapper.CategoryMapper;
import com.zxfdospy.mybill.pojo.Category;
import com.zxfdospy.mybill.pojo.CategoryExample;
import com.zxfdospy.mybill.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
