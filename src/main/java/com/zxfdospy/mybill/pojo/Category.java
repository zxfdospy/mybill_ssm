package com.zxfdospy.mybill.pojo;

public class Category {
    private Integer id;

    private String name;

    private Integer uid;

    private Record record;

    private Long categorySpend;
    private int recordCount;

    public Long getCategorySpend() {
        return categorySpend;
    }

    public void setCategorySpend(Long categorySpend) {
        this.categorySpend = categorySpend;
    }

    public int getRecordCount() {
        return recordCount;
    }

    public void setRecordCount(int recordCount) {
        this.recordCount = recordCount;
    }

    public Record getRecord() {
        return record;
    }

    public void setRecord(Record record) {
        this.record = record;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }
}