package com.xworkz.data.contant;

public enum SweetEnum {

    URl("jdbc:mysql://localhost:3306/matrimony_db"),
    USERNAME("root"),
    PASSWORD("0000");

    private String s;

    SweetEnum(String s){
        this.s=s;
    }

    public String getS() {
        return s;
    }
}

