package com.zxfdospy.mybill.service;

import com.zxfdospy.mybill.pojo.User;

public interface UserService {
    void add(User user);
    void delete(int id);
    void update(User user);
    User get(int id);

    boolean isExist(String name);

    User get(String name,String password);
}
