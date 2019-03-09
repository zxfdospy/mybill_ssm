package com.zxfdospy.mybill.service;

import com.zxfdospy.mybill.pojo.Record;

import java.util.List;

public interface RecordService {
    void add(Record record);
    void delete(int id);
    void update(Record record);
    Record get(int id);

    List<Record> listOrderByDate(int uid);

    List<Record> listSearch(int uid,boolean all,String start,String end,List<Integer> cs);
}
