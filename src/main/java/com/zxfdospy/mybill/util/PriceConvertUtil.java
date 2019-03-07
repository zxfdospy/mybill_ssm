package com.zxfdospy.mybill.util;

import org.springframework.core.convert.converter.Converter;

//需要实现Converter接口，这里是将String类型转换成Date类型
public class PriceConvertUtil implements Converter<String,Long> {

    @Override
    public Long convert(String price) {
        double dPrice = Double.parseDouble(price);
        dPrice *= 100;
        Long lPrice=(long) dPrice;
        return lPrice;
    }
}

